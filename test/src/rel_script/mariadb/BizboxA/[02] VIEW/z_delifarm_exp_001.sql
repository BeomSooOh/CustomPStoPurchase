/* 델리팜 제공 View - GRANT SELECT ON neos.z_delifarm_exp_001 TO interlock@'%' */
DELIMITER $$

ALTER ALGORITHM=UNDEFINED DEFINER=`neos`@`%` SQL SECURITY DEFINER VIEW `z_delifarm_exp_001` AS (
SELECT
  `b`.`doc_no`          AS `문서번호`,
  `b`.`doc_title`       AS `문서제목`,
  `b`.`user_nm`         AS `기안자`,
  `a`.`expend_date`     AS `회계일자`,
  `a`.`expend_req_date` AS `지급요청일`,
  IFNULL((SELECT `t_ex_expend_emp`.`erp_emp_name` FROM `t_ex_expend_emp` WHERE (`t_ex_expend_emp`.`seq` = `a`.`emp_seq`)),'') AS `사용자`,
  IFNULL((SELECT `t_ex_expend_emp`.`erp_dept_name` FROM `t_ex_expend_emp` WHERE (`t_ex_expend_emp`.`seq` = `a`.`emp_seq`)),'') AS `사용부서`,
  (SELECT SUM((CASE WHEN (`t_ex_expend_slip`.`drcr_gbn` = 'dr') THEN IFNULL(`t_ex_expend_slip`.`amt`,0) ELSE 0 END)) FROM `t_ex_expend_slip` WHERE (`t_ex_expend_slip`.`expend_seq` = `a`.`expend_seq`)) AS `공급가액`,
  (SELECT SUM((CASE WHEN (`t_ex_expend_slip`.`drcr_gbn` = 'vat') THEN IFNULL(`t_ex_expend_slip`.`amt`,0) ELSE 0 END)) FROM `t_ex_expend_slip` WHERE (`t_ex_expend_slip`.`expend_seq` = `a`.`expend_seq`)) AS `부가세액`,
  (SELECT SUM((CASE WHEN (`t_ex_expend_slip`.`drcr_gbn` = 'cr') THEN IFNULL(`t_ex_expend_slip`.`amt`,0) ELSE 0 END)) FROM `t_ex_expend_slip` WHERE (`t_ex_expend_slip`.`expend_seq` = `a`.`expend_seq`)) AS `공급대가`,
  `a`.`erp_send_yn`     AS `전송여부`,
  CASE WHEN `a`.`erp_send_yn` = 'Y' THEN IFNULL((SELECT `t_co_emp_multi`.`emp_name` FROM `t_co_emp_multi` WHERE ((`t_co_emp_multi`.`emp_seq` = `a`.`erp_send_seq`) AND (`t_co_emp_multi`.`lang_code` = 'kr')) LIMIT 1),'') ELSE '' END AS `전송자`,
  `a`.`row_id`          AS `자동전표번호`
FROM (`t_ex_expend` `a`
   JOIN `teag_appdoc` `b`
     ON ((`a`.`doc_seq` = `b`.`doc_id`)))
WHERE ((`b`.`doc_sts` = '90')
       AND (`b`.`use_yn` = '1')))$$

DELIMITER ;