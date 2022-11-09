/* 지출결의 ( 영리 ) 옵션 설정 쿼리 */

/* 1.1 매입전자세금계산서 버튼 노출 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
UPDATE  `neos`.`t_co_code_detail_multi`
SET     `detail_name` = 'Y'
WHERE   `code` = 'ex00027'
AND     `detail_code` = 'ETAXBTN';

/* 1.2 매입전자세금계산서 버튼 미노출 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
UPDATE  `neos`.`t_co_code_detail_multi`
SET     `detail_name` = 'N'
WHERE   `code` = 'ex00027'
AND     `detail_code` = 'ETAXBTN';

/* 2.1 카드 사용 내역 버튼 노출 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
UPDATE  `neos`.`t_co_code_detail_multi`
SET     `detail_name` = 'Y'
WHERE   `code` = 'ex00027'
AND     `detail_code` = 'CARDBTN';

/* 2.2 카드 사용 내역 버튼 미노출 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
UPDATE  `neos`.`t_co_code_detail_multi`
SET     `detail_name` = 'N'
WHERE   `code` = 'ex00027'
AND     `detail_code` = 'CARDBTN';

/* 3.1 예산연동 사용 설정 코드 노출 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
/* 예산연동 사용여부 - ex00028 - Y ( 사용 ) */
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUE ( 'Y', 'ex00028', 'N', 2, NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUE ( 'Y', 'ex00028', 'kr', '사용', '사용', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );


/* 2017. 08. 01. */
/* 2017. 08. 01. - 신재호 */
/* 2017. 08. 01. - 신재호 - 세금계산서 현황 페이지 배포 */
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810105000', 'MENU013', '810100000', '810105000', 'Y', 'exp', '/ex/admin/report/ExAdminETaxlListiCUBE.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810105000', 'kr', '세금계산서현황(iCUBE)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` ) VALUES ( '810106000', 'MENU013', '810100000', '810106000', 'Y', 'exp', '/ex/admin/report/ExAdminETaxlListERPiU.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'MENU013', 'ADMIN', 'Y', NULL );
INSERT IGNORE INTO `t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '810106000', 'kr', '세금계산서현황(ERPiU)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* 2018. 02. 08 */
/* 2018. 02. 08 - 신재호 */
/* 2018. 02. 08 - 신재호 - 메뉴 추가 - 나의 세금계산서 현황 */
/* ERPiU */
INSERT IGNORE INTO `t_co_menu` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn` ) VALUES ( '1001030000', 'MENU013', '1001000000', '1001030000', 'Y', 'exp', '/ex/user/report/ExUserETaxERPiUList.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y' );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001030000', 'kr', '나의 세금계산서 현황(ERPiU)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* iCUBE */
INSERT IGNORE INTO `t_co_menu` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn` ) VALUES ( '1001040000', 'MENU013', '1001000000', '1001040000', 'Y', 'exp', '/ex/user/report/ExUserETaxiCUBEList.do', 'N', '3', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW(), 'Y' );
INSERT IGNORE INTO `t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1001040000', 'kr', '나의 세금계산서 현황(iCUBE)', NULL, 'SYSTEM', NOW(), 'SYSTEM', NOW() );
