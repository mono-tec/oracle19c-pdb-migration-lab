# Oracle 19c PDB clone sample files (app_user edition v4.1)

このフォルダは、第6章用のサンプルSQLおよびバッチです。
app_user@PDBCLONE で確認したいケースに対応した版です。

## 追加ポイント

- PDBCLONE を listener に再登録するバッチを追加
- PDBCLONE 用の tnsnames.ora サンプルを追加

## フォルダ構成

- source/
  - create_app_user.sql
  - run_create_app_user.bat
  - create_test_table.sql
  - run_create_test_table.bat
  - create_clone_user.sql
  - run_create_clone_user.bat

- dest/
  - create_dblink.sql
  - run_create_dblink.bat
  - clone_pdb.sql
  - run_clone_pdb.bat
  - register_pdbclone_service.sql
  - run_register_pdbclone_service.bat
  - tnsnames_pdbclone_sample.ora
  - verify_clone.sql
  - run_verify_clone.bat

## 実行順

### VM1（source）
1. source\run_create_app_user.bat
2. source\run_create_test_table.bat
3. source\run_create_clone_user.bat

### VM2（dest）
4. dest\run_create_dblink.bat
5. dest\run_clone_pdb.bat
6. dest\run_register_pdbclone_service.bat
7. tnsnames.ora に PDBCLONE 定義を追加
8. dest\run_verify_clone.bat

## 補足

- すでに app_user / clone_user / pdbsrc_link / PDBCLONE が存在する場合は、事前に削除してください
- サンプルでは Oracle123! を使用しています
- FILE_NAME_CONVERT のパスは環境に応じて修正してください
