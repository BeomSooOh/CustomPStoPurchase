/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 11. 22. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 지출결의 쿼리 추가 */

/* 외부연동 프로세스 저장 - 추후 호출URL 변경 필수*/
INSERT IGNORE INTO `teag_out_process` (`out_process_id`, `process_nm`, `contents_tp`, `contents_pos`, `form_api`, `send_api`, `cancel_api`, `end_api`, `reject_api`, `delete_api`, `app_api`, `created_by`, `created_dt`, `modify_by`, `modify_dt`, `co_id`, `group_id`, `apply_api`, `detail_code_div`) VALUES( 'EXPENDA', '지출결의서(Bizbox)', '1', '1', '', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', 'SYSTEM', NOW(), 'SYSTEM', NOW(), '0', 'varGroupId', '/exp/ExpendPop.do', 'ea0060' );
INSERT IGNORE INTO `teag_out_process` (`out_process_id`, `process_nm`, `contents_tp`, `contents_pos`, `form_api`, `send_api`, `cancel_api`, `end_api`, `reject_api`, `delete_api`, `app_api`, `created_by`, `created_dt`, `modify_by`, `modify_dt`, `co_id`, `group_id`, `apply_api`, `detail_code_div`) VALUES( 'EXPENDI', '지출결의서(iCUBE)', '1', '1', '', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', 'SYSTEM', NOW(), 'SYSTEM', NOW(), '0', 'varGroupId', '/exp/ExpendPop.do', 'ea0060' );
INSERT IGNORE INTO `teag_out_process` (`out_process_id`, `process_nm`, `contents_tp`, `contents_pos`, `form_api`, `send_api`, `cancel_api`, `end_api`, `reject_api`, `delete_api`, `app_api`, `created_by`, `created_dt`, `modify_by`, `modify_dt`, `co_id`, `group_id`, `apply_api`, `detail_code_div`) VALUES( 'EXPENDU', '지출결의서(ERPiU)', '1', '1', '', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', 'SYSTEM', NOW(), 'SYSTEM', NOW(), '0', 'varGroupId', '/exp/ExpendPop.do', 'ea0060' );

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 12. 26. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 30. */
/* 2016. 12. 30. - 신재호 */
/* 2016. 12. 30. - 신재호 - 지출결의 쿼리 추가(미사용 쿼리 삭제 및 누락 쿼리 추가) */
-- t_ex_option 미사용 쿼리 삭제
DELETE FROM t_ex_option WHERE option_code = '000000' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000001' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000002' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000003' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000004' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000005' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000200' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000202' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000300' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000301' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000302' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000303' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000304' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000305' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '000306' AND option_gbn = '00';
DELETE FROM t_ex_option WHERE option_code = '003201' AND option_gbn = '003';
DELETE FROM t_ex_option WHERE option_code = '003201' AND option_gbn = '003';
DELETE FROM t_ex_option WHERE option_code = '003201' AND option_gbn = '003';
DELETE FROM t_ex_option WHERE option_code = '003202' AND option_gbn = '003';
DELETE FROM t_ex_option WHERE option_code = '003202' AND option_gbn = '003';
DELETE FROM t_ex_option WHERE option_code = '010000' AND option_gbn = '01';
DELETE FROM t_ex_option WHERE option_code = '010001' AND option_gbn = '01';
DELETE FROM t_ex_option WHERE option_code = '010002' AND option_gbn = '01';
DELETE FROM t_ex_option WHERE option_code = '010003' AND option_gbn = '01';
DELETE FROM t_ex_option WHERE option_code = '020000' AND option_gbn = '02';
DELETE FROM t_ex_option WHERE option_code = '020001' AND option_gbn = '02';
DELETE FROM t_ex_option WHERE option_code = '020002' AND option_gbn = '02';
DELETE FROM t_ex_option WHERE option_code = '020003' AND option_gbn = '02';
DELETE FROM t_ex_option WHERE option_code = '020004' AND option_gbn = '02';
DELETE FROM t_ex_option WHERE option_code = '020100' AND option_gbn = '02';
DELETE FROM t_ex_option WHERE option_code = '020200' AND option_gbn = '02';
DELETE FROM t_ex_option WHERE option_code = '020300' AND option_gbn = '02';
DELETE FROM t_ex_option WHERE option_code = '020301' AND option_gbn = '02';

-- t_ex_option_multi 미사용 항목 삭제
DELETE FROM t_ex_option_multi WHERE option_code = '000000' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000001' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000002' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000003' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000004' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000005' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000200' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000202' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000300' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000301' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000302' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000303' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000304' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000305' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '000306' AND option_gbn = '00';
DELETE FROM t_ex_option_multi WHERE option_code = '003201' AND option_gbn = '003';
DELETE FROM t_ex_option_multi WHERE option_code = '003201' AND option_gbn = '003';
DELETE FROM t_ex_option_multi WHERE option_code = '003201' AND option_gbn = '003';
DELETE FROM t_ex_option_multi WHERE option_code = '003202' AND option_gbn = '003';
DELETE FROM t_ex_option_multi WHERE option_code = '003202' AND option_gbn = '003';
DELETE FROM t_ex_option_multi WHERE option_code = '010000' AND option_gbn = '01';
DELETE FROM t_ex_option_multi WHERE option_code = '010001' AND option_gbn = '01';
DELETE FROM t_ex_option_multi WHERE option_code = '010002' AND option_gbn = '01';
DELETE FROM t_ex_option_multi WHERE option_code = '010003' AND option_gbn = '01';
DELETE FROM t_ex_option_multi WHERE option_code = '020000' AND option_gbn = '02';
DELETE FROM t_ex_option_multi WHERE option_code = '020001' AND option_gbn = '02';
DELETE FROM t_ex_option_multi WHERE option_code = '020002' AND option_gbn = '02';
DELETE FROM t_ex_option_multi WHERE option_code = '020003' AND option_gbn = '02';
DELETE FROM t_ex_option_multi WHERE option_code = '020004' AND option_gbn = '02';
DELETE FROM t_ex_option_multi WHERE option_code = '020100' AND option_gbn = '02';
DELETE FROM t_ex_option_multi WHERE option_code = '020200' AND option_gbn = '02';
DELETE FROM t_ex_option_multi WHERE option_code = '020300' AND option_gbn = '02';
DELETE FROM t_ex_option_multi WHERE option_code = '020301' AND option_gbn = '02';

-- 옵션 상세 미사용 코드 삭제
DELETE FROM t_co_code_detail_multi WHERE CODE = 'ex00007' AND detail_code = '0';
DELETE FROM t_co_code_detail_multi WHERE CODE = 'ex00007' AND detail_code = '3';
DELETE FROM t_co_code_detail WHERE CODE = 'ex00007' AND detail_code = '0';
DELETE FROM t_co_code_detail WHERE CODE = 'ex00007' AND detail_code = '3';

-- 옵션 상세 사용 코드 누락 추가
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`) VALUES ( 'Y', 'ex00004', 'kr', '예', '예', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

-- 미구현 옵션 항목 미사용 처리
UPDATE t_ex_option SET use_yn = 'N' WHERE option_code = '003303';
UPDATE t_ex_option SET use_yn = 'N' WHERE option_code = '003304';
UPDATE t_ex_option SET use_yn = 'N' WHERE option_code = '003305';
UPDATE t_ex_option SET use_yn = 'N' WHERE option_code = '003306';
UPDATE t_ex_option SET use_yn = 'N' WHERE option_code = '003307';

-- 첨부파일 그룹 패스 설정(group_seq는 입력)
INSERT IGNORE INTO `t_co_group_path` (`group_seq`, `path_seq`, `path_name`, `os_type`, `absol_path`, `avail_capac`, `limit_file_count`, `create_seq`, `create_date`, `modify_seq`, `modify_date`) VALUES ( 'varGroupId', '1400', '지출결의', 'linux', '/home/upload/expend', '1', '20', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `t_co_group_path` (`group_seq`, `path_seq`, `path_name`, `os_type`, `absol_path`, `avail_capac`, `limit_file_count`, `create_seq`, `create_date`, `modify_seq`, `modify_date`) VALUES ( 'varGroupId', '1400', '지출결의', 'windows', 'd:/upload/expend', '1', '20', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 2017. 01. 03. */
/* 2017. 01. 03. - 신재호 */
/* 2017. 01. 03. - 신재호 - 미사용 옵션 제거 */
DELETE FROM t_ex_option WHERE option_code = '003001' AND option_gbn = '003';
DELETE FROM t_ex_option_multi WHERE option_code = '003001' AND option_gbn = '003';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 04. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 05. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 01. 12. */
/* 2017. 01. 12. - 김상겸 */
/* 2017. 01. 12. - 김상겸 - 지출결의 쿼리 추가 */

/* 지출결의 Bizbox Alpha API url 변경 */
UPDATE  `teag_out_process`
SET     `send_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `cancel_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `end_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `reject_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `delete_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `app_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
WHERE   `out_process_id` = 'EXPENDA'
AND     `detail_code_div` = 'ea0060';

/* 지출결의 iCUBE API url 변경 */
UPDATE  `teag_out_process`
SET     `send_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `cancel_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `end_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `reject_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `delete_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `app_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
WHERE   `out_process_id` = 'EXPENDI'
AND     `detail_code_div` = 'ea0060';

/* 지출결의 ERPiU API url 변경 */
UPDATE  `teag_out_process`
SET     `send_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `cancel_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `end_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `reject_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `delete_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
        , `app_api` = 'http://varGroupwareDomain:varGroupwarePort/exp/ApprovalProcess.do'
WHERE   `out_process_id` = 'EXPENDU'
AND     `detail_code_div` = 'ea0060';

/* 지출결의 환경설정 설정 명칭 수정 */
UPDATE `neos`.`t_co_code_detail_multi` SET `detail_name` = '카드번호 가운데 8자리 * 표시' , `note` = '카드번호 가운데 8자리 * 표시' WHERE `detail_code` = '2' AND `code` = 'ex00007' AND `lang_code` = 'kr';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 16. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 01. 17. */
/* 2017. 01. 17. - 김상겸 */
/* 2017. 01. 17. - 김상겸 - 지출결의 쿼리 추가 */

/* 관리항목 필수입력여부 기본값 변경 */
UPDATE  t_ex_option
SET     base_value = 'Y'
        , base_name = '사용'
WHERE   option_gbn = '003'
AND     option_code = '003004'
AND     comp_seq = '0'
AND     form_seq = '0';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 17. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 01. 23. */
/* 2017. 01. 23. - 김상겸 */
/* 2017. 01. 23. - 김상겸 - 지출결의 쿼리 추가 */

/* 기초배포된 미사용 지출결의 양식 삭제 */
/* 회계 모듈 변경으로 인해 시스템 오류발생 영향이 확인되어 삭제 진행 */
DELETE
FROM    teag_form
WHERE   form_id = 24 /* 기초양식 배포된 지출결의 양식 아이디 */
AND     IFNULL(form_tp, '') = 'ea0060' /* 사용되지 않는 양식 구분 값 */
AND     IFNULL(use_yn, '0') = '0'; /* 미사용 양식만 삭제 */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 23. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 01. 25. */
/* 2017. 01. 25. - 신재호 */
/* 2017. 01. 25. - 신재호 - 지출결의 기본 배포 쿼리 변경 */
UPDATE  t_ex_option
SET     base_value = '1'
        , base_name = '카드명칭 표시'
WHERE   option_gbn = '003'
AND     option_code = '003002'
AND     comp_seq = '0'
AND     form_seq = '0';

UPDATE  t_co_code_detail_multi
SET		detail_name = '카드명칭 표시'
		, note = '카드명칭 표시'
WHERE 	CODE = 'ex00007' 
AND 	detail_code = 1;

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 25. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 02. 13. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 02. 24. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 03. 16. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 03. 21. */
/* 2017. 03. 21. - 김상겸 */
/* 2017. 03. 21. - 김상겸 - 지출결의(영리) 예산연동 사용여부 옵션 초기화 */
/* 예산연동 사용여부 기본값 미사용 일괄 설정 */
UPDATE  t_ex_option
SET     base_value = 'N'
        , base_name = '미사용'
        , set_value = 'N'
        , set_name = '미사용'
        , common_code = 'ex00028'
        , modify_seq = 'SYSTEM'
        , modify_date = NOW()
WHERE   option_gbn = '003'
AND     option_code IN ('003301')

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 03. 21. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 04. 11. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 05. 16. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 05. 29. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 06. 19. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

UPDATE t_ex_form_code SET CODE = '_subStdAmt_' WHERE CODE = '_sub_std_amt_';
UPDATE t_ex_form_code SET CODE = '_subTaxAmt_' WHERE CODE = '_sub_tax_amt_';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 07. 12. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 07. 18. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 08. 10. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 09. 14. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 09. 29. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 12. 15. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 06. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 13. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 20. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */