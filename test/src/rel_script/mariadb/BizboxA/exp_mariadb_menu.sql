/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 11. 22. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 메뉴 생성 쿼리 */

/* [MENU - 메뉴분류] */
INSERT IGNORE INTO `t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'MENU', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [MENU - '메뉴분류', ] */ 
INSERT IGNORE INTO `t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'MENU', 'kr', '메뉴분류', '메뉴관련 분류', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [MENU - MENU011, MENU013 - '회계 - 삭제] */
DELETE FROM `t_co_code_detail_multi` WHERE `code` = 'MENU' AND `detail_code` = 'MENU011';
DELETE FROM `t_co_code_detail_multi` WHERE `code` = 'MENU' AND `detail_code` = 'MENU013';

/* [MENU - MENU011, MENU013 - 회계 - 삭제] */
DELETE FROM `t_co_code_detail` WHERE `code` = 'MENU' AND `detail_code` = 'MENU011';
DELETE FROM `t_co_code_detail` WHERE `code` = 'MENU' AND `detail_code` = 'MENU013';

/* [MENU - MENU013 - 회계] */
INSERT IGNORE INTO `t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'MENU013', 'MENU', 'N', '12', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [MENU - MENU013 - '회계] */
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'MENU013', 'MENU', 'kr', '회계', '회계', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [MENU - MENU011 - '회계 - 삭제] */
DELETE FROM `t_co_menu_multi` WHERE `menu_no` IN ( SELECT  `menu_no` FROM `t_co_menu` WHERE `menu_gubun` = 'MENU011' );
DELETE FROM `t_co_menu` WHERE `menu_gubun` = 'MENU011';

/* [MENU - MENU011 - '회계 - 삭제] */
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` IN ( SELECT  `menu_no` FROM `t_co_menu_adm` WHERE `menu_gubun` = 'MENU011' );
DELETE FROM `t_co_menu_adm` WHERE `menu_gubun` = 'MENU011';

/* [MENU - MENU013 - '회계 - 삭제] */
DELETE FROM `t_co_menu_multi` WHERE `menu_no` IN ( SELECT  `menu_no` FROM `t_co_menu` WHERE `menu_gubun` = 'MENU013' );
DELETE FROM `t_co_menu` WHERE `menu_gubun` = 'MENU013';

/* [MENU - MENU013 - '회계 - 삭제] */
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` IN ( SELECT  `menu_no` FROM `t_co_menu_adm` WHERE `menu_gubun` = 'MENU013' );
DELETE FROM `t_co_menu_adm` WHERE `menu_gubun` = 'MENU013';

/* [0] 사용자 */
/* [1000000000] 사용자 - 회계 */
DELETE FROM `t_co_menu` WHERE `menu_no` = '1000000000';
DELETE FROM `t_co_menu_multi` WHERE `menu_no` = '1000000000';
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1000000000', '0', '1000000000', 'Y', NULL, NULL, 'N', '1', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1000000000', 'kr', '회계', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1001000000] 사용자 - 회계 - 지출결의 관리 */
/* DELETE FROM `t_co_menu` WHERE `menu_no` = '1001000000'; */
/* DELETE FROM `t_co_menu_multi` WHERE `menu_no` = '1001000000'; */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1001000000', '1000000000', '1000000000', 'Y', NULL, NULL, 'N', '2', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001000000', 'kr', '지출결의 관리', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1001010000] 사용자 - 회계 - 지출결의 관리 - 나의 지출결의 현황 */
/* DELETE FROM `t_co_menu` WHERE `menu_no` = '1001010000'; */
/* DELETE FROM `t_co_menu_multi` WHERE `menu_no` = '1001010000'; */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1001010000', '1001000000', '1000000000', 'Y', 'exp', '/ex/user/report/ExApprovalList.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001010000', 'kr', '나의 지출결의 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1001020000] 사용자 - 회계 - 지출결의 관리 - 나의 카드 사용 현황 */
/* DELETE FROM `t_co_menu` WHERE `menu_no` = '1001020000'; */
/* DELETE FROM `t_co_menu_multi` WHERE `menu_no` = '1001020000'; */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1001020000', '1001000000', '1000000000', 'Y', 'exp', '/ex/user/report/ExUseCardlList.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001020000', 'kr', '나의 카드 사용 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1002000000] 사용자 - 회계 - 자금관리 */
DELETE FROM `t_co_menu` WHERE `menu_no` = '1002000000';
DELETE FROM `t_co_menu_multi` WHERE `menu_no` = '1002000000';
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1002000000', '1000000000', '1000000000', 'Y', NULL, NULL, 'N', '2', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1002000000', 'kr', '자금 관리', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1002010000] 사용자 - 회계 - 자금관리 - 나의 자금 일보 현황 */
DELETE FROM `t_co_menu` WHERE `menu_no` = '1002010000';
DELETE FROM `t_co_menu_multi` WHERE `menu_no` = '1002010000';
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1002010000', '1002000000', '1000000000', 'Y', 'eap', '/ea/fund/FundReportList.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1002010000', 'kr', '나의 자금 일보 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [1003000000] 사용자 - 회계 - 예실대비 */
DELETE FROM `t_co_menu` WHERE `menu_no` = '1003000000';
DELETE FROM `t_co_menu_multi` WHERE `menu_no` = '1003000000';
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1003000000', '1000000000', '1003000000', 'Y', NULL, NULL, 'N', '2', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1003000000', 'kr', '예실대비', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [1003020000] 사용자 - 회계 - 예실대비 - 나의 예실대비 현황(iCUBE) */
DELETE FROM `t_co_menu` WHERE `menu_no` = '1003020000';
DELETE FROM `t_co_menu_multi` WHERE `menu_no` = '1003020000';
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1003020000', '1003000000', '1003020000', 'Y', 'exp', '/ex/user/yesil/ExUserYesilReport.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1003020000', 'kr', '나의 예실대비 현황(iCUBE)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [1003030000] 사용자 - 회계 - 예실대비 - 나의 예실대비 현황(ERPiU) */
DELETE FROM `t_co_menu` WHERE `menu_no` = '1003030000';
DELETE FROM `t_co_menu_multi` WHERE `menu_no` = '1003030000';
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1003030000', '1003000000', '1003030000', 'Y', 'exp', '/ex/user/yesil/ExUserYesil2Report.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1003030000', 'kr', '나의 예실대비 현황(ERPiU)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [1003040000] 사용자 - 회계 - 예실대비 - 나의 예실대비 현황(G20) */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1003040000', '1003000000', '1003040000', 'Y', 'ea', '/Ac/G20/State/AcBgtCompareStatusView.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1003040000', 'kr', '나의 예실대비 현황(G20)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [1003050000] 사용자 - 회계 - 예실대비 - 나의 예산 단계별 현황(G20) */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1003050000', '1003000000', '1003050000', 'Y', 'ea', '/Ac/G20/State/AcBgtStepStatusView.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1003050000', 'kr', '나의 예산 단계별 현황(G20)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [0] 관리자 */
/* [810000000] 관리자 - 회계 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810000000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810000000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810000000', 'MENU013', '0', '810000000', 'Y', NULL, NULL, 'N', '1', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810000000', 'kr', '회계', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810100000] 관리자 - 회계 - 지출결의 관리 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810100000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810100000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810100000', 'MENU013', '810000000', '810100000', 'Y', NULL, NULL, 'N', '2', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810100000', 'kr', '지출결의 관리', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810101000] 관리자 - 회계 - 지출결의 관리 - 지출결의 확인 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810101000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810101000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810101000', 'MENU013', '810100000', '810101000', 'Y', 'exp', '/ex/admin/report/ExApprovalSendList.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810101000', 'kr', '지출결의 확인', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810102000] 관리자 - 회계 - 지출결의 관리 - 지출결의 현황 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810102000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810102000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810102000', 'MENU013', '810100000', '810102000', 'Y', 'exp', '/ex/admin/report/ExApprovalList.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810102000', 'kr', '지출결의 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810103000] 관리자 - 회계 - 지출결의 관리 - 카드 사용 현황 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810103000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810103000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810103000', 'MENU013', '810100000', '810103000', 'Y', 'exp', '/ex/admin/report/ExUseCardlList.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810103000', 'kr', '카드 사용 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810403000] 관리자 - 회계 - G20 품의/결의서 관리 - 품의/결의서 현황 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810403000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810403000'; */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810403000', 'MENU013', '810100000', '810403000', 'Y', 'ea', '/Ac/G20/State/AcExDocListView.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810403000', 'kr', 'G20 품의/결의서 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810200000] 관리자 - 회계 - 지출결의 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810200000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810200000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810200000', 'MENU013', '810000000', '810200000', 'Y', NULL, NULL, 'N', '2', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810200000', 'kr', '지출결의 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810201000] 관리자 - 회계 - 지출결의 설정 - 계정과목 설정 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810201000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810201000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810201000', 'MENU013', '810200000', '810201000', 'Y', 'exp', '/ex/admin/config/ExAcctConfig.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810201000', 'kr', '계정과목 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */
/* [810202000] 관리자 - 회계 - 지출결의 설정 - 증빙 설정 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810202000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810202000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810202000', 'MENU013', '810200000', '810202000', 'Y', 'exp', '/ex/admin/config/ExAuthConfig.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810202000', 'kr', '증빙 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */
/* [810203000] 관리자 - 회계 - 지출결의 설정 - 카드 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810203000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810203000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810203000', 'MENU013', '810200000', '810203000', 'Y', 'exp', '/ex/admin/config/ExCardConfig.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810203000', 'kr', '카드 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810204000] 관리자 - 회계 - 지출결의 설정 - 표준적요 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810204000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810204000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810204000', 'MENU013', '810200000', '810204000', 'Y', 'exp', '/ex/admin/config/ExSummaryConfig.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810204000', 'kr', '표준적요 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810205000] 관리자 - 회계 - 지출결의 설정 - 증빙유형 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810205000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810205000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810205000', 'MENU013', '810200000', '810205000', 'Y', 'exp', '/ex/admin/config/ExAuthTypeConfig.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810205000', 'kr', '증빙유형 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810206000] 관리자 - 회계 - 지출결의 설정 - 환경 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810206000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810206000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810206000', 'MENU013', '810200000', '810206000', 'Y', 'exp', '/ex/admin/config/ExExpendSetting.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810206000', 'kr', '환경 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810207000] 관리자 - 회계 - 지출결의 설정 - 양식 설정 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810207000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810207000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810207000', 'MENU013', '810200000', '810207000', 'Y', 'exp', '/ex/admin/config/ExFormSetting.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810207000', 'kr', '양식 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */
/* [810208000] 관리자 - 회계 - 지출결의 설정 - 항목 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810208000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810208000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810208000', 'MENU013', '810200000', '810208000', 'Y', 'exp', '/ex/admin/config/ExItemSetting.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810208000', 'kr', '항목 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810209000] 관리자 - 회계 - 지출결의 설정 - 관리항목 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810209000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810209000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810209000', 'MENU013', '810200000', '810209000', 'Y', 'exp', '/ex/admin/config/ExMngDefSetting.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810209000', 'kr', '관리항목 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810210000] 관리자 - 회계 - 지출결의 설정 - 버튼 설정 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810210000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810210000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810210000', 'MENU013', '810200000', '810210000', 'Y', 'exp', '/ex/admin/config/ExButtonDefSetting.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810210000', 'kr', '버튼 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */

/* [810211000] 관리자 - 회계 - 지출결의 설정 - 명칭 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810211000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810211000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810211000', 'MENU013', '810200000', '810211000', 'Y', 'exp', '/ex/admin/config/ExLabelConfig.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810211000', 'kr', '명칭 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810211000] 관리자 - 회계 - 지출결의 설정 - 버튼 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810212000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810212000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810212000', 'MENU013', '810200000', '810212000', 'Y', 'exp', '/ex/admin/config/ExButtonConfig.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810212000', 'kr', '버튼 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810300000] 관리자 - 회계 - 자금관리 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810300000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810300000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810300000', 'MENU013', '810000000', '810300000', 'Y', NULL, NULL, 'N', '2', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810300000', 'kr', '자금 관리', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810301000] 관리자 - 회계 - 자금관리 - 자금 일보 양식 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810301000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810301000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810301000', 'MENU013', '810300000', '810301000', 'Y', 'gw', '/acc/money/AccMoneyForm.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810301000', 'kr', '자금 일보 양식 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810302000] 관리자 - 회계 - 자금관리 - 자금관리 권한 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810302000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810302000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810302000', 'MENU013', '810300000', '810302000', 'Y', 'gw', '/accmoney/auth/AccSetAuthView.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810302000', 'kr', '자금 관리 권한 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810400000] 관리자 - 회계 - G20 품의/결의서 관리 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810400000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810400000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810400000', 'MENU013', '810000000', '810400000', 'Y', NULL, NULL, 'N', '2', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810400000', 'kr', 'G20 품의/결의서 관리', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */
/* [810401000] 관리자 - 회계 - G20 품의/결의서 관리 - 예실대비 현황 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810401000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810401000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810401000', 'MENU013', '810400000', '810401000', 'Y', 'ea', '/Ac/G20/State/AcBgtCompareStatusView.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810401000', 'kr', '예실대비 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */
/* [810402000] 관리자 - 회계 - G20 품의/결의서 관리 - 예산 단계별 현황 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810402000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810402000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810402000', 'MENU013', '810400000', '810402000', 'Y', 'ea', '/Ac/G20/State/AcBgtStepStatusView.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810402000', 'kr', '예산 단계별 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */
/* [810403000] 관리자 - 회계 - G20 품의/결의서 관리 - 품의/결의서 현황 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810403000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810403000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810403000', 'MENU013', '810400000', '810403000', 'Y', 'ea', '/Ac/G20/State/AcExDocListView.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810403000', 'kr', '품의/결의서 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */

/* [810500000] 관리자 - 회계 - 예실대비 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810500000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810500000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810500000', 'MENU013', '810000000', '810500000', 'Y', NULL, NULL, 'Y', '2', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810500000', 'kr', '예실대비', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810502000] 관리자 - 회계 - 예실대비 - 예실대비 현황(iCUBE) */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810502000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810502000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810502000', 'MENU013', '810500000', '810502000', 'Y', 'exp', '/ex/admin/yesil/ExAdminYesilReport.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810502000', 'kr', '예실대비 현황(iCUBE)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810503000] 관리자 - 회계 - 예실대비 - 예실대비 현황(ERPiU) */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810503000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810503000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810503000', 'MENU013', '810500000', '810503000', 'Y', 'exp', '/ex/admin/yesil/ExAdminYesil2Report.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810503000', 'kr', '예실대비 현황(ERPiU)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810401000] 관리자 - 회계 - G20 품의/결의서 관리 - 예실대비 현황 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810401000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810401000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810401000', 'MENU013', '810500000', '810401000', 'Y', 'ea', '/Ac/G20/State/AcBgtCompareStatusView.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810401000', 'kr', '예실대비 현황(G20)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */
/* [810402000] 관리자 - 회계 - G20 품의/결의서 관리 - 예산 단계별 현황 */
/* DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '810402000'; */
/* DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '810402000'; */
/* INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810402000', 'MENU013', '810500000', '810402000', 'Y', 'ea', '/Ac/G20/State/AcBgtStepStatusView.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL ); */
/* INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810402000', 'kr', '예산 단계별 현황(G20)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() ); */

/* [1] 마스터 */
/* [1810000000] 마스터 - 회계 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '1810000000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '1810000000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '1810000000', 'MENU013', '1', '1810000000', 'N', NULL, NULL, 'Y', '1', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'MASTER', 'Y', 'Y' );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1810000000', 'kr', '회계', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1810100000] 마스터 - 회계 - 지출결의 관리 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '1810100000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '1810100000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '1810100000', 'MENU013', '1810000000', '1810100000', 'Y', NULL, NULL, 'Y', '2', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'MASTER', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1810100000', 'kr', '지출결의 관리', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1810101000] 마스터 - 회계 - 지출결의 관리 - 전체 지출결의 확인 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '1810101000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '1810101000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '1810101000', 'MENU013', '1810100000', '1810101000', 'Y', 'exp', '/ex/master/report/ExApprovalSendList.do', 'Y', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'MASTER', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1810101000', 'kr', '전체 지출결의 확인', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1810102000] 마스터 - 회계 - 지출결의 관리 - 전체 지출결의 현황 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '1810102000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '1810102000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '1810102000', 'MENU013', '1810100000', '1810102000', 'Y', 'exp', '/ex/master/report/ExApprovalList.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'MASTER', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1810102000', 'kr', '전체 지출결의 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1810103000] 마스터 - 회계 - 지출결의 관리 - 전체 카드 사용 현황 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '1810103000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '1810103000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '1810103000', 'MENU013', '1810100000', '1810103000', 'Y', 'exp', '/ex/master/report/ExUseCardList.do', 'Y', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'MASTER', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1810103000', 'kr', '전체 카드 사용 현황', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1810200000] 마스터 - 회계 - 지출결의 설정 */
/* [1810201000] 마스터 - 회계 - 지출결의 설정 - 전체 계정과목 설정 */
/* [1810202000] 마스터 - 회계 - 지출결의 설정 - 전체 증빙 설정 */
/* [1810203000] 마스터 - 회계 - 지출결의 설정 - 전체 카드 설정 */
/* [1810204000] 마스터 - 회계 - 지출결의 설정 - 전체 표준적요 설정 */
/* [1810205000] 마스터 - 회계 - 지출결의 설정 - 전체 증빙유형 설정 */
/* [1810206000] 마스터 - 회계 - 지출결의 설정 - 전체 환경 설정 */
/* [1810207000] 마스터 - 회계 - 지출결의 설정 - 전체 양식 설정 */    
/* [1810208000] 마스터 - 회계 - 지출결의 설정 - 전체 항목 설정 */
/* [1810209000] 마스터 - 회계 - 지출결의 설정 - 전체 관리항목 설정 */
/* [1810210000] 마스터 - 회계 - 지출결의 설정 - 전체 버튼 설정 */
/* [1810300000] 마스터 - 회계 - 자금관리 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '1810300000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '1810300000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '1810300000', 'MENU013', '1810000000', '1810300000', 'Y', NULL, NULL, 'Y', '2', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'MASTER', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1810300000', 'kr', '자금 관리', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1810301000] 마스터 - 회계 - 자금관리 - 전체 자금 일보 양식 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '1810301000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '1810301000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '1810301000', 'MENU013', '1810300000', '1810301000', 'Y', 'gw', '/acc/money/AccMoneyForm.do', 'Y', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'MASTER', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1810301000', 'kr', '전체 자금 일보 양식 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1810302000] 마스터 - 회계 - 자금관리 - 전체 자금관리 권한 설정 */
DELETE FROM `t_co_menu_adm` WHERE `menu_no` = '1810302000';
DELETE FROM `t_co_menu_adm_multi` WHERE `menu_no` = '1810302000';
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '1810302000', 'MENU013', '810300000', '1810302000', 'Y', 'gw', '/accmoney/auth/AccSetAuthView.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'MASTER', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1810302000', 'kr', '자금관리 권한 설정', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 12. 26. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 06. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */
