

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/


/*														배포 금지			  					 					 */


/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

/* CUST_001 */
/* WIKI : http://wiki.duzon.com:8080/pages/viewpage.action?spaceKey=UCDEV1&title=CUST_001 */
INSERT IGNORE INTO `t_exnp_option` (`comp_seq`, `form_seq`, `note`, `option_gbn`, `option_code`, `use_sw`, `order_num`, `common_code`, `base_value`, `base_name`, `base_emp_value`, `set_value`, `set_name`, `set_emp_value`, `option_select_type`, `option_process_type`, `use_yn`, `create_seq`, `modify_seq`, `create_date`, `modify_date`)
VALUES('NP_OPTION_U','0','커스터마이징구분','9','1','ERPiU','99','EXNP_CUST_001|','','전체','','0','전체','','cust','cust','Y','SYSTEM','SYSTEM','2018-09-03 00:00:00','0000-00-00 00:00:00');


/* CUST_001 */
/* WIKI :  */
INSERT IGNORE INTO `t_exnp_option` (`comp_seq`, `form_seq`, `note`, `option_gbn`, `option_code`, `use_sw`, `order_num`, `common_code`, `base_value`, `base_name`, `base_emp_value`, `set_value`, `set_name`, `set_emp_value`, `option_select_type`, `option_process_type`, `use_yn`, `create_seq`, `modify_seq`, `create_date`, `modify_date`)
VALUES('NP_OPTION_G20','0','소수점입력 적용','9','1','A','99','EXNP_CUST_002|','','전체','','0','전체','','cust','cust','Y','SYSTEM','SYSTEM','2018-09-03 00:00:00','0000-00-00 00:00:00');

ALTER TABLE t_exnp_consbudget MODIFY erp_open_amt DECIMAL(60,3);
ALTER TABLE t_exnp_consbudget MODIFY erp_apply_amt DECIMAL(60,3);
ALTER TABLE t_exnp_consbudget MODIFY erp_res_amt DECIMAL(60,3);
ALTER TABLE t_exnp_consbudget MODIFY erp_left_amt DECIMAL(60,3);
ALTER TABLE t_exnp_consbudget MODIFY gw_balance_amt DECIMAL(60,3);
ALTER TABLE t_exnp_consbudget MODIFY budget_std_amt DECIMAL(60,3);
ALTER TABLE t_exnp_consbudget MODIFY budget_tax_amt DECIMAL(60,3);
ALTER TABLE t_exnp_consbudget MODIFY budget_amt DECIMAL(60,3);

ALTER TABLE t_exnp_constrade MODIFY trade_unit_amt DECIMAL(60,3);
ALTER TABLE t_exnp_constrade MODIFY trade_std_amt DECIMAL(60,3);
ALTER TABLE t_exnp_constrade MODIFY trade_vat_amt DECIMAL(60,3);

ALTER TABLE t_exnp_resbudget MODIFY erp_open_amt DECIMAL(60,3);
ALTER TABLE t_exnp_resbudget MODIFY erp_apply_amt DECIMAL(60,3);
ALTER TABLE t_exnp_resbudget MODIFY erp_res_amt DECIMAL(60,3);
ALTER TABLE t_exnp_resbudget MODIFY erp_left_amt DECIMAL(60,3);
ALTER TABLE t_exnp_resbudget MODIFY gw_balance_amt DECIMAL(60,3);
ALTER TABLE t_exnp_resbudget MODIFY budget_std_amt DECIMAL(60,3);
ALTER TABLE t_exnp_resbudget MODIFY budget_tax_amt DECIMAL(60,3);
ALTER TABLE t_exnp_resbudget MODIFY budget_amt DECIMAL(60,3);

ALTER TABLE t_exnp_restrade MODIFY trade_amt DECIMAL(60,3);
ALTER TABLE t_exnp_restrade MODIFY trade_std_amt DECIMAL(60,3);
ALTER TABLE t_exnp_restrade MODIFY trade_vat_amt DECIMAL(60,3);
ALTER TABLE t_exnp_restrade MODIFY etc_required_amt DECIMAL(60,3);
ALTER TABLE t_exnp_restrade MODIFY etc_income_amt DECIMAL(60,3);
ALTER TABLE t_exnp_restrade MODIFY etc_income_vat_amt DECIMAL(60,3);
ALTER TABLE t_exnp_restrade MODIFY etc_resident_vat_amt DECIMAL(60,3);


/*	[롤백 쿼리]
DELETE FROM t_exnp_option WHERE note = '소수점 입력';
ALTER TABLE t_exnp_consbudget MODIFY erp_open_amt BIGINT(64);
ALTER TABLE t_exnp_consbudget MODIFY erp_apply_amt BIGINT(64);
ALTER TABLE t_exnp_consbudget MODIFY erp_res_amt BIGINT(64);
ALTER TABLE t_exnp_consbudget MODIFY erp_left_amt BIGINT(64);
ALTER TABLE t_exnp_consbudget MODIFY gw_balance_amt BIGINT(64);
ALTER TABLE t_exnp_consbudget MODIFY budget_std_amt BIGINT(64);
ALTER TABLE t_exnp_consbudget MODIFY budget_tax_amt BIGINT(64);
ALTER TABLE t_exnp_consbudget MODIFY budget_amt BIGINT(64);

ALTER TABLE t_exnp_constrade MODIFY trade_unit_amt BIGINT(64);
ALTER TABLE t_exnp_constrade MODIFY trade_std_amt BIGINT(64);
ALTER TABLE t_exnp_constrade MODIFY trade_vat_amt BIGINT(64);

ALTER TABLE t_exnp_resbudget MODIFY erp_open_amt BIGINT(64);
ALTER TABLE t_exnp_resbudget MODIFY erp_apply_amt BIGINT(64);
ALTER TABLE t_exnp_resbudget MODIFY erp_res_amt BIGINT(64);
ALTER TABLE t_exnp_resbudget MODIFY erp_left_amt BIGINT(64);
ALTER TABLE t_exnp_resbudget MODIFY gw_balance_amt BIGINT(64);
ALTER TABLE t_exnp_resbudget MODIFY budget_std_amt BIGINT(64);
ALTER TABLE t_exnp_resbudget MODIFY budget_tax_amt BIGINT(64);
ALTER TABLE t_exnp_resbudget MODIFY budget_amt BIGINT(64);

ALTER TABLE t_exnp_restrade MODIFY trade_amt BIGINT(64);
ALTER TABLE t_exnp_restrade MODIFY trade_std_amt BIGINT(64);
ALTER TABLE t_exnp_restrade MODIFY trade_vat_amt BIGINT(64);
ALTER TABLE t_exnp_restrade MODIFY etc_required_amt BIGINT(64);
ALTER TABLE t_exnp_restrade MODIFY etc_income_amt BIGINT(64);
ALTER TABLE t_exnp_restrade MODIFY etc_income_vat_amt BIGINT(64);
ALTER TABLE t_exnp_restrade MODIFY etc_resident_vat_amt BIGINT(64); 
*/