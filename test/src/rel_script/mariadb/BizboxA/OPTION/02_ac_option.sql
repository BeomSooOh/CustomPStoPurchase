/* 지출결의 ( 비영리 ) 옵션 설정 쿼리 */

/* iCUBE G20 - 결의서 옵션 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
INSERT IGNORE INTO `neos`.`t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20301', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( 'G20301', 'kr', 'G20옵션', 'G20옵션', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
/* iCUBE G20 - 결의서 옵션 - 명세서 사용 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '001', 'G20301', 'N', '1010', null, null, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );
INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES ( '001', 'G20301', 'kr', 'Y', 'Y', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

/* iCUBE G20 - 결의서 옵션 - 명세서 사용 활성화 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
UPDATE	`neos`.`t_co_code_detail_multi`
SET		`detail_name` = 'Y'
		, `note` = 'Y'
		, `use_yn` = 'Y'
WHERE	`code` = 'G20301'
AND		`detail_code` = '001';

/* iCUBE G20 - 결의서 옵션 - 명세서 사용 비활성화 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
UPDATE	`neos`.`t_co_code_detail_multi`
SET		`detail_name` = 'N'
		, `note` = 'N'
		, `use_yn` = 'Y'
WHERE	`code` = 'G20301'
AND		`detail_code` = '001';

/* iCUBE G20 - 영리결재 적용 *//* 쿼리 실행후 URL 호출 필요 : http://domain/exp/cmm/system/commonCodeReBuild.do */
/* 검색결과중 PKG 부분은 삭제를 진행해야 함. 별도 커스텀이 있는경우 삭제하면 안 됨. 커스텀 경우에는 지원 불가 또는 detail_code_div 변경으로 대응 가능 */
SELECT * FROM teag_out_process WHERE detail_code_div = 'ea0060';

INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code` ,`code` , `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES
( '5031', 'ea0060', 'N', '5031', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() ),
( '5041', 'ea0060', 'N', '5041', NULL, NULL, 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );

INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` ) VALUES
( '5031', 'ea0060', 'kr', 'G20결의서(iCUBE)', 'G20결의서(iCUBE)', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() ),
( '5041', 'ea0060', 'kr', 'G20품의서(iCUBE)', 'G20품의서(iCUBE)', 'Y', 'SYSTEM', NOW(), 'SYSTEM', NOW() );