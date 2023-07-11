# nendSDK-iOS Sample Project

![ロゴ](https://user-images.githubusercontent.com/9563381/31269103-17daebce-aaba-11e7-9899-742435c4ef20.png)

## Overview
iOS版nendSDKのサンプルプロジェクトになります。  
Objective-CとSwiftでの基本的な実装方法と動作確認が行えます。  
nendSDKの導入方法については [Wiki](https://github.com/fan-ADN/nendSDK-iOS/wiki) をご覧ください。

## Requirement
* **Xcode 14.1**以上
* iOS 11.0以上

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
ターミナルでnendSDK-iOSディレクトリに移動し、下記コマンドを実行します。
```
$ pod install
```

#### 3. ワークスペースプロジェクトをXcodeで開く
nendSDK-iOSディレクトリにある下記のワークスペースプロジェクトをXcodeで開きます。
```
NendSDK_Sample.xcworkspace
```
