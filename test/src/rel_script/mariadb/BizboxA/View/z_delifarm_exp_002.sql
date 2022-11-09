/* 델리팜 제공 View - GRANT SELECT ON neos.z_delifarm_exp_002 TO interlock@'%' */
DELIMITER $$

ALTER ALGORITHM=UNDEFINED DEFINER=`neos`@`%` SQL SECURITY DEFINER VIEW `z_delifarm_exp_002` AS (
SELECT
  `b`.`doc_no`          AS `문서번호`,
  `b`.`doc_title`       AS `문서제목`,
  `b`.`user_nm`         AS `기안자`,
  `a`.`expend_date`     AS `회계일자`,
  `a`.`expend_req_date` AS `지급요청일`,
  IFNULL((SELECT `t_ex_expend_emp`.`erp_emp_name` FROM `t_ex_expend_emp` WHERE (`t_ex_expend_emp`.`seq` = `a`.`emp_seq`)),'') AS `사용자`,
  IFNULL((SELECT `t_ex_expend_emp`.`erp_dept_name` FROM `t_ex_expend_emp` WHERE (`t_ex_expend_emp`.`seq` = `a`.`emp_seq`)),'') AS `사용부서`,
  (SELECT
     SUM((CASE WHEN (`t_ex_expend_slip`.`drcr_gbn` = 'dr') THEN IFNULL(`t_ex_expend_slip`.`amt`,0) ELSE 0 END))
   FROM `t_ex_expend_slip`
   WHERE (`t_ex_expend_slip`.`expend_seq` = `a`.`expend_seq`)) AS `공급가액`,
  (SELECT
     SUM((CASE WHEN (`t_ex_expend_slip`.`drcr_gbn` = 'vat') THEN IFNULL(`t_ex_expend_slip`.`amt`,0) ELSE 0 END))
   FROM `t_ex_expend_slip`
   WHERE (`t_ex_expend_slip`.`expend_seq` = `a`.`expend_seq`)) AS `부가세액`,
  (SELECT
     SUM((CASE WHEN (`t_ex_expend_slip`.`drcr_gbn` = 'cr') THEN IFNULL(`t_ex_expend_slip`.`amt`,0) ELSE 0 END))
   FROM `t_ex_expend_slip`
   WHERE (`t_ex_expend_slip`.`expend_seq` = `a`.`expend_seq`)) AS `공급대가`,
  `a`.`erp_send_yn`     AS `전송여부`,
  (CASE WHEN (`a`.`erp_send_yn` = 'Y') THEN IFNULL((SELECT `t_co_emp_multi`.`emp_name` FROM `t_co_emp_multi` WHERE ((`t_co_emp_multi`.`emp_seq` = `a`.`erp_send_seq`) AND (`t_co_emp_multi`.`lang_code` = 'kr')) LIMIT 1),'') ELSE '' END) AS `전송자`,
  `a`.`row_id`          AS `자동전표번호`,
  `c`.`form_nm`         AS `결재문서양식명`,
  IFNULL(`summary`.`summary_code`,'') AS `표준적요코드`,
  IFNULL(`summary`.`summary_name`,'') AS `표준적요명`,
  IFNULL(`slip`.`note`,'') AS `적요`,
  IFNULL(`auth`.`auth_code`,'') AS `증빙유형코드`,
  IFNULL(`auth`.`auth_name`,'') AS `증빙유형`,
  IFNULL(`slip`.`auth_date`,'') AS `증빙일자`,
  IFNULL(`auth`.`vat_type_name`,'') AS `증빙구분`,
  IFNULL(`partner`.`partner_code`,'') AS `거래처코드`,
  IFNULL(`partner`.`partner_name`,'') AS `거래처명`,
  IFNULL(`card`.`card_code`,'') AS `법인카드코드`,
  IFNULL(`card`.`card_name`,'') AS `법인카드명`,
  IFNULL(`emp`.`erp_cc_seq`,'') AS `CC코드`,
  IFNULL(`emp`.`erp_cc_name`,'') AS `CC명`
FROM (((((((((`t_ex_expend` `a`
           JOIN `teag_appdoc` `b`
             ON ((`a`.`doc_seq` = `b`.`doc_id`)))
          JOIN `teag_form` `c`
            ON ((`b`.`form_id` = `c`.`form_id`)))
         JOIN `t_ex_expend_list` `list`
           ON ((`a`.`expend_seq` = `list`.`expend_seq`)))
        LEFT JOIN `t_ex_expend_slip` `slip`
          ON (((`a`.`expend_seq` = `slip`.`expend_seq`)
               AND (`list`.`list_seq` = `slip`.`list_seq`))))
       LEFT JOIN `t_ex_expend_summary` `summary`
         ON ((`slip`.`summary_seq` = `summary`.`seq`)))
      LEFT JOIN `t_ex_expend_auth` `auth`
        ON ((`slip`.`auth_seq` = `auth`.`seq`)))
     LEFT JOIN `t_ex_expend_partner` `partner`
       ON ((`slip`.`partner_seq` = `partner`.`seq`)))
    LEFT JOIN `t_ex_expend_card` `card`
      ON ((`slip`.`card_seq` = `card`.`seq`)))
   LEFT JOIN `t_ex_expend_emp` `emp`
     ON ((`slip`.`emp_seq` = `emp`.`seq`)))
WHERE ((`b`.`doc_sts` = '90')
       AND (`b`.`use_yn` = '1')))$$

DELIMITER ;