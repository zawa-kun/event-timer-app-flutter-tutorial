# Flutterについて学習したこと
## StatefulWidget と StatelessWidget
FlutterのUIはすべて「Widget」で構成されている。

大きく分けて二つのWidgetがある。

1. StatelessWidget(ステートレスウィジェット)
- 特徴
  - **状態を持たない**。一度作成したら変化なし！👈コンストラクタで渡されるデータに基づいてのみUIを描画
  - Reactでいう「関数コンポーネント(Hooks無)」やPropsだけを受け取るシンプルなコンポーネント

- 例
アプリのタイトルや題名が変わることは無いので、状態を持つ必要が無い。
```Dart
class MyApp extends StatelessWidget { // ← ここが StatelessWidget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'おねがい社長 タイマー', // この内容はアプリ起動中に変化しない
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'おねがい社長 イベントタイマー'),
    );
  }
}
```

2. StatefulWidget(ステートフルウィジェット)
- 特徴
  - 状態を持つウィジェット。👈ユーザの操作や外部からのデータ変更に応じて、UIを動的に更新。
  - `statefulWidgets` は自体は不変（Immutable）だが、それに関連付けた`State`オブジェクトで状態管理
  - ReactでいうuseStateを使って状態を管理するコンポーネントに近いイメージ

- 動作原理
  1. `StatefulWidget`は自身の状態を保持する`State`オブジェクトを作成。
  2. `State`オブジェクト内で、変更したいデータ（例：カウンターの数値）を管理。
  3. 状態が変化したとき（例：ボタンがタップされたとき）`setState()`メソッドを呼び出す。
  4. `useState()`が呼ばれたときにFlutterは該当するウィジェット（正確にはそのStateオブジェクト）のbuildメソッドを再実行し、UIを新しい状態に合わせて再描画。

- 例
```Dart
class MyHomePage extends StatefulWidget { // ← ここが StatefulWidget
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Stateオブジェクトを作成
}

class _MyHomePageState extends State<MyHomePage> { // ← これがStateオブジェクト
  int _counter = 0; // ← この_counterが「状態」

  void _incrementCounter() {
    setState(() { // ← 状態が変化したことをFlutterに伝える
      _counter++; // 状態を変更
    });
    // ...
  }

  @override
  Widget build(BuildContext context) { // setState() が呼ばれるとここが再実行される
    // ... _counter の値を使ってUIを描画 ...
  }
}
```