/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 11. 22. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 스마트 자금관리 테이블 추가 */

CREATE TABLE IF NOT EXISTS `t_smart_authcode` (
  `auth_code` VARCHAR(30) NOT NULL COMMENT '권한코드',
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '그룹웨어 시퀀스',
  `use_yn` CHAR(1) DEFAULT 'Y' COMMENT '사용여부',
  `order_num` INT(4) DEFAULT NULL COMMENT '정렬순서',
  `etc` VARCHAR(255) DEFAULT NULL COMMENT '비고',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '등록자',
  `create_date` DATETIME DEFAULT NULL COMMENT '등록일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`comp_seq`,`auth_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_smart_authcode_emp` (
  `auth_code` VARCHAR(30) NOT NULL COMMENT '권한코드',
  `emp_seq` VARCHAR(32) NOT NULL COMMENT '사용자 시퀀스',
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사 시퀀스',
  `dept_seq` VARCHAR(32) NOT NULL COMMENT '부서 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '등록자 시퀀스',
  `create_date` DATETIME DEFAULT NULL COMMENT '등록일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자 시퀀스',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`auth_code`,`emp_seq`,`comp_seq`,`dept_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_smart_authcode_menu` (
  `auth_code` VARCHAR(30) NOT NULL COMMENT '권한코드',
  `menu_code` VARCHAR(30) NOT NULL COMMENT '메뉴코드',
  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 시퀀스',
  `erp_co_cd` VARCHAR(32) NOT NULL COMMENT 'erp 회사코드',
  `erp_biz_cd` VARCHAR(32) DEFAULT NULL COMMENT 'erp 사업장코드',
  `erp_co_cd_name` VARCHAR(32) NOT NULL COMMENT 'erp 회사명칭',
  `erp_biz_cd_name` VARCHAR(32) DEFAULT NULL COMMENT 'erp 사업장명칭',
  `use_yn` CHAR(2) DEFAULT 'Y' COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '등록자 시퀀스',
  `create_date` DATETIME DEFAULT NULL COMMENT '등록일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자 시퀀스',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자'
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_smart_authcode_menu` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NOT NULL  COMMENT '그룹웨어 회사 시퀀스' AFTER `use_yn`;

CREATE TABLE IF NOT EXISTS `t_smart_authcode_multi` (
  `auth_code` VARCHAR(30) NOT NULL COMMENT '권한코드',
  `auth_code_nm` VARCHAR(60) NOT NULL COMMENT '권한코드 이름',
  `lang_code` VARCHAR(32) NOT NULL COMMENT '언어코드',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '등록자 시퀀스',
  `create_date` DATETIME DEFAULT NULL COMMENT '등록일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자 시퀀스',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`auth_code`,`lang_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 12. 26. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 02. 24. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 07. 18. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 08. 10. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */