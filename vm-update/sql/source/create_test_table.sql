CREATE TABLE test_table (
  id NUMBER,
  name VARCHAR2(50)
);

INSERT INTO test_table VALUES (1, 'TEST1');
INSERT INTO test_table VALUES (2, 'TEST2');
COMMIT;

EXIT;
