/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 11. 22. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - G20 테이블 추가 */

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

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 07. 18. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 08. 10. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */