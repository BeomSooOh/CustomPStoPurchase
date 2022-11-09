/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2016. 11. 22. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - G20 쿼리 추가 */

/* `neos`.`t_seq` - 비영리 결의서 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE `name` = 'abdocuNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuNo', '0', '비영리 결의서 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_NO), '0') FROM G20_ABDOCU_H LIMIT 1 ), '0' ) WHERE NAME = 'abdocuNo';

/* `neos`.`t_seq` - 물품명세서 G20_abdocu_d 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuDNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuDNo', '0', '물품명세서 G20_abdocu_d 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_D_NO), '0') FROM G20_ABDOCU_D LIMIT 1 ), '0' ) WHERE NAME = 'abdocuDNo';

/* `neos`.`t_seq` - 비영리 결의서 예산 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuBNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuBNo', '0', '비영리 결의서 예산 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_B_NO), '0') FROM G20_ABDOCU_B LIMIT 1 ), '0' ) WHERE NAME = 'abdocuBNo';

/* `neos`.`t_seq` - 비영리 결의서 채주 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuTNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuTNo', '0', '비영리 결의서 예산 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_T_NO), '0') FROM G20_ABDOCU_T LIMIT 1 ), '0' ) WHERE NAME = 'abdocuTNo';

/* `neos`.`t_seq` - 여비명세서 G20_abdocu_th 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuTHNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuTHNo', '0', '여비명세서 G20_abdocu_th 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_TH_NO), '0') FROM G20_ABDOCU_TH LIMIT 1 ), '0' ) WHERE NAME = 'abdocuTHNo';

/* `neos`.`t_seq` - 여비명세서 G20_abdocu_td 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuTDNo';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuTDNo', '0', '여비명세서 G20_abdocu_td 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_TD_NO), '0') FROM G20_ABDOCU_TD LIMIT 1 ), '0' ) WHERE NAME = 'abdocuTDNo';

/* `neos`.`t_seq` - 여비명세서 G20_abdocu_td 시퀀스 */
DELETE FROM `neos`.`t_seq` WHERE NAME = 'abdocuTD2No';
INSERT IGNORE INTO `neos`.`t_seq` ( `name`, `currval`, `description` ) VALUES ( 'abdocuTD2No', '0', '여비명세서 G20_abdocu_td2 시퀀스' );
UPDATE `neos`.`t_seq` SET `currval` = IFNULL ( ( SELECT IFNULL(MAX(ABDOCU_TD2_NO), '0') FROM G20_ABDOCU_TD2 LIMIT 1 ), '0' ) WHERE NAME = 'abdocuTD2No';

/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 07. 18. ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 08. 10. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */