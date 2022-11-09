/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_co_menu` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        '/* ['
        , `menu_no`
        , ' - '
        , IFNULL(( SELECT `menu_nm` FROM `neos`.`t_co_menu_multi` WHERE `menu_no` = `A`.`menu_no` LIMIT 1 ), '')
        , '] */ \r\n'
        , 'INSERT IGNORE INTO `neos`.`t_co_menu` ( `comp_seq`, `menu_gubun`, `menu_no`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_path`, `menu_img_class`, `menu_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `public_yn`, `delete_yn` )'
        , '\r\nVALUES ( '
        , CASE WHEN `comp_seq` IS NULL OR `comp_seq` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `comp_seq`, ''', ') END
        , CASE WHEN `menu_gubun` IS NULL OR `menu_gubun` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_gubun`, ''', ') END
        , CASE WHEN `menu_no` IS NULL OR `menu_no` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_no`, ''', ') END
        , CASE WHEN `upper_menu_no` IS NULL OR `upper_menu_no` = '' THEN CONCAT('''0''', ', ') ELSE CONCAT('''', `upper_menu_no`, ''', ') END
        , CASE WHEN `menu_ordr` IS NULL OR `menu_ordr` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_ordr`, ''', ') END
        , CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , CASE WHEN `url_gubun` IS NULL OR `url_gubun` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `url_gubun`, ''', ') END
        , CASE WHEN `url_path` IS NULL OR `url_path` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `url_path`, ''', ') END
        , CASE WHEN `sso_use_yn` IS NULL OR `sso_use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `sso_use_yn`, ''', ') END
        , CASE WHEN `menu_depth` IS NULL OR `menu_depth` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_depth`, ''', ') END
        , CASE WHEN `menu_img_path` IS NULL OR `menu_img_path` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_img_path`, ''', ') END
        , CASE WHEN `menu_img_class` IS NULL OR `menu_img_class` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_img_class`, ''', ') END
        , CASE WHEN `menu_type` IS NULL OR `menu_type` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_type`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW(), '
        , CASE WHEN `public_yn` IS NULL OR `public_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `public_yn`, ''', ') END
        , CASE WHEN `delete_yn` IS NULL OR `delete_yn` = '' THEN CONCAT('NULL', '') ELSE CONCAT('''', `delete_yn`, '''') END
        , ' );'
        ) AS '`neos`.`t_co_menu` insert query'
FROM    `neos`.`t_co_menu` A
WHERE   `menu_no` IN ( '1000000000', '1001000000', '1001010000', '1001020000', '1002000000', '1002010000' );

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_co_menu_multi` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        '/* ['
        , `menu_no`
        , ' - '
        , CASE WHEN `menu_nm` IS NULL OR `menu_nm` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_nm`, ''', ') END
        , '] */ \r\n'
        , 'INSERT IGNORE INTO `neos`.`t_co_menu_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )'
        , '\r\nVALUES ( '
        , CASE WHEN `menu_no` IS NULL OR `menu_no` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_no`, ''', ') END
        , CASE WHEN `lang_code` IS NULL OR `lang_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `lang_code`, ''', ') END
        , CASE WHEN `menu_nm` IS NULL OR `menu_nm` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_nm`, ''', ') END
        , CASE WHEN `menu_dc` IS NULL OR `menu_dc` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_dc`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW()'
        , ' );'
        ) AS '`neos`.`t_co_menu_multi` insert query'
FROM    `neos`.`t_co_menu_multi`
WHERE   `menu_no` IN ( '1000000000', '1001000000', '1001010000', '1001020000', '1002000000', '1002010000' );

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_co_menu_adm` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        '/* ['
        , `menu_no`
        , ' - '
        , IFNULL(( SELECT `menu_nm` FROM `neos`.`t_co_menu_adm_multi` WHERE `menu_no` = `A`.`menu_no` LIMIT 1 ), '')
        , '] */ \r\n'
        , 'INSERT IGNORE INTO `neos`.`t_co_menu_adm` ( `menu_no`, `menu_gubun`, `upper_menu_no`, `menu_ordr`, `use_yn`, `url_gubun`, `url_path`, `sso_use_yn`, `menu_depth`, `menu_img_class`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `menu_adm_gubun`, `menu_auth_type`, `public_yn`, `delete_yn` )'
        , '\r\nVALUES ( '
        , CASE WHEN `menu_no` IS NULL OR `menu_no` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_no`, ''', ') END
        , CASE WHEN `menu_gubun` IS NULL OR `menu_gubun` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_gubun`, ''', ') END
        , CASE WHEN `upper_menu_no` IS NULL OR `upper_menu_no` = '' THEN CONCAT('''0''', ', ') ELSE CONCAT('''', `upper_menu_no`, ''', ') END
        , CASE WHEN `menu_ordr` IS NULL OR `menu_ordr` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_ordr`, ''', ') END
        , CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , CASE WHEN `url_gubun` IS NULL OR `url_gubun` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `url_gubun`, ''', ') END
        , CASE WHEN `url_path` IS NULL OR `url_path` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `url_path`, ''', ') END
        , CASE WHEN `sso_use_yn` IS NULL OR `sso_use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `sso_use_yn`, ''', ') END
        , CASE WHEN `menu_depth` IS NULL OR `menu_depth` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_depth`, ''', ') END
        , CASE WHEN `menu_img_class` IS NULL OR `menu_img_class` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_img_class`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW(), '
        , CASE WHEN `menu_adm_gubun` IS NULL OR `menu_adm_gubun` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_adm_gubun`, ''', ') END
        , CASE WHEN `menu_auth_type` IS NULL OR `menu_auth_type` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_auth_type`, ''', ') END
        , CASE WHEN `public_yn` IS NULL OR `public_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `public_yn`, ''', ') END
        , CASE WHEN `delete_yn` IS NULL OR `delete_yn` = '' THEN CONCAT('NULL', '') ELSE CONCAT('''', `delete_yn`, '''') END
        , ' );'
        ) AS '`neos`.`t_co_menu_adm` insert query'
FROM    `neos`.`t_co_menu_adm` A
WHERE   `menu_no` IN (	'810000000', '810100000', '810101000', '810102000', '810103000', '810200000', '810201000', '810202000', '810203000', '810204000', '810205000', '810206000', '810207000', '810208000', '810209000', '810210000', '810300000', '810301000', '810302000', '810400000', '810401000', '810402000', '810403000', 
						'1810000000', '1810100000', '1810101000', '1810102000', '1810103000', '1810200000', '1810201000', '1810202000', '1810203000', '1810204000', '1810205000', '1810206000', '1810207000', '1810208000', '1810209000', '1810210000', '1810300000', '1810301000', '1810302000' );

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_co_menu_adm_multi` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        '/* ['
        , `menu_no`
        , ' - '
        , CASE WHEN `menu_nm` IS NULL OR `menu_nm` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_nm`, ''', ') END
        , '] */ \r\n'
        , 'INSERT IGNORE INTO `neos`.`t_co_menu_adm_multi` ( `menu_no`, `lang_code`, `menu_nm`, `menu_dc`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )'
        , '\r\nVALUES ( '
        , CASE WHEN `menu_no` IS NULL OR `menu_no` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_no`, ''', ') END
        , CASE WHEN `lang_code` IS NULL OR `lang_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `lang_code`, ''', ') END
        , CASE WHEN `menu_nm` IS NULL OR `menu_nm` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_nm`, ''', ') END
        , CASE WHEN `menu_dc` IS NULL OR `menu_dc` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `menu_dc`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW()'
        , ' );'
        ) AS '`neos`.`t_co_menu_adm_multi` insert query'
FROM    `neos`.`t_co_menu_adm_multi`
WHERE   `menu_no` IN (	'810000000', '810100000', '810101000', '810102000', '810103000', '810200000', '810201000', '810202000', '810203000', '810204000', '810205000', '810206000', '810207000', '810208000', '810209000', '810210000', '810300000', '810301000', '810302000', '810400000', '810401000', '810402000', '810403000', 
						'1810000000', '1810100000', '1810101000', '1810102000', '1810103000', '1810200000', '1810201000', '1810202000', '1810203000', '1810204000', '1810205000', '1810206000', '1810207000', '1810208000', '1810209000', '1810210000', '1810300000', '1810301000', '1810302000' );

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_co_code` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        'INSERT IGNORE INTO `neos`.`t_co_code` ( `code`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )'
        , ' VALUES ( '
        , CASE WHEN `code` IS NULL OR `code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `code`, ''', ') END
        , CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW()'
        , ' );'
        , ' /* ['
        , `code`
        , ' - '
        , IFNULL(( SELECT `name` FROM `neos`.`t_co_code_multi` WHERE `code` = A.`code` AND `lang_code` = 'kr' LIMIT 1 ), '')
        , '] */'
        ) AS '`neos`.`t_co_code` insert query'
FROM    `neos`.`t_co_code` A
WHERE   `code` = '!@#$%^&*(*&^%$@#';

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_co_code_multi` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        'INSERT IGNORE INTO `neos`.`t_co_code_multi` ( `code`, `lang_code`, `name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )'
        , ' VALUES ( '
        , CASE WHEN `code` IS NULL OR `code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `code`, ''', ') END
        , CASE WHEN `lang_code` IS NULL OR `lang_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `lang_code`, ''', ') END
        , CASE WHEN `name` IS NULL OR `name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `name`, ''', ') END
        , CASE WHEN `note` IS NULL OR `note` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `note`, ''', ') END
        , CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW()'
        , ' );'
        , ' /* ['
        , `code`
        , ' - '
        , CASE WHEN `name` IS NULL OR `name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `name`, ''', ') END
        , '] */ '
        ) AS '`neos`.`t_co_code_multi` insert query'
FROM    `neos`.`t_co_code_multi`
WHERE   `lang_code` = 'kr'
AND		`code` = '!@#$%^&*(*&^%$@#';

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_co_code_detail` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        'INSERT IGNORE INTO `neos`.`t_co_code_detail` ( `detail_code`, `code`, `ischild`, `order_num`, `flag_1`, `flag_2`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )'
        , ' VALUES ( '
        , CASE WHEN `detail_code` IS NULL OR `detail_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `detail_code`, ''', ') END
        , CASE WHEN `code` IS NULL OR `code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `code`, ''', ') END
        , CASE WHEN `ischild` IS NULL OR `ischild` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `ischild`, ''', ') END
        , CASE WHEN `order_num` IS NULL OR `order_num` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `order_num`, ''', ') END
        , CASE WHEN `flag_1` IS NULL OR `flag_1` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `flag_1`, ''', ') END
        , CASE WHEN `flag_2` IS NULL OR `flag_2` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `flag_2`, ''', ') END
        , CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW()'
        , ' );'
        , ' /* ['
        , `code`
        , ' - '
        , `detail_code`
        , ' - '
        , IFNULL(( SELECT `detail_name` FROM `neos`.`t_co_code_detail_multi` WHERE `code` = A.`code` AND `detail_code` = A.`detail_code` AND `lang_code` = 'kr' LIMIT 1 ), '')
        , '] */'
        ) AS '`neos`.`t_co_code_detail` insert query'
FROM    `neos`.`t_co_code_detail` A
WHERE   `code` = '!@#$%^&*(*&^%$@#';

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_co_code_detail_multi` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        'INSERT IGNORE INTO `neos`.`t_co_code_detail_multi` ( `detail_code`, `code`, `lang_code`, `detail_name`, `note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )'
        , ' VALUES ( '
        , CASE WHEN `detail_code` IS NULL OR `detail_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `detail_code`, ''', ') END
        , CASE WHEN `code` IS NULL OR `code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `code`, ''', ') END
        , CASE WHEN `lang_code` IS NULL OR `lang_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `lang_code`, ''', ') END
        , CASE WHEN `detail_name` IS NULL OR `detail_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `detail_name`, ''', ') END
        , CASE WHEN `note` IS NULL OR `note` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `note`, ''', ') END
        , CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW()'
        , ' );'
        , ' /* ['
        , `code`
        , ' - '
        , `detail_code`
        , ' - '
        , CASE WHEN `detail_name` IS NULL OR `detail_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `detail_name`, '') END
        , '] */'
        ) AS '`neos`.`t_co_code_detail_multi` insert query'
FROM    `neos`.`t_co_code_detail_multi` A
WHERE   `lang_code` = 'kr'
AND		`code` = '!@#$%^&*(*&^%$@#';

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_ex_option` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        'INSERT INTO `neos`.`t_ex_option` ( `comp_seq`, `form_seq`, `option_gbn`, `option_code`, `use_sw`, `order_num`, `common_code`, `base_value`, `base_name`, `base_emp_value`, `set_value`, `set_name`, `set_emp_value`, `option_select_type`, `option_process_type`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )'
        , ' VALUES ( '
        , CASE WHEN `comp_seq` IS NULL OR `comp_seq` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `comp_seq`, ''', ') END
        , CASE WHEN `form_seq` IS NULL OR `form_seq` = '' THEN CONCAT('''0''', ', ') ELSE CONCAT('''', `form_seq`, ''', ') END
        , CASE WHEN `option_gbn` IS NULL OR `option_gbn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_gbn`, ''', ') END
        , CASE WHEN `option_code` IS NULL OR `option_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_code`, ''', ') END
        , CASE WHEN `use_sw` IS NULL OR `use_sw` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_sw`, ''', ') END
        , CASE WHEN `order_num` IS NULL OR `order_num` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `order_num`, ''', ') END
        , CASE WHEN `common_code` IS NULL OR `common_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `common_code`, ''', ') END
        , CASE WHEN `base_value` IS NULL OR `base_value` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `base_value`, ''', ') END
        , CASE WHEN `base_name` IS NULL OR `base_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `base_name`, ''', ') END
        , CASE WHEN `base_emp_value` IS NULL OR `base_emp_value` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `base_emp_value`, ''', ') END
        , CASE WHEN `set_value` IS NULL OR `set_value` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `set_value`, ''', ') END
        , CASE WHEN `set_name` IS NULL OR `set_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `set_name`, ''', ') END
        , CASE WHEN `set_emp_value` IS NULL OR `set_emp_value` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `set_emp_value`, ''', ') END
        , CASE WHEN `option_select_type` IS NULL OR `option_select_type` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_select_type`, ''', ') END
        , CASE WHEN `option_process_type` IS NULL OR `option_process_type` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_process_type`, ''', ') END
        , CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW()'
        , ' ) ON DUPLICATE KEY UPDATE '
        , '`comp_seq` = ', CASE WHEN `comp_seq` IS NULL OR `comp_seq` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `comp_seq`, ''', ') END
        , '`form_seq` = ',  CASE WHEN `form_seq` IS NULL OR `form_seq` = '' THEN CONCAT('''0''', ', ') ELSE CONCAT('''', `form_seq`, ''', ') END
        , '`option_gbn` = ', CASE WHEN `option_gbn` IS NULL OR `option_gbn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_gbn`, ''', ') END
        , '`option_code` = ', CASE WHEN `option_code` IS NULL OR `option_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_code`, ''', ') END
        , '`use_sw` = ', CASE WHEN `use_sw` IS NULL OR `use_sw` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_sw`, ''', ') END
        , '`order_num` = ', CASE WHEN `order_num` IS NULL OR `order_num` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `order_num`, ''', ') END
        , '`common_code` = ', CASE WHEN `common_code` IS NULL OR `common_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `common_code`, ''', ') END
        , '`base_value` = ', CASE WHEN `base_value` IS NULL OR `base_value` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `base_value`, ''', ') END
        , '`base_name` = ', CASE WHEN `base_name` IS NULL OR `base_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `base_name`, ''', ') END
        , '`base_emp_value` = ', CASE WHEN `base_emp_value` IS NULL OR `base_emp_value` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `base_emp_value`, ''', ') END
        , '`set_value` = ', CASE WHEN `set_value` IS NULL OR `set_value` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `set_value`, ''', ') END
        , '`set_name` = ', CASE WHEN `set_name` IS NULL OR `set_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `set_name`, ''', ') END
        , '`set_emp_value` = ', CASE WHEN `set_emp_value` IS NULL OR `set_emp_value` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `set_emp_value`, ''', ') END
        , '`option_select_type` = ', CASE WHEN `option_select_type` IS NULL OR `option_select_type` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_select_type`, ''', ') END
        , '`option_process_type` = ', CASE WHEN `option_process_type` IS NULL OR `option_process_type` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_process_type`, ''', ') END
        , '`use_yn` = ', CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , '`create_seq` = ''SYSTEM'', '
        , '`create_date` = NOW(), '
        , '`modify_seq` = ''SYSTEM'', '
        , '`modify_date` = NOW();'
        , ' /* ['
        , `option_gbn`
        , ' - '
        , `option_code`
        , ' - '
        , `use_sw`
        , ' - '
        , IFNULL(( SELECT option_name FROM `neos`.`t_ex_option_multi` WHERE `option_gbn` = A.`option_gbn` AND `option_code` = A.`option_code` AND `use_sw` = A.`use_sw` AND lang_code = 'kr' LIMIT 1 ), '')
        , '] */'
        ) AS '`neos`.`t_ex_option` insert query'
FROM    `neos`.`t_ex_option` A
WHERE   `comp_seq` = '0'
AND     `form_seq` = '0'
AND     ( `use_sw` IS NOT NULL AND `use_sw` != '' );

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_ex_option_multi` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        'INSERT INTO `neos`.`t_ex_option_multi` ( `option_gbn`, `option_code`, `use_sw`, `lang_code`, `option_name`, `option_note`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )'
        , ' VALUES ( '
        , CASE WHEN `option_gbn` IS NULL OR `option_gbn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_gbn`, ''', ') END
        , CASE WHEN `option_code` IS NULL OR `option_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_code`, ''', ') END
        , CASE WHEN `use_sw` IS NULL OR `use_sw` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_sw`, ''', ') END
        , CASE WHEN `lang_code` IS NULL OR `lang_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `lang_code`, ''', ') END
        , CASE WHEN `option_name` IS NULL OR `option_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_name`, ''', ') END
        , CASE WHEN `option_note` IS NULL OR `option_note` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_note`, ''', ') END
        , CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW()'
        , ' ) ON DUPLICATE KEY UPDATE '
        , '`option_gbn` = ', CASE WHEN `option_gbn` IS NULL OR `option_gbn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_gbn`, ''', ') END
        , '`option_code` = ', CASE WHEN `option_code` IS NULL OR `option_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_code`, ''', ') END
        , '`use_sw` = ', CASE WHEN `use_sw` IS NULL OR `use_sw` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_sw`, ''', ') END
        , '`lang_code` = ', CASE WHEN `lang_code` IS NULL OR `lang_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `lang_code`, ''', ') END
        , '`option_name` = ', CASE WHEN `option_name` IS NULL OR `option_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_name`, ''', ') END
        , '`option_note` = ', CASE WHEN `option_note` IS NULL OR `option_note` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_note`, ''', ') END
        , '`use_yn` = ', CASE WHEN `use_yn` IS NULL OR `use_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `use_yn`, ''', ') END
        , '`create_seq` = ''SYSTEM'', '
        , '`create_date` = NOW(), '
        , '`modify_seq` = ''SYSTEM'', '
        , '`modify_date` = NOW();'
        , ' /* ['
        , `option_gbn`
        , ' - '
        , `option_code`
        , ' - '
        , `use_sw`
        , ' - '
        , CASE WHEN `option_name` IS NULL OR `option_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `option_name`, '') END
        , '] */'
        ) AS '`neos`.`t_ex_option_multi` insert query'
FROM    `neos`.`t_ex_option_multi`
WHERE   `lang_code` = 'kr'
AND     ( `use_sw` IS NOT NULL AND `use_sw` != '' );

/* --------------------------------------------------------------------------------------------- */
/* `neos`.`t_ex_item` make query */
/* --------------------------------------------------------------------------------------------- */
SELECT  CONCAT(
        'INSERT INTO `neos`.`t_ex_item` ( `comp_seq`, `form_seq`, `item_gbn`, `langpack_code`, `langpack_name`, `order_num`, `display_align`, `head_code`, `select_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )'
        , ' VALUES ( '
        , CASE WHEN `comp_seq` IS NULL OR `comp_seq` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `comp_seq`, ''', ') END
        , CASE WHEN `form_seq` IS NULL OR `form_seq` = '' THEN CONCAT('''0''', ', ') ELSE CONCAT('''', `form_seq`, ''', ') END
        , CASE WHEN `item_gbn` IS NULL OR `item_gbn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `item_gbn`, ''', ') END
        , CASE WHEN `langpack_code` IS NULL OR `langpack_code` = '' THEN CONCAT('''''', ', ') ELSE CONCAT('''', `langpack_code`, ''', ') END
        , CASE WHEN `langpack_name` IS NULL OR `langpack_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `langpack_name`, ''', ') END
        , CASE WHEN `order_num` IS NULL OR `order_num` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `order_num`, ''', ') END
        , CASE WHEN `display_align` IS NULL OR `display_align` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `display_align`, ''', ') END
        , CASE WHEN `head_code` IS NULL OR `head_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `head_code`, ''', ') END
        , CASE WHEN `select_yn` IS NULL OR `select_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `select_yn`, ''', ') END
        , '''SYSTEM'', '
        , 'NOW(), '
        , '''SYSTEM'', '
        , 'NOW()'
        , ' ) ON DUPLICATE KEY UPDATE '
        , '`comp_seq` = ', CASE WHEN `comp_seq` IS NULL OR `comp_seq` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `comp_seq`, ''', ') END
        , '`form_seq` = ', CASE WHEN `form_seq` IS NULL OR `form_seq` = '' THEN CONCAT('''0''', ', ') ELSE CONCAT('''', `form_seq`, ''', ') END
        , '`item_gbn` = ', CASE WHEN `item_gbn` IS NULL OR `item_gbn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `item_gbn`, ''', ') END
        , '`langpack_code` = ', CASE WHEN `langpack_code` IS NULL OR `langpack_code` = '' THEN CONCAT('''''', ', ') ELSE CONCAT('''', `langpack_code`, ''', ') END
        , '`langpack_name` = ', CASE WHEN `langpack_name` IS NULL OR `langpack_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `langpack_name`, ''', ') END
        , '`order_num` = ', CASE WHEN `order_num` IS NULL OR `order_num` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `order_num`, ''', ') END
        , '`display_align` = ', CASE WHEN `display_align` IS NULL OR `display_align` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `display_align`, ''', ') END
        , '`head_code` = ', CASE WHEN `head_code` IS NULL OR `head_code` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `head_code`, ''', ') END
        , '`select_yn` = ', CASE WHEN `select_yn` IS NULL OR `select_yn` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `select_yn`, ''', ') END
        , '`create_seq` = ''SYSTEM'', '
        , '`create_date` = NOW(), '
        , '`modify_seq` = ''SYSTEM'', '
        , '`modify_date` = NOW();'
        , ' /* ['
        , `item_gbn`
        , ' - '
        , `langpack_code`
        , ' - '
        , `langpack_name`
        , ' - '
        , CASE WHEN `langpack_name` IS NULL OR `langpack_name` = '' THEN CONCAT('NULL', ', ') ELSE CONCAT('''', `langpack_name`, '') END
        , '] */'
        ) AS '`neos`.`t_ex_item` insert query'
FROM    `neos`.`t_ex_item`
WHERE   `comp_seq` = '0'
AND     `form_seq` = '0';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 06. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */