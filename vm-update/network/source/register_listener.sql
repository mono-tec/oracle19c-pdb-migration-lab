-- listener 起動後に、PDB のサービスが認識されない場合の対処
-- 本スクリプトでは、LOCAL_LISTENER を設定し、サービス情報をリスナーへ再登録します

ALTER SYSTEM SET LOCAL_LISTENER='(ADDRESS=(PROTOCOL=TCP)(HOST=10.0.1.10)(PORT=1521))' SCOPE=BOTH;

-- サービス情報の再登録（listener へ反映）
ALTER SYSTEM REGISTER;

EXIT;