/* 영리 - 매입전자세금계산서 - iCUBE */
UPDATE  `neos`.`t_co_code_detail_multi`
SET     `detail_name` = 'Y'
WHERE   `code` = 'ex00027'
AND     `detail_code` = 'ETAXBTN';

INSERT IGNORE INTO `T_CO_MENU` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no` ) VALUES ('1000', 'MENU013', '1001040000', '1001000000', '1001040000', 'Y', 'exp', '/ex/user/report/ExUserETaxiCUBEList.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );
INSERT IGNORE INTO `T_CO_MENU_MULTI` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES( '1001040000', 'kr', '나의 세금계산서 현황(iCUBE)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

INSERT IGNORE INTO `T_CO_MENU_ADM` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810105000', 'MENU013', '810100000', '810105000', 'Y', 'exp', '/ex/admin/report/ExAdminETaxlListiCUBE.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `T_CO_MENU_ADM_MULTI` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810105000','kr','세금계산서현황(iCUBE)',NULL,'SYSTEM',NOW(),'SYSTEM',NOW() );
/* ==================================================================================================== */


/* 영리 - 매입전자세금계산서 - ERPiU */
UPDATE  `neos`.`t_co_code_detail_multi`
SET     `detail_name` = 'Y'
WHERE   `code` = 'ex00027'
AND     `detail_code` = 'ETAXBTN';

INSERT IGNORE INTO `T_CO_MENU` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no` ) VALUES ('1000', 'MENU013', '1001030000', '1001000000', '1001030000', 'Y', 'exp', '/ex/user/report/ExUserETaxERPiUList.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );
INSERT IGNORE INTO `T_CO_MENU_MULTI` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES( '1001030000', 'kr', '나의 세금계산서 현황(ERPiU)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

INSERT IGNORE INTO `T_CO_MENU_ADM` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810106000', 'MENU013', '810100000', '810106000', 'Y', 'exp', '/ex/admin/report/ExAdminETaxlListERPiU.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `T_CO_MENU_ADM_MULTI` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810106000','kr','세금계산서현황(ERPiU)',NULL,'SYSTEM',NOW(),'SYSTEM',NOW() );
/* ==================================================================================================== */


/* 영리 - CMS / VAN */
UPDATE  `neos`.`t_co_code_detail_multi`
SET     `detail_name` = 'Y'
WHERE   `code` = 'ex00027'
AND     `detail_code` = 'CARDBTN';

INSERT IGNORE INTO `T_CO_MENU` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no` ) VALUES ('1000', 'MENU013', '1001020000', '1001000000', '1001020000', 'Y', 'exp', '/ex/user/report/ExUseCardlList.do?G20YN=true', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );
INSERT IGNORE INTO `T_CO_MENU_MULTI` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES( '1001020000', 'kr', '나의 카드 사용 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

INSERT IGNORE INTO `T_CO_MENU_ADM` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810103000', 'MENU013', '810100000', '810103000', 'Y', 'exp', '/ex/admin/report/ExUseCardlList.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `T_CO_MENU_ADM_MULTI` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810103000','kr','카드 사용 현황',NULL,'SYSTEM',NOW(),'SYSTEM',NOW() );
/* ==================================================================================================== */


/* 영리 - 예산 - iCUBE */
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUE ( 'Y', 'ex00028', 'N', 2, NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUE ( 'Y', 'ex00028', 'kr', '사용', '사용', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

INSERT IGNORE INTO `T_CO_MENU` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no` ) VALUES ('1000', 'MENU013', '1003020000', '1003000000', '1003020000', 'Y', 'exp', '/ex/user/yesil/ExUserYesilReport.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );
INSERT IGNORE INTO `T_CO_MENU_MULTI` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES( '1003020000', 'kr', '나의 예실대비 현황(iCUBE)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* ==================================================================================================== */


/* 영리 - 예산 - ERPiU */
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUE ( 'Y', 'ex00028', 'N', 2, NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUE ( 'Y', 'ex00028', 'kr', '사용', '사용', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

INSERT IGNORE INTO `T_CO_MENU` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no` ) VALUES ('1000', 'MENU013', '1003030000', '1003000000', '1003030000', 'Y', 'exp', '/ex/user/yesil/ExUserYesil2Report.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );
INSERT IGNORE INTO `T_CO_MENU_MULTI` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES( '1003030000', 'kr', '나의 예실대비 현황(ERPiU)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* ==================================================================================================== */