/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 11. 22. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 스마트 자금관리 공통코드 추가 */

/* [ac0001 - 자금관리] */ 
INSERT IGNORE INTO `t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( 'ac0001', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [ac0001 - '자금관리', ] */ 
INSERT IGNORE INTO `t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( 'ac0001', 'kr', '자금관리', NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [001 - 자금일보] */ 
INSERT IGNORE INTO `t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '001', 'ac0001', 'N', '1', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [002 - 총괄자금현황] */ 
INSERT IGNORE INTO `t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '002', 'ac0001', 'N', '2', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [003 - 법인카드사용현황] */ 
INSERT IGNORE INTO `t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '003', 'ac0001', 'N', '3', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [004 - 금융자산현황] */ 
INSERT IGNORE INTO `t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '004', 'ac0001', 'N', '4', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [005 - 어음관리현황] */ 
INSERT IGNORE INTO `t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '005', 'ac0001', 'N', '5', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [006 - 채권연령분석] */ 
INSERT IGNORE INTO `t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '006', 'ac0001', 'N', '6', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [007 - 자금캘린더] */ 
INSERT IGNORE INTO `t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '007', 'ac0001', 'N', '7', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [001 - '자금일보', ] */ 
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '001', 'ac0001', 'kr', '자금일보', NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [002 - '총괄자금현황', ] */ 
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '002', 'ac0001', 'kr', '총괄자금현황', NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [003 - '법인카드사용현황', ] */ 
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '003', 'ac0001', 'kr', '법인카드사용현황', NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [004 - '금융자산현황', ] */ 
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '004', 'ac0001', 'kr', '금융자산현황', NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [005 - '어음관리현황', ] */ 
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '005', 'ac0001', 'kr', '어음관리현황', NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [006 - '채권연령분석', ] */ 
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '006', 'ac0001', 'kr', '채권연령분석', NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* [007 - '자금캘린더', ] */ 
INSERT IGNORE INTO `t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
VALUES ( '007', 'ac0001', 'kr', '자금캘린더', NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 12. 26. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 02. 24. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2017. 03. 08. */
/* 2017. 03. 08. - 김상겸 */
/* 2017. 03. 08. - 김상겸 - 전자결재 양식 구분 추가 ( 스마트 자금관리 ) */
/* [ea0007 - ea0090 - 자금관리] */
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ea0090', 'ea0007', 'N', '1090', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ea0090', 'ea0007', 'kr', '자금관리', '자금관리', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [ea0090 - 자금관리] */
INSERT IGNORE INTO `neos`.`t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ea0090', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ea0090', 'kr', '자금관리', '자금관리 양식구분', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() ); 

/* [ea0090 - ba1000 - 연동문서(자금계획)] */
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ba1000', 'ea0090', 'N', '1010', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ba1000', 'ea0090', 'kr', '연동문서(자금계획)', '연동문서(자금계획)', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [ea0090 - ba2000 - 연동문서(자금이체)] */
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ba2000', 'ea0090', 'N', '1020', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ba2000', 'ea0090', 'kr', '연동문서(자금이체)', '연동문서(자금이체)', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* [ea0090 - ba3000 - 연동문서(자금일보)] */
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ba3000', 'ea0090', 'N', '1030', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'ba3000', 'ea0090', 'kr', '연동문서(자금일보)', '연동문서(자금일보)', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 07. 18. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 08. 10. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */