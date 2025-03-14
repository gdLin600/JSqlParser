---
-- #%L
-- JSQLParser library
-- %%
-- Copyright (C) 2004 - 2019 JSQLParser
-- %%
-- Dual licensed under GNU LGPL 2.1 or Apache License 2.0
-- #L%
---
with
  reports_to_101 (eid, emp_last, mgr_id, reportlevel, mgr_list) 
  as
  (
     (select employee_id, last_name, manager_id, 0 reportlevel
     , cast(manager_id as varchar2(2000))
     from employees
     where employee_id = 101)
  union all
     (select e.employee_id, e.last_name, e.manager_id, reportlevel+1
     , cast(mgr_list || ',' || manager_id as varchar2(2000))
     from reports_to_101 r, employees e
     where r.eid = e.manager_id)
  )
select eid, emp_last, mgr_id, reportlevel, mgr_list
from reports_to_101
order by reportlevel, eid


--@SUCCESSFULLY_PARSED_AND_DEPARSED first on Aug 3, 2021, 7:20:08 AM
--@FAILURE: Encountered unexpected token: "union" "UNION" recorded first on Feb 13, 2025, 10:16:06 AM