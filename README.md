# event_timer_app

Flutter学習用

# 何をしたか
- 通知機能の実装

# 通知機能の仕組み
**Flutter Local Notification**というパッケージと各スマホのＯＳが持つネイティブな通知システムが連携する事で実現。

### 流れ
1. Flutter(Dartコード)：アプリケーションのロジック（いつ、どのような通知を出すか）を記述。
2. Flutter Local Notifications パッケージ: Flutterと各ＯＳ間の「橋渡し」。Dartで書かれた通知の指示を各ＯＳごとに理解できる命令に変換。
3. プラットフォームチャンネル：Flutterとネイティブコードが通信するための仕組み。👈<u>Flutter Local NotificationsでもDartを各ＯＳが理解できる形に変換とあるが、プラットフォームチャンネルは変換はせず、命令を伝えるチャンネルという事？？？？</u>
4. 各OSのネイティブ通知システム：実際に通知を作成し、デバイスの画面に表示。

### 各コンポーネントの説明
1. Flutter Local Notifications パッケージ
- FlutterLocalNotificationsPlugin: 通知の初期化や表示、スケジューリングなどの操作を行うための中心となるクラスです。

- initialize メソッド: アプリケーション起動時に呼び出され、通知システムが正しく機能するように設定を行います。AndroidとiOSそれぞれに合わせた初期設定（通知アイコン、許可の要求など）を渡します。

- show メソッド: 指定した内容（タイトル、本文、IDなど）で即座に通知を表示します。

2. プラットフォームチャンネル
Dart言語で書かれたアプリケーション層と、ネイティブ層（OS側の言語）との間で通信を行うための仕組み。

<u><b>Flutter Local Notificationsパッケージは、このプラットフォームチャンネルを利用して</b></u>、Dart側で「通知を表示してほしい」というリクエストをネイティブ側に送り、ネイティブ側で実際の通知の処理を実行させている。

### Android通知の仕組み
- AndroidManifest.xml(/android/app/src/main/AndroidManifest.xml)：システムが許可ダイアログを表示。※Android13(API level 33)以降から通知をするにはユーザーから明示的な許可が必要になった。

- 通知チャンネル(Notification Channels)：通知を管理するチャンネル。ここでユーザーは通知音やバイブレーションの設定などを細かくできる。👈今回_showNotification()関数内で'your channel id', 'your channel name'などを設定したのはこれのため。

- 明示的な権限リクエスト：main関数の requestNotificationPermission()メソッドは、Android13以降でユーザに通知許可ダイアログを直接表示するために利用。

### iOS通知の仕組み
- 許可の要求は自動！！！👈Androidとは異なる
- DarwinInitializationSettings：iOS向けの初期設定で、アr－ト、バッジ、サウンドの各許可をユーザに求めるかを指定できる。

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
