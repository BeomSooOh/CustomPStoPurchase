
/* 2017. 08. 29. */
/* 2017. 08. 29. - 신재호 */
/* 2017. 08. 29. - 신재호 - 차량공개범위관리 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_biz_car` (
	`erp_comp_seq` VARCHAR(4) NOT NULL COMMENT 'iCUBE 회사 시퀀스',
	`car_code` VARCHAR(10) NOT NULL COMMENT '차량 코드',
	`car_number` VARCHAR(20) NOT NULL COMMENT '차량 번호',
	`car_name` VARCHAR(50) DEFAULT NULL COMMENT '차량 명칭',
	`erp_dept_seq` VARCHAR(4) DEFAULT NULL COMMENT 'iCUBE 부서 시퀀스',
	`erp_dept_name` VARCHAR(30) DEFAULT NULL COMMENT 'iCUBE 부서 명칭',
	`erp_emp_seq` VARCHAR(10) DEFAULT NULL COMMENT 'iCUBE 사원 시퀀스',
	`erp_emp_name` VARCHAR(30) DEFAULT NULL COMMENT 'iCUBE 사원 명칭',
	`use_yn` VARCHAR(1) DEFAULT NULL COMMENT '사용여부',
	`duty` VARCHAR(10) DEFAULT NULL COMMENT '직책',
	`erp_biz_seq` VARCHAR(4) DEFAULT NULL COMMENT 'iCUBE 사업장 시퀀스',
	`get_date` VARCHAR(8) DEFAULT NULL COMMENT '취득일자',
	`expend_type` VARCHAR(1) DEFAULT NULL COMMENT '경비구분',
	`insur_yn` VARCHAR(1) DEFAULT NULL COMMENT '보험여부',
	`insur_tr_code` VARCHAR(10) DEFAULT NULL COMMENT '보험회사',
	`insur_from_date` VARCHAR(8) DEFAULT NULL COMMENT '보험 시작일',
	`insur_to_date` VARCHAR(8) DEFAULT NULL COMMENT '보험 종료일',
	`lease_yn` VARCHAR(1) DEFAULT NULL COMMENT '임차구분',
	`lease_from_date` VARCHAR(8) DEFAULT NULL COMMENT '임차 시작일',
	`lease_to_date` VARCHAR(8) DEFAULT NULL COMMENT '임차 종료일',
	`biz_flag` VARCHAR(1) DEFAULT NULL COMMENT '사용구분',
	`comp_seq` VARCHAR(32) NOT NULL DEFAULT '' COMMENT 'BIzbox Alpha 회사 시퀀스',
	`biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'BIzbox Alpha 사업장 시퀀스',
	`dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'BIzbox Alpha 부서 시퀀스',
	`emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'BIzbox Alpha 사원 시퀀스',
	`create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
	`create_date` DATETIME DEFAULT NULL COMMENT '생얼일자',
	`modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
	`modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
	PRIMARY KEY (`car_code`,`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* 2017. 08. 29. */
/* 2017. 08. 29. - 신재호 */
/* 2017. 08. 29. - 신재호 - 차량공개범위관리 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_biz_car_d` (
	`erp_comp_seq` VARCHAR(4) NOT NULL COMMENT 'iCUBE 회사 시퀀스',
	`card_code` VARCHAR(10) NOT NULL COMMENT '차량 코드',
	`erp_dept_seq` VARCHAR(4) DEFAULT NULL COMMENT 'iCUBE 부서 시퀀스',
	`erp_emp_seq` VARCHAR(10) DEFAULT NULL COMMENT 'iCUBE 사원 시퀀스',
	`use_from_date` VARCHAR(8) DEFAULT NULL COMMENT '사용기간 시작일<정해진 기간 안에만 공개범위 설정 됨>',
	`use_to_date` VARCHAR(8) DEFAULT NULL COMMENT '사용기간 종료일<정해진 기간 안에만 공개범위 설정 됨>',
	`comp_seq` VARCHAR(32) NOT NULL DEFAULT '' COMMENT 'BIzbox Alpha 회사 시퀀스',
	`dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'BIzbox Alpha 부서 시퀀스',
	`emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'BIzbox Alpha 사원 시퀀스',
	`erp_use_type` VARCHAR(10) DEFAULT NULL COMMENT '사용자 사용 구분 (USER : 차량 사용자 / MANAGER : 차량 관리자)',
	`use_type` VARCHAR(10) DEFAULT NULL COMMENT '사용자 사용 구분 (USER : 차량 사용자 / MANAGER : 차량 관리자)',
	`org_div` VARCHAR(1) NOT NULL DEFAULT '' COMMENT '공개범위 구분',
	`org_id` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '공개범위 시퀀스',
	`create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
	`create_date` DATETIME DEFAULT NULL COMMENT '생얼일자',
	`modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
	`modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
	PRIMARY KEY (`card_code`,`comp_seq`,`org_div`,`org_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


/* 2017. 08. 29. */
/* 2017. 08. 29. - 신재호 */
/* 2017. 08. 29. - 신재호 - 운행기록부 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_biz_car_person`( 
	`erp_comp_seq` VARCHAR(4) COMMENT 'ERP회사코드', 
	`comp_seq` VARCHAR(32) NOT NULL COMMENT '그룹웨어 회사코드', 
	`car_code` VARCHAR(10) NOT NULL COMMENT '차량코드',
	`car_number` VARCHAR(10) NOT NULL COMMENT '차량번호',
	`car_name` VARCHAR(10) NOT NULL COMMENT '차량명칭',
	`use_date` VARCHAR(8) NOT NULL COMMENT '사용일자', 
	`seq_number` INT NOT NULL COMMENT '일자별순번', 
	`erp_emp_seq` VARCHAR(10) COMMENT 'ERP사원코드', 
	`erp_biz_seq` VARCHAR(4) COMMENT 'ERP사업장코드', 
	`start_time` VARCHAR(4) COMMENT '출발시간', 
	`end_time` VARCHAR(4) COMMENT '도착시간', 
	`erp_dept_seq` VARCHAR(4) COMMENT '부서코드', 
	`use_flag` VARCHAR(1) COMMENT '사용구분(1.출근 2.퇴근 3.출/퇴근 4.업무용 5.비업무용)', 
	`start_flag` VARCHAR(1) COMMENT '출발지 구분코드 0.직접입력 1.회사 2.자택 3.거래처 4.직전거래처 5.즐겨찾기', 
	`start_addr` VARCHAR(300) COMMENT '출발지', 
	`start_addr_detail` VARCHAR(300) COMMENT '출발지상세주소', 
	`end_flag` VARCHAR(1) COMMENT '도착지 구분코드0.직접입력 1.회사 2.자택 3.거래처 4.직전거래처 5.즐겨찾기', 
	`end_addr` VARCHAR(300) COMMENT '도착지', 
	`end_addr_detail` VARCHAR(300) COMMENT '도착지 상세주소', 
	`mileage_km` INT COMMENT '주행거리', 
	`before_km` INT COMMENT '주행전거리', 
	`after_km` INT COMMENT '주행후거리', 
	`rmk_nb` INT COMMENT '적요코드', 
	`rmk_dc` VARCHAR(80) COMMENT '적요명', 
	`oil_amt_type` VARCHAR(1) COMMENT '유류비_구분 0.없음 1.현금 2.현금영수증 3.카드(법인) 4.카드(개인)', 
	`oil_amt` INT COMMENT '유류비', 
	`toll_amt_type` VARCHAR(1) COMMENT '통행료_구분 0.없음 1.현금 2.현금영수증 3.카드(법인) 4.카드(개인)', 
	`toll_amt` INT COMMENT '통행료', 
	`parking_amt_type` VARBINARY(1) COMMENT '주차비_구분 0.없음 1.현금 2.현금영수증 3.카드(법인) 4.카드(개인)', 
	`parking_amt` INT COMMENT '주차비', 
	`repair_amt_type` VARBINARY(1) COMMENT '수리비_구분 0.없음 1.현금 2.현금영수증 3.카드(법인) 4.카드(개인)', 
	`repair_amt` INT COMMENT '수리비', `etc_amt_type` VARCHAR(1) COMMENT '기타_구분', 
	`etc_amt` INT COMMENT '기타 금액', 
	`etc_rmk` VARCHAR(80) COMMENT '메뉴하단 기타적요', 
	`erp_send_yn` VARCHAR(1) COMMENT '운행기록부 메뉴로 전송여부', 
	`erp_send_seq` INT COMMENT 'ABIZCAR_LIST.SEQ_NB와 연결',
	`close_yn` VARCHAR(1) COMMENT '마감여부', 
	`create_seq` VARCHAR(32) COMMENT '생성자', 
	`create_ip` VARCHAR(15) COMMENT '생성자IP', 
	`create_date` DATETIME COMMENT '생성일', 
	`modify_seq` VARCHAR(32) COMMENT '수정자', 
	`modify_ip` VARCHAR(15) COMMENT '수정자IP', 
	`modify_date` DATETIME COMMENT '수정일', 
	`start_naver_value` VARCHAR(300) COMMENT '출발지네이버기준 위도,경도', 
	`end_naver_value` VARCHAR(300) COMMENT '도착지네이버기준 위도,경도', 
	`biz_seq` VARCHAR(32) COMMENT '그룹웨어 사업장시퀀스', 
	`dept_seq` VARCHAR(32) COMMENT '그룹웨어 부서시퀀스', 
	`emp_seq` VARCHAR(32) COMMENT '그룹웨어 사원시퀀스', 
	PRIMARY KEY (`comp_seq`, `car_code`, `use_date`, `seq_number`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci; 

ALTER TABLE `t_ex_biz_car_person` CHANGE IF EXISTS `seq_number` `seq_number` INT(11) NOT NULL AUTO_INCREMENT COMMENT '일자별순번', ADD KEY(`seq_number`); 

/* 2017. 08. 29. */
/* 2017. 08. 29. - 신재호 */
/* 2017. 08. 29. - 신재호 - 즐겨찾기 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_biz_car_bookmark`( 
	`erp_comp_seq` VARCHAR(4) COMMENT 'ERP회사코드', 
	`erp_emp_seq` VARCHAR(10) COMMENT 'ERP사원코드', 
	`comp_seq` VARCHAR(32) NOT NULL COMMENT '그룹웨어회사코드', 
	`emp_seq` VARCHAR(32) NOT NULL COMMENT '그룹웨어사원코드', 
	`bookmark_code` INT NOT NULL COMMENT '즐겨찾기코드', 
	`bookmark_name` VARCHAR(50) COMMENT '즐겨찾기명', 
	`erp_biz_seq` VARCHAR(4) COMMENT 'ERP사업장코드', 
	`use_flag` VARCHAR(1) COMMENT '운행구분', 
	`start_time` VARCHAR(4) COMMENT '출발시간',
	`end_time` VARCHAR(4) COMMENT '도착시간',
	`start_flag` VARCHAR(1) COMMENT '출발구분',
	`start_addr` VARCHAR(300) COMMENT '출발지',
	`start_addr_detail` VARCHAR(300) COMMENT '출발지상세주소',
	`start_naver_value` VARCHAR(300) COMMENT '출발지네이버위도/경도',
	`end_flag` VARCHAR(1) COMMENT '도착지구분',
	`end_addr` VARCHAR(300) COMMENT '도착지',
	`end_addr_detail` VARCHAR(300) COMMENT '도착지상세주소',
	`end_naver_value` VARCHAR(300) COMMENT '도착지네이버위도/경도',
	`mileage_km` INT COMMENT '주행거리',
	`rmk_nb` INT COMMENT '비고코드',
	`rmk_dc` VARCHAR(30) COMMENT '비고',
	`toll_amt_type` VARCHAR(1) COMMENT '통행료결제구분',
	`toll_amt` INT COMMENT '통행료',
	`create_seq` VARCHAR(32) COMMENT '생성자',
	`create_time` DATETIME COMMENT '생성일',
	`create_ip` VARCHAR(15) COMMENT '생성자IP',
	`modify_seq` VARCHAR(32) COMMENT '수정자',
	`modify_date` DATETIME COMMENT '수정일',
	`modify_ip` VARCHAR(15) COMMENT '수정자IP',
	`biz_seq` VARCHAR(32) COMMENT '글부웨어사업장코드',
	`dept_seq` VARCHAR(32) COMMENT '그룹웨어부서코드',
	PRIMARY KEY (`comp_seq`, `emp_seq`, `bookmark_code`)
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci; 

/* 2017. 08. 29. */
/* 2017. 08. 29. - 신재호 */
/* 2017. 08. 29. - 신재호 - 비고 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_biz_car_rmk`( 
	`erp_comp_seq` VARCHAR(4) NOT NULL COMMENT 'ERP회사코드',
	`erp_emp_seq` VARCHAR(10) NOT NULL COMMENT 'ERP사원코드',
	`rmk_nb` INT NOT NULL COMMENT '비고코드',
	`use_fg` VARCHAR(1) NOT NULL COMMENT '운행구분',
	`rmk_dc` VARCHAR(80) NOT NULL COMMENT '비고',
	`erp_biz_seq` VARCHAR(4) COMMENT 'ERP사업장코드',
	`comp_seq` VARCHAR(32) COMMENT '그룹웨어회사코드',
	`biz_seq` VARCHAR(32) COMMENT '그룹웨어사업장코드',
	`dept_seq` VARCHAR(32) COMMENT '그룹웨어부서코드',
	`emp_seq` VARCHAR(32) COMMENT '그룹웨어사원코드',
	`order_num` INT COMMENT '정렬순서',
	`create_seq` VARCHAR(32) COMMENT '생성자',
	`create_date` DATETIME COMMENT '생성일',
	`modify_seq` VARCHAR(32) COMMENT '수정자',
	`modify_date` DATETIME COMMENT '수정일',
	PRIMARY KEY (`erp_comp_seq`, `erp_emp_seq`, `rmk_nb`, `use_fg`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci; 


/* 2017. 08. 29. */
/* 2017. 08. 29. - 신재호 */
/* 2017. 08. 29. - 신재호 - 운행기록현황 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_biz_car_list`(
	`erp_comp_seq` VARCHAR(4) COMMENT 'ERP회사코드',
	`comp_seq` VARCHAR(32) NOT NULL COMMENT '그룹웨어회사코드',
	`car_code` VARCHAR(10) NOT NULL COMMENT '차량코드',
	`use_date` VARCHAR(8) NOT NULL COMMENT '사용일자',
	`seq_number` INT(60) NOT NULL COMMENT '데이터순번',
	`erp_biz_Seq` VARCHAR(4) COMMENT 'ERP사업장코드',
	`use_time` VARCHAR(4) COMMENT '사용시작시간',
	`erp_detp_seq` VARCHAR(4) COMMENT 'ERP부서코드',
	`erp_emp_seq` VARCHAR(10) COMMENT 'ERP사원코드',
	`mileage_km` INT(100) COMMENT '주행거리',
	`commute_km` INT(100) COMMENT '주행거리(출,퇴근용)',
	`business_km` INT(100) COMMENT '주행거리(업무용)',
	`before_km` INT(100) COMMENT '주행전거리',
	`after_km` INT(100) COMMENT '주행후거리',
	`rmk_dc` VARCHAR(80) COMMENT '비고',
	`date_flag` VARCHAR(1) COMMENT '데이터구분(0.직접입력 1.엑셀임포트 2.전표 3.그룹웨어',
	`biz_seq` VARCHAR(32) COMMENT '그룹웨어사업장코드',
	`dept_seq` VARCHAR(32) COMMENT '그룹웨어부서코드',
	`emp_seq` VARCHAR(32) COMMENT '그룹웨어사원코드',
	`create_seq` VARCHAR(32) COMMENT '작성자',
	`create_date` DATETIME COMMENT '작성일',
	`create_ip` VARCHAR(16) COMMENT '작성자IP',
	`modify_seq` VARCHAR(32) COMMENT '수정자',
	`modify_date` DATETIME COMMENT '수정일',
	`modify_ip` VARCHAR(16) COMMENT '수정자IP',
	PRIMARY KEY (`comp_seq`, `car_code`, `use_date`, `seq_number`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci; 
ALTER TABLE `neos`.`t_ex_biz_car_list` CHANGE IF EXISTS `seq_number` `seq_number` INT(60) NOT NULL AUTO_INCREMENT COMMENT '데이터순번', ADD KEY(`seq_number`); 