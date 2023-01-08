INSERT IGNORE INTO neos.t_alert_setting
(comp_seq, group_seq, alert_type, alert_yn, push_yn, talk_yn, mail_yn, sms_yn, portal_yn, timeline_yn, use_yn, create_seq, create_date, modify_seq, modify_date, divide_type, link_event)
VALUES('SYSTEM', 'SYSTEM', 'PURCHASE001', 'Y', 'Y', 'N', 'N', 'N', 'Y', 'N', 'Y', '0', NULL, NULL, NULL, 'CM', NULL);

INSERT IGNORE INTO neos.t_co_event_setting
(`type`, code, portal_yn, timeline_yn, datas, seq, sub_seq, content_type, view_type, web_view_type, messenger_view_type, action_type, web_action_type)
VALUES('CUST', 'PURCHASE001', 'Y', 'N', 'title|contents', '', '', '0', 'B', 'Z', 'Z', 'Z', 'Z');

INSERT IGNORE INTO neos.t_co_event_message
(`type`, code, lang_code, message_no_preview, param_no_preview, message_title_push, param_title_push, message_push, param_push, message_talk, param_talk, message_sms, param_sms, message_mail, param_mail, message_portal, param_portal, message_title_talk, param_title_talk, message_title_sms, param_title_sms, message_title_mail, param_title_mail, message_title_portal, param_title_portal)
VALUES('CUST', 'PURCHASE001', 'cn', '', '', '%s', 'title', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'title', '%s', 'title', '%s', 'title', '%s', 'title');
INSERT IGNORE INTO neos.t_co_event_message
(`type`, code, lang_code, message_no_preview, param_no_preview, message_title_push, param_title_push, message_push, param_push, message_talk, param_talk, message_sms, param_sms, message_mail, param_mail, message_portal, param_portal, message_title_talk, param_title_talk, message_title_sms, param_title_sms, message_title_mail, param_title_mail, message_title_portal, param_title_portal)
VALUES('CUST', 'PURCHASE001', 'en', '', '', '%s', 'title', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'title', '%s', 'title', '%s', 'title', '%s', 'title');
INSERT IGNORE INTO neos.t_co_event_message
(`type`, code, lang_code, message_no_preview, param_no_preview, message_title_push, param_title_push, message_push, param_push, message_talk, param_talk, message_sms, param_sms, message_mail, param_mail, message_portal, param_portal, message_title_talk, param_title_talk, message_title_sms, param_title_sms, message_title_mail, param_title_mail, message_title_portal, param_title_portal)
VALUES('CUST', 'PURCHASE001', 'jp', '', '', '%s', 'title', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'title', '%s', 'title', '%s', 'title', '%s', 'title');
INSERT IGNORE INTO neos.t_co_event_message
(`type`, code, lang_code, message_no_preview, param_no_preview, message_title_push, param_title_push, message_push, param_push, message_talk, param_talk, message_sms, param_sms, message_mail, param_mail, message_portal, param_portal, message_title_talk, param_title_talk, message_title_sms, param_title_sms, message_title_mail, param_title_mail, message_title_portal, param_title_portal)
VALUES('CUST', 'PURCHASE001', 'kr', '', '', '%s', 'title', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'title', '%s', 'title', '%s', 'title', '%s', 'title');

INSERT IGNORE INTO neos.t_alert_admin
select
b.comp_seq, b.group_seq, a.alert_type, a.alert_yn, a.push_yn, a.talk_yn, a.mail_yn, a.sms_yn, a.portal_yn, a.timeline_yn, a.use_yn, a.create_seq, a.create_date, a.modify_seq, a.modify_date, a.divide_type, a.link_event
from neos.t_alert_setting a
join neos.t_co_comp b on b.comp_seq is not null
where a.alert_type = 'PURCHASE001';



CREATE table if not exists cust_sto.`t_purchase_attach_info` (
  `file_id` varchar(50) NOT NULL COMMENT '파일아이디',
  `file_name` varchar(255) NOT NULL COMMENT '파일아이디',
  `file_ext` varchar(20) NOT NULL COMMENT '확장자명',
  `seq` int(11) NOT NULL,
  `outProcessCode` varchar(30) NOT NULL COMMENT '프로세스코드',
  `form_code` varchar(50) NOT NULL COMMENT '양식코드',
  `use_yn` char(1) NOT NULL COMMENT '사용여부',
  `created_dt` datetime DEFAULT NULL COMMENT '생성일자',
  `created_by` varchar(32) DEFAULT NULL COMMENT '생성자',
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='첨부파일정보';


CREATE table if not exists cust_sto.`t_purchase_budget_info` (
  `seq` int(11) NOT NULL COMMENT '입찰/계약 시퀀스',
  `outProcessCode` varchar(15) NOT NULL COMMENT '외부연동코드',
  `erp_budget_seq` varchar(50) NOT NULL COMMENT '예산과목',
  `erp_budget_name` varchar(200) DEFAULT NULL COMMENT '예산과목',
  `erp_budget_div_seq` varchar(50) DEFAULT NULL COMMENT '예산회계단위',
  `erp_budget_div_name` varchar(200) DEFAULT NULL COMMENT '예산회계단위',
  `erp_bgt1_seq` varchar(50) DEFAULT NULL COMMENT '관',
  `erp_bgt1_name` varchar(200) DEFAULT NULL COMMENT '관',
  `erp_bgt2_seq` varchar(50) DEFAULT NULL COMMENT '항',
  `erp_bgt2_name` varchar(200) DEFAULT NULL COMMENT '항',
  `erp_bgt3_seq` varchar(50) DEFAULT NULL COMMENT '목',
  `erp_bgt3_name` varchar(200) DEFAULT NULL COMMENT '목',
  `erp_bgt4_seq` varchar(50) DEFAULT NULL COMMENT '세',
  `erp_bgt4_name` varchar(200) DEFAULT NULL COMMENT '세',
  `pjt_seq` varchar(50) DEFAULT NULL COMMENT '프로젝트',
  `pjt_name` varchar(200) DEFAULT NULL COMMENT '프로젝트',
  `bottom_seq` varchar(50) DEFAULT NULL COMMENT '하위사업',
  `bottom_name` varchar(200) DEFAULT NULL COMMENT '하위사업',
  `created_dt` datetime DEFAULT NULL COMMENT '생성일자',
  `created_by` varchar(32) DEFAULT NULL COMMENT '생성자',
  PRIMARY KEY (`seq`,`outProcessCode`,`erp_budget_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='예산정보';


CREATE table if not exists cust_sto.`t_purchase_code_detail` (
  `GROUP` varchar(50) NOT NULL,
  `CODE` varchar(50) NOT NULL,
  `NAME` varchar(200) NOT NULL,
  `USE_YN` char(1) NOT NULL,
  `ORDER_NUM` int(32) NOT NULL,
  `NOTE` varchar(500) DEFAULT NULL,
  `LINK` varchar(500) DEFAULT NULL,
  `FORM_HTML` longtext COMMENT '양식HTML',
  PRIMARY KEY (`GROUP`,`CODE`),
  KEY `t_purchase_code_detail_GROUP_IDX` (`GROUP`,`CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='구매모듈 전용코드';



CREATE table if not exists cust_sto.`t_purchase_code_group` (
  `GROUP` varchar(50) NOT NULL,
  `TYPE` varchar(50) NOT NULL,
  `NAME` varchar(200) NOT NULL,
  `USE_YN` char(1) NOT NULL,
  `ORDER_NUM` int(32) NOT NULL,
  `NOTE` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`GROUP`,`TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='구매모듈 전용코드그룹';



CREATE table if not exists cust_sto.`t_purchase_conclusion_change` (
  `change_seq` int(11) NOT NULL AUTO_INCREMENT,
  `seq` int(11) NOT NULL COMMENT '관리번호',
  `change_item_info` varchar(500) DEFAULT NULL COMMENT '변경항목정보',
  `work_info_before` varchar(500) DEFAULT NULL COMMENT '과업내용(전)',
  `work_info_after` varchar(500) DEFAULT NULL COMMENT '과업내용(후)',
  `contract_end_dt_before` char(10) DEFAULT NULL COMMENT '계약체결일자(전)',
  `contract_end_dt_after` char(10) DEFAULT NULL COMMENT '계약체결일자(후)',
  `contract_amt_info_before` varchar(500) DEFAULT NULL COMMENT '계약금액정보(전)',
  `contract_amt_info_after` varchar(500) DEFAULT NULL COMMENT '계약금액정보(후)',
  `contract_amt_after` decimal(19,2) DEFAULT NULL COMMENT '총계약금액(후)',
  `contract_amt_kor_after` varchar(50) DEFAULT NULL COMMENT '총계약금액(한글)',
  `change_etc` varchar(500) DEFAULT NULL COMMENT '기타변경정보',
  `change_reason` varchar(500) DEFAULT NULL COMMENT '변경사유정보',
  `created_dt` datetime DEFAULT NULL COMMENT '생성일자',
  `created_by` varchar(32) DEFAULT NULL COMMENT '생성자',
  `modify_dt` datetime DEFAULT NULL COMMENT '수정일자',
  `modify_by` varchar(32) DEFAULT NULL COMMENT '수정자',
  `doc_sts` varchar(10) DEFAULT NULL COMMENT '결재상태코드',
  PRIMARY KEY (`change_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='계약변경록정보';



CREATE table if not exists cust_sto.`t_purchase_contract` (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `manage_no` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '관리번호',
  `contract_no` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '계약번호',
  `contract_type` varchar(10) NOT NULL COMMENT '계약방법(입찰:01 / 수의:02)',
  `c_write_comp_seq` varchar(32) DEFAULT NULL COMMENT '(계약체결)작성자회사시퀀스',
  `c_write_dept_seq` varchar(32) DEFAULT NULL COMMENT '(계약체결)작성부서시퀀스',
  `c_write_emp_seq` varchar(32) DEFAULT NULL COMMENT '(계약체결)작성자시퀀스',
  `c_write_dt` char(10) DEFAULT NULL COMMENT '(계약체결)작성일자',
  `write_comp_seq` varchar(32) DEFAULT NULL COMMENT '작성자회사시퀀스',
  `write_dept_seq` varchar(32) DEFAULT NULL COMMENT '작성부서시퀀스',
  `write_emp_seq` varchar(32) DEFAULT NULL COMMENT '작성자시퀀스',
  `write_dt` char(10) DEFAULT NULL COMMENT '작성일자',
  `target_type` varchar(10) DEFAULT NULL COMMENT '목적물종류',
  `noti_type` varchar(10) DEFAULT NULL COMMENT '공고종류',
  `budget_type` varchar(10) DEFAULT NULL COMMENT '예산종류',
  `c_budget_type` varchar(10) DEFAULT NULL COMMENT '(계약체결)예산종류',
  `c_target_type` varchar(10) DEFAULT NULL COMMENT '(계약체결)목적물종류',
  `title` varchar(200) DEFAULT NULL COMMENT '공고명',
  `c_title` varchar(200) DEFAULT NULL COMMENT 'title\ncontract_end_dt\n(계약체결)공고명',
  `contract_start_dt` char(10) DEFAULT NULL COMMENT '계약체결일자',
  `contract_end_dt` char(10) DEFAULT NULL COMMENT '계약체결일자',
  `c_contract_end_dt` char(10) DEFAULT NULL COMMENT '(계약체결)계약체결일자',
  `amt` decimal(19,2) DEFAULT NULL COMMENT '기초금액',
  `amt_kor` varchar(50) DEFAULT NULL COMMENT '기초금액(한글)',
  `std_amt` decimal(19,2) DEFAULT NULL COMMENT '추정가격',
  `tax_amt` decimal(19,2) DEFAULT NULL COMMENT '부가세액',
  `base_law` varchar(10) DEFAULT NULL COMMENT '근거법령',
  `contract_law` varchar(10) DEFAULT NULL COMMENT '계약법령',
  `pay_type_info` varchar(500) DEFAULT NULL COMMENT '결재방법',
  `work_info` varchar(500) DEFAULT NULL COMMENT '과업내용',
  `c_work_info` varchar(500) DEFAULT NULL COMMENT '(계약체결)과업내용',
  `emergency_yn` char(1) DEFAULT NULL COMMENT '긴급여부',
  `restrict_sector_yn` char(1) DEFAULT NULL COMMENT '업종제한여부',
  `compete_type` varchar(10) DEFAULT NULL COMMENT '경쟁방식',
  `restrict_sector_info` varchar(500) DEFAULT NULL COMMENT '제한업종 정보',
  `restrict_area_info` varchar(500) DEFAULT NULL COMMENT '제한항목 정보',
  `nominee_info` varchar(500) DEFAULT NULL COMMENT '지명업체 정보',
  `decision_type_info` varchar(500) DEFAULT NULL COMMENT '낙찰자결정방식',
  `contract_form1` varchar(10) DEFAULT NULL COMMENT '계약체결형태(1)',
  `contract_form2` varchar(10) DEFAULT NULL COMMENT '계약체결형태(2)',
  `contract_form3` varchar(10) DEFAULT NULL COMMENT '계약체결형태(3)',
  `rebid_yn` char(1) DEFAULT NULL COMMENT '재입찰허용여부',
  `eorder_use_yn` char(1) DEFAULT NULL COMMENT 'E발주평가시스템이용여부',
  `created_dt` datetime DEFAULT NULL COMMENT '생성일자',
  `created_by` varchar(32) DEFAULT NULL COMMENT '생성자',
  `modify_dt` datetime DEFAULT NULL COMMENT '수정일자',
  `modify_by` varchar(32) DEFAULT NULL COMMENT '수정자',
  `doc_sts` varchar(10) DEFAULT NULL COMMENT '결재상태코드',
  `approkey_plan` varchar(50) DEFAULT NULL COMMENT '입찰/발주계획결재연동키',
  `approkey_meet` varchar(50) DEFAULT NULL COMMENT '평과회의전자결재연동키',
  `approkey_result` varchar(50) DEFAULT NULL COMMENT '평가결과전자결재연동키',
  `approkey_conclusion` varchar(50) DEFAULT NULL COMMENT '계약체결전자결재연동키',
  `approkey_change` varchar(50) DEFAULT NULL COMMENT '계약변경전자결재연동키',
  `meet_dt` char(25) DEFAULT NULL COMMENT '평가회의일시',
  `meet_place` varchar(100) DEFAULT NULL COMMENT '평가회의장소',
  `meet_method_pt` varchar(10) DEFAULT NULL COMMENT '평가방법(PT시간_분)',
  `meet_method_qa` varchar(10) DEFAULT NULL COMMENT '평가방법(QA시간_분)',
  `meet_amt_spent` decimal(19,2) DEFAULT NULL COMMENT '평가회의 지출금액',
  `result_judges_info` varchar(500) DEFAULT NULL COMMENT '제안서평가위원 정보',
  `result_judges_info_html` longtext COMMENT '제안서평가위원정보',
  `result_score_info` varchar(500) DEFAULT NULL COMMENT '제안서평가결과 정보',
  `result_score_info_html` longtext COMMENT '제안서평과결과정보',
  `result_target_info` varchar(500) DEFAULT NULL COMMENT '제안서평가대상 정보',
  `result_amt` decimal(19,2) DEFAULT NULL COMMENT '낙찰가격',
  `contract_term` varchar(10) DEFAULT NULL COMMENT '계약기간구분',
  `hope_attach_info` varchar(500) DEFAULT NULL COMMENT '희망기업확인서정보',
  `hope_company_info` varchar(500) DEFAULT NULL COMMENT '희망기업선택정보',
  `partner_addr` varchar(50) DEFAULT NULL COMMENT '계약대상거래처(주소)',
  `partner_bizno` varchar(30) DEFAULT NULL COMMENT '계약대상거래처(사업자번호)',
  `partner_code` varchar(50) DEFAULT NULL COMMENT '계약대상거래처(코드)',
  `partner_name` varchar(50) DEFAULT NULL COMMENT '계약대상거래처(회사명)',
  `partner_owner` varchar(50) DEFAULT NULL COMMENT '계약대상거래처(대표자명)',
  `partner_info_json` longtext COMMENT '거래처정보(결의데이터)',
  `private_reason` varchar(10) DEFAULT NULL COMMENT '수의계약사유',
  `pm_email` varchar(50) DEFAULT NULL COMMENT 'PM메일주소',
  `pm_hp` varchar(32) DEFAULT NULL COMMENT 'PM연락처',
  `pm_name` varchar(32) DEFAULT NULL COMMENT 'PM담당자명',
  `contract_amt` decimal(19,2) DEFAULT NULL COMMENT '계약금액',
  `contract_amt_info` varchar(500) DEFAULT NULL COMMENT '계약금액정보',
  `contract_amt_kor` varchar(50) DEFAULT NULL COMMENT '계약금액(한글)',
  `bidder_cnt` varchar(5) DEFAULT NULL COMMENT '투찰자수',
  `pre_notice_end_dt` char(10) DEFAULT NULL COMMENT '사전규격공개기간',
  `notice_start_dt` char(10) DEFAULT NULL COMMENT '본공고시작일자',
  `notice_end_dt` char(10) DEFAULT NULL COMMENT '본공고종료일자',
  `re_notice_start_dt` char(10) DEFAULT NULL COMMENT '재공고시작일자',
  `re_notice_end_dt` char(10) DEFAULT NULL COMMENT '재공고종료일자',
  `contract_change_dt` char(10) DEFAULT NULL COMMENT '변경계약일자',
  `contract_attach_info` varchar(100) DEFAULT NULL COMMENT '계약서첨부파일정보',
  `submit_attach_info` varchar(100) DEFAULT NULL COMMENT '제출첨부파일정보',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COMMENT='계약/발주등록정보';



-- cust_sto.t_purchase_payment_doc_info definition

CREATE table if not exists cust_sto.`t_purchase_payment_doc_info` (
  `seq` int(11) NOT NULL COMMENT '입찰/계약 시퀀스',
  `outProcessCode` varchar(15) NOT NULL COMMENT '외부연동코드',
  `res_doc_seq` varchar(32) NOT NULL COMMENT '전자결재문서키코드',
  `pay_type` char(1) NOT NULL COMMENT '지급구분(1:선금, 2:중도금, 3:잔금)',
  `pay_cnt` int(11) NOT NULL COMMENT '지급차수',
  `res_amt` decimal(19,2) NOT NULL COMMENT '결의금액',
  `remain_amt` decimal(19,2) NOT NULL COMMENT '잔여금액',
  `created_dt` datetime DEFAULT NULL COMMENT '생성일자',
  `created_by` varchar(32) DEFAULT NULL COMMENT '생성자',
  PRIMARY KEY (`seq`,`outProcessCode`,`res_doc_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='대금지급 전자결재 문서정보';



CREATE table if not exists cust_sto.`t_purchase_trade_info` (
  `seq` int(11) NOT NULL COMMENT '입찰/계약 시퀀스',
  `outProcessCode` varchar(15) NOT NULL COMMENT '외부연동코드',
  `tr_seq` varchar(50) DEFAULT NULL COMMENT '코드',
  `tr_name` varchar(50) DEFAULT NULL COMMENT '회사명',
  `at_tr_name` varchar(50) DEFAULT NULL COMMENT '회사명',
  `ceo_name` varchar(50) DEFAULT NULL COMMENT '대표자명',
  `tr_reg_number` varchar(30) DEFAULT NULL COMMENT '사업자번호',
  `addr` varchar(50) DEFAULT NULL COMMENT '주소',
  `depositor` varchar(32) DEFAULT NULL COMMENT '예금주',
  `ba_nb` varchar(50) DEFAULT NULL COMMENT '계좌번호',
  `btr_name` varchar(50) DEFAULT NULL COMMENT '금융기관명',
  `btr_seq` varchar(50) DEFAULT NULL COMMENT '금융기관코드',
  `tr_fg` varchar(50) DEFAULT NULL COMMENT '계약대상거래처(대표자명)',
  `tr_fg_name` varchar(50) DEFAULT NULL COMMENT '계약대상거래처(대표자명)',
  `pm_email` varchar(50) DEFAULT NULL COMMENT 'PM메일주소',
  `pm_hp` varchar(32) DEFAULT NULL COMMENT 'PM연락처',
  `pm_name` varchar(32) DEFAULT NULL COMMENT 'PM담당자명',
  `created_dt` datetime DEFAULT NULL COMMENT '생성일자',
  `created_by` varchar(32) DEFAULT NULL COMMENT '생성자',
  PRIMARY KEY (`seq`,`outProcessCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='결재내역정보';




CREATE DEFINER=`neos`@`%` FUNCTION `cust_sto`.`fn_get_purchase_code_text`(`GROUP_CODE` VARCHAR(50), `VALUE_INFO` VARCHAR(500)) RETURNS varchar(1000) CHARSET utf8
BEGIN
	DECLARE V_RETURN 		VARCHAR(1000);

	select 
	GROUP_CONCAT(value SEPARATOR ' / ')
	INTO V_RETURN
	from
	(
	select 
	concat(name,case when GROUP_CODE = 'hopeCompany' or sub_value = '' or INSTR(sub_value,'▦') = 1 then '' else concat('(',sub_value, case when `GROUP` = 'decisionType' and code = '03' then '%)' else ')' end ) end) as value
	from
	(
	select
	`GROUP`,
	code,
	name,
	substring(substring(concat('▦▦', VALUE_INFO,'▦▦'), INSTR(concat('▦▦', VALUE_INFO,'▦▦'), concat('▦▦',CODE, '▦'))+3 + length(code)), 1, INSTR(substring(concat('▦▦', VALUE_INFO,'▦▦'), INSTR(concat('▦▦', VALUE_INFO,'▦▦'), concat('▦▦',CODE, '▦'))+3 + length(code)), '▦▦')-1) as sub_value
	from cust_sto.t_purchase_code_detail where `GROUP` = GROUP_CODE and 
	concat('▦▦', VALUE_INFO,'▦▦') like concat('%▦▦',CODE, '▦%')
	) tableResult1
	) tableResult2	
	limit 1;
	
	IF V_RETURN IS NULL THEN
    SET V_RETURN = '';
	END IF;
	
	RETURN V_RETURN;
	
END;





INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('attachForm_Conclusion01-1', 'attachForm', '계약체결(입찰)', 'Y', 4, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('attachForm_Conclusion01-2', 'attachForm', '계약체결(수의)', 'Y', 5, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('attachForm_Conclusion02', 'attachForm', '계약변경', 'Y', 6, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('attachForm_Contract01', 'attachForm', '입찰공고', 'Y', 1, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('attachForm_Contract02', 'attachForm', '제안서평가회의', 'Y', 2, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('attachForm_Contract03', 'attachForm', '제안서평가결과', 'Y', 3, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('baseLaw', 'cm', '[공통]근거법령', 'Y', 3, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('contractForm1', 'cm', '[입찰]계약체결형태(1)', 'Y', 10, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('contractForm2', 'cm', '[입찰]계약체결형태(2)', 'Y', 11, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('contractForm3', 'cm', '[입찰]계약체결형태(3)', 'Y', 12, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('contractLaw', 'cm', '[계약]계약법령', 'Y', 15, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('contractYear', 'cm', '[계약]계약연도구분', 'Y', 13, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('decisionType', 'cm', '[입찰]낙찰자결정방식', 'Y', 5, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('hopeCompany', 'cm', '[입찰]희망기업구분', 'Y', 6, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('payType', 'cm', '[입찰]결재방법', 'Y', 4, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('privateReason', 'cm', '[계약]수의계약사유', 'Y', 14, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('restrictArea', 'cm', '[입찰]입찰제한항목', 'Y', 7, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('scoreType', 'cm', '[입찰]제안서평가구분', 'Y', 8, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('sectorGroup', 'cm', '[입찰]제한업종그룹', 'Y', 9, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('targetType', 'cm', '[공통]목적물종류', 'Y', 2, '');




INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Conclusion01-1', '01', '과업내용서', 'Y', 1, NULL, 'N▦과업내용서.pdf▦202211125c9a6611ba614952bc802784af794d6a', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Conclusion01-1', '02', '견적서(2부이상)', 'Y', 2, NULL, 'N▦견적서.pdf▦202211125c9a6611ba614952bc802784af794d6a', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Conclusion01-2', '01', '부당계약특수조건 체크리스트', 'Y', 1, NULL, 'N▦부당계약특수조건 체크리스트.pdf▦202211125c9a6611ba614952bc802784af794d6a', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Conclusion01-2', '02', '수의계약체결제한여부확인서', 'Y', 2, NULL, 'N▦수의계약체결제한여부확인서.pdf▦202211125c9a6611ba614952bc802784af794d6a', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Conclusion01-2', '03', '사업자등록증', 'Y', 3, NULL, 'N▦사업자등록증.pdf▦202211125c9a6611ba614952bc802784af794d6a', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Conclusion02', '01', '변경계약서', 'Y', 1, NULL, 'N▦변경계약서.pdf▦202211125c9a6611ba614952bc802784af794d6a', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Conclusion02', '02', '변경과업내용서', 'Y', 1, NULL, 'N▦변경과업내용서.pdf▦202211125c9a6611ba614952bc802784af794d6a', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract01', '01', '기초산출조사서', 'Y', 1, NULL, 'N▦기초산출조사서.pdf▦20221228d6b342090c2f44c9bea6b7919f42dfbd', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract01', '02', '사전규격공개', 'Y', 2, NULL, 'N▦사전규격공개.pdf▦2022122824d24543443d4c9389b0305048ccad00', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract01', '03', '입찰공고문', 'Y', 3, NULL, 'N▦입찰공고문.pdf▦20221228ce69f9f41b314ae8a3b00be8c65e155b', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract01', '04', '제안요청서', 'Y', 4, '', 'N▦제안요청서.pdf▦20221228f49a749a37904dfd8a608e9b9b75e0e9', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract01', '05', '과업내용서', 'Y', 5, '', 'N▦과업내용서.pdf▦202212283c5ccc655b9342649b1fce9bc5d8bd4c', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract01', '06', '부당계약특수조건 발주부서 체크리스트', 'Y', 6, '', 'N▦부당계약특수조건 발주부서 체크리스트.pdf▦20221228c9ab5c9c1150433b90bfa87ace5f7bfd', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract01', '07', '일상감사요청서', 'Y', 7, '', 'N▦일상감사요청서.pdf▦20221228fc0b02a144694897895cc564e95d2100', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract01', '08', '기타 사전절차자료', 'Y', 8, '', 'N▦기타 사전절차자료.pdf▦202212286038dc6d9d044dfb983e66720fa5b2a1', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract02', '01', '평가회의개최계획', 'Y', 1, NULL, 'N▦평가회의개최계획.pdf▦202211125c9a6611ba614952bc802784af794d6a', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract02', '02', '평가회의후보자명단', 'Y', 1, NULL, 'N▦평가회의후보자명단.pdf▦2022111216be93a0b12d451f8fdccc21df852d38', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract02', '03', '평가회의개최안내문', 'Y', 1, NULL, 'N▦평가회의개최안내문.pdf▦2022111215fc0ed3310542a6bb266fc0b7936af5', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract03', '01', '종합평가표', 'Y', 1, NULL, 'N▦종합평가표.pdf▦202211125c9a6611ba614952bc802784af794d6a', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract03', '02', '제안서 제출조서', 'Y', 1, NULL, 'N▦제안서 제출조서.pdf▦2022111216be93a0b12d451f8fdccc21df852d38', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('attachForm_Contract03', '03', '평가위원 최종선정표', 'Y', 1, NULL, 'N▦평가위원 최종선정표.pdf▦2022111215fc0ed3310542a6bb266fc0b7936af5', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('baseLaw', '01', '지방계약법 시행령 제22조 (지명입찰에 의할 계약)', 'Y', 1, '123123', NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('baseLaw', '02', '지방계약법 시행령 제25조 (전자공개 수의계약)', 'Y', 2, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('baseLaw', '03', '지방계약법 시행령 제42조 1항 (적격심사)', 'Y', 3, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('baseLaw', '04', '지방계약법 시행령 제43조 (협상에 의한 계약)', 'Y', 4, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('baseLaw', 'etc', '기타', 'Y', 5, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('budgetType', 'B1', '대행사업(B1)', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('budgetType', 'B2', '자체사업(B2)', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('budgetType', 'B3', '일반관리(B3)', 'Y', 3, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('budgetType', 'B4', '고유사업(B4)', 'Y', 4, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('budgetType', 'B5', '보조금(B5)', 'Y', 5, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('budgetType', 'B6', '기타(B6)', 'Y', 6, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('changeItem', '01', '과업내용', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('changeItem', '02', '계약기간', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('changeItem', '03', '계약금액', 'Y', 3, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('changeItem', 'etc', '기타', 'Y', 4, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('competeType', '01', '제한경쟁', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('competeType', '02', '지명경쟁', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Conclu01-01', '구매계약모듈(입찰계약체결)', 'Y', 4, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:57%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:757px;" />
	</colgroup>
	<tbody>
		<tr>
			<td style="width:754px;height:20px;border:1px dotted rgb(0, 0, 0);">
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="color:rgb(0, 0, 0);font-size:10pt;font-family:굴림;letter-spacing:0pt;">「OOO OOO OO」입찰 결과에 근거하여 「$title$」$target_type$ 계약을 아래와 같이 체결하고자 합니다.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>1.&nbsp;관련근거</b>:&nbsp;</span><span style="color:rgb(6, 17, 242);font-family:굴림;font-size:10pt;letter-spacing:0pt;">OOO OOO OO 제안서 평가회의 결과 (OOOO팀-000, 2023. 00. 00.)</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>2.&nbsp;계약개요</b></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;가.&nbsp;계 약 명:&nbsp;$title$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;나.&nbsp;계약기간:&nbsp;계약일로부터&nbsp;$contract_end_dt$&nbsp;까지</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;다.&nbsp;계약내용:&nbsp;$work_info$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;라.&nbsp;계약금액:&nbsp;$contract_amt$</span><span style="font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);letter-spacing:0pt;">원</span><span style="font-size:10pt;color:rgb(0, 0, 0);letter-spacing:0pt;font-family:굴림;"> $contract_amt_kor$ / 부가세 포함</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;마.&nbsp;계약법령:&nbsp;$contract_law$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;바.&nbsp;계약체결형태:&nbsp;$contract_form1$ /&nbsp;$contract_form2$ /&nbsp;$contract_form3$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>3.&nbsp;계약대상자</b></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;가.&nbsp;상호명:&nbsp;$tr_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;나.&nbsp;대표자:&nbsp;$ceo_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;다.&nbsp;사업자등록번호:&nbsp;$tr_reg_number$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;라.&nbsp;사업장 주소:&nbsp;$addr$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;마.&nbsp;담당자(PM)&nbsp;성명:&nbsp;$pm_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;바.&nbsp;담당자(PM)&nbsp;연락처:&nbsp;$pm_hp$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;사.&nbsp;담당자(PM)&nbsp;전자우편:&nbsp;$pm_email$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>4.&nbsp;예산항목</b>:&nbsp;$conclusion_budget_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>5.&nbsp;결제방법</b>:&nbsp;$pay_type$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">붙임 1</span><span style="font-family:굴림;font-size:10pt;letter-spacing:0pt;text-indent:0pt;">.&nbsp;과업내용서(최종) 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-family:굴림;font-size:10pt;letter-spacing:0pt;text-indent:0pt;">&nbsp; &nbsp; &nbsp; 2.&nbsp;산출내역서(최종) 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 3.&nbsp;사업자등록증(계약상대자) 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="color:rgb(0, 0, 0);font-size:10pt;letter-spacing:0pt;font-family:굴림;">&nbsp; &nbsp; &nbsp; 4.&nbsp;통장사본(계약상대자) 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="color:rgb(0, 0, 0);font-size:10pt;letter-spacing:0pt;font-family:굴림;">&nbsp; &nbsp; &nbsp; 5. 안전보건관리 준수 서약서 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="color:rgb(0, 0, 0);font-size:10pt;letter-spacing:0pt;font-family:굴림;">&nbsp; &nbsp; &nbsp; 6. 우선협상 회의록 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="color:rgb(0, 0, 0);font-size:10pt;letter-spacing:0pt;font-family:굴림;">&nbsp; &nbsp; &nbsp; </span><span style="color:rgb(6, 17, 242);font-size:10pt;letter-spacing:0pt;font-family:굴림;">7. 일상감사 요청서 1부.</span><span style="color:rgb(0, 0, 0);font-size:10pt;letter-spacing:0pt;font-family:굴림;">&nbsp; 끝.</span></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Conclu01-02', '구매계약모듈(수의계약체결)', 'Y', 4, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:58%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:779px;" />
	</colgroup>
	<tbody>
		<tr>
			<td style="width:776px;height:20px;border:1px dotted rgb(0, 0, 0);">
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="color:rgb(0, 0, 0);font-family:굴림;font-size:10pt;text-indent:0pt;letter-spacing:0pt;">「$title$」사업 추진과 관련하여&nbsp;「$title$」$target_type$ 계약을 아래와 같이 체결하고자 합니다.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;text-indent:0pt;letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>1.&nbsp;관련근거:</b>&nbsp;</span><span style="color:rgb(6, 17, 242);font-family:굴림;font-size:10pt;letter-spacing:0pt;">2023 OOOOO 사업 계획 수립 (OOOO팀-000, 2023. 00. 00.)</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>2.&nbsp;계약개요</b></span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp;가.&nbsp;계약명:&nbsp;$title$</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp;나.&nbsp;계약기간:&nbsp;계약일로부터&nbsp;$contract_end_dt$&nbsp;까지</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp;다.&nbsp;계약내용:&nbsp;$work_info$</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp;라.&nbsp;계약금액:&nbsp;$contract_amt$</span><span style="font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);letter-spacing:0pt;">원</span><span style="font-size:10pt;color:rgb(0, 0, 0);letter-spacing:0pt;font-family:굴림;"> $contract_amt_kor$ / 부가세 포함</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp;마.&nbsp;계약법령:&nbsp;$contract_law$</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp;바.&nbsp;계약방법:&nbsp;수의계약</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp;사.&nbsp;수의계약 사유:&nbsp;$private_reason$</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>3.&nbsp;계약대상자</b></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; 가.&nbsp;상호명:&nbsp;$tr_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;나.&nbsp;대표자:&nbsp;$ceo_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;다.&nbsp;사업자등록번호:&nbsp;$tr_reg_number$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;라.&nbsp;사업장 주소:&nbsp;$addr$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;마.&nbsp;담당자(PM)&nbsp;성명:&nbsp;$pm_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;바.&nbsp;담당자(PM)&nbsp;연락처:&nbsp;$pm_hp$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;사.&nbsp;담당자(PM)&nbsp;전자우편:&nbsp;$pm_email$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>4.&nbsp;예산항목</b>:&nbsp;$conclusion_budget_name$</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>5.&nbsp;결제방법</b>:&nbsp;$pay_type$</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">붙임 1.&nbsp;과업내용서&nbsp;1부.</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 2. 산출내역서 각&nbsp;1부.</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 3. 사업자등록증(계약상대자) 1부.</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 4.&nbsp;통장사본(계약상대자)&nbsp;1부.</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 5. 수의계약 요청사유서 </span><span style="color:rgb(6, 17, 242);font-size:10pt;letter-spacing:0pt;font-family:굴림;">및 희망기업 증명서 각</span><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"> 1부.</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 6. 청렴계약 이행서약서 1부.</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 7. 부당계약특수조건 발주부서 체크리스트&nbsp;1부.</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 8. 안전보관관리 준수 서약서 1부.</span></p>
				<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="color:rgb(0, 0, 0);font-size:10pt;letter-spacing:0pt;font-family:굴림;">&nbsp; &nbsp; &nbsp; 9.&nbsp;수의계약 체결 제한여부 확인서 1부.&nbsp; 끝.</span></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><br /></p>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Conclu01-2', '구매계약모듈(수의계약요청사유서)', 'Y', 4, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:40%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:647px;" />
	</colgroup>
	<tbody>
		<tr style="height:844px;">
			<td style="width:644px;height:841px;border:1px dotted rgb(0, 0, 0);">
				<p style="margin:0px;font-size:25pt;line-height:2;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);text-align:center;font-family:돋움체;"><span style="font-family:굴림;"><b>수의계약&nbsp;요청사유서</b></span><br /></p>
				<table id="table_1" cellspacing="0" summary="table" style="clear:both;zoom:1;word-break:normal;border:none;table-layout:fixed;width:641px;margin:1px;overflow-wrap:break-word;">
					<colgroup>
					<col style="width:112px;" />
					<col style="width:527px;" />
					</colgroup>
					<tbody>
						<tr style="height:38px;">
							<td style="overflow-wrap:break-word;width:109px;vertical-align:middle;border-width:2px 1px 1px 2px;border-style:solid;border-color:rgb(0, 0, 0);height:35.5px;">
								<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.7;letter-spacing:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><b><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">계&nbsp;약&nbsp;명</span></b></p>
							</td>
							<td style="overflow-wrap:break-word;width:524px;vertical-align:middle;border-width:2px 2px 1px 1px;border-style:solid;border-color:rgb(0, 0, 0);height:35.5px;">
								<p style="margin:0px;font-size:12pt;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">$title$</span></p>
							</td>
						</tr>
						<tr style="height:38px;">
							<td style="overflow-wrap:break-word;width:109px;vertical-align:middle;border-width:1px 1px 1px 2px;border-style:solid;border-color:rgb(0, 0, 0);height:36px;">
								<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.7;letter-spacing:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;"><b>소요예산</b></span></p>
							</td>
							<td style="overflow-wrap:break-word;width:524px;vertical-align:middle;border-width:1px 2px 1px 1px;border-style:solid;border-color:rgb(0, 0, 0);height:36px;">
								<p style="margin:0px;font-size:12pt;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">&nbsp;금</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">$amt$</span><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">원</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">$amt_kor$</span><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">&nbsp;/&nbsp;부가세&nbsp;포함</span></p>
							</td>
						</tr>
						<tr style="height:38px;">
							<td style="overflow-wrap:break-word;width:109px;vertical-align:middle;border-width:1px 1px 1px 2px;border-style:solid;border-color:rgb(0, 0, 0);height:36px;">
								<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.7;letter-spacing:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;"><b>계약상대자</b></span></p>
							</td>
							<td style="overflow-wrap:break-word;width:524px;vertical-align:middle;border-width:1px 2px 1px 1px;border-style:solid;border-color:rgb(0, 0, 0);height:36px;">
								<p style="margin:0px;font-size:12pt;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">$tr_name$&nbsp;</span><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">(대표자:&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">$ceo_name$</span><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">)</span></p>
							</td>
						</tr>
						<tr style="height:53px;">
							<td style="overflow-wrap:break-word;width:109px;vertical-align:middle;border-width:1px 1px 1px 2px;border-style:solid;border-color:rgb(0, 0, 0);height:51px;">
								<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;"><b>수의계약</b></span></p>
								<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;"><b>법적 근거</b></span></p>
							</td>
							<td style="overflow-wrap:break-word;width:524px;vertical-align:middle;border-width:1px 2px 1px 1px;border-style:solid;border-color:rgb(0, 0, 0);height:51px;">
								<p style="margin:0px;font-size:12pt;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:굴림;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">&nbsp;$contract_law$</span><br /></p>
							</td>
						</tr>
						<tr style="height:189px;">
							<td style="overflow-wrap:break-word;width:109px;vertical-align:middle;border-width:1px 1px 1px 2px;border-style:solid;border-color:rgb(0, 0, 0);height:187px;">
								<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;"><b>수의계약</b></span></p>
								<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;"><b>사유</b></span></p>
							</td>
							<td style="overflow-wrap:break-word;width:524px;vertical-align:middle;border-width:1px 2px 1px 1px;border-style:solid;border-color:rgb(0, 0, 0);height:187px;">
								<p style="margin:0px;font-size:12pt;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;text-indent:0pt;color:rgb(0, 0, 255);font-family:굴림;">&nbsp;$private_reason$</span></p>
							</td>
						</tr>
						<tr style="height:209px;">
							<td style="overflow-wrap:break-word;width:109px;vertical-align:middle;border-width:1px 1px 2px 2px;border-style:solid;border-color:rgb(0, 0, 0);height:206.5px;">
								<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;"><b>희망기업</b></span></p>
								<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><b><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">해당&nbsp;</span><span style="font-family:굴림;font-size:12pt;letter-spacing:0pt;text-indent:0pt;">확인</span></b></p>
							</td>
							<td style="overflow-wrap:break-word;width:524px;vertical-align:middle;border-width:1px 2px 2px 1px;border-style:solid;border-color:rgb(0, 0, 0);height:206.5px;">
								<p style="margin:0px;font-size:12pt;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:굴림;color:rgb(0, 0, 0);"><br /></p>
								<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><span style="font-size:12pt;letter-spacing:0pt;color:rgb(0, 0, 255);font-family:굴림;">&nbsp;$hope_company_info$</span></p>
								<p style="margin:0px 0px 0px 25px;font-size:10pt;line-height:1.6;letter-spacing:0pt;text-indent:-15pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;text-decoration-line:underline;">※ 확인서,&nbsp;지정서 등 해당 희망기업 증빙 서류를 품의서에 반드시 첨부</span></p>
							</td>
						</tr>
						<tr style="height:27px;">
							<td colspan="2" style="overflow-wrap:break-word;width:639px;vertical-align:middle;border-top:2px solid rgb(0, 0, 0);border-bottom:1px solid rgb(0, 0, 0);height:24.5px;">
								<p style="margin:0px;font-size:12pt;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">&nbsp;</span></p>
							</td>
						</tr>
						<tr style="height:90px;">
							<td colspan="2" style="overflow-wrap:break-word;width:639px;vertical-align:middle;border-top:1px solid rgb(0, 0, 0);border-bottom:1px solid rgb(0, 0, 0);height:88px;">
								<p style="margin:0px;font-size:13pt;text-align:right;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">담당:&nbsp;</span><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림;">&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">OOOOO</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">본부&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">OOOOO</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">팀&nbsp;&nbsp;&nbsp;직급:&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">OO</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">&nbsp;&nbsp;&nbsp;성명:&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">OOO</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">&nbsp;&nbsp;&nbsp;</span><span style="font-size:11pt;letter-spacing:0pt;font-family:굴림;">(서명)</span></p>
								<p style="margin:0px;font-size:13pt;text-align:right;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">팀장:&nbsp;&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">OOOOO</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">본부&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">OOOOO</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">팀&nbsp;&nbsp;&nbsp;직급:&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">OO</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">&nbsp;&nbsp;&nbsp;성명:&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">OOO</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림;">&nbsp;&nbsp;&nbsp;</span><span style="font-size:11pt;letter-spacing:0pt;font-family:굴림;">(서명)</span></p>
							</td>
						</tr>
						<tr style="height:115px;">
							<td colspan="2" style="overflow-wrap:break-word;width:639px;vertical-align:middle;border-top:1px solid rgb(0, 0, 0);border-bottom:2px solid rgb(0, 0, 0);height:112.5px;">
								<p style="margin:0px;font-size:10pt;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;">&nbsp;상기와&nbsp;같이&nbsp;수의계약&nbsp;요청사유서를&nbsp;제출합니다.</span></p>
								<p style="margin:0px;font-size:10pt;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;">&nbsp;</span></p>
								<p style="margin:0px;font-size:10pt;text-align:right;line-height:1.6;letter-spacing:0pt;text-indent:0pt;font-family:돋움체;color:rgb(0, 0, 0);"><span style="font-size:10pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림;">2023&nbsp;년&nbsp;&nbsp; &nbsp;월&nbsp;&nbsp; &nbsp;일</span></p>
							</td>
						</tr>
					</tbody>
				</table>
				<p style="line-height:1.2;color:rgb(0, 0, 0);font-family:돋움체;font-size:10pt;margin-top:0px;margin-bottom:0px;"><span style="font-family:굴림체;font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;"><br /></span></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Conclu02-01', '구매계약모듈(입찰계약변경)', 'Y', 5, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:50%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:798px;" />
	</colgroup>
	<tbody>
		<tr>
			<td style="width:795px;height:20px;border:1px dotted rgb(0, 0, 0);">
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="color:rgb(0, 0, 0);font-size:10pt;font-family:굴림;letter-spacing:0pt;">&nbsp;「$title$」 변경계약을 아래와 같이 체결하고자 합니다.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>1.&nbsp;관련근거</b>:&nbsp;2023 OOO OOO OO 계약 체결 [OOOO팀-000, 2023. 00. 00.]</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-family:굴림;font-size:10pt;letter-spacing:0pt;text-indent:0pt;color:rgb(0, 0, 0);">&nbsp;</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>2. 기존 계약 개요</b></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;가.&nbsp;계약명:&nbsp;$title$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;나.&nbsp;계약기간:&nbsp;계약일로부터&nbsp;$contract_end_dt$&nbsp;까지</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;다.&nbsp;계약내용:&nbsp;$work_info$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;라.&nbsp;계약금액:&nbsp;$contract_amt$</span><span style="font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);letter-spacing:0pt;">원</span><span style="font-size:10pt;color:rgb(0, 0, 0);letter-spacing:0pt;font-family:굴림;"> $contract_amt_kor$ / 부가세 포함</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;color:rgb(0, 0, 0);letter-spacing:0pt;font-family:굴림;"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>3. 변경계약 개요</b></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; 가. 변경사유: </span><span style="color:rgb(6, 17, 242);font-size:10pt;letter-spacing:0pt;font-family:굴림;">OOO OOO OO</span><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; 나. 변경내용</span></p>
				<table cellspacing="0" cellpadding="3" style="border-collapse:collapse;width:75%;table-layout:fixed;overflow-wrap:break-word;word-break:normal;">
					<colgroup>
					<col style="width:104px;" />
					<col style="width:247px;" />
					<col style="width:247px;" />
					</colgroup>
					<tbody>
						<tr style="height:31px;">
							<td style="width:97px;height:24px;border:1px solid rgb(0, 0, 0);background-color:rgb(217, 217, 217);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b>구분</b></p>
							</td>
							<td style="width:240px;height:24px;border:1px solid rgb(0, 0, 0);background-color:rgb(217, 217, 217);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b>기존</b></p>
							</td>
							<td style="width:240px;height:24px;border:1px solid rgb(0, 0, 0);background-color:rgb(217, 217, 217);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b>변경 후</b></p>
							</td>
						</tr>
						<tr style="height:42px;">
							<td style="width:97px;height:35px;border:1px solid rgb(0, 0, 0);background-color:rgb(242, 242, 242);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b>과업내용</b></p>
							</td>
							<td style="width:240px;height:35px;border:1px solid rgb(0, 0, 0);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
							</td>
							<td style="width:240px;height:35px;border:1px solid rgb(0, 0, 0);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
							</td>
						</tr>
						<tr style="height:42px;">
							<td style="width:97px;height:35px;border:1px solid rgb(0, 0, 0);background-color:rgb(242, 242, 242);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b>계약금액</b></p>
							</td>
							<td style="width:240px;height:35px;border:1px solid rgb(0, 0, 0);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
							</td>
							<td style="width:240px;height:35px;border:1px solid rgb(0, 0, 0);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
							</td>
						</tr>
						<tr style="height:42px;">
							<td style="width:97px;height:35px;border:1px solid rgb(0, 0, 0);background-color:rgb(242, 242, 242);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b>계약기간</b></p>
							</td>
							<td style="width:240px;height:35px;border:1px solid rgb(0, 0, 0);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
							</td>
							<td style="width:240px;height:35px;border:1px solid rgb(0, 0, 0);">
								<p style="text-align:center;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
							</td>
						</tr>
					</tbody>
				</table>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b><br /></b></span></p>
				<p style="font-size:10pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-family:굴림;font-size:10pt;letter-spacing:0pt;text-indent:0pt;"><b>4.&nbsp;예산항목</b>:&nbsp;$conclusion_budget_name$</span></p>
				<p style="font-size:10pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><br /></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><b>5.&nbsp;행정사항</b></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; 가. OOO OOO OO</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; 나.&nbsp;OOO OOO OO</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);"><br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">붙임 0. 합의각서 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 0. 변경 과업내용서 1부.<br /></span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 0. 수정 공정표 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 0. 변경 산출내역서 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 0. 변경 선금사용계획서 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 0. 일상감사 요청서 1부.&nbsp; 끝.</span></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Conclu02-02', '구매계약모듈(수의계약변경)', 'Y', 5, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:43%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:614px;" />
	</colgroup>
	<tbody>
		<tr>
			<td style="width:611px;height:20px;border:1px dotted rgb(0, 0, 0);">
				<p style="font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">「$title$」</span><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">사업 추진과 관련하여&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">「$title$」</span><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">용역(구매)&nbsp;계약을 아래와 같이 체결하고자 합니다.</span></p>
				<p style="font-size:10pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">1.&nbsp;관련근거:</span></p>
				<p style="font-size:10pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">2.&nbsp;계약개요</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;가.&nbsp;계약명 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$title$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;나.&nbsp;계약기간 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">계약일로부터&nbsp;$contract_end_dt_after$&nbsp;까지</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;다.&nbsp;계약내용 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$work_info_after$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;라.&nbsp;계약금액 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$contract_amt_after$</span><span style="font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-family:''apple sd gothic neo'';font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;">원</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"> $contract_amt_kor_after$/부가세 포함</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;마.&nbsp;계약법령 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$contract_law$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;바.&nbsp;계약방법 :&nbsp;수의계약</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;사.&nbsp;수의계약 사유 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$private_reason$</span></p>
				<p style="font-size:10pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">3.&nbsp;계약대상자</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; 가.&nbsp;상호명 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$tr_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;나.&nbsp;대표자 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$ceo_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;다.&nbsp;사업자등록번호 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$tr_reg_number$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;라.&nbsp;사업장 주소 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$addr$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;마.&nbsp;담당자(PM)&nbsp;성명 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$pm_name$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;바.&nbsp;담당자(PM)&nbsp;연락처 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$pm_hp$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;사.&nbsp;담당자(PM)&nbsp;전자우편 :&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$pm_email$</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-family:굴림체;font-size:10pt;letter-spacing:0pt;">&nbsp;</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">4.&nbsp;예산항목:&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$conclusion_budget_name$</span></p>
				<p style="font-size:10pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">5.&nbsp;결제방법:&nbsp;</span><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">$pay_type$</span></p>
				<p style="font-size:10pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">붙임&nbsp;1.&nbsp;과업내용서&nbsp;1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp;2.&nbsp;견적서 각&nbsp;1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp;3.&nbsp;수의계약 요청사유서&nbsp;1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp;4.&nbsp;청렴계약 이행서약서&nbsp;1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp;5.&nbsp;부당계약특수조건 발주부서 체크리스트&nbsp;1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp;6.&nbsp;사업자등록증(계약상대자) 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp;7.&nbsp;통장사본(계약상대자) 1부.</span></p>
				<p style="font-size:12pt;text-align:justify;line-height:1.35;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp;8. (선택)세부 추진계획(안) 1부. &nbsp;끝.</span></p>
				<p style="line-height:1.2;font-size:12pt;font-family:돋움체;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><br /></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Contract01', '구매계약모듈(계약입찰발주계획)', 'Y', 1, NULL, NULL, '<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><span style="font-family:함초롬바탕, 굴림;">&nbsp;</span></p>
<table cellpadding="0" cellspacing="0" style="font-size:9pt;border-collapse:collapse;width:145%;table-layout:fixed;overflow-wrap:break-word;word-break:normal;">
	<colgroup>
	<col style="width:1428px;" />
	</colgroup>
	<tbody>
		<tr style="height:25px;">
			<td style="border:1px rgb(0, 0, 0);width:1427px;height:24px;" rowspan="1" colspan="1">
				<table cellspacing="0" cellpadding="3" style="border-collapse:collapse;width:49%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
					<colgroup>
					<col style="width:711px;" />
					</colgroup>
					<tbody>
						<tr style="height:181px;">
							<td style="width:704px;height:174px;border:1px dotted rgb(0, 0, 0);">
								<p style="font-size:12pt;line-height:2;font-family:돋움체;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">「</span><span style="color:rgb(6, 17, 242);font-size:10pt;font-family:굴림;">OOO OOO OO</span><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">」 사업 추진과 관련하여 「$title$」 $target_type$&nbsp;계약 입찰을 아래와 같이 추진하고자 합니다.</span></p>
								<p style="font-size:12pt;line-height:2;font-family:돋움체;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;"><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);"><b>1.&nbsp;관련근거</b>: </span><span style="color:rgb(6, 17, 242);font-family:굴림;font-size:10pt;">2023 OOO OOO OO 사업 계획 수립 [OOOO팀-000, 2023. 00. 00.]</span></p>
								<p style="line-height:2;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;font-family:돋움체;font-size:10pt;"><span style="font-family:굴림;"><br /></span><span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);"><b>2.&nbsp;계약개요</b></span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp;&nbsp;가.&nbsp;계약명:&nbsp;&nbsp;$title$</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp;&nbsp;나.&nbsp;계약기간:&nbsp;&nbsp;계약일로부터 $contract_end_dt$&nbsp;까지</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp;&nbsp;다.&nbsp;계약내용:&nbsp;&nbsp;$work_info$</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp;&nbsp;라.&nbsp;기초금액:&nbsp; $amt$원($amt_kor$)</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp;&nbsp;마. 근거법령:&nbsp;&nbsp;$base_law$</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp;&nbsp;바.&nbsp;경쟁형태:&nbsp;&nbsp;$compete_type$</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp;&nbsp;사.&nbsp;낙찰자 결정방법:&nbsp;&nbsp;$decision_type$</span></p>
								<p style="line-height:2;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;font-family:돋움체;font-size:10pt;"><span style="font-family:굴림;"><br /></span><span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);"><b>3. 예산과목</b>:&nbsp;</span><span style="color:rgb(6, 17, 242);font-family:굴림;font-size:10pt;">고유목적사업비 / 2023 OOO OOO / 경비 / 지급수수료</span></p>
								<p style="line-height:2;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;font-family:돋움체;font-size:10pt;"><span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);"><b><br /></b></span></p>
								<p style="line-height:2;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;font-family:돋움체;font-size:10pt;"><span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);"><b>4.&nbsp;결제방법</b>:&nbsp;$pay_type$</span></p>
								<p style="line-height:2;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;font-family:돋움체;font-size:10pt;"><span style="font-family:굴림;"><br /></span></p>
								<p style="line-height:2;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;font-family:돋움체;font-size:10pt;"><span style="font-family:굴림;"><br /></span><span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp;붙임 1.&nbsp;사전규격공개&nbsp;1부.</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp;2.&nbsp;입찰공고문&nbsp;1부.</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp;3. 과업내용서&nbsp;1부.</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp;4.&nbsp;제안요청서 1부.</span></p>
								<p style="line-height:2;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;font-family:돋움체;font-size:10pt;"><span style="font-family:굴림;">&nbsp; &nbsp; &nbsp; &nbsp;5. 산출내역서 1부.</span></p>
								<p style="line-height:2;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;text-align:left;font-family:돋움체;font-size:10pt;"><span style="font-family:굴림;font-size:10pt;">&nbsp; &nbsp; &nbsp; &nbsp;6.&nbsp;청렴계약이행서약서&nbsp;1부.</span><span style="font-family:굴림;"><br /></span><span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp;7.&nbsp;부당계약특수조건 발주부서 체크리스트&nbsp;1부.</span><br />
								<span style="font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp;</span><span style="color:rgb(6, 17, 242);font-family:굴림;font-size:10pt;">8.&nbsp;일상감사요청서&nbsp;1부.</span><span style="font-size:10pt;font-family:굴림;">&nbsp; 끝.</span></p>
								<p style="text-align:left;font-size:12pt;font-family:돋움체;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
							</td>
						</tr>
					</tbody>
				</table>
				<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
			</td>
		</tr>
	</tbody>
</table>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Contract02', '구매계약모듈(평가회의등록)', 'Y', 2, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:50%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:675px;" />
	</colgroup>
	<tbody>
		<tr style="height:429px;">
			<td style="width:672px;height:426px;border:1px dotted rgb(0, 0, 0);">
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="color:rgb(0, 0, 0);font-size:10pt;font-family:굴림;">「$title$」$target_type$&nbsp;계약 입찰 우선협상대상자 선정을 위해,&nbsp;</span><span style="font-family:굴림;font-size:10pt;text-indent:0pt;">아래와 같이 제안서 평가회의를 개최하고자 합니다.</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);"><b>1.&nbsp;관련근거</b>:&nbsp;</span><span style="color:rgb(6, 17, 242);font-size:10pt;font-family:굴림;">2023 OOOOO 입찰 (OOOO팀-000, 2023. 00. 00.)</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-family:굴림;font-size:10pt;text-indent:0pt;color:rgb(0, 0, 0);">&nbsp;</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);"><b>2.&nbsp;계약개요</b></span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;가.&nbsp;계약명:&nbsp;$title$</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;나.&nbsp;계약기간:&nbsp;계약일로부터 $contract_end_dt$ 까지</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;다.&nbsp;계약내용:&nbsp;$work_info$</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;라.&nbsp;기초금액:&nbsp;$amt$</span><span style="font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-family:굴림;font-size:10pt;color:rgb(0, 0, 0);">원</span><span style="font-size:10pt;color:rgb(0, 0, 0);font-family:굴림;"> $amt_kor$/부가세 포함</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;마. 근거법령:&nbsp;$base_law$</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;바.&nbsp;경쟁형태:&nbsp;$compete_type$</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;사.&nbsp;낙찰자 결정방법:&nbsp;$decision_type$</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-family:굴림;font-size:10pt;text-indent:0pt;color:rgb(0, 0, 0);">&nbsp;</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);"><b>3.&nbsp;제안서 평가회의 개요</b></span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;가.&nbsp;일시:&nbsp;$meet_dt$</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;나.&nbsp;장소: $meet_place$</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;다.&nbsp;대상:&nbsp;$notice_end_dt$&nbsp;18시까지 입찰에 참여한 적격 업체</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;라.&nbsp;방법:&nbsp;업체별 PT $meet_method_pt$분, 질의응답 $meet_method_qa$분</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;&nbsp;마.&nbsp;심사위원: 8인 이상 분야별 전문가 선정(붙임 심사위원 후보자 명단 참조)</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(※서울관광재단 제안서 평가위원회 운영 개선 계획 근거하여 추진)</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);"><b>4.&nbsp;평가내용: 기술능력평가 중 정성적 평가(70점 만점)</b></span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; 가. 평가위원의 평가결과 집계 시</span><span style="font-family:굴림;font-size:10pt;text-indent:-42pt;">&nbsp;평가항목별 최고점과 최저점을 제외한 나머지를&nbsp;합산하여 채점(집계)</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-family:굴림;font-size:10pt;text-indent:-42pt;">&nbsp; 나. 평점은 소수점 이하 셋째 자리에서 반올림을 기준으로 함</span></p>
				<p style="margin-top:0px;margin-right:0px;margin-bottom:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;color:rgb(0, 0, 0);font-family:굴림;">&nbsp; 다. 기술능력평가 중 정량적 평가(20점)는 제안서 접수 후 발주부서에서 평가</span></p>
				<p style="margin-top:0px;margin-right:0px;margin-bottom:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-family:굴림;font-size:10pt;">&nbsp; 라. 입찰가격평가(10점)는 계약부서에서 평가</span></p>
				<p style="margin:0px;font-size:10pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp;</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);"><b>5.&nbsp;소요예산</b>:&nbsp;₩$meet_amt_spent$&nbsp;/ 부가세 포함</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp;※‘이사회 참석수당 및 회의수당’등 지급지침 근거</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);"><b>6.&nbsp;예산항목</b>&nbsp;:&nbsp;$meet_budget_name$</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;color:rgb(0, 0, 255);font-family:굴림;"><br /></span></p>
				<p style="margin:0px;font-size:10pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-family:굴림;font-size:10pt;text-indent:0pt;color:rgb(0, 0, 0);">붙임 1.&nbsp;심사위원 후보자 명단&nbsp;1부.</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 2.&nbsp;기술평가 배점기준 및 심사표&nbsp;1부.</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="font-size:10pt;font-family:굴림;color:rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; 3.&nbsp;제안서 평가회의 개최 안내문&nbsp;1부.</span></p>
				<p style="margin:0px;font-size:12pt;color:rgb(0, 0, 0);text-align:justify;line-height:2;text-indent:0pt;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;"><span style="color:rgb(0, 0, 0);font-size:10pt;font-family:굴림;">&nbsp; &nbsp; &nbsp; 4.&nbsp;이사회 참석수당,&nbsp;회의수당 등 지급지침&nbsp;1부. &nbsp;끝.</span></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Contract03', '구매계약모듈(평가결과등록)', 'Y', 3, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:68%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:675px;" />
	</colgroup>
	<tbody>
		<tr>
			<td style="width:672px;height:20px;border:1px dotted rgb(0, 0, 0);">
				<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;">​</p>
				<p style="margin:0px;font-size:21pt;text-align:center;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:14pt;text-decoration:underline;font-family:굴림;color:rgb(0, 0, 255);">$title$</span></p>
				<p style="margin:0px;font-size:21pt;text-align:center;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:14pt;text-decoration:underline;font-family:굴림;">제안서 평가결과</span></p>
				<p style="margin:0px;font-size:12pt;text-align:center;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:12pt;font-family:굴림;"><br /></span></p>
				<p style="margin-left:28px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;"><span style="font-size:10pt;font-family:굴림;"><b>□ 평가위원 명단</b></span></p>
				<p style="margin:20px 0px 0px;font-size:12pt;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);text-align:center;"><span style="font-size:10pt;font-family:굴림;">$result_judges_info_html$</span><span style="font-family:굴림;font-size:12pt;"><br /></span></p>
				<p style="margin:20px 0px 0px;font-size:12pt;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);text-align:center;"><span style="font-family:굴림;font-size:10pt;">​</span></p>
				<p style="margin:0px 0px 0px 28px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);"><span id="S_1672194164194" style="font-family:굴림;font-size:10pt;"></span><span style="color:rgb(6, 17, 242);font-family:굴림;font-size:10pt;">※ 특이사항 있을 시 기입</span><span id="E_1672194164194" style="font-size:10pt;font-family:굴림;"></span></p>
				<p style="margin:0px 0px 0px 28px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);"><span style="font-family:굴림;font-size:10pt;"><br /></span></p>
				<p style="margin:0px 0px 0px 28px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;font-family:굴림;"><b>□ 평가결과</b></span></p>
				<p style="margin:0px 0px 0px 28px;font-size:12pt;text-align:center;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;font-family:굴림;">$result_score_info_html$</span><span style="font-family:굴림;font-size:12pt;"><br /></span></p>
				<p style="margin:0px 0px 0px 28px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;font-family:굴림;"><br /></span></p>
				<p style="margin:0px 0px 0px 28px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;text-indent:-17pt;font-family:굴림;">&nbsp;※ 기술평가(정성적평가 </span><span style="color:rgb(6, 17, 242);font-size:10pt;text-indent:-17pt;font-family:굴림;">70점</span><span style="font-size:10pt;text-indent:-17pt;font-family:굴림;">) 점수는 평가항목별 최고점과 최저점을 제외한 산술평균임(소수점 이하 셋째자리 반올림)</span></p>
				<p style="margin:0px 0px 0px 28px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;font-family:굴림;">&nbsp;※ 지방자치단체 또는 계약담당자는 평가의 공정성 확보를 위하여 필요하다고 인정되는</span><span style="font-family:굴림;font-size:10pt;text-indent:-17pt;">&nbsp;경우 위원명을 공개하지 않을 수 있음</span></p>
				<p style="margin:0px 0px 0px 28px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);"><span style="font-family:굴림;font-size:10pt;text-indent:-17pt;">&nbsp;※ 제안서 평가결과 기술능력 및 가격 평가점수의 합산점수가 </span><span style="color:rgb(6, 17, 242);font-family:굴림;font-size:10pt;text-indent:-17pt;">00점</span><span style="font-family:굴림;font-size:10pt;text-indent:-17pt;"> 이상인 자를 협상적격자로 선정함</span></p>
				<p style="margin:0px 0px 0px 28px;font-size:12pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-17pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;font-family:굴림;"><br /></span></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'ManualPop01', '비품안내문구', 'Y', 5, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:68%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:436px;" />
	<col style="width:436px;" />
	</colgroup>
	<tbody>
		<tr style="height:61px;">
			<td style="width:869px;height:58px;border:1px solid rgb(0, 0, 0);" colspan="2">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b><span style="font-size:18pt;">비품</span></b></p>
			</td>
		</tr>
		<tr style="height:57px;">
			<td style="width:433px;height:54px;border:1px solid rgb(0, 0, 0);">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:15pt;">정수관리 대상</b></p>
			</td>
			<td style="width:433px;height:54px;border:1px solid rgb(0, 0, 0);">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:15pt;">정수관리 비대상</b></p>
			</td>
		</tr>
		<tr style="height:179px;">
			<td style="width:433px;height:176px;border:1px solid rgb(0, 0, 0);">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:13pt;">서울관광재단 정수관리 대상품 10종</b></p>
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:13pt;"><span style="color:rgb(6, 17, 242);">[물품관리 사무처리규정] 제 23조 주요물품의정수책정기준</span></b></p>
			</td>
			<td style="width:433px;height:176px;border:1px solid rgb(0, 0, 0);">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:13pt;">50만원 이상의 물품 중 정수관리대상 물품에 속하지 않은 물품</b></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'ManualPop02', '소모품안내문구', 'Y', 5, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:68%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:436px;" />
	<col style="width:436px;" />
	</colgroup>
	<tbody>
		<tr style="height:61px;">
			<td style="width:869px;height:58px;border:1px solid rgb(0, 0, 0);" colspan="2">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b><span style="font-size:18pt;">소모품</span></b></p>
			</td>
		</tr>
		<tr style="height:57px;">
			<td style="width:433px;height:54px;border:1px solid rgb(0, 0, 0);">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:15pt;">정수관리 대상</b></p>
			</td>
			<td style="width:433px;height:54px;border:1px solid rgb(0, 0, 0);">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:15pt;">정수관리 비대상</b></p>
			</td>
		</tr>
		<tr style="height:179px;">
			<td style="width:433px;height:176px;border:1px solid rgb(0, 0, 0);">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:13pt;">서울관광재단 정수관리 대상품 10종</b></p>
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:13pt;"><span style="color:rgb(6, 17, 242);">[물품관리 사무처리규정] 제 23조 주요물품의정수책정기준</span></b></p>
			</td>
			<td style="width:433px;height:176px;border:1px solid rgb(0, 0, 0);">
				<p style="text-align:center;font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><b style="font-size:13pt;">50만원 이상의 물품 중 정수관리대상 물품에 속하지 않은 물품</b></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractForm1', '01', '확정계약', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractForm1', '02', '사후원가검토조건부계약', 'Y', 2, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractForm1', '03', '개산계약', 'Y', 3, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractForm2', '01', '총액계약', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractForm2', '02', '단가계약', 'Y', 2, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractForm3', '01', '단년도', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractForm3', '02', '장기계속', 'Y', 2, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractForm3', '03', '계속비', 'Y', 3, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractLaw', '01', '지방계약법 시행령 제30조제1항제2호 나목 및 제25조(추정가격 2천만원 이하)', 'Y', 1, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractLaw', '02', '지방계약법 시행령 제30조제1항제2호 마목 및 제25조(추정가격 2천만원 초과 5천만원 이하 여성기업 등)', 'Y', 2, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractLaw', '03', '지방계약법 시행령 제26조제1항(유찰 후 수의계약)', 'Y', 3, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractLaw', '04', '지방계약법 시행령 제25조(전자공개수의)', 'Y', 4, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractLaw', '05', '지방계약법 시행령 제43조(협상에 의한 계약)', 'Y', 5, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractLaw', 'etc', '기타', 'Y', 6, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractTerm', '01', '단년도', 'Y', 0, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractTerm', '02', '다년도', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractTerm', '03', '계속비', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractType', '01', '입찰계약', 'Y', 0, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractType', '02', '수의계약', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractYear', '01', '1차년도', 'Y', 0, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractYear', '02', '2차년도', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contractYear', '03', '3차년도', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('decisionType', '01', '협상에의한계약', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('decisionType', '02', '적격심사', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('decisionType', '03', '낙찰하한가율', 'Y', 3, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('decisionType', 'etc', '기타', 'Y', 4, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('hopeCompany', '01', '소상공인', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('hopeCompany', '02', '소기업', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('hopeCompany', '03', '여성기업', 'Y', 3, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('hopeCompany', '04', '사회적기업', 'Y', 4, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('hopeCompany', '05', '장애인기업', 'Y', 5, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('hopeCompany', '06', '중증장애인생산품생산시설', 'Y', 6, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('notiType', '01', '입찰공고', 'Y', 0, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('notiType', '02', '전자수의공고', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('payType', '01', '세금계산서', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('payType', 'etc', '기타', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('privateReason', '01', '추정가격 2천만원 이하', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('privateReason', '02', '추정가격 2천만원 초과 5천만원 이하 여성기업 등', 'Y', 2, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('privateReason', '03', '유찰 후 수의계약', 'Y', 3, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('privateReason', '04', '전자공개 수의계약', 'Y', 4, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('privateReason', 'etc', '기타', 'Y', 5, '', '', '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('resFormSeq', 'CONCLUSION', '계약지출결의양식코드', 'Y', 1, NULL, '314', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('resFormSeq', 'Contract02', '평가회의품의양식코드', 'Y', 2, NULL, '316', NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('restrictArea', '01', '소기업', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('restrictArea', '02', '중소기업', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('restrictArea', '03', '동일실적', 'Y', 3, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('restrictArea', '04', '지역', 'Y', 4, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('restrictArea', '05', '보유기술', 'Y', 5, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('restrictArea', 'etc', '기타', 'Y', 6, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('scoreType', '10', '정량적평가(20)', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('scoreType', '20', '정성적평가(70)', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('scoreType', '30', '가격평가(10)', 'Y', 3, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('sectorGroup', '01', 'A그룹', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('sectorGroup', '02', 'B그룹', 'Y', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('targetType', '01', '용역', 'Y', 1, '123', NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('targetType', '02', '용역(정보화)', 'N', 2, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('targetType', '03', '용역(기술)', 'N', 3, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('targetType', '04', '물품(구매)', 'Y', 4, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('targetType', '05', '물품(제조)', 'N', 5, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('targetType', '06', '공사', 'Y', 6, NULL, NULL, NULL);

ALTER TABLE cust_sto.t_purchase_contract ADD public_info varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '담당자정보';
ALTER TABLE cust_sto.t_purchase_contract MODIFY COLUMN contract_law varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '계약법령';
ALTER TABLE cust_sto.t_purchase_contract MODIFY COLUMN base_law varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '근거법령';
ALTER TABLE cust_sto.t_purchase_contract MODIFY COLUMN private_reason varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '수의계약사유';
ALTER TABLE cust_sto.t_purchase_budget_info ADD amt decimal(19,2) NULL COMMENT '신청금액' AFTER bottom_name;

INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('competeType', '03', '일반경쟁', 'Y', 3, NULL, NULL, NULL);

INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('option', 'def_erp_budget_div_seq', '디폴트예산회계단위코드', 'Y', 0, '1000', NULL, NULL);

INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('option', 'def_erp_budget_div_name', '디폴트예산회계단위코드명', 'Y', 0, '재단법인 서울관광재단', NULL, NULL);


INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Conclu01-3', '구매계약모듈(안전보건관리준수서약서)', 'Y', 4, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:57%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:781px;" />
	</colgroup>
	<tbody>
		<tr style="height:844px;">
			<td style="width:778px;height:841px;border:1px dotted rgb(0, 0, 0);">
				<p style="margin:0px;font-size:24pt;text-align:center;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:24pt;font-weight:bold;letter-spacing:-0.72pt;font-family:''맑은 고딕'', 굴림;">안전보건관리 준수 서약서</span></p>
				<p style="margin:0px;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;font-size:10pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:''맑은 고딕'', 굴림;">&nbsp;</span></p>
				<p style="margin:0px;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;font-size:10pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:''맑은 고딕'', 굴림;">&nbsp;</span></p>
				<p style="margin:0px;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;font-size:10pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:''맑은 고딕'', 굴림;">&nbsp;</span></p>
				<p style="margin:0px;font-size:13pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;</span><span style="font-size:13pt;letter-spacing:-0.39pt;font-family:''맑은 고딕'', 굴림;">본인은&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:굴림체;text-decoration-line:underline;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.26pt;font-family:''신명 중고딕'', sylfaen;text-decoration-line:underline;">(</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.39pt;font-family:''신명 중고딕'', 굴림;text-decoration-line:underline;">계약명</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.26pt;font-family:''신명 중고딕'', sylfaen;text-decoration-line:underline;">)</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:굴림체;text-decoration-line:underline;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style="font-size:13pt;letter-spacing:-0.39pt;font-family:''맑은 고딕'', 굴림;">&nbsp;계약을 수행함에 있어 재해예방을 위하여 아래의 내용과 관련 법규에서 정한 필수사항을 철저히 준수할 것을 다음과 같이 서약합니다</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''맑은 고딕'', 굴림;">.</span></p>
				<p style="margin:0px;font-size:13pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:''맑은 고딕'', 굴림;">&nbsp;</span></p>
				<p style="margin:0px;font-size:13pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:굴림체;">&nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">&nbsp;｢산업안전보건법</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">,&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">중대재해처벌법｣ 등 관련 법규를 준수하겠습니다</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">.</span></p>
				<p style="margin:11px 0px 0px 33px;font-size:13pt;text-align:right;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-20pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">:&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">예</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">(</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp;&nbsp; &nbsp;</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">)</span></p>
				<p style="margin:11px 0px 0px 53px;font-size:13pt;text-align:right;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-32pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">&nbsp;:&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">아니오</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp;&nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">(</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp;&nbsp; &nbsp;</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">)</span></p>
				<p style="margin:11px 0px 0px 53px;font-size:13pt;text-align:right;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-32pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:''맑은 고딕'', 굴림;">&nbsp;</span></p>
				<p style="margin:0px;font-size:13pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">&nbsp;본인은 본 용역을 수행함에 있어 위 언급한 내용대로 계약을 성실히 이행할 것을 확약하며 안전보건관리 준수서약서를 제출합니다</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">.</span></p>
				<p style="margin:11px 0px 0px 23px;font-size:13pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:''맑은 고딕'', 굴림;">&nbsp;</span></p>
				<p style="margin:11px 0px 0px;font-size:13pt;text-align:center;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">20</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">년</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp;&nbsp; &nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">월</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp;&nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">일</span></p>
				<p style="margin:11px 0px 0px;font-size:13pt;text-align:center;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:''맑은 고딕'', 굴림;">&nbsp;</span></p>
				<p style="margin:11px 0px 0px;font-size:13pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:14pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:''맑은 고딕'', 굴림;">&nbsp;</span></p>
				<p style="margin:11px 0px 0px;font-size:13pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:14pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">서울관광재단 ○○○○팀장</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">○○○</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">(</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">인</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">)</span></p>
				<p style="margin:11px 0px 0px;font-size:5pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:14pt;color:rgb(0, 0, 0);"><span style="font-size:5pt;letter-spacing:0pt;font-family:''맑은 고딕'', 굴림;">&nbsp;</span></p>
				<p style="margin:11px 0px 0px;font-size:13pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:14pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">서울관광재단 경영지원팀장</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:굴림체;">&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">○○○</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">(</span><span style="font-size:13pt;letter-spacing:-0.13pt;font-family:''맑은 고딕'', 굴림;">인</span><span style="font-size:13pt;letter-spacing:-0.09pt;font-family:''맑은 고딕'', 굴림;">)</span></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
<div name="approval_end_date">
	<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
</div>
');

INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Contract01-1', '구매계약모듈(청렴계약이행서약서)', 'Y', 1, NULL, NULL, '<table cellspacing="0" cellpadding="1" style="border-collapse:collapse;width:57%;margin:0px;table-layout:fixed;overflow-wrap:break-word;word-break:normal;" mapping_key="">
	<colgroup>
	<col style="width:781px;" />
	</colgroup>
	<tbody>
		<tr style="height:844px;">
			<td style="width:778px;height:841px;border:1px dotted rgb(0, 0, 0);">
				<p style="margin:0px 0px 0px 61px;font-size:23pt;text-align:center;line-height:1.7;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:-37pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:23pt;letter-spacing:-0.61pt;font-family:''신명 견고딕'', sylfaen;text-decoration-line:underline;">(</span><span style="font-size:23pt;letter-spacing:-0.92pt;font-family:''신명 견고딕'', 굴림;text-decoration-line:underline;">재</span><span style="font-size:23pt;letter-spacing:-0.61pt;font-family:''신명 견고딕'', sylfaen;text-decoration-line:underline;">)</span><span style="font-size:23pt;letter-spacing:-0.92pt;font-family:''신명 견고딕'', 굴림;text-decoration-line:underline;">서울관광재단 청렴계약이행서약서</span></p>
				<p style="margin:16px 0px 0px;font-size:13pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.52pt;font-family:''신명 중명조'', 굴림;">&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.35pt;font-family:''신명 태명조'', sylfaen;">(</span><span style="font-size:13pt;letter-spacing:-0.52pt;font-family:''신명 중명조'', 굴림;">재</span><span style="font-size:13pt;letter-spacing:-0.35pt;font-family:''신명 태명조'', sylfaen;">)</span><span style="font-size:13pt;letter-spacing:-0.52pt;font-family:''신명 중명조'', 굴림;">서울관광재단에서는 부패 없는 투명한 행정이 사회발전과 국가 경쟁력에 중요한 관건이 됨을 깊이 인식하여 유리알처럼 맑고 깨끗한 시정을 구현하고자&nbsp;</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.52pt;font-family:''신명 중명조'', 굴림;">「</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.35pt;font-family:''신명 태명조'', sylfaen;">00</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.52pt;font-family:''신명 중명조'', 굴림;">공사</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.35pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.52pt;font-family:''신명 중명조'', 굴림;">용역</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.35pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;color:rgb(0, 0, 255);letter-spacing:-0.52pt;font-family:''신명 중명조'', 굴림;">물품」</span><span style="font-size:13pt;letter-spacing:-0.52pt;font-family:''신명 중명조'', 굴림;">에 대해 청렴계약제를 시행합니다</span><span style="font-size:13pt;letter-spacing:-0.35pt;font-family:''신명 태명조'', sylfaen;">.</span></p>
				<p style="margin:16px 0px 0px;font-size:13pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">&nbsp;우리 재단은 위 공사</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">(</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">용역</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">물품</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">)&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">입찰</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">계약</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">계약이행 과정</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">(</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">준공 이후도 포함</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">)</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">에서 관계되는 모든 임직원들은 관계법령에 규정된 절차에 따라 공정하고 투명하게 집행함은 물론 그 내용을 실시간으로 공개하고 이해관계자에 적극 협조하겠습니다</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">.</span></p>
				<p style="margin:16px 0px 0px;font-size:13pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">&nbsp;내부비리 제보자에 대하여는 어떠한 불이익 처분도 하지 않겠습니다</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">.</span></p>
				<p style="margin:16px 0px 0px;font-size:13pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">&nbsp;입찰</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">계약 및 계약이행 과정</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">(</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">준공 이후도 포함</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">)</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">에서 관련 임직원들은 이유여하를 막론하고 금품</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">향응</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">친인척 등에 대한 부정 취업 제공이나 부당한 이익 제공을 요구하지 않고</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">받지 않도록 하겠으며</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">,&nbsp;</span><span style="font-size:13pt;letter-spacing:-0.26pt;font-family:''신명 중명조'', 굴림;">이를 위반할 시에는 징계 등 관계법에 따라 책임질 것을 서약합니다</span><span style="font-size:13pt;letter-spacing:-0.17pt;font-family:''신명 태명조'', sylfaen;">.</span></p>
				<p style="margin:13px 0px 0px;font-size:10pt;text-align:justify;line-height:0.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:한양신명조, 굴림;">&nbsp;</span></p>
				<p style="margin:0px;font-size:10pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:한양신명조, 굴림;">&nbsp;</span></p>
				<p style="margin:0px;font-size:10pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:한양신명조, 굴림;">&nbsp;</span></p>
				<p style="margin:0px;font-size:10pt;text-align:justify;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:10pt;letter-spacing:0pt;font-family:한양신명조, 굴림;">&nbsp;</span></p>
				<p style="margin:33px 0px 0px;font-size:13pt;text-align:center;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp;</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">20</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">.</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">.</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">.</span></p>
				<p style="margin:33px 0px 0px;font-size:13pt;text-align:center;line-height:1.8;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">&nbsp;</span></p>
				<p style="margin:0px;font-size:13pt;text-align:center;line-height:1.3;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp;</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 중명조'', 굴림;">서울관광재단</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 중명조'', 굴림;">○○○팀장</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 중명조'', 굴림;">○○○</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">(</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 중명조'', 굴림;">인</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">)</span></p>
				<p style="margin:0px;font-size:13pt;text-align:center;line-height:1.3;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">&nbsp;</span></p>
				<p style="margin:0px;font-size:13pt;text-align:center;line-height:1.3;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">&nbsp;</span></p>
				<p style="margin:0px;font-size:13pt;text-align:center;line-height:1.3;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;word-break:keep-all;color:rgb(0, 0, 0);"><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 중명조'', 굴림;">서울관광재단 경영지원팀장</span><span style="font-size:13pt;letter-spacing:0pt;font-family:굴림체;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 중명조'', 굴림;">○○○</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">(</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 중명조'', 굴림;">인</span><span style="font-size:13pt;letter-spacing:0pt;font-family:''신명 태명조'', sylfaen;">)&nbsp;</span></p>
			</td>
		</tr>
	</tbody>
</table>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="margin:0px;font-size:12pt;text-align:justify;line-height:1.6;font-family:dotum, 돋움, helvetica, applesdgothicneo, sans-serif;text-indent:0pt;color:rgb(0, 0, 0);"><span style="font-size:12pt;color:rgb(0, 0, 255);letter-spacing:0pt;font-family:굴림체;"><br /></span></p>
<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
<div name="approval_end_date">
	<p style="font-family:돋움체;font-size:10pt;color:rgb(0, 0, 0);margin-top:0px;margin-bottom:0px;line-height:1.2;"><br /></p>
</div>
');

 
ALTER TABLE cust_sto.t_purchase_contract ADD joint_contract_method varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '공통계약방법';

INSERT ignore INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('jointContractMethod', 'cm', '[계약]공동계약방법', 'Y', 16, '');
INSERT ignore INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('jointContractMethod', '01', '단독이행', 'Y', 1, NULL, NULL, NULL);
INSERT ignore INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('jointContractMethod', '02', '공동(공동)이행', 'Y', 1, NULL, NULL, NULL);
INSERT ignore INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('jointContractMethod', '03', '공동(분담)이행', 'Y', 1, NULL, NULL, NULL);

ALTER TABLE cust_sto.t_purchase_trade_info ADD tr_idx int(11) NULL COMMENT '순번';

INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('option', 'ServiceKey', '공공데이터포털 인증키', 'Y', 0, 'PNQxDknffndjLgpc7m2eLwB3NkDdWbuS/FWdlGDfkvpldisL7f1X0729A2GNQVnTB014fBT3fiqqvMEIWfhl6A==', 'http://apis.data.go.kr/1230000/ShoppingMallPrdctInfoService05/getShoppingMallPrdctInfoList', NULL);

ALTER TABLE cust_sto.t_purchase_contract ADD c_contract_form1 varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '계약체결형태(1)';
ALTER TABLE cust_sto.t_purchase_contract ADD c_contract_form2 varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '계약체결형태(2)';
----------------- 운영서버에 여기까지 반영 -------------------

CREATE TABLE if not exists cust_stot_purchase_purchase (
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `manage_no` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '구매번호',
  `write_comp_seq` varchar(32) DEFAULT NULL COMMENT '작성자회사시퀀스',
  `write_dept_seq` varchar(32) DEFAULT NULL COMMENT '작성부서시퀀스',
  `write_emp_seq` varchar(32) DEFAULT NULL COMMENT '작성자시퀀스',
  `write_dt` char(10) DEFAULT NULL COMMENT '작성일자',
  `created_dt` datetime DEFAULT NULL COMMENT '생성일자',
  `created_by` varchar(32) DEFAULT NULL COMMENT '생성자',
  `modify_dt` datetime DEFAULT NULL COMMENT '수정일자',
  `modify_by` varchar(32) DEFAULT NULL COMMENT '수정자',
  `doc_sts` varchar(10) DEFAULT NULL COMMENT '결재상태코드',
  `approkey_purchase` varchar(50) DEFAULT NULL COMMENT '구매품의결재연동키',
  `approkey_check` varchar(50) DEFAULT NULL COMMENT '물품검수전자결재연동키',
  `title` varchar(200) DEFAULT NULL COMMENT '문서제목',
  `purchase_method` varchar(200) DEFAULT NULL COMMENT '구매방법',
  `purchase_type` varchar(10) DEFAULT NULL COMMENT '구매유형',
  `pay_type_info` varchar(200) DEFAULT NULL COMMENT '결재방법',
  `public_info` varchar(500) DEFAULT NULL COMMENT '담당자정보',
  `purchase_amt` decimal(19,2) DEFAULT NULL COMMENT '구매총금액',
  `purchase_amt_kor` varchar(50) DEFAULT NULL COMMENT '구매금액(한글)',
  `item_info_html` longtext COMMENT '물품규격정보연동html',
  `purchase_attach_info` varchar(100) DEFAULT NULL COMMENT '붙임문서정보',
  `c_write_comp_seq` varchar(32) DEFAULT NULL COMMENT '(검수)작성자회사시퀀스',
  `c_write_dept_seq` varchar(32) DEFAULT NULL COMMENT '(검수)작성부서시퀀스',
  `c_write_emp_seq` varchar(32) DEFAULT NULL COMMENT '(검수)작성자시퀀스',
  `c_write_dt` char(10) DEFAULT NULL COMMENT '(검수)작성일자',
  `check_location` varchar(10) DEFAULT NULL COMMENT '검수장소',
  `release_dt` char(10) DEFAULT NULL COMMENT '납품일자',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COMMENT='구매품의등록정보';

ALTER TABLE cust_sto.t_purchase_trade_info ADD hope_attach_info varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '희망기업확인서정보';
ALTER TABLE cust_sto.t_purchase_trade_info ADD hope_company_info varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '희망기업선택정보';

INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('resFormSeq', 'Purchase01', '구매품의양식코드', 'Y', 3, NULL, '219', NULL);

insert IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('attachForm_Purchase01', 'attachForm', '구매품의', 'Y', 7, '');

insert IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('attachForm_Purchase02', 'attachForm', '물품검수', 'Y', 8, '');



INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('unit', 'cm', '[구매]단위', 'Y', 17, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('unit', '01', '킬로그램', 'Y', 1, NULL, NULL, NULL);


INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('inventory', 'cm', '[구매]물품대장코드', 'Y', 18, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('inventory', '01', '내구성물품대장', 'Y', 1, NULL, NULL, NULL);


INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('useLocation', 'cm', '[구매]사용위치', 'Y', 19, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('useLocation', '01', '본사1층 서울광광플라자', 'Y', 1, NULL, NULL, NULL);


INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('foreignType', 'cm', '[구매]국내외구분', 'Y', 20, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('foreignType', '01', '국내', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('foreignType', '02', '국외', 'Y', 2, NULL, NULL, NULL);


INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('country', 'cm', '[구매]국가코드', 'Y', 21, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('country', 'kr', '대한민국', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('country', 'en', '미국', 'Y', 2, NULL, NULL, NULL);


INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('acquisitionReason', 'cm', '[구매]취득사유', 'Y', 22, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('acquisitionReason', '01', '취득/무상관리전환', 'Y', 1, NULL, NULL, NULL);


INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('greenCertType', 'cm', '[구매]녹색제품인증구분', 'Y', 23, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('greenCertType', '', '--', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('greenCertType', '01', '에너지절약', 'Y', 2, NULL, NULL, NULL);


INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('nonGreenReason', 'cm', '[구매]녹색미구매사유', 'Y', 24, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('nonGreenReason', '', '--', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('nonGreenReason', '01', '품목에 녹색제품 없음', 'Y', 2, NULL, NULL, NULL);


INSERT IGNORE INTO cust_sto.t_purchase_code_group
(`GROUP`, `TYPE`, NAME, USE_YN, ORDER_NUM, NOTE)
VALUES('greenClass', 'cm', '[구매]녹색제품분류', 'Y', 25, '');
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('greenClass', '', '--', 'Y', 1, NULL, NULL, NULL);
INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('greenClass', '01', '필기구 및 필기구 소모품', 'Y', 2, NULL, NULL, NULL);



CREATE table if not exists cust_sto.`t_purchase_item_info` (
  `seq` int(11) NOT NULL COMMENT '물품구매 시퀀스',
  `item_tr_seq` varchar(50) DEFAULT NULL COMMENT '공급업체시퀀스',
  `outProcessCode` varchar(15) NOT NULL COMMENT '외부연동코드',
  `item_idn_no` varchar(50) NOT NULL COMMENT '식별번호',
  `item_div_no` varchar(50) DEFAULT NULL COMMENT '분류번호',
  `item_name` varchar(200) DEFAULT NULL COMMENT '품명',
  `item_amt` decimal(19,2) DEFAULT NULL COMMENT '단가',
  `item_fee_amt` decimal(19,2) DEFAULT NULL COMMENT '부가세',
  `item_total_amt` decimal(19,2) DEFAULT NULL COMMENT '소계액',
  `item_total_amt_text` varchar(50) DEFAULT NULL COMMENT '소계액',
  `item_cnt` varchar(10) DEFAULT NULL COMMENT '수량',
  `item_check_cnt` varchar(10) DEFAULT NULL COMMENT '검수수량',
  `item_deadline` varchar(10) DEFAULT NULL COMMENT '납품기한',
  `item_acquisition_reason` varchar(50) NOT NULL COMMENT '취득사유',
  `item_inventory_cd` varchar(50) DEFAULT NULL COMMENT '물품대장코드',
  `item_unit` varchar(50) DEFAULT NULL COMMENT '단위',
  `item_use_location` varchar(200) DEFAULT NULL COMMENT '사용위치',
  `item_contry` varchar(10) DEFAULT NULL COMMENT '국가',
  `item_pickup_location` varchar(200) DEFAULT NULL COMMENT '수령장소',
  `item_green_cert_type` varchar(50) DEFAULT NULL COMMENT '녹색제품인증구분',
  `item_non_green_reason` varchar(50) DEFAULT NULL COMMENT '녹색제품미구매사유',
  `item_green_class` varchar(50) DEFAULT NULL COMMENT '녹색제품분류',
  `item_foreign_type` varchar(10) DEFAULT NULL COMMENT '국내외구분',
  `created_dt` datetime DEFAULT NULL COMMENT '생성일자',
  `created_by` varchar(32) DEFAULT NULL COMMENT '생성자',
  PRIMARY KEY (`seq`,`outProcessCode`,`item_idn_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='물품정보';

INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Purchase01', '구매계약모듈(구매품의)', 'Y', 6, NULL, NULL, '');

INSERT IGNORE INTO cust_sto.t_purchase_code_detail
(`GROUP`, CODE, NAME, USE_YN, ORDER_NUM, NOTE, LINK, FORM_HTML)
VALUES('contentsForm', 'Purchase02', '구매계약모듈(물품검수)', 'Y', 7, NULL, NULL, '');


ALTER TABLE cust_sto.t_purchase_budget_info ADD txt_open_amt varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '예산액(작성시점)';
ALTER TABLE cust_sto.t_purchase_budget_info ADD txt_cons_balance_amt varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '집행액(작성시점)';
ALTER TABLE cust_sto.t_purchase_budget_info ADD txt_apply_amt varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '품의액(작성시점)';
ALTER TABLE cust_sto.t_purchase_budget_info ADD txt_balance_amt varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '예산잔액(작성시점)';
