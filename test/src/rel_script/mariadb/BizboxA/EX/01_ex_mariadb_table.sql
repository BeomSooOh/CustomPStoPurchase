/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 11. 22. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 지출결의 테이블 추가 */

/* t_ex_acct */
CREATE TABLE IF NOT EXISTS `t_ex_acct` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `acct_name` VARCHAR(60) DEFAULT NULL COMMENT '계정과목 명칭';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `vat_yn` VARCHAR(20) DEFAULT NULL COMMENT '부가세 계정 여부 ( Y : 부가세 계정 / N : 부가세 계정 아님 )';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `modify_date`  DATETIME DEFAULT NULL COMMENT '최종 수정 일자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `test`  DATETIME DEFAULT NULL COMMENT '최종 수정 ';

/* t_ex_auth */
CREATE TABLE IF NOT EXISTS `t_ex_auth` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT 'iCUBE사유구분 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE사유구분 명';

/* t_ex_card */
CREATE TABLE IF NOT EXISTS `t_ex_card` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_num` VARCHAR(20) NOT NULL COMMENT '카드번호';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_name` VARCHAR(120) DEFAULT NULL COMMENT '카드명칭';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드 ( ERPiU 전용 사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '금융거래처 명청 ( ERPiU 전용 사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_public_json` LONGTEXT COMMENT '공개범위 설정 JSON 문자열';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_expend_auth */
CREATE TABLE IF NOT EXISTS `t_ex_expend_auth` (
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
) ENGINE=INNODB AUTO_INCREMENT=833 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_div` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_code` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `erp_auth_code` VARBINARY(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `erp_auth_code` VARBINARY(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '불공제구분 코드 ( ERP 정보 ERPiU )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_expend_budget */
CREATE TABLE IF NOT EXISTS `t_ex_expend_budget` (
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
) ENGINE=INNODB AUTO_INCREMENT=464 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_type` VARCHAR(32) DEFAULT NULL COMMENT '예산연동 구분 ( iCUBE 사용 : P / D )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bud_ym` VARBINARY(32) DEFAULT NULL COMMENT '예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_ym` VARCHAR(8) DEFAULT NULL COMMENT '귀속 예산년월';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_gbn` VARCHAR(32) DEFAULT NULL COMMENT '예산통제구분 ( P / D >> iCUBE )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_code` VARCHAR(32) DEFAULT NULL COMMENT '예산단위 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_name` VARCHAR(128) DEFAULT NULL COMMENT '예산단위 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bizplan_code` VARCHAR(32) DEFAULT NULL COMMENT '사업계획 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bizplan_name` VARCHAR(128) DEFAULT NULL COMMENT '사업계획 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bgacct_code` VARCHAR(32) DEFAULT NULL COMMENT '예산계정 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bgacct_name` VARCHAR(128) DEFAULT NULL COMMENT '예산계정 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_jsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산집행 금액 ( 편성 + 조정 금액 )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_actsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산 실행합 금액 ( 사용예산 금액 )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_control_yn` VARCHAR(32) DEFAULT NULL COMMENT '예산 통제여부';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_card */
CREATE TABLE IF NOT EXISTS `t_ex_expend_card` (
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
) ENGINE=INNODB AUTO_INCREMENT=715 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드코드 ( iCUBE 는 카드코드 존재, ERPiU 는 카드코드 미존재하므로 카드번호로 대체 )';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_num` VARCHAR(32) DEFAULT NULL COMMENT '카드 번호';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_name` VARCHAR(128) DEFAULT NULL COMMENT '카드 명칭';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_emp */
CREATE TABLE IF NOT EXISTS  `t_ex_expend_emp` (
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
) ENGINE=INNODB AUTO_INCREMENT=2746 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 회사 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_comp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_comp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회사 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `biz_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사업장 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `biz_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사업장 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_biz_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사업장 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `dept_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 부서 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `dept_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 부서 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_dept_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 부서 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사원 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사원 명';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_emp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사원 명';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_pc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회계단위 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_pc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회계단위 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_cc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 코스트센터 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_cc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 코스트센터 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_patner */
CREATE TABLE IF NOT EXISTS  `t_ex_expend_partner` (
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
) ENGINE=INNODB AUTO_INCREMENT=716 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처 코드';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_name` VARCHAR(128) DEFAULT NULL COMMENT '거래처 명칭';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '사업자 등록 번호';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_fg` VARCHAR(32) DEFAULT NULL COMMENT '거래처 종류';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `ceo_name` VARCHAR(128) DEFAULT NULL COMMENT '대표자명';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '업태';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `cls_job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '종목';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `deposit_no` VARCHAR(64) DEFAULT NULL COMMENT '계좌번호';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `bank_code` VARCHAR(32) DEFAULT NULL COMMENT '은행코드';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_emp_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_hp_emp_no` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자연락처';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `deposit_name` VARCHAR(64) DEFAULT NULL COMMENT '예금주';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `deposit_convert` VARCHAR(128) DEFAULT NULL COMMENT '관리항목';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_project */
CREATE TABLE IF NOT EXISTS  `t_ex_expend_project` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 프로젝트 시퀀스',
  `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드',
  `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=766 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_summary */
CREATE TABLE IF NOT EXISTS `t_ex_expend_summary` (
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
) ENGINE=INNODB AUTO_INCREMENT=964 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_code` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 게정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융거래처 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_vat */
CREATE TABLE IF NOT EXISTS `t_ex_expend_vat` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `vat_type_code` INT(11) DEFAULT NULL COMMENT '부가세구분 그룹웨어 코드 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `vat_type_name` VARCHAR(100) DEFAULT NULL COMMENT '부가세구분 그룹웨어 명 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `va_type_code` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `va_type_name` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `mutual_code` VARCHAR(20) DEFAULT NULL COMMENT '불공제/사유 ERP 코드 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `mutual_name` VARCHAR(100) DEFAULT NULL COMMENT '불공제/사유 ERP 명 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `iss_yn` VARCHAR(20) DEFAULT NULL COMMENT '전자세금계산서 여부 ERP 코드 ( ERP IU : 종이세금계산서 ( 0 ), 전자세금계산서 ( 2 ) / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `jeonjasend_yn` VARCHAR(20) DEFAULT NULL COMMENT '국세청전송11일이내 여부 ERP 코드 ( ERP IU : 전송 ( 0 ), 미전송 ( 1 ) / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tex_md` VARCHAR(4) DEFAULT NULL COMMENT '품목정보 월/일 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `item_name` VARCHAR(50) DEFAULT NULL COMMENT '품목정보 품명 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `size_name` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 규격 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tax_qt` DECIMAL(17,4) DEFAULT NULL COMMENT '품목정보 수량 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `prc_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 단가 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `supply_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 공급가액 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tax_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 부가세액 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `note_nm` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 비고 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `create_user_seq` INT(11) DEFAULT NULL COMMENT '작성자 그룹웨어 아이디';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '작성일자';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `modify_user_seq` INT(11) DEFAULT NULL COMMENT '수정자 그룹웨어 아이디';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자';

/* t_ex_item */
CREATE TABLE IF NOT EXISTS `t_ex_item` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `langpack_name` VARCHAR(100) DEFAULT NULL COMMENT '명칭';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `order_num` INT(11) DEFAULT NULL COMMENT '정렬 순서';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `display_align` VARCHAR(10) DEFAULT NULL COMMENT '정렬 표현 방법';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `head_code` VARCHAR(100) DEFAULT NULL COMMENT '그리드 헤더 키';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `select_yn` VARCHAR(1) DEFAULT NULL COMMENT '기본키 여부';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_langpack */
CREATE TABLE IF NOT EXISTS `t_ex_langpack` (
  `comp_seq` INT(11) NOT NULL COMMENT '회사시퀀스',
  `langpack_code` VARCHAR(100) NOT NULL COMMENT '명칭코드',
  `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름',
  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`langpack_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '생성일';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일';

/* t_ex_langpack_multi */
CREATE TABLE IF NOT EXISTS `t_ex_langpack_multi` (
  `comp_seq` INT(11) NOT NULL COMMENT '회사시퀀스',
  `langpack_code` VARCHAR(100) NOT NULL COMMENT '명칭코드',
  `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름',
  `lang_code` VARCHAR(4) NOT NULL COMMENT '언어코드',
  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`langpack_code`,`lang_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름';
ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `create_seq` INT(11) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '생성일';
ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일';

/* t_ex_mng_option */
CREATE TABLE IF NOT EXISTS  `t_ex_mng_option` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `mng_name` VARCHAR(100) DEFAULT NULL COMMENT '관리항목명';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `use_gbn` VARCHAR(20) DEFAULT NULL COMMENT '사용구분';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력코드';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `ctd_name` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력명';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `note` VARCHAR(512) DEFAULT NULL COMMENT '비고 ( 툴팁활용 )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `cust_set` VARCHAR(4000) DEFAULT NULL COMMENT '커스터마이징을 위한 컬럼';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `cust_set_target` VARCHAR(32) DEFAULT NULL COMMENT '조회 대상 ( BizboxA, iCUBE, ERPiU )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `modify_yn` VARCHAR(32) DEFAULT NULL COMMENT '수정가능 여부 ( 전용개발인 경우, 사용자에 의한 삭제 및 수정이 불가해야 함 )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '생성일';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일';

/* t_ex_option_multi */
CREATE TABLE IF NOT EXISTS  `t_ex_option_multi` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `option_name` VARCHAR(512) DEFAULT NULL COMMENT '옵션 명칭';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `option_note` VARCHAR(1024) DEFAULT NULL COMMENT '옵션 설명';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_option */
CREATE TABLE IF NOT EXISTS  `t_ex_option` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `order_num` DECIMAL(65,0) DEFAULT NULL COMMENT '정렬순서';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `common_code` VARCHAR(32) DEFAULT NULL COMMENT '공통코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `base_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 기본 설정 코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `base_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 명칭';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `base_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 사용자 정의';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `set_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 설정 코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `set_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 명칭';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `set_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 사용자 정의';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `option_select_type` VARCHAR(32) DEFAULT NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `option_process_type` VARCHAR(32) DEFAULT NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_summary */
CREATE TABLE IF NOT EXISTS  `t_ex_summary` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 게정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 계정과목 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융 거래처 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융 거래처 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최총 수정 일자';

/* t_ex_vat */
CREATE TABLE IF NOT EXISTS  `t_ex_vat` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `vat_code` VARCHAR(20) NOT NULL COMMENT '세무구분 코드',
  `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`comp_seq`,`vat_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_card_aq_tmp */
CREATE TABLE IF NOT EXISTS `t_ex_card_aq_tmp` (
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
) ENGINE=INNODB AUTO_INCREMENT=44221 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `owner_reg_no` VARCHAR(10) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `card_code` VARCHAR(3) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `card_name` VARCHAR(20) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `user_name` VARCHAR(30) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `auth_time` CHAR(6) NOT NULL COMMENT '승인시간';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `aqui_date` CHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `georae_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `georae_stat` VARCHAR(4) DEFAULT NULL COMMENT '승인(1) / 취소(!1) 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `georae_cand` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `request_amount` DECIMAL(19,0) NOT NULL COMMENT '공급대가';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `amt_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '공급가액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `vat_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '부가세액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `ser_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '서비스금액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `fre_amount` DECIMAL(19,0) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `amt_md_amount` DECIMAL(19,0) NOT NULL COMMENT '공급가액 ( 벤더사 재가공 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `vat_md_amount` DECIMAL(19,0) NOT NULL COMMENT '부가세액 ( 벤더사 재가공 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `georae_gukga` VARCHAR(3) DEFAULT NULL COMMENT '거래국가 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `for_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `usd_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액 ( 달러 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_saup_no` VARCHAR(10) DEFAULT NULL COMMENT '거래처 사업자 등록 번호';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_addr` VARCHAR(256) DEFAULT NULL COMMENT '거래처 주소';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_repr` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_tel` VARCHAR(20) DEFAULT NULL COMMENT '거래처 연락처';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_zip` VARCHAR(6) DEFAULT NULL COMMENT '거래처 우편번호';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `mcc_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `mcc_code` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `mcc_stat` VARCHAR(2) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `vat_stat` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `can_date` VARCHAR(8) DEFAULT NULL COMMENT '승인 취소 일자';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `ask_site` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `site_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `ask_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `ask_time` VARCHAR(6) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `gongje_no_chk` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `first_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `cancel_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `abroad` VARCHAR(1) DEFAULT NULL COMMENT '국내(A) / 해외(B) 사용 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `van_created_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `van_edited_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `created_by` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `created_dt` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `edited_dt` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `edited_by` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `edited_action` VARCHAR(256) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `createdate` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `createtime` VARCHAR(6) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `sett_date` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `org_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `aqui_rate` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `conversion_fee` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `auth_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `auth_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `summary_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `summary_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `pjt_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `pjt_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `detail` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `if_m_id` VARCHAR(32) DEFAULT '''0''' COMMENT '외부연동 아이디';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `if_d_id` VARCHAR(32) DEFAULT '''0''' COMMENT '외부연동 아이디';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `app_div` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `doc_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '전자결재 시퀀스';

/* t_ex_etax_aq_tmp */
CREATE TABLE IF NOT EXISTS `t_ex_etax_aq_tmp` (
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
) ENGINE=INNODB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `iss_dt` VARCHAR(8) DEFAULT NULL COMMENT '작성일자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '공급자 사업자 등록번호';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `send_yn` VARCHAR(32) DEFAULT NULL COMMENT '상신여부';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `note` VARCHAR(256) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `if_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 키';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `if_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 키';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '생성일자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자';

/* t_ex_expend */
CREATE TABLE IF NOT EXISTS `t_ex_expend` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '귀속 회사 시퀀스';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '전자결재 아이디';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `form_seq` VARCHAR(32) DEFAULT NULL COMMENT '양식 시퀀스';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `expend_stat_code` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 상태 코드';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `expend_date` VARCHAR(8) DEFAULT NULL COMMENT '결의일자 ( 회계일자, 예산년월 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `expend_req_date` VARCHAR(8) DEFAULT NULL COMMENT '지급요청일자 ( 만기일자 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `erp_send_yn` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 전송 상태';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 JSON 문자열';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `erp_send_seq` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 ERP 전송자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `erp_send_date` DATETIME DEFAULT NULL COMMENT '지출결의 ERP 전송일';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU 자동전표 연동 아이디';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `in_dt` VARCHAR(8) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 마스터 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `in_sq` INT(11) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 디테일 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';
 
 /* t_ex_expend_list */
CREATE TABLE IF NOT EXISTS `t_ex_expend_list` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급가액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '부가세액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급대가';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 항목 JSON 문자열';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_slip */
CREATE TABLE IF NOT EXISTS `t_ex_expend_slip` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `summary_seq` VARCHAR(32) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `auth_seq` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `write_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `budget_seq` VARCHAR(32) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `project_seq` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `partner_seq` VARCHAR(32) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `card_seq` VARCHAR(32) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `drcr_gbn` VARCHAR(32) DEFAULT NULL COMMENT '차변, 대변 구분값';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `acct_code` VARCHAR(64) DEFAULT NULL COMMENT '계정과목 코드';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `acct_name` VARCHAR(128) DEFAULT NULL COMMENT '계정과목 명칭';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '금액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KYE 1';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `row_no` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KEY 2';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 JSON 문자열';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/*t_ex_expend_mng */
CREATE TABLE IF NOT EXISTS `t_ex_expend_mng` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 코드';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_name` VARCHAR(40) DEFAULT NULL COMMENT '관리항목 명';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_form_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 표현 형태 ( ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_child_yn` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 하위 코드 존재 여부 ( ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_stat` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 필수 여부 ( iCUBE, ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '사용자 입력 관리항목 코드';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `ctd_name` VARCHAR(100) DEFAULT NULL COMMENT '사용자 입력 관리항목 명칭';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 관리항목 JSON 문자열';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 12. 26. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 지출결의 테이블 추가 */

 /* t_ex_cms_sync */
CREATE TABLE IF NOT EXISTS `t_ex_cms_sync` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT 'CMS 연동 귀속 회사 시퀀스',
  `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부',
  `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부',
  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부',
  `cms_base_date` VARCHAR(8) DEFAULT NULL COMMENT '연동시작 기준일',
  `cms_base_day` VARCHAR(2) DEFAULT '7' COMMENT '연동시작 기준일자',
  `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부' AFTER `comp_seq`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부' AFTER `cms_sync_yn`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부' AFTER `cms_batch_yn`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_base_date` VARCHAR(8) DEFAULT NULL COMMENT '연동시작 기준일' AFTER `cms_process_yn`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_base_day` VARCHAR(2) DEFAULT '7' COMMENT '연동시작 기준일자' AFTER `cms_base_date`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자' AFTER `cms_base_day`;

/* t_expend_log */
CREATE TABLE IF NOT EXISTS `t_expend_log` (
  `batch_seq` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'batch 실행 로그 순번',
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '로그 귀속 회사 시퀀스',
  `module_type` VARCHAR(32) NOT NULL COMMENT 'module 구분',
  `log_type` VARCHAR(32) NOT NULL COMMENT 'log 구분',
  `message` VARCHAR(1024) NOT NULL COMMENT 'log 메시지',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`batch_seq`)
) ENGINE=INNODB AUTO_INCREMENT=12511 DEFAULT CHARSET=utf8;

ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `comp_seq` VARCHAR(32) NOT NULL COMMENT '로그 귀속 회사 시퀀스' AFTER `batch_seq`;
ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `module_type` VARCHAR(32) NOT NULL COMMENT 'module 구분' AFTER `comp_seq`;
ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `log_type` VARCHAR(32) NOT NULL COMMENT 'log 구분' AFTER `module_type`;
ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `message` VARCHAR(1024) NOT NULL COMMENT 'log 메시지' AFTER `log_type`;
ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자' AFTER `message`;

ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `dracct_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '사용금액' AFTER `bgacct_name`;

/* 2016-12-27 데이터 형 수정 */
ALTER TABLE `t_ex_expend_auth` CHANGE `erp_auth_code` `erp_auth_code` VARCHAR(64) NULL  COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';

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

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 04. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 05. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 16. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 17. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 23. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017-01-25 카드사용내역 테이블 기본값 수정 (신재호) */
ALTER TABLE `t_ex_card_aq_tmp` 
CHANGE `if_m_id` `if_m_id` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '외부연동 아이디'
, CHANGE `if_d_id` `if_d_id` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '외부연동 아이디'
, CHANGE `del_yn` `del_yn` VARCHAR(20) CHARSET utf8 COLLATE utf8_general_ci DEFAULT 'N' NULL COMMENT '삭제 처리 여부 ( Y / !Y )'
, CHANGE `user_send_yn` `user_send_yn` VARCHAR(20) CHARSET utf8 COLLATE utf8_general_ci DEFAULT 'N' NULL COMMENT '관리자 마감 처리 구분 ( Y / !Y )'
, CHANGE `emp_seq` `emp_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '사용자정보 시퀀스'
, CHANGE `summary_seq` `summary_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '표준적요정보 시퀀스'
, CHANGE `auth_seq` `auth_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '증빙유형정보 시퀀스'
, CHANGE `project_seq` `project_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '프로젝트정보 시퀀스'
, CHANGE `budget_seq` `budget_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '예산정보 시퀀스'
, CHANGE `doc_seq` `doc_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '전자결재 시퀀스';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 01. 25. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017-02-09 표준적요 설정 시 정렬 순서 추가 */
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `order_num` DECIMAL(10,0) NULL COMMENT '정렬순서' AFTER `modify_date`;

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 02. 13. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017-02-16 버튼 설정 테이블 수정 (신재호) - 버튼 명칭 추가 및 null 여부 변경 */
DROP TABLE t_ex_langpack_multi;
DROP TABLE t_ex_langpack;
CREATE TABLE `t_ex_langpack`( 
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사 시퀀스'
  , `lang_type` VARCHAR(5) NOT NULL COMMENT '언어 타입'
  , `lang_code` VARCHAR(50) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '명칭 코드'
  , `basic_name` VARCHAR(50) NOT NULL COMMENT '기본 명칭'
  , `langpack_code` VARCHAR(50) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '다국어 코드'
  , `lang_name` VARCHAR(50) NOT NULL COMMENT '명칭'
  , `create_seq` INT(11) NOT NULL COMMENT '생성자'
  , `create_date` DATETIME NOT NULL COMMENT '생성일'
  , `modify_seq` INT(11) NOT NULL COMMENT '수정자'
  , `modify_date` DATETIME NOT NULL COMMENT '수정일'
  , PRIMARY KEY (`comp_seq`,  `lang_type`, `lang_code`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci;

/* 2017-02-20 CMS 커스텀 사용 여부 컬럼 추가 (구민기) */
ALTER TABLE `t_ex_cms_sync` ADD COLUMN IF NOT EXISTS  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부' AFTER `cms_batch_yn`;
ALTER TABLE `t_ex_cms_sync` ADD COLUMN IF NOT EXISTS `custom_yn` VARCHAR(2) DEFAULT 'N'  NOT NULL  COMMENT '커스텀 사용 여부( Y : 사용 / N : 미사용)' AFTER `cms_process_yn`;

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 02. 24. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 03. 08. */
/* 2017. 03. 08. - 신재호 */
/* 2017. 03. 08. - 신재호 - 지출결의 수정내역 이력 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_expend_history`(
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 Seq'
  , `history_seq` INT NOT NULL AUTO_INCREMENT COMMENT '변경내역 Seq'
  , `history_info` LONGTEXT COMMENT '변경내역 정보'
  , `doc_seq` VARCHAR(32) COMMENT '문서 Seq'
  , `create_seq` VARCHAR(32) NOT NULL COMMENT '변경자 사번'
  , `create_date` DATETIME NOT NULL COMMENT '변경시간'
  , KEY(`history_seq`)
  , PRIMARY KEY (`expend_seq`, `history_seq`) 
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `history_info` VARCHAR(32) COMMENT '변경내역 정보' AFTER `history_seq`;
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `doc_seq` VARCHAR(32) COMMENT '문서 Seq' AFTER `history_info`;
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `create_seq` VARCHAR(32) NOT NULL COMMENT '변경자 사번' AFTER `doc_seq`;
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `create_date` VARCHAR(32) NOT NULL COMMENT '변경시간' AFTER `create_date`;

/* 2017-03-20 카드 권한 테이블 org_id 생성 (김상겸) */
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS  `org_id` VARCHAR(32) DEFAULT NULL COMMENT '대상아이디' AFTER `org_div`;

/* 2017-03-20 카드 권한 테이블 org_id 변경 (신재호) */
ALTER TABLE `t_ex_card_public` CHANGE `org_id` `org_id` VARCHAR(32) NOT NULL COMMENT '대상아이디';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 03. 21. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 04. 11. */
/* 2017. 04. 11. - 김상겸 */
/* 2017. 04. 11. - 김상겸 - 비영리 결재 버전 미배포로 인한 테이블 재배포 */
/* table create */
/* t_ex_acct */
CREATE TABLE IF NOT EXISTS `t_ex_acct` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `acct_name` VARCHAR(60) DEFAULT NULL COMMENT '계정과목 명칭';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `vat_yn` VARCHAR(20) DEFAULT NULL COMMENT '부가세 계정 여부 ( Y : 부가세 계정 / N : 부가세 계정 아님 )';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_auth */
CREATE TABLE IF NOT EXISTS `t_ex_auth` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT 'iCUBE사유구분 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE사유구분 명';

/* t_ex_button */
CREATE TABLE IF NOT EXISTS `t_ex_button` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT 't_co_comp / comp_seq',
  `form_seq` INT(11) NOT NULL COMMENT 'teag_form / form_id',
  `page_seq` INT(11) NOT NULL COMMENT '지출결의 상신 페이지 : 10',
  `btn_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '자동증가 버튼 시퀀스',
  `position` INT(11) DEFAULT NULL COMMENT '버튼 위치 최상단 : 10, 항목 : 20, 분개 : 30, 관리항목 : 40',
  `order_num` INT(11) DEFAULT NULL COMMENT '버튼정렬순서, 값에는 연속성이 없음, ASC',
  `display_yn` CHAR(1) DEFAULT NULL COMMENT '버튼 출력여부 [Y,N]',
  `license_yn` CHAR(1) DEFAULT NULL COMMENT '버튼 라이선스여부 [Y,N]',
  `btn_size` INT(11) DEFAULT NULL COMMENT '버튼사이즈(width) N px;',
  `nm_basic` VARCHAR(32) DEFAULT NULL COMMENT '버튼기본 명칭',
  `nm_kr` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 한글',
  `nm_en` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 영어',
  `nm_jp` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 일본어',
  `nm_cn` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 중국어',
  `default_yn` CHAR(1) DEFAULT NULL COMMENT '기본버튼여부 [Y,N]',
  `default_code` VARCHAR(32) DEFAULT NULL COMMENT '버튼별 통합 코드',
  `call_url` TEXT COMMENT '커스터마이징 호출 주소',
  `call_param` TEXT COMMENT '커스터마이징 호출 파라미터 json',
  `callback_url` VARCHAR(512) DEFAULT NULL COMMENT '커스터마이징 콜백 주소',
  `callback_type` INT(11) DEFAULT NULL COMMENT '커스터마이징 콜백 타입',
  `callback_key` VARCHAR(32) DEFAULT NULL COMMENT '커스터마이징 콜백 키,함수명',
  `default_elemId` VARCHAR(32) DEFAULT NULL COMMENT '버튼 엘리먼트 ID',
  `default_elemClass` VARCHAR(32) DEFAULT NULL COMMENT '버튼 엘리먼트 class',
  PRIMARY KEY (`comp_seq`,`form_seq`,`page_seq`,`btn_seq`),
  KEY `btn_seq` (`btn_seq`)
) ENGINE=INNODB AUTO_INCREMENT=1102 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `position` INT(11) DEFAULT NULL COMMENT '버튼 위치 최상단 : 10, 항목 : 20, 분개 : 30, 관리항목 : 40';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `order_num` INT(11) DEFAULT NULL COMMENT '버튼정렬순서, 값에는 연속성이 없음, ASC';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `display_yn` CHAR(1) DEFAULT NULL COMMENT '버튼 출력여부 [Y,N]';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `license_yn` CHAR(1) DEFAULT NULL COMMENT '버튼 라이선스여부 [Y,N]';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `btn_size` INT(11) DEFAULT NULL COMMENT '버튼사이즈(width) N px;';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_basic` VARCHAR(32) DEFAULT NULL COMMENT '버튼기본 명칭';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_kr` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 한글';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_en` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 영어';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_jp` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 일본어';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_cn` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 중국어';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `default_yn` CHAR(1) DEFAULT NULL COMMENT '기본버튼여부 [Y,N]';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `default_code` VARCHAR(32) DEFAULT NULL COMMENT '버튼별 통합 코드';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `call_url` TEXT COMMENT '커스터마이징 호출 주소';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `call_param` TEXT COMMENT '커스터마이징 호출 파라미터 json';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `callback_url` VARCHAR(512) DEFAULT NULL COMMENT '커스터마이징 콜백 주소';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `callback_type` INT(11) DEFAULT NULL COMMENT '커스터마이징 콜백 타입';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `callback_key` VARCHAR(32) DEFAULT NULL COMMENT '커스터마이징 콜백 키,함수명';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `default_elemId` VARCHAR(32) DEFAULT NULL COMMENT '버튼 엘리먼트 ID';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `default_elemClass` VARCHAR(32) DEFAULT NULL COMMENT '버튼 엘리먼트 class';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `btn_page` VARCHAR(32) NOT NULL COMMENT '버튼 페이지 위치' AFTER `nm_basic`;

/* t_ex_card */
CREATE TABLE IF NOT EXISTS `t_ex_card` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_num` VARCHAR(20) NOT NULL COMMENT '카드번호';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_name` VARCHAR(120) DEFAULT NULL COMMENT '카드명칭';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드 ( ERPiU 전용 사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '금융거래처 명청 ( ERPiU 전용 사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_public_json` LONGTEXT COMMENT '공개범위 설정 JSON 문자열';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_card_aq_tmp */
CREATE TABLE IF NOT EXISTS `t_ex_card_aq_tmp` (
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
  `if_m_id` VARCHAR(32) DEFAULT '0' COMMENT '외부연동 아이디',
  `if_d_id` VARCHAR(32) DEFAULT '0' COMMENT '외부연동 아이디',
  `del_yn` VARCHAR(20) DEFAULT 'N' COMMENT '삭제 처리 여부 ( Y / !Y )',
  `app_div` VARCHAR(20) DEFAULT NULL,
  `send_yn` VARCHAR(1) DEFAULT NULL COMMENT '결의 상신 구분 ( Y / !Y )',
  `user_send_yn` VARCHAR(20) DEFAULT 'N' COMMENT '관리자 마감 처리 구분 ( Y / !Y )',
  `emp_seq` VARCHAR(32) DEFAULT '0' COMMENT '사용자정보 시퀀스',
  `summary_seq` VARCHAR(32) DEFAULT '0' COMMENT '표준적요정보 시퀀스',
  `auth_seq` VARCHAR(32) DEFAULT '0' COMMENT '증빙유형정보 시퀀스',
  `project_seq` VARCHAR(32) DEFAULT '0' COMMENT '프로젝트정보 시퀀스',
  `budget_seq` VARCHAR(32) DEFAULT '0' COMMENT '예산정보 시퀀스',
  `doc_seq` VARCHAR(32) DEFAULT '0' COMMENT '전자결재 시퀀스',
  PRIMARY KEY (`sync_id`),
  KEY `card_num` (`card_num`),
  KEY `auth_date` (`auth_date`),
  KEY `auth_num` (`auth_num`),
  KEY `merc_name` (`merc_name`),
  KEY `emp_seq` (`emp_seq`,`summary_seq`,`auth_seq`,`project_seq`,`budget_seq`),
  KEY `del_yn` (`del_yn`,`send_yn`,`user_send_yn`)
) ENGINE=INNODB AUTO_INCREMENT=56819 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `owner_reg_no` VARCHAR(10) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `card_code` VARCHAR(3) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `card_name` VARCHAR(20) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `user_name` VARCHAR(30) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `auth_time` CHAR(6) NOT NULL COMMENT '승인시간';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `aqui_date` CHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `georae_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `georae_stat` VARCHAR(4) DEFAULT NULL COMMENT '승인(1) / 취소(!1) 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `georae_cand` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `request_amount` DECIMAL(19,0) NOT NULL COMMENT '공급대가';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `amt_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '공급가액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `vat_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '부가세액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `ser_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '서비스금액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `fre_amount` DECIMAL(19,0) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `amt_md_amount` DECIMAL(19,0) NOT NULL COMMENT '공급가액 ( 벤더사 재가공 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `vat_md_amount` DECIMAL(19,0) NOT NULL COMMENT '부가세액 ( 벤더사 재가공 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `georae_gukga` VARCHAR(3) DEFAULT NULL COMMENT '거래국가 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `for_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `usd_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액 ( 달러 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_saup_no` VARCHAR(10) DEFAULT NULL COMMENT '거래처 사업자 등록 번호';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_addr` VARCHAR(256) DEFAULT NULL COMMENT '거래처 주소';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_repr` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_tel` VARCHAR(20) DEFAULT NULL COMMENT '거래처 연락처';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_zip` VARCHAR(6) DEFAULT NULL COMMENT '거래처 우편번호';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `mcc_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `mcc_code` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `mcc_stat` VARCHAR(2) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `vat_stat` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `can_date` VARCHAR(8) DEFAULT NULL COMMENT '승인 취소 일자';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `ask_site` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `site_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `ask_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `ask_time` VARCHAR(6) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `gongje_no_chk` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `first_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `cancel_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `abroad` VARCHAR(1) DEFAULT NULL COMMENT '국내(A) / 해외(B) 사용 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `van_created_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `van_edited_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `created_by` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `created_dt` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `edited_dt` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `edited_by` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `edited_action` VARCHAR(256) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `createdate` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `createtime` VARCHAR(6) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `sett_date` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `org_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `aqui_rate` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `conversion_fee` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `auth_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `auth_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `summary_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `summary_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `pjt_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `pjt_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `detail` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `if_m_id` VARCHAR(32) DEFAULT '0' COMMENT '외부연동 아이디';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `if_d_id` VARCHAR(32) DEFAULT '0' COMMENT '외부연동 아이디';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `app_div` VARCHAR(20) DEFAULT NULL;

/* t_ex_card_public */
CREATE TABLE IF NOT EXISTS `t_ex_card_public` (
  `comp_seq` VARCHAR(96) DEFAULT NULL,
  `card_num` VARCHAR(90) DEFAULT NULL,
  `org_div` VARCHAR(30) DEFAULT NULL,
  `org_id` VARCHAR(32) NOT NULL COMMENT '대상아이디',
  `create_seq` VARCHAR(96) DEFAULT NULL,
  `create_dt` DATETIME DEFAULT NULL,
  `modify_seq` VARCHAR(96) DEFAULT NULL,
  `modify_dt` DATETIME DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `comp_seq` VARCHAR(96) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `card_num` VARCHAR(90) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `org_div` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `org_id` VARCHAR(32) NOT NULL COMMENT '대상아이디';
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `create_seq` VARCHAR(96) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `create_dt` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `modify_seq` VARCHAR(96) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `modify_dt` DATETIME DEFAULT NULL;

/* t_ex_cms_sync */
CREATE TABLE IF NOT EXISTS `t_ex_cms_sync` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT 'CMS 연동 귀속 회사 시퀀스',
  `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부',
  `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부',
  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부',
  `custom_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT '커스텀 사용 여부( Y : 사용 / N : 미사용)',
  `cms_base_date` VARCHAR(8) DEFAULT NULL COMMENT '연동시작 기준일',
  `cms_base_day` VARCHAR(2) DEFAULT '7' COMMENT '연동시작 기준일자',
  `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자',
  `module_type` VARCHAR(32) NOT NULL COMMENT 'module 구분',
  `log_type` VARCHAR(32) NOT NULL COMMENT 'log 구분',
  `message` VARCHAR(1024) NOT NULL COMMENT 'log 메시지',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `custom_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT '커스텀 사용 여부( Y : 사용 / N : 미사용)';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_base_date` VARCHAR(8) DEFAULT NULL COMMENT '연동시작 기준일';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_base_day` VARCHAR(2) DEFAULT '7' COMMENT '연동시작 기준일자';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `module_type` VARCHAR(32) NOT NULL COMMENT 'module 구분';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `log_type` VARCHAR(32) NOT NULL COMMENT 'log 구분';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `message` VARCHAR(1024) NOT NULL COMMENT 'log 메시지';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자';

/* t_ex_etax_aq_tmp */
CREATE TABLE IF NOT EXISTS `t_ex_etax_aq_tmp` (
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
) ENGINE=INNODB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `iss_dt` VARCHAR(8) DEFAULT NULL COMMENT '작성일자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '공급자 사업자 등록번호';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `send_yn` VARCHAR(32) DEFAULT NULL COMMENT '상신여부';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `note` VARCHAR(256) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `card_seq` INT(11) DEFAULT NULL COMMENT '카드 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `if_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 키';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `if_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 키';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '생성일자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자';

/* t_ex_expend */
CREATE TABLE IF NOT EXISTS `t_ex_expend` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '귀속 회사 시퀀스';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '전자결재 아이디';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `form_seq` VARCHAR(32) DEFAULT NULL COMMENT '양식 시퀀스';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `expend_stat_code` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 상태 코드';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `expend_date` VARCHAR(8) DEFAULT NULL COMMENT '결의일자 ( 회계일자, 예산년월 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `expend_req_date` VARCHAR(8) DEFAULT NULL COMMENT '지급요청일자 ( 만기일자 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `erp_send_yn` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 전송 상태';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 JSON 문자열';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `erp_send_seq` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 ERP 전송자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `erp_send_date` DATETIME DEFAULT NULL COMMENT '지출결의 ERP 전송일';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU 자동전표 연동 아이디';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `in_dt` VARCHAR(8) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 마스터 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `in_sq` INT(11) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 디테일 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_attach */
CREATE TABLE IF NOT EXISTS `t_ex_expend_attach` (
  `type` VARCHAR(10) NOT NULL COMMENT 'list :항목, slip : 분개',
  `expend_seq` VARCHAR(32) NOT NULL DEFAULT '0' COMMENT '문서번호',
  `list_seq` VARCHAR(32) NOT NULL DEFAULT '0' COMMENT '항목번호',
  `slip_seq` VARCHAR(32) NOT NULL DEFAULT '0' COMMENT '분개번호',
  `file_seq` VARCHAR(32) NOT NULL DEFAULT '0' COMMENT '파일번호',
  `create_seq` VARCHAR(32) NOT NULL COMMENT '생성자',
  `create_date` DATE DEFAULT NULL COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATE DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`type`,`expend_seq`,`list_seq`,`slip_seq`,`file_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_attach` ADD IF NOT EXISTS `create_seq` VARCHAR(32) NOT NULL COMMENT '생성자';
ALTER TABLE `t_ex_expend_attach` ADD IF NOT EXISTS `create_date` DATE DEFAULT NULL COMMENT '생성일자';
ALTER TABLE `t_ex_expend_attach` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_expend_attach` ADD IF NOT EXISTS `modify_date` DATE DEFAULT NULL COMMENT '수정일자';

/* t_ex_expend_auth */
CREATE TABLE IF NOT EXISTS `t_ex_expend_auth` (
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
  `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
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
) ENGINE=INNODB AUTO_INCREMENT=4935 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_div` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_code` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '불공제구분 코드 ( ERP 정보 ERPiU )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '불공제구분 명칭 ( ERP 정보 ERPiU )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_expend_budget */
CREATE TABLE IF NOT EXISTS `t_ex_expend_budget` (
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
  `dracct_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '사용금액',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=3855 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_type` VARCHAR(32) DEFAULT NULL COMMENT '예산연동 구분 ( iCUBE 사용 : P / D )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bud_ym` VARBINARY(32) DEFAULT NULL COMMENT '예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_ym` VARCHAR(8) DEFAULT NULL COMMENT '귀속 예산년월';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_gbn` VARCHAR(32) DEFAULT NULL COMMENT '예산통제구분 ( P / D >> iCUBE )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_code` VARCHAR(32) DEFAULT NULL COMMENT '예산단위 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_name` VARCHAR(128) DEFAULT NULL COMMENT '예산단위 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bizplan_code` VARCHAR(32) DEFAULT NULL COMMENT '사업계획 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bizplan_name` VARCHAR(128) DEFAULT NULL COMMENT '사업계획 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bgacct_code` VARCHAR(32) DEFAULT NULL COMMENT '예산계정 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bgacct_name` VARCHAR(128) DEFAULT NULL COMMENT '예산계정 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_jsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산집행 금액 ( 편성 + 조정 금액 )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_actsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산 실행합 금액 ( 사용예산 금액 )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_control_yn` VARCHAR(32) DEFAULT NULL COMMENT '예산 통제여부';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `dracct_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '사용금액';

/* t_ex_expend_card */
CREATE TABLE IF NOT EXISTS `t_ex_expend_card` (
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
) ENGINE=INNODB AUTO_INCREMENT=5306 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드코드 ( iCUBE 는 카드코드 존재, ERPiU 는 카드코드 미존재하므로 카드번호로 대체 )';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_num` VARCHAR(32) DEFAULT NULL COMMENT '카드 번호';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_name` VARCHAR(128) DEFAULT NULL COMMENT '카드 명칭';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_emp */
CREATE TABLE IF NOT EXISTS `t_ex_expend_emp` (
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
) ENGINE=INNODB AUTO_INCREMENT=15335 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 회사 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_comp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_comp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회사 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `biz_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사업장 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `biz_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사업장 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_biz_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사업장 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `dept_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 부서 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `dept_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 부서 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_dept_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 부서 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사원 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사원 명';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_emp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사원 명';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_pc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회계단위 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_pc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회계단위 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_cc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 코스트센터 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_cc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 코스트센터 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_history */
CREATE TABLE IF NOT EXISTS `t_ex_expend_history` (
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 Seq',
  `history_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '변경내역 Seq',
  `history_info` LONGTEXT COMMENT '변경내역 정보',
  `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '문서 Seq',
  `create_seq` VARCHAR(32) NOT NULL COMMENT '변경자 사번',
  `create_date` DATETIME NOT NULL COMMENT '변경시간',
  PRIMARY KEY (`expend_seq`,`history_seq`),
  KEY `history_seq` (`history_seq`)
) ENGINE=INNODB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `history_info` LONGTEXT COMMENT '변경내역 정보';
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '문서 Seq';
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `create_seq` VARCHAR(32) NOT NULL COMMENT '변경자 사번';
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `create_date` DATETIME NOT NULL COMMENT '변경시간';

/* t_ex_expend_list */
CREATE TABLE IF NOT EXISTS `t_ex_expend_list` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `note` VARCHAR(100) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급가액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '부가세액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급대가';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 항목 JSON 문자열';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_mng */
CREATE TABLE IF NOT EXISTS `t_ex_expend_mng` (
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
  `real_mng_code` VARCHAR(32) DEFAULT NULL COMMENT '실제 연동 관리항목 코드',
  PRIMARY KEY (`expend_seq`,`list_seq`,`slip_seq`,`mng_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 코드';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_name` VARCHAR(40) DEFAULT NULL COMMENT '관리항목 명';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_form_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 표현 형태 ( ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_child_yn` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 하위 코드 존재 여부 ( ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_stat` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 필수 여부 ( iCUBE, ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '사용자 입력 관리항목 코드';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `ctd_name` VARCHAR(100) DEFAULT NULL COMMENT '사용자 입력 관리항목 명칭';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 항목 분개 관리항목 JSON 문자열';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `real_mng_code` VARCHAR(32) DEFAULT NULL COMMENT '실제 연동 관리항목 코드';

/* t_ex_expend_partner */
CREATE TABLE IF NOT EXISTS `t_ex_expend_partner` (
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
) ENGINE=INNODB AUTO_INCREMENT=6222 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처 코드';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_name` VARCHAR(128) DEFAULT NULL COMMENT '거래처 명칭';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '사업자 등록 번호';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_fg` VARCHAR(32) DEFAULT NULL COMMENT '거래처 종류';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `ceo_name` VARCHAR(128) DEFAULT NULL COMMENT '대표자명';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '업태';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `cls_job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '종목';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `deposit_no` VARCHAR(64) DEFAULT NULL COMMENT '계좌번호';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `bank_code` VARCHAR(32) DEFAULT NULL COMMENT '은행코드';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_emp_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_hp_emp_no` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자연락처';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `deposit_name` VARCHAR(64) DEFAULT NULL COMMENT '예금주';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `deposit_convert` VARCHAR(128) DEFAULT NULL COMMENT '관리항목';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_project */
CREATE TABLE IF NOT EXISTS `t_ex_expend_project` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 프로젝트 시퀀스',
  `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드',
  `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=5475 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_slip */
CREATE TABLE IF NOT EXISTS `t_ex_expend_slip` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `summary_seq` VARCHAR(32) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `auth_seq` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `write_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `budget_seq` VARCHAR(32) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `project_seq` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `partner_seq` VARCHAR(32) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `card_seq` VARCHAR(32) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `drcr_gbn` VARCHAR(32) DEFAULT NULL COMMENT '차변, 대변 구분값';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `acct_code` VARCHAR(64) DEFAULT NULL COMMENT '계정과목 코드';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `acct_name` VARCHAR(128) DEFAULT NULL COMMENT '계정과목 명칭';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `note` VARCHAR(100) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '금액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KYE 1';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `row_no` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KEY 2';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 항목 분개 JSON 문자열';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_summary */
CREATE TABLE IF NOT EXISTS `t_ex_expend_summary` (
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
) ENGINE=INNODB AUTO_INCREMENT=4894 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_code` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 게정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융거래처 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_vat */
CREATE TABLE IF NOT EXISTS `t_ex_expend_vat` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `vat_type_code` INT(11) DEFAULT NULL COMMENT '부가세구분 그룹웨어 코드 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `vat_type_name` VARCHAR(100) DEFAULT NULL COMMENT '부가세구분 그룹웨어 명 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `va_type_code` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `va_type_name` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `mutual_code` VARCHAR(20) DEFAULT NULL COMMENT '불공제/사유 ERP 코드 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `mutual_name` VARCHAR(100) DEFAULT NULL COMMENT '불공제/사유 ERP 명 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `iss_yn` VARCHAR(20) DEFAULT NULL COMMENT '전자세금계산서 여부 ERP 코드 ( ERP IU : 종이세금계산서 ( 0 ), 전자세금계산서 ( 2 ) / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `jeonjasend_yn` VARCHAR(20) DEFAULT NULL COMMENT '국세청전송11일이내 여부 ERP 코드 ( ERP IU : 전송 ( 0 ), 미전송 ( 1 ) / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tex_md` VARCHAR(4) DEFAULT NULL COMMENT '품목정보 월/일 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `item_name` VARCHAR(50) DEFAULT NULL COMMENT '품목정보 품명 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `size_name` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 규격 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tax_qt` DECIMAL(17,4) DEFAULT NULL COMMENT '품목정보 수량 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `prc_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 단가 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `supply_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 공급가액 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tax_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 부가세액 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `note_nm` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 비고 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `create_user_seq` INT(11) DEFAULT NULL COMMENT '작성자 그룹웨어 아이디';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '작성일자';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `modify_user_seq` INT(11) DEFAULT NULL COMMENT '수정자 그룹웨어 아이디';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자';

/* t_ex_item */
CREATE TABLE IF NOT EXISTS `t_ex_item` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `langpack_name` VARCHAR(100) DEFAULT NULL COMMENT '명칭';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `order_num` INT(11) DEFAULT NULL COMMENT '정렬 순서';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `display_align` VARCHAR(10) DEFAULT NULL COMMENT '정렬 표현 방법';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `head_code` VARCHAR(100) DEFAULT NULL COMMENT '그리드 헤더 키';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `select_yn` VARCHAR(1) DEFAULT NULL COMMENT '기본키 여부';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_langpack */
CREATE TABLE IF NOT EXISTS `t_ex_langpack` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사 시퀀스',
  `lang_type` VARCHAR(5) NOT NULL COMMENT '언어 타입',
  `lang_code` VARCHAR(50) NOT NULL COMMENT '명칭 코드',
  `basic_name` VARCHAR(50) NOT NULL COMMENT '기본 명칭',
  `langpack_code` VARCHAR(50) NOT NULL COMMENT '다국어 코드',
  `lang_name` VARCHAR(50) NOT NULL COMMENT '명칭',
  `create_seq` INT(11) NOT NULL COMMENT '생성자',
  `create_date` DATETIME NOT NULL COMMENT '생성일',
  `modify_seq` INT(11) NOT NULL COMMENT '수정자',
  `modify_date` DATETIME NOT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`lang_type`,`lang_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `basic_name` VARCHAR(50) NOT NULL COMMENT '기본 명칭';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `langpack_code` VARCHAR(50) NOT NULL COMMENT '다국어 코드';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `lang_name` VARCHAR(50) NOT NULL COMMENT '명칭';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `create_seq` INT(11) NOT NULL COMMENT '생성자';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `create_date` DATETIME NOT NULL COMMENT '생성일';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `modify_seq` INT(11) NOT NULL COMMENT '수정자';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `modify_date` DATETIME NOT NULL COMMENT '수정일';

/* t_ex_mng_option */
CREATE TABLE IF NOT EXISTS `t_ex_mng_option` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `mng_name` VARCHAR(100) DEFAULT NULL COMMENT '관리항목명';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `use_gbn` VARCHAR(20) DEFAULT NULL COMMENT '사용구분';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력코드';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `ctd_name` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력명';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `note` VARCHAR(512) DEFAULT NULL COMMENT '비고 ( 툴팁활용 )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `cust_set` VARCHAR(4000) DEFAULT NULL COMMENT '커스터마이징을 위한 컬럼';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `cust_set_target` VARCHAR(32) DEFAULT NULL COMMENT '조회 대상 ( BizboxA, iCUBE, ERPiU )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `modify_yn` VARCHAR(32) DEFAULT NULL COMMENT '수정가능 여부 ( 전용개발인 경우, 사용자에 의한 삭제 및 수정이 불가해야 함 )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `create_seq` INT(11) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '생성일';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일';

/* t_ex_option */
CREATE TABLE IF NOT EXISTS `t_ex_option` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `use_sw` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 연동 시스템';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `order_num` DECIMAL(65,0) DEFAULT NULL COMMENT '정렬순서';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `common_code` VARCHAR(32) DEFAULT NULL COMMENT '공통코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `base_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 기본 설정 코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `base_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 명칭';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `base_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 사용자 정의';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `set_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 설정 코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `set_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 명칭';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `set_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 사용자 정의';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `option_select_type` VARCHAR(32) DEFAULT NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `option_process_type` VARCHAR(32) DEFAULT NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_option_multi */
CREATE TABLE IF NOT EXISTS `t_ex_option_multi` (
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `option_name` VARCHAR(512) DEFAULT NULL COMMENT '옵션 명칭';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `option_note` VARCHAR(1024) DEFAULT NULL COMMENT '옵션 설명';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_summary */
CREATE TABLE IF NOT EXISTS `t_ex_summary` (
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
  `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서',
  PRIMARY KEY (`comp_seq`,`summary_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 게정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 계정과목 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융 거래처 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융 거래처 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최총 수정 일자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서';

/* t_ex_vat */
CREATE TABLE IF NOT EXISTS `t_ex_vat` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `vat_code` VARCHAR(20) NOT NULL COMMENT '세무구분 코드',
  `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`comp_seq`,`vat_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* 명칭설정 툴팁 추가 / 최상배 / 2017-04-12 */
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `tooltip` VARCHAR(256) DEFAULT '' COMMENT '명칭 툴팁';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 04. 11. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 양식설정 / 양식정보 */
CREATE TABLE IF NOT EXISTS `t_ex_form` (
  `form_seq` varchar(96) NOT NULL COMMENT '양식 시퀀스',
  `comp_seq` varchar(96) NOT NULL COMMENT '회사 시퀀스',
  `form_content` text COMMENT '양식 본문 TABLE',
  `form_change_content` text COMMENT '양식 본문 HTML',
  `create_seq` varchar(96) DEFAULT NULL COMMENT '생성자',
  `create_date` datetime DEFAULT NULL COMMENT '생성일',
  `modify_seq` varchar(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` datetime DEFAULT NULL COMMENT '생성일',
  PRIMARY KEY (`form_seq`,`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


/* 양식설정 / 양식샘플 */
CREATE TABLE IF NOT EXISTS `t_ex_form_sample` (
  `seq` int(11) DEFAULT NULL COMMENT '양식 순번',
  `comp_seq` varchar(96) DEFAULT NULL COMMENT '회사 시퀀스',
  `sample_name` varchar(765) DEFAULT NULL COMMENT '샘플코드 이름',
  `sample_content` text COMMENT '샘플코드 본문',
  `create_seq` varchar(96) DEFAULT NULL COMMENT '생성자',
  `create_date` datetime DEFAULT NULL COMMENT '생성일',
  `modify_seq` varchar(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` datetime DEFAULT NULL COMMENT '수정일'
) ENGINE=INNODB DEFAULT CHARSET=utf8;


/* 양식설정 / 양식코드 */
CREATE TABLE IF NOT EXISTS `t_ex_form_code` (
  `code` varchar(96) NOT NULL COMMENT '코드명',
  `code_name` varchar(192) DEFAULT NULL COMMENT '코드 명칭',
  `code_gbn` varchar(96) DEFAULT NULL COMMENT '코드 구분',
  `use_yn` char(3) DEFAULT NULL COMMENT '사용여부',
  `required_yn` char(3) DEFAULT NULL COMMENT '필수 여부',
  `create_seq` varchar(96) DEFAULT NULL COMMENT '생성자',
  `create_date` datetime DEFAULT NULL COMMENT '생성일',
  `modify_seq` varchar(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 04. 28. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */


/* 2017. 05. 08. */
/* 2017. 05. 08. - 신재호 */
/* 2017. 05. 08. - 신재호 - 지출결의(영리) 항목단위 전송시 row_id 저장 테이블 */
CREATE TABLE IF NOT EXISTS `t_ex_expend_send`( 
	`expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스', 
	`list_seq` VARCHAR(32) NOT NULL COMMENT '리스트 시퀀스', 
	`row_id` VARCHAR(20) COMMENT 'ERPiU 자동전표 번호', 
	`in_dt` VARCHAR(8) COMMENT 'iCUBE 자동전표 번호', 
	`in_sq` INT(11) COMMENT 'iCUBE 자동전표 번호', 
	`doc_seq` VARCHAR(32) NOT NULL COMMENT '그룹웨어 문서 번호', 
	`create_seq` VARCHAR(32) COMMENT '작성자', 
	`create_date` DATETIME COMMENT '작성일', 
	PRIMARY KEY (`expend_seq`, `list_seq`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci; 


/* 2017. 05. 10. */
/* 2017. 05. 10. - 신재호 */
/* 2017. 05. 10. - 신재호 - 지출결의(영리) 항목설정 페이지 회사 시퀀스 varchar로 변경 */
ALTER TABLE `t_ex_mng_option` CHANGE `comp_seq` `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스';


/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 05. 16. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 05. 29. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */
/* t_ex_form primary key 정의 */
/* t_ex_form primary key 정의 - 백업 테이블 생성 */
DROP TABLE IF EXISTS `t_ex_form_bak`;
CREATE TABLE IF NOT EXISTS `t_ex_form_bak` (
  `form_seq` VARCHAR(96) NOT NULL COMMENT '양식 시퀀스',
  `comp_seq` VARCHAR(96) NOT NULL COMMENT '회사 시퀀스',
  `form_content` TEXT COMMENT '양식 본문 TABLE',
  `form_change_content` TEXT COMMENT '양식 본문 HTML',
  `create_seq` VARCHAR(96) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` VARCHAR(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '생성일'
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* t_ex_form primary key 정의 - 기존 데이터 백업 */
INSERT INTO `t_ex_form_bak` ( `form_seq`, `comp_seq`, `form_content`, `form_change_content`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
SELECT  `form_seq`, `comp_seq`, `form_content`, `form_change_content`, 'SYSTEM', NOW(), 'SYSTEM', NOW()
FROM    `t_ex_form`
WHERE   `form_seq` != '0'
GROUP   BY `form_seq`, `comp_seq`, `form_content`, `form_change_content`;

/* t_ex_form primary key 정의 - 테이블 재생성 */
DROP TABLE `t_ex_form`;
CREATE TABLE IF NOT EXISTS `t_ex_form` (
  `form_seq` VARCHAR(96) NOT NULL COMMENT '양식 시퀀스',
  `comp_seq` VARCHAR(96) NOT NULL COMMENT '회사 시퀀스',
  `form_content` TEXT COMMENT '양식 본문 TABLE',
  `form_change_content` TEXT COMMENT '양식 본문 HTML',
  `create_seq` VARCHAR(96) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` VARCHAR(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '생성일',
  PRIMARY KEY (`form_seq`,`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* t_ex_form primary key 정의 - 백업 데이터 복원 */
INSERT INTO `t_ex_form` ( `form_seq`, `comp_seq`, `form_content`, `form_change_content`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
SELECT  `form_seq`, `comp_seq`, `form_content`, `form_change_content`, 'SYSTEM', NOW(), 'SYSTEM', NOW()
FROM    `t_ex_form_bak`
WHERE   `form_seq` != '0'
GROUP   BY `form_seq`, `comp_seq`, `form_content`, `form_change_content`;

/* t_ex_form primary key 정의 - 기본값 재설정 */
INSERT IGNORE INTO `t_ex_form` (
        `form_seq`
        , `comp_seq`
        , `form_content`
        , `form_change_content`
        , `create_seq`
        , `create_date`
        , `modify_seq`
        , `modify_date` )
VALUES (
        '0'
        , 'EXP_FORM'
        , '<table width="100%" border="1" cellspacing="0" cellpadding="0"><tbody><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">회계일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="3"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendDate_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">지급요청일자</span></p></td><td width="245" height="27" align="center" style="width: 245px; text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendReqDate_</span></p></td></tr><tr><td width="10%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">순번</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">계정분류</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">적요</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙구분</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">법인카드</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">프로젝트</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">거래처</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">공급가액</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">부가세</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">첨부</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)" colspan="2"><p>예산단위</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>사업계획</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산계정</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산년월</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>실행합금액</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>집행금액</p></td></tr><tr><td height="27" align="center" class="listNum" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listNum_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAcctName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: left; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> _note_ [_slipPop_]</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authName_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authDate_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;">_cardName_</td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listStdAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listTaxAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_attach_ </span></p></td></tr><tr><td height="27" align="center" style="text-align: center;" colspan="2"><p>_budgetName_</p></td><td height="27" align="center" style="text-align: center;"><p>_bizplanName_</p></td><td height="27" align="right" style="text-align: right;"><p>_bgacctName_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetYm_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetActsum_</p></td><td height="27" align="center" style="text-align: center;"><p>_budgetJsum_</p></td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="4"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_vatAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_crAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> </span></p></td></tr></tbody></table>'
        , '<table width="100%" border="1" cellspacing="0" cellpadding="0"><tbody><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">회계일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="3"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendDate_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">지급요청일자</span></p></td><td width="245" height="27" align="center" style="width: 245px; text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendReqDate_</span></p></td></tr><tr><td width="10%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">순번</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">계정분류</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">적요</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙구분</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">법인카드</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">프로젝트</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">거래처</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">공급가액</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">부가세</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">첨부</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)" colspan="2"><p>예산단위</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>사업계획</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산계정</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산년월</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>실행합금액</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>집행금액</p></td></tr><tr><td height="27" align="center" class="listNum" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listNum_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAcctName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: left; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> _note_ [_slipPop_]</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authName_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authDate_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;">_cardName_</td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listStdAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listTaxAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_attach_ </span></p></td></tr><tr><td height="27" align="center" style="text-align: center;" colspan="2"><p>_budgetName_</p></td><td height="27" align="center" style="text-align: center;"><p>_bizplanName_</p></td><td height="27" align="right" style="text-align: right;"><p>_bgacctName_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetYm_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetActsum_</p></td><td height="27" align="center" style="text-align: center;"><p>_budgetJsum_</p></td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="4"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_vatAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_crAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> </span></p></td></tr></tbody></table>'
        , 'SYSTEM'
        , NOW()
        , 'SYSTEM'
        , NOW() );

UPDATE  `t_ex_form`
SET     form_content = '<table width="100%" border="1" cellspacing="0" cellpadding="0"><tbody><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">회계일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="3"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendDate_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">지급요청일자</span></p></td><td width="245" height="27" align="center" style="width: 245px; text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendReqDate_</span></p></td></tr><tr><td width="10%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">순번</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">계정분류</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">적요</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙구분</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">법인카드</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">프로젝트</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">거래처</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">공급가액</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">부가세</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">첨부</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)" colspan="2"><p>예산단위</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>사업계획</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산계정</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산년월</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>실행합금액</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>집행금액</p></td></tr><tr><td height="27" align="center" class="listNum" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listNum_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAcctName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: left; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> _note_ [_slipPop_]</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authName_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authDate_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;">_cardName_</td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listStdAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listTaxAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_attach_ </span></p></td></tr><tr><td height="27" align="center" style="text-align: center;" colspan="2"><p>_budgetName_</p></td><td height="27" align="center" style="text-align: center;"><p>_bizplanName_</p></td><td height="27" align="right" style="text-align: right;"><p>_bgacctName_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetYm_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetActsum_</p></td><td height="27" align="center" style="text-align: center;"><p>_budgetJsum_</p></td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="4"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_vatAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_crAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> </span></p></td></tr></tbody></table>'
WHERE   form_seq = '0'
AND     comp_seq = 'EXP_FORM';

DROP TABLE IF EXISTS `t_ex_form_bak`;

/* 2017. 06. 16. */
/* 2017. 06. 16. - 신재호 */
/* 2017. 06. 16. - 신재호 - 지출결의(영리) ERPiU 거래처 계좌번호 코드 추가 */
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `deposit_cd` VARCHAR(64) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '계좌번호코드' AFTER `deposit_convert`; 

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 06. 19. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 07. 06. */
/* 2017. 07. 06. - 신재호 */
/* 2017. 07. 06. - 신재호 - 세금계산서 권한 테이블 추가 */
CREATE TABLE IF NOT EXISTS `t_ex_etax`( 
	`etax_seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '세금계산서 권한 시퀀스', 
	`comp_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '회사 시퀀스', 
	`auth_type` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '권한타입(P:거래처, E:이메일)', 
	`use_yn` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '사용여부', 
	`name` VARCHAR(100) CHARSET utf8 COLLATE utf8_general_ci COMMENT '대상 명칭(거래처명 또는 이메일주소)', 
	`code` VARCHAR(100) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '대상 코드(사업자등록번호 또는 이메일주소)',
	`public_json` LONGTEXT CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '공개범위 JSON',
	PRIMARY KEY (`etax_seq`, `comp_seq`) 
) ENGINE=INNODB DEFAULT CHARSET=utf8; 
 
/* 2017. 07. 06. */
/* 2017. 07. 06. - 신재호 */
/* 2017. 07. 06. - 신재호 - 세금계산서 권한 공개범위 테이블 추가 */
CREATE TABLE IF NOT EXISTS `t_ex_etax_public`( 
	`etax_seq` INT(32) NOT NULL COMMENT '세금계산서 권한 시퀀스', 
	`comp_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '회사 시퀀스', 
	`pupblic_seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '공개범위 시퀀스', 
	`type` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '공개범위 타입(U:사용자, D:부서)', 
	`code` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '코드(사용자 또는 부서코드)',
	`name` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '명칭(이름)',
	KEY(`pupblic_seq`), PRIMARY KEY (`etax_seq`, `comp_seq`, `pupblic_seq`) 
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 07. 12. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 07. 17. */
/* 2017. 07. 17. - 신재호 */
/* 2017. 07. 17. - 신재호 - 세금계산서 권한 공개범위 테이블 수정(그룹시퀀스, 부서시퀀스 추가) */
ALTER TABLE `t_ex_etax_public` ADD IF NOT EXISTS `group_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '그룹 시퀀스' AFTER `name`, ADD IF NOT EXISTS `dept_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '부서 시퀀스' AFTER `group_seq`;

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 07. 18. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 07. 19. */
/* 2017. 07. 19. - 신재호 */
/* 2017. 07. 19. - 신재호 - 세금계산서발행여부 및 11이내 전송여부 추가 */
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `etax_yn` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '전자세금계산서여부' AFTER `modify_date`, ADD IF NOT EXISTS `etax_send_yn` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '계산서11이내 전송여부' AFTER `etax_yn`;
ALTER TABLE `t_ex_etax_public` ADD IF NOT EXISTS `group_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '그룹 시퀀스' AFTER `name`, ADD IF NOT EXISTS `dept_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '부서 시퀀스' AFTER `group_seq`;
ALTER TABLE `t_ex_etax_public` ADD IF NOT EXISTS `group_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '그룹 시퀀스' AFTER `name`, ADD IF NOT EXISTS `dept_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '부서 시퀀스' AFTER `group_seq`;
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 08. 10. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 09. 14. */
/* 2017. 09. 14. - 김상겸 */
/* 2017. 09. 14. - 김상겸 - 양식별 표준적요 & 증빙유형 귀속 범위 설정 */
CREATE TABLE IF NOT EXISTS `t_ex_formlink_summary_auth` (
  `comp_seq` varchar(32) NOT NULL COMMENT '회사 시퀀스',
  `form_seq` varchar(32) NOT NULL COMMENT '양식 시퀀스',
  `type_div` varchar(32) NOT NULL COMMENT '표준적요 / 증빙유형 구분 ( 표준적요(summary) / 증빙유형(auth) )',
  `code_div` varchar(2) NOT NULL COMMENT '코드 귀속 구분 ( 매입(A) / 매출(B) ) ## 매출 기능 미존재 ##',
  `code` varchar(32) NOT NULL COMMENT '표준적요 코드 or 증빙유형 코드',
  `create_seq` varchar(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` datetime DEFAULT NULL COMMENT '최초 생성일',
  `modify_seq` varchar(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` datetime DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`comp_seq`,`form_seq`,`type_div`,`code_div`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 09. 14. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 09. 28. */
/* 2017. 09. 28. - 신재호 */
/* 2017. 09. 28. - 신재호 - 사용자 계좌번호 추가 */
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `deposit_name` VARCHAR(100) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '경비계좌' AFTER `modify_date`;
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `deposit_cd` VARCHAR(20) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '경비계좌코드' AFTER `deposit_name`; 

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 09. 29. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 10. 17. */
/* 2017. 10. 17. - 신재호 */
/* 2017. 10. 17. - 신재호 - 지출결의 마감설정 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_close`( 
	`comp_seq` VARCHAR(32) NOT NULL COMMENT '회사Seq', 
	`form_seq` VARCHAR(32) NOT NULL COMMENT '양식Seq', 
	`seq` INT NOT NULL COMMENT 'seq', 
	`close_type` VARCHAR(1) NOT NULL COMMENT '마감구분(C:작성일,E:회계일자,A:증빙일자)', 
	`close_from_date` VARCHAR(8) NOT NULL COMMENT '시작일', 
	`close_to_date` VARCHAR(8) NOT NULL COMMENT '종료일', 
	`close_stat` VARCHAR(1) NOT NULL COMMENT '마감상태(Y:마감,N:마감취소)', 
	`note` LONGTEXT COMMENT '비고', 
	`create_seq` VARCHAR(32) COMMENT '작성자', 
	`create_date` DATETIME COMMENT '작성일', 
	`modify_seq` VARCHAR(32) NOT NULL COMMENT '수정자(마감자)', 
	`modify_name` VARCHAR(128) NOT NULL COMMENT '수정자명(마감자명)', 
	`modify_date` DATETIME NOT NULL COMMENT '수정일(마감등록일)', 
	PRIMARY KEY (`comp_seq`, `form_seq`, `seq`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci;


/* 2017. 10. 17. */
/* 2017. 10. 17. - 신재호 */
/* 2017. 10. 17. - 신재호 - 지출결의 마감설정 이력 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_close_history`( 
	`comp_seq` VARCHAR(32) NOT NULL COMMENT '회사Seq', 
	`form_seq` VARCHAR(32) NOT NULL COMMENT '양식Seq', 
	`close_seq` INT NOT NULL COMMENT '마감Seq', 
	`seq` INT NOT NULL COMMENT '이력Seq', 
	`close_stat` VARCHAR(1) NOT NULL COMMENT '마감상태(Y:마감,N:마감취소,D:삭제)',
	`hitory_info` LONGTEXT NOT NULL COMMENT '마감정보(마감구분/시작일/종료일/비고/작성자/작성일)', 
	`create_seq` VARCHAR(32) NOT NULL COMMENT '수정자', 
	`create_date` DATETIME NOT NULL COMMENT '수정일', 
	PRIMARY KEY (`comp_seq`, `form_seq`, `close_seq`, `seq`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci; 


ALTER TABLE `neos`.`t_ex_expend_list` ADD IF NOT EXISTS `fee_seq` INT(11) DEFAULT 0 NULL COMMENT '접대비관련 정보' AFTER `card_seq`; 
ALTER TABLE `neos`.`t_ex_expend_slip` ADD IF NOT EXISTS `fee_seq` INT(11) DEFAULT 0 NULL COMMENT '접대비 정보(t_ex_entertainment)' AFTER `card_seq`; 

/* 2017. 11. 02. */
/* 2017. 11. 02. - 최상배 */
/* 2017. 11. 02. - 신재호 - 지출결의 접대비 부표 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_entertainment` (
  `fee_seq` INT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '접대비 등록 키',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '회사 코드',
  `start_date` VARCHAR(10) DEFAULT NULL COMMENT '발생일자',
  `use_fg_code` VARCHAR(4) DEFAULT NULL COMMENT '사용구분 코드',
  `use_fg_name` VARCHAR(32) DEFAULT NULL COMMENT '사용구분 명칭',
  `auth_fg_code` VARCHAR(4) DEFAULT NULL COMMENT '증빙구분 코드',
  `auth_fg_name` VARCHAR(32) DEFAULT NULL COMMENT '증빙구분 명칭',
  `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드 코드',
  `card_num` VARCHAR(20) DEFAULT NULL COMMENT '카드 번호',
  `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '접대상대(거래처) 코드',
  `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '접대상대(거래처) 명칭',
  `partner_num` VARCHAR(10) DEFAULT NULL COMMENT '사업자 번호',
  `ceo_name` VARCHAR(20) DEFAULT NULL COMMENT '대표자 명칭',
  `res_num` VARCHAR(20) DEFAULT NULL COMMENT '주민번호',
  `amt` VARCHAR(64) DEFAULT NULL COMMENT '사용 금액',
  `metirial_amt` VARCHAR(64) DEFAULT NULL COMMENT '물품대',
  `service_amt` VARCHAR(64) DEFAULT NULL COMMENT '봉사료',
  `entertainment` VARCHAR(256) DEFAULT NULL COMMENT '접대 내역',
  `note` VARCHAR(256) DEFAULT NULL COMMENT '비고',
  `amt_over_yn` VARCHAR(1) DEFAULT NULL COMMENT '금액 초과 여부',
  PRIMARY KEY (`fee_seq`)
) ENGINE=INNODB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/* 2017. 12. 12. */
/* 2017. 12. 12. - 신재호 */
/* 2017. 12. 12. - 신재호 - 지출결의 로그 테이블 - 메세지 형 변환 */
ALTER TABLE `neos`.`t_expend_log` CHANGE `message` `message` TEXT NOT NULL COMMENT 'log 메시지'; 

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 12. 15. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* 2018. 02. 20. */
/* 2018. 02. 20. - 신재호 */
/* 2018. 02. 20. - 신재호 - 세금계산서 이관 테이블 */
CREATE TABLE IF NOT EXISTS `t_ex_etax_transfer` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '회사SEQ',
  `iss_no` VARCHAR(32) NOT NULL COMMENT '세금계산서번호',
  `iss_dt` VARCHAR(8) NOT NULL COMMENT '계산서발행일자',
  `partner_no` VARCHAR(32) NOT NULL COMMENT '공급자 사업자등록번호',
  `partner_name` VARCHAR(128) NOT NULL COMMENT '공급자 명',
  `amt` DECIMAL(19,0) NOT NULL COMMENT '세금계산서 금액',
  `transfer_seq` VARCHAR(32) NOT NULL COMMENT '이관 한 사원 번호',
  `transfer_name` VARCHAR(128) DEFAULT NULL COMMENT '이관 한 사원 이름',
  `receive_seq` VARCHAR(32) NOT NULL COMMENT '이관 받은 사원 번호',
  `receive_name` VARCHAR(128) DEFAULT NULL COMMENT '이관 받은 사원 이름',
  `supper_key` VARCHAR(128) DEFAULT NULL COMMENT '조직도팝업 슈퍼키',
  `create_date` DATETIME DEFAULT NULL COMMENT '이관일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

/* 2018. 02. 20. */
/* 2018. 02. 20. - 신재호 */
/* 2018. 02. 20. - 신재호 - 이관 로그 테이블 */
CREATE TABLE IF NOT EXISTS `t_ex_transfer_log` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사SEQ',
  `interface_type` VARCHAR(32) NOT NULL COMMENT 'interface타입(card,etax)',
  `interface_key` VARCHAR(32) NOT NULL COMMENT '카드승인번호/세금계산서번호',
  `transfer_cancel_yn` VARCHAR(1) NOT NULL COMMENT '이관취소여부(Y:취소,N:이관)',
  `transfer_seq` VARCHAR(32) NOT NULL COMMENT '이관 한 사용자',
  `receive_seq` VARCHAR(32) NOT NULL COMMENT '이관 받은 사용자',
  `create_seq` VARCHAR(32) NOT NULL COMMENT '이관/이관취소자',
  `create_date` DATETIME NOT NULL COMMENT '이관/이관취소일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';

ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 02. 22. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* 2018. 04. 03. */
/* 2018. 04. 03. - 신재호 */
/* 2018. 04. 03. - 신재호 - CMS 동기화 테이블 변경 */
ALTER TABLE `neos`.`t_ex_cms_sync` ADD IF NOT EXISTS `server_ip` VARCHAR(20) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '서버IP(다중서버일 경우를 위해)' AFTER `create_date`;

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 04. 05. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

ALTER TABLE `neos`.`t_ex_expend_auth` ADD IF NOT EXISTS `no_cash` VARCHAR(9) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '현금승인번호(ERPiU전용)' AFTER `etax_send_yn`; 

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 05. 04. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */

/* 2018. 06. 21. */
/* 2018. 06. 21. - 김상겸 */
/* 2018. 06. 21. - 김상겸 - TABLE 엔진 변경 */
ALTER TABLE `neos`.`t_ex_entertainment` ENGINE=INNODB;
ALTER TABLE `neos`.`t_ex_etax_transfer` ENGINE=INNODB;
ALTER TABLE `neos`.`t_ex_ezbaro_code_param` ENGINE=INNODB;
ALTER TABLE `neos`.`t_ex_ezbaro_erp_master` ENGINE=INNODB;
ALTER TABLE `neos`.`t_ex_ezbaro_erp_slave` ENGINE=INNODB;
ALTER TABLE `neos`.`t_ex_ezbaro_gw_master` ENGINE=INNODB;
ALTER TABLE `neos`.`t_ex_ezbaro_gw_slave` ENGINE=INNODB;
ALTER TABLE `neos`.`t_ex_transfer_log` ENGINE=INNODB;



/* 2018. 12. 05. */
/* 2018. 12. 05. - 최상배 */
/* 2018. 12. 05. - 최상배 - 스마트 자금관리 양식설정 테이블 */
CREATE TABLE IF NOT EXISTS `t_ex_smartoption` (
  `option_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  `code` VARCHAR(32) NOT NULL COMMENT '옵션코드',
  `value` VARCHAR(32) NOT NULL COMMENT '옵션 설정값',
  `note` VARCHAR(32) NOT NULL COMMENT '옵션 메모',
  PRIMARY KEY (`option_seq`)
) ENGINE=INNODB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 06. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */
CREATE TABLE IF NOT EXISTS `t_ex_card_transfer` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사SEQ' AFTER `seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `sync_id` BIGINT(20) NULL COMMENT '카드 승인 내역 고유 키' AFTER `comp_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `card_num` VARCHAR(16) NULL COMMENT '카드번호' AFTER `sync_id`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `auth_num` VARCHAR(20) NULL COMMENT '카드승인번호' AFTER `card_num`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `auth_date` CHAR(8) NULL COMMENT '승인일자' AFTER `auth_num`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `auth_time` CHAR(6) NULL COMMENT '승인시간' AFTER `auth_date`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `partner_no` VARCHAR(32) NULL COMMENT '공급자 사업자등록번호' AFTER `auth_time`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `partner_name` VARCHAR(128) NULL COMMENT '공급자 명' AFTER `partner_no`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `amt` DECIMAL(19,0) NULL COMMENT '세금계산서 금액' AFTER `partner_name`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `transfer_seq` VARCHAR(32) NULL COMMENT '이관 한 사원 번호' AFTER `amt`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `transfer_name` VARCHAR(128) NULL COMMENT '이관 한 사원 이름' AFTER `transfer_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `receive_seq` VARCHAR(32) NULL COMMENT '이관 받은 사원 번호' AFTER `transfer_name`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `receive_name` VARCHAR(128) NULL COMMENT '이관 받은 사원 이름' AFTER `receive_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(2)  DEFAULT 'Y' COMMENT '사용 여부 ( 사용 : Y / 미사용 : N )' AFTER `receive_name`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `use_yn_emp_seq` VARCHAR(32) NULL COMMENT '사용 여부 설정 사용자 시퀀스' AFTER `use_yn`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `supper_key` VARCHAR(32) NULL COMMENT '조직도팝업 슈퍼키' AFTER `use_yn_emp_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `create_date` DATETIME NULL COMMENT '이관일자' AFTER `supper_key`;

/* 2018. 12. 14. */
/* 2018. 12. 14. - 박용욱 */
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `auto_calc_yn` CHAR(1) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '금액자동계산체크여부(Y/N)'

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 13. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 20. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */