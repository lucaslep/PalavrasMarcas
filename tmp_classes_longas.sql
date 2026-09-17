SET LIST ON;
SELECT FIRST 30 cod_marca, classe_internacional,
       substring(classe_internacional from 2 for 20) as RESTO
FROM processos_ma
WHERE substring(classe_internacional from 1 for 1) = ' '
  AND substring(classe_internacional from 4 for 1) <> ' '
ORDER BY cod_marca;
COMMIT;
