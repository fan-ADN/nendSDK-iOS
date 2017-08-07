# nendSDK-iOS Sample Project

![ロゴ](https://github.com/fan-ADN/nendSDK-iOS/blob/master/Sample/NendSDK_Sample/Images.xcassets/AppIcon.appiconset/icon-60%403x.png)

## Overview
iOS版nendSDKのサンプルプロジェクトになります。  
Objective-CとSwiftでの基本的な実装方法と動作確認が行えます。  
nendSDKの導入方法については [Wiki](https://github.com/fan-ADN/nendSDK-iOS/wiki) をご覧ください。

## Requirement
* **Xcode8.1**以上
* iOS8以上

## Usage
### CocoaPodsをインストール

＜公式ガイド＞  
http://guides.cocoapods.org/using/getting-started.html

#### 1. CocoaPodsをインストール
```
$ sudo gem install cocoapods
```

#### 2. リポジトリ情報のセットアップ
```
$ pod setup
```

### サンプルプロジェクトを動かす

#### 1. サンプルプロジェクトを入手する
https://github.com/fan-ADN/nendSDK-iOS   
こちらのリンクを開き、リポジトリをクローンまたはzipをダウンロードします。

#### 2. nendSDKをプロジェクトに導入する
ターミナルでSampleディレクトリに移動し、下記コマンドを実行します。
```
$ pod install
```

#### 3. ワークスペースプロジェクトをXcodeで開く
Sampleディレクトリにある下記のワークスペースプロジェクトをXcodeで開きます。
```
NendSDK_Sample.xcworkspace
```
