/* 2018-10-03 */
/* 최상배 - 비영리 회계 2.0 연동 모듈 배포 스크립트 작성 */

/*  - 품의문서 t_exnp_consdoc 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_consdoc` (
	`cons_doc_seq` BIGINT(32) NOT NULL AUTO_INCREMENT 	COMMENT '품의 문서 키',
	`create_seq` VARCHAR(32) DEFAULT NULL COMMENT '품의문서 생성자 키',
	`create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '품의문서 생성일자',
	`modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '품의문서 수정자 키',
	`modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '품의문서 수정일자',
	PRIMARY KEY (`cons_doc_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `doc_seq` VARCHAR(32) NULL COMMENT '품의 문서 전자결재 키' AFTER `cons_doc_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `doc_no` VARCHAR(64) NULL COMMENT '품의 문서 전자결재 문서 번호' AFTER `doc_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `doc_status` VARCHAR(6) NULL COMMENT '품의 문서 전자결재 상태값' AFTER `doc_no`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `consdoc_note` VARCHAR(1024) NULL COMMENT '품의 문서 적요' AFTER `doc_status`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `expend_date` DATETIME NULL COMMENT '품의일자' AFTER `consdoc_note`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT 'ERP 회계단위 코드' AFTER `expend_date`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(32) NULL COMMENT 'ERP 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(32) NULL COMMENT 'ERP 회사 코드' AFTER `erp_div_name`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_dept_seq` VARCHAR(32) NULL COMMENT 'ERP 부서 코드' AFTER `erp_comp_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(32) NULL COMMENT 'ERP 사용자 코드' AFTER `erp_dept_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_gisu` VARCHAR(10) NULL COMMENT 'ERP 기수' AFTER `erp_emp_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_expend_year` VARCHAR(4) NULL COMMENT 'ERP 회계 연도' AFTER `erp_gisu`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT 'GW 회사 키' AFTER `erp_expend_year`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT 'GW 회사 명칭' AFTER `comp_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `dept_seq` VARCHAR(32) NULL COMMENT 'GW 부서 키' AFTER `comp_name`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `dept_name` VARCHAR(128) NULL COMMENT 'GW 부서 명칭' AFTER `dept_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT 'GW 사용자 키' AFTER `dept_name`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT 'GW 사용자 명칭' AFTER `emp_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `conffer_return_yn` VARCHAR(2) DEFAULT 'N' COMMENT '품의 문서 환원 여부' AFTER `emp_name`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `conffer_return_name` VARCHAR(128) NULL COMMENT '품의 문서 환원자 명' AFTER `conffer_return_yn`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `conffer_return_emp_seq` VARCHAR(32) NULL COMMENT '품의 문서 환원자 키' AFTER `conffer_return_name`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 구분값 ( 전자결재 아님 )' AFTER `conffer_return_emp_seq`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_m_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 마스터 아이디 ( 전자결재 아님 )' AFTER `out_process_interface_id`;
ALTER TABLE `neos`.`t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_d_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 디테일 아이디 ( 전자결재 아님 )' AFTER `out_process_interface_m_id`;


/*  - 품의서 t_exnp_conshead 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_conshead` (
	`cons_doc_seq` BIGINT(32) NOT NULL COMMENT '품의 문서 키',
	`cons_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '품의서 키',
	`create_seq` VARCHAR(32) DEFAULT NULL,
	`create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,	
	`modify_seq` VARCHAR(32) DEFAULT NULL,
	`modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,  
	PRIMARY KEY (`cons_doc_seq`,`cons_seq`),
	KEY `cons_seq` (`cons_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `cons_date` VARCHAR(16) NULL COMMENT '품의 일자' AFTER `cons_seq`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `mgt_seq` VARCHAR(10) NULL COMMENT '[I]ERP 프로젝트/부서 코드' AFTER `cons_date`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `mgt_name` VARCHAR(128) NULL COMMENT '[I]ERP 프로젝트/부서 명' AFTER `mgt_seq`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `docu_fg_code` VARCHAR(2) NULL COMMENT '품의 구분 코드' AFTER `mgt_name`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `docu_fg_name` VARCHAR(32) NULL COMMENT '품의 구분 명' AFTER `docu_fg_code`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `cons_note` VARCHAR(400) NULL COMMENT '품의서 적요' AFTER `docu_fg_name`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(8) NULL COMMENT 'ERP 회사 코드' AFTER `cons_note`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_comp_name` VARCHAR(100) NULL COMMENT 'ERP 회사 명' AFTER `erp_comp_seq`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_pc_seq` VARCHAR(8) NULL COMMENT '[U]ERP 회계단위 코드' AFTER `erp_comp_name`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_pc_name` VARCHAR(64) NULL COMMENT '[U]ERP 회계단위 명' AFTER `erp_pc_seq`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(40) NULL COMMENT 'ERP 사원 코드' AFTER `erp_pc_name`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_emp_name` VARCHAR(100) NULL COMMENT 'ERP 사원 명' AFTER `erp_emp_seq`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(40) NULL COMMENT '[I]ERP 예산 회계단위 코드' AFTER `erp_emp_name`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(100) NULL COMMENT '[I]ERP 예산 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_dept_seq` VARCHAR(40) NULL COMMENT 'ERP 부서 코드' AFTER `erp_div_name`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_dept_name` VARCHAR(100) NULL COMMENT 'ERP 부서 명' AFTER `erp_dept_seq`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_gisu` INT(32) NULL COMMENT 'ERP 기수' AFTER `erp_dept_name`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_gisu_from_date` VARCHAR(8) NULL COMMENT 'ERP 기수 시작일' AFTER `erp_gisu`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_gisu_to_date` VARCHAR(8) NULL COMMENT 'ERP 기수 종료일' AFTER `erp_gisu_from_date`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_year` VARCHAR(4) NULL COMMENT 'ERP 회계 연도' AFTER `erp_gisu_to_date`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `btr_seq` VARCHAR(10) NULL COMMENT '[I] MGT 입출금 계좌 코드' AFTER `erp_year`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `btr_nb` VARCHAR(50) NULL COMMENT '[I] MGT 입출금 계좌 번호' AFTER `btr_seq`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `btr_name` VARCHAR(100) NULL COMMENT '[I] MGT 입출금 계좌 명' AFTER `btr_nb`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `bottom_seq` VARCHAR(10) NULL COMMENT '[I] 하위사업 코드' AFTER `btr_name`;
ALTER TABLE `neos`.`t_exnp_conshead` ADD COLUMN IF NOT EXISTS `bottom_name` VARCHAR(100) NULL COMMENT '[I] 하위사업 명' AFTER `bottom_seq`;


/*  - 품의서 t_exnp_consbudget 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_consbudget` (
  `cons_doc_seq` BIGINT(32) NOT NULL COMMENT '품의 문서 키',
  `cons_seq` BIGINT(32) NOT NULL COMMENT '품의서 키',
  `budget_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '품의서 예산 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cons_doc_seq`,`cons_seq`,`budget_seq`),
  KEY `budget_seq` (`budget_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bq_seq` INT(38) NULL COMMENT 'ERP 예산순번' AFTER `budget_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bk_seq` INT(5) NULL COMMENT 'ERP 에산 순번' AFTER `erp_bq_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_budget_seq` VARCHAR(32) NULL COMMENT '예산단위 코드 [U:budgetCode]' AFTER `erp_bk_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_budget_name` VARCHAR(32) NULL COMMENT '예산단위 명 [U:budget]' AFTER `erp_budget_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bizplan_seq` VARCHAR(32) NULL COMMENT '사업 계획 코드 [U:bizplanCode]' AFTER `erp_budget_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bizplan_name` VARCHAR(32) NULL COMMENT '사업계획 명 [U:bizplan]' AFTER `erp_bizplan_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT '[G] ERP 전표 사업장 코드' AFTER `erp_bizplan_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(32) NULL COMMENT '[G] ERP 전표 사업장 명' AFTER `erp_div_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_fiacct_seq` VARCHAR(10) NULL COMMENT '[U] 회계계정 코드 [U:fiacctCode]' AFTER `erp_div_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_fiacct_name` VARCHAR(32) NULL COMMENT '[U] 회계계정 명 [U:fiacct]' AFTER `erp_fiacct_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgacct_seq` VARCHAR(10) NULL COMMENT '노드 [G:예산코드 U:예산계정] 코드' AFTER `erp_fiacct_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgacct_name` VARCHAR(10) NULL COMMENT '노드 [G:예산코드 U:예산계정] 명칭' AFTER `erp_bgacct_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt1_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]관' AFTER `erp_bgacct_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt1_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]관 코드' AFTER `erp_bgt1_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt2_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]항' AFTER `erp_bgt1_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt2_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]항 코드' AFTER `erp_bgt2_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt3_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]목' AFTER `erp_bgt2_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt3_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]목 코드' AFTER `erp_bgt3_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt4_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]세' AFTER `erp_bgt3_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt4_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]세 코드' AFTER `erp_bgt4_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `set_fg_code` VARCHAR(1) NULL COMMENT '결제 수단 코드' AFTER `erp_bgt4_seq`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `set_fg_name` VARCHAR(32) NULL COMMENT '결제 수단 명' AFTER `set_fg_code`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `vat_fg_code` VARCHAR(1) NULL COMMENT '과세 구분 코드' AFTER `set_fg_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `vat_fg_name` VARCHAR(32) NULL COMMENT '과세 구분 명' AFTER `vat_fg_code`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `tr_fg_code` VARCHAR(1) NULL COMMENT '채주 구분 코드' AFTER `vat_fg_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `tr_fg_name` VARCHAR(32) NULL COMMENT '채주 구분 명' AFTER `tr_fg_code`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `ctl_fg_code` VARCHAR(1) NULL COMMENT '부가세 포함 통제 여부 [0:불포함, 1:포함]' AFTER `tr_fg_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `ctl_fg_name` VARCHAR(32) NULL COMMENT '부가세 포함통제 내용' AFTER `ctl_fg_code`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_open_amt` BIGINT(64) NULL COMMENT 'ERP 예산 편성 금액' AFTER `ctl_fg_name`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_apply_amt` BIGINT(64) NULL COMMENT 'ERP 예산 결의 금액' AFTER `erp_open_amt`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_res_amt` BIGINT(64) NULL COMMENT 'ERP 원인행위 금액' AFTER `erp_apply_amt`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_left_amt` BIGINT(64) NULL COMMENT 'ERP 예산잔액' AFTER `erp_res_amt`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `gw_balance_amt` BIGINT(64) NULL COMMENT '작성시점 그룹웨어 예산 잔액' AFTER `erp_left_amt`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `budget_std_amt` BIGINT(64) NULL COMMENT '부가세 대급금' AFTER `gw_balance_amt`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `budget_tax_amt` BIGINT(64) NULL COMMENT '부가세' AFTER `budget_std_amt`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `budget_amt` BIGINT(64) NULL COMMENT '사용 예산 금액' AFTER `budget_tax_amt`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `budget_note` VARCHAR(100) NULL COMMENT '예산 적요' AFTER `budget_amt`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `conffer_budget_return_yn` VARCHAR(2) DEFAULT 'N' NULL COMMENT '품의 예산별 환원 여부' AFTER `budget_note`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `conffer_budget_return_emp_seq` VARCHAR(32) NULL COMMENT '품의 예산 환원 사용자 코드' AFTER `conffer_budget_return_yn`;
ALTER TABLE `neos`.`t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `conffer_budget_return_emp_name` VARCHAR(32) NULL COMMENT '품의 예산 환원 사용자 명' AFTER `conffer_budget_return_emp_seq`;


/*  - 품의서 t_exnp_constrade 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_constrade` (
  `cons_doc_seq` BIGINT(32) NOT NULL COMMENT '품의 문서 키',
  `cons_seq` BIGINT(32) NOT NULL COMMENT '품의서 키',
  `budget_seq` BIGINT(32) NOT NULL COMMENT '품의 예산 키',
  `trade_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '품의 거래처 키',
  
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,  
  
  PRIMARY KEY (`cons_doc_seq`,`cons_seq`,`budget_seq`,`trade_seq`),
  KEY `trade_seq` (`trade_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) NULL COMMENT '[I] ERP 채주 키' AFTER `trade_seq`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `erp_isu_sq` VARCHAR(38) NULL COMMENT '[I] ERP 채주 키' AFTER `erp_isu_dt`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `erp_in_sq` BIGINT(38) NULL COMMENT '[U] ERP 채주 키 ' AFTER `erp_isu_sq`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `erp_bq_sq` BIGINT(38) NULL COMMENT '[U] ERP 채주 키' AFTER `erp_in_sq`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `item_name` VARCHAR(100) NULL COMMENT '물품 명칭' AFTER `erp_bq_sq`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `item_cnt` VARCHAR(100) NULL COMMENT '물품 갯수' AFTER `item_name`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(100) NULL COMMENT '사용자 명' AFTER `item_cnt`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `tr_seq` VARCHAR(15) NULL COMMENT 'ERP 거래처 코드' AFTER `emp_name`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `tr_name` VARCHAR(40) NULL COMMENT 'ERP 거래처 명' AFTER `tr_seq`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `ceo_name` VARCHAR(20) NULL COMMENT 'ERP 거래처 대표자 명' AFTER `tr_name`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `trade_unit_amt` BIGINT(64) NULL COMMENT '채주 금액' AFTER `ceo_name`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `trade_std_amt` BIGINT(64) NULL COMMENT '채주 부가세 대급금' AFTER `trade_unit_amt`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `trade_vat_amt` BIGINT(64) NULL COMMENT '채주 부가세' AFTER `trade_std_amt`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `jiro_seq` VARCHAR(10) NULL COMMENT '' AFTER `trade_vat_amt`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `jiro_name` VARCHAR(40) NULL COMMENT '' AFTER `jiro_seq`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `ba_nb` VARCHAR(40) NULL COMMENT '금융 계좌번호' AFTER `jiro_name`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `btr_seq` VARCHAR(10) NULL COMMENT '금융 기관 코드' AFTER `ba_nb`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `btr_name` VARCHAR(40) NULL COMMENT '금융 기관 명' AFTER `btr_seq`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `depositor` VARCHAR(30) NULL COMMENT '예금주' AFTER `btr_name`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `trade_note` VARCHAR(100) NULL COMMENT '채주 비고' AFTER `depositor`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `ctr_seq` VARCHAR(10) NULL COMMENT '' AFTER `trade_note`;
ALTER TABLE `neos`.`t_exnp_constrade` ADD COLUMN IF NOT EXISTS `ctr_name` VARCHAR(10) NULL COMMENT '' AFTER `ctr_seq`;


/*  - 결의서 t_exnp_resdoc 테이블 생성*/
CREATE TABLE IF NOT EXISTS `t_exnp_resdoc` (
  `res_doc_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '결의 문서 순번',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,   
  PRIMARY KEY (`res_doc_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `doc_seq` VARCHAR(32) NULL COMMENT '결의 문서 전자결재 문서 키' AFTER `res_doc_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `doc_no` VARCHAR(64) NULL COMMENT '결의 문서 전자결재 문서번호' AFTER `doc_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `doc_status` VARCHAR(6) NULL COMMENT '결의 문서 문서 상태 코드' AFTER `doc_no`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `resdoc_note` VARCHAR(32) NULL COMMENT '결의 문서 적요' AFTER `doc_status`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `expend_date` DATETIME(6) NULL COMMENT '결의일자' AFTER `resdoc_note`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(32) NULL COMMENT 'ERP 회사 코드' AFTER `expend_date`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_dept_seq` VARCHAR(32) NULL COMMENT 'ERP 부서 코드' AFTER `erp_comp_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(32) NULL COMMENT 'ERP 사원 코드' AFTER `erp_dept_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_gisu` VARCHAR(4) NULL COMMENT 'ERP 기수' AFTER `erp_emp_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_expend_year` VARCHAR(4) NULL COMMENT 'ERP 회계연도' AFTER `erp_gisu`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT 'ERP 회계단위 코드' AFTER `erp_expend_year`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(32) NULL COMMENT 'ERP 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT 'GW 회사 키' AFTER `erp_div_name`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT 'GW 회사 명' AFTER `comp_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `dept_seq` VARCHAR(32) NULL COMMENT 'GW 부서 키' AFTER `comp_name`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `dept_name` VARCHAR(128) NULL COMMENT 'GW 부서 명' AFTER `dept_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT 'GW 사용자 키' AFTER `dept_name`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT 'GW 사용자 명' AFTER `emp_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `conffer_doc_seq` VARCHAR(32) NULL COMMENT '참조 품의 문서 번호' AFTER `emp_name`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_send_yn` VARCHAR(2) DEFAULT 'N' COMMENT '결의서 ERP 전송 여부' AFTER `conffer_doc_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `send_emp_seq` VARCHAR(32) NULL COMMENT '결의서 전송자 키' AFTER `erp_send_yn`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `send_emp_name` VARCHAR(128) NULL COMMENT '결의서 전송자 명' AFTER `send_emp_seq`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `send_date` DATETIME NULL COMMENT '결의서 전송 일자' AFTER `send_emp_name`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 구분값 ( 전자결재 아님 )' AFTER `send_date`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_m_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 마스터 아이디 ( 전자결재 아님 )' AFTER `out_process_interface_id`;
ALTER TABLE `neos`.`t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_d_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 디테일 아이디 ( 전자결재 아님 )' AFTER `out_process_interface_m_id`;

/*  - 결의서 t_exnp_reshead 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_reshead` (
  `res_doc_seq` BIGINT(32) NOT NULL COMMENT '결의 문서 키',
  `res_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '결의서 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`res_doc_seq`,`res_seq`),
  KEY `res_seq` (`res_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu_date` VARCHAR(8) NULL COMMENT '[I] ERP 결의서 연동 키' AFTER `res_seq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` VARCHAR(10) NULL COMMENT '[I] ERP 결의서 연동 키' AFTER `erp_gisu_date`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_no_cdocu` VARCHAR(8) NULL COMMENT '[U] ERP 원인행위 키' AFTER `erp_gisu_sq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(40) NULL COMMENT 'ERP 회사 코드' AFTER `erp_no_cdocu`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_comp_name` VARCHAR(100) NULL COMMENT 'ERP 회사 명' AFTER `erp_comp_seq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_dept_seq` VARCHAR(40) NULL COMMENT 'ERP 부서 코드' AFTER `erp_comp_name`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_dept_name` VARCHAR(100) NULL COMMENT 'ERP 부서 명' AFTER `erp_dept_seq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(40) NULL COMMENT 'ERP 사원 코드' AFTER `erp_dept_name`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_emp_name` VARCHAR(100) NULL COMMENT 'ERP 사원 명' AFTER `erp_emp_seq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu` INT(38) NULL COMMENT 'ERP 기수' AFTER `erp_emp_name`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu_from_date` VARCHAR(8) NULL COMMENT 'ERP 기수 시작 일' AFTER `erp_gisu`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu_to_date` VARCHAR(8) NULL COMMENT 'ERP 기수 종료 일' AFTER `erp_gisu_from_date`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_year` VARCHAR(4) NULL COMMENT 'ERP 회계 연도' AFTER `erp_gisu_to_date`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(40) NULL COMMENT '[I] ERP 회계단위 코드' AFTER `erp_year`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(100) NULL COMMENT '[I] ERP 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_pc_seq` VARCHAR(8) NULL COMMENT '[U] ERP 회계단위' AFTER `erp_div_name`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_pc_name` VARCHAR(64) NULL COMMENT '[U] ERP 회계단위 명' AFTER `erp_pc_seq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `mgt_seq` VARCHAR(10) NULL COMMENT '[I] 프로젝트/부서 코드' AFTER `erp_pc_name`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `mgt_name` VARCHAR(100) NULL COMMENT '[I] 프로젝트/부서 명' AFTER `mgt_seq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `res_date` VARCHAR(16) NULL COMMENT '결의일자' AFTER `mgt_name`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `docu_fg_code` VARCHAR(2) NULL COMMENT '결의 구분 코드' AFTER `res_date`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `docu_fg_name` VARCHAR(32) NULL COMMENT '결의 구분 명' AFTER `docu_fg_code`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `res_note` VARCHAR(100) NULL COMMENT '결의서 적요' AFTER `docu_fg_name`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `btr_seq` VARCHAR(10) NULL COMMENT '[I] 프로젝트 입출금 계좌 코드' AFTER `res_note`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `btr_name` VARCHAR(100) NULL COMMENT '[I] 프로젝트 입출금 계좌 명' AFTER `btr_seq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `btr_nb` VARCHAR(50) NULL COMMENT '[I] 프로젝트 입출금 계좌 번호' AFTER `btr_name`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `bottom_seq` VARCHAR(10) NULL COMMENT '[I] 하위 사업 코드' AFTER `btr_nb`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `bottom_name` VARCHAR(100) NULL COMMENT '[I] 하위 사업 명' AFTER `bottom_seq`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `conffer_doc_seq` VARCHAR(32) NULL COMMENT '참조 품의 문서 키' AFTER `bottom_name`;
ALTER TABLE `neos`.`t_exnp_reshead` ADD COLUMN IF NOT EXISTS `conffer_seq` VARCHAR(32) NULL COMMENT '참조 품의서 키' AFTER `conffer_doc_seq`;

/*  - 결의서 t_exnp_resbudget 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_resbudget` (
  `res_doc_seq` BIGINT(32) NOT NULL COMMENT '결의 문서 키',
  `res_seq` BIGINT(32) NOT NULL COMMENT '결의서 키',
  `budget_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '결의 예산 키',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '',  
  PRIMARY KEY (`res_doc_seq`,`res_seq`,`budget_seq`),
  KEY `budget_seq` (`budget_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_gisu_date` VARCHAR(8) NULL COMMENT '[I] ERP 결의서 연동 키' AFTER `budget_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` VARCHAR(8) NULL COMMENT '[I] ERP 결의서 연동 키' AFTER `erp_gisu_date`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bg_sq` VARCHAR(8) NULL COMMENT '[I] ERP 결의서 예산 키' AFTER `erp_gisu_sq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bq_seq` VARCHAR(32) NULL COMMENT '[I] 결의서 예산 연동 키' AFTER `erp_bg_sq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bk_seq` VARCHAR(5) NULL COMMENT '[I] 결의서 예산 연동 키' AFTER `erp_bq_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `no_cdocu` VARCHAR(32) NULL COMMENT '[U] 원인행위 전표 연동 키' AFTER `erp_bk_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `no_cdoline` VARCHAR(32) NULL COMMENT '[U] 원인행위 전표 라인 키' AFTER `no_cdocu`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT '[I] ERP 전표 회계단위 코드' AFTER `no_cdoline`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(100) NULL COMMENT '[I] ERP 전표 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bizplan_seq` VARCHAR(32) NULL COMMENT '[U] 사업 계획 코드' AFTER `erp_div_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bizplan_name` VARCHAR(32) NULL COMMENT '[U] 사업 계획 명' AFTER `erp_bizplan_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_fiacct_seq` VARCHAR(10) NULL COMMENT '[U] ERP 회계 계정 코드' AFTER `erp_bizplan_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_fiacct_name` VARCHAR(32) NULL COMMENT '[U] ERP 회계 계정 명' AFTER `erp_fiacct_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgacct_seq` VARCHAR(10) NULL COMMENT '[U] ERP 예산 계정 코드' AFTER `erp_fiacct_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgacct_name` VARCHAR(32) NULL COMMENT '[U] ERP 예산 계정 명' AFTER `erp_bgacct_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_budget_seq` VARCHAR(32) NULL COMMENT 'ERP 예산단위 코드 I budget_seq, U budget_code' AFTER `erp_bgacct_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_budget_name` VARCHAR(32) NULL COMMENT 'ERP 예산 단위 명 I budget_name, U budget' AFTER `erp_budget_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt1_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]관 명' AFTER `erp_budget_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt1_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]관 코드' AFTER `erp_bgt1_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt2_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]항 명' AFTER `erp_bgt1_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt2_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]항 코드' AFTER `erp_bgt2_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt3_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]목 명' AFTER `erp_bgt2_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt3_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]목 코드' AFTER `erp_bgt3_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt4_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]세 명' AFTER `erp_bgt3_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt4_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]세 코드' AFTER `erp_bgt4_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_open_amt` BIGINT(64) NULL COMMENT 'ERP 예산 편성 금액' AFTER `erp_bgt4_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_apply_amt` BIGINT(64) NULL COMMENT 'ERP 예산 결의 금액' AFTER `erp_open_amt`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_res_amt` BIGINT(64) NULL COMMENT 'ERP 예산 원인행위 금액' AFTER `erp_apply_amt`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_left_amt` BIGINT(64) NULL COMMENT 'ERP 예산 잔액' AFTER `erp_res_amt`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `gw_balance_amt` BIGINT(64) NULL COMMENT '작성시점 그룹웨어 예산 잔액' AFTER `erp_left_amt`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `budget_std_amt` BIGINT(64) NULL COMMENT '부가세 대급금' AFTER `gw_balance_amt`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `budget_tax_amt` BIGINT(64) NULL COMMENT '부가세' AFTER `budget_std_amt`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `budget_amt` BIGINT(64) NULL COMMENT '결의 금액' AFTER `budget_tax_amt`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `set_fg_code` VARCHAR(2) NULL COMMENT '결재 수단 코드' AFTER `budget_amt`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `set_fg_name` VARCHAR(32) NULL COMMENT '결재 수단 명' AFTER `set_fg_code`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `vat_fg_code` VARCHAR(2) NULL COMMENT '과세 구분 코드' AFTER `set_fg_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `vat_fg_name` VARCHAR(32) NULL COMMENT '과세 구분 명' AFTER `vat_fg_code`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `tr_fg_code` VARCHAR(2) NULL COMMENT '채주 유형 코드' AFTER `vat_fg_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `tr_fg_name` VARCHAR(32) NULL COMMENT '채주 유형 명' AFTER `tr_fg_code`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `ctl_fg_code` VARCHAR(2) NULL COMMENT '부가세 포함 통제 여부 [0:불포함, 1:포함]' AFTER `tr_fg_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `ctl_fg_name` VARCHAR(32) NULL COMMENT '부가세 포함통제 내용' AFTER `ctl_fg_code`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `budget_note` VARCHAR(100) NULL COMMENT '결의서 예산 비고' AFTER `ctl_fg_name`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `conffer_doc_seq` VARCHAR(32) NULL COMMENT '참조 품의 문서 키' AFTER `budget_note`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `conffer_seq` VARCHAR(32) NULL COMMENT '참조 품의서 키' AFTER `conffer_doc_seq`;
ALTER TABLE `neos`.`t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `conffer_budget_seq` VARCHAR(32) NULL COMMENT '참조 품의 예산 키' AFTER `conffer_seq`;


/*  - 결의서 t_exnp_restrade 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_restrade` (
  `res_doc_seq` BIGINT(32) NOT NULL COMMENT '결의 문서 키',
  `res_seq` BIGINT(32) NOT NULL COMMENT '결의서 키',
  `budget_seq` BIGINT(32) NOT NULL COMMENT '결의 예산 키',
  `trade_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '결의 거래처 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,  
  PRIMARY KEY (`res_doc_seq`,`res_seq`,`budget_seq`,`trade_seq`),
  KEY `trade_seq` (`trade_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) NULL COMMENT '[I] 결의서 연동 키' AFTER `trade_seq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_isu_sq` VARCHAR(32) NULL COMMENT '[I] 결의서 연동 키' AFTER `erp_isu_dt`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_bq_sq` VARCHAR(32) NULL COMMENT '[I] 결의서 예산 연동 키' AFTER `erp_isu_sq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_in_sq` VARCHAR(32) NULL COMMENT '[I] 결의서 채주 연동 키' AFTER `erp_bq_sq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_gisu_date` VARCHAR(8) NULL COMMENT '[I] 결의서 연동 키' AFTER `erp_in_sq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` VARCHAR(8) NULL COMMENT '[I] 결의서 연동 키' AFTER `erp_gisu_date`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_bg_sq` VARCHAR(8) NULL COMMENT '[I] 결의서 예산 연동 키' AFTER `erp_gisu_sq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_ln_sq` VARCHAR(8) NULL COMMENT '[I] 결의서 채주 연동 키' AFTER `erp_bg_sq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_cdocu` VARCHAR(32) NULL COMMENT '[U] 전표 연동 키' AFTER `erp_ln_sq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_cdoline` VARCHAR(32) NULL COMMENT '[U] 전표 라인 번호' AFTER `no_cdocu`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_payline` VARCHAR(32) NULL COMMENT '[U] 전표 채주 라인 번호' AFTER `no_cdoline`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(50) NULL COMMENT '채주 사용자 명' AFTER `no_payline`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `tr_seq` VARCHAR(15) NULL COMMENT '거래처 코드' AFTER `emp_name`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `tr_name` VARCHAR(50) NULL COMMENT '거래처 명' AFTER `tr_seq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `ctr_seq` VARCHAR(10) NULL COMMENT '미지급금 거래처 코드' AFTER `tr_name`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `ctr_name` VARCHAR(50) NULL COMMENT '미지급금 거래처 명' AFTER `ctr_seq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `ceo_name` VARCHAR(50) NULL COMMENT '거래처 대표자 명' AFTER `ctr_name`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `item_name` VARCHAR(50) NULL COMMENT '물품 명' AFTER `ceo_name`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `item_cnt` VARCHAR(32) NULL COMMENT '물품 갯수' AFTER `item_name`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `trade_amt` BIGINT(64) NULL COMMENT '채주 금액' AFTER `item_cnt`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `trade_std_amt` BIGINT(64) NULL COMMENT '채주 공급대가' AFTER `trade_amt`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `trade_vat_amt` BIGINT(64) NULL COMMENT '부가세' AFTER `trade_std_amt`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `jiro_seq` VARCHAR(10) NULL COMMENT '미사용' AFTER `trade_vat_amt`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `jiro_name` VARCHAR(40) NULL COMMENT '미사용' AFTER `jiro_seq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `business_nb` VARCHAR(32) NULL COMMENT '사업자 번호' AFTER `jiro_name`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `ba_nb` VARCHAR(40) NULL COMMENT '거래처 계좌번호' AFTER `business_nb`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `btr_seq` VARCHAR(10) NULL COMMENT '거래처 금융기관 코드' AFTER `ba_nb`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `btr_name` VARCHAR(40) NULL COMMENT '거래처 금융기관 명' AFTER `btr_seq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `depositor` VARCHAR(32) NULL COMMENT '거래처 예금주' AFTER `btr_name`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `trade_note` VARCHAR(100) NULL COMMENT '거래처 비고' AFTER `depositor`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `reg_date` VARCHAR(8) NULL COMMENT '신고기준일' AFTER `trade_note`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_income_seq` VARCHAR(32) NULL COMMENT '소득 구분 코드' AFTER `reg_date`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_income_name` VARCHAR(32) NULL COMMENT '소득 구분 명' AFTER `etc_income_seq`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_required_rate` VARCHAR(32) NULL COMMENT '필요 경비율' AFTER `etc_income_name`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_required_amt` BIGINT(64) NULL COMMENT '필요 경비 금액' AFTER `etc_required_rate`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_income_amt` BIGINT(64) NULL COMMENT '소득금액' AFTER `etc_required_amt`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_income_vat_amt` BIGINT(64) NULL COMMENT '소득세액' AFTER `etc_income_amt`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_resident_vat_amt` BIGINT(64) NULL COMMENT '주민세액' AFTER `etc_income_vat_amt`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_belong_year` VARCHAR(10) NULL COMMENT '귀속년도' AFTER `etc_resident_vat_amt`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_belong_month` VARCHAR(6) NULL COMMENT '귀속 월' AFTER `etc_belong_year`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_tax_code` VARCHAR(3) NULL COMMENT '[U] 불공제 사유 코드' AFTER `etc_belong_month`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_tax_name` VARCHAR(64) NULL COMMENT '[U] 불공제 사유 명 ' AFTER `no_tax_code`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `interface_type` VARCHAR(8) NULL COMMENT '외부 시스템 연동 타입' AFTER `no_tax_name`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `interface_seq` VARCHAR(32) NULL COMMENT '외부 시스템 연동 키' AFTER `interface_type`;

/*  - 원인행위 정보 t_exnp_cause 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_cause` (
  `cause_seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '원인행위 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_dt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_dt` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cause_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `neos`.`t_exnp_cause` ADD COLUMN IF NOT EXISTS `res_seq` VARCHAR(32) NULL COMMENT '결의서 키 [t_exnp_reshead.res_seq]' AFTER `cause_seq`;
ALTER TABLE `neos`.`t_exnp_cause` ADD COLUMN IF NOT EXISTS `cause_date` VARCHAR(8) NULL COMMENT '원인행위 일자' AFTER `res_seq`;
ALTER TABLE `neos`.`t_exnp_cause` ADD COLUMN IF NOT EXISTS `sign_date` VARCHAR(32) NULL COMMENT '계약일자' AFTER `cause_date`;
ALTER TABLE `neos`.`t_exnp_cause` ADD COLUMN IF NOT EXISTS `inspect_date` VARCHAR(8) NULL COMMENT '검수일자' AFTER `sign_date`;
ALTER TABLE `neos`.`t_exnp_cause` ADD COLUMN IF NOT EXISTS `cause_emp_seq` VARCHAR(32) NULL COMMENT '원인행위자 ERP 사원 코드' AFTER `inspect_date`;
ALTER TABLE `neos`.`t_exnp_cause` ADD COLUMN IF NOT EXISTS `cause_emp_name` VARCHAR(32) NULL COMMENT '원인행위자 ERP 사원 명' AFTER `cause_emp_seq`;

/*  - 품의 조회권한 1.0 [미사용] t_exnp_consauth 테이블 생성*/
CREATE TABLE IF NOT EXISTS `t_exnp_consauth` (
  `auth_seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '품의서 조회 권한 순번',
  `emp_seq` VARCHAR(32) NOT NULL COMMENT 'GW 사원 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_dt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_dt` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`auth_seq`,`emp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `neos`.`t_exnp_consauth` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT 'GW 회사 시퀀스' AFTER `auth_seq`;
ALTER TABLE `neos`.`t_exnp_consauth` ADD COLUMN IF NOT EXISTS `gbn_org` VARCHAR(2) NULL COMMENT '권한 구분 c:회사, b: 사업장, d:부서, u:사용자' AFTER `emp_seq`;
ALTER TABLE `neos`.`t_exnp_consauth` ADD COLUMN IF NOT EXISTS `seq` VARCHAR(32) NULL COMMENT '권한 구분에 따른 키' AFTER `gbn_org`;

/*  - 양식정보 t_exnp_form 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_form` (
  `form_seq` VARCHAR(32) NOT NULL,
  `comp_seq` VARCHAR(32) NOT NULL,
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` DATETIME DEFAULT NULL,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` DATETIME DEFAULT NULL,
  PRIMARY KEY (`form_seq`,`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `neos`.`t_exnp_form` ADD COLUMN IF NOT EXISTS `form_content` TEXT  COMMENT '원본 양식 폼' AFTER `comp_seq`;
ALTER TABLE `neos`.`t_exnp_form` ADD COLUMN IF NOT EXISTS `form_change_content` TEXT  COMMENT '클래스 보정 처리된 실제 사용 폼' AFTER `form_content`;

/*  - 양식코드정보 t_exnp_form_code 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_form_code` (
  `code` VARCHAR(288) DEFAULT NULL,
  `code_name` VARCHAR(576) DEFAULT NULL,
  `code_gbn` VARCHAR(288) DEFAULT NULL,
  `use_yn` CHAR(9) DEFAULT NULL,
  `required_yn` CHAR(9) DEFAULT NULL,
  `create_seq` VARCHAR(288) DEFAULT NULL,
  `create_date` DATETIME DEFAULT NULL,
  `modify_seq` VARCHAR(288) DEFAULT NULL,
  `modify_date` DATETIME DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/*  - 양식 샘플 정보 t_exnp_form_sample 테이블 생성*/
CREATE TABLE IF NOT EXISTS `t_exnp_form_sample` (
  `seq` INT(11) DEFAULT NULL,
  `comp_seq` VARCHAR(288) DEFAULT NULL,
  `sample_name` VARCHAR(2295) DEFAULT NULL,
  `sample_content` TEXT,
  `create_seq` VARCHAR(288) DEFAULT NULL,
  `create_date` DATETIME DEFAULT NULL,
  `modify_seq` VARCHAR(288) DEFAULT NULL,
  `modify_date` DATETIME DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/*  - 비영리 회계 모듈 옵션 t_exnp_option 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_option` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 회사시퀀스 ( 기본 0 )',
  `form_seq` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 양식코드 ( 기본 0 )',
  `option_gbn` VARCHAR(32) NOT NULL COMMENT '옵션 구분 코드',
  `option_code` VARCHAR(32) NOT NULL COMMENT '옵션 상세 코드', 
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`comp_seq`,`form_seq`,`option_gbn`,`option_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `note` VARCHAR(128) NULL COMMENT '옵션 설명' AFTER `option_code`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `use_sw` VARCHAR(32) NULL COMMENT '옵션 귀속 연동 시스템' AFTER `note`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `order_num` VARCHAR(32) NULL COMMENT '정렬순서' AFTER `use_sw`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `common_code` VARCHAR(32) NULL COMMENT '공통코드' AFTER `order_num`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `base_value` VARCHAR(32) NULL COMMENT '옵션 기본 설정 코드' AFTER `common_code`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `base_name` VARCHAR(32) NULL COMMENT '옵션 기본 설정' AFTER `base_value`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `base_emp_value` VARCHAR(32) NULL COMMENT '옵션 기본 설정 사용자 정의' AFTER `base_name`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `set_value` VARCHAR(32) NULL COMMENT '옵션 설정 코드' AFTER `base_emp_value`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `set_name` VARCHAR(128) NULL COMMENT '옵션 설정 명칭' AFTER `set_value`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `set_emp_value` VARCHAR(128) NULL COMMENT '옵션 설정 사용자 정의' AFTER `set_name`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `option_select_type` VARCHAR(32) NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )' AFTER `set_emp_value`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `option_process_type` VARCHAR(32) NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )' AFTER `option_select_type`;
ALTER TABLE `neos`.`t_exnp_option` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(32) NULL COMMENT '사용여부' AFTER `option_process_type`;


/*  - 비영리 회부시스템 연동 테이블 t_exnp_out_process 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_out_process` (
  `interface_id` VARCHAR(32) NOT NULL COMMENT '외부 연동 구분 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,    
  PRIMARY KEY (`interface_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `neos`.`t_exnp_out_process` ADD COLUMN IF NOT EXISTS `iframe_url` VARCHAR(1024) NULL COMMENT '외부 연동 iframe url ( outProcessInterfaceId, outProcessInterfaceMId, outProcessInterfaceDId, consDocSeq, resDocSeq )' AFTER `interface_id`;
ALTER TABLE `neos`.`t_exnp_out_process` ADD COLUMN IF NOT EXISTS `iframe_height` VARCHAR(4) NULL COMMENT '외부 연동 iframe 높이' AFTER `iframe_url`;
ALTER TABLE `neos`.`t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_form` VARCHAR(1024) NULL COMMENT '외부 연동 본문 호출할 URL 정의' AFTER `iframe_height`;
ALTER TABLE `neos`.`t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_save` VARCHAR(1024) NULL COMMENT '임시보관시 호출할 URL 정의' AFTER `interface_call_form`;
ALTER TABLE `neos`.`t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_approval` VARCHAR(1024) NULL COMMENT '상신시 호출할 URL 정의' AFTER `interface_call_save`;
ALTER TABLE `neos`.`t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_return` VARCHAR(1024) NULL COMMENT '반려시 호출할 URL 정의' AFTER `interface_call_approval`;
ALTER TABLE `neos`.`t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_end` VARCHAR(1024) NULL COMMENT '종결시 호출할 URL 정의' AFTER `interface_call_return`;
ALTER TABLE `neos`.`t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_delete` VARCHAR(1024) NULL COMMENT '삭제시 호출할 URL 정의' AFTER `interface_call_end`;
ALTER TABLE `neos`.`t_exnp_out_process` ADD COLUMN IF NOT EXISTS `licence` VARCHAR(64) NULL COMMENT '라이센스 키' AFTER `interface_call_delete`;


/*  - 비영리 회부시스템 연동 테이블 t_exnp_out_process_his 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_out_process_his` (
  `seq` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '호출 시퀀스',
  `create_seq` VARCHAR(32) NOT NULL COMMENT '생성자',
  `create_date` DATETIME NOT NULL COMMENT '생성일자',
  `modify_seq` VARCHAR(32) NOT NULL COMMENT '수정자',
  `modify_date` DATETIME NOT NULL COMMENT '수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `neos`.`t_exnp_out_process_his` ADD COLUMN IF NOT EXISTS `interface_type` VARCHAR(8) NULL COMMENT '호출 타입 ( process id )' AFTER `seq`;
ALTER TABLE `neos`.`t_exnp_out_process_his` ADD COLUMN IF NOT EXISTS `approval_status_code` VARCHAR(8) NULL COMMENT '전자결재 상태 값' AFTER `interface_type`;
ALTER TABLE `neos`.`t_exnp_out_process_his` ADD COLUMN IF NOT EXISTS `interface_url` VARCHAR(8) NULL COMMENT 'API 호출 URL' AFTER `approval_status_code`;
ALTER TABLE `neos`.`t_exnp_out_process_his` ADD COLUMN IF NOT EXISTS `interface_param` VARCHAR(8) NULL COMMENT 'API 전달 파라미터' AFTER `interface_url`;


/* ERPiU 기타소득자, 사업소득자 연동 정보 ( 지급일자, 귀속년월 ) */
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_belong_date` VARCHAR(8) NULL COMMENT 'ERPiU 기타,사업소득자 지급일자' AFTER `etc_belong_month`;
ALTER TABLE `neos`.`t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_belong_yearmonth` VARCHAR(8) NULL COMMENT 'ERPiU 기타,사업소득자 귀속년월' AFTER `etc_belong_date`;

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 06. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 14. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 21. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

CREATE TABLE IF NOT EXISTS `t_exnp_code_seq` (
  `seq` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '양식 코드 시퀀스',
   PRIMARY KEY (`seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;