if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行出来る引数は1個です。" 1>&2
  exit 1
fi

VERSION=$1
API_RELEASES_LIST="https://api.github.com/repos/fan-ADN/nendSDK-iOS/releases"
UPLOAD_URL=''

function parseUploadUrlFromResponse() {
    IFS=$'\n'
    for line in $RESPONSE_API_RELEASES_LIST
    do
        if [ "`echo $line | grep "upload_url"`" ]; then
            UPLOAD_URL=`echo ${line//\"upload_url\":\ /}`
            UPLOAD_URL=`echo ${UPLOAD_URL//\{?name,label\}/?name=out_archive_without_sign.zip}`
            UPLOAD_URL=`echo ${UPLOAD_URL//\ /}`
            UPLOAD_URL=`echo ${UPLOAD_URL//,/}`
            UPLOAD_URL=`echo ${UPLOAD_URL//\"/}`
        elif [[ "`echo $line | grep "draft"`" ]]; then
            if [ "`echo $line | grep true`" ]; then
                break
            else
                UPLOAD_URL=''
            fi
        fi
    done
}

curl -H "Authorization: token $TOKEN" $API_RELEASES_LIST > upload_release_response.json
RESPONSE_API_RELEASES_LIST=`cat upload_release_response.json`

CURRENT_DRAFT=`grep "\"tag_name\": \"$VERSION\"" upload_release_response.json`
echo $CURRENT_DRAFT

if [ -n "${CURRENT_DRAFT}" ]; then
    echo "Draft is created"
    parseUploadUrlFromResponse
else
    echo "Create new draft"
    JSON_CREATE_DRAFT="
    {
        \"tag_name\": \"$VERSION\",
        \"target_commitish\": \"master\",
        \"name\": \"$VERSION\",
        \"body\": \"Description of the release\",
        \"draft\": true,
        \"prerelease\": false
    }
    "
    curl -X POST -H "Authorization: token $TOKEN" \
        -H "Content-Type: application/json" -d "$JSON_CREATE_DRAFT" $API_RELEASES_LIST \
        > upload_release_response.json
    RESPONSE_API_RELEASES_LIST=`cat upload_release_response.json`
    echo $RESPONSE_API_RELEASES_LIST
    parseUploadUrlFromResponse
fi


curl -X POST -H "Authorization: token $TOKEN" \
    -H "Content-Type: application/zip" --data-binary @out_archive_without_sign.zip $UPLOAD_URL
