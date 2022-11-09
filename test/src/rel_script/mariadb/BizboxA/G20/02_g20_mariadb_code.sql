/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 11. 22. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - G20 공통코드 추가 */

/* `neos`.`t_co_code` */
INSERT IGNORE INTO `neos`.`t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20101', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20201', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20SET', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20VAT', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20_TR', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* `neos`.`t_co_code_multi` */
INSERT IGNORE INTO `neos`.`t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20101', 'kr', 'G20품의서', 'G20품의서', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20201', 'kr', 'G20결의서', 'G20결의서', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20SET', 'kr', 'G20 결재수단', '결의서 작성시 결재수단', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20VAT', 'kr', 'G20 과세구분', '결의서 작성시 과세구분', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20_TR', 'kr', 'G20 채주유형', '결의서 작성시 채주유형', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* `neos`.`t_co_code_detail` */
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1', 'G20101', 'Y', '1', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2', 'G20101', 'Y', '2', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3', 'G20101', 'Y', '3', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '4', 'G20101', 'Y', '4', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '5', 'G20101', 'Y', '5', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '6', 'G20101', 'Y', '6', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '7', 'G20101', 'Y', '7', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '8', 'G20101', 'Y', '8', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1', 'G20201', 'Y', '1', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2', 'G20201', 'Y', '2', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3', 'G20201', 'Y', '3', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '4', 'G20201', 'Y', '4', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '5', 'G20201', 'Y', '5', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '6', 'G20201', 'Y', '6', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '7', 'G20201', 'Y', '7', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '8', 'G20201', 'Y', '8', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '9', 'G20201', 'Y', '9', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1', 'G20SET', 'N', '1', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2', 'G20SET', 'N', '2', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3', 'G20SET', 'N', '3', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '4', 'G20SET', 'N', '4', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1', 'G20VAT', 'N', '1', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2', 'G20VAT', 'N', '2', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3', 'G20VAT', 'N', '3', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1', 'G20_TR', 'N', '1', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2', 'G20_TR', 'N', '2', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3', 'G20_TR', 'N', '3', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '4', 'G20_TR', 'N', '4', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '5', 'G20_TR', 'N', '5', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '6', 'G20_TR', 'N', '6', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '7', 'G20_TR', 'N', '7', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '8', 'G20_TR', 'N', '8', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '9', 'G20_TR', 'N', '9', '', '', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* `neos`.`t_co_code_detail_multi` */
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1','G20101','kr','구매품의서','G20품의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2','G20101','kr','제조품의서','G20품의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3','G20101','kr','수리품의서','G20품의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '4','G20101','kr','외부거래처용','G20품의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '5','G20101','kr','내부직원용','G20품의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '6','G20101','kr','기타소득자용','G20품의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '7','G20101','kr','기타','G20품의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '8','G20101','kr','수입','G20품의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1','G20201','kr','지출결의서','G20결의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2','G20201','kr','공사집행지출결의서','G20결의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3','G20201','kr','용역과지출결의서','G20결의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '4','G20201','kr','구입과지출결의서','G20결의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '5','G20201','kr','수입결의서','G20결의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '6','G20201','kr','여입결의서','G20결의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '7','G20201','kr','반납결의서','G20결의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '8','G20201','kr','여비지출결의서','G20결의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '9','G20201','kr','봉급지출결의서','G20결의서','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1','G20SET','kr','예금','예금','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2','G20SET','kr','현금','현금','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3','G20SET','kr','외상','외상','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '4','G20SET','kr','카드','카드','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1','G20VAT','kr','과세','과세','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2','G20VAT','kr','면세','면세','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3','G20VAT','kr','기타','기타','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '1','G20_TR','kr','거래처','거래처','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '2','G20_TR','kr','사원등록','사원등록','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '3','G20_TR','kr','거래처명','거래처명','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '4','G20_TR','kr','기타소득자','기타소득자','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '5','G20_TR','kr','기금','기금','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '6','G20_TR','kr','운영비','운영비','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '7','G20_TR','kr','결연자','결연자','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '8','G20_TR','kr','급여','급여','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '9','G20_TR','kr','사업소득자','사업소득자','Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 07. 18. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 08. 10. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */