/* 사용자 */
/* 사용자 - 회계 */
INSERT IGNORE INTO `t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no` )
VALUES ( '1000', 'MENU013', '1000000000', '0', '1000000000', 'Y', NULL, NULL, 'N', '1', NULL, 'ea', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );

INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '1000000000', 'kr', '회계', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 사용자 - 회계 - 지출결의 관리 */
INSERT IGNORE INTO `t_co_menu` (`comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no`)
VALUES ( '1000', 'MENU013', '1001000000', '1000000000', '1000000000', 'Y', NULL, NULL, 'N', '2', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );

INSERT IGNORE INTO `t_co_menu_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '1001000000', 'kr', '지출결의 관리', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 사용자 - 회계 - 지출결의 관리 - 나의 품의서 현황 [1001030000] - /expend/np/user/NpUserConsUserReport.do */
INSERT IGNORE INTO `t_co_menu` (`comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no`)
VALUES ( '1000', 'MENU013', '1001030000', '1001000000', '1001030000', 'Y', 'exp', '/expend/np/user/NpUserConsUserReport.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );

INSERT IGNORE INTO `t_co_menu_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '1001030000', 'kr', '나의 품의서 현황(비영리)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 사용자 - 회계 - 지출결의 관리 - 나의 결의서 현황 [1001030100] - /expend/np/user/NpUserResUserReport.do */
INSERT IGNORE INTO `t_co_menu` (`comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no`)
VALUES ( '1000', 'MENU013', '1001030100', '1001000000', '1001030100', 'Y', 'exp', '/expend/np/user/NpUserResUserReport.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );

INSERT IGNORE INTO `t_co_menu_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '1001030100', 'kr', '나의 결의서 현황(비영리)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 사용자 - 회계 - 지출결의 관리 - 나의 세금계산서 현황 [1001030200] - /expend/np/user/NpUserEtaxReport.do */
-- INSERT IGNORE INTO `t_co_menu` (`comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no`)
-- VALUES ( '1000', 'MENU013', '1001030200', '1001000000', '1001030200', 'Y', 'exp', '/expend/np/user/NpUserEtaxReport.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );

-- INSERT IGNORE INTO `t_co_menu_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
-- VALUES ( '1001030200', 'kr', '나의 세금계산서 현황(비영리)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 사용자 - 회계 - 지출결의 관리 - 나의 품의서 반환 [1001030300] - /expend/np/user/NpUserConsConfferReturn.do */
INSERT IGNORE INTO `t_co_menu` (`comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn`, `open_menu_no`)
VALUES ( '1000', 'MENU013', '1001030300', '1001000000', '1001030300', 'Y', 'exp', '/expend/np/user/NpUserConsConfferReturn.do', 'N', '3', NULL, NULL, NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y', NULL, NULL );

INSERT IGNORE INTO `t_co_menu_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '1001030300', 'kr', '나의 품의서 반환(비영리)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 관리자 */
/* 관리자 - 회계 */
INSERT IGNORE INTO `t_co_menu_adm` (`menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn`)
VALUES ( '810000000', 'MENU013', '0', '810000000', 'Y', NULL, NULL, 'N', '1', 'ea', 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );

INSERT IGNORE INTO `t_co_menu_adm_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '810000000', 'kr', '회계', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 관리자 - 회계 - 지출결의 관리 */
INSERT IGNORE INTO `t_co_menu_adm` (`menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn`)
VALUES ( '810100000', 'MENU013', '810000000', '810100000', 'Y', NULL, NULL, 'N', '2', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );

INSERT IGNORE INTO `t_co_menu_adm_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '810100000', 'kr', '지출결의 관리', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 관리자 - 회계 - 지출결의 관리 - 지출결의 전송 [810105010] */
INSERT IGNORE INTO `t_co_menu_adm` (`menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn`)
VALUES ( '810105010', 'MENU013', '810100000', '810105010', 'Y', 'exp', '/expend/np/admin/NpApprovalSendList.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );

INSERT IGNORE INTO `t_co_menu_adm_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '810105010', 'kr', '지출결의 전송(비영리)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 관리자 - 회계 - 지출결의 관리 - 카드사용 현황 [810105020] */
INSERT IGNORE INTO `t_co_menu_adm` (`menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn`)
VALUES ( '810105020', 'MENU013', '810100000', '810105020', 'Y', 'exp', '/expend/np/admin/NpAdminCardReport.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );

INSERT IGNORE INTO `t_co_menu_adm_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '810105020', 'kr', '카드사용 현황(비영리)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 관리자 - 회계 - 지출결의 관리 - 품의서 현황 [810105030] */
INSERT IGNORE INTO `t_co_menu_adm` (`menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn`)
VALUES ( '810105030', 'MENU013', '810100000', '810105030', 'Y', 'exp', '/expend/np/admin/NpAdminConsReport.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );

INSERT IGNORE INTO `t_co_menu_adm_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '810105030', 'kr', '품의서 현황(비영리)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 관리자 - 회계 - 지출결의 관리 - 결의서 현황 [810105040] */
INSERT IGNORE INTO `t_co_menu_adm` (`menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn`)
VALUES ( '810105040', 'MENU013', '810100000', '810105040', 'Y', 'exp', '/expend/np/admin/NpAdminResReport.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );

INSERT IGNORE INTO `t_co_menu_adm_multi` (`menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ( '810105040', 'kr', '결의서 현황(비영리)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 관리자 - 회계 - 지출결의 설정 */
/* 관리자 - 회계 - 지출결의 설정 - 품의결의 기본설정 */
/* 관리자 - 회계 - 지출결의 설정 - 품의결의 환경설정 */


/* 카드 연동 기능 ( 옵션 - 유상상품 ) */
/* 카드 설정 - 비영리 - 메뉴 */
INSERT IGNORE INTO t_co_menu_adm ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` )
VALUES ( '810203100', 'MENU013', '810200000', '810203100', 'Y', 'exp', '/ex/admin/config/NpExCardConfig.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );

/* 카드 설정 - 비영리 - 명칭 */
INSERT IGNORE INTO t_co_menu_adm_multi ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '810203100', 'kr', '카드 설정(비영리)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );