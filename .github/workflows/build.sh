if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行出来る引数は1個です。" 1>&2
  exit 1
fi

SCRIPT_JOB=$1

function archive_without_sign() {
    xcodebuild -workspace NendSDK_Sample.xcworkspace -scheme $1 \
        -configuration Debug -sdk iphoneos clean archive -archivePath ../out_archive_without_sign/ \
        CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED="NO" CODE_SIGN_ENTITLEMENTS="" CODE_SIGNING_ALLOWED="NO"
}

function build_simulator() {
    xcodebuild -workspace NendSDK_Sample.xcworkspace -scheme $1 -configuration Debug -sdk iphonesimulator
}

if [ "archive" = "${SCRIPT_JOB}" ]; then
    mkdir -p out_archive_without_sign
    archive_without_sign "NendSDK_Sample"
    archive_without_sign "NendSDK_Swift_Sample"
    zip -r out_archive_without_sign.zip out_archive_without_sign/
else
    build_simulator "NendSDK_Sample"
    build_simulator "NendSDK_Swift_Sample"
fi
