<#
.SYNOPSIS
OCI APIキー用のRSA鍵（秘密鍵・公開鍵）を生成するスクリプト

.DESCRIPTION
このスクリプトは、OCI（Oracle Cloud Infrastructure）で使用するAPIキー用の
RSA鍵ペア（秘密鍵・公開鍵）を生成します。

生成された公開鍵は、OCIコンソールに登録して使用します。

.PREREQUISITES
- OpenSSL がインストールされていること
  例：
    winget install -e --id ShiningLight.OpenSSL

.PARAMETER KeyName
作成する鍵ファイルの名前（拡張子は自動付与）

.PARAMETER BaseDir
鍵を保存するディレクトリ（デフォルト：$HOME\.oci）

.EXAMPLE
.\create-oci-api-key.ps1

.EXAMPLE
.\create-oci-api-key.ps1 -KeyName my_oci_key
#>

param(
    [string]$KeyName = "oci_api_key",
    [string]$BaseDir = "$HOME\.oci"
)

$ErrorActionPreference = "Stop"

function Require-Command {
    param([string]$Name)
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command not found: $Name"
    }
}

# OpenSSL が使用可能か確認
Require-Command "openssl"

# 保存先ディレクトリの展開
$resolvedBaseDir = [Environment]::ExpandEnvironmentVariables($BaseDir)

# ディレクトリが存在しなければ作成
if (-not (Test-Path -LiteralPath $resolvedBaseDir)) {
    New-Item -ItemType Directory -Path $resolvedBaseDir -Force | Out-Null
}

# ファイルパス定義
$privateKeyPath = Join-Path $resolvedBaseDir "$KeyName.pem"
$publicKeyPath  = Join-Path $resolvedBaseDir "${KeyName}_public.pem"

Write-Host "Creating private key..."
& openssl genrsa -out $privateKeyPath 2048
if ($LASTEXITCODE -ne 0) {
    throw "Failed to create private key."
}

Write-Host "Creating public key..."
& openssl rsa -pubout -in $privateKeyPath -out $publicKeyPath
if ($LASTEXITCODE -ne 0) {
    throw "Failed to create public key."
}

Write-Host ""
Write-Host "Done."
Write-Host "Private key: $privateKeyPath"
Write-Host "Public key : $publicKeyPath"
Write-Host ""
Write-Host "Next step:"
Write-Host "1. Open the public key file and copy its contents."
Write-Host "2. Register the public key in OCI Console."