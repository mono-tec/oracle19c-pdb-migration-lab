# oracle19c-pdb-migration-lab

Oracle Database 19c における  
PDBクローンによる移行検証環境を構築するためのリポジトリです。

Terraformを使用してOCI上に検証環境を自動構築し、
Oracle 19cのPDB移行を検証するためのサンプルファイルを配置しています。

## 概要

本リポジトリでは以下を再現できます：

- OCI上にTerraformでインフラ構築
- Oracle 19c サイレントインストール
- CDB/PDB構成の作成
- DBリンクを用いたPDBクローン

## 構成

- terraform/ : OCI環境構築
- oracle-install/ : インストール関連
- dbca/ : DB作成
- network/ : ネットワーク設定
- sql/ : クローンSQL

## 使い方（概要）

1. Terraformで環境構築
2. Oracleインストール
3. DB作成
4. PDBクローン実行

詳細はZenn記事を参照してください。


## 設定ファイルについて

Terraform実行前に、以下のファイルを作成してください。
```text
terraform.tfvars
```

以下のサンプルをコピーして編集します。
```text
terraform.tfvars.example
```

※ APIキーなどの機密情報はGitHubに含めないようにしてください。


## OCI APIキーの作成

TerraformからOCIを操作するためには、APIキーの作成が必要です。

本リポジトリでは、Windows環境向けに  
RSA鍵を作成するPowerShellスクリプトを用意しています。
※ 作成した秘密鍵（.pem）は絶対に公開しないでください

### 事前準備

OpenSSLが必要です。未インストールの場合は、以下でインストールできます。

```powershell
winget install -e --id ShiningLight.OpenSSL
```


## ■ prefixについて

Terraformで作成するリソースには、prefixが付与されます。

```hcl
prefix = "oracle-replace-lab"
```

例えば以下のような名前で作成されます：

- VCN
- Subnet
- VM

※ 複数回実行する場合は、prefixを変更するとリソースの識別がしやすくなります。


## ■ コンパートメントの設定

OCIコンソールで作成したコンパートメントのOCIDを指定します。

### 手順（概要）

1. OCIコンソールにログイン  
2. 「アイデンティティとセキュリティ」→「コンパートメント」を選択  
3. 「コンパートメントの作成」から新規作成  
4. 作成後、詳細画面からOCIDをコピー  

```hcl
compartment_ocid = "ocid1.compartment.oc1...."
```
※ 詳細な手順はZenn記事を参照してください。
https://zenn.dev/mono_tec/articles/oracle19c-pdb-migration-01-overview

---

## ■ Image OCIDについて

OCIのイメージはリージョンごとに異なります。

以下の公式ページから対象リージョンのOCIDを確認してください。

https://docs.oracle.com/en-us/iaas/images/index.htm

例（terraform.tfvars）：

```hcl
image_ocid = "ocid1.image.oc1.ap-xxxxx-1.xxxxx"
```
※ region と同じリージョンのOCIDを指定する必要があります
※ 利用可能なShapeはイメージによって異なるため、OCIコンソールで確認してください

---

## ライセンス

本リポジトリは MIT License のもとで公開されています。