/*## #################################################################################################### ##*/
/*## 2018. 06. 11. ##*/
/*## 2018. 06. 11. - 김상겸 ##*/
/*## 2018. 06. 11. - 회계(비영리) 메뉴 ##*/
/*## #################################################################################################### ##*/

/* [MENU - 메뉴분류 - t_co_code] */
INSERT IGNORE INTO `t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'MENU', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [MENU - 메뉴분류 - t_co_code_multi ] */ 
INSERT IGNORE INTO `t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'MENU', 'kr', '메뉴분류', '메뉴관련 분류', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [MENU - MENU013 - 회계] */
INSERT IGNORE INTO `t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'MENU013', 'MENU', 'N', '12', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [MENU - MENU013 - '회계] */
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'MENU013', 'MENU', 'kr', '회계', '회계', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810107000] 관리자 - 매입전자세금계산서현황 */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `menu_adm_gubun`, `menu_auth_type` )  VALUES ( '810107005', 'MENU013', '810100000', '810107005', 'Y', 'exp', '/expend/np/admin/NpAdminEtaxReport.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', 'MENU013', 'ADMIN' );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810107005', 'kr', '세금계산서 현황(비영리 2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [1001050000] 사용자 - 매입전자세금계산서현황 */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1001050000', '1001000000', '1001050000', 'Y', 'exp', '/expend/np/user/NpUserEtaxReport.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001050000', 'kr', '나의 세금계산서 현황(비영리 2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810107000] 관리자 - 카드 사용 현황 */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `menu_adm_gubun`, `menu_auth_type` )  VALUES ( '810107004', 'MENU013', '810100000', '810107004', 'Y', 'exp', '/expend/np/admin/NpAdminCardReport.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', 'MENU013', 'ADMIN' );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810107004', 'kr', '카드 사용 현황(비영리 2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [1001050000] 사용자 - 나의 카드 사용 현황 */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1001020001', '1001000000', '1001020001', 'Y', 'exp', '/expend/np/user/NpUserCardReport.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001020001', 'kr', '나의 카드 사용 현황(비영리 2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810500000] 관리자 - 예실대비 
 * * 영리과 동일 코드 사용, 메뉴 중복 생성 방지
 * */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810500000', 'MENU013', '810000000', '810500000', 'Y', NULL, NULL, 'Y', '2', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810500000', 'kr', '예실대비', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [810500000] 관리자 - 예실대비 현황 - G20 */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810504000', 'MENU013', '810500000', '810502000', 'Y', 'exp', '/expend/np/admin/NpAdminG20Yesil.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810504000', 'kr', '예실대비 현황(G20)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );



/* [810107000] 관리자 - 회계 - 지출결의 관리 - 지출결의 전송 [비영리] 2018-04-27 */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `menu_adm_gubun`, `menu_auth_type` )  VALUES ( '810107000', 'MENU013', '810100000', '810107000', 'Y', 'exp', '/expend/np/admin/NpApprovalSendList.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', 'MENU013', 'ADMIN' );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810107000', 'kr', '결의서 전송(2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810107001] 관리자 - 회계 - 지출결의 관리 - 결의서 현황 [비영리] 2018-04-27 */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `menu_adm_gubun`, `menu_auth_type` )  VALUES ( '810107001', 'MENU013', '810100000', '810107000', 'Y', 'exp', '/expend/np/admin/NpAdminResReport.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', 'MENU013', 'ADMIN' );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810107001', 'kr', '결의서 현황(2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810107002] 관리자 - 회계 - 지출결의 관리 - 품의서 반환 [비영리] 2018-04-27 */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `menu_adm_gubun`, `menu_auth_type` )  VALUES ( '810107002', 'MENU013', '810100000', '810107000', 'Y', 'exp', '/expend/np/admin/NpAdminConsConfferReturn.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', 'MENU013', 'ADMIN' );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810107002', 'kr', '품의서 반환(2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [810107003] 관리자 - 회계 - 지출결의 관리 - 품의서 현황 [비영리] 2018-04-27 */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `menu_adm_gubun`, `menu_auth_type` )  VALUES ( '810107003', 'MENU013', '810100000', '810107000', 'Y', 'exp', '/expend/np/admin/NpAdminConsReport.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', 'MENU013', 'ADMIN' );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810107003', 'kr', '품의서 현황(2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );


/* [1001070000] 사용자 - 회계 - 지출결의 관리 - 품의서 현황 [비영리] 2018-04-27 */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1001070000', '1001000000', '1001020001', 'Y', 'exp', '/expend/np/user/NpUserConsUserReport.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001070000', 'kr', '품의서 현황(2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1001070001] 사용자 - 회계 - 지출결의 관리 - 결의서 현황 [비영리] 2018-04-27 */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1001070001', '1001000000', '1001020001', 'Y', 'exp', '/expend/np/user/NpUserResUserReport.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001070001', 'kr', '결의서 현황(2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [1001070002] 사용자 - 회계 - 지출결의 관리 - 품의서 반환 [비영리] 2018-04-27 */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1001070002', '1001000000', '1001020001', 'Y', 'exp', '/expend/np/user/NpUserConsConfferReturn.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001070002', 'kr', '품의서 반환(2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );


/* 2018-08-13 최상배 */
/* [1001070002] 사용자 - 회계 - 사용자현황 - G20 사용자 예실대비 현황 2018-08-13 */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` ) VALUES ( '1000', 'MENU013', '1001020002', '1001000000', '1001020002', 'Y', 'exp', '/expend/np/user/NpUserG20Yesil.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001020002', 'kr', '나의 예실대비 현황(비영리 2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 06. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */


/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 14. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 21. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */


/* 2018-12-27 최상배 */
/* [810307001] 관리자 - 회계 - 지출결의 설정 - 품의/결의 기본설정 [비영리] 2018-04-27 */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `menu_adm_gubun`, `menu_auth_type` )  VALUES ( '810307001', 'MENU013', '810200000', '810300000', 'Y', 'exp', '/expend/np/admin/NpAdminMasterOption.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', 'MENU013', 'ADMIN' );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810307001', 'kr', '품의/결의 기본설정(2.0)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );