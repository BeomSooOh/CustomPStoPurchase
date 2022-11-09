/* CREATE TABLE SAMPLE */
/* 
CREATE TABLE IF NOT EXITS `neos`.`table_name`(
    `columns` VARCHAR(32) NOT NULL COMMENT '컬럼 설명'
    PRIMARY KEY (`columns`)
);
*/

/* ALERT TABLE SAMPLE */
/*
ALTER TABLE `neos`.`table_name` ADD COLUMN IF NOT EXISTS `columnsA` VARCAHR(32) DEFAULT '-' NOT NULL COMMENT '컬럼 설멍' AFTER `columns`;
*/

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 11. 22. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 11. 22. */
/* 2016. 11. 22. - 김상겸 */
/* 2016. 11. 22. - 김상겸 - CMS 연동 배치 생성 개발 */
/* CREATE `neos`.`t_ex_cms_sync` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_cms_sync`(  
  `comp_seq` VARCHAR(32) NOT NULL COMMENT 'CMS 연동 귀속 회사 시퀀스',
  `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부',
  `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부',
  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부',
  `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`)
);

/* ALTER `neos`.`t_ex_cms_sync` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS `cms_sync_yn` VARCHAR(2) DEFAULT 'N'  NOT NULL  COMMENT 'CMS 연동 여부' AFTER `comp_seq`;
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS `cms_batch_yn` VARCHAR(2) DEFAULT 'N'  NOT NULL  COMMENT 'CMS 배치 처리 여부' AFTER `cms_sync_yn`;
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS `cms_process_yn` VARCHAR(2) DEFAULT 'N'  NOT NULL  COMMENT 'CMS 연동 진행중 여부' AFTER `cms_batch_yn`;
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL  COMMENT '최종 수정 일자' AFTER `cms_process_yn`;

/* CREATE `neos`.`t_expend_log` */
CREATE TABLE IF NOT EXISTS `neos`.`t_expend_log`(  
  `batch_seq` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'batch 실행 로그 순번',
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '로그 귀속 회사 시퀀스',
  `module_type` VARCHAR(32) NOT NULL COMMENT 'module 구분',
  `log_type` VARCHAR(32) NOT NULL COMMENT 'log 구분',
  `message` VARCHAR(1024) NOT NULL COMMENT 'log 메시지',
  `create_date` DATETIME NOT NULL DEFAULT NOW() COMMENT '생성일자',
  PRIMARY KEY (`batch_seq`)
);

/* ALTER `neos`.`t_expend_log` ADD COLUMN */
ALTER TABLE `neos`.`t_expend_log` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NOT NULL  COMMENT '로그 귀속 회사 시퀀스' AFTER `batch_seq`;
ALTER TABLE `neos`.`t_expend_log` ADD COLUMN IF NOT EXISTS `module_type` VARCHAR(32) NOT NULL  COMMENT 'module 구분' AFTER `comp_seq`;
ALTER TABLE `neos`.`t_expend_log` ADD COLUMN IF NOT EXISTS `log_type` VARCHAR(32) NOT NULL  COMMENT 'log 구분' AFTER `module_type`;
ALTER TABLE `neos`.`t_expend_log` ADD COLUMN IF NOT EXISTS `message` VARCHAR(1024) NOT NULL  COMMENT 'log 메시지' AFTER `log_type`;
ALTER TABLE `neos`.`t_expend_log` ADD COLUMN IF NOT EXISTS `create_date` DATETIME NOT NULL  COMMENT '생성일자' AFTER `message`;


/* 2016. 11. 23. */
/* 2016. 11. 23. - 최상배 */
/* 2016. 11. 23. - 최상배 - 회계 기초 테이블 생성쿼리 */

/* CREATE `neos`.`t_ex_acct` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_acct`(  
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `acct_code` VARCHAR(20) NOT NULL COMMENT '계정과목 코드',
  `acct_name` VARCHAR(60) DEFAULT NULL COMMENT '계정과목 명칭',
  `vat_yn` VARCHAR(20) DEFAULT NULL COMMENT '부가세 계정 여부 ( Y : 부가세 계정 / N : 부가세 계정 아님 )',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`,`acct_code`)
);

/* ALTER `neos`.`t_ex_acct` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_acct` ADD COLUMN IF NOT EXISTS `acct_name` VARCHAR(60) DEFAULT NULL COMMENT '계정과목 명칭' AFTER `acct_code`;
ALTER TABLE `neos`.`t_ex_acct` ADD COLUMN IF NOT EXISTS `vat_yn` VARCHAR(20) DEFAULT NULL COMMENT '부가세 계정 여부 ( Y : 부가세 계정 / N : 부가세 계정 아님 )' AFTER `acct_name`;
ALTER TABLE `neos`.`t_ex_acct` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )' AFTER `vat_yn`;
ALTER TABLE `neos`.`t_ex_acct` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자' AFTER `use_yn`;
ALTER TABLE `neos`.`t_ex_acct` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자' AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_acct` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자' AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_acct` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자' AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_auth` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_auth`(
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `auth_div` VARCHAR(32) NOT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )',
  `auth_code` VARCHAR(32) NOT NULL COMMENT '증빙유형 코드',
  `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭',
  `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )',
  `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드',
  `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭',
  `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드',
  `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭',
  `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서',
  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT 'iCUBE사유구분 코드',
  `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE사유구분 명',
  PRIMARY KEY (`comp_seq`,`auth_div`,`auth_code`)  
);

/* ALTER `neos`.`t_ex_auth` ADD COLUMN */
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭'  AFTER `auth_code`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )'  AFTER `auth_name`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드'  AFTER `cash_type`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭'  AFTER `cr_acct_code`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드'  AFTER `cr_acct_name`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭'  AFTER `vat_acct_code`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )'  AFTER `vat_acct_name`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )'  AFTER `vat_type_code`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )'  AFTER `vat_type_name`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )'  AFTER `erp_auth_code`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )'  AFTER `erp_auth_name`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )'  AFTER `auth_required_yn`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )'  AFTER `partner_required_yn`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )'  AFTER `card_required_yn`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )' 	 AFTER `project_required_yn`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 / ERPiU / iCUBE )'  AFTER `note_required_yn`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 / ERPiU / iCUBE )' 	 AFTER `no_tax_code`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `order_num` DECIMAL(10, 0) DEFAULT NULL COMMENT '정렬순서'  AFTER `no_tax_name`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부' 	  AFTER `order_num`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'  AFTER `use_yn`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자'  AFTER `create_seq`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'  AFTER `create_date`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자'  AFTER `modify_seq`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT 'iCUBE사유구분 코드'   AFTER `modify_date`;
 ALTER TABLE `neos`.`t_ex_auth` ADD COLUMN IF NOT EXISTS  `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE사유구분 명'  AFTER `va_type_code`;

/* CREATE `neos`.`t_ex_card` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_card`(  
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `card_code` VARCHAR(32) NOT NULL COMMENT '카드코드',
  `card_num` VARCHAR(20) NOT NULL COMMENT '카드번호',
  `card_name` VARCHAR(120) DEFAULT NULL COMMENT '카드명칭',
  `partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드 ( ERPiU 전용 사용 )',
  `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '금융거래처 명청 ( ERPiU 전용 사용 )',
  `card_public_json` LONGTEXT COMMENT '공개범위 설정 JSON 문자열',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`,`card_code`)
);

/* ALTER `neos`.`t_ex_card` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `card_num` VARCHAR(20) NOT NULL COMMENT '카드번호' AFTER `card_code`;
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `card_name` VARCHAR(120) DEFAULT NULL COMMENT '카드명칭'  AFTER `card_num`;
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드 ( ERPiU 전용 사용 )'  AFTER `card_name`;
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '금융거래처 명청 ( ERPiU 전용 사용 )'  AFTER `partner_code`;
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `card_public_json` LONGTEXT COMMENT '공개범위 설정 JSON 문자열'  AFTER `partner_name`;
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )'  AFTER `card_public_json`;
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'  AFTER `use_yn`;
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자'  AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'  AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_card` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자'  AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_card_aq_tmp` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_card_aq_tmp`(  
  `sync_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '키값',
  `owner_reg_no` VARCHAR(10) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `card_code` VARCHAR(3) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `card_name` VARCHAR(20) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `card_num` VARCHAR(16) NOT NULL COMMENT '카드번호',
  `user_name` VARCHAR(30) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `auth_num` VARCHAR(20) NOT NULL COMMENT '승인번호',
  `auth_date` CHAR(8) NOT NULL COMMENT '승인일자',
  `auth_time` CHAR(6) NOT NULL COMMENT '승인시간',
  `aqui_date` CHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `georae_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `georae_stat` VARCHAR(4) DEFAULT NULL COMMENT '승인(1) / 취소(!1) 구분',
  `georae_cand` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `request_amount` DECIMAL(19,0) NOT NULL COMMENT '공급대가',
  `amt_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '공급가액 ( 금융사 제공 )',
  `vat_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '부가세액 ( 금융사 제공 )',
  `ser_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '서비스금액 ( 금융사 제공 )',
  `fre_amount` DECIMAL(19,0) DEFAULT NULL,
  `amt_md_amount` DECIMAL(19,0) NOT NULL COMMENT '공급가액 ( 벤더사 재가공 제공 )',
  `vat_md_amount` DECIMAL(19,0) NOT NULL COMMENT '부가세액 ( 벤더사 재가공 제공 )',
  `georae_gukga` VARCHAR(3) DEFAULT NULL COMMENT '거래국가 구분',
  `for_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액',
  `usd_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액 ( 달러 )',
  `merc_name` VARCHAR(50) NOT NULL COMMENT '거래처 명',
  `merc_saup_no` VARCHAR(10) DEFAULT NULL COMMENT '거래처 사업자 등록 번호',
  `merc_addr` VARCHAR(256) DEFAULT NULL COMMENT '거래처 주소',
  `merc_repr` VARCHAR(30) DEFAULT NULL,
  `merc_tel` VARCHAR(20) DEFAULT NULL COMMENT '거래처 연락처',
  `merc_zip` VARCHAR(6) DEFAULT NULL COMMENT '거래처 우편번호',
  `mcc_name` VARCHAR(60) DEFAULT NULL,
  `mcc_code` VARCHAR(10) DEFAULT NULL,
  `mcc_stat` VARCHAR(2) DEFAULT NULL,
  `vat_stat` VARCHAR(1) DEFAULT NULL,
  `can_date` VARCHAR(8) DEFAULT NULL COMMENT '승인 취소 일자',
  `ask_site` VARCHAR(1) DEFAULT NULL,
  `site_date` VARCHAR(8) DEFAULT NULL,
  `ask_date` VARCHAR(8) DEFAULT NULL,
  `ask_time` VARCHAR(6) DEFAULT NULL,
  `gongje_no_chk` VARCHAR(1) DEFAULT NULL,
  `first_date` VARCHAR(8) DEFAULT NULL,
  `cancel_date` VARCHAR(8) DEFAULT NULL,
  `abroad` VARCHAR(1) DEFAULT NULL COMMENT '국내(A) / 해외(B) 사용 구분',
  `van_created_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드',
  `van_edited_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드',
  `created_by` INT(11) DEFAULT NULL,
  `created_dt` DATETIME DEFAULT NULL,
  `edited_dt` INT(11) DEFAULT NULL,
  `edited_by` DATETIME DEFAULT NULL,
  `edited_action` VARCHAR(256) DEFAULT NULL,
  `createdate` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `createtime` VARCHAR(6) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `sett_date` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `org_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `aqui_rate` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `conversion_fee` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `auth_cd` VARCHAR(32) DEFAULT NULL,
  `auth_nm` VARCHAR(128) DEFAULT NULL,
  `summary_cd` VARCHAR(32) DEFAULT NULL,
  `summary_nm` VARCHAR(128) DEFAULT NULL,
  `pjt_cd` VARCHAR(32) DEFAULT NULL,
  `pjt_nm` VARCHAR(128) DEFAULT NULL,
  `detail` VARCHAR(100) DEFAULT NULL,
  `if_m_id` VARCHAR(32) DEFAULT '''0''' COMMENT '외부연동 아이디',
  `if_d_id` VARCHAR(32) DEFAULT '''0''' COMMENT '외부연동 아이디',
  `del_yn` VARCHAR(20) DEFAULT '''N''' COMMENT '삭제 처리 여부 ( Y / !Y )',
  `app_div` VARCHAR(20) DEFAULT NULL,
  `send_yn` VARCHAR(1) DEFAULT NULL COMMENT '결의 상신 구분 ( Y / !Y )',
  `user_send_yn` VARCHAR(20) DEFAULT '''N''' COMMENT '관리자 마감 처리 구분 ( Y / !Y )',
  `emp_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '사용자정보 시퀀스',
  `summary_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '표준적요정보 시퀀스',
  `auth_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '증빙유형정보 시퀀스',
  `project_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '프로젝트정보 시퀀스',
  `budget_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '예산정보 시퀀스',
  `doc_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '전자결재 시퀀스',
  PRIMARY KEY (`sync_id`),
  KEY `card_num` (`card_num`),
  KEY `auth_date` (`auth_date`),
  KEY `auth_num` (`auth_num`),
  KEY `merc_name` (`merc_name`),
  KEY `emp_seq` (`emp_seq`,`summary_seq`,`auth_seq`,`project_seq`,`budget_seq`),
  KEY `del_yn` (`del_yn`,`send_yn`,`user_send_yn`)
);

/* ALTER `neos`.`t_ex_card_aq_tmp` ADD COLUMN */
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `owner_reg_no` VARCHAR(10) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `sync_id`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `card_code` VARCHAR(3) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `owner_reg_no`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `card_name` VARCHAR(20) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `card_code`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `card_num` VARCHAR(16) NOT NULL COMMENT '카드번호'  AFTER `card_name`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `user_name` VARCHAR(30) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `card_num`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `auth_num` VARCHAR(20) NOT NULL COMMENT '승인번호'  AFTER `user_name`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `auth_date` CHAR(8) NOT NULL COMMENT '승인일자'  AFTER `auth_num`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `auth_time` CHAR(6) NOT NULL COMMENT '승인시간'  AFTER `auth_date`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `aqui_date` CHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `auth_time`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `georae_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `aqui_date`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `georae_stat` VARCHAR(4) DEFAULT NULL COMMENT '승인(1) / 취소(!1) 구분'    AFTER `georae_coll`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `georae_cand` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `georae_stat`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `request_amount` DECIMAL(19,0) NOT NULL COMMENT '공급대가'  AFTER `georae_cand`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `amt_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '공급가액 ( 금융사 제공 )'     AFTER `request_amount`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `vat_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '부가세액 ( 금융사 제공 )'     AFTER `amt_amount`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `ser_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '서비스금액 ( 금융사 제공 )'    AFTER `vat_amount`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `fre_amount` DECIMAL(19,0) DEFAULT NULL  AFTER `ser_amount`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `amt_md_amount` DECIMAL(19,0) NOT NULL COMMENT '공급가액 ( 벤더사 재가공 제공 )'  AFTER `fre_amount`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `vat_md_amount` DECIMAL(19,0) NOT NULL COMMENT '부가세액 ( 벤더사 재가공 제공 )'  AFTER `amt_md_amount`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `georae_gukga` VARCHAR(3) DEFAULT NULL COMMENT '거래국가 구분'    AFTER `vat_md_amount`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `for_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액'  AFTER `georae_gukga`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `usd_amount` DECIMAL(19, 4) DEFAULT NULL COMMENT '외화금액 ( 달러 )'    AFTER `for_amount`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `merc_name` VARCHAR(50) NOT NULL COMMENT '거래처 명'  AFTER `usd_amount`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `merc_saup_no` VARCHAR(10) DEFAULT NULL COMMENT '거래처 사업자 등록 번호'    AFTER `merc_name`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `merc_addr` VARCHAR(256) DEFAULT NULL COMMENT '거래처 주소'     AFTER `merc_saup_no`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `merc_repr` VARCHAR(30) DEFAULT NULL  AFTER `merc_addr`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `merc_tel` VARCHAR(20) DEFAULT NULL COMMENT '거래처 연락처'    AFTER `merc_repr`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `merc_zip` VARCHAR(6) DEFAULT NULL COMMENT '거래처 우편번호'   AFTER `merc_tel`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `mcc_name` VARCHAR(60) DEFAULT NULL  AFTER `merc_zip`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `mcc_code` VARCHAR(10) DEFAULT NULL  AFTER `mcc_name`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `mcc_stat` VARCHAR(2) DEFAULT NULL  AFTER `mcc_code`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `vat_stat` VARCHAR(1) DEFAULT NULL  AFTER `mcc_stat`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `can_date` VARCHAR(8) DEFAULT NULL COMMENT '승인 취소 일자'    AFTER `vat_stat`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `ask_site` VARCHAR(1) DEFAULT NULL  AFTER `can_date`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `site_date` VARCHAR(8) DEFAULT NULL  AFTER `ask_site`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `ask_date` VARCHAR(8) DEFAULT NULL  AFTER `site_date`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `ask_time` VARCHAR(6) DEFAULT NULL  AFTER `ask_date`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `gongje_no_chk` VARCHAR(1) DEFAULT NULL  AFTER `ask_time`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `first_date` VARCHAR(8) DEFAULT NULL  AFTER `gongje_no_chk`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `cancel_date` VARCHAR(8) DEFAULT NULL  AFTER `first_date`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `abroad` VARCHAR(1) DEFAULT NULL COMMENT '국내(A) / 해외(B) 사용 구분'  AFTER `cancel_date`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `van_created_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `abroad`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `van_edited_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `van_created_dt`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `created_by` INT(11) DEFAULT NULL  AFTER `van_edited_dt`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `created_dt` DATETIME DEFAULT NULL  AFTER `created_by`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `edited_dt` INT(11) DEFAULT NULL  AFTER `created_dt`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `edited_by` DATETIME DEFAULT NULL  AFTER `edited_dt`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `edited_action` VARCHAR(256) DEFAULT NULL  AFTER `edited_by`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `createdate` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `edited_action`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `createtime` VARCHAR(6) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `createdate`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `sett_date` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `createtime`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `org_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `sett_date`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `aqui_rate` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `org_coll`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `conversion_fee` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드'   AFTER `aqui_rate`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `auth_cd` VARCHAR(32) DEFAULT NULL  AFTER `conversion_fee`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `auth_nm` VARCHAR(128) DEFAULT NULL  AFTER `auth_cd`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `summary_cd` VARCHAR(32) DEFAULT NULL  AFTER `auth_nm`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `summary_nm` VARCHAR(128) DEFAULT NULL  AFTER `summary_cd`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `pjt_cd` VARCHAR(32) DEFAULT NULL  AFTER `summary_nm`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `pjt_nm` VARCHAR(128) DEFAULT NULL  AFTER `pjt_cd`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `detail` VARCHAR(100) DEFAULT NULL  AFTER `pjt_nm`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `if_m_id` VARCHAR(32) DEFAULT '''0''' COMMENT '외부연동 아이디'   AFTER `detail`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `if_d_id` VARCHAR(32) DEFAULT '''0''' COMMENT '외부연동 아이디'   AFTER `if_m_id`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `del_yn` VARCHAR(20) DEFAULT '''N''' COMMENT '삭제 처리 여부 ( Y / !Y )'    AFTER `if_d_id`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `app_div` VARCHAR(20) DEFAULT NULL  AFTER `del_yn`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `send_yn` VARCHAR(1) DEFAULT NULL COMMENT '결의 상신 구분 ( Y / !Y )'    AFTER `app_div`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `user_send_yn` VARCHAR(20) DEFAULT '''N''' COMMENT '관리자 마감 처리 구분 ( Y / !Y )'    AFTER `send_yn`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '사용자정보 시퀀스'  AFTER `user_send_yn`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `summary_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '표준적요정보 시퀀스'     AFTER `emp_seq`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `auth_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '증빙유형정보 시퀀스'     AFTER `summary_seq`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `project_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '프로젝트정보 시퀀스'     AFTER `auth_seq`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `budget_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '예산정보 시퀀스'   AFTER `project_seq`;
 ALTER TABLE `neos`.`t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `doc_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '전자결재 시퀀스' AFTER `budget_seq`;

 /* CREATE `neos`.`t_ex_card_public` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_card_public`(  
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `card_num` VARCHAR(30) NOT NULL COMMENT '카드번호',
  `org_div` VARCHAR(10) NOT NULL COMMENT '대상구분 ( C : 회사 / W : 사업장 / D : 부서 / U : 사용자 )',
  `org_id` INT(4) NOT NULL COMMENT '대상아이디',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자',
  `create_dt` DATETIME DEFAULT NULL COMMENT '작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_dt` DATETIME DEFAULT NULL COMMENT '수정일자'
);

/* ALTER `neos`.`t_ex_card_public` ADD COLUMN */
 ALTER TABLE `neos`.`t_ex_card_public` ADD COLUMN IF NOT EXISTS  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스';
 ALTER TABLE `neos`.`t_ex_card_public` ADD COLUMN IF NOT EXISTS  `card_num` VARCHAR(30) NOT NULL COMMENT '카드번호'  AFTER `comp_seq`;
 ALTER TABLE `neos`.`t_ex_card_public` ADD COLUMN IF NOT EXISTS  `org_div` VARCHAR(10) NOT NULL COMMENT '대상구분 ( C : 회사 / W : 사업장 / D : 부서 / U : 사용자 )'     AFTER `card_num`;
 ALTER TABLE `neos`.`t_ex_card_public` ADD COLUMN IF NOT EXISTS  `org_id` INT(4) NOT NULL COMMENT '대상아이디'  AFTER `org_div`;
 ALTER TABLE `neos`.`t_ex_card_public` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자'  AFTER `org_id`;
 ALTER TABLE `neos`.`t_ex_card_public` ADD COLUMN IF NOT EXISTS  `create_dt` DATETIME DEFAULT NULL COMMENT '작성일자'  AFTER `create_seq`;
 ALTER TABLE `neos`.`t_ex_card_public` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자'  AFTER `create_dt`;
 ALTER TABLE `neos`.`t_ex_card_public` ADD COLUMN IF NOT EXISTS  `modify_dt` DATETIME DEFAULT NULL COMMENT '수정일자'  AFTER `modify_seq`;
 
 /* CREATE `neos`.`t_ex_cms_sync` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_cms_sync`(  
  `comp_seq` VARCHAR(32) NOT NULL COMMENT 'CMS 연동 귀속 회사 시퀀스',
  `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부',
  `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부',
  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부',
  `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`)
);

/* ALTER `neos`.`t_ex_cms_sync` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS  `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부' AFTER `comp_seq`;
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS  `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부' AFTER `cms_sync_yn`;
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부' AFTER `cms_batch_yn`;
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자' AFTER `cms_process_yn`;
 
/* CREATE `neos`.`t_ex_etax_aq_tmp` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_etax_aq_tmp`(  
  `sync_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `iss_no` VARCHAR(32) DEFAULT NULL COMMENT '매입전자세금계산서 승인번호',
  `iss_dt` VARCHAR(8) DEFAULT NULL COMMENT '작성일자',
  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '공급자 사업자 등록번호',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사 시퀀스',
  `send_yn` VARCHAR(32) DEFAULT NULL COMMENT '상신여부',
  `note` VARCHAR(256) DEFAULT NULL COMMENT '적요',
  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 시퀀스',
  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 시퀀스',
  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 시퀀스',
  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 시퀀스',
  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 시퀀스',
  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 시퀀스',
  `if_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 키',
  `if_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 키',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`sync_id`),
  KEY `iss_no` (`iss_no`)
);

/* ALTER `neos`.`t_ex_etax_aq_tmp` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `iss_no` VARCHAR(32) DEFAULT NULL COMMENT '매입전자세금계산서 승인번호' AFTER `sync_id`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `iss_dt` VARCHAR(8) DEFAULT NULL COMMENT '작성일자' AFTER `iss_no`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '공급자 사업자 등록번호'  AFTER `iss_dt`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사 시퀀스'    AFTER `partner_no`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `send_yn` VARCHAR(32) DEFAULT NULL COMMENT '상신여부' AFTER `comp_seq`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `note` VARCHAR(256) DEFAULT NULL COMMENT '적요'   AFTER `send_yn`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 시퀀스'   AFTER `note`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 시퀀스'  AFTER `emp_seq`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 시퀀스'  AFTER `summary_seq`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 시퀀스'  AFTER `auth_seq`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 시퀀스'    AFTER `project_seq`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 시퀀스'    AFTER `card_seq`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `if_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 키'   AFTER `budget_seq`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `if_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 키'   AFTER `if_m_id`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자'  AFTER `if_d_id`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '생성일자' AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자'  AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자' AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_expend` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend`( 
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '귀속 회사 시퀀스',
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '전자결재 아이디',
  `form_seq` VARCHAR(32) DEFAULT NULL COMMENT '양식 시퀀스',
  `expend_stat_code` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 상태 코드',
  `expend_date` VARCHAR(8) DEFAULT NULL COMMENT '결의일자 ( 회계일자, 예산년월 )',
  `expend_req_date` VARCHAR(8) DEFAULT NULL COMMENT '지급요청일자 ( 만기일자 )',
  `erp_send_yn` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 전송 상태',
  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )',
  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )',
  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )',
  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )',
  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )',
  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )',
  `json_str` LONGTEXT COMMENT '지출결의 JSON 문자열',
  `erp_send_seq` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 ERP 전송자',
  `erp_send_date` DATETIME DEFAULT NULL COMMENT '지출결의 ERP 전송일',
  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU 자동전표 연동 아이디',
  `in_dt` VARCHAR(8) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 마스터 )',
  `in_sq` INT(11) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 디테일 )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`) 
);

/* ALTER `neos`.`t_ex_expend` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '귀속 회사 시퀀스' AFTER `expend_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '전자결재 아이디'  AFTER `comp_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `form_seq` VARCHAR(32) DEFAULT NULL COMMENT '양식 시퀀스'    AFTER `doc_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `expend_stat_code` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 상태 코드' AFTER `form_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `expend_date` VARCHAR(8) DEFAULT NULL COMMENT '결의일자 ( 회계일자 예산년월 )' AFTER `expend_stat_code`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `expend_req_date` VARCHAR(8) DEFAULT NULL COMMENT '지급요청일자 ( 만기일자 )'   AFTER `expend_date`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `erp_send_yn` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 전송 상태' AFTER `expend_req_date`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )'    AFTER `erp_send_yn`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )'    AFTER `write_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )' AFTER `emp_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )'   AFTER `budget_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )'    AFTER `project_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )' AFTER `partner_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 JSON 문자열'	  AFTER `card_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `erp_send_seq` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 ERP 전송자'  AFTER `json_str`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `erp_send_date` DATETIME DEFAULT NULL COMMENT '지출결의 ERP 전송일'  AFTER `erp_send_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU 자동전표 연동 아이디'    AFTER `erp_send_date`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `in_dt` VARCHAR(8) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 마스터 )' AFTER `row_id`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `in_sq` INT(11) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 디테일 )' AFTER `in_dt`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'    AFTER `in_sq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일'    AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'    AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일'    AFTER `modify_seq`;
 
/* CREATE `neos`.`t_ex_expend_auth` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_auth`(  
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 증빙유형 시퀀스',
  `auth_div` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )',
  `auth_code` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 코드',
  `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭',
  `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )',
  `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드',
  `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭',
  `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드',
  `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭',
  `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_code` VARBINARY(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '불공제구분 코드 ( ERP 정보 ERPiU )',
  `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '불공제구분 명칭 ( ERP 정보 ERPiU )',
  `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 iCUBE )',
  `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 iCUBE )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`seq`)
);

/* ALTER `neos`.`t_ex_expend_auth` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `auth_div` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )' AFTER `seq`;					
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `auth_code` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 코드'   AFTER `auth_div`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭'   AFTER `auth_code`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )'   AFTER `auth_name`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드' AFTER `cash_type`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭' AFTER `cr_acct_code`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드'    AFTER `cr_acct_name`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭'    AFTER `vat_acct_code`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )'    AFTER `vat_acct_name`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )'   AFTER `vat_type_code`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `erp_auth_code` VARBINARY(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )'   AFTER `vat_type_name`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )'   AFTER `erp_auth_code`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )' AFTER `erp_auth_name`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )'  AFTER `auth_required_yn`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )'   AFTER `partner_required_yn`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )' AFTER `card_required_yn`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )'   AFTER `project_required_yn`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '불공제구분 코드 ( ERP 정보 ERPiU )'    AFTER `note_required_yn`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '불공제구분 명칭 ( ERP 정보 ERPiU )'    AFTER `no_tax_code`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 iCUBE )' AFTER `no_tax_name`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 iCUBE )' AFTER `va_type_code`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'    AFTER `va_type_name`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자'   AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'    AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_auth` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자'   AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_expend_budget` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_budget`( 
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 예산정보 시퀀스',
  `budget_type` VARCHAR(32) DEFAULT NULL COMMENT '예산연동 구분 ( iCUBE 사용 : P / D )',
  `bud_ym` VARBINARY(32) DEFAULT NULL COMMENT '예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... )',
  `budget_ym` VARCHAR(8) DEFAULT NULL COMMENT '귀속 예산년월',
  `budget_gbn` VARCHAR(32) DEFAULT NULL COMMENT '예산통제구분 ( P / D >> iCUBE )',
  `budget_code` VARCHAR(32) DEFAULT NULL COMMENT '예산단위 코드',
  `budget_name` VARCHAR(128) DEFAULT NULL COMMENT '예산단위 명칭',
  `bizplan_code` VARCHAR(32) DEFAULT NULL COMMENT '사업계획 코드',
  `bizplan_name` VARCHAR(128) DEFAULT NULL COMMENT '사업계획 명칭',
  `bgacct_code` VARCHAR(32) DEFAULT NULL COMMENT '예산계정 코드',
  `bgacct_name` VARCHAR(128) DEFAULT NULL COMMENT '예산계정 명칭',
  `budget_jsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산집행 금액 ( 편성 + 조정 금액 )',
  `budget_actsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산 실행합 금액 ( 사용예산 금액 )',
  `budget_control_yn` VARCHAR(32) DEFAULT NULL COMMENT '예산 통제여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`) 
);

/* ALTER `neos`.`t_ex_expend_budget` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `budget_type` VARCHAR(32) DEFAULT NULL COMMENT '예산연동 구분 ( iCUBE 사용 : P / D )'AFTER `seq`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `bud_ym` VARBINARY(32) DEFAULT NULL COMMENT '예산년월 귀속 ( 1Q 2Q 3Q 4Q Y M .... )'  AFTER `budget_type`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `budget_ym` VARCHAR(8) DEFAULT NULL COMMENT '귀속 예산년월'  AFTER `bud_ym`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `budget_gbn` VARCHAR(32) DEFAULT NULL COMMENT '예산통제구분 ( P / D >> iCUBE )'  AFTER `budget_ym`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `budget_code` VARCHAR(32) DEFAULT NULL COMMENT '예산단위 코드'  AFTER `budget_gbn`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `budget_name` VARCHAR(128) DEFAULT NULL COMMENT '예산단위 명칭'  AFTER `budget_code`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `bizplan_code` VARCHAR(32) DEFAULT NULL COMMENT '사업계획 코드'  AFTER `budget_name`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `bizplan_name` VARCHAR(128) DEFAULT NULL COMMENT '사업계획 명칭'  AFTER `bizplan_code`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `bgacct_code` VARCHAR(32) DEFAULT NULL COMMENT '예산계정 코드'  AFTER `bizplan_name`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `bgacct_name` VARCHAR(128) DEFAULT NULL COMMENT '예산계정 명칭'  AFTER `bgacct_code`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `budget_jsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산집행 금액 ( 편성 + 조정 금액 )'AFTER `bgacct_name`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `budget_actsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산 실행합 금액 ( 사용예산 금액 )'AFTER `budget_jsum`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `budget_control_yn` VARCHAR(32) DEFAULT NULL COMMENT '예산 통제여부'  AFTER `budget_actsum`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자'   AFTER `budget_control_yn`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일자'  AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'   AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_budget` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자'  AFTER `modify_seq`;
 
/* CREATE `neos`.`t_ex_expend_card` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_card`(  
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 카드 시퀀스',
  `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드코드 ( iCUBE 는 카드코드 존재, ERPiU 는 카드코드 미존재하므로 카드번호로 대체 )',
  `card_num` VARCHAR(32) DEFAULT NULL COMMENT '카드 번호',
  `card_name` VARCHAR(128) DEFAULT NULL COMMENT '카드 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`),
  KEY `seq` (`seq`)
);

/* ALTER `neos`.`t_ex_expend_card` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_card` ADD COLUMN IF NOT EXISTS  `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드코드 ( iCUBE 는 카드코드 존재 ERPiU 는 카드코드 미존재하므로 카드번호로 대체 )'AFTER `seq`;
ALTER TABLE `neos`.`t_ex_expend_card` ADD COLUMN IF NOT EXISTS  `card_num` VARCHAR(32) DEFAULT NULL COMMENT '카드 번호'   AFTER `card_code`;
ALTER TABLE `neos`.`t_ex_expend_card` ADD COLUMN IF NOT EXISTS  `card_name` VARCHAR(128) DEFAULT NULL COMMENT '카드 명칭'   AFTER `card_num`;
ALTER TABLE `neos`.`t_ex_expend_card` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'  AFTER `card_name`;
ALTER TABLE `neos`.`t_ex_expend_card` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자' AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_card` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'  AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_card` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자' AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_expend_emp` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_emp`(  
  `seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '지출결의 사용자 정보 시퀀스',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사시퀀스',
  `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 회사 명칭',
  `erp_comp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 시퀀스',
  `erp_comp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회사 명칭',
  `biz_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사업장 시퀀스',
  `biz_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사업장 명칭',
  `erp_biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 시퀀스',
  `erp_biz_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사업장 명칭',
  `dept_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 부서 시퀀스',
  `dept_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 부서 명칭',
  `erp_dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 시퀀스',
  `erp_dept_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 부서 명칭',
  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사원 시퀀스',
  `erp_emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 시퀀스',
  `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사원 명',
  `erp_emp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사원 명',
  `erp_pc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회계단위 시퀀스',
  `erp_pc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회계단위 명칭',
  `erp_cc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 코스트센터 시퀀스',
  `erp_cc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 코스트센터 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`seq`)
);

/* ALTER `neos`.`t_ex_expend_emp` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사시퀀스' AFTER `seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 회사 명칭' AFTER `comp_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_comp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 시퀀스'   AFTER `comp_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_comp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회사 명칭' AFTER `erp_comp_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `biz_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사업장 시퀀스'  AFTER `erp_comp_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `biz_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사업장 명칭'   AFTER `biz_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 시퀀스'  AFTER `biz_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_biz_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사업장 명칭'   AFTER `erp_biz_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `dept_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 부서 시퀀스'   AFTER `erp_biz_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `dept_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 부서 명칭' AFTER `dept_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 시퀀스'   AFTER `dept_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_dept_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 부서 명칭' AFTER `erp_dept_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사원 시퀀스'   AFTER `erp_dept_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 시퀀스'   AFTER `emp_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사원 명' AFTER `erp_emp_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_emp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사원 명' AFTER `emp_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_pc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회계단위 시퀀스' AFTER `erp_emp_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_pc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회계단위 명칭'  AFTER `erp_pc_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_cc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 코스트센터 시퀀스' AFTER `erp_pc_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `erp_cc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 코스트센터 명칭' AFTER `erp_cc_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자'   AFTER `erp_cc_name`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일'   AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'   AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_emp` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일'   AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_expend_list` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_list`(  
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `list_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 시퀀스',
  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )',
  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )',
  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )',
  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )',
  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )',
  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )',
  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )',
  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )',
  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자',
  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요',
  `std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급가액',
  `tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '부가세액',
  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급대가',
  `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액',
  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액',
  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값',
  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디',
  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디',
  `json_str` LONGTEXT COMMENT '지출결의 항목 JSON 문자열',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`,`list_seq`),
  KEY `summary_seq` (`summary_seq`)
);

/* ALTER `neos`.`t_ex_expend_list` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )' AFTER `list_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )'   AFTER `summary_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )'    AFTER `auth_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )'    AFTER `write_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )' AFTER `emp_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )' AFTER `budget_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )'   AFTER `project_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )' AFTER `partner_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자' AFTER `card_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요'   AFTER `auth_date`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급가액' AFTER `note`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '부가세액' AFTER `std_amt`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급대가' AFTER `tax_amt`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액'    AFTER `amt`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액'   AFTER `sub_std_amt`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값'    AFTER `sub_tax_amt`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디' AFTER `interface_type`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디' AFTER `interface_m_id`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 항목 JSON 문자열'    AFTER `interface_d_id`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'    AFTER `json_str`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일'    AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'    AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_list` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일'    AFTER `modify_seq`;
 
/* CREATE `neos`.`t_ex_expend_mng` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_mng`(  
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `list_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 시퀀스',
  `slip_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 분개 시퀀스',
  `mng_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 분개 관리항목 시퀀스',
  `mng_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 코드',
  `mng_name` VARCHAR(40) DEFAULT NULL COMMENT '관리항목 명',
  `mng_form_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 표현 형태 ( ERPiU )',
  `mng_child_yn` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 하위 코드 존재 여부 ( ERPiU )',
  `mng_stat` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 필수 여부 ( iCUBE, ERPiU )',
  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '사용자 입력 관리항목 코드',
  `ctd_name` VARCHAR(100) DEFAULT NULL COMMENT '사용자 입력 관리항목 명칭',
  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 관리항목 JSON 문자열',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`,`list_seq`,`slip_seq`,`mng_seq`)
);

/* ALTER `neos`.`t_ex_expend_mng` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `mng_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 코드' AFTER `mng_seq`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `mng_name` VARCHAR(40) DEFAULT NULL COMMENT '관리항목 명'  AFTER `mng_code`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `mng_form_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 표현 형태 ( ERPiU )' AFTER `mng_name`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `mng_child_yn` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 하위 코드 존재 여부 ( ERPiU )' AFTER `mng_form_code`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `mng_stat` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 필수 여부 ( iCUBE ERPiU )' AFTER `mng_child_yn`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '사용자 입력 관리항목 코드'  AFTER `mng_stat`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `ctd_name` VARCHAR(100) DEFAULT NULL COMMENT '사용자 입력 관리항목 명칭'  AFTER `ctd_code`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 관리항목 JSON 문자열'  AFTER `ctd_name`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'    AFTER `json_str`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일'    AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'    AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_mng` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일'    AFTER `modify_seq`;
 
/* CREATE `neos`.`t_ex_expend_partner` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_partner`(  
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 거래처 시퀀스',
  `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처 코드',
  `partner_name` VARCHAR(128) DEFAULT NULL COMMENT '거래처 명칭',
  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '사업자 등록 번호',
  `partner_fg` VARCHAR(32) DEFAULT NULL COMMENT '거래처 종류',
  `ceo_name` VARCHAR(128) DEFAULT NULL COMMENT '대표자명',
  `job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '업태',
  `cls_job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '종목',
  `deposit_no` VARCHAR(64) DEFAULT NULL COMMENT '계좌번호',
  `bank_code` VARCHAR(32) DEFAULT NULL COMMENT '은행코드',
  `partner_emp_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자',
  `partner_hp_emp_no` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자연락처',
  `deposit_name` VARCHAR(64) DEFAULT NULL COMMENT '예금주',
  `deposit_convert` VARCHAR(128) DEFAULT NULL COMMENT '관리항목',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
);

/* ALTER `neos`.`t_ex_expend_partner` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처 코드'AFTER `seq`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `partner_name` VARCHAR(128) DEFAULT NULL COMMENT '거래처 명칭'   AFTER `partner_code`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '사업자 등록 번호' AFTER `partner_name`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `partner_fg` VARCHAR(32) DEFAULT NULL COMMENT '거래처 종류'   AFTER `partner_no`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `ceo_name` VARCHAR(128) DEFAULT NULL COMMENT '대표자명'AFTER `partner_fg`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '업태'  AFTER `ceo_name`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `cls_job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '종목'  AFTER `job_gbn`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `deposit_no` VARCHAR(64) DEFAULT NULL COMMENT '계좌번호'AFTER `cls_job_gbn`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `bank_code` VARCHAR(32) DEFAULT NULL COMMENT '은행코드'AFTER `deposit_no`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `partner_emp_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자'  AFTER `bank_code`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `partner_hp_emp_no` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자연락처' AFTER `partner_emp_code`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `deposit_name` VARCHAR(64) DEFAULT NULL COMMENT '예금주' AFTER `partner_hp_emp_no`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `deposit_convert` VARCHAR(128) DEFAULT NULL COMMENT '관리항목'AFTER `deposit_name`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'   AFTER `deposit_convert`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자'  AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'   AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_partner` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자'  AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_expend_project` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_project`( 
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 프로젝트 시퀀스',
  `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드',
  `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`) 
);

/* ALTER `neos`.`t_ex_expend_project` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_project` ADD COLUMN IF NOT EXISTS  `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드'AFTER `seq`;
ALTER TABLE `neos`.`t_ex_expend_project` ADD COLUMN IF NOT EXISTS  `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭'  AFTER `project_code`;
ALTER TABLE `neos`.`t_ex_expend_project` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'   AFTER `project_name`;
ALTER TABLE `neos`.`t_ex_expend_project` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자'  AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_project` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'   AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_project` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자'  AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_expend_slip` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_slip`(  
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `list_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 시퀀스',
  `slip_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 분개 시퀀스',
  `summary_seq` VARCHAR(32) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )',
  `auth_seq` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )',
  `write_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )',
  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )',
  `budget_seq` VARCHAR(32) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )',
  `project_seq` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )',
  `partner_seq` VARCHAR(32) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )',
  `card_seq` VARCHAR(32) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )',
  `drcr_gbn` VARCHAR(32) DEFAULT NULL COMMENT '차변, 대변 구분값',
  `acct_code` VARCHAR(64) DEFAULT NULL COMMENT '계정과목 코드',
  `acct_name` VARCHAR(128) DEFAULT NULL COMMENT '계정과목 명칭',
  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자',
  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요',
  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '금액',
  `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액',
  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액',
  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값',
  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디',
  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디',
  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KYE 1',
  `row_no` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KEY 2',
  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 JSON 문자열',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`,`list_seq`,`slip_seq`)
);

/* ALTER `neos`.`t_ex_expend_slip` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `summary_seq` VARCHAR(32) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )' AFTER `slip_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `auth_seq` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )'    AFTER `summary_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `write_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )' AFTER `auth_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )' AFTER `write_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `budget_seq` VARCHAR(32) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )'  AFTER `emp_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `project_seq` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )' AFTER `budget_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `partner_seq` VARCHAR(32) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )' AFTER `project_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `card_seq` VARCHAR(32) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )'  AFTER `partner_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `drcr_gbn` VARCHAR(32) DEFAULT NULL COMMENT '차변 대변 구분값'   AFTER `card_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `acct_code` VARCHAR(64) DEFAULT NULL COMMENT '계정과목 코드'    AFTER `drcr_gbn`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `acct_name` VARCHAR(128) DEFAULT NULL COMMENT '계정과목 명칭'    AFTER `acct_code`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자'  AFTER `acct_name`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `note` VARCHAR(100) DEFAULT NULL COMMENT '적요'    AFTER `auth_date`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '금액'    AFTER `note`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액' AFTER `amt`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액'    AFTER `sub_std_amt`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값' AFTER `sub_tax_amt`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디'  AFTER `interface_type`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디'  AFTER `interface_m_id`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KYE 1'  AFTER `interface_d_id`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `row_no` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KEY 2'  AFTER `row_id`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 항목 분개 JSON 문자열'   AFTER `row_no`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자' AFTER `json_str`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일' AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자' AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일' AFTER `modify_seq`;
 
/* CREATE `neos`.`t_ex_expend_summary` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_summary`( 
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '분개정보 시퀀스',
  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )',
  `summary_code` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 코드',
  `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭',
  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 계정과목 코드',
  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭',
  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드',
  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 게정과목 명칭',
  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드',
  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명칭',
  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드',
  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융거래처 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`) 
);

/* ALTER `neos`.`t_ex_expend_summary` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )'AFTER `seq`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `summary_code` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 코드'   AFTER `summary_div`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭'   AFTER `summary_code`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 계정과목 코드' AFTER `summary_name`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭' AFTER `dr_acct_code`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드' AFTER `dr_acct_name`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 게정과목 명칭' AFTER `cr_acct_code`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드'AFTER `cr_acct_name`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명칭'AFTER `vat_acct_code`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드'  AFTER `vat_acct_name`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융거래처 명칭'  AFTER `bank_partner_code`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'AFTER `bank_partner_name`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자'   AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_summary` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자'   AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_expend_vat` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_expend_vat`( 
  `ex_gb` VARCHAR(10) NOT NULL COMMENT '전표/분개 구분값',
  `ex_vat_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '부가세정보 고유키',
  `vat_type_code` INT(11) DEFAULT NULL COMMENT '부가세구분 그룹웨어 코드 ( ERP IU / ICUBE )',
  `vat_type_name` VARCHAR(100) DEFAULT NULL COMMENT '부가세구분 그룹웨어 명 ( ERP IU / ICUBE )',
  `va_type_code` INT(11) DEFAULT NULL,
  `va_type_name` VARCHAR(100) DEFAULT NULL,
  `mutual_code` VARCHAR(20) DEFAULT NULL COMMENT '불공제/사유 ERP 코드 ( ERP IU / ICUBE )',
  `mutual_name` VARCHAR(100) DEFAULT NULL COMMENT '불공제/사유 ERP 명 ( ERP IU / ICUBE )',
  `iss_yn` VARCHAR(20) DEFAULT NULL COMMENT '전자세금계산서 여부 ERP 코드 ( ERP IU : 종이세금계산서 ( 0 ), 전자세금계산서 ( 2 ) / ICUBE )',
  `jeonjasend_yn` VARCHAR(20) DEFAULT NULL COMMENT '국세청전송11일이내 여부 ERP 코드 ( ERP IU : 전송 ( 0 ), 미전송 ( 1 ) / ICUBE )',
  `tex_md` VARCHAR(4) DEFAULT NULL COMMENT '품목정보 월/일 ( ERP IU )',
  `item_name` VARCHAR(50) DEFAULT NULL COMMENT '품목정보 품명 ( ERP IU )',
  `size_name` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 규격 ( ERP IU )',
  `tax_qt` DECIMAL(17,4) DEFAULT NULL COMMENT '품목정보 수량 ( ERP IU )',
  `prc_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 단가 ( ERP IU )',
  `supply_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 공급가액 ( ERP IU )',
  `tax_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 부가세액 ( ERP IU )',
  `note_nm` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 비고 ( ERP IU )',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부',
  `create_user_seq` INT(11) DEFAULT NULL COMMENT '작성자 그룹웨어 아이디',
  `create_date` DATETIME DEFAULT NULL COMMENT '작성일자',
  `modify_user_seq` INT(11) DEFAULT NULL COMMENT '수정자 그룹웨어 아이디',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`ex_gb`,`ex_vat_seq`),
  KEY `ex_vat_seq` (`ex_vat_seq`) 
);

/* ALTER `neos`.`t_ex_expend_vat` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `vat_type_code` INT(11) DEFAULT NULL COMMENT '부가세구분 그룹웨어 코드 ( ERP IU / ICUBE )' AFTER `ex_vat_seq`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `vat_type_name` VARCHAR(100) DEFAULT NULL COMMENT '부가세구분 그룹웨어 명 ( ERP IU / ICUBE )'   AFTER `vat_type_code`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `va_type_code` INT(11) DEFAULT NULL AFTER `vat_type_name`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `va_type_name` VARCHAR(100) DEFAULT NULL AFTER `va_type_code`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `mutual_code` VARCHAR(20) DEFAULT NULL COMMENT '불공제/사유 ERP 코드 ( ERP IU / ICUBE )'  AFTER `va_type_name`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `mutual_name` VARCHAR(100) DEFAULT NULL COMMENT '불공제/사유 ERP 명 ( ERP IU / ICUBE )'   AFTER `mutual_code`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `iss_yn` VARCHAR(20) DEFAULT NULL COMMENT '전자세금계산서 여부 ERP 코드 ( ERP IU : 종이세금계산서 ( 0 ) 전자세금계산서 ( 2 ) / ICUBE )'  AFTER `mutual_name`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `jeonjasend_yn` VARCHAR(20) DEFAULT NULL COMMENT '국세청전송11일이내 여부 ERP 코드 ( ERP IU : 전송 ( 0 ) 미전송 ( 1 ) / ICUBE )'    AFTER `iss_yn`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `tex_md` VARCHAR(4) DEFAULT NULL COMMENT '품목정보 월/일 ( ERP IU )'   AFTER `jeonjasend_yn`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `item_name` VARCHAR(50) DEFAULT NULL COMMENT '품목정보 품명 ( ERP IU )'   AFTER `tex_md`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `size_name` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 규격 ( ERP IU )'   AFTER `item_name`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `tax_qt` DECIMAL(17,4) DEFAULT NULL COMMENT '품목정보 수량 ( ERP IU )'   AFTER `size_name`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `prc_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 단가 ( ERP IU )'   AFTER `tax_qt`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `supply_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 공급가액 ( ERP IU )' AFTER `prc_am`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `tax_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 부가세액 ( ERP IU )' AFTER `supply_am`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `note_nm` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 비고 ( ERP IU )'   AFTER `tax_am`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부' AFTER `note_nm`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `create_user_seq` INT(11) DEFAULT NULL COMMENT '작성자 그룹웨어 아이디'   AFTER `use_yn`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '작성일자' AFTER `create_user_seq`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `modify_user_seq` INT(11) DEFAULT NULL COMMENT '수정자 그룹웨어 아이디'   AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_expend_vat` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자' AFTER `modify_user_seq`;

/* CREATE `neos`.`t_ex_item` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_item`(  
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '귀속 회사 시퀀스',
  `form_seq` VARCHAR(32) NOT NULL COMMENT '귀속 전자결재 양식 시퀀스',
  `item_gbn` VARCHAR(100) NOT NULL COMMENT '표현 위치 구분',
  `langpack_code` VARCHAR(100) NOT NULL COMMENT '코드',
  `langpack_name` VARCHAR(100) DEFAULT NULL COMMENT '명칭',
  `order_num` INT(11) DEFAULT NULL COMMENT '정렬 순서',
  `display_align` VARCHAR(10) DEFAULT NULL COMMENT '정렬 표현 방법',
  `head_code` VARCHAR(100) DEFAULT NULL COMMENT '그리드 헤더 키',
  `select_yn` VARCHAR(1) DEFAULT NULL COMMENT '기본키 여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`comp_seq`,`form_seq`,`item_gbn`,`langpack_code`)
);

/* ALTER `neos`.`t_ex_item` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_item` ADD COLUMN IF NOT EXISTS `langpack_name` VARCHAR(100) DEFAULT NULL COMMENT '명칭' AFTER `langpack_code`;
ALTER TABLE `neos`.`t_ex_item` ADD COLUMN IF NOT EXISTS `order_num` INT(11) DEFAULT NULL COMMENT '정렬 순서' AFTER `langpack_name`;
ALTER TABLE `neos`.`t_ex_item` ADD COLUMN IF NOT EXISTS `display_align` VARCHAR(10) DEFAULT NULL COMMENT '정렬 표현 방법' AFTER `order_num`;
ALTER TABLE `neos`.`t_ex_item` ADD COLUMN IF NOT EXISTS `head_code` VARCHAR(100) DEFAULT NULL COMMENT '그리드 헤더 키'   AFTER `display_align`;
ALTER TABLE `neos`.`t_ex_item` ADD COLUMN IF NOT EXISTS `select_yn` VARCHAR(1) DEFAULT NULL COMMENT '기본키 여부'    AFTER `head_code`;
ALTER TABLE `neos`.`t_ex_item` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자'    AFTER `select_yn`;
ALTER TABLE `neos`.`t_ex_item` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일'    AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_item` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'    AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_item` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일'    AFTER `modify_seq`;
 
/* CREATE `neos`.`t_ex_langpack` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_langpack`(  
  `comp_seq` INT(11) NOT NULL COMMENT '회사시퀀스',
  `langpack_code` VARCHAR(100) NOT NULL COMMENT '명칭코드',
  `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름',
  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`langpack_code`)
);

/* ALTER `neos`.`t_ex_langpack` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_langpack` ADD COLUMN IF NOT EXISTS `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름' AFTER `langpack_code`;
ALTER TABLE `neos`.`t_ex_langpack` ADD COLUMN IF NOT EXISTS `create_seq` INT(11) DEFAULT NULL COMMENT '생성자' AFTER `langpack_name`;
ALTER TABLE `neos`.`t_ex_langpack` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '생성일' AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_langpack` ADD COLUMN IF NOT EXISTS `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자' AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_langpack` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일' AFTER `modify_seq`;
 
/* CREATE `neos`.`t_ex_langpack_multi` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_langpack_multi`(  
  `comp_seq` INT(11) NOT NULL COMMENT '회사시퀀스',
  `langpack_code` VARCHAR(100) NOT NULL COMMENT '명칭코드',
  `lang_code` VARCHAR(4) NOT NULL COMMENT '언어코드',
  `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름',
  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`langpack_code`,`lang_code`)
);

/* ALTER `neos`.`t_ex_langpack_multi` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_langpack_multi` ADD COLUMN IF NOT EXISTS `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름' AFTER `lang_code`;
ALTER TABLE `neos`.`t_ex_langpack_multi` ADD COLUMN IF NOT EXISTS `create_seq` INT(11) DEFAULT NULL COMMENT '생성자' AFTER `langpack_name`;
ALTER TABLE `neos`.`t_ex_langpack_multi` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '생성일' AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_langpack_multi` ADD COLUMN IF NOT EXISTS `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자' AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_langpack_multi` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일' AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_mng_option` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_mng_option`(  
  `comp_seq` INT(11) NOT NULL COMMENT '회사시퀀스',
  `form_seq` INT(11) NOT NULL COMMENT '양식코드',
  `drcr_gbn` VARCHAR(20) NOT NULL COMMENT '관리항목구분',
  `mng_code` VARCHAR(20) NOT NULL COMMENT '관리항목코드',
  `mng_name` VARCHAR(100) DEFAULT NULL COMMENT '관리항목명',
  `use_gbn` VARCHAR(20) DEFAULT NULL COMMENT '사용구분',
  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력코드',
  `ctd_name` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력명',
  `note` VARCHAR(512) DEFAULT NULL COMMENT '비고 ( 툴팁활용 )',
  `cust_set` VARCHAR(4000) DEFAULT NULL COMMENT '커스터마이징을 위한 컬럼',
  `cust_set_target` VARCHAR(32) DEFAULT NULL COMMENT '조회 대상 ( BizboxA, iCUBE, ERPiU )',
  `modify_yn` VARCHAR(32) DEFAULT NULL COMMENT '수정가능 여부 ( 전용개발인 경우, 사용자에 의한 삭제 및 수정이 불가해야 함 )',
  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`form_seq`,`drcr_gbn`,`mng_code`)
);

/* ALTER `neos`.`t_ex_mng_option` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `mng_name` VARCHAR(100) DEFAULT NULL COMMENT '관리항목명' AFTER `mng_code`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `use_gbn` VARCHAR(20) DEFAULT NULL COMMENT '사용구분' AFTER `mng_name`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력코드'  AFTER `use_gbn`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `ctd_name` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력명'   AFTER `ctd_code`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `note` VARCHAR(512) DEFAULT NULL COMMENT '비고 ( 툴팁활용 )'   AFTER `ctd_name`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `cust_set` VARCHAR(4000) DEFAULT NULL COMMENT '커스터마이징을 위한 컬럼'  AFTER `note`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `cust_set_target` VARCHAR(32) DEFAULT NULL COMMENT '조회 대상 ( BizboxA iCUBE ERPiU )' AFTER `cust_set`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `modify_yn` VARCHAR(32) DEFAULT NULL COMMENT '수정가능 여부 ( 전용개발인 경우 사용자에 의한 삭제 및 수정이 불가해야 함 )'   AFTER `cust_set_target`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `create_seq` INT(11) DEFAULT NULL COMMENT '생성자'  AFTER `modify_yn`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '생성일'  AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자'  AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_mng_option` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일'  AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_option` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_option`(  
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 회사시퀀스 ( 기본 0 )',
  `form_seq` INT(11) NOT NULL COMMENT '옵션 귀속 양식코드 ( 기본 0 )',
  `option_gbn` VARCHAR(32) NOT NULL COMMENT '옵션 구분 코드',
  `option_code` VARCHAR(32) NOT NULL COMMENT '옵션 상세 코드',
  `use_sw` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 연동 시스템',
  `order_num` DECIMAL(65,0) DEFAULT NULL COMMENT '정렬순서',
  `common_code` VARCHAR(32) DEFAULT NULL COMMENT '공통코드',
  `base_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 기본 설정 코드',
  `base_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 명칭',
  `base_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 사용자 정의',
  `set_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 설정 코드',
  `set_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 명칭',
  `set_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 사용자 정의',
  `option_select_type` VARCHAR(32) DEFAULT NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )',
  `option_process_type` VARCHAR(32) DEFAULT NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )',
  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`,`form_seq`,`option_gbn`,`option_code`,`use_sw`)
);

/* ALTER `neos`.`t_ex_option` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `order_num` DECIMAL(65,0) DEFAULT NULL COMMENT '정렬순서' AFTER `use_sw`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `common_code` VARCHAR(32) DEFAULT NULL COMMENT '공통코드' AFTER `order_num`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `base_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 기본 설정 코드' AFTER `common_code`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `base_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 명칭' AFTER `base_value`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `base_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 사용자 정의'  AFTER `base_name`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `set_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 설정 코드'   AFTER `base_emp_value`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `set_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 명칭'   AFTER `set_value`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `set_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 사용자 정의'    AFTER `set_name`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `option_select_type` VARCHAR(32) DEFAULT NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )'   AFTER `set_emp_value`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `option_process_type` VARCHAR(32) DEFAULT NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )' AFTER `option_select_type`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부' AFTER `option_process_type`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'    AFTER `use_yn`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자'   AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'    AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_option` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자'   AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_option_multi` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_option_multi`(  
  `option_gbn` VARCHAR(32) NOT NULL COMMENT '옵션 구분 코드',
  `option_code` VARCHAR(32) NOT NULL COMMENT '옵션 상세 코드',
  `use_sw` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 연동 시스템',
  `lang_code` VARCHAR(32) NOT NULL COMMENT '연동 언어 코드',
  `option_name` VARCHAR(512) DEFAULT NULL COMMENT '옵션 명칭',
  `option_note` VARCHAR(1024) DEFAULT NULL COMMENT '옵션 설명',
  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`option_gbn`,`option_code`,`use_sw`,`lang_code`)
);

/* ALTER `neos`.`t_ex_option_multi` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_option_multi` ADD COLUMN IF NOT EXISTS `option_name` VARCHAR(512) DEFAULT NULL COMMENT '옵션 명칭' AFTER `lang_code`;
ALTER TABLE `neos`.`t_ex_option_multi` ADD COLUMN IF NOT EXISTS `option_note` VARCHAR(1024) DEFAULT NULL COMMENT '옵션 설명' AFTER `option_name`;
ALTER TABLE `neos`.`t_ex_option_multi` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부' AFTER `option_note`;
ALTER TABLE `neos`.`t_ex_option_multi` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'   AFTER `use_yn`;
ALTER TABLE `neos`.`t_ex_option_multi` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자'  AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_option_multi` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'   AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_option_multi` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자'  AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_summary` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_summary`(  
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `summary_code` VARCHAR(20) NOT NULL COMMENT '표준적요 코드',
  `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭',
  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )',
  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 게정과목 코드',
  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭',
  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드',
  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 계정과목 명칭',
  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드',
  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명',
  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융 거래처 코드',
  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융 거래처 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최총 수정 일자',
  PRIMARY KEY (`comp_seq`,`summary_code`)
);

/* ALTER `neos`.`t_ex_summary` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭' AFTER `summary_code`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )'   AFTER `summary_name`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 게정과목 코드' AFTER `summary_div`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭' AFTER `dr_acct_code`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드' AFTER `dr_acct_name`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 계정과목 명칭' AFTER `cr_acct_code`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드'    AFTER `cr_acct_name`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명' AFTER `vat_acct_code`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융 거래처 코드'  AFTER `vat_acct_name`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융 거래처 명칭'  AFTER `bank_partner_code`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자'    AFTER `bank_partner_name`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자'   AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자'    AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_summary` ADD COLUMN IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최총 수정 일자'   AFTER `modify_seq`;

/* CREATE `neos`.`t_ex_vat` */
CREATE TABLE IF NOT EXISTS `neos`.`t_ex_vat`(  
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `vat_code` VARCHAR(20) NOT NULL COMMENT '세무구분 코드',
  `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`comp_seq`,`vat_code`)
);

/* ALTER `neos`.`t_ex_vat` ADD COLUMN */
ALTER TABLE `neos`.`t_ex_vat` ADD COLUMN IF NOT EXISTS  `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭' AFTER `vat_code`;
ALTER TABLE `neos`.`t_ex_vat` ADD COLUMN IF NOT EXISTS  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부'   AFTER `vat_name`;
ALTER TABLE `neos`.`t_ex_vat` ADD COLUMN IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자' AFTER `use_yn`;
ALTER TABLE `neos`.`t_ex_vat` ADD COLUMN IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자' AFTER `create_seq`;
ALTER TABLE `neos`.`t_ex_vat` ADD COLUMN IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자' AFTER `create_date`;
ALTER TABLE `neos`.`t_ex_vat` ADD COLUMN IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자' AFTER `modify_seq`;

/* 2016. 11. 28. */
/* 2016. 11. 28. - 김상겸 */
/* 2016. 11. 28. - 김상겸 - G20 연동 개발 */
/* CREATE `neos`.`g20_abdocu_h` */
CREATE TABLE IF NOT EXISTS `neos`.`g20_abdocu_h` (
  `abdocu_no` BIGINT(38) NOT NULL,
  `c_dikeycode` VARCHAR(32) DEFAULT NULL,
  `sanction_no` VARCHAR(100) DEFAULT NULL,
  `docu_mode` INT(38) DEFAULT NULL,
  `abdocu_no_reffer` BIGINT(38) DEFAULT '0',
  `sessionid` VARCHAR(100) DEFAULT NULL,
  `mgt_cd` VARCHAR(10) DEFAULT NULL,
  `mgt_nm` VARCHAR(1000) DEFAULT NULL,
  `docu_fg` VARCHAR(1) DEFAULT NULL,
  `docu_fg_text` VARCHAR(100) DEFAULT NULL,
  `rmk_dc` VARCHAR(100) DEFAULT NULL,
  `erp_co_cd` VARCHAR(4) DEFAULT NULL,
  `erp_gisu_dt` VARCHAR(8) DEFAULT NULL,
  `erp_gisu_sq` INT(38) DEFAULT '0',
  `erp_emp_cd` VARCHAR(10) DEFAULT NULL,
  `erp_emp_nm` VARCHAR(100) DEFAULT NULL,
  `erp_div_cd` VARCHAR(4) DEFAULT NULL,
  `erp_div_nm` VARCHAR(100) DEFAULT NULL,
  `erp_dept_cd` VARCHAR(4) DEFAULT NULL,
  `erp_dept_nm` VARCHAR(100) DEFAULT NULL,
  `erp_gisu` INT(38) DEFAULT NULL,
  `erp_gisu_from_dt` VARCHAR(8) DEFAULT NULL,
  `erp_gisu_to_dt` VARCHAR(8) DEFAULT NULL,
  `erp_year` VARCHAR(4) DEFAULT NULL,
  `btr_cd` VARCHAR(10) DEFAULT NULL,
  `btr_nm` VARCHAR(100) DEFAULT NULL,
  `bottom_cd` VARCHAR(10) DEFAULT NULL,
  `bottom_nm` VARCHAR(100) DEFAULT NULL,
  `edit_proc` INT(38) DEFAULT '100',
  `insert_id` VARCHAR(100) DEFAULT NULL,
  `insert_dt` DATE DEFAULT NULL,
  `modify_id` VARCHAR(100) DEFAULT NULL,
  `modify_dt` DATE DEFAULT NULL,
  `btr_nb` VARCHAR(50) DEFAULT NULL,
  `cause_dt` VARCHAR(8) DEFAULT NULL,
  `sign_dt` VARCHAR(8) DEFAULT NULL,
  `inspect_dt` VARCHAR(8) DEFAULT NULL,
  `cause_id` VARCHAR(10) DEFAULT NULL,
  `cause_nm` VARCHAR(40) DEFAULT NULL,
  `complete_yn` CHAR(1) DEFAULT NULL,
  `hc_nm` VARCHAR(100) DEFAULT NULL,
  `hc_cd` VARCHAR(100) DEFAULT NULL,
  `it_businesslink` VARCHAR(10) DEFAULT NULL,
  `support_money` VARCHAR(10) DEFAULT NULL,
  `kulsudancheckcardyn` VARCHAR(10) DEFAULT NULL,
  `erp_co_nm` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`abdocu_no`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`g20_abdocu_h` ADD COLUMN */
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `c_dikeycode` VARCHAR(32) DEFAULT NULL AFTER `abdocu_no`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `sanction_no` VARCHAR(100) DEFAULT NULL AFTER `c_dikeycode`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `docu_mode` INT(38) DEFAULT NULL AFTER `sanction_no`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `abdocu_no_reffer` BIGINT(38) DEFAULT '0' AFTER `docu_mode`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL AFTER `abdocu_no_reffer`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `mgt_cd` VARCHAR(10) DEFAULT NULL AFTER `sessionid`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `mgt_nm` VARCHAR(1000) DEFAULT NULL AFTER `mgt_cd`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `docu_fg` VARCHAR(1) DEFAULT NULL AFTER `mgt_nm`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `docu_fg_text` VARCHAR(100) DEFAULT NULL AFTER `docu_fg`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `rmk_dc` VARCHAR(100) DEFAULT NULL AFTER `docu_fg_text`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL AFTER `rmk_dc`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu_dt` VARCHAR(8) DEFAULT NULL AFTER `erp_co_cd`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` INT(38) DEFAULT '0' AFTER `erp_gisu_dt`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_emp_cd` VARCHAR(10) DEFAULT NULL AFTER `erp_gisu_sq`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_emp_nm` VARCHAR(100) DEFAULT NULL AFTER `erp_emp_cd`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_div_cd` VARCHAR(4) DEFAULT NULL AFTER `erp_emp_nm`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_div_nm` VARCHAR(100) DEFAULT NULL AFTER `erp_div_cd`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_dept_cd` VARCHAR(4) DEFAULT NULL AFTER `erp_div_nm`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_dept_nm` VARCHAR(100) DEFAULT NULL AFTER `erp_dept_cd`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu` INT(38) DEFAULT NULL AFTER `erp_dept_nm`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu_from_dt` VARCHAR(8) DEFAULT NULL AFTER `erp_gisu`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu_to_dt` VARCHAR(8) DEFAULT NULL AFTER `erp_gisu_from_dt`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_year` VARCHAR(4) DEFAULT NULL AFTER `erp_gisu_to_dt`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `btr_cd` VARCHAR(10) DEFAULT NULL AFTER `erp_year`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `btr_nm` VARCHAR(100) DEFAULT NULL AFTER `btr_cd`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `bottom_cd` VARCHAR(10) DEFAULT NULL AFTER `btr_nm`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `bottom_nm` VARCHAR(100) DEFAULT NULL AFTER `bottom_cd`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `edit_proc` INT(38) DEFAULT '100' AFTER `bottom_nm`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(100) DEFAULT NULL AFTER `edit_proc`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `insert_dt` DATE DEFAULT NULL AFTER `insert_id`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL AFTER `insert_dt`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `modify_dt` DATE DEFAULT NULL AFTER `modify_id`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `btr_nb` VARCHAR(50) DEFAULT NULL AFTER `modify_dt`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `cause_dt` VARCHAR(8) DEFAULT NULL AFTER `btr_nb`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `sign_dt` VARCHAR(8) DEFAULT NULL AFTER `cause_dt`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `inspect_dt` VARCHAR(8) DEFAULT NULL AFTER `sign_dt`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `cause_id` VARCHAR(10) DEFAULT NULL AFTER `inspect_dt`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `cause_nm` VARCHAR(40) DEFAULT NULL AFTER `cause_id`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `complete_yn` CHAR(1) DEFAULT NULL AFTER `cause_nm`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `hc_nm` VARCHAR(100) DEFAULT NULL AFTER `complete_yn`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `hc_cd` VARCHAR(100) DEFAULT NULL AFTER `hc_nm`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `it_businesslink` VARCHAR(10) DEFAULT NULL AFTER `hc_cd`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `support_money` VARCHAR(10) DEFAULT NULL AFTER `it_businesslink`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `kulsudancheckcardyn` VARCHAR(10) DEFAULT NULL AFTER `support_money`;
ALTER TABLE `neos`.`g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_co_nm` VARCHAR(100) DEFAULT NULL AFTER `kulsudancheckcardyn`;

/* CREATE `neos`.`g20_abdocu_b` */
CREATE TABLE IF NOT EXISTS `neos`.`g20_abdocu_b` (
  `abdocu_b_no` bigint(38) NOT NULL,
  `abdocu_no` bigint(38) DEFAULT NULL,
  `docu_mode` int(38) DEFAULT NULL,
  `abdocu_no_reffer` bigint(38) DEFAULT NULL,
  `erp_co_cd` varchar(4) NOT NULL,
  `erp_gisu_dt` varchar(8) DEFAULT NULL,
  `erp_gisu_sq` int(38) DEFAULT NULL,
  `erp_bq_sq` int(38) DEFAULT NULL,
  `erp_bk_sq` int(5) DEFAULT NULL,
  `erp_bgt_nm1` varchar(50) DEFAULT NULL,
  `erp_bgt_nm2` varchar(50) DEFAULT NULL,
  `erp_bgt_nm3` varchar(50) DEFAULT NULL,
  `erp_bgt_nm4` varchar(50) DEFAULT NULL,
  `open_am` int(19) DEFAULT NULL,
  `apply_am` int(19) DEFAULT NULL,
  `left_am` int(19) DEFAULT NULL,
  `abgt_cd` varchar(10) DEFAULT NULL,
  `abgt_nm` varchar(40) DEFAULT NULL,
  `set_fg` varchar(1) DEFAULT NULL,
  `vat_fg` varchar(1) DEFAULT NULL,
  `tr_fg` varchar(1) DEFAULT NULL,
  `div_cd2` varchar(4) DEFAULT NULL,
  `div_nm2` varchar(20) DEFAULT NULL,
  `ctl_fg` varchar(1) DEFAULT NULL,
  `insert_id` varchar(100) DEFAULT NULL,
  `insert_dt` date DEFAULT NULL,
  `modify_id` varchar(100) DEFAULT NULL,
  `modify_dt` date DEFAULT NULL,
  `sessionid` varchar(50) DEFAULT NULL,
  `rmk_dc` varchar(200) DEFAULT NULL,
  `bank_dt` varchar(8) DEFAULT NULL,
  `bank_sq` int(5) DEFAULT NULL,
  `tran_cd` varchar(3) DEFAULT NULL,
  `it_use_way` varchar(2) DEFAULT NULL,
  `confer_return` varchar(10) DEFAULT NULL,
  `abdocu_b_no_reffer` int(38) DEFAULT NULL,
  `it_sbgtcdlink` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`abdocu_b_no`),
  KEY `idx_g20_abdocu_b_bgt_cd` (`abdocu_no`,`abgt_cd`),
  CONSTRAINT `fk_g20_abdocu_b_g20_abdocu_h` FOREIGN KEY (`abdocu_no`) REFERENCES `g20_abdocu_h` (`abdocu_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`g20_abdocu_b` ADD COLUMN */
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `docu_mode` INT(38) DEFAULT NULL AFTER `abdocu_no`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `abdocu_no_reffer` BIGINT(38) DEFAULT NULL AFTER `docu_mode`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) NOT NULL AFTER `abdocu_no_reffer`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_gisu_dt` VARCHAR(8) DEFAULT NULL AFTER `erp_co_cd`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` INT(38) DEFAULT NULL AFTER `erp_gisu_dt`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bq_sq` INT(38) DEFAULT NULL AFTER `erp_gisu_sq`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bk_sq` INT(5) DEFAULT NULL AFTER `erp_bq_sq`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bgt_nm1` VARCHAR(50) DEFAULT NULL AFTER `erp_bk_sq`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bgt_nm2` VARCHAR(50) DEFAULT NULL AFTER `erp_bgt_nm1`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bgt_nm3` VARCHAR(50) DEFAULT NULL AFTER `erp_bgt_nm2`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bgt_nm4` VARCHAR(50) DEFAULT NULL AFTER `erp_bgt_nm3`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `open_am` INT(19) DEFAULT NULL AFTER `erp_bgt_nm4`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `apply_am` INT(19) DEFAULT NULL AFTER `open_am`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `left_am` INT(19) DEFAULT NULL AFTER `apply_am`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `abgt_cd` VARCHAR(10) DEFAULT NULL AFTER `left_am`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `abgt_nm` VARCHAR(40) DEFAULT NULL AFTER `abgt_cd`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `set_fg` VARCHAR(1) DEFAULT NULL AFTER `abgt_nm`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `vat_fg` VARCHAR(1) DEFAULT NULL AFTER `set_fg`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `tr_fg` VARCHAR(1) DEFAULT NULL AFTER `vat_fg`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `div_cd2` VARCHAR(4) DEFAULT NULL AFTER `tr_fg`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `div_nm2` VARCHAR(20) DEFAULT NULL AFTER `div_cd2`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `ctl_fg` VARCHAR(1) DEFAULT NULL AFTER `div_nm2`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(100) DEFAULT NULL AFTER `ctl_fg`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `insert_dt` DATE DEFAULT NULL AFTER `insert_id`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL AFTER `insert_dt`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `modify_dt` DATE DEFAULT NULL AFTER `modify_id`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(50) DEFAULT NULL AFTER `modify_dt`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `rmk_dc` VARCHAR(200) DEFAULT NULL AFTER `sessionid`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `bank_dt` VARCHAR(8) DEFAULT NULL AFTER `rmk_dc`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `bank_sq` INT(5) DEFAULT NULL AFTER `bank_dt`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `tran_cd` VARCHAR(3) DEFAULT NULL AFTER `bank_sq`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `it_use_way` VARCHAR(2) DEFAULT NULL AFTER `tran_cd`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `confer_return` VARCHAR(10) DEFAULT NULL AFTER `it_use_way`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `abdocu_b_no_reffer` INT(38) DEFAULT NULL AFTER `confer_return`;
ALTER TABLE `neos`.`g20_abdocu_b` ADD COLUMN IF NOT EXISTS `it_sbgtcdlink` VARCHAR(10) DEFAULT NULL AFTER `abdocu_b_no_reffer`;

/* CREATE `neos`.`g20_abdocu_t` */
CREATE TABLE IF NOT EXISTS `neos`.`g20_abdocu_t` (
  `abdocu_t_no` bigint(38) NOT NULL,
  `abdocu_no` bigint(38) DEFAULT NULL,
  `abdocu_b_no` bigint(38) DEFAULT NULL,
  `abdocu_no_reffer` bigint(38) DEFAULT NULL,
  `docu_mode` int(38) DEFAULT NULL,
  `erp_co_cd` varchar(4) NOT NULL,
  `erp_isu_dt` varchar(8) DEFAULT NULL,
  `erp_isu_sq` int(38) DEFAULT NULL,
  `erp_ln_sq` int(38) DEFAULT '0',
  `erp_bq_sq` int(38) DEFAULT '0',
  `bk_sq2` int(5) DEFAULT NULL,
  `item_nm` varchar(100) DEFAULT NULL,
  `item_cnt` varchar(100) DEFAULT NULL,
  `emp_nm` varchar(100) DEFAULT NULL,
  `tr_cd` varchar(15) DEFAULT NULL,
  `tr_nm` varchar(40) DEFAULT NULL,
  `ceo_nm` varchar(20) DEFAULT NULL,
  `unit_am` int(19) DEFAULT NULL,
  `sup_am` int(19) DEFAULT NULL,
  `vat_am` int(19) DEFAULT NULL,
  `jiro_cd` varchar(10) DEFAULT NULL,
  `jiro_nm` varchar(40) DEFAULT NULL,
  `ba_nb` varchar(40) DEFAULT NULL,
  `btr_cd` varchar(10) DEFAULT NULL,
  `btr_nm` varchar(40) DEFAULT NULL,
  `depositor` varchar(30) DEFAULT NULL,
  `rmk_dc` varchar(80) DEFAULT NULL,
  `ctr_cd` varchar(10) DEFAULT NULL,
  `ctr_nm` varchar(40) DEFAULT NULL,
  `etcrvrs_ym` varchar(6) DEFAULT NULL,
  `ndep_am` int(19) DEFAULT NULL,
  `inad_am` int(19) DEFAULT NULL,
  `intx_am` int(19) DEFAULT NULL,
  `rstx_am` int(19) DEFAULT NULL,
  `ctr_appdt` varchar(8) DEFAULT NULL,
  `reg_nb` varchar(15) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `tr_fg` varchar(100) DEFAULT NULL,
  `tr_fg_nm` varchar(100) DEFAULT NULL,
  `attr_nm` varchar(100) DEFAULT NULL,
  `ppl_nb` varchar(100) DEFAULT NULL,
  `addr` varchar(100) DEFAULT NULL,
  `trcharge_emp` varchar(100) DEFAULT NULL,
  `insert_id` varchar(100) DEFAULT NULL,
  `insert_dt` date DEFAULT NULL,
  `modify_id` varchar(100) DEFAULT NULL,
  `modify_dt` date DEFAULT NULL,
  `sessionid` varchar(50) DEFAULT NULL,
  `edit_proc` int(38) DEFAULT NULL,
  `ref_abin_ln_no` int(38) DEFAULT NULL,
  `tax_dt` varchar(16) DEFAULT NULL,
  `etcdiv_cd` varchar(4) DEFAULT NULL,
  `etcdummy1_nm` varchar(200) DEFAULT NULL,
  `etcdummy1` varchar(20) DEFAULT NULL,
  `cms_name` varchar(60) DEFAULT NULL,
  `bank_dt` varchar(8) DEFAULT NULL,
  `bank_sq` int(5) DEFAULT NULL,
  `bk_sq` int(5) DEFAULT NULL,
  `iss_dt` varchar(8) DEFAULT NULL,
  `iss_sq` int(5) DEFAULT NULL,
  `tran_cd` varchar(3) DEFAULT NULL,
  `link_type` varchar(20) DEFAULT NULL,
  `chain_name` varchar(60) DEFAULT NULL,
  `it_use_dt` varchar(8) DEFAULT NULL,
  `it_use_no` varchar(11) DEFAULT NULL,
  `it_card_no` varchar(16) DEFAULT NULL,
  `et_yn` varchar(1) DEFAULT NULL,
  `wd_am` int(19) DEFAULT NULL,
  `etcdata_cd` varchar(2) DEFAULT NULL,
  `etcrate` varchar(19) DEFAULT NULL,
  `item_am` int(19) DEFAULT NULL,
  `purc_req_no` varchar(13) DEFAULT NULL,
  `purc_req_item_no` varchar(13) DEFAULT NULL,
  `ctr_card_num` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`abdocu_t_no`),
  KEY `abdocu_b_no` (`abdocu_b_no`),
  CONSTRAINT `fk_g20_abdocu_t_g20_abdocu_b` FOREIGN KEY (`abdocu_b_no`) REFERENCES `g20_abdocu_b` (`abdocu_b_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`g20_abdocu_t` ADD COLUMN */
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `abdocu_no_reffer` BIGINT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `docu_mode` INT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) NOT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_ln_sq` INT(38) DEFAULT '0';
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_bq_sq` INT(38) DEFAULT '0';
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `bk_sq2` INT(5) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `item_nm` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `item_cnt` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `emp_nm` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tr_cd` VARCHAR(15) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tr_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ceo_nm` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `unit_am` INT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `sup_am` INT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `vat_am` INT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `jiro_cd` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `jiro_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ba_nb` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `btr_cd` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `btr_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `depositor` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `rmk_dc` VARCHAR(80) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ctr_cd` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ctr_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcrvrs_ym` VARCHAR(6) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ndep_am` INT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `inad_am` INT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `intx_am` INT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `rstx_am` INT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ctr_appdt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `reg_nb` VARCHAR(15) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tel` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tr_fg` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tr_fg_nm` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `attr_nm` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ppl_nb` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `addr` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `trcharge_emp` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `insert_dt` DATE DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `modify_dt` DATE DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(50) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `edit_proc` INT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ref_abin_ln_no` INT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tax_dt` VARCHAR(16) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcdiv_cd` VARCHAR(4) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcdummy1_nm` VARCHAR(200) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcdummy1` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `cms_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `bank_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `bank_sq` INT(5) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `bk_sq` INT(5) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `iss_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `iss_sq` INT(5) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tran_cd` VARCHAR(3) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `link_type` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `chain_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `it_use_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `it_use_no` VARCHAR(11) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `it_card_no` VARCHAR(16) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `et_yn` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `wd_am` INT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcdata_cd` VARCHAR(2) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcrate` VARCHAR(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `item_am` INT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `purc_req_no` VARCHAR(13) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `purc_req_item_no` VARCHAR(13) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ctr_card_num` VARCHAR(40) DEFAULT NULL;

/* CREATE `neos`.`g20_abdocu_th` */
CREATE TABLE IF NOT EXISTS `neos`.`g20_abdocu_th` (
  `abdocu_no` bigint(38) NOT NULL COMMENT '문서번호',
  `abdocu_th_no` bigint(38) NOT NULL COMMENT '헤더번호',
  `erp_co_cd` varchar(4) DEFAULT NULL COMMENT '회사코드',
  `erp_isu_dt` varchar(8) DEFAULT NULL COMMENT '결의일자',
  `erp_isu_sq` int(38) DEFAULT '0' COMMENT '결의번호',
  `ts_dt` varchar(8) DEFAULT NULL COMMENT '출장시작일',
  `te_dt` varchar(8) DEFAULT NULL COMMENT '출장종료일',
  `tday_cnt` int(30) DEFAULT NULL COMMENT '출장일수',
  `site_nm` varchar(20) DEFAULT NULL COMMENT '출장지',
  `req_nm` varchar(10) DEFAULT NULL COMMENT '청구인성명',
  `scost_am` bigint(17) DEFAULT NULL COMMENT '정산급',
  `ontrip_nm` varchar(40) DEFAULT NULL COMMENT '출장용무',
  `rsv_nm` varchar(10) DEFAULT NULL COMMENT '영수인 성명',
  `site_nmk` varchar(20) DEFAULT NULL COMMENT '출장지(다국어)',
  `ontrip_nmk` varchar(40) DEFAULT NULL COMMENT '출장용무(다국어)',
  `req_nmk` varchar(10) DEFAULT NULL COMMENT '청구인성명(다국어)',
  `rsv_nmk` varchar(10) DEFAULT NULL COMMENT '영수인성명(다국어)',
  `rcost_am` bigint(17) DEFAULT NULL COMMENT '개산급',
  `insert_id` varchar(10) DEFAULT NULL COMMENT '등록자',
  `insert_ip` varchar(15) DEFAULT NULL COMMENT '등록자 ip',
  `insert_dt` datetime DEFAULT NULL COMMENT '등록일자',
  `modify_id` varchar(100) DEFAULT NULL COMMENT '수정자',
  `modify_ip` varchar(15) DEFAULT NULL COMMENT '수정자 ip',
  `modify_dt` datetime DEFAULT NULL COMMENT '수정일자',
  `sessionid` varchar(100) DEFAULT NULL,
  `biztrip_appl_id` int(38) DEFAULT NULL,
  PRIMARY KEY (`abdocu_no`,`abdocu_th_no`),
  UNIQUE KEY `g20_abdocu_th_pk` (`abdocu_no`,`abdocu_th_no`),
  KEY `abdocu_th_no` (`abdocu_th_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`g20_abdocu_th` ADD COLUMN */
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL COMMENT '회사코드';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL COMMENT '결의일자';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT '0' COMMENT '결의번호';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `ts_dt` VARCHAR(8) DEFAULT NULL COMMENT '출장시작일';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `te_dt` VARCHAR(8) DEFAULT NULL COMMENT '출장종료일';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `tday_cnt` INT(30) DEFAULT NULL COMMENT '출장일수';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `site_nm` VARCHAR(20) DEFAULT NULL COMMENT '출장지';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `req_nm` VARCHAR(10) DEFAULT NULL COMMENT '청구인성명';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `scost_am` BIGINT(17) DEFAULT NULL COMMENT '정산급';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `ontrip_nm` VARCHAR(40) DEFAULT NULL COMMENT '출장용무';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `rsv_nm` VARCHAR(10) DEFAULT NULL COMMENT '영수인 성명';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `site_nmk` VARCHAR(20) DEFAULT NULL COMMENT '출장지(다국어)';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `ontrip_nmk` VARCHAR(40) DEFAULT NULL COMMENT '출장용무(다국어)';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `req_nmk` VARCHAR(10) DEFAULT NULL COMMENT '청구인성명(다국어)';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `rsv_nmk` VARCHAR(10) DEFAULT NULL COMMENT '영수인성명(다국어)';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `rcost_am` BIGINT(17) DEFAULT NULL COMMENT '개산급';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(10) DEFAULT NULL COMMENT '등록자';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `insert_ip` VARCHAR(15) DEFAULT NULL COMMENT '등록자 ip';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `insert_dt` DATETIME DEFAULT NULL COMMENT '등록일자';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `modify_ip` VARCHAR(15) DEFAULT NULL COMMENT '수정자 ip';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `modify_dt` DATETIME DEFAULT NULL COMMENT '수정일자';
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_th` ADD COLUMN IF NOT EXISTS `biztrip_appl_id` INT(38) DEFAULT NULL;

/* CREATE `neos`.`g20_abdocu_td` */
CREATE TABLE IF NOT EXISTS `neos`.`g20_abdocu_td` (
  `abdocu_no` bigint(38) DEFAULT NULL COMMENT '문서번호',
  `abdocu_td_no` bigint(38) NOT NULL COMMENT '상세번호',
  `erp_co_cd` varchar(4) DEFAULT NULL COMMENT ' 회사코드',
  `erp_isu_dt` varchar(8) DEFAULT NULL COMMENT ' 결의일자',
  `erp_isu_sq` int(38) DEFAULT '0' COMMENT ' 결의번호',
  `erp_ln_sq` int(30) DEFAULT NULL COMMENT '라인순번',
  `jong_nm` varchar(10) DEFAULT NULL COMMENT ' 종별',
  `jkm_cnt` int(17) DEFAULT NULL COMMENT ' 운임거리',
  `jgrade` varchar(3) DEFAULT NULL COMMENT '운임등급',
  `junit_am` int(17) DEFAULT NULL COMMENT '운임단가',
  `jtot_am` int(17) DEFAULT NULL COMMENT '운임총액',
  `jong_nmk` varchar(10) DEFAULT NULL COMMENT '종별(다국어)',
  `memo_cd` varchar(14) DEFAULT NULL COMMENT '메모 cd',
  `check_pen` varchar(20) DEFAULT NULL COMMENT '체크펜',
  `sessionid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`abdocu_td_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`g20_abdocu_td` ADD COLUMN */
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) DEFAULT NULL COMMENT '문서번호';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL COMMENT ' 회사코드';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL COMMENT ' 결의일자';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT '0' COMMENT ' 결의번호';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `erp_ln_sq` INT(30) DEFAULT NULL COMMENT '라인순번';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jong_nm` VARCHAR(10) DEFAULT NULL COMMENT ' 종별';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jkm_cnt` INT(17) DEFAULT NULL COMMENT ' 운임거리';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jgrade` VARCHAR(3) DEFAULT NULL COMMENT '운임등급';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `junit_am` INT(17) DEFAULT NULL COMMENT '운임단가';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jtot_am` INT(17) DEFAULT NULL COMMENT '운임총액';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jong_nmk` VARCHAR(10) DEFAULT NULL COMMENT '종별(다국어)';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `memo_cd` VARCHAR(14) DEFAULT NULL COMMENT '메모 cd';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `check_pen` VARCHAR(20) DEFAULT NULL COMMENT '체크펜';
ALTER TABLE `neos`.`g20_abdocu_td` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL;

/* CREATE `neos`.`g20_abdocu_td2` */
CREATE TABLE IF NOT EXISTS `neos`.`g20_abdocu_td2` (
  `abdocu_no` bigint(38) NOT NULL COMMENT '문서번호',
  `abdocu_td2_no` bigint(38) NOT NULL COMMENT '헤더번호',
  `erp_co_cd` varchar(4) DEFAULT NULL COMMENT '회사코드',
  `erp_isu_dt` varchar(8) DEFAULT NULL COMMENT '결의일자',
  `erp_isu_sq` int(38) DEFAULT '0' COMMENT '결의번호',
  `erp_ln_sq` int(30) DEFAULT NULL COMMENT '라인순번',
  `emp_nm` varchar(20) DEFAULT NULL COMMENT '사원',
  `dept_nm` varchar(20) DEFAULT NULL COMMENT '부서',
  `class_nm` varchar(20) DEFAULT NULL COMMENT '직위',
  `hcls_nm` varchar(20) DEFAULT NULL COMMENT '직급',
  `trip_dt` varchar(8) DEFAULT NULL COMMENT '출장일자',
  `nt_cnt` int(30) DEFAULT NULL COMMENT '이수',
  `day_cnt` int(30) DEFAULT NULL COMMENT '일수',
  `start_nm` varchar(20) DEFAULT NULL COMMENT '출발지',
  `cross_nm` varchar(20) DEFAULT NULL COMMENT '경유지',
  `arr_nm` varchar(20) DEFAULT NULL COMMENT '도착지',
  `jong_nm` varchar(10) DEFAULT NULL COMMENT '종별',
  `km_am` bigint(17) DEFAULT NULL COMMENT '거리',
  `fair_am` bigint(17) DEFAULT NULL COMMENT '요금',
  `trmk_dc` varchar(20) DEFAULT NULL COMMENT '적요',
  `start_nmk` varchar(20) DEFAULT NULL COMMENT '출발지(다국어)',
  `cross_nmk` varchar(20) DEFAULT NULL COMMENT '경유지(다국어)',
  `arr_nmk` varchar(20) DEFAULT NULL COMMENT '도착지(다국어)',
  `jong_nmk` varchar(10) DEFAULT NULL COMMENT '종별(다국어)',
  `trmk_dck` varchar(20) DEFAULT NULL COMMENT '적요(다국어)',
  `memo_cd` varchar(14) DEFAULT NULL COMMENT '메모 cd',
  `check_pen` varchar(20) DEFAULT NULL COMMENT '체크펜',
  `day_am` bigint(17) DEFAULT NULL COMMENT '일비',
  `food_am` bigint(17) DEFAULT NULL COMMENT '식비',
  `room_am` bigint(17) DEFAULT NULL COMMENT '숙박비',
  `other_am` bigint(17) DEFAULT NULL COMMENT '기타',
  `sessionid` varchar(100) DEFAULT NULL,
  `total_am` bigint(17) DEFAULT NULL,
  `biztrip_appl_id` int(20) DEFAULT NULL,
  `biztrip_no_seq` int(3) DEFAULT NULL,
  `trip_dt2` varchar(8) DEFAULT NULL,
  `na_day_am` int(17) DEFAULT NULL,
  `na_room_am` int(17) DEFAULT NULL,
  `na_food_am` int(17) DEFAULT NULL,
  PRIMARY KEY (`abdocu_no`,`abdocu_td2_no`),
  UNIQUE KEY `g20_abdocu_td2_pk` (`abdocu_no`,`abdocu_td2_no`),
  KEY `abdocu_td2_no` (`abdocu_td2_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`g20_abdocu_td2` ADD COLUMN */
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) NOT NULL COMMENT '문서번호';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `abdocu_td2_no` BIGINT(38) NOT NULL COMMENT '헤더번호';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL COMMENT '회사코드';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL COMMENT '결의일자';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT '0' COMMENT '결의번호';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `erp_ln_sq` INT(30) DEFAULT NULL COMMENT '라인순번';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `emp_nm` VARCHAR(20) DEFAULT NULL COMMENT '사원';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `dept_nm` VARCHAR(20) DEFAULT NULL COMMENT '부서';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `class_nm` VARCHAR(20) DEFAULT NULL COMMENT '직위';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `hcls_nm` VARCHAR(20) DEFAULT NULL COMMENT '직급';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `trip_dt` VARCHAR(8) DEFAULT NULL COMMENT '출장일자';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `nt_cnt` INT(30) DEFAULT NULL COMMENT '이수';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `day_cnt` INT(30) DEFAULT NULL COMMENT '일수';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `start_nm` VARCHAR(20) DEFAULT NULL COMMENT '출발지';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `cross_nm` VARCHAR(20) DEFAULT NULL COMMENT '경유지';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `arr_nm` VARCHAR(20) DEFAULT NULL COMMENT '도착지';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `jong_nm` VARCHAR(10) DEFAULT NULL COMMENT '종별';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `km_am` BIGINT(17) DEFAULT NULL COMMENT '거리';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `fair_am` BIGINT(17) DEFAULT NULL COMMENT '요금';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `trmk_dc` VARCHAR(20) DEFAULT NULL COMMENT '적요';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `start_nmk` VARCHAR(20) DEFAULT NULL COMMENT '출발지(다국어)';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `cross_nmk` VARCHAR(20) DEFAULT NULL COMMENT '경유지(다국어)';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `arr_nmk` VARCHAR(20) DEFAULT NULL COMMENT '도착지(다국어)';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `jong_nmk` VARCHAR(10) DEFAULT NULL COMMENT '종별(다국어)';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `trmk_dck` VARCHAR(20) DEFAULT NULL COMMENT '적요(다국어)';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `memo_cd` VARCHAR(14) DEFAULT NULL COMMENT '메모 cd';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `check_pen` VARCHAR(20) DEFAULT NULL COMMENT '체크펜';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `day_am` BIGINT(17) DEFAULT NULL COMMENT '일비';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `food_am` BIGINT(17) DEFAULT NULL COMMENT '식비';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `room_am` BIGINT(17) DEFAULT NULL COMMENT '숙박비';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `other_am` BIGINT(17) DEFAULT NULL COMMENT '기타';
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `total_am` BIGINT(17) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `biztrip_appl_id` INT(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `biztrip_no_seq` INT(3) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `trip_dt2` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `na_day_am` INT(17) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `na_room_am` INT(17) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `na_food_am` INT(17) DEFAULT NULL;

/* CREATE `neos`.`g20_abdocu_d` */
CREATE TABLE IF NOT EXISTS `neos`.`g20_abdocu_d` (
  `abdocu_d_no` bigint(38) NOT NULL,
  `abdocu_no` bigint(38) DEFAULT NULL,
  `erp_co_cd` varchar(4) DEFAULT NULL,
  `erp_isu_dt` varchar(8) DEFAULT NULL,
  `erp_isu_sq` int(38) DEFAULT '0',
  `erp_ln_sq` int(38) DEFAULT NULL,
  `item_nm` varchar(40) DEFAULT NULL,
  `item_dc` varchar(40) DEFAULT NULL,
  `unit_dc` varchar(40) DEFAULT NULL,
  `ct_qt` varchar(40) DEFAULT NULL,
  `unit_am` int(38) DEFAULT NULL,
  `ct_am` int(38) DEFAULT NULL,
  `rmk_dc` varchar(40) DEFAULT NULL,
  `dummy1` varchar(20) DEFAULT NULL,
  `dummy2` varchar(20) DEFAULT NULL,
  `dummy3` varchar(20) DEFAULT NULL,
  `item_nmk` varchar(30) DEFAULT NULL,
  `rmk_dck` varchar(40) DEFAULT NULL,
  `memo_cd` varchar(14) DEFAULT NULL,
  `check_pen` varchar(20) DEFAULT NULL,
  `insert_id` varchar(10) DEFAULT NULL,
  `insert_ip` varchar(15) DEFAULT NULL,
  `insert_dt` date DEFAULT NULL,
  `modify_id` varchar(100) DEFAULT NULL,
  `modify_ip` varchar(15) DEFAULT NULL,
  `modify_dt` date DEFAULT NULL,
  `item_cd` varchar(20) DEFAULT NULL,
  `sessionid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`abdocu_d_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`g20_abdocu_d` ADD COLUMN */
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT '0';
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `erp_ln_sq` INT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `item_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `item_dc` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `unit_dc` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `ct_qt` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `unit_am` INT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `ct_am` INT(38) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `rmk_dc` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `dummy1` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `dummy2` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `dummy3` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `item_nmk` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `rmk_dck` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `memo_cd` VARCHAR(14) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `check_pen` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `insert_ip` VARCHAR(15) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `insert_dt` DATE DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `modify_ip` VARCHAR(15) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `modify_dt` DATE DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `item_cd` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_abdocu_d` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL;

/* CREATE `neos`.`g20_acard_sungin` */
CREATE TABLE IF NOT EXISTS `neos`.`g20_acard_sungin` (
  `abdocu_no` bigint(38) NOT NULL,
  `abdocu_b_no` bigint(38) NOT NULL,
  `iss_dt` varchar(8) NOT NULL,
  `iss_sq` varchar(10) NOT NULL,
  `erp_co_cd` varchar(4) NOT NULL,
  `bank_cd` varchar(2) DEFAULT NULL,
  `card_nb` varchar(20) DEFAULT NULL,
  `user_detail` varchar(100) DEFAULT NULL,
  `chain_name` varchar(60) DEFAULT NULL,
  `chain_regnb` varchar(20) DEFAULT NULL,
  `sungin_nb` varchar(20) DEFAULT NULL,
  `sungin_am` bigint(19) DEFAULT NULL,
  `vat_am` bigint(19) DEFAULT NULL,
  `user_type` varchar(20) DEFAULT NULL,
  `ebank_cd` varchar(20) DEFAULT NULL,
  `ebank_key` varchar(100) DEFAULT NULL,
  `gw_state` varchar(1) DEFAULT NULL,
  `gw_state_han` varchar(100) DEFAULT NULL,
  `pkey` varchar(30) DEFAULT NULL,
  `ctr_cd` varchar(10) DEFAULT NULL,
  `ctr_nm` varchar(40) DEFAULT NULL,
  `abdocu_t_no` bigint(38) DEFAULT NULL,
  `tot_am` bigint(19) DEFAULT NULL COMMENT '합계',
  `admit_dt` varchar(8) DEFAULT NULL,
  `chain_business` varchar(40) DEFAULT NULL COMMENT '가맹점',
  `cancel_yn` varchar(40) DEFAULT NULL COMMENT '취소여부',
  KEY `fk_G20_acard_sungin_abdocu_t` (`abdocu_t_no`),
  CONSTRAINT `fk_G20_acard_sungin_abdocu_t` FOREIGN KEY (`abdocu_t_no`) REFERENCES `g20_abdocu_t` (`abdocu_t_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`g20_acard_sungin` ADD COLUMN */
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) NOT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `abdocu_b_no` BIGINT(38) NOT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `iss_dt` VARCHAR(8) NOT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `iss_sq` VARCHAR(10) NOT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) NOT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `bank_cd` VARCHAR(2) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `card_nb` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `user_detail` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `chain_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `chain_regnb` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `sungin_nb` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `sungin_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `vat_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `user_type` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `ebank_cd` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `ebank_key` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `gw_state` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `gw_state_han` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `pkey` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `ctr_cd` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `ctr_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `tot_am` BIGINT(19) DEFAULT NULL COMMENT '합계';
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `admit_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `chain_business` VARCHAR(40) DEFAULT NULL COMMENT '가맹점';
ALTER TABLE `neos`.`g20_acard_sungin` ADD COLUMN IF NOT EXISTS `cancel_yn` VARCHAR(40) DEFAULT NULL COMMENT '취소여부';

/* CREATE `neos`.`g20_hpomnpy_padata` */
CREATE TABLE IF NOT EXISTS `neos`.`g20_hpomnpy_padata` (
  `abdocu_no` bigint(38) NOT NULL,
  `abdocu_b_no` bigint(38) NOT NULL,
  `abdocu_t_no` bigint(38) NOT NULL,
  `emp_tr_cd` varchar(10) NOT NULL,
  `rvrs_ym` varchar(6) NOT NULL,
  `sq` int(3) NOT NULL,
  `kor_nm` varchar(30) DEFAULT NULL,
  `dept_nm` varchar(30) DEFAULT NULL,
  `gisu_dt` varchar(8) DEFAULT NULL,
  `pay_dt` varchar(8) DEFAULT NULL,
  `tpay_am` bigint(19) DEFAULT NULL,
  `sup_am` bigint(19) DEFAULT NULL,
  `vat_am` bigint(19) DEFAULT NULL,
  `intx_am` bigint(19) DEFAULT NULL,
  `rstx_am` bigint(19) DEFAULT NULL,
  `etc_am` bigint(19) DEFAULT NULL,
  `acct_no` varchar(30) DEFAULT NULL,
  `pytb_cd` varchar(5) DEFAULT NULL,
  `dpst_nm` varchar(30) DEFAULT NULL,
  `bank_nm` varchar(20) DEFAULT NULL,
  `rsrg_no` varchar(100) DEFAULT NULL,
  `pjt_nm` varchar(30) DEFAULT NULL,
  `pkey` varchar(30) DEFAULT NULL,
  KEY `fk_g20_hpomnpy_abdocu_t` (`abdocu_t_no`),
  CONSTRAINT `fk_g20_hpomnpy_abdocu_t` FOREIGN KEY (`abdocu_t_no`) REFERENCES `g20_abdocu_t` (`abdocu_t_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`g20_hpomnpy_padata` ADD COLUMN */
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) NOT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `abdocu_b_no` BIGINT(38) NOT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `emp_tr_cd` VARCHAR(10) NOT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `rvrs_ym` VARCHAR(6) NOT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `sq` INT(3) NOT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `kor_nm` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `dept_nm` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `gisu_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `pay_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `tpay_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `sup_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `vat_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `intx_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `rstx_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `etc_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `acct_no` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `pytb_cd` VARCHAR(5) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `dpst_nm` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `bank_nm` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `rsrg_no` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `pjt_nm` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `neos`.`g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `pkey` VARCHAR(30) DEFAULT NULL;

/* CREATE `neos`.`erpgwlink` */
CREATE TABLE IF NOT EXISTS `neos`.`erpgwlink` (
  `appr_seqn` varchar(10) NOT NULL COMMENT 'erp연계처리번호(시퀀스: seq_erpgwlink)',
  `pack_knd_cd` varchar(5) NOT NULL COMMENT 'erp패키지 구분코드(공통코드:g20,eiu)',
  `docx_gubn` varchar(5) NOT NULL COMMENT 'erpd연계종류코드( 결재양식:지출물의, 지출결의..)',
  `docx_numb` varchar(50) DEFAULT NULL COMMENT 'erp문서번호(업무별 구분 key)',
  `requ_userid` varchar(50) NOT NULL COMMENT '요청자 id',
  `requ_userkey` varchar(30) NOT NULL COMMENT '전자결재사용자 key',
  `requ_date` varchar(14) NOT NULL COMMENT '결재요청일시(yyyymmddhhmmss)',
  `appr_dikey` varchar(46) NOT NULL COMMENT '전자결재문서 키코드',
  `appr_status` varchar(3) DEFAULT NULL COMMENT '결재진행상태코드(002:결재중..)',
  `appr_end_date` varchar(14) DEFAULT NULL COMMENT '결재처리일시(yyyymmddhhmmss)',
  `cd_company` varchar(7) DEFAULT NULL COMMENT '회사코드',
  `doc_audit` VARCHAR(1) DEFAULT 'N' COMMENT '문서 감사여부 감사 ''y''  감사아님''n''',
  `back_docx_numb` varchar(50) DEFAULT NULL COMMENT '회수나 반려시 docx_numb을 저장',
  `modify_id` varchar(50) DEFAULT NULL,
  `modify_userkey` varchar(30) DEFAULT NULL,
  `modify_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`appr_seqn`),
  UNIQUE KEY `a_erpgwlink_pk` (`appr_seqn`),
  KEY `idx_erpgwlink02` (`docx_numb`,`docx_gubn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `neos`.`erpgwlink` ADD COLUMN */
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `pack_knd_cd` VARCHAR(5) NOT NULL COMMENT 'erp패키지 구분코드(공통코드:g20,eiu)';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `requ_userid` VARCHAR(50) NOT NULL COMMENT '요청자 id';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `requ_userkey` VARCHAR(30) NOT NULL COMMENT '전자결재사용자 key';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `requ_date` VARCHAR(14) NOT NULL COMMENT '결재요청일시(yyyymmddhhmmss)';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `appr_dikey` VARCHAR(46) NOT NULL COMMENT '전자결재문서 키코드';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `appr_status` VARCHAR(3) DEFAULT NULL COMMENT '결재진행상태코드(002:결재중..)';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `appr_end_date` VARCHAR(14) DEFAULT NULL COMMENT '결재처리일시(yyyymmddhhmmss)';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `cd_company` VARCHAR(7) DEFAULT NULL COMMENT '회사코드';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `doc_audit` VARCHAR(1) DEFAULT 'N' COMMENT '문서 감사여부 감사 ''y''  감사아님''n''';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `back_docx_numb` VARCHAR(50) DEFAULT NULL COMMENT '회수나 반려시 docx_numb을 저장';
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(50) DEFAULT NULL;
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `modify_userkey` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `neos`.`erpgwlink` ADD COLUMN IF NOT EXISTS `modify_dt` DATETIME DEFAULT NULL;

/* 2016. 11. 22. */
/* 2016. 11. 22. - 김상겸 */
/* 2016. 11. 22. - 김상겸 - CMS 연동 배치 생성 개발 */
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS `base_date` VARCHAR(8) NULL COMMENT '연동시작 기준일' AFTER `cms_process_yn`;
ALTER TABLE `neos`.`t_ex_cms_sync` ADD COLUMN IF NOT EXISTS `base_day` VARCHAR(2) NULL DEFAULT '7' COMMENT '연동시작 기준일자' AFTER `base_date`;

/* 2016-12-27 지출결의 첨부파일 테이블 */
CREATE TABLE IF NOT EXISTS `t_ex_expend_attach` (
  `type` varchar(10) NOT NULL COMMENT 'list :항목, slip : 분개',
  `expend_seq` varchar(32) NOT NULL DEFAULT '0' COMMENT '문서번호',
  `list_seq` varchar(32) NOT NULL DEFAULT '0' COMMENT '항목번호',
  `slip_seq` varchar(32) NOT NULL DEFAULT '0' COMMENT '분개번호',
  `file_seq` varchar(32) NOT NULL DEFAULT '0' COMMENT '파일번호',
  `create_seq` varchar(32) NOT NULL COMMENT '생성자',
  `create_date` date DEFAULT NULL COMMENT '생성일자',
  `modify_seq` varchar(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` date DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`type`,`expend_seq`,`list_seq`,`slip_seq`,`file_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* =================================================================================== */

CREATE TABLE IF NOT EXISTS  `t_ex_card_transfer` (
  `seq` int(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  `comp_seq` varchar(32) DEFAULT NULL COMMENT '회사SEQ',
  `card_num` varchar(16) NOT NULL COMMENT '카드번호',
  `auth_num` varchar(20) NOT NULL COMMENT '카드승인번호',
  `auth_date` char(8) NOT NULL COMMENT '승인일자',
  `auth_time` char(6) NOT NULL COMMENT '승인시간',
  `partner_no` varchar(32) NOT NULL COMMENT '공급자 사업자등록번호',
  `partner_name` varchar(128) NOT NULL COMMENT '공급자 명',
  `amt` decimal(19,0) NOT NULL COMMENT '세금계산서 금액',
  `transfer_seq` varchar(32) NOT NULL COMMENT '이관 한 사원 번호',
  `transfer_name` varchar(128) DEFAULT NULL COMMENT '이관 한 사원 이름',
  `receive_seq` varchar(32) NOT NULL COMMENT '이관 받은 사원 번호',
  `receive_name` varchar(128) DEFAULT NULL COMMENT '이관 받은 사원 이름',
  `supper_key` varchar(128) DEFAULT NULL COMMENT '조직도팝업 슈퍼키',
  `create_date` datetime DEFAULT NULL COMMENT '이관일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8

/* 테이블 엔진 변경 */
ALTER TABLE `neos`.`t_ex_card_transfer` ENGINE=INNODB;



/*--------------------------- 스마트증빙 KEY 값 변경으로 인한 컬럼 크기 수정 패키지 (50버전)  ---------------------------------*/
ALTER TABLE `neos`.`t_ex_card_aq_tmp` MODIFY georae_coll VARCHAR(50);


/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 06. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

