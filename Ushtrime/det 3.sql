create table notat(Id integer, Col1 integer, Col2 integer, Col3 integer, Col4 integer, Col5 integer, Col6 integer, Col7 integer);
insert into notat(Id, Col1, Col2,  Col3, Col4, Col5, Col6, Col7) values(1, 6, 3, 8, 4, 7, 8, 4);
insert into notat(Id, Col1, Col2,  Col3, Col4, Col5, Col6, Col7) values(2, 5, 7, 9, 2, 1, 7, 8);
insert into notat(Id, Col1, Col2,  Col3, Col4, Col5, Col6, Col7) values(3, 2, 7, 4, 8, 1, 5, 9);
insert into notat(Id, Col1, Col2,  Col3, Col4, Col5, Col6, Col7) values(4, 8, 4, 7, 9, 4, 1, 4);
insert into notat(Id, Col1, Col2,  Col3, Col4, Col5, Col6, Col7) values(5, 7, 5, 2, 5, 2, 6, 4);

create or replace procedure sp1_aq_marks as
  v_max_cols integer;
  v_max_id integer;
  v_min_id integer;
  v_id_test integer;
  v_val1 integer;
  v_val2 integer;
  plsql_block VARCHAR2(500);
begin
  select count(COLUMN_NAME) into v_max_cols 
  from user_tab_cols 
  where TABLE_NAME = 'NOTAT' 
  AND COLUMN_NAME LIKE '%COL%';
  
  select max(id), min(id) into v_max_id, v_min_id
  from NOTAT;
  
  for i in v_min_id..v_max_id loop
    select count(*) into v_id_test 
    from notat
    where id = i;
    continue when v_id_test = 0;
    for j in 1..v_max_cols-1 loop
      for k in 1..v_max_cols-j loop
        plsql_block := 'select COL' || k  || ' from NOTAT where id = ' || i;
        EXECUTE IMMEDIATE plsql_block into v_val1;
        plsql_block := 'select COL' || (k+1)  || ' from NOTAT where id = ' || i;      
        EXECUTE IMMEDIATE plsql_block into v_val2;
        if MOD(i, 2) = 0 then 
          --zbrites
          if v_val1 < v_val2 then
            plsql_block := 'update NOTAT set COL' || k || ' = ' || v_val2 || ' where id = ' || i ;
            EXECUTE IMMEDIATE plsql_block;
            plsql_block := 'update NOTAT set COL' || (k+1) || ' = ' || v_val1 || ' where id = ' || i;
            EXECUTE IMMEDIATE plsql_block;
          end if;
        else
          --rrites
          if v_val1 > v_val2 then
            plsql_block := 'update NOTAT set COL' || k || ' = ' || v_val2 || ' where id = ' || i ;
            EXECUTE IMMEDIATE plsql_block;
            plsql_block := 'update NOTAT set COL' || (k+1) || ' = ' || v_val1 || ' where id = ' || i;
            EXECUTE IMMEDIATE plsql_block;
          end if; 
        end if;
        DBMS_OUTPUT.PUT_LINE('COL' || k || ' --> Col' || (k+1));
      end loop;
    end loop;
  end loop;
  DBMS_OUTPUT.PUT_LINE('Program finished!');
end;
