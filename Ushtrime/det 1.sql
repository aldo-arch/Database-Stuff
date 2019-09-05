CREATE TABLE sp_fa_bonuses (employee_id NUMBER, bonus NUMBER DEFAULT 100);
INSERT INTO sp_fa_bonuses(employee_id)
(SELECT e.employee_id FROM employees e, orders o
WHERE e.employee_id = o.sales_rep_id
GROUP BY e.employee_id);
SELECT * FROM sp_fa_bonuses;
MERGE INTO sp_fa_bonuses D
  USING (SELECT employee_id, salary, department_id FROM employees
         WHERE department_id = 80) S
  ON (D.employee_id = S.employee_id)
  WHEN MATCHED THEN UPDATE SET D.bonus = D.bonus + S.salary*.01
  WHEN NOT MATCHED THEN INSERT (D.employee_id, D.bonus)
    VALUES (S.employee_id, S.salary*0.1);