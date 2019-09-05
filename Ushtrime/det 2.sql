--krijojme tabelen
create table SP_GB_BONUSES (
employee_id NUMBER(6) NOT NULL,
bonus NUMBER(8,2) DEFAULT 100
);

declare 
  cursor emp is select employee_id, salary  from hr.employees;--krijova nje kursor qe mban id e punetoreve
  Mregion_id number(6);
  C_ID CHAR(2);
  cnt number(6);
  cust_id number(6);
begin 
  for i in emp 
  loop
    -- gjejme nese employee ka bere blerje 
    SELECT count(*) into cnt FROM oe.orders WHERE  SALES_REP_ID = i.employee_id;
    if cnt != 0 then 
    select DISTINCT SALES_REP_ID into cust_id FROM oe.orders WHERE  SALES_REP_ID = i.employee_id;
     -- gjejme se nga eshte
      SELECT DEPARTMENT_ID INTO MREGION_ID FROM HR.EMPLOYEES WHERE EMPLOYEE_ID = i.employee_id;
      select count(*) into cnt from hr.departments where DEPARTMENT_ID = MREGION_ID;
      if cnt != 0 then 
      SELECT LOCATION_ID INTO MREGION_ID FROM HR.DEPARTMENTS WHERE DEPARTMENT_ID = MREGION_ID;
      SELECT COUNTRY_ID INTO C_ID FROM HR.LOCATIONS WHERE LOCATION_ID = MREGION_ID;
      SELECT REGION_ID INTO MREGION_ID FROM HR.COUNTRIES WHERE COUNTRY_ID = C_ID;
      -- plotesojme rreshtin
      insert into SP_GB_BONUSES(employee_id) values(i.employee_id);
      --pyesim nese eshte europian dhe perditesojme tabelat
      if Mregion_ID = 1 then 
        update SP_GB_BONUSES set BONUS = BONUS + i.salary*0.01 where employee_id = i.employee_id;
      else 
        update SP_GB_BONUSES set BONUS = i.salary*0.01 where employee_id = i.employee_id;
      end if;
      end if;
    end if;
  end loop;
end;
/
