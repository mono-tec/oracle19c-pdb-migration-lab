# oracle19c-pdb-migration-lab

Oracle Database 19c における
PDBクローンによる移行検証環境を構築するためのリポジトリです。

Terraformを使用してOCI上に検証環境を自動構築し、
Oracle 19cのPDB移行を検証するためのサンプルファイルを提供します。

---

## 🚀 このリポジトリでできること

- OCI上にOracle 19c環境を構築
- DBリンクを使用したPDBクローン
- データ移行の検証（バッチ実行で再現可能）

---

## ■ 対象読者

* Oracle 19c の移行検証を行いたい方
* PDBクローンによる移行手順を試したい方
* OCI + Terraform による検証環境構築を学びたい方

---

## ■ 概要

本リポジトリでは以下を再現できます：

* OCI上にTerraformでインフラ構築
* Oracle 19c サイレントインストール
* CDB/PDB構成の作成
* DBリンクを用いたPDBクローン

---

## ■ 構成

### ■ Terraform（OCI環境構築）

```text
terraform/
  base/ : 基本構成（VM1 / VM2）
```

* Terraformはローカル環境で実行します
* `terraform/base` ディレクトリで実行してください

```powershell
cd terraform/base
terraform init
terraform apply
```

---

### ■ VM作業用スクリプト

```text
vm-update/
  oracle-install/ : Oracle 19c サイレントインストール
  dbca/           : DB作成
  network/        : ネットワーク設定
  sql/            : クローンSQL
```

* `vm-update` フォルダはVMへコピーして使用します（デスクトップ等）

---

## ■ 使い方（概要）

1. TerraformでOCI環境を構築
2. VMへ `vm-update` フォルダをコピー
3. Oracleサイレントインストール実行
4. DBCAでCDB/PDB作成
5. ネットワーク設定（listener / tns）
6. DBリンク作成・PDBクローン

👉 詳細手順はZenn記事を参照してください

---

## ■ Zenn記事

本リポジトリの詳細手順は以下の記事で解説しています：

* https://zenn.dev/mono_tec/articles/oracle19c-pdb-migration-01-overview
* https://zenn.dev/mono_tec/articles/oracle19c-pdb-migration-02-terraform
* https://zenn.dev/mono_tec/articles/oracle19c-pdb-migration-03-oracleinstall
* https://zenn.dev/mono_tec/articles/oracle19c-pdb-migration-04-dbca
* https://zenn.dev/mono_tec/articles/oracle19c-pdb-migration-05-network
* https://zenn.dev/mono_tec/articles/oracle19c-pdb-migration-06-db-link-clone
* https://zenn.dev/mono_tec/articles/oracle19c-pdb-migration-07-verify

---

## ■ 設定ファイルについて

Terraform実行前に、以下のファイルを作成してください。

```text
terraform.tfvars
```

以下のサンプルをコピーして編集します。

```text
terraform.tfvars.example
```

※ APIキーなどの機密情報はGitHubに含めないようにしてください

---

## ■ OCI APIキーの作成

TerraformからOCIを操作するためには、APIキーの作成が必要です。

本リポジトリでは、Windows環境向けに
RSA鍵を作成するPowerShellスクリプトを用意しています。

※ 作成した秘密鍵（.pem）は絶対に公開しないでください

### ■ 事前準備

OpenSSLが必要です。

```powershell
winget install -e --id ShiningLight.OpenSSL
```

---

## ■ prefixについて

Terraformで作成するリソースには prefix が付与されます。

```hcl
prefix = "oracle-replace-lab"
```

例：

* VCN
* Subnet
* VM

※ 複数回実行する場合は prefix を変更すると識別しやすくなります

---

## ■ コンパートメントの設定

OCIコンソールで作成したコンパートメントのOCIDを指定します。

```hcl
compartment_ocid = "ocid1.compartment.oc1...."
```

詳細は以下を参照してください：
https://zenn.dev/mono_tec/articles/oracle19c-pdb-migration-01-overview

---

## ■ Image OCIDについて

OCIのイメージはリージョンごとに異なります。

以下の公式ページから確認してください：
https://docs.oracle.com/en-us/iaas/images/index.htm

```hcl
image_ocid = "ocid1.image.oc1.ap-xxxxx-1.xxxxx"
```

* region と同一リージョンのOCIDを指定してください
* 利用可能なShapeはイメージに依存します

---

## ■ ライセンス

本リポジトリは MIT License のもとで公開されています。
