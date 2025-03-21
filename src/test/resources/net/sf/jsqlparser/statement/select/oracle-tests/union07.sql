---
-- #%L
-- JSQLParser library
-- %%
-- Copyright (C) 2004 - 2019 JSQLParser
-- %%
-- Dual licensed under GNU LGPL 2.1 or Apache License 2.0
-- #L%
---
select * from (
        select row_.*, rownum rownum_
        from (
                select *
                        from
                        (
                                select results.*,row_number() over ( partition by results.object_id order by results.gmt_modified desc) rn
                                from
                                (
                                        (
                                                select                                        sus.id                id,          sus.gmt_create        gmt_create,
                                                        sus.gmt_modified      gmt_modified,          sus.company_id        company_id,
                                                        sus.object_id         object_id,          sus.object_type       object_type,
                                                        sus.confirm_type      confirm_type,          sus.operator          operator,
                                                        sus.filter_type       filter_type,          sus.member_id         member_id,
                                                        sus.member_fuc_q        member_fuc_q,          sus.risk_type         risk_type     , 'y' is_draft
                                                from                        f_u_c_ sus , a_b_c_draft p                                                              ,
                                                        member m
                                                where 1=1                                               and             p.company_id = m.company_id
                                                        and                     m.login_id=?
                                                        and p.sale_type in(                     ?                       )
                                                        and p.id=sus.object_id
                                        )
                                        union
                                        (
                                                select                                        sus.id                id,          sus.gmt_create        gmt_create,
                                                        sus.gmt_modified      gmt_modified,          sus.company_id        company_id,
                                                        sus.object_id         object_id,          sus.object_type       object_type,
                                                        sus.confirm_type      confirm_type,          sus.operator          operator,
                                                        sus.filter_type       filter_type,          sus.member_id         member_id,
                                                        sus.member_fuc_q        member_fuc_q,          sus.risk_type         risk_type     , 'n' is_draft
                                                from f_u_c_ sus , a_b_c p                                                                   ,member m
                                                where 1=1
                                                        and             p.company_id = m.company_id
                                                        and                     m.login_id=?
                                                        and p.sale_type in(                     ?                       )
                                                        and p.id=sus.object_id
                                        )
                                        ) results
                                )               where rn = 1 order by gmt_modified desc
                        )row_ where rownum <= ?
        )
where rownum_ >= ?

--@SUCCESSFULLY_PARSED_AND_DEPARSED first on Aug 3, 2021, 7:20:08 AM
--@FAILURE: Encountered unexpected token: "union" "UNION" recorded first on Feb 13, 2025, 10:16:06 AM