/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 지출결의 쿼리 추가 */

/* 외부연동 프로세스 저장 - 추후 호출URL 변경 필수*/
INSERT IGNORE INTO `teag_out_process` (`out_process_id`, `process_nm`, `contents_tp`, `contents_pos`, `form_api`, `send_api`, `cancel_api`, `end_api`, `reject_api`, `delete_api`, `app_api`, `created_by`, `created_dt`, `modify_by`, `modify_dt`, `co_id`, `group_id`, `apply_api`, `detail_code_div`) VALUES( 'EXPENDA', '지출결의서(Bizbox)', '1', '1', '', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', 'SYSTEM', NOW(), 'SYSTEM', NOW(), '0', 'varGroupId', '/exp/ExpendPop.do', 'ea0060' );
INSERT IGNORE INTO `teag_out_process` (`out_process_id`, `process_nm`, `contents_tp`, `contents_pos`, `form_api`, `send_api`, `cancel_api`, `end_api`, `reject_api`, `delete_api`, `app_api`, `created_by`, `created_dt`, `modify_by`, `modify_dt`, `co_id`, `group_id`, `apply_api`, `detail_code_div`) VALUES( 'EXPENDI', '지출결의서(iCUBE)', '1', '1', '', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', 'SYSTEM', NOW(), 'SYSTEM', NOW(), '0', 'varGroupId', '/exp/ExpendPop.do', 'ea0060' );
INSERT IGNORE INTO `teag_out_process` (`out_process_id`, `process_nm`, `contents_tp`, `contents_pos`, `form_api`, `send_api`, `cancel_api`, `end_api`, `reject_api`, `delete_api`, `app_api`, `created_by`, `created_dt`, `modify_by`, `modify_dt`, `co_id`, `group_id`, `apply_api`, `detail_code_div`) VALUES( 'EXPENDU', '지출결의서(ERPiU)', '1', '1', '', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', '/exp/ApprovalProcess.do', 'SYSTEM', NOW(), 'SYSTEM', NOW(), '0', 'varGroupId', '/exp/ExpendPop.do', 'ea0060' );

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

UPDATE t_ex_form_code SET CODE = '_subStdAmt_' WHERE CODE = '_sub_std_amt_';
UPDATE t_ex_form_code SET CODE = '_subTaxAmt_' WHERE CODE = '_sub_tax_amt_';

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - G20 쿼리 추가 */

/* `neos`.`t_seq` - 비영리 결의서 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE `name` = 'abdocuNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuNo', '0', '비영리 결의서 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_NO), '0') FROM G20_ABDOCU_H LIMIT 1 ), '0' ) WHERE NAME = 'abdocuNo';

/* `neos`.`t_seq` - 물품명세서 G20_abdocu_d 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuDNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuDNo', '0', '물품명세서 G20_abdocu_d 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_D_NO), '0') FROM G20_ABDOCU_D LIMIT 1 ), '0' ) WHERE NAME = 'abdocuDNo';

/* `neos`.`t_seq` - 비영리 결의서 예산 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuBNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuBNo', '0', '비영리 결의서 예산 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_B_NO), '0') FROM G20_ABDOCU_B LIMIT 1 ), '0' ) WHERE NAME = 'abdocuBNo';

/* `neos`.`t_seq` - 비영리 결의서 채주 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuTNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuTNo', '0', '비영리 결의서 예산 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_T_NO), '0') FROM G20_ABDOCU_T LIMIT 1 ), '0' ) WHERE NAME = 'abdocuTNo';

/* `neos`.`t_seq` - 여비명세서 G20_abdocu_th 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuTHNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuTHNo', '0', '여비명세서 G20_abdocu_th 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_TH_NO), '0') FROM G20_ABDOCU_TH LIMIT 1 ), '0' ) WHERE NAME = 'abdocuTHNo';

/* `neos`.`t_seq` - 여비명세서 G20_abdocu_td 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuTDNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuTDNo', '0', '여비명세서 G20_abdocu_td 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_TD_NO), '0') FROM G20_ABDOCU_TD LIMIT 1 ), '0' ) WHERE NAME = 'abdocuTDNo';

/* `neos`.`t_seq` - 여비명세서 G20_abdocu_td 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuTD2No';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuTD2No', '0', '여비명세서 G20_abdocu_td2 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_TD2_NO), '0') FROM G20_ABDOCU_TD2 LIMIT 1 ), '0' ) WHERE NAME = 'abdocuTD2No';

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 스마트 자금관리 쿼리 추가 */

/* 시퀀스 */
DELETE FROM `t_seq` WHERE `name` = 'accMoneyAuthSeq';

INSERT INTO t_seq ( `name`, `currval`, `description` )
VALUES ( 'accMoneyAuthSeq', '0', '자금관리 권한 시퀀스' );

UPDATE  `t_seq`
SET     `currval` = (
                SELECT  IFNULL(MAX(REPLACE(auth_code, 'A', '')), '0') AS auth_code
                FROM    t_smart_authcode
                WHERE   auth_code LIKE 'A%'
        )
WHERE   `name` = 'accMoneyAuthSeq';

/* 기본권한 */
DELETE FROM `t_smart_authcode` WHERE auth_code = 'USERREG';

INSERT IGNORE INTO `t_smart_authcode` ( `auth_code`, `comp_seq`, `use_yn`, `order_num`, `etc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( 'USERREG', '1000', 'Y', '1', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

INSERT IGNORE INTO `t_smart_authcode_multi` ( `auth_code`, `auth_code_nm`, `lang_code`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( 'USEREG', '사용자 지정권한', 'kr', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* --------------------------------------------------------------------------------------------- */
/* \rel_script\mariadb\BizboxA\EX\03_ex_mariadb_query.sql */
/* \rel_script\mariadb\BizboxA\G20\03_g20_mariadb_query.sql */
/* \rel_script\mariadb\BizboxA\SMART\03_smart_mariadb_query.sql */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 0.0 */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 20. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 6.7 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 01. 10. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

DELETE FROM t_ex_form_code
WHERE `code` = 'etaxHometaxIssNo'
AND `code_gbn` = 'list';

CREATE TABLE t_ex_form_code_bak_recheck
SELECT	`code`, `code_name`, `code_gbn`, `use_yn`, `required_yn`
FROM	t_ex_form_code;

DELETE FROM t_ex_form_code;

INSERT INTO t_ex_form_code ( `code`, `code_name`, `code_gbn`, `use_yn`, `required_yn`, create_seq, create_date, modify_seq, modify_date )
SELECT	`code`, `code_name`, `code_gbn`, `use_yn`, `required_yn`, 'SYSTEM', NOW(), 'SYSTEM', NOW()
FROM	t_ex_form_code_bak_recheck
GROUP	BY `code`, `code_name`, `code_gbn`, `use_yn`, `required_yn`;

DROP TABLE t_ex_form_code_bak_recheck;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => ?.? */
/* 여기까지 배포 완료 ( 배포일 : 2019. 01. 17. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 7.0 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 02. 15. 16:15 ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 7.3 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 03. 14. 17:27 ) - 이준성  */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 82 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 05. 23. 17:27 ) - 이준성  */

DELETE FROM t_ex_langpack WHERE lang_code IN ('ex_listCopy', 'ex_listDelete', 'ex_copyJournalizing', 'ex_deletionJournalizing' );

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 88 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 07. 04. 17:50 ) - 이준성  */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 89 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 07. 11. 17:50 ) - 김상겸  */

/* 2019. 07. 29. 김상겸 */
/* 지출결의 항목 추가 최대 건수 150건으로 조정 */
update	t_ex_option_multi
set		option_name = '[일반설정] 지출결의 상신 시 결의내역 최대입력 건수 설정 ( 최대 : 150 건 )'
where	option_gbn = '003'
and		option_code = '003003'
and		use_sw in ( 'ERPiU', 'iCUBE' );
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 93 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 08. 22. 18:06 ) - 이준성  */

/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 94 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 09. 06. 10:49  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.97 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 10. 31. 17:00  ) - 최상배  */
/* --------------------------------------------------------------------------------------------- */
		
/* 2019-12-11 최상배 
 * 2019-12-11 최상배 비영리 회계 시스템 기본설정 코드 제배포 */		
/* 2019-12-11 최상배 매입세금계산서 버튼 옵션 코드 변경 1/4 -> 3/6 */
UPDATE t_exnp_option SET option_gbn = '3', option_code = '6' WHERE option_gbn = '1' AND option_code = '4';
/* 2019-12-11 최상배 법인카드 승인내역 버튼 옵션 코드 변경 1/5 -> 3/5 */
UPDATE t_exnp_option SET option_gbn = '3' WHERE option_gbn = '1' AND option_code = '5';
/* 2019-12-11 최상배 비영리 회계 공통 양식코드 추가 [3/7] */
INSERT IGNORE INTO t_exnp_option (comp_seq, form_seq, option_gbn, option_code, note, use_sw, order_num, common_code, base_value, base_name, base_emp_value, set_value, set_name, set_emp_value, option_select_type, option_process_type, use_yn)
SELECT 
	comp_seq	
	, form_seq		
	, '3'			AS option_gbn
	, '7'			AS option_code
	, '카드 거래처 iCUBE 자동등록' AS note
	, use_sw
	, order_num	
	, common_code	
	, base_value
	, base_name
	, base_emp_value
	, set_value
	, set_name
	, set_emp_value
	, option_select_type
	, option_process_type
	, use_yn
FROM	t_exnp_option 
WHERE	option_gbn	= '3' 
 AND	option_code	= '4' 
 AND	form_seq	= '0' 
 AND	comp_seq	= 'NP_OPTION_G20';
/* 2019-12-11 최상배 비영리 회계 공통 양식코드 추가 [3/8] */
INSERT IGNORE INTO t_exnp_option (comp_seq, form_seq, option_gbn, option_code, note, use_sw, order_num, common_code, base_value, base_name, base_emp_value, set_value, set_name, set_emp_value, option_select_type, option_process_type, use_yn)
SELECT 
	comp_seq	
	, form_seq		
	, '3'			AS option_gbn
	, '8'			AS option_code
	, '계산서 거래처 iCUBE 자동등록' AS note
	, use_sw
	, order_num	
	, common_code	
	, base_value
	, base_name
	, base_emp_value
	, set_value
	, set_name
	, set_emp_value
	, option_select_type
	, option_process_type
	, use_yn
FROM	t_exnp_option 
WHERE	option_gbn	= '3' 
 AND	option_code	= '4' 
 AND	form_seq	= '0' 
 AND	comp_seq	= 'NP_OPTION_G20'; 
/* 2019-12-11 최상배 비영리 회계 공통 양식코드 삭제 [3/4] */ 
DELETE FROM t_exnp_option WHERE option_gbn = '3' AND option_code = '4';		

/* 2019-12-11 최상배 비영리 회계 공통 양식코드 미사용 처리 */
UPDATE	t_co_code_detail_multi SET use_yn = 'N'	WHERE	CODE  = 'exnp00006' AND	detail_code = '0';

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.102 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 09 17:00  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.102 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 15 17:55  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.103 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 23 15:00  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.103 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 29 13:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.103 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 30 09:10  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */


/* CMS 연동 중복데이터 제거를 위한 방안 >>>>> 104 버전 배포!! */
UPDATE	T_EX_CMS_SYNC
SET		CMS_BASE_DATE = (
			SELECT	DATE_FORMAT(DATE_ADD(DATE_FORMAT(MAX(AUTH_DATE), '%Y%m%d'), INTERVAL 1 day), '%Y%m%d')
			FROM	T_EX_CARD_AQ_TMP
			LIMIT	1
		)
		, MODIFY_DATE = NOW()
		, CMS_BASE_DAY = '31';
		
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.104 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 02. 10 14:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.104 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 02. 12 18:02  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.105 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 02. 20 17:25  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */		
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.105 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 02. 26 17:25  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.106 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 03. 05 17:35  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.106 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 03. 11 17:11  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.107 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 03. 19 17:58  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.107 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 03. 25 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.108 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 02 17:58  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.108 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 08 17:23  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.109 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 16 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.109 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 22 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.110 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 22 16:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.111 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 05. 21 16:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.111 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 05. 27 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- *//* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.112 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 06. 4 16:51  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.113 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 06. 18 17:20  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.114 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 07. 02 17:20  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.114 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 07. 10 14:40  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.115 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 07. 10 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.116 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 07. 30 14:40  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.116 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 08. 05 17:20  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.117 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 08. 05 14:35  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.117 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 08. 19 17:32  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.118 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 09. 02 17:32  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.119 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 09. 10 17:05  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.120 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 09. 24 17:05  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.121 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 10. 15 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.121 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 10. 21 17:20  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.121 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 10. 27 11:55  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.122 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 10. 29 17:20  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.122 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 11. 04 16:20  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.122 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 11. 09 15:40  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.123 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 11. 19 15:40  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.124 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 12. 03 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.124 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 12. 14 13:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.125 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 12. 17 17:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.126 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 01. 06 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.128 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 01. 28 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.128 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 02. 02 16:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.128 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 02. 03 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.130 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 03. 04 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.131 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 03. 24 15:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.132 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 03. 24 15:44  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.132 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 04. 07 17:16  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.133 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 04. 15 17:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.133 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 04. 21 17:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.134 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 04. 28 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.135 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 05. 18 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.136 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 05. 27 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.136 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 06. 02 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.139 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 07. 19 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.140 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 07. 22 17:43  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */



