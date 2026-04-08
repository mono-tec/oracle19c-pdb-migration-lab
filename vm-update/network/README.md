# Oracle 19c network files

このフォルダは、GitHub から取得した `vm-update\network` フォルダを
そのまま VM 上へコピーして使用する想定です。

## フォルダ構成

- source : 移行元（VM1）用
- dest   : 移行先（VM2）用

## 同梱ファイル

- listener.ora
- tnsnames.ora
- configure_network.bat

## 使い方

### 移行元（VM1）
- `source\configure_network.bat` を管理者権限で実行

### 移行先（VM2）
- `dest\configure_network.bat` を管理者権限で実行

## バッチで行う内容

1. `listener.ora` / `tnsnames.ora` を `C:\app\oracle\product\19.0.0\dbhome_1\network\admin` に配置
2. Windows Firewall で 1521/TCP を開放
3. listener を起動
4. listener の状態確認ログを出力

## 注意事項

- `tnsnames.ora` の HOST は環境に合わせて修正してください
- `SERVICE_NAME` は必要に応じて実機に合わせて修正してください
