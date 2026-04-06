## ■ DBCA実行方法

本リポジトリでは、移行元と移行先で設定を分離しています。

- source : 移行元（VM1）用
- dest   : 移行先（VM2）用

それぞれのVMに `vm-update\dbca` フォルダをコピーし、  
対象のフォルダ内にあるバッチファイルを実行してください。

### 移行元（VM1）

```text
vm-update\dbca\source\create_cdb_pdb_silent.bat
```

### 移行元先（VM2）
```text
vm-update\dbca\dest\create_cdb_pdb_silent.bat
```
