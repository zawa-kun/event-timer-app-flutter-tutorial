## リポジトリの説明
このリポジトリはFlutterアプリ用のプロジェクトです。

pubspec.lockはリモートリポジトリに含めています。

**理由**

`pubspec.lock`をバージョン管理することで、全開発メンバーの依存パッケージを統一し、

バグの再現性を高めたり、動作環境の違いによるトラブルを防止しています。

---


## 手順
1. リポジトリのクローン
2. 以下のコマンドを順に実行
```
flutter pub get
flutter run
```

--- 

## 注意事項
- **pubspec.yaml**や**pubspec.lock**は必ずコミット。
- **pubspec.lockは絶対に削除しない。**(理由：依存バージョンがばらばらになり、再現性が失われるため。)
- 依存パッケージを追加更新時は`pubspec.lock`も一緒にコミット
- 他メンバーが`pubspec.yaml`や`pubspec.lock`を更新したときは必ず、`flutter pub get`を実行
