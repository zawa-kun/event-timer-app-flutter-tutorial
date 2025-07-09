import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // 通知パッケージ

// アプリ全体で使うためmain関数の外で定義
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// 通知の初期化を待てるようにするためmainは非同期関数
void main() async {
  // Flutterとネイティブコード間の通知が利用可能であることを保証。
  // 通知のプラグインの初期化に必要
  WidgetsFlutterBinding.ensureInitialized();

  // 通知の初期化設定 (AndroidとiOS向け)
  // Androidでは通知アイコンを用意する必要がある
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // デフォルトのアイコン

  // iOSではアラート、バッジ、サウンドの許可をユーザに要求するよう設定
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: true, // アラートの許可を要求
    requestBadgePermission: true, // バッジの許可を要求
    requestSoundPermission: true, // サウンドの許可を要求
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  // 通知プラグインの初期化
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      // 通知をタップしたときの処理（今回はシンプルにログ表示）
      debugPrint('notification payload: ${notificationResponse.payload}');
    },
  );

  // Androidで通知許可を明示的に要求
  // android/app/src/main/AndroidManifest.xmlで記述したが動作しなかったため.
  final bool? result = await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()
    ?.requestNotificationsPermission();
  
  if(result == true) {
    debugPrint('Notification permission granted for Android.');
  } else {
    debugPrint('Notification permission denied or not requested for Android.');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'おねがい社長 タイマー',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'おねがい社長 イベントタイマー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _showNotification(); // ボタンを押したら通知を出す
  }

  // 通知を表示する関数
  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // 通知ID
      'おねがい社長 通知テスト', // 通知タイトル
      'これはテスト通知です！アプリを閉じても届きます！', // 通知本文
      notificationDetails,
      payload: 'item x', // 通知に付加するデータ
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}