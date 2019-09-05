create or replace procedure sp_aq_create_table_bonuses is 
begin
  execute immediate '
  create table bonuses as create table bonuses as select employee_id, 100 bonus from HR.employees 
  inner join HR.DEPARTMENTS on HR.employees.department_id=HR.DEPARTMENTS.department_id
  inner JOIN  HR.LOCATIONS on  HR.LOCATIONS.location_id=HR.DEPARTMENTS.location_id
  inner join HR.COUNTRIES on  HR.COUNTRIES.country_id = HR.LOCATIONS.country_id
  inner join HR.REGIONS on  HR.COUNTRIES.region_id= HR.REGIONS.region_id
  where hr.employees.EMPLOYEE_ID in (select customer_id from oe.orders)
  ';
end;


create or replace procedure sp_aq_bonuses is
cursor rajoniEurope is 
select *  from HR.employees 
  inner join HR.DEPARTMENTS on HR.employees.department_id=HR.DEPARTMENTS.department_id
  inner JOIN  HR.LOCATIONS on  HR.LOCATIONS.location_id=HR.DEPARTMENTS.location_id
  inner join HR.COUNTRIES on  HR.COUNTRIES.country_id = HR.LOCATIONS.country_id
  inner join HR.REGIONS on  HR.COUNTRIES.region_id= HR.REGIONS.region_id
  where region_name like 'Europe' and employee_id in (select employee_id from bonuses);
cursor rajoneTjera is 
select * from HR.employees 
 inner join HR.DEPARTMENTS on HR.employees.department_id=HR.DEPARTMENTS.department_id
  inner JOIN  HR.LOCATIONS on  HR.LOCATIONS.location_id=HR.DEPARTMENTS.location_id
  inner join HR.COUNTRIES on  HR.COUNTRIES.country_id = HR.LOCATIONS.country_id
  inner join HR.REGIONS on  HR.COUNTRIES.region_id= HR.REGIONS.region_id
  where region_name like 'Europe' and employee_id not in (select employee_id from bonuses);
begin
  for i in rajoniEurope loop
    update bonuses set bonus = bonus + 0.01 * i.salary where employee_id = i.employee_id;
  end loop;
  for i in rajoneTjera loop
    insert into bonuses values (i.employee_id, i.salary * 0.01);
  end loop;
end;
/
execute sp_aq_create_table_bonuses;
execute sp_aq_bonuses;
select * from bonuses;
select * from user_objects;
