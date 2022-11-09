\/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 국고보조통합시스템 테이블 추가 */

CREATE TABLE IF NOT EXISTS `t_ex_anbojo` (
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '귀속 회사 시퀀스',
  `anbojo_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '국고보조 시퀀스',
  `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '전자결재 아이디',
  `form_seq` VARCHAR(32) DEFAULT NULL COMMENT '양식 시퀀스',
  `anbojo_stat_code` VARCHAR(32) DEFAULT NULL COMMENT '국고보조 상태 코드',
  `gisu_date` VARCHAR(8) DEFAULT NULL COMMENT '결의일자 ( 회계일자 )',
  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_anbojo_emp )',
  `json_str` LONGTEXT COMMENT '국고보조 JSON 문자열',
  `erp_send_yn` VARCHAR(32) DEFAULT NULL COMMENT '국고보조 ERP 전송 여부',
  `erp_send_seq` VARCHAR(32) DEFAULT NULL COMMENT '국고보조 ERP 전송자',
  `erp_send_date` DATETIME DEFAULT NULL COMMENT '국고보조 ERP 전송일',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`anbojo_seq`)
) ENGINE=INNODB AUTO_INCREMENT=810 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_anbojo_abdocu` (
  `anbojo_seq` INT(11) NOT NULL COMMENT '국고보조 시퀀스',
  `d_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 시퀀스',
  `erp_comp_seq` VARCHAR(4) NOT NULL COMMENT 'ERP 회사 코드',
  `erp_comp_name` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 명칭',
  `mosf_gisu_dt` VARCHAR(8) NOT NULL COMMENT '집행등록 결의일자',
  `mosf_gisu_sq` INT(11) DEFAULT NULL COMMENT '집행등록 결의순번',
  `mosf_pay_fg` VARCHAR(2) NOT NULL COMMENT '지급구분 ( 1 : 일반 / 2 : 인력등록 )',
  `erp_biz_seq` VARCHAR(4) NOT NULL COMMENT 'ERP 사업장 코드',
  `erp_biz_name` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 명칭',
  `erp_dept_seq` VARCHAR(4) NOT NULL COMMENT 'ERP 부서 코드',
  `erp_dept_name` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 명칭',
  `erp_emp_seq` VARCHAR(10) NOT NULL COMMENT 'ERP 사원 번호',
  `erp_emp_name` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 명',
  `cntc_sn` INT(11) DEFAULT NULL COMMENT '연계순번 ( 파일 생성시 update, 파일내 데이터를 구별하는 유일한 식별자_순차적 기재 )',
  `cntc_job_process_code` VARCHAR(2) DEFAULT NULL COMMENT '연계업무처리 코드 ( 등록, 수정, 삭제 요청시 ( C : 등록 / U : 수정 / D : 삭제 ) / 집행등록 요청 시 : C / 집행수정 요청 시 : U / 집행삭제 요청 시 : D )',
  `intrfc_id` VARCHAR(20) DEFAULT NULL COMMENT '인터페이스 ID ( IF-EXE-ERP-0074 )',
  `trnsc_id` VARCHAR(50) DEFAULT NULL COMMENT '트랜잭션 ID ( 파일생성시 update )',
  `file_id` VARCHAR(64) DEFAULT NULL COMMENT '파일 ID ( 파일생성시 update ( 첨부파일이 존재할 경우 ) )',
  `cntc_creat_dt` VARCHAR(14) DEFAULT NULL COMMENT '연계생성일시 ( 파일생성시 update ( yyyymmddhh24miss ) )',
  `cntc_trget_sys_code` VARCHAR(6) NOT NULL COMMENT '연계대상 기관시스템코드 ( 디폴트 : ANBOJO_SYSTEM_CD.SYSTEM_CD )',
  `bsnsyear` VARCHAR(4) NOT NULL COMMENT '사업연도',
  `ddtlbz_id` VARCHAR(20) NOT NULL COMMENT '상세내역 사업 ID',
  `exc_instt_id` VARCHAR(12) NOT NULL COMMENT '수행기관 ID ( 디폴트 : ANBOJO_SYSTEM_CD.BUSINESS_CD )',
  `excut_cntc_id` VARCHAR(20) NOT NULL COMMENT '집행연계 ID ( 집행건별 유일 KEY ( CO_CD + MOSF_GISU_DT + MOSF_GISU_SQ )',
  `excut_ty_se_code` VARCHAR(20) NOT NULL DEFAULT '20' COMMENT '집행 유형 구분 코드 ( 10 : 계약집행 / 20 : 일반집행 ( 연계는 일반집행만 지원 ) )',
  `pruf_se_code` VARCHAR(3) NOT NULL COMMENT '증빙구분 코드 ( 전자세금계산서 : 001 / 전자계산서(면세) : 002 / 카드 : 004 / 기타 : 005 )',
  `card_no` VARCHAR(40) DEFAULT NULL COMMENT '카드번호 ( 증빙구분 카드(004) 인 경우 카드 번호 )',
  `ctr_cd` VARCHAR(10) DEFAULT NULL,
  `pruf_se_no` VARCHAR(55) DEFAULT NULL COMMENT '증빙승인번호 ( 전자세금계산서 승인번호, 카드 매입 추심번호 )',
  `tax_ty` VARCHAR(2) DEFAULT NULL COMMENT '매입매출 구분 ( 증빙구분코드가 전자세금계산서 / 전자계산서인 경우만 적용 ( 매출 : 1 / 매입 : 2 / 면세매출 : 3 / 면세매입 : 4 ) => 결의서 발행 시 과세구분 정의로 활용, 신용카드의 경우 과세구분 : "과세" 로 처리 )',
  `excut_requst_de` VARCHAR(8) NOT NULL COMMENT '증빙사용 일자 ( 전자세금계산서 = 발행일자 / 카드 = 매입일자 / 기타 = 직접입력 )',
  `transfr_acnut_se_code` VARCHAR(3) DEFAULT NULL COMMENT '자계좌입금구분 ( 공통코드 : 1089 ( 거래처계좌입금 : 001 / 자계좌입금 : 002 ) )',
  `sbsacnt_trfrsn_code` VARCHAR(3) DEFAULT NULL COMMENT '자계좌이체사유코드 ( 공통코드 : 0665 ( 교부전집행 : 001 / 운영비 : 002 / 해외송금 : 003 / 카드결제 : 004 / 기타 : 099 ) ) ※자계좌입금구분이''002''이면 해당 항목 필수입력',
  `sbsacnt_trfrsn_cn` VARCHAR(4000) DEFAULT NULL COMMENT '자계좌이체사유 ( 자계좌이체사유코드 기타 ( 099 ) 인 경우 필수 입력',
  `bcnc_se_code` VARCHAR(3) NOT NULL DEFAULT '001' COMMENT '거래처구분 코드 ( 법인거래 : 001 / 개인사업자거래 : 002 / 개인거래 : 003 )',
  `tr_cd` VARCHAR(10) DEFAULT NULL COMMENT '거래처 코드 ( 거래처실명번호와 매칭된 STRADE 의 TR_CD ( 코드도움을 통한 변경 가능 ) )',
  `bcnc_lsft_no` VARCHAR(24) DEFAULT NULL COMMENT '거래처 실명 번호 ( 법인, 개인사업자 - 사업자번호 / 개인 - 생년월일 + 성별 )',
  `bcnc_cmpny_nm` VARCHAR(300) DEFAULT NULL COMMENT '거래처 회사명',
  `bcnc_induty_nm` VARCHAR(300) DEFAULT NULL COMMENT '거래처 업종명',
  `bcnc_bizcnd_nm` VARCHAR(300) DEFAULT NULL COMMENT '거래처 업태명',
  `bcnc_rprsntv_nm` VARCHAR(300) DEFAULT NULL COMMENT '거래처 대표자명',
  `bcnc_adres` VARCHAR(500) DEFAULT NULL COMMENT '거래처 주소',
  `bcnc_telno` VARCHAR(14) DEFAULT NULL COMMENT '거래처 전화번호',
  `bcnc_bank_code` VARCHAR(3) DEFAULT NULL COMMENT '거래처 입금은행 코드',
  `duzon_bank_code` VARCHAR(10) DEFAULT NULL COMMENT '거래처 입금은행 코드 ( 더존 )',
  `bcnc_acnut_no` VARCHAR(20) DEFAULT NULL COMMENT '거래처 입금계좌번호',
  `excut_splpc` DECIMAL(15,0) DEFAULT NULL COMMENT '집행 공급가액',
  `excut_vat` DECIMAL(15,0) DEFAULT NULL COMMENT '집행 부가가치세',
  `excut_sum_amount` DECIMAL(15,0) DEFAULT NULL COMMENT '집행 합계금액',
  `excut_prpos_cn` VARCHAR(400) DEFAULT NULL COMMENT '집행 용도 내용',
  `bcnc_bnkb_indict_cn` VARCHAR(20) DEFAULT NULL COMMENT '거래처 통장 표시 내용',
  `sbsidy_bnkb_indict_cn` VARCHAR(20) DEFAULT NULL COMMENT '보조금 통장 표시 내용',
  `prepar` VARCHAR(100) DEFAULT NULL COMMENT '예비',
  `excut_expitm_taxitm_cnt` VARCHAR(5) DEFAULT NULL COMMENT '집행별 비목세목 건 수',
  `send_yn` VARCHAR(3) DEFAULT NULL COMMENT '전송 상태 값',
  `process_result_code` VARCHAR(4) DEFAULT NULL COMMENT '집행등록 처리 결과 코드',
  `process_result_mssage` VARCHAR(4000) DEFAULT NULL COMMENT '집행등록 처리 결과 메시지',
  `exrlt_code` VARCHAR(3) DEFAULT NULL COMMENT '이체결과 처리 결과 코드',
  `exrlt_mssage` VARCHAR(4000) DEFAULT NULL COMMENT '이체결과 처리 결과 메시지',
  `insert_id` VARCHAR(10) DEFAULT NULL COMMENT '입력자',
  `insert_dt` VARCHAR(8) DEFAULT NULL COMMENT '입력일자',
  `insert_ip` VARCHAR(30) DEFAULT NULL COMMENT '입력 IP',
  `modify_id` VARCHAR(10) DEFAULT NULL COMMENT '수정자',
  `modify_dt` DATETIME DEFAULT NULL COMMENT '수정일자',
  `modify_ip` VARCHAR(30) DEFAULT NULL COMMENT '수정 IP',
  `json_abdocu_h` LONGTEXT COMMENT '집행등록 row json 문자열',
  `json_abdocu_d` LONGTEXT COMMENT '집행등록 상세 row json 문자열',
  PRIMARY KEY (`anbojo_seq`,`d_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_anbojo_abdocu_b` (
  `anbojo_seq` INT(11) NOT NULL COMMENT '국고보조 시퀀스',
  `d_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 시퀀스',
  `b_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 비목정보 시퀀스',
  `erp_comp_seq` VARCHAR(4) NOT NULL COMMENT 'ERP 회사 코드',
  `erp_comp_name` VARCHAR(32) NOT NULL COMMENT 'ERP 회사 명칭',
  `mosf_gisu_dt` VARCHAR(8) NOT NULL COMMENT '집행등록 결의일자 ( 집행등록 요청의 품의일자 ( CNSUL_DE ) )',
  `mosf_gisu_sq` INT(11) DEFAULT NULL COMMENT '집행등록 결의순번 ( 집행등록 요청의 품의번호 ( CNSUL_NO ) )',
  `mosf_bg_sq` INT(11) DEFAULT NULL COMMENT '집행등록 비목순번',
  `cntc_sn` INT(11) DEFAULT NULL COMMENT '연계 순번 ( 파일생성시 update ( 파일내 데이터를 구별하는 유일한 식별자, 순차적 기재 ) )',
  `cntc_job_process_code` VARCHAR(2) DEFAULT NULL COMMENT '연계 업무처리 코드 ( 파일생성시 update ( 등록 : C / 수정 : U / 삭제 : D ) )',
  `intrfc_id` VARCHAR(20) DEFAULT NULL COMMENT '인터페이스 ID ( IF-EXE-ERP-0074 )',
  `trnsc_id` VARCHAR(50) DEFAULT NULL COMMENT '트랜잭션 ID ( 파일생성시 update )',
  `file_id` VARCHAR(64) DEFAULT NULL COMMENT '파일 ID ( 파일생성시 update ( 첨부파일이 존재할 경우 ) )',
  `cntc_creat_dt` VARBINARY(14) DEFAULT NULL COMMENT '연계 생성 일시 ( 파일생성시 udpate )',
  `cntc_trget_sys_code` VARCHAR(6) NOT NULL COMMENT '연계 대상 시스템 코드 ( 디폴트 : ANBOJO_SYSTEM_CD.SYSTEM_CD )',
  `excut_cntc_id` VARCHAR(20) NOT NULL COMMENT '집행연계 ID ( 집행건별 유일 KEY ( CO_CD + MOSF_GISU_DT + MOSF_GISU_SQ ) )',
  `asstn_taxitm_code` VARCHAR(5) DEFAULT NULL COMMENT '보조세목코드 ( 보조비목세목 ( T_CMM_ASSTM_EXPITM_TAXITM ), 공통관리 인터페이스 ( 공통관리코드 ) )',
  `excut_taxitm_cntc_id` VARCHAR(20) DEFAULT NULL COMMENT '집행비목세목연계 ID ( CO_CD+MOSF_GISU_DT+MOSF_GISU_SQ+MOSF_BG_SQ )',
  `taxitm_fnrsc_cnt` VARCHAR(5) DEFAULT NULL COMMENT '세목별재원건수 ( 집행비목세목연계ID에 해당하는 _T 건수 )',
  `prdlst_nm` VARCHAR(100) DEFAULT NULL COMMENT '품목',
  `insert_id` VARCHAR(10) DEFAULT NULL COMMENT '입력자',
  `insert_dt` DATETIME DEFAULT NULL COMMENT '입력일자',
  `insert_ip` VARCHAR(15) DEFAULT NULL COMMENT '입력 IP',
  `modify_id` VARCHAR(10) DEFAULT NULL COMMENT '수정자',
  `modify_dt` DATETIME DEFAULT NULL COMMENT '수정일자',
  `modify_ip` VARCHAR(15) DEFAULT NULL COMMENT '수정 IP',
  `json_abdocu_b` LONGTEXT COMMENT '비목정보 row json 문자열',
  PRIMARY KEY (`anbojo_seq`,`d_seq`,`b_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_anbojo_abdocu_pay` (
  `anbojo_seq` INT(11) NOT NULL COMMENT '국고보조 시퀀스',
  `d_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 시퀀스',
  `b_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 비목정보 시퀀스',
  `t_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 비목정보 재원정보 시퀀스',
  `p_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 비목정보 재원정보 인력정보 시퀀스',
  `erp_comp_seq` VARCHAR(4) NOT NULL COMMENT 'ERP 회사 코드',
  `erp_comp_name` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 명칭',
  `mosf_gisu_dt` VARCHAR(8) NOT NULL COMMENT '집행등록 결의일자 ( 집행등록 요청의 품의일자(CNSUL_DE) )',
  `mosf_gisu_sq` INT(11) DEFAULT NULL COMMENT '집행등록 결의순번 ( 집행등록 요청의 품의번호(CNSUL_NO) )',
  `mosf_bg_sq` INT(11) DEFAULT NULL COMMENT '집행등록 비목순번',
  `mosf_ln_sq` INT(11) DEFAULT NULL COMMENT '집행등록 재원순번',
  `cntc_sn` INT(11) DEFAULT NULL COMMENT '연계순번 ( 파일내 데이터를 구별하는 유일한 식별자_순차적 기재, 집행인력등록 요청 시 UPDATE )',
  `cntc_job_process_code` VARCHAR(2) DEFAULT NULL COMMENT '연계업무처리코드 ( C.등록 U.수정 D.삭제 )',
  `intrfc_id` VARCHAR(20) DEFAULT NULL COMMENT '인터페이스 ID',
  `trnsc_id` VARCHAR(50) DEFAULT NULL COMMENT '트랜잭션 ID',
  `file_id` VARCHAR(64) DEFAULT NULL COMMENT '파일 ID ( 파일생성시 update (첨부파일이 존재할 경우) )',
  `cntc_creat_dt` VARCHAR(14) DEFAULT NULL COMMENT '연계생성일시',
  `cntc_trget_sys_code` VARCHAR(6) DEFAULT NULL COMMENT '연계대상시스템코드',
  `bsnsyear` VARCHAR(4) NOT NULL COMMENT '사업연도 ( ANBOJO_ABDOCU의 해당 값 )',
  `ddtlbz_id` VARCHAR(20) NOT NULL COMMENT '상세내역사업 ID ( ANBOJO_ABDOCU의 해당 값 )',
  `exc_instt_id` VARCHAR(12) NOT NULL COMMENT '수행기관 ID ( ANBOJO_ABDOCU의 해당 값 )',
  `excut_cntc_id` VARCHAR(20) NOT NULL COMMENT '집행연계 ID ( 집행건별 유일KEY (CO_CD+MOSF_GISU_DT+MOSF_GISU_SQ) )',
  `excut_taxitm_cntc_id` VARCHAR(20) NOT NULL COMMENT '집행비목세목연계 ID ( CO_CD+MOSF_GISU_DT+MOSF_GISU_SQ+MOSF_BG_SQ )',
  `hnf_regist_sn` VARCHAR(5) NOT NULL COMMENT '인력등록순번 ( 동일 키값에서 MAX+1 )',
  `hnf_nm` VARCHAR(300) DEFAULT NULL COMMENT '인력명(기타소득/사원명) ( ABDOCU_T.TR_NM으로 활용 )',
  `hnf_lsft_no` VARCHAR(13) DEFAULT NULL COMMENT '인력실명번호',
  `prrt` INT(11) DEFAULT NULL COMMENT '참여율',
  `partcptn_begin_de` VARCHAR(8) DEFAULT NULL COMMENT '참여시작일자',
  `partcptn_end_de` VARCHAR(8) DEFAULT NULL COMMENT '참여종료일자',
  `pymnt_amount` DECIMAL(15,0) DEFAULT NULL COMMENT '지급총금액',
  `process_result_code` VARCHAR(3) DEFAULT NULL COMMENT '처리결과코드 ( 등록결과 수신정보  )',
  `process_result_mssage` VARCHAR(2000) DEFAULT NULL COMMENT '처리결과메시지 ( 등록결과 수신정보 )',
  `pay_fg` VARCHAR(2) DEFAULT NULL COMMENT '지급처구분 ( 1.급여 2.기타소득 3.사업소득 )',
  `etctr_cd` VARCHAR(15) DEFAULT NULL COMMENT '기타소득자 거래처코드 ( 더존 사원/기타소득/사업소득자 코드 (결의서 ABDOCU_T.TR_CD로 활용) )',
  `etcrvrs_ym` VARCHAR(6) DEFAULT NULL COMMENT '급여/기타소득 귀속년월',
  `etcdiv_cd` VARCHAR(4) DEFAULT NULL COMMENT '기타/사업소득자 사업장코드',
  `etcdummy1` VARCHAR(20) DEFAULT NULL COMMENT '기타소득 소득구분 OR 자료 불러오기 구분 ( 1.처리된 급여/사업소득자료불러오기 2.기타소득자료불러오기 기타소득자코드도움시 소득구분 값(디폴트76) )',
  `etcdummy2` VARCHAR(4) DEFAULT NULL COMMENT '기타소득 신고귀속년 ( 기타소득에만 해당 )',
  `ndep_am` DECIMAL(17,4) DEFAULT NULL COMMENT '기타소득 필요경비금액',
  `inad_am` DECIMAL(17,4) DEFAULT NULL COMMENT '기타소득 소득금액',
  `intx_am` DECIMAL(17,4) DEFAULT NULL COMMENT '급여/기타/사업 소득세액',
  `rstx_am` DECIMAL(17,4) DEFAULT NULL COMMENT '급여/기타/사업 주민세액',
  `wd_am` DECIMAL(17,4) DEFAULT NULL COMMENT '급여 소득공제액 ( 급여자료에만 해당 )',
  `etcpay_dt` VARCHAR(8) DEFAULT NULL COMMENT '기타/사업소득 지급일자 ( F3.처리된 기타/사업소득자료 불러오기시에만 반영 )',
  `et_yn` VARCHAR(2) DEFAULT NULL COMMENT '소득 처리방법 ( 0.처리된 기타소득 불러오기 1.기타소득자 코드도움 5.처리된 급여데이터 불러오기 9.처리된 사업소득 불러오기 ''''.사원코드도움, 사업소득자코드도움 )',
  `etcdata_cd` VARCHAR(4) DEFAULT NULL COMMENT '기타소득자구분코드 ( G.거주자 기타소득자 F.거주자 사업소득자 BI.비거주자 사업/기타 ''''.사원코드도움,처리된 급여데이터 불러오기 )',
  `etctax_rt` DECIMAL(10,4) DEFAULT NULL COMMENT '미사용 컬럼',
  `hife_am` DECIMAL(17,4) DEFAULT NULL COMMENT '국민연금',
  `nape_am` DECIMAL(17,4) DEFAULT NULL COMMENT '건강보험',
  `ddct_am` DECIMAL(17,4) DEFAULT NULL COMMENT '고용보험',
  `noin_am` DECIMAL(17,4) DEFAULT NULL COMMENT '장기요양',
  `wd_am2` DECIMAL(17,4) DEFAULT NULL COMMENT '급여 기타세액',
  `etcrate` DECIMAL(5,2) DEFAULT NULL COMMENT '필요경비율 ( 기타소득자 그외 필요경비있는경우(62번)에 한하여 필요경비율 저장 )',
  `gw_state` VARCHAR(2) DEFAULT NULL COMMENT '그룹웨어 상태값',
  `gw_id` VARCHAR(20) DEFAULT NULL COMMENT '전자결재 작업자',
  `sing_fg` VARCHAR(3) DEFAULT NULL COMMENT '인력등록결과코드',
  `sing_nm` VARCHAR(2000) DEFAULT NULL COMMENT '인력등록결과메시지',
  `insert_id` VARCHAR(10) DEFAULT NULL COMMENT '입력자',
  `insert_dt` DATETIME DEFAULT NULL COMMENT '입력일자',
  `insert_ip` VARCHAR(15) DEFAULT NULL COMMENT '입력 IP',
  `modify_id` VARCHAR(10) DEFAULT NULL COMMENT '수정자',
  `modify_dt` DATETIME DEFAULT NULL COMMENT '수정일자',
  `modify_ip` VARCHAR(15) DEFAULT NULL COMMENT '수정 IP',
  PRIMARY KEY (`anbojo_seq`,`d_seq`,`b_seq`,`t_seq`,`p_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_anbojo_abdocu_t` (
  `anbojo_seq` INT(11) NOT NULL COMMENT '국고보조 시퀀스',
  `d_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 시퀀스',
  `b_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 비목정보 시퀀스',
  `t_seq` INT(11) NOT NULL COMMENT '국고보조 집행등록 비목정보 재원정보 시퀀스',
  `erp_comp_seq` VARCHAR(4) NOT NULL COMMENT 'ERP 회사 코드',
  `erp_comp_name` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 명칭',
  `mosf_gisu_dt` VARCHAR(8) NOT NULL COMMENT '집행등록 결의일자 ( 집행등록 요청의 품의일자(CNSUL_DE) )',
  `mosf_gisu_sq` INT(11) DEFAULT NULL COMMENT '집행등록 결의순번 ( 집행등록 요청의 품의번호(CNSUL_NO) )',
  `mosf_bg_sq` INT(11) DEFAULT NULL COMMENT '집행등록 비목순번',
  `mosf_ln_sq` INT(11) DEFAULT NULL COMMENT '집행등록 재원순번',
  `gisu_dt` VARCHAR(8) DEFAULT NULL,
  `gisu_sq` INT(11) DEFAULT NULL,
  `cntc_sn` INT(11) DEFAULT NULL COMMENT '연계순번 ( 파일생성시 update (파일내 데이터를 구별하는 유일한 식별자_순차적 기재) )',
  `cntc_job_process_code` VARCHAR(2) DEFAULT NULL COMMENT '연계업무처리코드 ( 파일생성시 update (C: 등록, U: 수정, D: 삭제) )',
  `intrfc_id` VARCHAR(40) DEFAULT NULL COMMENT '인터페이스 ID ( IF-EXE-ERP-0074 )',
  `trnsc_id` VARCHAR(100) DEFAULT NULL COMMENT '트랜잭션 ID ( 파일생성시 update )',
  `file_id` VARCHAR(128) DEFAULT NULL COMMENT '파일 ID ( 파일생성시 update (첨부파일이 존재할 경우) )',
  `cntc_creat_dt` VARCHAR(28) DEFAULT NULL COMMENT '연계생성일시 ( 파일생성시 update )',
  `cntc_trget_sys_code` VARCHAR(12) NOT NULL COMMENT '연계대상시스템코드 ( 디폴트 (ANBOJO_SYSTEM_CD.SYSTEM_CD) )',
  `excut_cntc_id` VARCHAR(40) NOT NULL COMMENT '집행연계 ID ( 집행건별 유일KEY (CO_CD+MOSF_GISU_DT+MOSF_GISU_SQ) )',
  `excut_taxitm_cntc_id` VARCHAR(40) DEFAULT NULL COMMENT '집행비목세목연계 ID ( CO_CD+MOSF_GISU_DT+MOSF_GISU_SQ+MOSF_BG_SQ )',
  `fnrsc_se_code` VARCHAR(20) DEFAULT NULL COMMENT '재원구분코드 ( 재원구분코드:1220 공통관리 인터페이스(공통관리코드) )',
  `mgt_cd` VARCHAR(20) DEFAULT NULL COMMENT '프로젝트 ( 결의서발행 시 활용(ABDOCU.MGT_CD) )',
  `bottom_cd` VARCHAR(20) DEFAULT NULL COMMENT '하위사업',
  `abgt_cd` VARCHAR(20) DEFAULT NULL COMMENT '예산과목 ( 결의서발행 시 활용(ABDOCU_B.ABGT_CD) )',
  `btr_cd` VARCHAR(20) DEFAULT NULL COMMENT '입/출금계좌 거래처 코드 ( 결의서발행 시 활용(ABDOCU.BTR_CD) )',
  `splpc` DECIMAL(15,0) DEFAULT NULL COMMENT '공급가액',
  `vat` DECIMAL(15,0) DEFAULT NULL COMMENT '부가가치세',
  `sum_amount` DECIMAL(15,0) DEFAULT NULL COMMENT '합계금액',
  `insert_id` VARCHAR(10) DEFAULT NULL COMMENT '입력자',
  `insert_dt` DATETIME DEFAULT NULL COMMENT '입력일자',
  `insert_ip` VARCHAR(15) DEFAULT NULL COMMENT '입력 IP',
  `modify_id` VARCHAR(10) DEFAULT NULL COMMENT '수정자',
  `modify_dt` DATETIME DEFAULT NULL COMMENT '수정일자',
  `modify_ip` VARCHAR(15) DEFAULT NULL COMMENT '수정 IP',
  `json_abdocu_t` LONGTEXT COMMENT '재원정보 JSON',
  PRIMARY KEY (`anbojo_seq`,`d_seq`,`b_seq`,`t_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_anbojo_emp` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '회사 시퀀스',
  `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '회사 명칭',
  `erp_comp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 코드',
  `erp_comp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회사 명칭',
  `biz_seq` VARCHAR(32) DEFAULT NULL COMMENT '사업장 시퀀스',
  `biz_name` VARCHAR(128) DEFAULT NULL COMMENT '사업장 명칭',
  `erp_biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 코드',
  `erp_biz_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사업장 명칭',
  `dept_seq` VARCHAR(32) DEFAULT NULL COMMENT '부서 시퀀스',
  `dept_name` VARCHAR(128) DEFAULT NULL COMMENT '부서 명칭',
  `erp_dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 코드',
  `erp_dept_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 부서 명ㅊ이',
  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사원 시퀀스',
  `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '사원 명',
  `erp_emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 번호',
  `erp_emp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사원 명',
  `erp_pc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회계단위 코드',
  `erp_pc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회계단위 명칭',
  `erp_cc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 코스트센터 코드',
  `erp_cc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 코스트센터 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8;

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 지출결의 테이블 추가 */

/* t_ex_acct */
CREATE TABLE IF NOT EXISTS `t_ex_acct` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `acct_code` VARCHAR(20) NOT NULL COMMENT '계정과목 코드',
  `acct_name` VARCHAR(60) DEFAULT NULL COMMENT '계정과목 명칭',
  `vat_yn` VARCHAR(20) DEFAULT NULL COMMENT '부가세 계정 여부 ( Y : 부가세 계정 / N : 부가세 계정 아님 )',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`,`acct_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `acct_name` VARCHAR(60) DEFAULT NULL COMMENT '계정과목 명칭';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `vat_yn` VARCHAR(20) DEFAULT NULL COMMENT '부가세 계정 여부 ( Y : 부가세 계정 / N : 부가세 계정 아님 )';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `modify_date`  DATETIME DEFAULT NULL COMMENT '최종 수정 일자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `test`  DATETIME DEFAULT NULL COMMENT '최종 수정 ';

/* t_ex_auth */
CREATE TABLE IF NOT EXISTS `t_ex_auth` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `auth_div` VARCHAR(32) NOT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )',
  `auth_code` VARCHAR(32) NOT NULL COMMENT '증빙유형 코드',
  `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭',
  `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )',
  `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드',
  `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭',
  `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드',
  `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭',
  `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서',
  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT 'iCUBE사유구분 코드',
  `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE사유구분 명',
  PRIMARY KEY (`comp_seq`,`auth_div`,`auth_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT 'iCUBE사유구분 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE사유구분 명';

/* t_ex_card */
CREATE TABLE IF NOT EXISTS `t_ex_card` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `card_code` VARCHAR(32) NOT NULL COMMENT '카드코드',
  `card_num` VARCHAR(20) NOT NULL COMMENT '카드번호',
  `card_name` VARCHAR(120) DEFAULT NULL COMMENT '카드명칭',
  `partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드 ( ERPiU 전용 사용 )',
  `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '금융거래처 명청 ( ERPiU 전용 사용 )',
  `card_public_json` LONGTEXT COMMENT '공개범위 설정 JSON 문자열',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`,`card_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_num` VARCHAR(20) NOT NULL COMMENT '카드번호';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_name` VARCHAR(120) DEFAULT NULL COMMENT '카드명칭';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드 ( ERPiU 전용 사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '금융거래처 명청 ( ERPiU 전용 사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_public_json` LONGTEXT COMMENT '공개범위 설정 JSON 문자열';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_expend_auth */
CREATE TABLE IF NOT EXISTS `t_ex_expend_auth` (
 `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 증빙유형 시퀀스',
  `auth_div` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )',
  `auth_code` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 코드',
  `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭',
  `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )',
  `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드',
  `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭',
  `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드',
  `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭',
  `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_code` VARBINARY(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '불공제구분 코드 ( ERP 정보 ERPiU )',
  `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '불공제구분 명칭 ( ERP 정보 ERPiU )',
  `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 iCUBE )',
  `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 iCUBE )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=833 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_div` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_code` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `erp_auth_code` VARBINARY(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `erp_auth_code` VARBINARY(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '불공제구분 코드 ( ERP 정보 ERPiU )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_expend_budget */
CREATE TABLE IF NOT EXISTS `t_ex_expend_budget` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 예산정보 시퀀스',
  `budget_type` VARCHAR(32) DEFAULT NULL COMMENT '예산연동 구분 ( iCUBE 사용 : P / D )',
  `bud_ym` VARBINARY(32) DEFAULT NULL COMMENT '예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... )',
  `budget_ym` VARCHAR(8) DEFAULT NULL COMMENT '귀속 예산년월',
  `budget_gbn` VARCHAR(32) DEFAULT NULL COMMENT '예산통제구분 ( P / D >> iCUBE )',
  `budget_code` VARCHAR(32) DEFAULT NULL COMMENT '예산단위 코드',
  `budget_name` VARCHAR(128) DEFAULT NULL COMMENT '예산단위 명칭',
  `bizplan_code` VARCHAR(32) DEFAULT NULL COMMENT '사업계획 코드',
  `bizplan_name` VARCHAR(128) DEFAULT NULL COMMENT '사업계획 명칭',
  `bgacct_code` VARCHAR(32) DEFAULT NULL COMMENT '예산계정 코드',
  `bgacct_name` VARCHAR(128) DEFAULT NULL COMMENT '예산계정 명칭',
  `budget_jsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산집행 금액 ( 편성 + 조정 금액 )',
  `budget_actsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산 실행합 금액 ( 사용예산 금액 )',
  `budget_control_yn` VARCHAR(32) DEFAULT NULL COMMENT '예산 통제여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=464 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_type` VARCHAR(32) DEFAULT NULL COMMENT '예산연동 구분 ( iCUBE 사용 : P / D )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bud_ym` VARBINARY(32) DEFAULT NULL COMMENT '예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_ym` VARCHAR(8) DEFAULT NULL COMMENT '귀속 예산년월';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_gbn` VARCHAR(32) DEFAULT NULL COMMENT '예산통제구분 ( P / D >> iCUBE )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_code` VARCHAR(32) DEFAULT NULL COMMENT '예산단위 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_name` VARCHAR(128) DEFAULT NULL COMMENT '예산단위 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bizplan_code` VARCHAR(32) DEFAULT NULL COMMENT '사업계획 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bizplan_name` VARCHAR(128) DEFAULT NULL COMMENT '사업계획 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bgacct_code` VARCHAR(32) DEFAULT NULL COMMENT '예산계정 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `bgacct_name` VARCHAR(128) DEFAULT NULL COMMENT '예산계정 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_jsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산집행 금액 ( 편성 + 조정 금액 )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_actsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산 실행합 금액 ( 사용예산 금액 )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `budget_control_yn` VARCHAR(32) DEFAULT NULL COMMENT '예산 통제여부';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_card */
CREATE TABLE IF NOT EXISTS `t_ex_expend_card` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 카드 시퀀스',
  `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드코드 ( iCUBE 는 카드코드 존재, ERPiU 는 카드코드 미존재하므로 카드번호로 대체 )',
  `card_num` VARCHAR(32) DEFAULT NULL COMMENT '카드 번호',
  `card_name` VARCHAR(128) DEFAULT NULL COMMENT '카드 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`),
  KEY `seq` (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=715 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드코드 ( iCUBE 는 카드코드 존재, ERPiU 는 카드코드 미존재하므로 카드번호로 대체 )';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_num` VARCHAR(32) DEFAULT NULL COMMENT '카드 번호';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_name` VARCHAR(128) DEFAULT NULL COMMENT '카드 명칭';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_emp */
CREATE TABLE IF NOT EXISTS  `t_ex_expend_emp` (
  `seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '지출결의 사용자 정보 시퀀스',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사시퀀스',
  `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 회사 명칭',
  `erp_comp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 시퀀스',
  `erp_comp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회사 명칭',
  `biz_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사업장 시퀀스',
  `biz_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사업장 명칭',
  `erp_biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 시퀀스',
  `erp_biz_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사업장 명칭',
  `dept_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 부서 시퀀스',
  `dept_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 부서 명칭',
  `erp_dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 시퀀스',
  `erp_dept_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 부서 명칭',
  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사원 시퀀스',
  `erp_emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 시퀀스',
  `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사원 명',
  `erp_emp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사원 명',
  `erp_pc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회계단위 시퀀스',
  `erp_pc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회계단위 명칭',
  `erp_cc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 코스트센터 시퀀스',
  `erp_cc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 코스트센터 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=2746 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 회사 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_comp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_comp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회사 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `biz_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사업장 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `biz_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사업장 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_biz_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사업장 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `dept_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 부서 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `dept_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 부서 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_dept_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 부서 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사원 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사원 명';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_emp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사원 명';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_pc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회계단위 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_pc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회계단위 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_cc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 코스트센터 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `erp_cc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 코스트센터 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_patner */
CREATE TABLE IF NOT EXISTS  `t_ex_expend_partner` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 거래처 시퀀스',
  `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처 코드',
  `partner_name` VARCHAR(128) DEFAULT NULL COMMENT '거래처 명칭',
  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '사업자 등록 번호',
  `partner_fg` VARCHAR(32) DEFAULT NULL COMMENT '거래처 종류',
  `ceo_name` VARCHAR(128) DEFAULT NULL COMMENT '대표자명',
  `job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '업태',
  `cls_job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '종목',
  `deposit_no` VARCHAR(64) DEFAULT NULL COMMENT '계좌번호',
  `bank_code` VARCHAR(32) DEFAULT NULL COMMENT '은행코드',
  `partner_emp_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자',
  `partner_hp_emp_no` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자연락처',
  `deposit_name` VARCHAR(64) DEFAULT NULL COMMENT '예금주',
  `deposit_convert` VARCHAR(128) DEFAULT NULL COMMENT '관리항목',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=716 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처 코드';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_name` VARCHAR(128) DEFAULT NULL COMMENT '거래처 명칭';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '사업자 등록 번호';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_fg` VARCHAR(32) DEFAULT NULL COMMENT '거래처 종류';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `ceo_name` VARCHAR(128) DEFAULT NULL COMMENT '대표자명';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '업태';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `cls_job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '종목';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `deposit_no` VARCHAR(64) DEFAULT NULL COMMENT '계좌번호';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `bank_code` VARCHAR(32) DEFAULT NULL COMMENT '은행코드';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_emp_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `partner_hp_emp_no` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자연락처';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `deposit_name` VARCHAR(64) DEFAULT NULL COMMENT '예금주';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `deposit_convert` VARCHAR(128) DEFAULT NULL COMMENT '관리항목';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_project */
CREATE TABLE IF NOT EXISTS  `t_ex_expend_project` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 프로젝트 시퀀스',
  `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드',
  `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=766 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_summary */
CREATE TABLE IF NOT EXISTS `t_ex_expend_summary` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '분개정보 시퀀스',
  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )',
  `summary_code` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 코드',
  `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭',
  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 계정과목 코드',
  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭',
  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드',
  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 게정과목 명칭',
  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드',
  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명칭',
  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드',
  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융거래처 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=964 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_code` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 게정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융거래처 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_vat */
CREATE TABLE IF NOT EXISTS `t_ex_expend_vat` (
  `ex_gb` VARCHAR(10) NOT NULL COMMENT '전표/분개 구분값',
  `ex_vat_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '부가세정보 고유키',
  `vat_type_code` INT(11) DEFAULT NULL COMMENT '부가세구분 그룹웨어 코드 ( ERP IU / ICUBE )',
  `vat_type_name` VARCHAR(100) DEFAULT NULL COMMENT '부가세구분 그룹웨어 명 ( ERP IU / ICUBE )',
  `va_type_code` INT(11) DEFAULT NULL,
  `va_type_name` VARCHAR(100) DEFAULT NULL,
  `mutual_code` VARCHAR(20) DEFAULT NULL COMMENT '불공제/사유 ERP 코드 ( ERP IU / ICUBE )',
  `mutual_name` VARCHAR(100) DEFAULT NULL COMMENT '불공제/사유 ERP 명 ( ERP IU / ICUBE )',
  `iss_yn` VARCHAR(20) DEFAULT NULL COMMENT '전자세금계산서 여부 ERP 코드 ( ERP IU : 종이세금계산서 ( 0 ), 전자세금계산서 ( 2 ) / ICUBE )',
  `jeonjasend_yn` VARCHAR(20) DEFAULT NULL COMMENT '국세청전송11일이내 여부 ERP 코드 ( ERP IU : 전송 ( 0 ), 미전송 ( 1 ) / ICUBE )',
  `tex_md` VARCHAR(4) DEFAULT NULL COMMENT '품목정보 월/일 ( ERP IU )',
  `item_name` VARCHAR(50) DEFAULT NULL COMMENT '품목정보 품명 ( ERP IU )',
  `size_name` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 규격 ( ERP IU )',
  `tax_qt` DECIMAL(17,4) DEFAULT NULL COMMENT '품목정보 수량 ( ERP IU )',
  `prc_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 단가 ( ERP IU )',
  `supply_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 공급가액 ( ERP IU )',
  `tax_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 부가세액 ( ERP IU )',
  `note_nm` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 비고 ( ERP IU )',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부',
  `create_user_seq` INT(11) DEFAULT NULL COMMENT '작성자 그룹웨어 아이디',
  `create_date` DATETIME DEFAULT NULL COMMENT '작성일자',
  `modify_user_seq` INT(11) DEFAULT NULL COMMENT '수정자 그룹웨어 아이디',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`ex_gb`,`ex_vat_seq`),
  KEY `ex_vat_seq` (`ex_vat_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `vat_type_code` INT(11) DEFAULT NULL COMMENT '부가세구분 그룹웨어 코드 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `vat_type_name` VARCHAR(100) DEFAULT NULL COMMENT '부가세구분 그룹웨어 명 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `va_type_code` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `va_type_name` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `mutual_code` VARCHAR(20) DEFAULT NULL COMMENT '불공제/사유 ERP 코드 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `mutual_name` VARCHAR(100) DEFAULT NULL COMMENT '불공제/사유 ERP 명 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `iss_yn` VARCHAR(20) DEFAULT NULL COMMENT '전자세금계산서 여부 ERP 코드 ( ERP IU : 종이세금계산서 ( 0 ), 전자세금계산서 ( 2 ) / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `jeonjasend_yn` VARCHAR(20) DEFAULT NULL COMMENT '국세청전송11일이내 여부 ERP 코드 ( ERP IU : 전송 ( 0 ), 미전송 ( 1 ) / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tex_md` VARCHAR(4) DEFAULT NULL COMMENT '품목정보 월/일 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `item_name` VARCHAR(50) DEFAULT NULL COMMENT '품목정보 품명 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `size_name` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 규격 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tax_qt` DECIMAL(17,4) DEFAULT NULL COMMENT '품목정보 수량 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `prc_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 단가 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `supply_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 공급가액 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tax_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 부가세액 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `note_nm` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 비고 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `create_user_seq` INT(11) DEFAULT NULL COMMENT '작성자 그룹웨어 아이디';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '작성일자';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `modify_user_seq` INT(11) DEFAULT NULL COMMENT '수정자 그룹웨어 아이디';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자';

/* t_ex_item */
CREATE TABLE IF NOT EXISTS `t_ex_item` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '귀속 회사 시퀀스',
  `form_seq` VARCHAR(32) NOT NULL COMMENT '귀속 전자결재 양식 시퀀스',
  `item_gbn` VARCHAR(100) NOT NULL COMMENT '표현 위치 구분',
  `langpack_code` VARCHAR(100) NOT NULL COMMENT '코드',
  `langpack_name` VARCHAR(100) DEFAULT NULL COMMENT '명칭',
  `order_num` INT(11) DEFAULT NULL COMMENT '정렬 순서',
  `display_align` VARCHAR(10) DEFAULT NULL COMMENT '정렬 표현 방법',
  `head_code` VARCHAR(100) DEFAULT NULL COMMENT '그리드 헤더 키',
  `select_yn` VARCHAR(1) DEFAULT NULL COMMENT '기본키 여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`comp_seq`,`form_seq`,`item_gbn`,`langpack_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `langpack_name` VARCHAR(100) DEFAULT NULL COMMENT '명칭';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `order_num` INT(11) DEFAULT NULL COMMENT '정렬 순서';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `display_align` VARCHAR(10) DEFAULT NULL COMMENT '정렬 표현 방법';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `head_code` VARCHAR(100) DEFAULT NULL COMMENT '그리드 헤더 키';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `select_yn` VARCHAR(1) DEFAULT NULL COMMENT '기본키 여부';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_langpack */
CREATE TABLE IF NOT EXISTS `t_ex_langpack` (
  `comp_seq` INT(11) NOT NULL COMMENT '회사시퀀스',
  `langpack_code` VARCHAR(100) NOT NULL COMMENT '명칭코드',
  `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름',
  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`langpack_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '생성일';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일';

/* t_ex_langpack_multi */
CREATE TABLE IF NOT EXISTS `t_ex_langpack_multi` (
  `comp_seq` INT(11) NOT NULL COMMENT '회사시퀀스',
  `langpack_code` VARCHAR(100) NOT NULL COMMENT '명칭코드',
  `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름',
  `lang_code` VARCHAR(4) NOT NULL COMMENT '언어코드',
  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`langpack_code`,`lang_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `langpack_name` VARCHAR(300) DEFAULT NULL COMMENT '명칭이름';
ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `create_seq` INT(11) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '생성일';
ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_langpack_multi` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일';

/* t_ex_mng_option */
CREATE TABLE IF NOT EXISTS  `t_ex_mng_option` (
  `comp_seq` INT(11) NOT NULL COMMENT '회사시퀀스',
  `form_seq` INT(11) NOT NULL COMMENT '양식코드',
  `drcr_gbn` VARCHAR(20) NOT NULL COMMENT '관리항목구분',
  `mng_code` VARCHAR(20) NOT NULL COMMENT '관리항목코드',
  `mng_name` VARCHAR(100) DEFAULT NULL COMMENT '관리항목명',
  `use_gbn` VARCHAR(20) DEFAULT NULL COMMENT '사용구분',
  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력코드',
  `ctd_name` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력명',
  `note` VARCHAR(512) DEFAULT NULL COMMENT '비고 ( 툴팁활용 )',
  `cust_set` VARCHAR(4000) DEFAULT NULL COMMENT '커스터마이징을 위한 컬럼',
  `cust_set_target` VARCHAR(32) DEFAULT NULL COMMENT '조회 대상 ( BizboxA, iCUBE, ERPiU )',
  `modify_yn` VARCHAR(32) DEFAULT NULL COMMENT '수정가능 여부 ( 전용개발인 경우, 사용자에 의한 삭제 및 수정이 불가해야 함 )',
  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`form_seq`,`drcr_gbn`,`mng_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `mng_name` VARCHAR(100) DEFAULT NULL COMMENT '관리항목명';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `use_gbn` VARCHAR(20) DEFAULT NULL COMMENT '사용구분';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력코드';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `ctd_name` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력명';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `note` VARCHAR(512) DEFAULT NULL COMMENT '비고 ( 툴팁활용 )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `cust_set` VARCHAR(4000) DEFAULT NULL COMMENT '커스터마이징을 위한 컬럼';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `cust_set_target` VARCHAR(32) DEFAULT NULL COMMENT '조회 대상 ( BizboxA, iCUBE, ERPiU )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `modify_yn` VARCHAR(32) DEFAULT NULL COMMENT '수정가능 여부 ( 전용개발인 경우, 사용자에 의한 삭제 및 수정이 불가해야 함 )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '생성일';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일';

/* t_ex_option_multi */
CREATE TABLE IF NOT EXISTS  `t_ex_option_multi` (
  `option_gbn` VARCHAR(32) NOT NULL COMMENT '옵션 구분 코드',
  `option_code` VARCHAR(32) NOT NULL COMMENT '옵션 상세 코드',
  `use_sw` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 연동 시스템',
  `lang_code` VARCHAR(32) NOT NULL COMMENT '연동 언어 코드',
  `option_name` VARCHAR(512) DEFAULT NULL COMMENT '옵션 명칭',
  `option_note` VARCHAR(1024) DEFAULT NULL COMMENT '옵션 설명',
  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`option_gbn`,`option_code`,`use_sw`,`lang_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `option_name` VARCHAR(512) DEFAULT NULL COMMENT '옵션 명칭';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `option_note` VARCHAR(1024) DEFAULT NULL COMMENT '옵션 설명';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_option */
CREATE TABLE IF NOT EXISTS  `t_ex_option` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 회사시퀀스 ( 기본 0 )',
  `form_seq` INT(11) NOT NULL COMMENT '옵션 귀속 양식코드 ( 기본 0 )',
  `option_gbn` VARCHAR(32) NOT NULL COMMENT '옵션 구분 코드',
  `option_code` VARCHAR(32) NOT NULL COMMENT '옵션 상세 코드',
  `use_sw` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 연동 시스템',
  `order_num` DECIMAL(65,0) DEFAULT NULL COMMENT '정렬순서',
  `common_code` VARCHAR(32) DEFAULT NULL COMMENT '공통코드',
  `base_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 기본 설정 코드',
  `base_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 명칭',
  `base_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 사용자 정의',
  `set_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 설정 코드',
  `set_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 명칭',
  `set_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 사용자 정의',
  `option_select_type` VARCHAR(32) DEFAULT NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )',
  `option_process_type` VARCHAR(32) DEFAULT NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )',
  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`,`form_seq`,`option_gbn`,`option_code`,`use_sw`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `order_num` DECIMAL(65,0) DEFAULT NULL COMMENT '정렬순서';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `common_code` VARCHAR(32) DEFAULT NULL COMMENT '공통코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `base_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 기본 설정 코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `base_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 명칭';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `base_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 사용자 정의';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `set_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 설정 코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `set_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 명칭';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `set_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 사용자 정의';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `option_select_type` VARCHAR(32) DEFAULT NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `option_process_type` VARCHAR(32) DEFAULT NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_summary */
CREATE TABLE IF NOT EXISTS  `t_ex_summary` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `summary_code` VARCHAR(20) NOT NULL COMMENT '표준적요 코드',
  `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭',
  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )',
  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 게정과목 코드',
  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭',
  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드',
  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 계정과목 명칭',
  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드',
  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명',
  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융 거래처 코드',
  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융 거래처 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최총 수정 일자',
  PRIMARY KEY (`comp_seq`,`summary_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 게정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 계정과목 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융 거래처 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융 거래처 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최총 수정 일자';

/* t_ex_vat */
CREATE TABLE IF NOT EXISTS  `t_ex_vat` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `vat_code` VARCHAR(20) NOT NULL COMMENT '세무구분 코드',
  `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`comp_seq`,`vat_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_card_aq_tmp */
CREATE TABLE IF NOT EXISTS `t_ex_card_aq_tmp` (
  `sync_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '키값',
  `owner_reg_no` VARCHAR(10) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `card_code` VARCHAR(3) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `card_name` VARCHAR(20) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `card_num` VARCHAR(16) NOT NULL COMMENT '카드번호',
  `user_name` VARCHAR(30) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `auth_num` VARCHAR(20) NOT NULL COMMENT '승인번호',
  `auth_date` CHAR(8) NOT NULL COMMENT '승인일자',
  `auth_time` CHAR(6) NOT NULL COMMENT '승인시간',
  `aqui_date` CHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `georae_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `georae_stat` VARCHAR(4) DEFAULT NULL COMMENT '승인(1) / 취소(!1) 구분',
  `georae_cand` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `request_amount` DECIMAL(19,0) NOT NULL COMMENT '공급대가',
  `amt_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '공급가액 ( 금융사 제공 )',
  `vat_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '부가세액 ( 금융사 제공 )',
  `ser_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '서비스금액 ( 금융사 제공 )',
  `fre_amount` DECIMAL(19,0) DEFAULT NULL,
  `amt_md_amount` DECIMAL(19,0) NOT NULL COMMENT '공급가액 ( 벤더사 재가공 제공 )',
  `vat_md_amount` DECIMAL(19,0) NOT NULL COMMENT '부가세액 ( 벤더사 재가공 제공 )',
  `georae_gukga` VARCHAR(3) DEFAULT NULL COMMENT '거래국가 구분',
  `for_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액',
  `usd_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액 ( 달러 )',
  `merc_name` VARCHAR(50) NOT NULL COMMENT '거래처 명',
  `merc_saup_no` VARCHAR(10) DEFAULT NULL COMMENT '거래처 사업자 등록 번호',
  `merc_addr` VARCHAR(256) DEFAULT NULL COMMENT '거래처 주소',
  `merc_repr` VARCHAR(30) DEFAULT NULL,
  `merc_tel` VARCHAR(20) DEFAULT NULL COMMENT '거래처 연락처',
  `merc_zip` VARCHAR(6) DEFAULT NULL COMMENT '거래처 우편번호',
  `mcc_name` VARCHAR(60) DEFAULT NULL,
  `mcc_code` VARCHAR(10) DEFAULT NULL,
  `mcc_stat` VARCHAR(2) DEFAULT NULL,
  `vat_stat` VARCHAR(1) DEFAULT NULL,
  `can_date` VARCHAR(8) DEFAULT NULL COMMENT '승인 취소 일자',
  `ask_site` VARCHAR(1) DEFAULT NULL,
  `site_date` VARCHAR(8) DEFAULT NULL,
  `ask_date` VARCHAR(8) DEFAULT NULL,
  `ask_time` VARCHAR(6) DEFAULT NULL,
  `gongje_no_chk` VARCHAR(1) DEFAULT NULL,
  `first_date` VARCHAR(8) DEFAULT NULL,
  `cancel_date` VARCHAR(8) DEFAULT NULL,
  `abroad` VARCHAR(1) DEFAULT NULL COMMENT '국내(A) / 해외(B) 사용 구분',
  `van_created_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드',
  `van_edited_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드',
  `created_by` INT(11) DEFAULT NULL,
  `created_dt` DATETIME DEFAULT NULL,
  `edited_dt` INT(11) DEFAULT NULL,
  `edited_by` DATETIME DEFAULT NULL,
  `edited_action` VARCHAR(256) DEFAULT NULL,
  `createdate` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `createtime` VARCHAR(6) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `sett_date` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `org_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `aqui_rate` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `conversion_fee` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `auth_cd` VARCHAR(32) DEFAULT NULL,
  `auth_nm` VARCHAR(128) DEFAULT NULL,
  `summary_cd` VARCHAR(32) DEFAULT NULL,
  `summary_nm` VARCHAR(128) DEFAULT NULL,
  `pjt_cd` VARCHAR(32) DEFAULT NULL,
  `pjt_nm` VARCHAR(128) DEFAULT NULL,
  `detail` VARCHAR(100) DEFAULT NULL,
  `if_m_id` VARCHAR(32) DEFAULT ''
'' COMMENT '외부연동 아이디',
  `if_d_id` VARCHAR(32) DEFAULT '''0''' COMMENT '외부연동 아이디',
  `del_yn` VARCHAR(20) DEFAULT '''N''' COMMENT '삭제 처리 여부 ( Y / !Y )',
  `app_div` VARCHAR(20) DEFAULT NULL,
  `send_yn` VARCHAR(1) DEFAULT NULL COMMENT '결의 상신 구분 ( Y / !Y )',
  `user_send_yn` VARCHAR(20) DEFAULT '''N''' COMMENT '관리자 마감 처리 구분 ( Y / !Y )',
  `emp_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '사용자정보 시퀀스',
  `summary_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '표준적요정보 시퀀스',
  `auth_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '증빙유형정보 시퀀스',
  `project_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '프로젝트정보 시퀀스',
  `budget_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '예산정보 시퀀스',
  `doc_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '전자결재 시퀀스',
  PRIMARY KEY (`sync_id`),
  KEY `card_num` (`card_num`),
  KEY `auth_date` (`auth_date`),
  KEY `auth_num` (`auth_num`),
  KEY `merc_name` (`merc_name`),
  KEY `emp_seq` (`emp_seq`,`summary_seq`,`auth_seq`,`project_seq`,`budget_seq`),
  KEY `del_yn` (`del_yn`,`send_yn`,`user_send_yn`)
) ENGINE=INNODB AUTO_INCREMENT=44221 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `owner_reg_no` VARCHAR(10) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `card_code` VARCHAR(3) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `card_name` VARCHAR(20) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `user_name` VARCHAR(30) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `auth_time` CHAR(6) NOT NULL COMMENT '승인시간';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `aqui_date` CHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `georae_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `georae_stat` VARCHAR(4) DEFAULT NULL COMMENT '승인(1) / 취소(!1) 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `georae_cand` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `request_amount` DECIMAL(19,0) NOT NULL COMMENT '공급대가';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `amt_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '공급가액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `vat_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '부가세액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `ser_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '서비스금액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `fre_amount` DECIMAL(19,0) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `amt_md_amount` DECIMAL(19,0) NOT NULL COMMENT '공급가액 ( 벤더사 재가공 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `vat_md_amount` DECIMAL(19,0) NOT NULL COMMENT '부가세액 ( 벤더사 재가공 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `georae_gukga` VARCHAR(3) DEFAULT NULL COMMENT '거래국가 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `for_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `usd_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액 ( 달러 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_saup_no` VARCHAR(10) DEFAULT NULL COMMENT '거래처 사업자 등록 번호';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_addr` VARCHAR(256) DEFAULT NULL COMMENT '거래처 주소';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_repr` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_tel` VARCHAR(20) DEFAULT NULL COMMENT '거래처 연락처';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `merc_zip` VARCHAR(6) DEFAULT NULL COMMENT '거래처 우편번호';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `mcc_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `mcc_code` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `mcc_stat` VARCHAR(2) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `vat_stat` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `can_date` VARCHAR(8) DEFAULT NULL COMMENT '승인 취소 일자';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `ask_site` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `site_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `ask_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `ask_time` VARCHAR(6) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `gongje_no_chk` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `first_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `cancel_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `abroad` VARCHAR(1) DEFAULT NULL COMMENT '국내(A) / 해외(B) 사용 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `van_created_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `van_edited_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `created_by` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `created_dt` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `edited_dt` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `edited_by` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `edited_action` VARCHAR(256) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `createdate` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `createtime` VARCHAR(6) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `sett_date` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `org_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `aqui_rate` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `conversion_fee` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `auth_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `auth_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `summary_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `summary_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `pjt_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `pjt_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `detail` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `if_m_id` VARCHAR(32) DEFAULT '''0''' COMMENT '외부연동 아이디';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `if_d_id` VARCHAR(32) DEFAULT '''0''' COMMENT '외부연동 아이디';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `app_div` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS  `doc_seq` VARCHAR(32) DEFAULT '''0''' COMMENT '전자결재 시퀀스';

/* t_ex_etax_aq_tmp */
CREATE TABLE IF NOT EXISTS `t_ex_etax_aq_tmp` (
  `sync_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `iss_no` VARCHAR(32) DEFAULT NULL COMMENT '매입전자세금계산서 승인번호',
  `iss_dt` VARCHAR(8) DEFAULT NULL COMMENT '작성일자',
  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '공급자 사업자 등록번호',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사 시퀀스',
  `send_yn` VARCHAR(32) DEFAULT NULL COMMENT '상신여부',
  `note` VARCHAR(256) DEFAULT NULL COMMENT '적요',
  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 시퀀스',
  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 시퀀스',
  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 시퀀스',
  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 시퀀스',
  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 시퀀스',
  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 시퀀스',
  `if_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 키',
  `if_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 키',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`sync_id`),
  KEY `iss_no` (`iss_no`)
) ENGINE=INNODB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `iss_dt` VARCHAR(8) DEFAULT NULL COMMENT '작성일자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '공급자 사업자 등록번호';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `send_yn` VARCHAR(32) DEFAULT NULL COMMENT '상신여부';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `note` VARCHAR(256) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `if_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 키';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `if_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 키';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '생성일자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자';

/* t_ex_expend */
CREATE TABLE IF NOT EXISTS `t_ex_expend` (
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '귀속 회사 시퀀스',
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '전자결재 아이디',
  `form_seq` VARCHAR(32) DEFAULT NULL COMMENT '양식 시퀀스',
  `expend_stat_code` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 상태 코드',
  `expend_date` VARCHAR(8) DEFAULT NULL COMMENT '결의일자 ( 회계일자, 예산년월 )',
  `expend_req_date` VARCHAR(8) DEFAULT NULL COMMENT '지급요청일자 ( 만기일자 )',
  `erp_send_yn` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 전송 상태',
  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )',
  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )',
  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )',
  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )',
  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )',
  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )',
  `json_str` LONGTEXT COMMENT '지출결의 JSON 문자열',
  `erp_send_seq` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 ERP 전송자',
  `erp_send_date` DATETIME DEFAULT NULL COMMENT '지출결의 ERP 전송일',
  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU 자동전표 연동 아이디',
  `in_dt` VARCHAR(8) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 마스터 )',
  `in_sq` INT(11) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 디테일 )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '귀속 회사 시퀀스';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '전자결재 아이디';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `form_seq` VARCHAR(32) DEFAULT NULL COMMENT '양식 시퀀스';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `expend_stat_code` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 상태 코드';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `expend_date` VARCHAR(8) DEFAULT NULL COMMENT '결의일자 ( 회계일자, 예산년월 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `expend_req_date` VARCHAR(8) DEFAULT NULL COMMENT '지급요청일자 ( 만기일자 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `erp_send_yn` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 전송 상태';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 JSON 문자열';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `erp_send_seq` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 ERP 전송자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `erp_send_date` DATETIME DEFAULT NULL COMMENT '지출결의 ERP 전송일';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU 자동전표 연동 아이디';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `in_dt` VARCHAR(8) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 마스터 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `in_sq` INT(11) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 디테일 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';
 
 /* t_ex_expend_list */
CREATE TABLE IF NOT EXISTS `t_ex_expend_list` (
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `list_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 시퀀스',
  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )',
  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )',
  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )',
  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )',
  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )',
  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )',
  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )',
  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )',
  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자',
  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요',
  `std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급가액',
  `tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '부가세액',
  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급대가',
  `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액',
  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액',
  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값',
  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디',
  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디',
  `json_str` LONGTEXT COMMENT '지출결의 항목 JSON 문자열',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`,`list_seq`),
  KEY `summary_seq` (`summary_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급가액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '부가세액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급대가';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 항목 JSON 문자열';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_slip */
CREATE TABLE IF NOT EXISTS `t_ex_expend_slip` (
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `list_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 시퀀스',
  `slip_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 분개 시퀀스',
  `summary_seq` VARCHAR(32) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )',
  `auth_seq` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )',
  `write_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )',
  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )',
  `budget_seq` VARCHAR(32) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )',
  `project_seq` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )',
  `partner_seq` VARCHAR(32) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )',
  `card_seq` VARCHAR(32) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )',
  `drcr_gbn` VARCHAR(32) DEFAULT NULL COMMENT '차변, 대변 구분값',
  `acct_code` VARCHAR(64) DEFAULT NULL COMMENT '계정과목 코드',
  `acct_name` VARCHAR(128) DEFAULT NULL COMMENT '계정과목 명칭',
  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자',
  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요',
  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '금액',
  `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액',
  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액',
  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값',
  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디',
  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디',
  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KYE 1',
  `row_no` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KEY 2',
  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 JSON 문자열',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`,`list_seq`,`slip_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `summary_seq` VARCHAR(32) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `auth_seq` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `write_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `budget_seq` VARCHAR(32) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `project_seq` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `partner_seq` VARCHAR(32) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `card_seq` VARCHAR(32) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `drcr_gbn` VARCHAR(32) DEFAULT NULL COMMENT '차변, 대변 구분값';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `acct_code` VARCHAR(64) DEFAULT NULL COMMENT '계정과목 코드';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `acct_name` VARCHAR(128) DEFAULT NULL COMMENT '계정과목 명칭';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '금액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KYE 1';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `row_no` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KEY 2';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 JSON 문자열';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/*t_ex_expend_mng */
CREATE TABLE IF NOT EXISTS `t_ex_expend_mng` (
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `list_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 시퀀스',
  `slip_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 분개 시퀀스',
  `mng_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 분개 관리항목 시퀀스',
  `mng_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 코드',
  `mng_name` VARCHAR(40) DEFAULT NULL COMMENT '관리항목 명',
  `mng_form_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 표현 형태 ( ERPiU )',
  `mng_child_yn` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 하위 코드 존재 여부 ( ERPiU )',
  `mng_stat` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 필수 여부 ( iCUBE, ERPiU )',
  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '사용자 입력 관리항목 코드',
  `ctd_name` VARCHAR(100) DEFAULT NULL COMMENT '사용자 입력 관리항목 명칭',
  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 관리항목 JSON 문자열',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`,`list_seq`,`slip_seq`,`mng_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 코드';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_name` VARCHAR(40) DEFAULT NULL COMMENT '관리항목 명';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_form_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 표현 형태 ( ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_child_yn` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 하위 코드 존재 여부 ( ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `mng_stat` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 필수 여부 ( iCUBE, ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '사용자 입력 관리항목 코드';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `ctd_name` VARCHAR(100) DEFAULT NULL COMMENT '사용자 입력 관리항목 명칭';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 관리항목 JSON 문자열';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 지출결의 테이블 추가 */

 /* t_ex_cms_sync */
CREATE TABLE IF NOT EXISTS `t_ex_cms_sync` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT 'CMS 연동 귀속 회사 시퀀스',
  `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부',
  `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부',
  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부',
  `cms_base_date` VARCHAR(8) DEFAULT NULL COMMENT '연동시작 기준일',
  `cms_base_day` VARCHAR(2) DEFAULT '7' COMMENT '연동시작 기준일자',
  `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부' AFTER `comp_seq`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부' AFTER `cms_sync_yn`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부' AFTER `cms_batch_yn`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_base_date` VARCHAR(8) DEFAULT NULL COMMENT '연동시작 기준일' AFTER `cms_process_yn`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `cms_base_day` VARCHAR(2) DEFAULT '7' COMMENT '연동시작 기준일자' AFTER `cms_base_date`;
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS  `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자' AFTER `cms_base_day`;

/* t_expend_log */
CREATE TABLE IF NOT EXISTS `t_expend_log` (
  `batch_seq` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'batch 실행 로그 순번',
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '로그 귀속 회사 시퀀스',
  `module_type` VARCHAR(32) NOT NULL COMMENT 'module 구분',
  `log_type` VARCHAR(32) NOT NULL COMMENT 'log 구분',
  `message` VARCHAR(1024) NOT NULL COMMENT 'log 메시지',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`batch_seq`)
) ENGINE=INNODB AUTO_INCREMENT=12511 DEFAULT CHARSET=utf8;

ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `comp_seq` VARCHAR(32) NOT NULL COMMENT '로그 귀속 회사 시퀀스' AFTER `batch_seq`;
ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `module_type` VARCHAR(32) NOT NULL COMMENT 'module 구분' AFTER `comp_seq`;
ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `log_type` VARCHAR(32) NOT NULL COMMENT 'log 구분' AFTER `module_type`;
ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `message` VARCHAR(1024) NOT NULL COMMENT 'log 메시지' AFTER `log_type`;
ALTER TABLE `t_expend_log` ADD IF NOT EXISTS  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자' AFTER `message`;

ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS  `dracct_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '사용금액' AFTER `bgacct_name`;

/* 2016-12-27 데이터 형 수정 */
ALTER TABLE `t_ex_expend_auth` CHANGE `erp_auth_code` `erp_auth_code` VARCHAR(64) NULL  COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';

/* 2016-12-27 지출결의 첨부파일 테이블 */
CREATE TABLE IF NOT EXISTS `t_ex_expend_attach` (
  `type` varchar(10) NOT NULL COMMENT 'list :항목, slip : 분개',
  `expend_seq` varchar(32) NOT NULL DEFAULT '0' COMMENT '문서번호',
  `list_seq` varchar(32) NOT NULL DEFAULT '0' COMMENT '항목번호',
  `slip_seq` varchar(32) NOT NULL DEFAULT '0' COMMENT '분개번호',
  `file_seq` varchar(32) NOT NULL DEFAULT '0' COMMENT '파일번호',
  `create_seq` varchar(32) NOT NULL COMMENT '생성자',
  `create_date` date DEFAULT NULL COMMENT '생성일자',
  `modify_seq` varchar(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` date DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`type`,`expend_seq`,`list_seq`,`slip_seq`,`file_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 2017-01-25 카드사용내역 테이블 기본값 수정 (신재호) */
ALTER TABLE `t_ex_card_aq_tmp` 
CHANGE `if_m_id` `if_m_id` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '외부연동 아이디'
, CHANGE `if_d_id` `if_d_id` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '외부연동 아이디'
, CHANGE `del_yn` `del_yn` VARCHAR(20) CHARSET utf8 COLLATE utf8_general_ci DEFAULT 'N' NULL COMMENT '삭제 처리 여부 ( Y / !Y )'
, CHANGE `user_send_yn` `user_send_yn` VARCHAR(20) CHARSET utf8 COLLATE utf8_general_ci DEFAULT 'N' NULL COMMENT '관리자 마감 처리 구분 ( Y / !Y )'
, CHANGE `emp_seq` `emp_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '사용자정보 시퀀스'
, CHANGE `summary_seq` `summary_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '표준적요정보 시퀀스'
, CHANGE `auth_seq` `auth_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '증빙유형정보 시퀀스'
, CHANGE `project_seq` `project_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '프로젝트정보 시퀀스'
, CHANGE `budget_seq` `budget_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '예산정보 시퀀스'
, CHANGE `doc_seq` `doc_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci DEFAULT '0' NULL COMMENT '전자결재 시퀀스';

/* 2017-02-09 표준적요 설정 시 정렬 순서 추가 */
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `order_num` DECIMAL(10,0) NULL COMMENT '정렬순서' AFTER `modify_date`;

/* 2017-02-16 버튼 설정 테이블 수정 (신재호) - 버튼 명칭 추가 및 null 여부 변경 */
DROP TABLE t_ex_langpack_multi;
DROP TABLE t_ex_langpack;
CREATE TABLE `t_ex_langpack`( 
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사 시퀀스'
  , `lang_type` VARCHAR(5) NOT NULL COMMENT '언어 타입'
  , `lang_code` VARCHAR(50) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '명칭 코드'
  , `basic_name` VARCHAR(50) NOT NULL COMMENT '기본 명칭'
  , `langpack_code` VARCHAR(50) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '다국어 코드'
  , `lang_name` VARCHAR(50) NOT NULL COMMENT '명칭'
  , `create_seq` INT(11) NOT NULL COMMENT '생성자'
  , `create_date` DATETIME NOT NULL COMMENT '생성일'
  , `modify_seq` INT(11) NOT NULL COMMENT '수정자'
  , `modify_date` DATETIME NOT NULL COMMENT '수정일'
  , PRIMARY KEY (`comp_seq`,  `lang_type`, `lang_code`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci;

/* 2017-02-20 CMS 커스텀 사용 여부 컬럼 추가 (구민기) */
ALTER TABLE `t_ex_cms_sync` ADD COLUMN IF NOT EXISTS  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부' AFTER `cms_batch_yn`;
ALTER TABLE `t_ex_cms_sync` ADD COLUMN IF NOT EXISTS `custom_yn` VARCHAR(2) DEFAULT 'N'  NOT NULL  COMMENT '커스텀 사용 여부( Y : 사용 / N : 미사용)' AFTER `cms_process_yn`;

/* 2017. 03. 08. */
/* 2017. 03. 08. - 신재호 */
/* 2017. 03. 08. - 신재호 - 지출결의 수정내역 이력 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_expend_history`(
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 Seq'
  , `history_seq` INT NOT NULL AUTO_INCREMENT COMMENT '변경내역 Seq'
  , `history_info` LONGTEXT COMMENT '변경내역 정보'
  , `doc_seq` VARCHAR(32) COMMENT '문서 Seq'
  , `create_seq` VARCHAR(32) NOT NULL COMMENT '변경자 사번'
  , `create_date` DATETIME NOT NULL COMMENT '변경시간'
  , KEY(`history_seq`)
  , PRIMARY KEY (`expend_seq`, `history_seq`) 
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `history_info` VARCHAR(32) COMMENT '변경내역 정보' AFTER `history_seq`;
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `doc_seq` VARCHAR(32) COMMENT '문서 Seq' AFTER `history_info`;
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `create_seq` VARCHAR(32) NOT NULL COMMENT '변경자 사번' AFTER `doc_seq`;
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `create_date` VARCHAR(32) NOT NULL COMMENT '변경시간' AFTER `create_date`;

/* 2017-03-20 카드 권한 테이블 org_id 생성 (김상겸) */
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS  `org_id` VARCHAR(32) DEFAULT NULL COMMENT '대상아이디' AFTER `org_div`;

/* 2017-03-20 카드 권한 테이블 org_id 변경 (신재호) */
ALTER TABLE `t_ex_card_public` CHANGE `org_id` `org_id` VARCHAR(32) NOT NULL COMMENT '대상아이디';

/* 2017. 04. 11. */
/* 2017. 04. 11. - 김상겸 */
/* 2017. 04. 11. - 김상겸 - 비영리 결재 버전 미배포로 인한 테이블 재배포 */
/* table create */
/* t_ex_acct */
CREATE TABLE IF NOT EXISTS `t_ex_acct` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `acct_code` VARCHAR(20) NOT NULL COMMENT '계정과목 코드',
  `acct_name` VARCHAR(60) DEFAULT NULL COMMENT '계정과목 명칭',
  `vat_yn` VARCHAR(20) DEFAULT NULL COMMENT '부가세 계정 여부 ( Y : 부가세 계정 / N : 부가세 계정 아님 )',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`,`acct_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `acct_name` VARCHAR(60) DEFAULT NULL COMMENT '계정과목 명칭';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `vat_yn` VARCHAR(20) DEFAULT NULL COMMENT '부가세 계정 여부 ( Y : 부가세 계정 / N : 부가세 계정 아님 )';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_acct` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_auth */
CREATE TABLE IF NOT EXISTS `t_ex_auth` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `auth_div` VARCHAR(32) NOT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )',
  `auth_code` VARCHAR(32) NOT NULL COMMENT '증빙유형 코드',
  `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭',
  `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )',
  `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드',
  `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭',
  `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드',
  `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭',
  `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서',
  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT 'iCUBE사유구분 코드',
  `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE사유구분 명',
  PRIMARY KEY (`comp_seq`,`auth_div`,`auth_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT 'iCUBE사유구분 코드';
ALTER TABLE `t_ex_auth` ADD IF NOT EXISTS `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE사유구분 명';

/* t_ex_button */
CREATE TABLE IF NOT EXISTS `t_ex_button` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT 't_co_comp / comp_seq',
  `form_seq` INT(11) NOT NULL COMMENT 'teag_form / form_id',
  `page_seq` INT(11) NOT NULL COMMENT '지출결의 상신 페이지 : 10',
  `btn_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '자동증가 버튼 시퀀스',
  `position` INT(11) DEFAULT NULL COMMENT '버튼 위치 최상단 : 10, 항목 : 20, 분개 : 30, 관리항목 : 40',
  `order_num` INT(11) DEFAULT NULL COMMENT '버튼정렬순서, 값에는 연속성이 없음, ASC',
  `display_yn` CHAR(1) DEFAULT NULL COMMENT '버튼 출력여부 [Y,N]',
  `license_yn` CHAR(1) DEFAULT NULL COMMENT '버튼 라이선스여부 [Y,N]',
  `btn_size` INT(11) DEFAULT NULL COMMENT '버튼사이즈(width) N px;',
  `nm_basic` VARCHAR(32) DEFAULT NULL COMMENT '버튼기본 명칭',
  `nm_kr` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 한글',
  `nm_en` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 영어',
  `nm_jp` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 일본어',
  `nm_cn` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 중국어',
  `default_yn` CHAR(1) DEFAULT NULL COMMENT '기본버튼여부 [Y,N]',
  `default_code` VARCHAR(32) DEFAULT NULL COMMENT '버튼별 통합 코드',
  `call_url` TEXT COMMENT '커스터마이징 호출 주소',
  `call_param` TEXT COMMENT '커스터마이징 호출 파라미터 json',
  `callback_url` VARCHAR(512) DEFAULT NULL COMMENT '커스터마이징 콜백 주소',
  `callback_type` INT(11) DEFAULT NULL COMMENT '커스터마이징 콜백 타입',
  `callback_key` VARCHAR(32) DEFAULT NULL COMMENT '커스터마이징 콜백 키,함수명',
  `default_elemId` VARCHAR(32) DEFAULT NULL COMMENT '버튼 엘리먼트 ID',
  `default_elemClass` VARCHAR(32) DEFAULT NULL COMMENT '버튼 엘리먼트 class',
  PRIMARY KEY (`comp_seq`,`form_seq`,`page_seq`,`btn_seq`),
  KEY `btn_seq` (`btn_seq`)
) ENGINE=INNODB AUTO_INCREMENT=1102 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `position` INT(11) DEFAULT NULL COMMENT '버튼 위치 최상단 : 10, 항목 : 20, 분개 : 30, 관리항목 : 40';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `order_num` INT(11) DEFAULT NULL COMMENT '버튼정렬순서, 값에는 연속성이 없음, ASC';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `display_yn` CHAR(1) DEFAULT NULL COMMENT '버튼 출력여부 [Y,N]';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `license_yn` CHAR(1) DEFAULT NULL COMMENT '버튼 라이선스여부 [Y,N]';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `btn_size` INT(11) DEFAULT NULL COMMENT '버튼사이즈(width) N px;';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_basic` VARCHAR(32) DEFAULT NULL COMMENT '버튼기본 명칭';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_kr` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 한글';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_en` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 영어';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_jp` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 일본어';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `nm_cn` VARCHAR(32) DEFAULT NULL COMMENT '버튼명칭 중국어';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `default_yn` CHAR(1) DEFAULT NULL COMMENT '기본버튼여부 [Y,N]';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `default_code` VARCHAR(32) DEFAULT NULL COMMENT '버튼별 통합 코드';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `call_url` TEXT COMMENT '커스터마이징 호출 주소';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `call_param` TEXT COMMENT '커스터마이징 호출 파라미터 json';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `callback_url` VARCHAR(512) DEFAULT NULL COMMENT '커스터마이징 콜백 주소';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `callback_type` INT(11) DEFAULT NULL COMMENT '커스터마이징 콜백 타입';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `callback_key` VARCHAR(32) DEFAULT NULL COMMENT '커스터마이징 콜백 키,함수명';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `default_elemId` VARCHAR(32) DEFAULT NULL COMMENT '버튼 엘리먼트 ID';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `default_elemClass` VARCHAR(32) DEFAULT NULL COMMENT '버튼 엘리먼트 class';
ALTER TABLE `t_ex_button` ADD IF NOT EXISTS `btn_page` VARCHAR(32) NOT NULL COMMENT '버튼 페이지 위치' AFTER `nm_basic`;

/* t_ex_card */
CREATE TABLE IF NOT EXISTS `t_ex_card` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `card_code` VARCHAR(32) NOT NULL COMMENT '카드코드',
  `card_num` VARCHAR(20) NOT NULL COMMENT '카드번호',
  `card_name` VARCHAR(120) DEFAULT NULL COMMENT '카드명칭',
  `partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드 ( ERPiU 전용 사용 )',
  `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '금융거래처 명청 ( ERPiU 전용 사용 )',
  `card_public_json` LONGTEXT COMMENT '공개범위 설정 JSON 문자열',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`,`card_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_num` VARCHAR(20) NOT NULL COMMENT '카드번호';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_name` VARCHAR(120) DEFAULT NULL COMMENT '카드명칭';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드 ( ERPiU 전용 사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '금융거래처 명청 ( ERPiU 전용 사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `card_public_json` LONGTEXT COMMENT '공개범위 설정 JSON 문자열';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부 ( Y : 사용 / N : 미사용 )';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_card_aq_tmp */
CREATE TABLE IF NOT EXISTS `t_ex_card_aq_tmp` (
  `sync_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '키값',
  `owner_reg_no` VARCHAR(10) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `card_code` VARCHAR(3) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `card_name` VARCHAR(20) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `card_num` VARCHAR(16) NOT NULL COMMENT '카드번호',
  `user_name` VARCHAR(30) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `auth_num` VARCHAR(20) NOT NULL COMMENT '승인번호',
  `auth_date` CHAR(8) NOT NULL COMMENT '승인일자',
  `auth_time` CHAR(6) NOT NULL COMMENT '승인시간',
  `aqui_date` CHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `georae_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `georae_stat` VARCHAR(4) DEFAULT NULL COMMENT '승인(1) / 취소(!1) 구분',
  `georae_cand` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `request_amount` DECIMAL(19,0) NOT NULL COMMENT '공급대가',
  `amt_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '공급가액 ( 금융사 제공 )',
  `vat_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '부가세액 ( 금융사 제공 )',
  `ser_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '서비스금액 ( 금융사 제공 )',
  `fre_amount` DECIMAL(19,0) DEFAULT NULL,
  `amt_md_amount` DECIMAL(19,0) NOT NULL COMMENT '공급가액 ( 벤더사 재가공 제공 )',
  `vat_md_amount` DECIMAL(19,0) NOT NULL COMMENT '부가세액 ( 벤더사 재가공 제공 )',
  `georae_gukga` VARCHAR(3) DEFAULT NULL COMMENT '거래국가 구분',
  `for_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액',
  `usd_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액 ( 달러 )',
  `merc_name` VARCHAR(50) NOT NULL COMMENT '거래처 명',
  `merc_saup_no` VARCHAR(10) DEFAULT NULL COMMENT '거래처 사업자 등록 번호',
  `merc_addr` VARCHAR(256) DEFAULT NULL COMMENT '거래처 주소',
  `merc_repr` VARCHAR(30) DEFAULT NULL,
  `merc_tel` VARCHAR(20) DEFAULT NULL COMMENT '거래처 연락처',
  `merc_zip` VARCHAR(6) DEFAULT NULL COMMENT '거래처 우편번호',
  `mcc_name` VARCHAR(60) DEFAULT NULL,
  `mcc_code` VARCHAR(10) DEFAULT NULL,
  `mcc_stat` VARCHAR(2) DEFAULT NULL,
  `vat_stat` VARCHAR(1) DEFAULT NULL,
  `can_date` VARCHAR(8) DEFAULT NULL COMMENT '승인 취소 일자',
  `ask_site` VARCHAR(1) DEFAULT NULL,
  `site_date` VARCHAR(8) DEFAULT NULL,
  `ask_date` VARCHAR(8) DEFAULT NULL,
  `ask_time` VARCHAR(6) DEFAULT NULL,
  `gongje_no_chk` VARCHAR(1) DEFAULT NULL,
  `first_date` VARCHAR(8) DEFAULT NULL,
  `cancel_date` VARCHAR(8) DEFAULT NULL,
  `abroad` VARCHAR(1) DEFAULT NULL COMMENT '국내(A) / 해외(B) 사용 구분',
  `van_created_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드',
  `van_edited_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드',
  `created_by` INT(11) DEFAULT NULL,
  `created_dt` DATETIME DEFAULT NULL,
  `edited_dt` INT(11) DEFAULT NULL,
  `edited_by` DATETIME DEFAULT NULL,
  `edited_action` VARCHAR(256) DEFAULT NULL,
  `createdate` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `createtime` VARCHAR(6) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `sett_date` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `org_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `aqui_rate` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `conversion_fee` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드',
  `auth_cd` VARCHAR(32) DEFAULT NULL,
  `auth_nm` VARCHAR(128) DEFAULT NULL,
  `summary_cd` VARCHAR(32) DEFAULT NULL,
  `summary_nm` VARCHAR(128) DEFAULT NULL,
  `pjt_cd` VARCHAR(32) DEFAULT NULL,
  `pjt_nm` VARCHAR(128) DEFAULT NULL,
  `detail` VARCHAR(100) DEFAULT NULL,
  `if_m_id` VARCHAR(32) DEFAULT '0' COMMENT '외부연동 아이디',
  `if_d_id` VARCHAR(32) DEFAULT '0' COMMENT '외부연동 아이디',
  `del_yn` VARCHAR(20) DEFAULT 'N' COMMENT '삭제 처리 여부 ( Y / !Y )',
  `app_div` VARCHAR(20) DEFAULT NULL,
  `send_yn` VARCHAR(1) DEFAULT NULL COMMENT '결의 상신 구분 ( Y / !Y )',
  `user_send_yn` VARCHAR(20) DEFAULT 'N' COMMENT '관리자 마감 처리 구분 ( Y / !Y )',
  `emp_seq` VARCHAR(32) DEFAULT '0' COMMENT '사용자정보 시퀀스',
  `summary_seq` VARCHAR(32) DEFAULT '0' COMMENT '표준적요정보 시퀀스',
  `auth_seq` VARCHAR(32) DEFAULT '0' COMMENT '증빙유형정보 시퀀스',
  `project_seq` VARCHAR(32) DEFAULT '0' COMMENT '프로젝트정보 시퀀스',
  `budget_seq` VARCHAR(32) DEFAULT '0' COMMENT '예산정보 시퀀스',
  `doc_seq` VARCHAR(32) DEFAULT '0' COMMENT '전자결재 시퀀스',
  PRIMARY KEY (`sync_id`),
  KEY `card_num` (`card_num`),
  KEY `auth_date` (`auth_date`),
  KEY `auth_num` (`auth_num`),
  KEY `merc_name` (`merc_name`),
  KEY `emp_seq` (`emp_seq`,`summary_seq`,`auth_seq`,`project_seq`,`budget_seq`),
  KEY `del_yn` (`del_yn`,`send_yn`,`user_send_yn`)
) ENGINE=INNODB AUTO_INCREMENT=56819 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `owner_reg_no` VARCHAR(10) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `card_code` VARCHAR(3) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `card_name` VARCHAR(20) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `user_name` VARCHAR(30) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `auth_time` CHAR(6) NOT NULL COMMENT '승인시간';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `aqui_date` CHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `georae_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `georae_stat` VARCHAR(4) DEFAULT NULL COMMENT '승인(1) / 취소(!1) 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `georae_cand` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `request_amount` DECIMAL(19,0) NOT NULL COMMENT '공급대가';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `amt_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '공급가액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `vat_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '부가세액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `ser_amount` DECIMAL(19,0) DEFAULT NULL COMMENT '서비스금액 ( 금융사 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `fre_amount` DECIMAL(19,0) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `amt_md_amount` DECIMAL(19,0) NOT NULL COMMENT '공급가액 ( 벤더사 재가공 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `vat_md_amount` DECIMAL(19,0) NOT NULL COMMENT '부가세액 ( 벤더사 재가공 제공 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `georae_gukga` VARCHAR(3) DEFAULT NULL COMMENT '거래국가 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `for_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `usd_amount` DECIMAL(19,4) DEFAULT NULL COMMENT '외화금액 ( 달러 )';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_saup_no` VARCHAR(10) DEFAULT NULL COMMENT '거래처 사업자 등록 번호';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_addr` VARCHAR(256) DEFAULT NULL COMMENT '거래처 주소';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_repr` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_tel` VARCHAR(20) DEFAULT NULL COMMENT '거래처 연락처';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `merc_zip` VARCHAR(6) DEFAULT NULL COMMENT '거래처 우편번호';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `mcc_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `mcc_code` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `mcc_stat` VARCHAR(2) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `vat_stat` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `can_date` VARCHAR(8) DEFAULT NULL COMMENT '승인 취소 일자';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `ask_site` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `site_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `ask_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `ask_time` VARCHAR(6) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `gongje_no_chk` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `first_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `cancel_date` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `abroad` VARCHAR(1) DEFAULT NULL COMMENT '국내(A) / 해외(B) 사용 구분';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `van_created_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `van_edited_dt` DATETIME DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `created_by` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `created_dt` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `edited_dt` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `edited_by` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `edited_action` VARCHAR(256) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `createdate` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `createtime` VARCHAR(6) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `sett_date` VARCHAR(8) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `org_coll` VARCHAR(40) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `aqui_rate` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `conversion_fee` DECIMAL(19,4) DEFAULT NULL COMMENT '벤더사 사용 코드';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `auth_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `auth_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `summary_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `summary_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `pjt_cd` VARCHAR(32) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `pjt_nm` VARCHAR(128) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `detail` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `if_m_id` VARCHAR(32) DEFAULT '0' COMMENT '외부연동 아이디';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `if_d_id` VARCHAR(32) DEFAULT '0' COMMENT '외부연동 아이디';
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `app_div` VARCHAR(20) DEFAULT NULL;

/* t_ex_card_public */
CREATE TABLE IF NOT EXISTS `t_ex_card_public` (
  `comp_seq` VARCHAR(96) DEFAULT NULL,
  `card_num` VARCHAR(90) DEFAULT NULL,
  `org_div` VARCHAR(30) DEFAULT NULL,
  `org_id` VARCHAR(32) NOT NULL COMMENT '대상아이디',
  `create_seq` VARCHAR(96) DEFAULT NULL,
  `create_dt` DATETIME DEFAULT NULL,
  `modify_seq` VARCHAR(96) DEFAULT NULL,
  `modify_dt` DATETIME DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `comp_seq` VARCHAR(96) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `card_num` VARCHAR(90) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `org_div` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `org_id` VARCHAR(32) NOT NULL COMMENT '대상아이디';
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `create_seq` VARCHAR(96) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `create_dt` DATETIME DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `modify_seq` VARCHAR(96) DEFAULT NULL;
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS `modify_dt` DATETIME DEFAULT NULL;

/* t_ex_cms_sync */
CREATE TABLE IF NOT EXISTS `t_ex_cms_sync` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT 'CMS 연동 귀속 회사 시퀀스',
  `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부',
  `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부',
  `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부',
  `custom_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT '커스텀 사용 여부( Y : 사용 / N : 미사용)',
  `cms_base_date` VARCHAR(8) DEFAULT NULL COMMENT '연동시작 기준일',
  `cms_base_day` VARCHAR(2) DEFAULT '7' COMMENT '연동시작 기준일자',
  `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자',
  `module_type` VARCHAR(32) NOT NULL COMMENT 'module 구분',
  `log_type` VARCHAR(32) NOT NULL COMMENT 'log 구분',
  `message` VARCHAR(1024) NOT NULL COMMENT 'log 메시지',
  `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_sync_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 여부';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_batch_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 배치 처리 여부';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_process_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT 'CMS 연동 진행중 여부';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `custom_yn` VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT '커스텀 사용 여부( Y : 사용 / N : 미사용)';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_base_date` VARCHAR(8) DEFAULT NULL COMMENT '연동시작 기준일';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `cms_base_day` VARCHAR(2) DEFAULT '7' COMMENT '연동시작 기준일자';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `modify_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최종 수정 일자';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `module_type` VARCHAR(32) NOT NULL COMMENT 'module 구분';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `log_type` VARCHAR(32) NOT NULL COMMENT 'log 구분';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `message` VARCHAR(1024) NOT NULL COMMENT 'log 메시지';
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `create_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자';

/* t_ex_etax_aq_tmp */
CREATE TABLE IF NOT EXISTS `t_ex_etax_aq_tmp` (
  `sync_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `iss_no` VARCHAR(32) DEFAULT NULL COMMENT '매입전자세금계산서 승인번호',
  `iss_dt` VARCHAR(8) DEFAULT NULL COMMENT '작성일자',
  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '공급자 사업자 등록번호',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사 시퀀스',
  `send_yn` VARCHAR(32) DEFAULT NULL COMMENT '상신여부',
  `note` VARCHAR(256) DEFAULT NULL COMMENT '적요',
  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 시퀀스',
  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 시퀀스',
  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 시퀀스',
  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 시퀀스',
  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 시퀀스',
  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 시퀀스',
  `if_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 키',
  `if_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 키',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`sync_id`),
  KEY `iss_no` (`iss_no`)
) ENGINE=INNODB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `iss_dt` VARCHAR(8) DEFAULT NULL COMMENT '작성일자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '공급자 사업자 등록번호';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `send_yn` VARCHAR(32) DEFAULT NULL COMMENT '상신여부';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `note` VARCHAR(256) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `card_seq` INT(11) DEFAULT NULL COMMENT '카드 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 시퀀스';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `if_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 키';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `if_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 키';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '생성일자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_etax_aq_tmp` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자';

/* t_ex_expend */
CREATE TABLE IF NOT EXISTS `t_ex_expend` (
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '귀속 회사 시퀀스',
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '전자결재 아이디',
  `form_seq` VARCHAR(32) DEFAULT NULL COMMENT '양식 시퀀스',
  `expend_stat_code` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 상태 코드',
  `expend_date` VARCHAR(8) DEFAULT NULL COMMENT '결의일자 ( 회계일자, 예산년월 )',
  `expend_req_date` VARCHAR(8) DEFAULT NULL COMMENT '지급요청일자 ( 만기일자 )',
  `erp_send_yn` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 전송 상태',
  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )',
  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )',
  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )',
  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )',
  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )',
  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )',
  `json_str` LONGTEXT COMMENT '지출결의 JSON 문자열',
  `erp_send_seq` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 ERP 전송자',
  `erp_send_date` DATETIME DEFAULT NULL COMMENT '지출결의 ERP 전송일',
  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU 자동전표 연동 아이디',
  `in_dt` VARCHAR(8) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 마스터 )',
  `in_sq` INT(11) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 디테일 )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '귀속 회사 시퀀스';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '전자결재 아이디';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `form_seq` VARCHAR(32) DEFAULT NULL COMMENT '양식 시퀀스';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `expend_stat_code` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 상태 코드';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `expend_date` VARCHAR(8) DEFAULT NULL COMMENT '결의일자 ( 회계일자, 예산년월 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `expend_req_date` VARCHAR(8) DEFAULT NULL COMMENT '지급요청일자 ( 만기일자 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `erp_send_yn` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 전송 상태';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 JSON 문자열';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `erp_send_seq` VARCHAR(32) DEFAULT NULL COMMENT '지출결의 ERP 전송자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `erp_send_date` DATETIME DEFAULT NULL COMMENT '지출결의 ERP 전송일';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU 자동전표 연동 아이디';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `in_dt` VARCHAR(8) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 마스터 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `in_sq` INT(11) DEFAULT NULL COMMENT 'iCUBE 자동전표 연동 아이디 ( 디테일 )';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_attach */
CREATE TABLE IF NOT EXISTS `t_ex_expend_attach` (
  `type` VARCHAR(10) NOT NULL COMMENT 'list :항목, slip : 분개',
  `expend_seq` VARCHAR(32) NOT NULL DEFAULT '0' COMMENT '문서번호',
  `list_seq` VARCHAR(32) NOT NULL DEFAULT '0' COMMENT '항목번호',
  `slip_seq` VARCHAR(32) NOT NULL DEFAULT '0' COMMENT '분개번호',
  `file_seq` VARCHAR(32) NOT NULL DEFAULT '0' COMMENT '파일번호',
  `create_seq` VARCHAR(32) NOT NULL COMMENT '생성자',
  `create_date` DATE DEFAULT NULL COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATE DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`type`,`expend_seq`,`list_seq`,`slip_seq`,`file_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_attach` ADD IF NOT EXISTS `create_seq` VARCHAR(32) NOT NULL COMMENT '생성자';
ALTER TABLE `t_ex_expend_attach` ADD IF NOT EXISTS `create_date` DATE DEFAULT NULL COMMENT '생성일자';
ALTER TABLE `t_ex_expend_attach` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_expend_attach` ADD IF NOT EXISTS `modify_date` DATE DEFAULT NULL COMMENT '수정일자';

/* t_ex_expend_auth */
CREATE TABLE IF NOT EXISTS `t_ex_expend_auth` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 증빙유형 시퀀스',
  `auth_div` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )',
  `auth_code` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 코드',
  `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭',
  `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )',
  `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드',
  `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭',
  `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드',
  `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭',
  `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )',
  `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )',
  `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )',
  `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '불공제구분 코드 ( ERP 정보 ERPiU )',
  `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '불공제구분 명칭 ( ERP 정보 ERPiU )',
  `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 iCUBE )',
  `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 iCUBE )',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=4935 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_div` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_code` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_name` VARCHAR(128) DEFAULT NULL COMMENT '증빙유형 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cash_type` VARCHAR(32) DEFAULT NULL COMMENT '현금영수증 구분 ( 미사용 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '대변 대체 계정 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '대변 대체 계정 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 대체 계정 코드';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 대체 계정 명칭';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_type_code` VARCHAR(64) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `vat_type_name` VARCHAR(128) DEFAULT NULL COMMENT '부가세 구분 ( 세무구분 ) 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `auth_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '증빙일자 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `partner_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '거래처 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `card_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '카드 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `project_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `note_required_yn` VARCHAR(32) DEFAULT NULL COMMENT '적요 필수입력 여부 ( Y : 필수 / N : 필수아님 )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `no_tax_code` VARCHAR(64) DEFAULT NULL COMMENT '불공제구분 코드 ( ERP 정보 ERPiU )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `no_tax_name` VARCHAR(128) DEFAULT NULL COMMENT '불공제구분 명칭 ( ERP 정보 ERPiU )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `va_type_code` VARCHAR(32) DEFAULT NULL COMMENT '사유구분 코드 ( ERP 정보 iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `va_type_name` VARCHAR(128) DEFAULT NULL COMMENT '사유구분 명칭 ( ERP 정보 iCUBE )';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_expend_budget */
CREATE TABLE IF NOT EXISTS `t_ex_expend_budget` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 예산정보 시퀀스',
  `budget_type` VARCHAR(32) DEFAULT NULL COMMENT '예산연동 구분 ( iCUBE 사용 : P / D )',
  `bud_ym` VARBINARY(32) DEFAULT NULL COMMENT '예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... )',
  `budget_ym` VARCHAR(8) DEFAULT NULL COMMENT '귀속 예산년월',
  `budget_gbn` VARCHAR(32) DEFAULT NULL COMMENT '예산통제구분 ( P / D >> iCUBE )',
  `budget_code` VARCHAR(32) DEFAULT NULL COMMENT '예산단위 코드',
  `budget_name` VARCHAR(128) DEFAULT NULL COMMENT '예산단위 명칭',
  `bizplan_code` VARCHAR(32) DEFAULT NULL COMMENT '사업계획 코드',
  `bizplan_name` VARCHAR(128) DEFAULT NULL COMMENT '사업계획 명칭',
  `bgacct_code` VARCHAR(32) DEFAULT NULL COMMENT '예산계정 코드',
  `bgacct_name` VARCHAR(128) DEFAULT NULL COMMENT '예산계정 명칭',
  `budget_jsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산집행 금액 ( 편성 + 조정 금액 )',
  `budget_actsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산 실행합 금액 ( 사용예산 금액 )',
  `budget_control_yn` VARCHAR(32) DEFAULT NULL COMMENT '예산 통제여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  `dracct_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '사용금액',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=3855 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_type` VARCHAR(32) DEFAULT NULL COMMENT '예산연동 구분 ( iCUBE 사용 : P / D )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bud_ym` VARBINARY(32) DEFAULT NULL COMMENT '예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_ym` VARCHAR(8) DEFAULT NULL COMMENT '귀속 예산년월';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_gbn` VARCHAR(32) DEFAULT NULL COMMENT '예산통제구분 ( P / D >> iCUBE )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_code` VARCHAR(32) DEFAULT NULL COMMENT '예산단위 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_name` VARCHAR(128) DEFAULT NULL COMMENT '예산단위 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bizplan_code` VARCHAR(32) DEFAULT NULL COMMENT '사업계획 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bizplan_name` VARCHAR(128) DEFAULT NULL COMMENT '사업계획 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bgacct_code` VARCHAR(32) DEFAULT NULL COMMENT '예산계정 코드';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `bgacct_name` VARCHAR(128) DEFAULT NULL COMMENT '예산계정 명칭';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_jsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산집행 금액 ( 편성 + 조정 금액 )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_actsum` DECIMAL(19,2) DEFAULT NULL COMMENT '예산 실행합 금액 ( 사용예산 금액 )';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `budget_control_yn` VARCHAR(32) DEFAULT NULL COMMENT '예산 통제여부';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';
ALTER TABLE `t_ex_expend_budget` ADD IF NOT EXISTS `dracct_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '사용금액';

/* t_ex_expend_card */
CREATE TABLE IF NOT EXISTS `t_ex_expend_card` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 카드 시퀀스',
  `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드코드 ( iCUBE 는 카드코드 존재, ERPiU 는 카드코드 미존재하므로 카드번호로 대체 )',
  `card_num` VARCHAR(32) DEFAULT NULL COMMENT '카드 번호',
  `card_name` VARCHAR(128) DEFAULT NULL COMMENT '카드 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`),
  KEY `seq` (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=5306 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드코드 ( iCUBE 는 카드코드 존재, ERPiU 는 카드코드 미존재하므로 카드번호로 대체 )';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_num` VARCHAR(32) DEFAULT NULL COMMENT '카드 번호';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `card_name` VARCHAR(128) DEFAULT NULL COMMENT '카드 명칭';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_card` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_emp */
CREATE TABLE IF NOT EXISTS `t_ex_expend_emp` (
  `seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '지출결의 사용자 정보 시퀀스',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사시퀀스',
  `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 회사 명칭',
  `erp_comp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 시퀀스',
  `erp_comp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회사 명칭',
  `biz_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사업장 시퀀스',
  `biz_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사업장 명칭',
  `erp_biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 시퀀스',
  `erp_biz_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사업장 명칭',
  `dept_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 부서 시퀀스',
  `dept_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 부서 명칭',
  `erp_dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 시퀀스',
  `erp_dept_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 부서 명칭',
  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사원 시퀀스',
  `erp_emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 시퀀스',
  `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사원 명',
  `erp_emp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사원 명',
  `erp_pc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회계단위 시퀀스',
  `erp_pc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회계단위 명칭',
  `erp_cc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 코스트센터 시퀀스',
  `erp_cc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 코스트센터 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=15335 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 회사시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 회사 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_comp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회사 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_comp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회사 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `biz_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사업장 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `biz_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사업장 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_biz_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사업장 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_biz_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사업장 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `dept_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 부서 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `dept_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 부서 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_dept_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 부서 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_dept_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 부서 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '그룹웨어 사원 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_emp_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 사원 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '그룹웨어 사원 명';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_emp_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 사원 명';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_pc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 회계단위 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_pc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 회계단위 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_cc_seq` VARCHAR(32) DEFAULT NULL COMMENT 'ERP 코스트센터 시퀀스';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `erp_cc_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 코스트센터 명칭';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_history */
CREATE TABLE IF NOT EXISTS `t_ex_expend_history` (
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 Seq',
  `history_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '변경내역 Seq',
  `history_info` LONGTEXT COMMENT '변경내역 정보',
  `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '문서 Seq',
  `create_seq` VARCHAR(32) NOT NULL COMMENT '변경자 사번',
  `create_date` DATETIME NOT NULL COMMENT '변경시간',
  PRIMARY KEY (`expend_seq`,`history_seq`),
  KEY `history_seq` (`history_seq`)
) ENGINE=INNODB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `history_info` LONGTEXT COMMENT '변경내역 정보';
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `doc_seq` VARCHAR(32) DEFAULT NULL COMMENT '문서 Seq';
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `create_seq` VARCHAR(32) NOT NULL COMMENT '변경자 사번';
ALTER TABLE `t_ex_expend_history` ADD IF NOT EXISTS `create_date` DATETIME NOT NULL COMMENT '변경시간';

/* t_ex_expend_list */
CREATE TABLE IF NOT EXISTS `t_ex_expend_list` (
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `list_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 시퀀스',
  `summary_seq` INT(11) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )',
  `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )',
  `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )',
  `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )',
  `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )',
  `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )',
  `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )',
  `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )',
  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자',
  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요',
  `std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급가액',
  `tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '부가세액',
  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급대가',
  `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액',
  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액',
  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값',
  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디',
  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디',
  `json_str` LONGTEXT COMMENT '지출결의 항목 JSON 문자열',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`,`list_seq`),
  KEY `summary_seq` (`summary_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `auth_seq` INT(11) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `write_seq` INT(11) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `emp_seq` INT(11) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `budget_seq` INT(11) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `project_seq` INT(11) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `partner_seq` INT(11) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `card_seq` INT(11) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `note` VARCHAR(100) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급가액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '부가세액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '공급대가';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 항목 JSON 문자열';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_mng */
CREATE TABLE IF NOT EXISTS `t_ex_expend_mng` (
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `list_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 시퀀스',
  `slip_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 분개 시퀀스',
  `mng_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 분개 관리항목 시퀀스',
  `mng_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 코드',
  `mng_name` VARCHAR(40) DEFAULT NULL COMMENT '관리항목 명',
  `mng_form_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 표현 형태 ( ERPiU )',
  `mng_child_yn` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 하위 코드 존재 여부 ( ERPiU )',
  `mng_stat` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 필수 여부 ( iCUBE, ERPiU )',
  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '사용자 입력 관리항목 코드',
  `ctd_name` VARCHAR(100) DEFAULT NULL COMMENT '사용자 입력 관리항목 명칭',
  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 관리항목 JSON 문자열',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  `real_mng_code` VARCHAR(32) DEFAULT NULL COMMENT '실제 연동 관리항목 코드',
  PRIMARY KEY (`expend_seq`,`list_seq`,`slip_seq`,`mng_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 코드';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_name` VARCHAR(40) DEFAULT NULL COMMENT '관리항목 명';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_form_code` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 표현 형태 ( ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_child_yn` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 하위 코드 존재 여부 ( ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `mng_stat` VARCHAR(32) DEFAULT NULL COMMENT '관리항목 필수 여부 ( iCUBE, ERPiU )';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '사용자 입력 관리항목 코드';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `ctd_name` VARCHAR(100) DEFAULT NULL COMMENT '사용자 입력 관리항목 명칭';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 항목 분개 관리항목 JSON 문자열';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';
ALTER TABLE `t_ex_expend_mng` ADD IF NOT EXISTS `real_mng_code` VARCHAR(32) DEFAULT NULL COMMENT '실제 연동 관리항목 코드';

/* t_ex_expend_partner */
CREATE TABLE IF NOT EXISTS `t_ex_expend_partner` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 거래처 시퀀스',
  `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처 코드',
  `partner_name` VARCHAR(128) DEFAULT NULL COMMENT '거래처 명칭',
  `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '사업자 등록 번호',
  `partner_fg` VARCHAR(32) DEFAULT NULL COMMENT '거래처 종류',
  `ceo_name` VARCHAR(128) DEFAULT NULL COMMENT '대표자명',
  `job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '업태',
  `cls_job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '종목',
  `deposit_no` VARCHAR(64) DEFAULT NULL COMMENT '계좌번호',
  `bank_code` VARCHAR(32) DEFAULT NULL COMMENT '은행코드',
  `partner_emp_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자',
  `partner_hp_emp_no` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자연락처',
  `deposit_name` VARCHAR(64) DEFAULT NULL COMMENT '예금주',
  `deposit_convert` VARCHAR(128) DEFAULT NULL COMMENT '관리항목',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=6222 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처 코드';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_name` VARCHAR(128) DEFAULT NULL COMMENT '거래처 명칭';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_no` VARCHAR(32) DEFAULT NULL COMMENT '사업자 등록 번호';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_fg` VARCHAR(32) DEFAULT NULL COMMENT '거래처 종류';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `ceo_name` VARCHAR(128) DEFAULT NULL COMMENT '대표자명';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '업태';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `cls_job_gbn` VARCHAR(32) DEFAULT NULL COMMENT '종목';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `deposit_no` VARCHAR(64) DEFAULT NULL COMMENT '계좌번호';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `bank_code` VARCHAR(32) DEFAULT NULL COMMENT '은행코드';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_emp_code` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `partner_hp_emp_no` VARCHAR(32) DEFAULT NULL COMMENT '거래처담당자연락처';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `deposit_name` VARCHAR(64) DEFAULT NULL COMMENT '예금주';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `deposit_convert` VARCHAR(128) DEFAULT NULL COMMENT '관리항목';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_project */
CREATE TABLE IF NOT EXISTS `t_ex_expend_project` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '지출결의 프로젝트 시퀀스',
  `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드',
  `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=5475 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `project_code` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 코드';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `project_name` VARCHAR(128) DEFAULT NULL COMMENT '프로젝트 명칭';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_project` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_slip */
CREATE TABLE IF NOT EXISTS `t_ex_expend_slip` (
  `expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스',
  `list_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 시퀀스',
  `slip_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 항목 분개 시퀀스',
  `summary_seq` VARCHAR(32) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )',
  `auth_seq` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )',
  `write_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )',
  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )',
  `budget_seq` VARCHAR(32) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )',
  `project_seq` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )',
  `partner_seq` VARCHAR(32) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )',
  `card_seq` VARCHAR(32) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )',
  `drcr_gbn` VARCHAR(32) DEFAULT NULL COMMENT '차변, 대변 구분값',
  `acct_code` VARCHAR(64) DEFAULT NULL COMMENT '계정과목 코드',
  `acct_name` VARCHAR(128) DEFAULT NULL COMMENT '계정과목 명칭',
  `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자',
  `note` VARCHAR(100) DEFAULT NULL COMMENT '적요',
  `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '금액',
  `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액',
  `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액',
  `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값',
  `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디',
  `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디',
  `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KYE 1',
  `row_no` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KEY 2',
  `json_str` LONGTEXT COMMENT '지출결의 항목 분개 JSON 문자열',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`expend_seq`,`list_seq`,`slip_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `summary_seq` VARCHAR(32) DEFAULT NULL COMMENT '표준적요 정보 ( t_ex_expend_summary )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `auth_seq` VARCHAR(32) DEFAULT NULL COMMENT '증빙유형 정보 ( t_ex_expend_auth )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `write_seq` VARCHAR(32) DEFAULT NULL COMMENT '작성자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 정보 ( t_ex_expend_user )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `budget_seq` VARCHAR(32) DEFAULT NULL COMMENT '예산 정보 ( t_ex_expend_budget )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `project_seq` VARCHAR(32) DEFAULT NULL COMMENT '프로젝트 정보 ( t_ex_expend_project )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `partner_seq` VARCHAR(32) DEFAULT NULL COMMENT '거래처 정보 ( t_ex_expend_partner )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `card_seq` VARCHAR(32) DEFAULT NULL COMMENT '카드 정보 ( t_ex_expend_card )';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `drcr_gbn` VARCHAR(32) DEFAULT NULL COMMENT '차변, 대변 구분값';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `acct_code` VARCHAR(64) DEFAULT NULL COMMENT '계정과목 코드';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `acct_name` VARCHAR(128) DEFAULT NULL COMMENT '계정과목 명칭';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `auth_date` VARCHAR(8) DEFAULT NULL COMMENT '증빙일자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `note` VARCHAR(100) DEFAULT NULL COMMENT '적요';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `amt` DECIMAL(19,2) DEFAULT NULL COMMENT '금액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `sub_std_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '과세표준액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `sub_tax_amt` DECIMAL(19,2) DEFAULT NULL COMMENT '세액';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `interface_type` VARCHAR(128) DEFAULT NULL COMMENT '연동 구분 값';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `interface_m_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 마스터 아이디';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `interface_d_id` VARCHAR(32) DEFAULT NULL COMMENT '연동 디테일 아이디';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `row_id` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KYE 1';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `row_no` VARCHAR(20) DEFAULT NULL COMMENT 'ERPiU FI_GMMSUM_OTHER KEY 2';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `json_str` LONGTEXT COMMENT '지출결의 항목 분개 JSON 문자열';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_expend_summary */
CREATE TABLE IF NOT EXISTS `t_ex_expend_summary` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '분개정보 시퀀스',
  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )',
  `summary_code` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 코드',
  `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭',
  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 계정과목 코드',
  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭',
  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드',
  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 게정과목 명칭',
  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드',
  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명칭',
  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드',
  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융거래처 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=4894 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_code` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 게정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융거래처 코드';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융거래처 명칭';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* t_ex_expend_vat */
CREATE TABLE IF NOT EXISTS `t_ex_expend_vat` (
  `ex_gb` VARCHAR(10) NOT NULL COMMENT '전표/분개 구분값',
  `ex_vat_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '부가세정보 고유키',
  `vat_type_code` INT(11) DEFAULT NULL COMMENT '부가세구분 그룹웨어 코드 ( ERP IU / ICUBE )',
  `vat_type_name` VARCHAR(100) DEFAULT NULL COMMENT '부가세구분 그룹웨어 명 ( ERP IU / ICUBE )',
  `va_type_code` INT(11) DEFAULT NULL,
  `va_type_name` VARCHAR(100) DEFAULT NULL,
  `mutual_code` VARCHAR(20) DEFAULT NULL COMMENT '불공제/사유 ERP 코드 ( ERP IU / ICUBE )',
  `mutual_name` VARCHAR(100) DEFAULT NULL COMMENT '불공제/사유 ERP 명 ( ERP IU / ICUBE )',
  `iss_yn` VARCHAR(20) DEFAULT NULL COMMENT '전자세금계산서 여부 ERP 코드 ( ERP IU : 종이세금계산서 ( 0 ), 전자세금계산서 ( 2 ) / ICUBE )',
  `jeonjasend_yn` VARCHAR(20) DEFAULT NULL COMMENT '국세청전송11일이내 여부 ERP 코드 ( ERP IU : 전송 ( 0 ), 미전송 ( 1 ) / ICUBE )',
  `tex_md` VARCHAR(4) DEFAULT NULL COMMENT '품목정보 월/일 ( ERP IU )',
  `item_name` VARCHAR(50) DEFAULT NULL COMMENT '품목정보 품명 ( ERP IU )',
  `size_name` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 규격 ( ERP IU )',
  `tax_qt` DECIMAL(17,4) DEFAULT NULL COMMENT '품목정보 수량 ( ERP IU )',
  `prc_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 단가 ( ERP IU )',
  `supply_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 공급가액 ( ERP IU )',
  `tax_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 부가세액 ( ERP IU )',
  `note_nm` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 비고 ( ERP IU )',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부',
  `create_user_seq` INT(11) DEFAULT NULL COMMENT '작성자 그룹웨어 아이디',
  `create_date` DATETIME DEFAULT NULL COMMENT '작성일자',
  `modify_user_seq` INT(11) DEFAULT NULL COMMENT '수정자 그룹웨어 아이디',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`ex_gb`,`ex_vat_seq`),
  KEY `ex_vat_seq` (`ex_vat_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `vat_type_code` INT(11) DEFAULT NULL COMMENT '부가세구분 그룹웨어 코드 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `vat_type_name` VARCHAR(100) DEFAULT NULL COMMENT '부가세구분 그룹웨어 명 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `va_type_code` INT(11) DEFAULT NULL;
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `va_type_name` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `mutual_code` VARCHAR(20) DEFAULT NULL COMMENT '불공제/사유 ERP 코드 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `mutual_name` VARCHAR(100) DEFAULT NULL COMMENT '불공제/사유 ERP 명 ( ERP IU / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `iss_yn` VARCHAR(20) DEFAULT NULL COMMENT '전자세금계산서 여부 ERP 코드 ( ERP IU : 종이세금계산서 ( 0 ), 전자세금계산서 ( 2 ) / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `jeonjasend_yn` VARCHAR(20) DEFAULT NULL COMMENT '국세청전송11일이내 여부 ERP 코드 ( ERP IU : 전송 ( 0 ), 미전송 ( 1 ) / ICUBE )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tex_md` VARCHAR(4) DEFAULT NULL COMMENT '품목정보 월/일 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `item_name` VARCHAR(50) DEFAULT NULL COMMENT '품목정보 품명 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `size_name` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 규격 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tax_qt` DECIMAL(17,4) DEFAULT NULL COMMENT '품목정보 수량 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `prc_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 단가 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `supply_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 공급가액 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `tax_am` DECIMAL(19,4) DEFAULT NULL COMMENT '품목정보 부가세액 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `note_nm` VARCHAR(20) DEFAULT NULL COMMENT '품목정보 비고 ( ERP IU )';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `create_user_seq` INT(11) DEFAULT NULL COMMENT '작성자 그룹웨어 아이디';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '작성일자';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `modify_user_seq` INT(11) DEFAULT NULL COMMENT '수정자 그룹웨어 아이디';
ALTER TABLE `t_ex_expend_vat` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자';

/* t_ex_item */
CREATE TABLE IF NOT EXISTS `t_ex_item` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '귀속 회사 시퀀스',
  `form_seq` VARCHAR(32) NOT NULL COMMENT '귀속 전자결재 양식 시퀀스',
  `item_gbn` VARCHAR(100) NOT NULL COMMENT '표현 위치 구분',
  `langpack_code` VARCHAR(100) NOT NULL COMMENT '코드',
  `langpack_name` VARCHAR(100) DEFAULT NULL COMMENT '명칭',
  `order_num` INT(11) DEFAULT NULL COMMENT '정렬 순서',
  `display_align` VARCHAR(10) DEFAULT NULL COMMENT '정렬 표현 방법',
  `head_code` VARCHAR(100) DEFAULT NULL COMMENT '그리드 헤더 키',
  `select_yn` VARCHAR(1) DEFAULT NULL COMMENT '기본키 여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`comp_seq`,`form_seq`,`item_gbn`,`langpack_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `langpack_name` VARCHAR(100) DEFAULT NULL COMMENT '명칭';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `order_num` INT(11) DEFAULT NULL COMMENT '정렬 순서';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `display_align` VARCHAR(10) DEFAULT NULL COMMENT '정렬 표현 방법';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `head_code` VARCHAR(100) DEFAULT NULL COMMENT '그리드 헤더 키';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `select_yn` VARCHAR(1) DEFAULT NULL COMMENT '기본키 여부';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 생성자';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 생성일';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_item` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일';

/* t_ex_langpack */
CREATE TABLE IF NOT EXISTS `t_ex_langpack` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사 시퀀스',
  `lang_type` VARCHAR(5) NOT NULL COMMENT '언어 타입',
  `lang_code` VARCHAR(50) NOT NULL COMMENT '명칭 코드',
  `basic_name` VARCHAR(50) NOT NULL COMMENT '기본 명칭',
  `langpack_code` VARCHAR(50) NOT NULL COMMENT '다국어 코드',
  `lang_name` VARCHAR(50) NOT NULL COMMENT '명칭',
  `create_seq` INT(11) NOT NULL COMMENT '생성자',
  `create_date` DATETIME NOT NULL COMMENT '생성일',
  `modify_seq` INT(11) NOT NULL COMMENT '수정자',
  `modify_date` DATETIME NOT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`lang_type`,`lang_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `basic_name` VARCHAR(50) NOT NULL COMMENT '기본 명칭';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `langpack_code` VARCHAR(50) NOT NULL COMMENT '다국어 코드';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `lang_name` VARCHAR(50) NOT NULL COMMENT '명칭';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `create_seq` INT(11) NOT NULL COMMENT '생성자';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `create_date` DATETIME NOT NULL COMMENT '생성일';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `modify_seq` INT(11) NOT NULL COMMENT '수정자';
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `modify_date` DATETIME NOT NULL COMMENT '수정일';

/* t_ex_mng_option */
CREATE TABLE IF NOT EXISTS `t_ex_mng_option` (
  `comp_seq` INT(11) NOT NULL COMMENT '회사시퀀스',
  `form_seq` INT(11) NOT NULL COMMENT '양식코드',
  `drcr_gbn` VARCHAR(20) NOT NULL COMMENT '관리항목구분',
  `mng_code` VARCHAR(20) NOT NULL COMMENT '관리항목코드',
  `mng_name` VARCHAR(100) DEFAULT NULL COMMENT '관리항목명',
  `use_gbn` VARCHAR(20) DEFAULT NULL COMMENT '사용구분',
  `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력코드',
  `ctd_name` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력명',
  `note` VARCHAR(512) DEFAULT NULL COMMENT '비고 ( 툴팁활용 )',
  `cust_set` VARCHAR(4000) DEFAULT NULL COMMENT '커스터마이징을 위한 컬럼',
  `cust_set_target` VARCHAR(32) DEFAULT NULL COMMENT '조회 대상 ( BizboxA, iCUBE, ERPiU )',
  `modify_yn` VARCHAR(32) DEFAULT NULL COMMENT '수정가능 여부 ( 전용개발인 경우, 사용자에 의한 삭제 및 수정이 불가해야 함 )',
  `create_seq` INT(11) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`comp_seq`,`form_seq`,`drcr_gbn`,`mng_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `mng_name` VARCHAR(100) DEFAULT NULL COMMENT '관리항목명';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `use_gbn` VARCHAR(20) DEFAULT NULL COMMENT '사용구분';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `ctd_code` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력코드';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `ctd_name` VARCHAR(20) DEFAULT NULL COMMENT '관리항목 사용자 입력명';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `note` VARCHAR(512) DEFAULT NULL COMMENT '비고 ( 툴팁활용 )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `cust_set` VARCHAR(4000) DEFAULT NULL COMMENT '커스터마이징을 위한 컬럼';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `cust_set_target` VARCHAR(32) DEFAULT NULL COMMENT '조회 대상 ( BizboxA, iCUBE, ERPiU )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `modify_yn` VARCHAR(32) DEFAULT NULL COMMENT '수정가능 여부 ( 전용개발인 경우, 사용자에 의한 삭제 및 수정이 불가해야 함 )';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `create_seq` INT(11) DEFAULT NULL COMMENT '생성자';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '생성일';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `t_ex_mng_option` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '수정일';

/* t_ex_option */
CREATE TABLE IF NOT EXISTS `t_ex_option` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 회사시퀀스 ( 기본 0 )',
  `form_seq` INT(11) NOT NULL COMMENT '옵션 귀속 양식코드 ( 기본 0 )',
  `option_gbn` VARCHAR(32) NOT NULL COMMENT '옵션 구분 코드',
  `option_code` VARCHAR(32) NOT NULL COMMENT '옵션 상세 코드',
  `use_sw` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 연동 시스템',
  `order_num` DECIMAL(65,0) DEFAULT NULL COMMENT '정렬순서',
  `common_code` VARCHAR(32) DEFAULT NULL COMMENT '공통코드',
  `base_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 기본 설정 코드',
  `base_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 명칭',
  `base_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 사용자 정의',
  `set_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 설정 코드',
  `set_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 명칭',
  `set_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 사용자 정의',
  `option_select_type` VARCHAR(32) DEFAULT NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )',
  `option_process_type` VARCHAR(32) DEFAULT NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )',
  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`comp_seq`,`form_seq`,`option_gbn`,`option_code`,`use_sw`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `use_sw` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 연동 시스템';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `order_num` DECIMAL(65,0) DEFAULT NULL COMMENT '정렬순서';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `common_code` VARCHAR(32) DEFAULT NULL COMMENT '공통코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `base_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 기본 설정 코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `base_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 명칭';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `base_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 기본 설정 사용자 정의';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `set_value` VARCHAR(32) DEFAULT NULL COMMENT '옵션 설정 코드';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `set_name` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 명칭';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `set_emp_value` VARCHAR(128) DEFAULT NULL COMMENT '옵션 설정 사용자 정의';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `option_select_type` VARCHAR(32) DEFAULT NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `option_process_type` VARCHAR(32) DEFAULT NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_option` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_option_multi */
CREATE TABLE IF NOT EXISTS `t_ex_option_multi` (
  `option_gbn` VARCHAR(32) NOT NULL COMMENT '옵션 구분 코드',
  `option_code` VARCHAR(32) NOT NULL COMMENT '옵션 상세 코드',
  `use_sw` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 연동 시스템',
  `lang_code` VARCHAR(32) NOT NULL COMMENT '연동 언어 코드',
  `option_name` VARCHAR(512) DEFAULT NULL COMMENT '옵션 명칭',
  `option_note` VARCHAR(1024) DEFAULT NULL COMMENT '옵션 설명',
  `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자',
  PRIMARY KEY (`option_gbn`,`option_code`,`use_sw`,`lang_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `option_name` VARCHAR(512) DEFAULT NULL COMMENT '옵션 명칭';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `option_note` VARCHAR(1024) DEFAULT NULL COMMENT '옵션 설명';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `use_yn` VARCHAR(32) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_option_multi` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정 일자';

/* t_ex_summary */
CREATE TABLE IF NOT EXISTS `t_ex_summary` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `summary_code` VARCHAR(20) NOT NULL COMMENT '표준적요 코드',
  `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭',
  `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )',
  `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 게정과목 코드',
  `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭',
  `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드',
  `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 계정과목 명칭',
  `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드',
  `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명',
  `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융 거래처 코드',
  `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융 거래처 명칭',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최총 수정 일자',
  `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서',
  PRIMARY KEY (`comp_seq`,`summary_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `summary_name` VARCHAR(120) DEFAULT NULL COMMENT '표준적요 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `summary_div` VARCHAR(20) DEFAULT NULL COMMENT '표준적요 구분 ( A : 지출결의 / B : 매출결의 )';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `dr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '차변 게정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `dr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '차변 계정과목 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `cr_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '대변 계정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `cr_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '대변 계정과목 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `vat_acct_code` VARCHAR(60) DEFAULT NULL COMMENT '부가세 계정과목 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `vat_acct_name` VARCHAR(120) DEFAULT NULL COMMENT '부가세 계정과목 명';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `bank_partner_code` VARCHAR(60) DEFAULT NULL COMMENT '금융 거래처 코드';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `bank_partner_name` VARCHAR(200) DEFAULT NULL COMMENT '금융 거래처 명칭';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성 일자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최총 수정 일자';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `order_num` DECIMAL(10,0) DEFAULT NULL COMMENT '정렬순서';

/* t_ex_vat */
CREATE TABLE IF NOT EXISTS `t_ex_vat` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스',
  `vat_code` VARCHAR(20) NOT NULL COMMENT '세무구분 코드',
  `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭',
  `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자',
  PRIMARY KEY (`comp_seq`,`vat_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `vat_name` VARCHAR(32) DEFAULT NULL COMMENT '세무구분 명칭';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `use_yn` VARCHAR(20) DEFAULT NULL COMMENT '사용여부';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자';
ALTER TABLE `t_ex_vat` ADD IF NOT EXISTS `modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일자';

/* 명칭설정 툴팁 추가 / 최상배 / 2017-04-12 */
ALTER TABLE `t_ex_langpack` ADD IF NOT EXISTS `tooltip` VARCHAR(256) DEFAULT '' COMMENT '명칭 툴팁';

/* 양식설정 / 양식정보 */
CREATE TABLE IF NOT EXISTS `t_ex_form` (
  `form_seq` varchar(96) NOT NULL COMMENT '양식 시퀀스',
  `comp_seq` varchar(96) NOT NULL COMMENT '회사 시퀀스',
  `form_content` text COMMENT '양식 본문 TABLE',
  `form_change_content` text COMMENT '양식 본문 HTML',
  `create_seq` varchar(96) DEFAULT NULL COMMENT '생성자',
  `create_date` datetime DEFAULT NULL COMMENT '생성일',
  `modify_seq` varchar(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` datetime DEFAULT NULL COMMENT '생성일',
  PRIMARY KEY (`form_seq`,`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


/* 양식설정 / 양식샘플 */
CREATE TABLE IF NOT EXISTS `t_ex_form_sample` (
  `seq` int(11) DEFAULT NULL COMMENT '양식 순번',
  `comp_seq` varchar(96) DEFAULT NULL COMMENT '회사 시퀀스',
  `sample_name` varchar(765) DEFAULT NULL COMMENT '샘플코드 이름',
  `sample_content` text COMMENT '샘플코드 본문',
  `create_seq` varchar(96) DEFAULT NULL COMMENT '생성자',
  `create_date` datetime DEFAULT NULL COMMENT '생성일',
  `modify_seq` varchar(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` datetime DEFAULT NULL COMMENT '수정일'
) ENGINE=INNODB DEFAULT CHARSET=utf8;


/* 양식설정 / 양식코드 */
CREATE TABLE IF NOT EXISTS `t_ex_form_code` (
  `code` varchar(96) NOT NULL COMMENT '코드명',
  `code_name` varchar(192) DEFAULT NULL COMMENT '코드 명칭',
  `code_gbn` varchar(96) DEFAULT NULL COMMENT '코드 구분',
  `use_yn` char(3) DEFAULT NULL COMMENT '사용여부',
  `required_yn` char(3) DEFAULT NULL COMMENT '필수 여부',
  `create_seq` varchar(96) DEFAULT NULL COMMENT '생성자',
  `create_date` datetime DEFAULT NULL COMMENT '생성일',
  `modify_seq` varchar(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* 2017. 05. 08. */
/* 2017. 05. 08. - 신재호 */
/* 2017. 05. 08. - 신재호 - 지출결의(영리) 항목단위 전송시 row_id 저장 테이블 */
CREATE TABLE IF NOT EXISTS `t_ex_expend_send`( 
	`expend_seq` VARCHAR(32) NOT NULL COMMENT '지출결의 시퀀스', 
	`list_seq` VARCHAR(32) NOT NULL COMMENT '리스트 시퀀스', 
	`row_id` VARCHAR(20) COMMENT 'ERPiU 자동전표 번호', 
	`in_dt` VARCHAR(8) COMMENT 'iCUBE 자동전표 번호', 
	`in_sq` INT(11) COMMENT 'iCUBE 자동전표 번호', 
	`doc_seq` VARCHAR(32) NOT NULL COMMENT '그룹웨어 문서 번호', 
	`create_seq` VARCHAR(32) COMMENT '작성자', 
	`create_date` DATETIME COMMENT '작성일', 
	PRIMARY KEY (`expend_seq`, `list_seq`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci; 


/* 2017. 05. 10. */
/* 2017. 05. 10. - 신재호 */
/* 2017. 05. 10. - 신재호 - 지출결의(영리) 항목설정 페이지 회사 시퀀스 varchar로 변경 */
ALTER TABLE `t_ex_mng_option` CHANGE `comp_seq` `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사시퀀스';

/* t_ex_form primary key 정의 */
/* t_ex_form primary key 정의 - 백업 테이블 생성 */
DROP TABLE IF EXISTS `t_ex_form_bak`;
CREATE TABLE IF NOT EXISTS `t_ex_form_bak` (
  `form_seq` VARCHAR(96) NOT NULL COMMENT '양식 시퀀스',
  `comp_seq` VARCHAR(96) NOT NULL COMMENT '회사 시퀀스',
  `form_content` TEXT COMMENT '양식 본문 TABLE',
  `form_change_content` TEXT COMMENT '양식 본문 HTML',
  `create_seq` VARCHAR(96) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` VARCHAR(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '생성일'
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* t_ex_form primary key 정의 - 기존 데이터 백업 */
INSERT INTO `t_ex_form_bak` ( `form_seq`, `comp_seq`, `form_content`, `form_change_content`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
SELECT  `form_seq`, `comp_seq`, `form_content`, `form_change_content`, 'SYSTEM', NOW(), 'SYSTEM', NOW()
FROM    `t_ex_form`
WHERE   `form_seq` != '0'
GROUP   BY `form_seq`, `comp_seq`, `form_content`, `form_change_content`;

/* t_ex_form primary key 정의 - 테이블 재생성 */
DROP TABLE `t_ex_form`;
CREATE TABLE IF NOT EXISTS `t_ex_form` (
  `form_seq` VARCHAR(96) NOT NULL COMMENT '양식 시퀀스',
  `comp_seq` VARCHAR(96) NOT NULL COMMENT '회사 시퀀스',
  `form_content` TEXT COMMENT '양식 본문 TABLE',
  `form_change_content` TEXT COMMENT '양식 본문 HTML',
  `create_seq` VARCHAR(96) DEFAULT NULL COMMENT '생성자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_seq` VARCHAR(96) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '생성일',
  PRIMARY KEY (`form_seq`,`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* t_ex_form primary key 정의 - 백업 데이터 복원 */
INSERT INTO `t_ex_form` ( `form_seq`, `comp_seq`, `form_content`, `form_change_content`, `create_seq`, `create_date`, `modify_seq`, `modify_date` )
SELECT  `form_seq`, `comp_seq`, `form_content`, `form_change_content`, 'SYSTEM', NOW(), 'SYSTEM', NOW()
FROM    `t_ex_form_bak`
WHERE   `form_seq` != '0'
GROUP   BY `form_seq`, `comp_seq`, `form_content`, `form_change_content`;

/* t_ex_form primary key 정의 - 기본값 재설정 */
INSERT IGNORE INTO `t_ex_form` (
        `form_seq`
        , `comp_seq`
        , `form_content`
        , `form_change_content`
        , `create_seq`
        , `create_date`
        , `modify_seq`
        , `modify_date` )
VALUES (
        '0'
        , 'EXP_FORM'
        , '<table width="100%" border="1" cellspacing="0" cellpadding="0"><tbody><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">회계일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="3"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendDate_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">지급요청일자</span></p></td><td width="245" height="27" align="center" style="width: 245px; text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendReqDate_</span></p></td></tr><tr><td width="10%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">순번</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">계정분류</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">적요</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙구분</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">법인카드</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">프로젝트</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">거래처</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">공급가액</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">부가세</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">첨부</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)" colspan="2"><p>예산단위</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>사업계획</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산계정</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산년월</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>실행합금액</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>집행금액</p></td></tr><tr><td height="27" align="center" class="listNum" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listNum_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAcctName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: left; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> _note_ [_slipPop_]</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authName_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authDate_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;">_cardName_</td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listStdAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listTaxAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_attach_ </span></p></td></tr><tr><td height="27" align="center" style="text-align: center;" colspan="2"><p>_budgetName_</p></td><td height="27" align="center" style="text-align: center;"><p>_bizplanName_</p></td><td height="27" align="right" style="text-align: right;"><p>_bgacctName_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetYm_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetActsum_</p></td><td height="27" align="center" style="text-align: center;"><p>_budgetJsum_</p></td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="4"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_vatAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_crAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> </span></p></td></tr></tbody></table>'
        , '<table width="100%" border="1" cellspacing="0" cellpadding="0"><tbody><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">회계일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="3"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendDate_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">지급요청일자</span></p></td><td width="245" height="27" align="center" style="width: 245px; text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendReqDate_</span></p></td></tr><tr><td width="10%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">순번</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">계정분류</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">적요</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙구분</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">법인카드</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">프로젝트</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">거래처</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">공급가액</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">부가세</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">첨부</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)" colspan="2"><p>예산단위</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>사업계획</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산계정</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산년월</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>실행합금액</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>집행금액</p></td></tr><tr><td height="27" align="center" class="listNum" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listNum_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAcctName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: left; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> _note_ [_slipPop_]</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authName_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authDate_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;">_cardName_</td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listStdAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listTaxAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_attach_ </span></p></td></tr><tr><td height="27" align="center" style="text-align: center;" colspan="2"><p>_budgetName_</p></td><td height="27" align="center" style="text-align: center;"><p>_bizplanName_</p></td><td height="27" align="right" style="text-align: right;"><p>_bgacctName_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetYm_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetActsum_</p></td><td height="27" align="center" style="text-align: center;"><p>_budgetJsum_</p></td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="4"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_vatAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_crAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> </span></p></td></tr></tbody></table>'
        , 'SYSTEM'
        , NOW()
        , 'SYSTEM'
        , NOW() );

UPDATE  `t_ex_form`
SET     form_content = '<table width="100%" border="1" cellspacing="0" cellpadding="0"><tbody><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">회계일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="3"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendDate_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">지급요청일자</span></p></td><td width="245" height="27" align="center" style="width: 245px; text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_expendReqDate_</span></p></td></tr><tr><td width="10%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">순번</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">계정분류</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">적요</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙구분</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">증빙일자</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">법인카드</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">프로젝트</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">거래처</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">공급가액</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">부가세</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td width="12%" height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">첨부</span></p></td></tr><tr><td width="20%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)" colspan="2"><p>예산단위</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>사업계획</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산계정</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>예산년월</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>실행합금액</p></td><td width="12%" height="27" align="center" style="text-align: center; background-color: rgb(231, 230, 230);" bgcolor="rgb(231,230,230)"><p>집행금액</p></td></tr><tr><td height="27" align="center" class="listNum" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" rowspan="3" colspan="1"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listNum_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAcctName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: left; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> _note_ [_slipPop_]</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authName_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_authDate_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;">_cardName_</td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;" colspan="2"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_projectName_</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listStdAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listTaxAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_listAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt;"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_attach_ </span></p></td></tr><tr><td height="27" align="center" style="text-align: center;" colspan="2"><p>_budgetName_</p></td><td height="27" align="center" style="text-align: center;"><p>_bizplanName_</p></td><td height="27" align="right" style="text-align: right;"><p>_bgacctName_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetYm_</p></td><td height="27" align="right" style="text-align: right;"><p>_budgetActsum_</p></td><td height="27" align="center" style="text-align: center;"><p>_budgetJsum_</p></td></tr><tr><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);" colspan="4"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">합계</span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_drAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_vatAmt_ </span></p></td><td height="27" align="right" style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: right; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;">_crAmt_ </span></p></td><td height="27" align="center" style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; background-color: rgb(231, 230, 230);"><p style="text-align: center; line-height: 1.2; font-family: 돋움; font-size: 10pt; margin-top: 0px; margin-bottom: 0px;"><span style="font-family: 돋움; font-size: 9pt;"> </span></p></td></tr></tbody></table>'
WHERE   form_seq = '0'
AND     comp_seq = 'EXP_FORM';

DROP TABLE IF EXISTS `t_ex_form_bak`;

/* 2017. 06. 16. */
/* 2017. 06. 16. - 신재호 */
/* 2017. 06. 16. - 신재호 - 지출결의(영리) ERPiU 거래처 계좌번호 코드 추가 */
ALTER TABLE `t_ex_expend_partner` ADD IF NOT EXISTS  `deposit_cd` VARCHAR(64) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '계좌번호코드' AFTER `deposit_convert`; 

/* 2017. 07. 06. */
/* 2017. 07. 06. - 신재호 */
/* 2017. 07. 06. - 신재호 - 세금계산서 권한 테이블 추가 */
CREATE TABLE IF NOT EXISTS `t_ex_etax`( 
	`etax_seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '세금계산서 권한 시퀀스', 
	`comp_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '회사 시퀀스', 
	`auth_type` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '권한타입(P:거래처, E:이메일)', 
	`use_yn` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '사용여부', 
	`name` VARCHAR(100) CHARSET utf8 COLLATE utf8_general_ci COMMENT '대상 명칭(거래처명 또는 이메일주소)', 
	`code` VARCHAR(100) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '대상 코드(사업자등록번호 또는 이메일주소)',
	`public_json` LONGTEXT CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '공개범위 JSON',
	PRIMARY KEY (`etax_seq`, `comp_seq`) 
) ENGINE=INNODB DEFAULT CHARSET=utf8; 
 
/* 2017. 07. 06. */
/* 2017. 07. 06. - 신재호 */
/* 2017. 07. 06. - 신재호 - 세금계산서 권한 공개범위 테이블 추가 */
CREATE TABLE IF NOT EXISTS `t_ex_etax_public`( 
	`etax_seq` INT(32) NOT NULL COMMENT '세금계산서 권한 시퀀스', 
	`comp_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '회사 시퀀스', 
	`pupblic_seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '공개범위 시퀀스', 
	`type` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '공개범위 타입(U:사용자, D:부서)', 
	`code` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '코드(사용자 또는 부서코드)',
	`name` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '명칭(이름)',
	KEY(`pupblic_seq`), PRIMARY KEY (`etax_seq`, `comp_seq`, `pupblic_seq`) 
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/* 2017. 07. 17. */
/* 2017. 07. 17. - 신재호 */
/* 2017. 07. 17. - 신재호 - 세금계산서 권한 공개범위 테이블 수정(그룹시퀀스, 부서시퀀스 추가) */
ALTER TABLE `t_ex_etax_public` ADD IF NOT EXISTS `group_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '그룹 시퀀스' AFTER `name`, ADD IF NOT EXISTS `dept_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '부서 시퀀스' AFTER `group_seq`;

/* 2017. 07. 19. */
/* 2017. 07. 19. - 신재호 */
/* 2017. 07. 19. - 신재호 - 세금계산서발행여부 및 11이내 전송여부 추가 */
ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `etax_yn` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '전자세금계산서여부' AFTER `modify_date`, ADD IF NOT EXISTS `etax_send_yn` VARCHAR(1) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '계산서11이내 전송여부' AFTER `etax_yn`;
ALTER TABLE `t_ex_etax_public` ADD IF NOT EXISTS `group_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '그룹 시퀀스' AFTER `name`, ADD IF NOT EXISTS `dept_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '부서 시퀀스' AFTER `group_seq`;
ALTER TABLE `t_ex_etax_public` ADD IF NOT EXISTS `group_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '그룹 시퀀스' AFTER `name`, ADD IF NOT EXISTS `dept_seq` VARCHAR(32) CHARSET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '부서 시퀀스' AFTER `group_seq`;

/* 2017. 09. 14. */
/* 2017. 09. 14. - 김상겸 */
/* 2017. 09. 14. - 김상겸 - 양식별 표준적요 & 증빙유형 귀속 범위 설정 */
CREATE TABLE IF NOT EXISTS `t_ex_formlink_summary_auth` (
  `comp_seq` varchar(32) NOT NULL COMMENT '회사 시퀀스',
  `form_seq` varchar(32) NOT NULL COMMENT '양식 시퀀스',
  `type_div` varchar(32) NOT NULL COMMENT '표준적요 / 증빙유형 구분 ( 표준적요(summary) / 증빙유형(auth) )',
  `code_div` varchar(2) NOT NULL COMMENT '코드 귀속 구분 ( 매입(A) / 매출(B) ) ## 매출 기능 미존재 ##',
  `code` varchar(32) NOT NULL COMMENT '표준적요 코드 or 증빙유형 코드',
  `create_seq` varchar(32) DEFAULT NULL COMMENT '최초 생성자',
  `create_date` datetime DEFAULT NULL COMMENT '최초 생성일',
  `modify_seq` varchar(32) DEFAULT NULL COMMENT '최종 수정자',
  `modify_date` datetime DEFAULT NULL COMMENT '최종 수정일',
  PRIMARY KEY (`comp_seq`,`form_seq`,`type_div`,`code_div`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 2017. 09. 28. */
/* 2017. 09. 28. - 신재호 */
/* 2017. 09. 28. - 신재호 - 사용자 계좌번호 추가 */
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `deposit_name` VARCHAR(100) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '경비계좌' AFTER `modify_date`;
ALTER TABLE `t_ex_expend_emp` ADD IF NOT EXISTS `deposit_cd` VARCHAR(20) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '경비계좌코드' AFTER `deposit_name`; 

/* 2017. 10. 17. */
/* 2017. 10. 17. - 신재호 */
/* 2017. 10. 17. - 신재호 - 지출결의 마감설정 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_close`( 
	`comp_seq` VARCHAR(32) NOT NULL COMMENT '회사Seq', 
	`form_seq` VARCHAR(32) NOT NULL COMMENT '양식Seq', 
	`seq` INT NOT NULL COMMENT 'seq', 
	`close_type` VARCHAR(1) NOT NULL COMMENT '마감구분(C:작성일,E:회계일자,A:증빙일자)', 
	`close_from_date` VARCHAR(8) NOT NULL COMMENT '시작일', 
	`close_to_date` VARCHAR(8) NOT NULL COMMENT '종료일', 
	`close_stat` VARCHAR(1) NOT NULL COMMENT '마감상태(Y:마감,N:마감취소)', 
	`note` LONGTEXT COMMENT '비고', 
	`create_seq` VARCHAR(32) COMMENT '작성자', 
	`create_date` DATETIME COMMENT '작성일', 
	`modify_seq` VARCHAR(32) NOT NULL COMMENT '수정자(마감자)', 
	`modify_name` VARCHAR(128) NOT NULL COMMENT '수정자명(마감자명)', 
	`modify_date` DATETIME NOT NULL COMMENT '수정일(마감등록일)', 
	PRIMARY KEY (`comp_seq`, `form_seq`, `seq`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci;


/* 2017. 10. 17. */
/* 2017. 10. 17. - 신재호 */
/* 2017. 10. 17. - 신재호 - 지출결의 마감설정 이력 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_close_history`( 
	`comp_seq` VARCHAR(32) NOT NULL COMMENT '회사Seq', 
	`form_seq` VARCHAR(32) NOT NULL COMMENT '양식Seq', 
	`close_seq` INT NOT NULL COMMENT '마감Seq', 
	`seq` INT NOT NULL COMMENT '이력Seq', 
	`close_stat` VARCHAR(1) NOT NULL COMMENT '마감상태(Y:마감,N:마감취소,D:삭제)',
	`hitory_info` LONGTEXT NOT NULL COMMENT '마감정보(마감구분/시작일/종료일/비고/작성자/작성일)', 
	`create_seq` VARCHAR(32) NOT NULL COMMENT '수정자', 
	`create_date` DATETIME NOT NULL COMMENT '수정일', 
	PRIMARY KEY (`comp_seq`, `form_seq`, `close_seq`, `seq`) 
) ENGINE=INNODB CHARSET=utf8 COLLATE=utf8_general_ci; 

ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `fee_seq` INT(11) DEFAULT 0 NULL COMMENT '접대비관련 정보' AFTER `card_seq`; 
ALTER TABLE `t_ex_expend_slip` ADD IF NOT EXISTS `fee_seq` INT(11) DEFAULT 0 NULL COMMENT '접대비 정보(t_ex_entertainment)' AFTER `card_seq`; 

/* 2017. 11. 02. */
/* 2017. 11. 02. - 최상배 */
/* 2017. 11. 02. - 신재호 - 지출결의 접대비 부표 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_ex_entertainment` (
  `fee_seq` INT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '접대비 등록 키',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '회사 코드',
  `start_date` VARCHAR(10) DEFAULT NULL COMMENT '발생일자',
  `use_fg_code` VARCHAR(4) DEFAULT NULL COMMENT '사용구분 코드',
  `use_fg_name` VARCHAR(32) DEFAULT NULL COMMENT '사용구분 명칭',
  `auth_fg_code` VARCHAR(4) DEFAULT NULL COMMENT '증빙구분 코드',
  `auth_fg_name` VARCHAR(32) DEFAULT NULL COMMENT '증빙구분 명칭',
  `card_code` VARCHAR(32) DEFAULT NULL COMMENT '카드 코드',
  `card_num` VARCHAR(20) DEFAULT NULL COMMENT '카드 번호',
  `partner_code` VARCHAR(32) DEFAULT NULL COMMENT '접대상대(거래처) 코드',
  `partner_name` VARCHAR(120) DEFAULT NULL COMMENT '접대상대(거래처) 명칭',
  `partner_num` VARCHAR(10) DEFAULT NULL COMMENT '사업자 번호',
  `ceo_name` VARCHAR(20) DEFAULT NULL COMMENT '대표자 명칭',
  `res_num` VARCHAR(20) DEFAULT NULL COMMENT '주민번호',
  `amt` VARCHAR(64) DEFAULT NULL COMMENT '사용 금액',
  `metirial_amt` VARCHAR(64) DEFAULT NULL COMMENT '물품대',
  `service_amt` VARCHAR(64) DEFAULT NULL COMMENT '봉사료',
  `entertainment` VARCHAR(256) DEFAULT NULL COMMENT '접대 내역',
  `note` VARCHAR(256) DEFAULT NULL COMMENT '비고',
  `amt_over_yn` VARCHAR(1) DEFAULT NULL COMMENT '금액 초과 여부',
  PRIMARY KEY (`fee_seq`)
) ENGINE=INNODB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/* 2017. 12. 12. */
/* 2017. 12. 12. - 신재호 */
/* 2017. 12. 12. - 신재호 - 지출결의 로그 테이블 - 메세지 형 변환 */
ALTER TABLE `t_expend_log` CHANGE `message` `message` TEXT NOT NULL COMMENT 'log 메시지'; 

/* 2018. 02. 20. */
/* 2018. 02. 20. - 신재호 */
/* 2018. 02. 20. - 신재호 - 세금계산서 이관 테이블 */
CREATE TABLE IF NOT EXISTS `t_ex_etax_transfer` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '회사SEQ',
  `iss_no` VARCHAR(32) NOT NULL COMMENT '세금계산서번호',
  `iss_dt` VARCHAR(8) NOT NULL COMMENT '계산서발행일자',
  `partner_no` VARCHAR(32) NOT NULL COMMENT '공급자 사업자등록번호',
  `partner_name` VARCHAR(128) NOT NULL COMMENT '공급자 명',
  `amt` DECIMAL(19,0) NOT NULL COMMENT '세금계산서 금액',
  `transfer_seq` VARCHAR(32) NOT NULL COMMENT '이관 한 사원 번호',
  `transfer_name` VARCHAR(128) DEFAULT NULL COMMENT '이관 한 사원 이름',
  `receive_seq` VARCHAR(32) NOT NULL COMMENT '이관 받은 사원 번호',
  `receive_name` VARCHAR(128) DEFAULT NULL COMMENT '이관 받은 사원 이름',
  `supper_key` VARCHAR(128) DEFAULT NULL COMMENT '조직도팝업 슈퍼키',
  `create_date` DATETIME DEFAULT NULL COMMENT '이관일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

/* 2018. 02. 20. */
/* 2018. 02. 20. - 신재호 */
/* 2018. 02. 20. - 신재호 - 이관 로그 테이블 */
CREATE TABLE IF NOT EXISTS `t_ex_transfer_log` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사SEQ',
  `interface_type` VARCHAR(32) NOT NULL COMMENT 'interface타입(card,etax)',
  `interface_key` VARCHAR(32) NOT NULL COMMENT '카드승인번호/세금계산서번호',
  `transfer_cancel_yn` VARCHAR(1) NOT NULL COMMENT '이관취소여부(Y:취소,N:이관)',
  `transfer_seq` VARCHAR(32) NOT NULL COMMENT '이관 한 사용자',
  `receive_seq` VARCHAR(32) NOT NULL COMMENT '이관 받은 사용자',
  `create_seq` VARCHAR(32) NOT NULL COMMENT '이관/이관취소자',
  `create_date` DATETIME NOT NULL COMMENT '이관/이관취소일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_summary` ADD IF NOT EXISTS `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';

ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `erp_auth_code` VARCHAR(64) DEFAULT NULL COMMENT 'ERP 증빙 코드 ( ERP 정보 / ERPiU / iCUBE )';
ALTER TABLE `t_ex_expend_summary` ADD IF NOT EXISTS `erp_auth_name` VARCHAR(128) DEFAULT NULL COMMENT 'ERP 증빙 명칭 ( ERP 정보 / ERPiU / iCUBE )';

/* 2018. 04. 03. */
/* 2018. 04. 03. - 신재호 */
/* 2018. 04. 03. - 신재호 - CMS 동기화 테이블 변경 */
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `server_ip` VARCHAR(20) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '서버IP(다중서버일 경우를 위해)' AFTER `create_date`;

ALTER TABLE `t_ex_expend_auth` ADD IF NOT EXISTS `no_cash` VARCHAR(9) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '현금승인번호(ERPiU전용)' AFTER `etax_send_yn`; 

/* 2018. 06. 21. */
/* 2018. 06. 21. - 김상겸 */
/* 2018. 06. 21. - 김상겸 - TABLE 엔진 변경 */
ALTER TABLE `t_ex_entertainment` ENGINE=INNODB;
ALTER TABLE `t_ex_etax_transfer` ENGINE=INNODB;
ALTER TABLE `t_ex_ezbaro_code_param` ENGINE=INNODB;
ALTER TABLE `t_ex_ezbaro_erp_master` ENGINE=INNODB;
ALTER TABLE `t_ex_ezbaro_erp_slave` ENGINE=INNODB;
ALTER TABLE `t_ex_ezbaro_gw_master` ENGINE=INNODB;
ALTER TABLE `t_ex_ezbaro_gw_slave` ENGINE=INNODB;
ALTER TABLE `t_ex_transfer_log` ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS `t_ex_card_transfer` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사SEQ' AFTER `seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `sync_id` BIGINT(20) NULL COMMENT '카드 승인 내역 고유 키' AFTER `comp_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `card_num` VARCHAR(16) NULL COMMENT '카드번호' AFTER `sync_id`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `auth_num` VARCHAR(20) NULL COMMENT '카드승인번호' AFTER `card_num`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `auth_date` CHAR(8) NULL COMMENT '승인일자' AFTER `auth_num`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `auth_time` CHAR(6) NULL COMMENT '승인시간' AFTER `auth_date`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `partner_no` VARCHAR(32) NULL COMMENT '공급자 사업자등록번호' AFTER `auth_time`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `partner_name` VARCHAR(128) NULL COMMENT '공급자 명' AFTER `partner_no`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `amt` DECIMAL(19,0) NULL COMMENT '세금계산서 금액' AFTER `partner_name`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `transfer_seq` VARCHAR(32) NULL COMMENT '이관 한 사원 번호' AFTER `amt`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `transfer_name` VARCHAR(128) NULL COMMENT '이관 한 사원 이름' AFTER `transfer_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `receive_seq` VARCHAR(32) NULL COMMENT '이관 받은 사원 번호' AFTER `transfer_name`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `receive_name` VARCHAR(128) NULL COMMENT '이관 받은 사원 이름' AFTER `receive_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(2)  DEFAULT 'Y' COMMENT '사용 여부 ( 사용 : Y / 미사용 : N )' AFTER `receive_name`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `use_yn_emp_seq` VARCHAR(32) NULL COMMENT '사용 여부 설정 사용자 시퀀스' AFTER `use_yn`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `supper_key` VARCHAR(32) NULL COMMENT '조직도팝업 슈퍼키' AFTER `use_yn_emp_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `create_date` DATETIME NULL COMMENT '이관일자' AFTER `supper_key`;

/* 2017. 12. 14. */
/* 2017. 12. 14. - 박용욱 */
/* 2017. 12. 14. - 박용욱 - 지출결의(영리) 금액 자동계산 값 컬럼 추가 */
ALTER TABLE `t_ex_expend_list` ADD IF NOT EXISTS `auto_calc_yn` CHAR(1) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '금액자동계산체크여부(Y/N)';

/* 2017. 12. 14. */
/* 2017. 12. 14. - 임헌용 */
/* 2017. 12. 14. - 임헌용 - 이지바로 테이블 추가 */
CREATE TABLE IF NOT EXISTS `t_ex_ezbaro_code_param` (
  `param_seq` INT(11) NOT NULL AUTO_INCREMENT,
  `CO_CD` VARCHAR(20) DEFAULT NULL,
  `master_seq` INT(11) DEFAULT NULL,
  `LANGKIND` VARCHAR(20) DEFAULT NULL,
  `group_key` VARCHAR(20) DEFAULT NULL,
  `PRJNO` VARCHAR(20) DEFAULT NULL,
  `OFCODE` VARCHAR(20) DEFAULT NULL,
  `BIZGRP` VARCHAR(20) DEFAULT NULL,
  `CODEDIV` VARCHAR(20) DEFAULT NULL,
  `BMCODE` VARCHAR(20) DEFAULT NULL,
  `P_HELP_TY` VARCHAR(20) DEFAULT NULL,
  `P_CODE` VARCHAR(20) DEFAULT NULL,
  `P_CODE2` VARCHAR(20) DEFAULT NULL,
  `P_CODE3` VARCHAR(20) DEFAULT NULL,
  `P_USE_YN` VARCHAR(20) DEFAULT NULL,
  `P_NAME` VARCHAR(20) DEFAULT NULL,
  `P_STD_DT` VARCHAR(20) DEFAULT NULL,
  `P_WHERE` VARCHAR(20) DEFAULT NULL,
  `RESPERSONNO` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`param_seq`)
) ENGINE=INNODB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_ezbaro_erp_master` (
  `erp_master_seq` INT(11) NOT NULL AUTO_INCREMENT,
  `master_seq` INT(11) NOT NULL,
  `group_key` VARCHAR(50) DEFAULT NULL,
  `LANGKIND` VARCHAR(20) DEFAULT NULL,
  `CO_CD` VARCHAR(20) NOT NULL,
  `TASK_DT` VARCHAR(20) NOT NULL,
  `TASK_SQ` VARCHAR(20) NOT NULL,
  `OFCODE` VARCHAR(20) DEFAULT NULL,
  `PRJNO` VARCHAR(20) DEFAULT NULL,
  `EXECDATE` VARCHAR(20) DEFAULT NULL,
  `REGNO` VARCHAR(20) DEFAULT NULL,
  `DIV_CD` VARCHAR(20) DEFAULT NULL,
  `DEPT_CD` VARCHAR(20) DEFAULT NULL,
  `EMP_CD` VARCHAR(20) DEFAULT NULL,
  `EXECTIME` VARCHAR(20) DEFAULT NULL,
  `EXECSEQ` VARCHAR(20) DEFAULT NULL,
  `BIZGRP` VARCHAR(20) DEFAULT NULL,
  `BMCODE` VARCHAR(20) DEFAULT NULL,
  `EXECREQDIV` VARCHAR(20) DEFAULT NULL,
  `EXECDIV` VARCHAR(20) DEFAULT NULL,
  `EXECMTD` VARCHAR(20) DEFAULT NULL,
  `RESOLNO` VARCHAR(20) DEFAULT NULL,
  `RESOLDATE` VARCHAR(20) DEFAULT NULL,
  `CONT` VARCHAR(20) DEFAULT NULL,
  `BELONG` VARCHAR(20) DEFAULT NULL,
  `NM` VARCHAR(20) DEFAULT NULL,
  `RESPERSONNO` VARCHAR(20) DEFAULT NULL,
  `POSI` VARCHAR(20) DEFAULT NULL,
  `PAYYYMM` VARCHAR(20) DEFAULT NULL,
  `PARTRATE` VARCHAR(20) DEFAULT NULL,
  `PAYBASEAMT` VARCHAR(20) DEFAULT NULL,
  `RESOLAMT` VARCHAR(20) DEFAULT NULL,
  `EXTTAX` VARCHAR(20) DEFAULT NULL,
  `ACCREGAMT` VARCHAR(20) DEFAULT NULL,
  `COURTAMT` VARCHAR(20) DEFAULT NULL,
  `CHARGE` VARCHAR(20) DEFAULT NULL,
  `EXECBANK` VARCHAR(20) DEFAULT NULL,
  `EXECREQACCNO` VARCHAR(20) DEFAULT NULL,
  `ACCOWNER` VARCHAR(20) DEFAULT NULL,
  `EXECRECIP` VARCHAR(20) DEFAULT NULL,
  `EXECREQFLAG` VARCHAR(20) DEFAULT NULL,
  `TAXAPPRNO` VARCHAR(20) DEFAULT NULL,
  `SUPPERSON` VARCHAR(20) DEFAULT NULL,
  `SUPBIZNO` VARCHAR(20) DEFAULT NULL,
  `MEETSDT` VARCHAR(20) DEFAULT NULL,
  `MEETEDT` VARCHAR(20) DEFAULT NULL,
  `MEETPLACE` VARCHAR(20) DEFAULT NULL,
  `CONSIORG` VARCHAR(20) DEFAULT NULL,
  `BIZNO` VARCHAR(20) DEFAULT NULL,
  `SENDYN` VARCHAR(20) DEFAULT NULL,
  `SENDOPT` VARCHAR(20) DEFAULT NULL,
  `SENDDATE` VARCHAR(20) DEFAULT NULL,
  `SENDTIME` VARCHAR(20) DEFAULT NULL,
  `STATECODE` VARCHAR(20) DEFAULT NULL,
  `STATETEXT` VARCHAR(20) DEFAULT NULL,
  `RCVDATE` VARCHAR(20) DEFAULT NULL,
  `RCVTIME` VARCHAR(20) DEFAULT NULL,
  `RESOLCHKNO` VARCHAR(20) DEFAULT NULL,
  `RESOLCHKTXT` VARCHAR(20) DEFAULT NULL,
  `ORIGRESOLNO` VARCHAR(20) DEFAULT NULL,
  `CHECKDATE` VARCHAR(20) DEFAULT NULL,
  `CHECKUSER` VARCHAR(20) DEFAULT NULL,
  `TRNSDATE` VARCHAR(20) DEFAULT NULL,
  `TRNSTIME` VARCHAR(20) DEFAULT NULL,
  `TRNSBANK` VARCHAR(20) DEFAULT NULL,
  `TRNSACCNO` VARCHAR(20) DEFAULT NULL,
  `TRNSACCOWNER` VARCHAR(20) DEFAULT NULL,
  `RECIP` VARCHAR(20) DEFAULT NULL,
  `TRNSAMT` VARCHAR(20) DEFAULT NULL,
  `CARDNO` VARCHAR(20) DEFAULT NULL,
  `TRSEQ` VARCHAR(20) DEFAULT NULL,
  `TRDATE` VARCHAR(20) DEFAULT NULL,
  `APPRNO` VARCHAR(20) DEFAULT NULL,
  `GISU_DT` VARCHAR(20) DEFAULT NULL,
  `GISU_SQ` VARCHAR(20) DEFAULT NULL,
  `PJT_CD` VARCHAR(20) DEFAULT NULL,
  `ABGT_CD` VARCHAR(20) DEFAULT NULL,
  `TR_FG` VARCHAR(20) DEFAULT NULL,
  `TR_CD` VARCHAR(20) DEFAULT NULL,
  `CTR_CD` VARCHAR(20) DEFAULT NULL,
  `CTR_NM` VARCHAR(20) DEFAULT NULL,
  `ETCRVRS_YM` VARCHAR(20) DEFAULT NULL,
  `ETCDIV_CD` VARCHAR(20) DEFAULT NULL,
  `ETCDUMMY1` VARCHAR(20) DEFAULT NULL,
  `NDEP_AM` VARCHAR(20) DEFAULT NULL,
  `INAD_AM` VARCHAR(20) DEFAULT NULL,
  `INTX_AM` VARCHAR(20) DEFAULT NULL,
  `RSTX_AM` VARCHAR(20) DEFAULT NULL,
  `WD_AM` VARCHAR(20) DEFAULT NULL,
  `BG_SQ` VARCHAR(20) DEFAULT NULL,
  `ETCPAY_DT` VARCHAR(20) DEFAULT NULL,
  `ET_YN` VARCHAR(20) DEFAULT NULL,
  `ETCDATA_CD` VARCHAR(20) DEFAULT NULL,
  `ETCTAX_RT` VARCHAR(20) DEFAULT NULL,
  `HIFE_AM` VARCHAR(20) DEFAULT NULL,
  `NAPE_AM` VARCHAR(20) DEFAULT NULL,
  `DDCT_AM` VARCHAR(20) DEFAULT NULL,
  `NOIN_AM` VARCHAR(20) DEFAULT NULL,
  `WD_AM2` VARCHAR(20) DEFAULT NULL,
  `ETCRATE` VARCHAR(20) DEFAULT NULL,
  `HINCOME_SQ` VARCHAR(20) DEFAULT NULL,
  `PYTP_FG` VARCHAR(20) DEFAULT NULL,
  `GW_STATE` VARCHAR(20) DEFAULT NULL,
  `GW_ID` VARCHAR(20) DEFAULT NULL,
  `BTR_CD` VARCHAR(20) DEFAULT NULL,
  `RMK_DC` VARCHAR(20) DEFAULT NULL,
  `TAX_TY` VARCHAR(20) DEFAULT NULL,
  `TR_NM` VARCHAR(20) DEFAULT NULL,
  `ETCDUMMY2` VARCHAR(20) DEFAULT NULL,
  `TAX_YN` VARCHAR(1) DEFAULT NULL,
  PRIMARY KEY (`erp_master_seq`),
  KEY `master_seq` (`master_seq`),
  KEY `seq` (`erp_master_seq`)
) ENGINE=INNODB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_ezbaro_erp_slave` (
  `erp_slave_seq` INT(11) NOT NULL AUTO_INCREMENT,
  `erp_master_seq` INT(11) NOT NULL,
  `master_seq` INT(11) NOT NULL,
  `group_key` VARCHAR(50) DEFAULT NULL,
  `LANGKIND` VARCHAR(20) DEFAULT NULL,
  `CO_CD` VARCHAR(20) NOT NULL,
  `TASK_DT` VARCHAR(20) NOT NULL,
  `TASK_SQ` VARCHAR(20) NOT NULL,
  `REGSEQ` VARCHAR(20) DEFAULT NULL,
  `OFCODE` VARCHAR(20) DEFAULT NULL,
  `PRJNO` VARCHAR(20) DEFAULT NULL,
  `EXECDATE` VARCHAR(20) DEFAULT NULL,
  `REGNO` VARCHAR(20) DEFAULT NULL,
  `ARTDIV` VARCHAR(20) DEFAULT NULL,
  `ITEMNAME` VARCHAR(20) DEFAULT NULL,
  `STANDARD` VARCHAR(20) DEFAULT NULL,
  `AMOUNT` VARCHAR(20) DEFAULT NULL,
  `UNITCOST` VARCHAR(20) DEFAULT NULL,
  `SUPCOST` VARCHAR(20) DEFAULT NULL,
  `EXECREQDIV` VARCHAR(20) DEFAULT NULL,
  `EXTTAX` VARCHAR(20) DEFAULT NULL,
  `TOTPURCHAMT` VARCHAR(20) DEFAULT NULL,
  `NTISREGNO` VARCHAR(20) DEFAULT NULL,
  `NTISREGDATE` VARCHAR(20) DEFAULT NULL,
  `CHECKDATE` VARCHAR(20) DEFAULT NULL,
  `CHECKUSER` VARCHAR(20) DEFAULT NULL,
  `GISU_DT` VARCHAR(20) DEFAULT NULL,
  `GISU_SQ` VARCHAR(20) DEFAULT NULL,
  `INSERT_ID` VARCHAR(20) DEFAULT NULL,
  `INSERT_DT` VARCHAR(20) DEFAULT NULL,
  `INSERT_IP` VARCHAR(20) DEFAULT NULL,
  `MODIFY_ID` VARCHAR(20) DEFAULT NULL,
  `MODIFY_DT` VARCHAR(20) DEFAULT NULL,
  `MODIFY_IP` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`erp_slave_seq`,`CO_CD`,`TASK_DT`,`TASK_SQ`),
  KEY `seq` (`erp_slave_seq`)
) ENGINE=INNODB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_ezbaro_gw_master` (
  `gw_master_seq` INT(11) NOT NULL AUTO_INCREMENT,
  `master_seq` INT(11) NOT NULL,
  `cheju` VARCHAR(20) DEFAULT NULL,
  `group_key` VARCHAR(50) DEFAULT NULL,
  `TASK_DT` VARCHAR(20) DEFAULT NULL,
  `TASK_SQ` VARCHAR(20) DEFAULT NULL,
  `CO_CD` VARCHAR(20) DEFAULT NULL,
  `project` VARCHAR(100) DEFAULT NULL,
  `bmcode` VARCHAR(100) DEFAULT NULL,
  `use` VARCHAR(20) DEFAULT NULL,
  `G20Project` VARCHAR(100) DEFAULT NULL,
  `G20abgt` VARCHAR(20) DEFAULT NULL,
  `execmtd` VARCHAR(20) DEFAULT NULL,
  `execreqdiv` VARCHAR(20) DEFAULT NULL,
  `inoutaccount` VARCHAR(20) DEFAULT NULL,
  `resoldate` VARCHAR(20) DEFAULT NULL,
  `partnergbn` VARCHAR(20) DEFAULT NULL,
  `partner` VARCHAR(20) DEFAULT NULL,
  `cardnum` VARCHAR(20) DEFAULT NULL,
  `aprovNum` VARCHAR(20) DEFAULT NULL,
  `serialNum` VARCHAR(20) DEFAULT NULL,
  `trdate` VARCHAR(20) DEFAULT NULL,
  `posi` VARCHAR(20) DEFAULT NULL,
  `belong` VARCHAR(20) DEFAULT NULL,
  `nm` VARCHAR(20) DEFAULT NULL,
  `entrant` VARCHAR(20) DEFAULT NULL,
  `bank` VARCHAR(20) DEFAULT NULL,
  `bankaccount` VARCHAR(20) DEFAULT NULL,
  `accholder` VARCHAR(20) DEFAULT NULL,
  `recip` VARCHAR(20) DEFAULT NULL,
  `paybaseamt` VARCHAR(20) DEFAULT NULL,
  `taxapprno` VARCHAR(20) DEFAULT NULL,
  `supperson` VARCHAR(20) DEFAULT NULL,
  `supbizno` VARCHAR(20) DEFAULT NULL,
  `meetstd` VARCHAR(20) DEFAULT NULL,
  `meetetd` VARCHAR(20) DEFAULT NULL,
  `meetplace` VARCHAR(20) DEFAULT NULL,
  `bigo` VARCHAR(20) DEFAULT NULL,
  `consiorg` VARCHAR(20) DEFAULT NULL,
  `bizno` VARCHAR(20) DEFAULT NULL,
  `resolamt` VARCHAR(20) DEFAULT NULL,
  `taxamt` VARCHAR(20) DEFAULT NULL,
  `resolnote` VARCHAR(500) DEFAULT NULL,
  `supplyamt` VARCHAR(20) DEFAULT NULL,
  `group_class` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`gw_master_seq`)
) ENGINE=INNODB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_ezbaro_gw_slave` (
  `gw_slave_seq` INT(11) NOT NULL AUTO_INCREMENT,
  `master_seq` INT(11) NOT NULL,
  `gw_master_seq` INT(11) NOT NULL,
  `group_key` VARCHAR(20) DEFAULT NULL,
  `TASK_DT` VARCHAR(20) DEFAULT NULL,
  `TASK_SQ` VARCHAR(20) DEFAULT NULL,
  `CO_CD` VARCHAR(20) DEFAULT NULL,
  `rownum` VARCHAR(20) DEFAULT NULL,
  `item` VARCHAR(20) DEFAULT NULL,
  `standard` VARCHAR(20) DEFAULT NULL,
  `amount` VARCHAR(20) DEFAULT NULL,
  `unitprice` VARCHAR(20) DEFAULT NULL,
  `itemsupplyamt` VARCHAR(20) DEFAULT NULL,
  `itemtaxamt` VARCHAR(20) DEFAULT NULL,
  `itemtotalamt` VARCHAR(20) DEFAULT NULL,
  `itemgbn` VARCHAR(20) DEFAULT NULL,
  `ntisregdt` VARCHAR(20) DEFAULT NULL,
  `ntisregno` VARCHAR(20) DEFAULT NULL,
  `specialist` VARCHAR(20) DEFAULT NULL,
  `itementrant` VARCHAR(20) DEFAULT NULL,
  `purposebiztrip` VARCHAR(20) DEFAULT NULL,
  `biztripstdt` VARCHAR(20) DEFAULT NULL,
  `biztripendt` VARCHAR(20) DEFAULT NULL,
  `biztripsttime` VARCHAR(20) DEFAULT NULL,
  `biztripentime` VARCHAR(20) DEFAULT NULL,
  `stplace` VARCHAR(20) DEFAULT NULL,
  `enplace` VARCHAR(20) DEFAULT NULL,
  `inoutgbn` VARCHAR(20) DEFAULT NULL,
  `belonggbn` VARCHAR(20) DEFAULT NULL,
  `peopleregno` VARCHAR(20) DEFAULT NULL,
  `overtimeworker` VARCHAR(20) DEFAULT NULL,
  `overworkstdt` VARCHAR(20) DEFAULT NULL,
  `overworkendt` VARCHAR(20) DEFAULT NULL,
  `overworksttime` VARCHAR(20) DEFAULT NULL,
  `overworkentime` VARCHAR(20) DEFAULT NULL,
  `belongbizno` VARCHAR(20) DEFAULT NULL,
  `entnm` VARCHAR(20) DEFAULT NULL,
  `educator` VARCHAR(20) DEFAULT NULL,
  `eduorgnm` VARCHAR(20) DEFAULT NULL,
  `edustdt` VARCHAR(20) DEFAULT NULL,
  `eduendt` VARCHAR(20) DEFAULT NULL,
  `edusttime` VARCHAR(20) DEFAULT NULL,
  `eduentime` VARCHAR(20) DEFAULT NULL,
  `useplace` VARCHAR(20) DEFAULT NULL,
  `usestdt` VARCHAR(20) DEFAULT NULL,
  `useendt` VARCHAR(20) DEFAULT NULL,
  `usesttime` VARCHAR(20) DEFAULT NULL,
  `useentime` VARCHAR(20) DEFAULT NULL,
  `usemethod` VARCHAR(20) DEFAULT NULL,
  `amt` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`gw_slave_seq`)
) ENGINE=INNODB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_ex_ezbaro_master` (
  `master_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '테이블 시퀀스',
  `doc_seq` INT(11) DEFAULT '0' COMMENT '이지바로 전자결재 키',
  `doc_sts` INT(11) DEFAULT '0' COMMENT '결재상태값',
  `erp_send_yn` CHAR(1) DEFAULT 'N' COMMENT '전송여부',
  `comp_seq` INT(11) DEFAULT '0' COMMENT '회사코드',
  `erp_co_cd` INT(11) DEFAULT NULL COMMENT 'erp회사코드(작성자기준)',
  `create_seq` INT(11) DEFAULT '0' COMMENT '생성자',
  `modify_seq` INT(11) DEFAULT NULL COMMENT '수정자',
  `create_date` DATETIME DEFAULT NULL COMMENT '생성일',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일',
  `use_yn` VARCHAR(1) DEFAULT NULL COMMENT '사용여부',
  PRIMARY KEY (`master_seq`),
  KEY `seq` (`master_seq`)
) ENGINE=INNODB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8;

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - G20 테이블 추가 */

/* CREATE `g20_abdocu_h` */
CREATE TABLE IF NOT EXISTS `g20_abdocu_h` (
  `abdocu_no` BIGINT(38) NOT NULL,
  `c_dikeycode` VARCHAR(32) DEFAULT NULL,
  `sanction_no` VARCHAR(100) DEFAULT NULL,
  `docu_mode` INT(38) DEFAULT NULL,
  `abdocu_no_reffer` BIGINT(38) DEFAULT '0',
  `sessionid` VARCHAR(100) DEFAULT NULL,
  `mgt_cd` VARCHAR(10) DEFAULT NULL,
  `mgt_nm` VARCHAR(1000) DEFAULT NULL,
  `docu_fg` VARCHAR(1) DEFAULT NULL,
  `docu_fg_text` VARCHAR(100) DEFAULT NULL,
  `rmk_dc` VARCHAR(100) DEFAULT NULL,
  `erp_co_cd` VARCHAR(4) DEFAULT NULL,
  `erp_gisu_dt` VARCHAR(8) DEFAULT NULL,
  `erp_gisu_sq` INT(38) DEFAULT '0',
  `erp_emp_cd` VARCHAR(10) DEFAULT NULL,
  `erp_emp_nm` VARCHAR(100) DEFAULT NULL,
  `erp_div_cd` VARCHAR(4) DEFAULT NULL,
  `erp_div_nm` VARCHAR(100) DEFAULT NULL,
  `erp_dept_cd` VARCHAR(4) DEFAULT NULL,
  `erp_dept_nm` VARCHAR(100) DEFAULT NULL,
  `erp_gisu` INT(38) DEFAULT NULL,
  `erp_gisu_from_dt` VARCHAR(8) DEFAULT NULL,
  `erp_gisu_to_dt` VARCHAR(8) DEFAULT NULL,
  `erp_year` VARCHAR(4) DEFAULT NULL,
  `btr_cd` VARCHAR(10) DEFAULT NULL,
  `btr_nm` VARCHAR(100) DEFAULT NULL,
  `bottom_cd` VARCHAR(10) DEFAULT NULL,
  `bottom_nm` VARCHAR(100) DEFAULT NULL,
  `edit_proc` INT(38) DEFAULT '100',
  `insert_id` VARCHAR(100) DEFAULT NULL,
  `insert_dt` DATE DEFAULT NULL,
  `modify_id` VARCHAR(100) DEFAULT NULL,
  `modify_dt` DATE DEFAULT NULL,
  `btr_nb` VARCHAR(50) DEFAULT NULL,
  `cause_dt` VARCHAR(8) DEFAULT NULL,
  `sign_dt` VARCHAR(8) DEFAULT NULL,
  `inspect_dt` VARCHAR(8) DEFAULT NULL,
  `cause_id` VARCHAR(10) DEFAULT NULL,
  `cause_nm` VARCHAR(40) DEFAULT NULL,
  `complete_yn` CHAR(1) DEFAULT NULL,
  `hc_nm` VARCHAR(100) DEFAULT NULL,
  `hc_cd` VARCHAR(100) DEFAULT NULL,
  `it_businesslink` VARCHAR(10) DEFAULT NULL,
  `support_money` VARCHAR(10) DEFAULT NULL,
  `kulsudancheckcardyn` VARCHAR(10) DEFAULT NULL,
  `erp_co_nm` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`abdocu_no`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* ALTER `g20_abdocu_h` ADD COLUMN */
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `sanction_no` VARCHAR(100) DEFAULT NULL AFTER `c_dikeycode`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `docu_mode` INT(38) DEFAULT NULL AFTER `sanction_no`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `abdocu_no_reffer` BIGINT(38) DEFAULT '0' AFTER `docu_mode`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL AFTER `abdocu_no_reffer`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `mgt_cd` VARCHAR(10) DEFAULT NULL AFTER `sessionid`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `mgt_nm` VARCHAR(1000) DEFAULT NULL AFTER `mgt_cd`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `docu_fg` VARCHAR(1) DEFAULT NULL AFTER `mgt_nm`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `docu_fg_text` VARCHAR(100) DEFAULT NULL AFTER `docu_fg`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `rmk_dc` VARCHAR(100) DEFAULT NULL AFTER `docu_fg_text`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL AFTER `rmk_dc`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu_dt` VARCHAR(8) DEFAULT NULL AFTER `erp_co_cd`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` INT(38) DEFAULT '0' AFTER `erp_gisu_dt`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_emp_cd` VARCHAR(10) DEFAULT NULL AFTER `erp_gisu_sq`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_emp_nm` VARCHAR(100) DEFAULT NULL AFTER `erp_emp_cd`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_div_cd` VARCHAR(4) DEFAULT NULL AFTER `erp_emp_nm`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_div_nm` VARCHAR(100) DEFAULT NULL AFTER `erp_div_cd`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_dept_cd` VARCHAR(4) DEFAULT NULL AFTER `erp_div_nm`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_dept_nm` VARCHAR(100) DEFAULT NULL AFTER `erp_dept_cd`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu` INT(38) DEFAULT NULL AFTER `erp_dept_nm`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu_from_dt` VARCHAR(8) DEFAULT NULL AFTER `erp_gisu`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_gisu_to_dt` VARCHAR(8) DEFAULT NULL AFTER `erp_gisu_from_dt`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_year` VARCHAR(4) DEFAULT NULL AFTER `erp_gisu_to_dt`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `btr_cd` VARCHAR(10) DEFAULT NULL AFTER `erp_year`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `btr_nm` VARCHAR(100) DEFAULT NULL AFTER `btr_cd`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `bottom_cd` VARCHAR(10) DEFAULT NULL AFTER `btr_nm`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `bottom_nm` VARCHAR(100) DEFAULT NULL AFTER `bottom_cd`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `edit_proc` INT(38) DEFAULT '100' AFTER `bottom_nm`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(100) DEFAULT NULL AFTER `edit_proc`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `insert_dt` DATE DEFAULT NULL AFTER `insert_id`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL AFTER `insert_dt`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `modify_dt` DATE DEFAULT NULL AFTER `modify_id`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `btr_nb` VARCHAR(50) DEFAULT NULL AFTER `modify_dt`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `cause_dt` VARCHAR(8) DEFAULT NULL AFTER `btr_nb`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `sign_dt` VARCHAR(8) DEFAULT NULL AFTER `cause_dt`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `inspect_dt` VARCHAR(8) DEFAULT NULL AFTER `sign_dt`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `cause_id` VARCHAR(10) DEFAULT NULL AFTER `inspect_dt`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `cause_nm` VARCHAR(40) DEFAULT NULL AFTER `cause_id`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `complete_yn` CHAR(1) DEFAULT NULL AFTER `cause_nm`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `hc_nm` VARCHAR(100) DEFAULT NULL AFTER `complete_yn`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `hc_cd` VARCHAR(100) DEFAULT NULL AFTER `hc_nm`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `it_businesslink` VARCHAR(10) DEFAULT NULL AFTER `hc_cd`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `support_money` VARCHAR(10) DEFAULT NULL AFTER `it_businesslink`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `kulsudancheckcardyn` VARCHAR(10) DEFAULT NULL AFTER `support_money`;
ALTER TABLE `g20_abdocu_h` ADD COLUMN IF NOT EXISTS `erp_co_nm` VARCHAR(100) DEFAULT NULL AFTER `kulsudancheckcardyn`;

/* CREATE `g20_abdocu_b` */
CREATE TABLE IF NOT EXISTS `g20_abdocu_b` (
  `abdocu_b_no` bigint(38) NOT NULL,
  `abdocu_no` bigint(38) DEFAULT NULL,
  `docu_mode` int(38) DEFAULT NULL,
  `abdocu_no_reffer` bigint(38) DEFAULT NULL,
  `erp_co_cd` varchar(4) NOT NULL,
  `erp_gisu_dt` varchar(8) DEFAULT NULL,
  `erp_gisu_sq` int(38) DEFAULT NULL,
  `erp_bq_sq` int(38) DEFAULT NULL,
  `erp_bk_sq` int(5) DEFAULT NULL,
  `erp_bgt_nm1` varchar(50) DEFAULT NULL,
  `erp_bgt_nm2` varchar(50) DEFAULT NULL,
  `erp_bgt_nm3` varchar(50) DEFAULT NULL,
  `erp_bgt_nm4` varchar(50) DEFAULT NULL,
  `open_am` int(19) DEFAULT NULL,
  `apply_am` int(19) DEFAULT NULL,
  `left_am` int(19) DEFAULT NULL,
  `abgt_cd` varchar(10) DEFAULT NULL,
  `abgt_nm` varchar(40) DEFAULT NULL,
  `set_fg` varchar(1) DEFAULT NULL,
  `vat_fg` varchar(1) DEFAULT NULL,
  `tr_fg` varchar(1) DEFAULT NULL,
  `div_cd2` varchar(4) DEFAULT NULL,
  `div_nm2` varchar(20) DEFAULT NULL,
  `ctl_fg` varchar(1) DEFAULT NULL,
  `insert_id` varchar(100) DEFAULT NULL,
  `insert_dt` date DEFAULT NULL,
  `modify_id` varchar(100) DEFAULT NULL,
  `modify_dt` date DEFAULT NULL,
  `sessionid` varchar(50) DEFAULT NULL,
  `rmk_dc` varchar(200) DEFAULT NULL,
  `bank_dt` varchar(8) DEFAULT NULL,
  `bank_sq` int(5) DEFAULT NULL,
  `tran_cd` varchar(3) DEFAULT NULL,
  `it_use_way` varchar(2) DEFAULT NULL,
  `confer_return` varchar(10) DEFAULT NULL,
  `abdocu_b_no_reffer` int(38) DEFAULT NULL,
  `it_sbgtcdlink` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`abdocu_b_no`),
  KEY `idx_g20_abdocu_b_bgt_cd` (`abdocu_no`,`abgt_cd`),
  CONSTRAINT `fk_g20_abdocu_b_g20_abdocu_h` FOREIGN KEY (`abdocu_no`) REFERENCES `g20_abdocu_h` (`abdocu_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `g20_abdocu_b` ADD COLUMN */
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `docu_mode` INT(38) DEFAULT NULL AFTER `abdocu_no`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `abdocu_no_reffer` BIGINT(38) DEFAULT NULL AFTER `docu_mode`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) NOT NULL AFTER `abdocu_no_reffer`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_gisu_dt` VARCHAR(8) DEFAULT NULL AFTER `erp_co_cd`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` INT(38) DEFAULT NULL AFTER `erp_gisu_dt`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bq_sq` INT(38) DEFAULT NULL AFTER `erp_gisu_sq`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bk_sq` INT(5) DEFAULT NULL AFTER `erp_bq_sq`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bgt_nm1` VARCHAR(50) DEFAULT NULL AFTER `erp_bk_sq`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bgt_nm2` VARCHAR(50) DEFAULT NULL AFTER `erp_bgt_nm1`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bgt_nm3` VARCHAR(50) DEFAULT NULL AFTER `erp_bgt_nm2`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `erp_bgt_nm4` VARCHAR(50) DEFAULT NULL AFTER `erp_bgt_nm3`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `open_am` INT(19) DEFAULT NULL AFTER `erp_bgt_nm4`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `apply_am` INT(19) DEFAULT NULL AFTER `open_am`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `left_am` INT(19) DEFAULT NULL AFTER `apply_am`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `abgt_cd` VARCHAR(10) DEFAULT NULL AFTER `left_am`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `abgt_nm` VARCHAR(40) DEFAULT NULL AFTER `abgt_cd`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `set_fg` VARCHAR(1) DEFAULT NULL AFTER `abgt_nm`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `vat_fg` VARCHAR(1) DEFAULT NULL AFTER `set_fg`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `tr_fg` VARCHAR(1) DEFAULT NULL AFTER `vat_fg`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `div_cd2` VARCHAR(4) DEFAULT NULL AFTER `tr_fg`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `div_nm2` VARCHAR(20) DEFAULT NULL AFTER `div_cd2`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `ctl_fg` VARCHAR(1) DEFAULT NULL AFTER `div_nm2`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(100) DEFAULT NULL AFTER `ctl_fg`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `insert_dt` DATE DEFAULT NULL AFTER `insert_id`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL AFTER `insert_dt`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `modify_dt` DATE DEFAULT NULL AFTER `modify_id`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(50) DEFAULT NULL AFTER `modify_dt`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `rmk_dc` VARCHAR(200) DEFAULT NULL AFTER `sessionid`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `bank_dt` VARCHAR(8) DEFAULT NULL AFTER `rmk_dc`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `bank_sq` INT(5) DEFAULT NULL AFTER `bank_dt`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `tran_cd` VARCHAR(3) DEFAULT NULL AFTER `bank_sq`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `it_use_way` VARCHAR(2) DEFAULT NULL AFTER `tran_cd`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `confer_return` VARCHAR(10) DEFAULT NULL AFTER `it_use_way`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `abdocu_b_no_reffer` INT(38) DEFAULT NULL AFTER `confer_return`;
ALTER TABLE `g20_abdocu_b` ADD COLUMN IF NOT EXISTS `it_sbgtcdlink` VARCHAR(10) DEFAULT NULL AFTER `abdocu_b_no_reffer`;

/* CREATE `g20_abdocu_t` */
CREATE TABLE IF NOT EXISTS `g20_abdocu_t` (
  `abdocu_t_no` bigint(38) NOT NULL,
  `abdocu_no` bigint(38) DEFAULT NULL,
  `abdocu_b_no` bigint(38) DEFAULT NULL,
  `abdocu_no_reffer` bigint(38) DEFAULT NULL,
  `docu_mode` int(38) DEFAULT NULL,
  `erp_co_cd` varchar(4) NOT NULL,
  `erp_isu_dt` varchar(8) DEFAULT NULL,
  `erp_isu_sq` int(38) DEFAULT NULL,
  `erp_ln_sq` int(38) DEFAULT '0',
  `erp_bq_sq` int(38) DEFAULT '0',
  `bk_sq2` int(5) DEFAULT NULL,
  `item_nm` varchar(100) DEFAULT NULL,
  `item_cnt` varchar(100) DEFAULT NULL,
  `emp_nm` varchar(100) DEFAULT NULL,
  `tr_cd` varchar(15) DEFAULT NULL,
  `tr_nm` varchar(40) DEFAULT NULL,
  `ceo_nm` varchar(20) DEFAULT NULL,
  `unit_am` int(19) DEFAULT NULL,
  `sup_am` int(19) DEFAULT NULL,
  `vat_am` int(19) DEFAULT NULL,
  `jiro_cd` varchar(10) DEFAULT NULL,
  `jiro_nm` varchar(40) DEFAULT NULL,
  `ba_nb` varchar(40) DEFAULT NULL,
  `btr_cd` varchar(10) DEFAULT NULL,
  `btr_nm` varchar(40) DEFAULT NULL,
  `depositor` varchar(30) DEFAULT NULL,
  `rmk_dc` varchar(80) DEFAULT NULL,
  `ctr_cd` varchar(10) DEFAULT NULL,
  `ctr_nm` varchar(40) DEFAULT NULL,
  `etcrvrs_ym` varchar(6) DEFAULT NULL,
  `ndep_am` int(19) DEFAULT NULL,
  `inad_am` int(19) DEFAULT NULL,
  `intx_am` int(19) DEFAULT NULL,
  `rstx_am` int(19) DEFAULT NULL,
  `ctr_appdt` varchar(8) DEFAULT NULL,
  `reg_nb` varchar(15) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `tr_fg` varchar(100) DEFAULT NULL,
  `tr_fg_nm` varchar(100) DEFAULT NULL,
  `attr_nm` varchar(100) DEFAULT NULL,
  `ppl_nb` varchar(100) DEFAULT NULL,
  `addr` varchar(100) DEFAULT NULL,
  `trcharge_emp` varchar(100) DEFAULT NULL,
  `insert_id` varchar(100) DEFAULT NULL,
  `insert_dt` date DEFAULT NULL,
  `modify_id` varchar(100) DEFAULT NULL,
  `modify_dt` date DEFAULT NULL,
  `sessionid` varchar(50) DEFAULT NULL,
  `edit_proc` int(38) DEFAULT NULL,
  `ref_abin_ln_no` int(38) DEFAULT NULL,
  `tax_dt` varchar(16) DEFAULT NULL,
  `etcdiv_cd` varchar(4) DEFAULT NULL,
  `etcdummy1_nm` varchar(200) DEFAULT NULL,
  `etcdummy1` varchar(20) DEFAULT NULL,
  `cms_name` varchar(60) DEFAULT NULL,
  `bank_dt` varchar(8) DEFAULT NULL,
  `bank_sq` int(5) DEFAULT NULL,
  `bk_sq` int(5) DEFAULT NULL,
  `iss_dt` varchar(8) DEFAULT NULL,
  `iss_sq` int(5) DEFAULT NULL,
  `tran_cd` varchar(3) DEFAULT NULL,
  `link_type` varchar(20) DEFAULT NULL,
  `chain_name` varchar(60) DEFAULT NULL,
  `it_use_dt` varchar(8) DEFAULT NULL,
  `it_use_no` varchar(11) DEFAULT NULL,
  `it_card_no` varchar(16) DEFAULT NULL,
  `et_yn` varchar(1) DEFAULT NULL,
  `wd_am` int(19) DEFAULT NULL,
  `etcdata_cd` varchar(2) DEFAULT NULL,
  `etcrate` varchar(19) DEFAULT NULL,
  `item_am` int(19) DEFAULT NULL,
  `purc_req_no` varchar(13) DEFAULT NULL,
  `purc_req_item_no` varchar(13) DEFAULT NULL,
  `ctr_card_num` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`abdocu_t_no`),
  KEY `abdocu_b_no` (`abdocu_b_no`),
  CONSTRAINT `fk_g20_abdocu_t_g20_abdocu_b` FOREIGN KEY (`abdocu_b_no`) REFERENCES `g20_abdocu_b` (`abdocu_b_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `g20_abdocu_t` ADD COLUMN */
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `abdocu_no_reffer` BIGINT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `docu_mode` INT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) NOT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_ln_sq` INT(38) DEFAULT '0';
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `erp_bq_sq` INT(38) DEFAULT '0';
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `bk_sq2` INT(5) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `item_nm` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `item_cnt` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `emp_nm` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tr_cd` VARCHAR(15) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tr_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ceo_nm` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `unit_am` INT(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `sup_am` INT(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `vat_am` INT(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `jiro_cd` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `jiro_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ba_nb` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `btr_cd` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `btr_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `depositor` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `rmk_dc` VARCHAR(80) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ctr_cd` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ctr_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcrvrs_ym` VARCHAR(6) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ndep_am` INT(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `inad_am` INT(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `intx_am` INT(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `rstx_am` INT(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ctr_appdt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `reg_nb` VARCHAR(15) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tel` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tr_fg` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tr_fg_nm` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `attr_nm` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ppl_nb` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `addr` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `trcharge_emp` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `insert_dt` DATE DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `modify_dt` DATE DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(50) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `edit_proc` INT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ref_abin_ln_no` INT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tax_dt` VARCHAR(16) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcdiv_cd` VARCHAR(4) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcdummy1_nm` VARCHAR(200) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcdummy1` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `cms_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `bank_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `bank_sq` INT(5) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `bk_sq` INT(5) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `iss_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `iss_sq` INT(5) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `tran_cd` VARCHAR(3) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `link_type` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `chain_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `it_use_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `it_use_no` VARCHAR(11) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `it_card_no` VARCHAR(16) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `et_yn` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `wd_am` INT(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcdata_cd` VARCHAR(2) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `etcrate` VARCHAR(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `item_am` INT(19) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `purc_req_no` VARCHAR(13) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `purc_req_item_no` VARCHAR(13) DEFAULT NULL;
ALTER TABLE `g20_abdocu_t` ADD COLUMN IF NOT EXISTS `ctr_card_num` VARCHAR(40) DEFAULT NULL;

/* CREATE `g20_abdocu_th` */
CREATE TABLE IF NOT EXISTS `g20_abdocu_th` (
  `abdocu_no` bigint(38) NOT NULL COMMENT '문서번호',
  `abdocu_th_no` bigint(38) NOT NULL COMMENT '헤더번호',
  `erp_co_cd` varchar(4) DEFAULT NULL COMMENT '회사코드',
  `erp_isu_dt` varchar(8) DEFAULT NULL COMMENT '결의일자',
  `erp_isu_sq` int(38) DEFAULT '0' COMMENT '결의번호',
  `ts_dt` varchar(8) DEFAULT NULL COMMENT '출장시작일',
  `te_dt` varchar(8) DEFAULT NULL COMMENT '출장종료일',
  `tday_cnt` int(30) DEFAULT NULL COMMENT '출장일수',
  `site_nm` varchar(20) DEFAULT NULL COMMENT '출장지',
  `req_nm` varchar(10) DEFAULT NULL COMMENT '청구인성명',
  `scost_am` bigint(17) DEFAULT NULL COMMENT '정산급',
  `ontrip_nm` varchar(40) DEFAULT NULL COMMENT '출장용무',
  `rsv_nm` varchar(10) DEFAULT NULL COMMENT '영수인 성명',
  `site_nmk` varchar(20) DEFAULT NULL COMMENT '출장지(다국어)',
  `ontrip_nmk` varchar(40) DEFAULT NULL COMMENT '출장용무(다국어)',
  `req_nmk` varchar(10) DEFAULT NULL COMMENT '청구인성명(다국어)',
  `rsv_nmk` varchar(10) DEFAULT NULL COMMENT '영수인성명(다국어)',
  `rcost_am` bigint(17) DEFAULT NULL COMMENT '개산급',
  `insert_id` varchar(10) DEFAULT NULL COMMENT '등록자',
  `insert_ip` varchar(15) DEFAULT NULL COMMENT '등록자 ip',
  `insert_dt` datetime DEFAULT NULL COMMENT '등록일자',
  `modify_id` varchar(100) DEFAULT NULL COMMENT '수정자',
  `modify_ip` varchar(15) DEFAULT NULL COMMENT '수정자 ip',
  `modify_dt` datetime DEFAULT NULL COMMENT '수정일자',
  `sessionid` varchar(100) DEFAULT NULL,
  `biztrip_appl_id` int(38) DEFAULT NULL,
  PRIMARY KEY (`abdocu_no`,`abdocu_th_no`),
  UNIQUE KEY `g20_abdocu_th_pk` (`abdocu_no`,`abdocu_th_no`),
  KEY `abdocu_th_no` (`abdocu_th_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `g20_abdocu_th` ADD COLUMN */
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL COMMENT '회사코드';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL COMMENT '결의일자';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT '0' COMMENT '결의번호';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `ts_dt` VARCHAR(8) DEFAULT NULL COMMENT '출장시작일';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `te_dt` VARCHAR(8) DEFAULT NULL COMMENT '출장종료일';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `tday_cnt` INT(30) DEFAULT NULL COMMENT '출장일수';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `site_nm` VARCHAR(20) DEFAULT NULL COMMENT '출장지';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `req_nm` VARCHAR(10) DEFAULT NULL COMMENT '청구인성명';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `scost_am` BIGINT(17) DEFAULT NULL COMMENT '정산급';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `ontrip_nm` VARCHAR(40) DEFAULT NULL COMMENT '출장용무';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `rsv_nm` VARCHAR(10) DEFAULT NULL COMMENT '영수인 성명';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `site_nmk` VARCHAR(20) DEFAULT NULL COMMENT '출장지(다국어)';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `ontrip_nmk` VARCHAR(40) DEFAULT NULL COMMENT '출장용무(다국어)';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `req_nmk` VARCHAR(10) DEFAULT NULL COMMENT '청구인성명(다국어)';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `rsv_nmk` VARCHAR(10) DEFAULT NULL COMMENT '영수인성명(다국어)';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `rcost_am` BIGINT(17) DEFAULT NULL COMMENT '개산급';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(10) DEFAULT NULL COMMENT '등록자';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `insert_ip` VARCHAR(15) DEFAULT NULL COMMENT '등록자 ip';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `insert_dt` DATETIME DEFAULT NULL COMMENT '등록일자';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL COMMENT '수정자';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `modify_ip` VARCHAR(15) DEFAULT NULL COMMENT '수정자 ip';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `modify_dt` DATETIME DEFAULT NULL COMMENT '수정일자';
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_th` ADD COLUMN IF NOT EXISTS `biztrip_appl_id` INT(38) DEFAULT NULL;

/* CREATE `g20_abdocu_td` */
CREATE TABLE IF NOT EXISTS `g20_abdocu_td` (
  `abdocu_no` bigint(38) DEFAULT NULL COMMENT '문서번호',
  `abdocu_td_no` bigint(38) NOT NULL COMMENT '상세번호',
  `erp_co_cd` varchar(4) DEFAULT NULL COMMENT ' 회사코드',
  `erp_isu_dt` varchar(8) DEFAULT NULL COMMENT ' 결의일자',
  `erp_isu_sq` int(38) DEFAULT '0' COMMENT ' 결의번호',
  `erp_ln_sq` int(30) DEFAULT NULL COMMENT '라인순번',
  `jong_nm` varchar(10) DEFAULT NULL COMMENT ' 종별',
  `jkm_cnt` int(17) DEFAULT NULL COMMENT ' 운임거리',
  `jgrade` varchar(3) DEFAULT NULL COMMENT '운임등급',
  `junit_am` int(17) DEFAULT NULL COMMENT '운임단가',
  `jtot_am` int(17) DEFAULT NULL COMMENT '운임총액',
  `jong_nmk` varchar(10) DEFAULT NULL COMMENT '종별(다국어)',
  `memo_cd` varchar(14) DEFAULT NULL COMMENT '메모 cd',
  `check_pen` varchar(20) DEFAULT NULL COMMENT '체크펜',
  `sessionid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`abdocu_td_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `g20_abdocu_td` ADD COLUMN */
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) DEFAULT NULL COMMENT '문서번호';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL COMMENT ' 회사코드';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL COMMENT ' 결의일자';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT '0' COMMENT ' 결의번호';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `erp_ln_sq` INT(30) DEFAULT NULL COMMENT '라인순번';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jong_nm` VARCHAR(10) DEFAULT NULL COMMENT ' 종별';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jkm_cnt` INT(17) DEFAULT NULL COMMENT ' 운임거리';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jgrade` VARCHAR(3) DEFAULT NULL COMMENT '운임등급';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `junit_am` INT(17) DEFAULT NULL COMMENT '운임단가';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jtot_am` INT(17) DEFAULT NULL COMMENT '운임총액';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `jong_nmk` VARCHAR(10) DEFAULT NULL COMMENT '종별(다국어)';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `memo_cd` VARCHAR(14) DEFAULT NULL COMMENT '메모 cd';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `check_pen` VARCHAR(20) DEFAULT NULL COMMENT '체크펜';
ALTER TABLE `g20_abdocu_td` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL;

/* CREATE `g20_abdocu_td2` */
CREATE TABLE IF NOT EXISTS `g20_abdocu_td2` (
  `abdocu_no` bigint(38) NOT NULL COMMENT '문서번호',
  `abdocu_td2_no` bigint(38) NOT NULL COMMENT '헤더번호',
  `erp_co_cd` varchar(4) DEFAULT NULL COMMENT '회사코드',
  `erp_isu_dt` varchar(8) DEFAULT NULL COMMENT '결의일자',
  `erp_isu_sq` int(38) DEFAULT '0' COMMENT '결의번호',
  `erp_ln_sq` int(30) DEFAULT NULL COMMENT '라인순번',
  `emp_nm` varchar(20) DEFAULT NULL COMMENT '사원',
  `dept_nm` varchar(20) DEFAULT NULL COMMENT '부서',
  `class_nm` varchar(20) DEFAULT NULL COMMENT '직위',
  `hcls_nm` varchar(20) DEFAULT NULL COMMENT '직급',
  `trip_dt` varchar(8) DEFAULT NULL COMMENT '출장일자',
  `nt_cnt` int(30) DEFAULT NULL COMMENT '이수',
  `day_cnt` int(30) DEFAULT NULL COMMENT '일수',
  `start_nm` varchar(20) DEFAULT NULL COMMENT '출발지',
  `cross_nm` varchar(20) DEFAULT NULL COMMENT '경유지',
  `arr_nm` varchar(20) DEFAULT NULL COMMENT '도착지',
  `jong_nm` varchar(10) DEFAULT NULL COMMENT '종별',
  `km_am` bigint(17) DEFAULT NULL COMMENT '거리',
  `fair_am` bigint(17) DEFAULT NULL COMMENT '요금',
  `trmk_dc` varchar(20) DEFAULT NULL COMMENT '적요',
  `start_nmk` varchar(20) DEFAULT NULL COMMENT '출발지(다국어)',
  `cross_nmk` varchar(20) DEFAULT NULL COMMENT '경유지(다국어)',
  `arr_nmk` varchar(20) DEFAULT NULL COMMENT '도착지(다국어)',
  `jong_nmk` varchar(10) DEFAULT NULL COMMENT '종별(다국어)',
  `trmk_dck` varchar(20) DEFAULT NULL COMMENT '적요(다국어)',
  `memo_cd` varchar(14) DEFAULT NULL COMMENT '메모 cd',
  `check_pen` varchar(20) DEFAULT NULL COMMENT '체크펜',
  `day_am` bigint(17) DEFAULT NULL COMMENT '일비',
  `food_am` bigint(17) DEFAULT NULL COMMENT '식비',
  `room_am` bigint(17) DEFAULT NULL COMMENT '숙박비',
  `other_am` bigint(17) DEFAULT NULL COMMENT '기타',
  `sessionid` varchar(100) DEFAULT NULL,
  `total_am` bigint(17) DEFAULT NULL,
  `biztrip_appl_id` int(20) DEFAULT NULL,
  `biztrip_no_seq` int(3) DEFAULT NULL,
  `trip_dt2` varchar(8) DEFAULT NULL,
  `na_day_am` int(17) DEFAULT NULL,
  `na_room_am` int(17) DEFAULT NULL,
  `na_food_am` int(17) DEFAULT NULL,
  PRIMARY KEY (`abdocu_no`,`abdocu_td2_no`),
  UNIQUE KEY `g20_abdocu_td2_pk` (`abdocu_no`,`abdocu_td2_no`),
  KEY `abdocu_td2_no` (`abdocu_td2_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `g20_abdocu_td2` ADD COLUMN */
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) NOT NULL COMMENT '문서번호';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `abdocu_td2_no` BIGINT(38) NOT NULL COMMENT '헤더번호';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL COMMENT '회사코드';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL COMMENT '결의일자';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT '0' COMMENT '결의번호';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `erp_ln_sq` INT(30) DEFAULT NULL COMMENT '라인순번';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `emp_nm` VARCHAR(20) DEFAULT NULL COMMENT '사원';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `dept_nm` VARCHAR(20) DEFAULT NULL COMMENT '부서';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `class_nm` VARCHAR(20) DEFAULT NULL COMMENT '직위';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `hcls_nm` VARCHAR(20) DEFAULT NULL COMMENT '직급';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `trip_dt` VARCHAR(8) DEFAULT NULL COMMENT '출장일자';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `nt_cnt` INT(30) DEFAULT NULL COMMENT '이수';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `day_cnt` INT(30) DEFAULT NULL COMMENT '일수';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `start_nm` VARCHAR(20) DEFAULT NULL COMMENT '출발지';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `cross_nm` VARCHAR(20) DEFAULT NULL COMMENT '경유지';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `arr_nm` VARCHAR(20) DEFAULT NULL COMMENT '도착지';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `jong_nm` VARCHAR(10) DEFAULT NULL COMMENT '종별';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `km_am` BIGINT(17) DEFAULT NULL COMMENT '거리';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `fair_am` BIGINT(17) DEFAULT NULL COMMENT '요금';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `trmk_dc` VARCHAR(20) DEFAULT NULL COMMENT '적요';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `start_nmk` VARCHAR(20) DEFAULT NULL COMMENT '출발지(다국어)';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `cross_nmk` VARCHAR(20) DEFAULT NULL COMMENT '경유지(다국어)';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `arr_nmk` VARCHAR(20) DEFAULT NULL COMMENT '도착지(다국어)';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `jong_nmk` VARCHAR(10) DEFAULT NULL COMMENT '종별(다국어)';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `trmk_dck` VARCHAR(20) DEFAULT NULL COMMENT '적요(다국어)';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `memo_cd` VARCHAR(14) DEFAULT NULL COMMENT '메모 cd';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `check_pen` VARCHAR(20) DEFAULT NULL COMMENT '체크펜';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `day_am` BIGINT(17) DEFAULT NULL COMMENT '일비';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `food_am` BIGINT(17) DEFAULT NULL COMMENT '식비';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `room_am` BIGINT(17) DEFAULT NULL COMMENT '숙박비';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `other_am` BIGINT(17) DEFAULT NULL COMMENT '기타';
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `total_am` BIGINT(17) DEFAULT NULL;
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `biztrip_appl_id` INT(20) DEFAULT NULL;
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `biztrip_no_seq` INT(3) DEFAULT NULL;
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `trip_dt2` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `na_day_am` INT(17) DEFAULT NULL;
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `na_room_am` INT(17) DEFAULT NULL;
ALTER TABLE `g20_abdocu_td2` ADD COLUMN IF NOT EXISTS `na_food_am` INT(17) DEFAULT NULL;

/* CREATE `g20_abdocu_d` */
CREATE TABLE IF NOT EXISTS `g20_abdocu_d` (
  `abdocu_d_no` bigint(38) NOT NULL,
  `abdocu_no` bigint(38) DEFAULT NULL,
  `erp_co_cd` varchar(4) DEFAULT NULL,
  `erp_isu_dt` varchar(8) DEFAULT NULL,
  `erp_isu_sq` int(38) DEFAULT '0',
  `erp_ln_sq` int(38) DEFAULT NULL,
  `item_nm` varchar(40) DEFAULT NULL,
  `item_dc` varchar(40) DEFAULT NULL,
  `unit_dc` varchar(40) DEFAULT NULL,
  `ct_qt` varchar(40) DEFAULT NULL,
  `unit_am` int(38) DEFAULT NULL,
  `ct_am` int(38) DEFAULT NULL,
  `rmk_dc` varchar(40) DEFAULT NULL,
  `dummy1` varchar(20) DEFAULT NULL,
  `dummy2` varchar(20) DEFAULT NULL,
  `dummy3` varchar(20) DEFAULT NULL,
  `item_nmk` varchar(30) DEFAULT NULL,
  `rmk_dck` varchar(40) DEFAULT NULL,
  `memo_cd` varchar(14) DEFAULT NULL,
  `check_pen` varchar(20) DEFAULT NULL,
  `insert_id` varchar(10) DEFAULT NULL,
  `insert_ip` varchar(15) DEFAULT NULL,
  `insert_dt` date DEFAULT NULL,
  `modify_id` varchar(100) DEFAULT NULL,
  `modify_ip` varchar(15) DEFAULT NULL,
  `modify_dt` date DEFAULT NULL,
  `item_cd` varchar(20) DEFAULT NULL,
  `sessionid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`abdocu_d_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `g20_abdocu_d` ADD COLUMN */
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `erp_isu_sq` INT(38) DEFAULT '0';
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `erp_ln_sq` INT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `item_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `item_dc` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `unit_dc` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `ct_qt` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `unit_am` INT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `ct_am` INT(38) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `rmk_dc` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `dummy1` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `dummy2` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `dummy3` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `item_nmk` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `rmk_dck` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `memo_cd` VARCHAR(14) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `check_pen` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `insert_id` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `insert_ip` VARCHAR(15) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `insert_dt` DATE DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `modify_ip` VARCHAR(15) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `modify_dt` DATE DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `item_cd` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_abdocu_d` ADD COLUMN IF NOT EXISTS `sessionid` VARCHAR(100) DEFAULT NULL;

/* CREATE `g20_acard_sungin` */
CREATE TABLE IF NOT EXISTS `g20_acard_sungin` (
  `abdocu_no` bigint(38) NOT NULL,
  `abdocu_b_no` bigint(38) NOT NULL,
  `iss_dt` varchar(8) NOT NULL,
  `iss_sq` varchar(10) NOT NULL,
  `erp_co_cd` varchar(4) NOT NULL,
  `bank_cd` varchar(2) DEFAULT NULL,
  `card_nb` varchar(20) DEFAULT NULL,
  `user_detail` varchar(100) DEFAULT NULL,
  `chain_name` varchar(60) DEFAULT NULL,
  `chain_regnb` varchar(20) DEFAULT NULL,
  `sungin_nb` varchar(20) DEFAULT NULL,
  `sungin_am` bigint(19) DEFAULT NULL,
  `vat_am` bigint(19) DEFAULT NULL,
  `user_type` varchar(20) DEFAULT NULL,
  `ebank_cd` varchar(20) DEFAULT NULL,
  `ebank_key` varchar(100) DEFAULT NULL,
  `gw_state` varchar(1) DEFAULT NULL,
  `gw_state_han` varchar(100) DEFAULT NULL,
  `pkey` varchar(30) DEFAULT NULL,
  `ctr_cd` varchar(10) DEFAULT NULL,
  `ctr_nm` varchar(40) DEFAULT NULL,
  `abdocu_t_no` bigint(38) DEFAULT NULL,
  `tot_am` bigint(19) DEFAULT NULL COMMENT '합계',
  `admit_dt` varchar(8) DEFAULT NULL,
  `chain_business` varchar(40) DEFAULT NULL COMMENT '가맹점',
  `cancel_yn` varchar(40) DEFAULT NULL COMMENT '취소여부',
  KEY `fk_G20_acard_sungin_abdocu_t` (`abdocu_t_no`),
  CONSTRAINT `fk_G20_acard_sungin_abdocu_t` FOREIGN KEY (`abdocu_t_no`) REFERENCES `g20_abdocu_t` (`abdocu_t_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `g20_acard_sungin` ADD COLUMN */
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) NOT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `abdocu_b_no` BIGINT(38) NOT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `iss_dt` VARCHAR(8) NOT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `iss_sq` VARCHAR(10) NOT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `erp_co_cd` VARCHAR(4) NOT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `bank_cd` VARCHAR(2) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `card_nb` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `user_detail` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `chain_name` VARCHAR(60) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `chain_regnb` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `sungin_nb` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `sungin_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `vat_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `user_type` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `ebank_cd` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `ebank_key` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `gw_state` VARCHAR(1) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `gw_state_han` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `pkey` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `ctr_cd` VARCHAR(10) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `ctr_nm` VARCHAR(40) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `tot_am` BIGINT(19) DEFAULT NULL COMMENT '합계';
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `admit_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `chain_business` VARCHAR(40) DEFAULT NULL COMMENT '가맹점';
ALTER TABLE `g20_acard_sungin` ADD COLUMN IF NOT EXISTS `cancel_yn` VARCHAR(40) DEFAULT NULL COMMENT '취소여부';

/* CREATE `g20_hpomnpy_padata` */
CREATE TABLE IF NOT EXISTS `g20_hpomnpy_padata` (
  `abdocu_no` bigint(38) NOT NULL,
  `abdocu_b_no` bigint(38) NOT NULL,
  `abdocu_t_no` bigint(38) NOT NULL,
  `emp_tr_cd` varchar(10) NOT NULL,
  `rvrs_ym` varchar(6) NOT NULL,
  `sq` int(3) NOT NULL,
  `kor_nm` varchar(30) DEFAULT NULL,
  `dept_nm` varchar(30) DEFAULT NULL,
  `gisu_dt` varchar(8) DEFAULT NULL,
  `pay_dt` varchar(8) DEFAULT NULL,
  `tpay_am` bigint(19) DEFAULT NULL,
  `sup_am` bigint(19) DEFAULT NULL,
  `vat_am` bigint(19) DEFAULT NULL,
  `intx_am` bigint(19) DEFAULT NULL,
  `rstx_am` bigint(19) DEFAULT NULL,
  `etc_am` bigint(19) DEFAULT NULL,
  `acct_no` varchar(30) DEFAULT NULL,
  `pytb_cd` varchar(5) DEFAULT NULL,
  `dpst_nm` varchar(30) DEFAULT NULL,
  `bank_nm` varchar(20) DEFAULT NULL,
  `rsrg_no` varchar(100) DEFAULT NULL,
  `pjt_nm` varchar(30) DEFAULT NULL,
  `pkey` varchar(30) DEFAULT NULL,
  KEY `fk_g20_hpomnpy_abdocu_t` (`abdocu_t_no`),
  CONSTRAINT `fk_g20_hpomnpy_abdocu_t` FOREIGN KEY (`abdocu_t_no`) REFERENCES `g20_abdocu_t` (`abdocu_t_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `g20_hpomnpy_padata` ADD COLUMN */
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `abdocu_no` BIGINT(38) NOT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `abdocu_b_no` BIGINT(38) NOT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `emp_tr_cd` VARCHAR(10) NOT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `rvrs_ym` VARCHAR(6) NOT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `sq` INT(3) NOT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `kor_nm` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `dept_nm` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `gisu_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `pay_dt` VARCHAR(8) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `tpay_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `sup_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `vat_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `intx_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `rstx_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `etc_am` BIGINT(19) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `acct_no` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `pytb_cd` VARCHAR(5) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `dpst_nm` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `bank_nm` VARCHAR(20) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `rsrg_no` VARCHAR(100) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `pjt_nm` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `g20_hpomnpy_padata` ADD COLUMN IF NOT EXISTS `pkey` VARCHAR(30) DEFAULT NULL;

/* CREATE `erpgwlink` */
CREATE TABLE IF NOT EXISTS `erpgwlink` (
  `appr_seqn` varchar(10) NOT NULL COMMENT 'erp연계처리번호(시퀀스: seq_erpgwlink)',
  `pack_knd_cd` varchar(5) NOT NULL COMMENT 'erp패키지 구분코드(공통코드:g20,eiu)',
  `docx_gubn` varchar(5) NOT NULL COMMENT 'erpd연계종류코드( 결재양식:지출물의, 지출결의..)',
  `docx_numb` varchar(50) DEFAULT NULL COMMENT 'erp문서번호(업무별 구분 key)',
  `requ_userid` varchar(50) NOT NULL COMMENT '요청자 id',
  `requ_userkey` varchar(30) NOT NULL COMMENT '전자결재사용자 key',
  `requ_date` varchar(14) NOT NULL COMMENT '결재요청일시(yyyymmddhhmmss)',
  `appr_dikey` varchar(46) NOT NULL COMMENT '전자결재문서 키코드',
  `appr_status` varchar(3) DEFAULT NULL COMMENT '결재진행상태코드(002:결재중..)',
  `appr_end_date` varchar(14) DEFAULT NULL COMMENT '결재처리일시(yyyymmddhhmmss)',
  `cd_company` varchar(7) DEFAULT NULL COMMENT '회사코드',
  `doc_audit` VARCHAR(1) DEFAULT 'N' COMMENT '문서 감사여부 감사 ''y''  감사아님''n''',
  `back_docx_numb` varchar(50) DEFAULT NULL COMMENT '회수나 반려시 docx_numb을 저장',
  `modify_id` varchar(50) DEFAULT NULL,
  `modify_userkey` varchar(30) DEFAULT NULL,
  `modify_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`appr_seqn`),
  UNIQUE KEY `a_erpgwlink_pk` (`appr_seqn`),
  KEY `idx_erpgwlink02` (`docx_numb`,`docx_gubn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* ALTER `erpgwlink` ADD COLUMN */
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `pack_knd_cd` VARCHAR(5) NOT NULL COMMENT 'erp패키지 구분코드(공통코드:g20,eiu)';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `requ_userid` VARCHAR(50) NOT NULL COMMENT '요청자 id';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `requ_userkey` VARCHAR(30) NOT NULL COMMENT '전자결재사용자 key';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `requ_date` VARCHAR(14) NOT NULL COMMENT '결재요청일시(yyyymmddhhmmss)';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `appr_dikey` VARCHAR(46) NOT NULL COMMENT '전자결재문서 키코드';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `appr_status` VARCHAR(3) DEFAULT NULL COMMENT '결재진행상태코드(002:결재중..)';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `appr_end_date` VARCHAR(14) DEFAULT NULL COMMENT '결재처리일시(yyyymmddhhmmss)';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `cd_company` VARCHAR(7) DEFAULT NULL COMMENT '회사코드';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `doc_audit` VARCHAR(1) DEFAULT 'N' COMMENT '문서 감사여부 감사 ''y''  감사아님''n''';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `back_docx_numb` VARCHAR(50) DEFAULT NULL COMMENT '회수나 반려시 docx_numb을 저장';
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `modify_id` VARCHAR(50) DEFAULT NULL;
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `modify_userkey` VARCHAR(30) DEFAULT NULL;
ALTER TABLE `erpgwlink` ADD COLUMN IF NOT EXISTS `modify_dt` DATETIME DEFAULT NULL;

/* 2018-10-03 */
/* 최상배 - 비영리 회계 2.0 연동 모듈 배포 스크립트 작성 */

/*  - 품의문서 t_exnp_consdoc 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_consdoc` (
	`cons_doc_seq` BIGINT(32) NOT NULL AUTO_INCREMENT 	COMMENT '품의 문서 키',
	`create_seq` VARCHAR(32) DEFAULT NULL COMMENT '품의문서 생성자 키',
	`create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '품의문서 생성일자',
	`modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '품의문서 수정자 키',
	`modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '품의문서 수정일자',
	PRIMARY KEY (`cons_doc_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `doc_seq` VARCHAR(32) NULL COMMENT '품의 문서 전자결재 키' AFTER `cons_doc_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `doc_no` VARCHAR(64) NULL COMMENT '품의 문서 전자결재 문서 번호' AFTER `doc_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `doc_status` VARCHAR(6) NULL COMMENT '품의 문서 전자결재 상태값' AFTER `doc_no`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `consdoc_note` VARCHAR(1024) NULL COMMENT '품의 문서 적요' AFTER `doc_status`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `expend_date` DATETIME NULL COMMENT '품의일자' AFTER `consdoc_note`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT 'ERP 회계단위 코드' AFTER `expend_date`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(32) NULL COMMENT 'ERP 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(32) NULL COMMENT 'ERP 회사 코드' AFTER `erp_div_name`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_dept_seq` VARCHAR(32) NULL COMMENT 'ERP 부서 코드' AFTER `erp_comp_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(32) NULL COMMENT 'ERP 사용자 코드' AFTER `erp_dept_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_gisu` VARCHAR(10) NULL COMMENT 'ERP 기수' AFTER `erp_emp_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `erp_expend_year` VARCHAR(4) NULL COMMENT 'ERP 회계 연도' AFTER `erp_gisu`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT 'GW 회사 키' AFTER `erp_expend_year`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT 'GW 회사 명칭' AFTER `comp_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `dept_seq` VARCHAR(32) NULL COMMENT 'GW 부서 키' AFTER `comp_name`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `dept_name` VARCHAR(128) NULL COMMENT 'GW 부서 명칭' AFTER `dept_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT 'GW 사용자 키' AFTER `dept_name`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT 'GW 사용자 명칭' AFTER `emp_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `conffer_return_yn` VARCHAR(2) DEFAULT 'N' COMMENT '품의 문서 환원 여부' AFTER `emp_name`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `conffer_return_name` VARCHAR(128) NULL COMMENT '품의 문서 환원자 명' AFTER `conffer_return_yn`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `conffer_return_emp_seq` VARCHAR(32) NULL COMMENT '품의 문서 환원자 키' AFTER `conffer_return_name`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 구분값 ( 전자결재 아님 )' AFTER `conffer_return_emp_seq`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_m_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 마스터 아이디 ( 전자결재 아님 )' AFTER `out_process_interface_id`;
ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_d_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 디테일 아이디 ( 전자결재 아님 )' AFTER `out_process_interface_m_id`;


/*  - 품의서 t_exnp_conshead 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_conshead` (
	`cons_doc_seq` BIGINT(32) NOT NULL COMMENT '품의 문서 키',
	`cons_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '품의서 키',
	`create_seq` VARCHAR(32) DEFAULT NULL,
	`create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,	
	`modify_seq` VARCHAR(32) DEFAULT NULL,
	`modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,  
	PRIMARY KEY (`cons_doc_seq`,`cons_seq`),
	KEY `cons_seq` (`cons_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `cons_date` VARCHAR(16) NULL COMMENT '품의 일자' AFTER `cons_seq`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `mgt_seq` VARCHAR(10) NULL COMMENT '[I]ERP 프로젝트/부서 코드' AFTER `cons_date`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `mgt_name` VARCHAR(128) NULL COMMENT '[I]ERP 프로젝트/부서 명' AFTER `mgt_seq`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `docu_fg_code` VARCHAR(2) NULL COMMENT '품의 구분 코드' AFTER `mgt_name`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `docu_fg_name` VARCHAR(32) NULL COMMENT '품의 구분 명' AFTER `docu_fg_code`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `cons_note` VARCHAR(400) NULL COMMENT '품의서 적요' AFTER `docu_fg_name`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(8) NULL COMMENT 'ERP 회사 코드' AFTER `cons_note`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_comp_name` VARCHAR(100) NULL COMMENT 'ERP 회사 명' AFTER `erp_comp_seq`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_pc_seq` VARCHAR(8) NULL COMMENT '[U]ERP 회계단위 코드' AFTER `erp_comp_name`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_pc_name` VARCHAR(64) NULL COMMENT '[U]ERP 회계단위 명' AFTER `erp_pc_seq`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(40) NULL COMMENT 'ERP 사원 코드' AFTER `erp_pc_name`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_emp_name` VARCHAR(100) NULL COMMENT 'ERP 사원 명' AFTER `erp_emp_seq`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(40) NULL COMMENT '[I]ERP 예산 회계단위 코드' AFTER `erp_emp_name`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(100) NULL COMMENT '[I]ERP 예산 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_dept_seq` VARCHAR(40) NULL COMMENT 'ERP 부서 코드' AFTER `erp_div_name`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_dept_name` VARCHAR(100) NULL COMMENT 'ERP 부서 명' AFTER `erp_dept_seq`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_gisu` INT(32) NULL COMMENT 'ERP 기수' AFTER `erp_dept_name`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_gisu_from_date` VARCHAR(8) NULL COMMENT 'ERP 기수 시작일' AFTER `erp_gisu`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_gisu_to_date` VARCHAR(8) NULL COMMENT 'ERP 기수 종료일' AFTER `erp_gisu_from_date`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `erp_year` VARCHAR(4) NULL COMMENT 'ERP 회계 연도' AFTER `erp_gisu_to_date`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `btr_seq` VARCHAR(10) NULL COMMENT '[I] MGT 입출금 계좌 코드' AFTER `erp_year`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `btr_nb` VARCHAR(50) NULL COMMENT '[I] MGT 입출금 계좌 번호' AFTER `btr_seq`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `btr_name` VARCHAR(100) NULL COMMENT '[I] MGT 입출금 계좌 명' AFTER `btr_nb`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `bottom_seq` VARCHAR(10) NULL COMMENT '[I] 하위사업 코드' AFTER `btr_name`;
ALTER TABLE `t_exnp_conshead` ADD COLUMN IF NOT EXISTS `bottom_name` VARCHAR(100) NULL COMMENT '[I] 하위사업 명' AFTER `bottom_seq`;


/*  - 품의서 t_exnp_consbudget 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_consbudget` (
  `cons_doc_seq` BIGINT(32) NOT NULL COMMENT '품의 문서 키',
  `cons_seq` BIGINT(32) NOT NULL COMMENT '품의서 키',
  `budget_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '품의서 예산 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cons_doc_seq`,`cons_seq`,`budget_seq`),
  KEY `budget_seq` (`budget_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bq_seq` INT(38) NULL COMMENT 'ERP 예산순번' AFTER `budget_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bk_seq` INT(5) NULL COMMENT 'ERP 에산 순번' AFTER `erp_bq_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_budget_seq` VARCHAR(32) NULL COMMENT '예산단위 코드 [U:budgetCode]' AFTER `erp_bk_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_budget_name` VARCHAR(32) NULL COMMENT '예산단위 명 [U:budget]' AFTER `erp_budget_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bizplan_seq` VARCHAR(32) NULL COMMENT '사업 계획 코드 [U:bizplanCode]' AFTER `erp_budget_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bizplan_name` VARCHAR(32) NULL COMMENT '사업계획 명 [U:bizplan]' AFTER `erp_bizplan_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT '[G] ERP 전표 사업장 코드' AFTER `erp_bizplan_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(32) NULL COMMENT '[G] ERP 전표 사업장 명' AFTER `erp_div_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_fiacct_seq` VARCHAR(10) NULL COMMENT '[U] 회계계정 코드 [U:fiacctCode]' AFTER `erp_div_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_fiacct_name` VARCHAR(32) NULL COMMENT '[U] 회계계정 명 [U:fiacct]' AFTER `erp_fiacct_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgacct_seq` VARCHAR(10) NULL COMMENT '노드 [G:예산코드 U:예산계정] 코드' AFTER `erp_fiacct_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgacct_name` VARCHAR(10) NULL COMMENT '노드 [G:예산코드 U:예산계정] 명칭' AFTER `erp_bgacct_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt1_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]관' AFTER `erp_bgacct_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt1_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]관 코드' AFTER `erp_bgt1_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt2_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]항' AFTER `erp_bgt1_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt2_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]항 코드' AFTER `erp_bgt2_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt3_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]목' AFTER `erp_bgt2_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt3_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]목 코드' AFTER `erp_bgt3_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt4_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]세' AFTER `erp_bgt3_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_bgt4_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]세 코드' AFTER `erp_bgt4_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `set_fg_code` VARCHAR(1) NULL COMMENT '결제 수단 코드' AFTER `erp_bgt4_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `set_fg_name` VARCHAR(32) NULL COMMENT '결제 수단 명' AFTER `set_fg_code`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `vat_fg_code` VARCHAR(1) NULL COMMENT '과세 구분 코드' AFTER `set_fg_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `vat_fg_name` VARCHAR(32) NULL COMMENT '과세 구분 명' AFTER `vat_fg_code`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `tr_fg_code` VARCHAR(1) NULL COMMENT '채주 구분 코드' AFTER `vat_fg_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `tr_fg_name` VARCHAR(32) NULL COMMENT '채주 구분 명' AFTER `tr_fg_code`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `ctl_fg_code` VARCHAR(1) NULL COMMENT '부가세 포함 통제 여부 [0:불포함, 1:포함]' AFTER `tr_fg_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `ctl_fg_name` VARCHAR(32) NULL COMMENT '부가세 포함통제 내용' AFTER `ctl_fg_code`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_open_amt` BIGINT(64) NULL COMMENT 'ERP 예산 편성 금액' AFTER `ctl_fg_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_apply_amt` BIGINT(64) NULL COMMENT 'ERP 예산 결의 금액' AFTER `erp_open_amt`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_res_amt` BIGINT(64) NULL COMMENT 'ERP 원인행위 금액' AFTER `erp_apply_amt`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_left_amt` BIGINT(64) NULL COMMENT 'ERP 예산잔액' AFTER `erp_res_amt`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `gw_balance_amt` BIGINT(64) NULL COMMENT '작성시점 그룹웨어 예산 잔액' AFTER `erp_left_amt`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `budget_std_amt` BIGINT(64) NULL COMMENT '부가세 대급금' AFTER `gw_balance_amt`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `budget_tax_amt` BIGINT(64) NULL COMMENT '부가세' AFTER `budget_std_amt`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `budget_amt` BIGINT(64) NULL COMMENT '사용 예산 금액' AFTER `budget_tax_amt`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `budget_note` VARCHAR(100) NULL COMMENT '예산 적요' AFTER `budget_amt`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `conffer_budget_return_yn` VARCHAR(2) DEFAULT 'N' NULL COMMENT '품의 예산별 환원 여부' AFTER `budget_note`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `conffer_budget_return_emp_seq` VARCHAR(32) NULL COMMENT '품의 예산 환원 사용자 코드' AFTER `conffer_budget_return_yn`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `conffer_budget_return_emp_name` VARCHAR(32) NULL COMMENT '품의 예산 환원 사용자 명' AFTER `conffer_budget_return_emp_seq`;


/*  - 품의서 t_exnp_constrade 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_constrade` (
  `cons_doc_seq` BIGINT(32) NOT NULL COMMENT '품의 문서 키',
  `cons_seq` BIGINT(32) NOT NULL COMMENT '품의서 키',
  `budget_seq` BIGINT(32) NOT NULL COMMENT '품의 예산 키',
  `trade_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '품의 거래처 키',
  
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,  
  
  PRIMARY KEY (`cons_doc_seq`,`cons_seq`,`budget_seq`,`trade_seq`),
  KEY `trade_seq` (`trade_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) NULL COMMENT '[I] ERP 채주 키' AFTER `trade_seq`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `erp_isu_sq` VARCHAR(38) NULL COMMENT '[I] ERP 채주 키' AFTER `erp_isu_dt`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `erp_in_sq` BIGINT(38) NULL COMMENT '[U] ERP 채주 키 ' AFTER `erp_isu_sq`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `erp_bq_sq` BIGINT(38) NULL COMMENT '[U] ERP 채주 키' AFTER `erp_in_sq`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `item_name` VARCHAR(100) NULL COMMENT '물품 명칭' AFTER `erp_bq_sq`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `item_cnt` VARCHAR(100) NULL COMMENT '물품 갯수' AFTER `item_name`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(100) NULL COMMENT '사용자 명' AFTER `item_cnt`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `tr_seq` VARCHAR(15) NULL COMMENT 'ERP 거래처 코드' AFTER `emp_name`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `tr_name` VARCHAR(40) NULL COMMENT 'ERP 거래처 명' AFTER `tr_seq`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `ceo_name` VARCHAR(20) NULL COMMENT 'ERP 거래처 대표자 명' AFTER `tr_name`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `trade_unit_amt` BIGINT(64) NULL COMMENT '채주 금액' AFTER `ceo_name`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `trade_std_amt` BIGINT(64) NULL COMMENT '채주 부가세 대급금' AFTER `trade_unit_amt`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `trade_vat_amt` BIGINT(64) NULL COMMENT '채주 부가세' AFTER `trade_std_amt`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `jiro_seq` VARCHAR(10) NULL COMMENT '' AFTER `trade_vat_amt`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `jiro_name` VARCHAR(40) NULL COMMENT '' AFTER `jiro_seq`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `ba_nb` VARCHAR(40) NULL COMMENT '금융 계좌번호' AFTER `jiro_name`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `btr_seq` VARCHAR(10) NULL COMMENT '금융 기관 코드' AFTER `ba_nb`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `btr_name` VARCHAR(40) NULL COMMENT '금융 기관 명' AFTER `btr_seq`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `depositor` VARCHAR(30) NULL COMMENT '예금주' AFTER `btr_name`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `trade_note` VARCHAR(100) NULL COMMENT '채주 비고' AFTER `depositor`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `ctr_seq` VARCHAR(10) NULL COMMENT '' AFTER `trade_note`;
ALTER TABLE `t_exnp_constrade` ADD COLUMN IF NOT EXISTS `ctr_name` VARCHAR(10) NULL COMMENT '' AFTER `ctr_seq`;


/*  - 결의서 t_exnp_resdoc 테이블 생성*/
CREATE TABLE IF NOT EXISTS `t_exnp_resdoc` (
  `res_doc_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '결의 문서 순번',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,   
  PRIMARY KEY (`res_doc_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `doc_seq` VARCHAR(32) NULL COMMENT '결의 문서 전자결재 문서 키' AFTER `res_doc_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `doc_no` VARCHAR(64) NULL COMMENT '결의 문서 전자결재 문서번호' AFTER `doc_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `doc_status` VARCHAR(6) NULL COMMENT '결의 문서 문서 상태 코드' AFTER `doc_no`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `resdoc_note` VARCHAR(32) NULL COMMENT '결의 문서 적요' AFTER `doc_status`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `expend_date` DATETIME(6) NULL COMMENT '결의일자' AFTER `resdoc_note`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(32) NULL COMMENT 'ERP 회사 코드' AFTER `expend_date`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_dept_seq` VARCHAR(32) NULL COMMENT 'ERP 부서 코드' AFTER `erp_comp_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(32) NULL COMMENT 'ERP 사원 코드' AFTER `erp_dept_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_gisu` VARCHAR(4) NULL COMMENT 'ERP 기수' AFTER `erp_emp_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_expend_year` VARCHAR(4) NULL COMMENT 'ERP 회계연도' AFTER `erp_gisu`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT 'ERP 회계단위 코드' AFTER `erp_expend_year`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(32) NULL COMMENT 'ERP 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT 'GW 회사 키' AFTER `erp_div_name`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT 'GW 회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `dept_seq` VARCHAR(32) NULL COMMENT 'GW 부서 키' AFTER `comp_name`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `dept_name` VARCHAR(128) NULL COMMENT 'GW 부서 명' AFTER `dept_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT 'GW 사용자 키' AFTER `dept_name`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT 'GW 사용자 명' AFTER `emp_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `conffer_doc_seq` VARCHAR(32) NULL COMMENT '참조 품의 문서 번호' AFTER `emp_name`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `erp_send_yn` VARCHAR(2) DEFAULT 'N' COMMENT '결의서 ERP 전송 여부' AFTER `conffer_doc_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `send_emp_seq` VARCHAR(32) NULL COMMENT '결의서 전송자 키' AFTER `erp_send_yn`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `send_emp_name` VARCHAR(128) NULL COMMENT '결의서 전송자 명' AFTER `send_emp_seq`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `send_date` DATETIME NULL COMMENT '결의서 전송 일자' AFTER `send_emp_name`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 구분값 ( 전자결재 아님 )' AFTER `send_date`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_m_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 마스터 아이디 ( 전자결재 아님 )' AFTER `out_process_interface_id`;
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `out_process_interface_d_id` VARCHAR(32) NULL COMMENT '결의서 외부연동 개발 디테일 아이디 ( 전자결재 아님 )' AFTER `out_process_interface_m_id`;

/*  - 결의서 t_exnp_reshead 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_reshead` (
  `res_doc_seq` BIGINT(32) NOT NULL COMMENT '결의 문서 키',
  `res_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '결의서 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`res_doc_seq`,`res_seq`),
  KEY `res_seq` (`res_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu_date` VARCHAR(8) NULL COMMENT '[I] ERP 결의서 연동 키' AFTER `res_seq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` VARCHAR(10) NULL COMMENT '[I] ERP 결의서 연동 키' AFTER `erp_gisu_date`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_no_cdocu` VARCHAR(8) NULL COMMENT '[U] ERP 원인행위 키' AFTER `erp_gisu_sq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(40) NULL COMMENT 'ERP 회사 코드' AFTER `erp_no_cdocu`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_comp_name` VARCHAR(100) NULL COMMENT 'ERP 회사 명' AFTER `erp_comp_seq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_dept_seq` VARCHAR(40) NULL COMMENT 'ERP 부서 코드' AFTER `erp_comp_name`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_dept_name` VARCHAR(100) NULL COMMENT 'ERP 부서 명' AFTER `erp_dept_seq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(40) NULL COMMENT 'ERP 사원 코드' AFTER `erp_dept_name`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_emp_name` VARCHAR(100) NULL COMMENT 'ERP 사원 명' AFTER `erp_emp_seq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu` INT(38) NULL COMMENT 'ERP 기수' AFTER `erp_emp_name`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu_from_date` VARCHAR(8) NULL COMMENT 'ERP 기수 시작 일' AFTER `erp_gisu`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_gisu_to_date` VARCHAR(8) NULL COMMENT 'ERP 기수 종료 일' AFTER `erp_gisu_from_date`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_year` VARCHAR(4) NULL COMMENT 'ERP 회계 연도' AFTER `erp_gisu_to_date`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(40) NULL COMMENT '[I] ERP 회계단위 코드' AFTER `erp_year`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(100) NULL COMMENT '[I] ERP 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_pc_seq` VARCHAR(8) NULL COMMENT '[U] ERP 회계단위' AFTER `erp_div_name`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `erp_pc_name` VARCHAR(64) NULL COMMENT '[U] ERP 회계단위 명' AFTER `erp_pc_seq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `mgt_seq` VARCHAR(10) NULL COMMENT '[I] 프로젝트/부서 코드' AFTER `erp_pc_name`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `mgt_name` VARCHAR(100) NULL COMMENT '[I] 프로젝트/부서 명' AFTER `mgt_seq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `res_date` VARCHAR(16) NULL COMMENT '결의일자' AFTER `mgt_name`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `docu_fg_code` VARCHAR(2) NULL COMMENT '결의 구분 코드' AFTER `res_date`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `docu_fg_name` VARCHAR(32) NULL COMMENT '결의 구분 명' AFTER `docu_fg_code`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `res_note` VARCHAR(100) NULL COMMENT '결의서 적요' AFTER `docu_fg_name`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `btr_seq` VARCHAR(10) NULL COMMENT '[I] 프로젝트 입출금 계좌 코드' AFTER `res_note`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `btr_name` VARCHAR(100) NULL COMMENT '[I] 프로젝트 입출금 계좌 명' AFTER `btr_seq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `btr_nb` VARCHAR(50) NULL COMMENT '[I] 프로젝트 입출금 계좌 번호' AFTER `btr_name`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `bottom_seq` VARCHAR(10) NULL COMMENT '[I] 하위 사업 코드' AFTER `btr_nb`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `bottom_name` VARCHAR(100) NULL COMMENT '[I] 하위 사업 명' AFTER `bottom_seq`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `conffer_doc_seq` VARCHAR(32) NULL COMMENT '참조 품의 문서 키' AFTER `bottom_name`;
ALTER TABLE `t_exnp_reshead` ADD COLUMN IF NOT EXISTS `conffer_seq` VARCHAR(32) NULL COMMENT '참조 품의서 키' AFTER `conffer_doc_seq`;

/*  - 결의서 t_exnp_resbudget 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_resbudget` (
  `res_doc_seq` BIGINT(32) NOT NULL COMMENT '결의 문서 키',
  `res_seq` BIGINT(32) NOT NULL COMMENT '결의서 키',
  `budget_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '결의 예산 키',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '',  
  PRIMARY KEY (`res_doc_seq`,`res_seq`,`budget_seq`),
  KEY `budget_seq` (`budget_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_gisu_date` VARCHAR(8) NULL COMMENT '[I] ERP 결의서 연동 키' AFTER `budget_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` VARCHAR(8) NULL COMMENT '[I] ERP 결의서 연동 키' AFTER `erp_gisu_date`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bg_sq` VARCHAR(8) NULL COMMENT '[I] ERP 결의서 예산 키' AFTER `erp_gisu_sq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bq_seq` VARCHAR(32) NULL COMMENT '[I] 결의서 예산 연동 키' AFTER `erp_bg_sq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bk_seq` VARCHAR(5) NULL COMMENT '[I] 결의서 예산 연동 키' AFTER `erp_bq_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `no_cdocu` VARCHAR(32) NULL COMMENT '[U] 원인행위 전표 연동 키' AFTER `erp_bk_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `no_cdoline` VARCHAR(32) NULL COMMENT '[U] 원인행위 전표 라인 키' AFTER `no_cdocu`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT '[I] ERP 전표 회계단위 코드' AFTER `no_cdoline`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(100) NULL COMMENT '[I] ERP 전표 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bizplan_seq` VARCHAR(32) NULL COMMENT '[U] 사업 계획 코드' AFTER `erp_div_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bizplan_name` VARCHAR(32) NULL COMMENT '[U] 사업 계획 명' AFTER `erp_bizplan_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_fiacct_seq` VARCHAR(10) NULL COMMENT '[U] ERP 회계 계정 코드' AFTER `erp_bizplan_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_fiacct_name` VARCHAR(32) NULL COMMENT '[U] ERP 회계 계정 명' AFTER `erp_fiacct_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgacct_seq` VARCHAR(10) NULL COMMENT '[U] ERP 예산 계정 코드' AFTER `erp_fiacct_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgacct_name` VARCHAR(32) NULL COMMENT '[U] ERP 예산 계정 명' AFTER `erp_bgacct_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_budget_seq` VARCHAR(32) NULL COMMENT 'ERP 예산단위 코드 I budget_seq, U budget_code' AFTER `erp_bgacct_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_budget_name` VARCHAR(32) NULL COMMENT 'ERP 예산 단위 명 I budget_name, U budget' AFTER `erp_budget_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt1_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]관 명' AFTER `erp_budget_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt1_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]관 코드' AFTER `erp_bgt1_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt2_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]항 명' AFTER `erp_bgt1_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt2_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]항 코드' AFTER `erp_bgt2_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt3_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]목 명' AFTER `erp_bgt2_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt3_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]목 코드' AFTER `erp_bgt3_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt4_name` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]세 명' AFTER `erp_bgt3_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_bgt4_seq` VARCHAR(50) NULL COMMENT '[G:예산코드 U:예산계정]세 코드' AFTER `erp_bgt4_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_open_amt` BIGINT(64) NULL COMMENT 'ERP 예산 편성 금액' AFTER `erp_bgt4_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_apply_amt` BIGINT(64) NULL COMMENT 'ERP 예산 결의 금액' AFTER `erp_open_amt`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_res_amt` BIGINT(64) NULL COMMENT 'ERP 예산 원인행위 금액' AFTER `erp_apply_amt`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_left_amt` BIGINT(64) NULL COMMENT 'ERP 예산 잔액' AFTER `erp_res_amt`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `gw_balance_amt` BIGINT(64) NULL COMMENT '작성시점 그룹웨어 예산 잔액' AFTER `erp_left_amt`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `budget_std_amt` BIGINT(64) NULL COMMENT '부가세 대급금' AFTER `gw_balance_amt`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `budget_tax_amt` BIGINT(64) NULL COMMENT '부가세' AFTER `budget_std_amt`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `budget_amt` BIGINT(64) NULL COMMENT '결의 금액' AFTER `budget_tax_amt`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `set_fg_code` VARCHAR(2) NULL COMMENT '결재 수단 코드' AFTER `budget_amt`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `set_fg_name` VARCHAR(32) NULL COMMENT '결재 수단 명' AFTER `set_fg_code`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `vat_fg_code` VARCHAR(2) NULL COMMENT '과세 구분 코드' AFTER `set_fg_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `vat_fg_name` VARCHAR(32) NULL COMMENT '과세 구분 명' AFTER `vat_fg_code`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `tr_fg_code` VARCHAR(2) NULL COMMENT '채주 유형 코드' AFTER `vat_fg_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `tr_fg_name` VARCHAR(32) NULL COMMENT '채주 유형 명' AFTER `tr_fg_code`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `ctl_fg_code` VARCHAR(2) NULL COMMENT '부가세 포함 통제 여부 [0:불포함, 1:포함]' AFTER `tr_fg_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `ctl_fg_name` VARCHAR(32) NULL COMMENT '부가세 포함통제 내용' AFTER `ctl_fg_code`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `budget_note` VARCHAR(100) NULL COMMENT '결의서 예산 비고' AFTER `ctl_fg_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `conffer_doc_seq` VARCHAR(32) NULL COMMENT '참조 품의 문서 키' AFTER `budget_note`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `conffer_seq` VARCHAR(32) NULL COMMENT '참조 품의서 키' AFTER `conffer_doc_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `conffer_budget_seq` VARCHAR(32) NULL COMMENT '참조 품의 예산 키' AFTER `conffer_seq`;


/*  - 결의서 t_exnp_restrade 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_restrade` (
  `res_doc_seq` BIGINT(32) NOT NULL COMMENT '결의 문서 키',
  `res_seq` BIGINT(32) NOT NULL COMMENT '결의서 키',
  `budget_seq` BIGINT(32) NOT NULL COMMENT '결의 예산 키',
  `trade_seq` BIGINT(32) NOT NULL AUTO_INCREMENT COMMENT '결의 거래처 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,  
  PRIMARY KEY (`res_doc_seq`,`res_seq`,`budget_seq`,`trade_seq`),
  KEY `trade_seq` (`trade_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_isu_dt` VARCHAR(8) NULL COMMENT '[I] 결의서 연동 키' AFTER `trade_seq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_isu_sq` VARCHAR(32) NULL COMMENT '[I] 결의서 연동 키' AFTER `erp_isu_dt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_bq_sq` VARCHAR(32) NULL COMMENT '[I] 결의서 예산 연동 키' AFTER `erp_isu_sq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_in_sq` VARCHAR(32) NULL COMMENT '[I] 결의서 채주 연동 키' AFTER `erp_bq_sq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_gisu_date` VARCHAR(8) NULL COMMENT '[I] 결의서 연동 키' AFTER `erp_in_sq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_gisu_sq` VARCHAR(8) NULL COMMENT '[I] 결의서 연동 키' AFTER `erp_gisu_date`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_bg_sq` VARCHAR(8) NULL COMMENT '[I] 결의서 예산 연동 키' AFTER `erp_gisu_sq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `erp_ln_sq` VARCHAR(8) NULL COMMENT '[I] 결의서 채주 연동 키' AFTER `erp_bg_sq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_cdocu` VARCHAR(32) NULL COMMENT '[U] 전표 연동 키' AFTER `erp_ln_sq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_cdoline` VARCHAR(32) NULL COMMENT '[U] 전표 라인 번호' AFTER `no_cdocu`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_payline` VARCHAR(32) NULL COMMENT '[U] 전표 채주 라인 번호' AFTER `no_cdoline`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(50) NULL COMMENT '채주 사용자 명' AFTER `no_payline`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `tr_seq` VARCHAR(15) NULL COMMENT '거래처 코드' AFTER `emp_name`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `tr_name` VARCHAR(50) NULL COMMENT '거래처 명' AFTER `tr_seq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `ctr_seq` VARCHAR(10) NULL COMMENT '미지급금 거래처 코드' AFTER `tr_name`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `ctr_name` VARCHAR(50) NULL COMMENT '미지급금 거래처 명' AFTER `ctr_seq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `ceo_name` VARCHAR(50) NULL COMMENT '거래처 대표자 명' AFTER `ctr_name`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `item_name` VARCHAR(50) NULL COMMENT '물품 명' AFTER `ceo_name`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `item_cnt` VARCHAR(32) NULL COMMENT '물품 갯수' AFTER `item_name`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `trade_amt` BIGINT(64) NULL COMMENT '채주 금액' AFTER `item_cnt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `trade_std_amt` BIGINT(64) NULL COMMENT '채주 공급대가' AFTER `trade_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `trade_vat_amt` BIGINT(64) NULL COMMENT '부가세' AFTER `trade_std_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `jiro_seq` VARCHAR(10) NULL COMMENT '미사용' AFTER `trade_vat_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `jiro_name` VARCHAR(40) NULL COMMENT '미사용' AFTER `jiro_seq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `business_nb` VARCHAR(32) NULL COMMENT '사업자 번호' AFTER `jiro_name`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `ba_nb` VARCHAR(40) NULL COMMENT '거래처 계좌번호' AFTER `business_nb`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `btr_seq` VARCHAR(10) NULL COMMENT '거래처 금융기관 코드' AFTER `ba_nb`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `btr_name` VARCHAR(40) NULL COMMENT '거래처 금융기관 명' AFTER `btr_seq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `depositor` VARCHAR(32) NULL COMMENT '거래처 예금주' AFTER `btr_name`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `trade_note` VARCHAR(100) NULL COMMENT '거래처 비고' AFTER `depositor`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `reg_date` VARCHAR(8) NULL COMMENT '신고기준일' AFTER `trade_note`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_income_seq` VARCHAR(32) NULL COMMENT '소득 구분 코드' AFTER `reg_date`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_income_name` VARCHAR(32) NULL COMMENT '소득 구분 명' AFTER `etc_income_seq`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_required_rate` VARCHAR(32) NULL COMMENT '필요 경비율' AFTER `etc_income_name`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_required_amt` BIGINT(64) NULL COMMENT '필요 경비 금액' AFTER `etc_required_rate`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_income_amt` BIGINT(64) NULL COMMENT '소득금액' AFTER `etc_required_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_income_vat_amt` BIGINT(64) NULL COMMENT '소득세액' AFTER `etc_income_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_resident_vat_amt` BIGINT(64) NULL COMMENT '주민세액' AFTER `etc_income_vat_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_belong_year` VARCHAR(10) NULL COMMENT '귀속년도' AFTER `etc_resident_vat_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_belong_month` VARCHAR(6) NULL COMMENT '귀속 월' AFTER `etc_belong_year`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_tax_code` VARCHAR(3) NULL COMMENT '[U] 불공제 사유 코드' AFTER `etc_belong_month`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `no_tax_name` VARCHAR(64) NULL COMMENT '[U] 불공제 사유 명 ' AFTER `no_tax_code`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `interface_type` VARCHAR(8) NULL COMMENT '외부 시스템 연동 타입' AFTER `no_tax_name`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `interface_seq` VARCHAR(32) NULL COMMENT '외부 시스템 연동 키' AFTER `interface_type`;

/*  - 원인행위 정보 t_exnp_cause 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_cause` (
  `cause_seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '원인행위 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_dt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_dt` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cause_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_cause` ADD COLUMN IF NOT EXISTS `res_seq` VARCHAR(32) NULL COMMENT '결의서 키 [t_exnp_reshead.res_seq]' AFTER `cause_seq`;
ALTER TABLE `t_exnp_cause` ADD COLUMN IF NOT EXISTS `cause_date` VARCHAR(8) NULL COMMENT '원인행위 일자' AFTER `res_seq`;
ALTER TABLE `t_exnp_cause` ADD COLUMN IF NOT EXISTS `sign_date` VARCHAR(32) NULL COMMENT '계약일자' AFTER `cause_date`;
ALTER TABLE `t_exnp_cause` ADD COLUMN IF NOT EXISTS `inspect_date` VARCHAR(8) NULL COMMENT '검수일자' AFTER `sign_date`;
ALTER TABLE `t_exnp_cause` ADD COLUMN IF NOT EXISTS `cause_emp_seq` VARCHAR(32) NULL COMMENT '원인행위자 ERP 사원 코드' AFTER `inspect_date`;
ALTER TABLE `t_exnp_cause` ADD COLUMN IF NOT EXISTS `cause_emp_name` VARCHAR(32) NULL COMMENT '원인행위자 ERP 사원 명' AFTER `cause_emp_seq`;

/*  - 품의 조회권한 1.0 [미사용] t_exnp_consauth 테이블 생성*/
CREATE TABLE IF NOT EXISTS `t_exnp_consauth` (
  `auth_seq` INT(32) NOT NULL AUTO_INCREMENT COMMENT '품의서 조회 권한 순번',
  `emp_seq` VARCHAR(32) NOT NULL COMMENT 'GW 사원 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_dt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_dt` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`auth_seq`,`emp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `t_exnp_consauth` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT 'GW 회사 시퀀스' AFTER `auth_seq`;
ALTER TABLE `t_exnp_consauth` ADD COLUMN IF NOT EXISTS `gbn_org` VARCHAR(2) NULL COMMENT '권한 구분 c:회사, b: 사업장, d:부서, u:사용자' AFTER `emp_seq`;
ALTER TABLE `t_exnp_consauth` ADD COLUMN IF NOT EXISTS `seq` VARCHAR(32) NULL COMMENT '권한 구분에 따른 키' AFTER `gbn_org`;

/*  - 양식정보 t_exnp_form 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_form` (
  `form_seq` VARCHAR(32) NOT NULL,
  `comp_seq` VARCHAR(32) NOT NULL,
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` DATETIME DEFAULT NULL,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` DATETIME DEFAULT NULL,
  PRIMARY KEY (`form_seq`,`comp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `t_exnp_form` ADD COLUMN IF NOT EXISTS `form_content` TEXT  COMMENT '원본 양식 폼' AFTER `comp_seq`;
ALTER TABLE `t_exnp_form` ADD COLUMN IF NOT EXISTS `form_change_content` TEXT  COMMENT '클래스 보정 처리된 실제 사용 폼' AFTER `form_content`;

/*  - 양식코드정보 t_exnp_form_code 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_form_code` (
  `code` VARCHAR(288) DEFAULT NULL,
  `code_name` VARCHAR(576) DEFAULT NULL,
  `code_gbn` VARCHAR(288) DEFAULT NULL,
  `use_yn` CHAR(9) DEFAULT NULL,
  `required_yn` CHAR(9) DEFAULT NULL,
  `create_seq` VARCHAR(288) DEFAULT NULL,
  `create_date` DATETIME DEFAULT NULL,
  `modify_seq` VARCHAR(288) DEFAULT NULL,
  `modify_date` DATETIME DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/*  - 양식 샘플 정보 t_exnp_form_sample 테이블 생성*/
CREATE TABLE IF NOT EXISTS `t_exnp_form_sample` (
  `seq` INT(11) DEFAULT NULL,
  `comp_seq` VARCHAR(288) DEFAULT NULL,
  `sample_name` VARCHAR(2295) DEFAULT NULL,
  `sample_content` TEXT,
  `create_seq` VARCHAR(288) DEFAULT NULL,
  `create_date` DATETIME DEFAULT NULL,
  `modify_seq` VARCHAR(288) DEFAULT NULL,
  `modify_date` DATETIME DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/*  - 비영리 회계 모듈 옵션 t_exnp_option 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_option` (
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 회사시퀀스 ( 기본 0 )',
  `form_seq` VARCHAR(32) NOT NULL COMMENT '옵션 귀속 양식코드 ( 기본 0 )',
  `option_gbn` VARCHAR(32) NOT NULL COMMENT '옵션 구분 코드',
  `option_code` VARCHAR(32) NOT NULL COMMENT '옵션 상세 코드', 
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`comp_seq`,`form_seq`,`option_gbn`,`option_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `note` VARCHAR(128) NULL COMMENT '옵션 설명' AFTER `option_code`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `use_sw` VARCHAR(32) NULL COMMENT '옵션 귀속 연동 시스템' AFTER `note`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `order_num` VARCHAR(32) NULL COMMENT '정렬순서' AFTER `use_sw`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `common_code` VARCHAR(32) NULL COMMENT '공통코드' AFTER `order_num`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `base_value` VARCHAR(32) NULL COMMENT '옵션 기본 설정 코드' AFTER `common_code`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `base_name` VARCHAR(32) NULL COMMENT '옵션 기본 설정' AFTER `base_value`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `base_emp_value` VARCHAR(32) NULL COMMENT '옵션 기본 설정 사용자 정의' AFTER `base_name`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `set_value` VARCHAR(32) NULL COMMENT '옵션 설정 코드' AFTER `base_emp_value`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `set_name` VARCHAR(128) NULL COMMENT '옵션 설정 명칭' AFTER `set_value`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `set_emp_value` VARCHAR(128) NULL COMMENT '옵션 설정 사용자 정의' AFTER `set_name`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `option_select_type` VARCHAR(32) NULL COMMENT '옵션 표시 방법 ( CHECKBOX / COMBOBOX / TEXT )' AFTER `set_emp_value`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `option_process_type` VARCHAR(32) NULL COMMENT '프로세스 처리 방법 ( YN / DATETIME / DATEDIFF / SHOWHIDE / IPLX / ETC )' AFTER `option_select_type`;
ALTER TABLE `t_exnp_option` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(32) NULL COMMENT '사용여부' AFTER `option_process_type`;

/*  - 비영리 회부시스템 연동 테이블 t_exnp_out_process 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_out_process` (
  `interface_id` VARCHAR(32) NOT NULL COMMENT '외부 연동 구분 키',
  `create_seq` VARCHAR(32) DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` VARCHAR(32) DEFAULT NULL,
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,    
  PRIMARY KEY (`interface_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `t_exnp_out_process` ADD COLUMN IF NOT EXISTS `iframe_url` VARCHAR(1024) NULL COMMENT '외부 연동 iframe url ( outProcessInterfaceId, outProcessInterfaceMId, outProcessInterfaceDId, consDocSeq, resDocSeq )' AFTER `interface_id`;
ALTER TABLE `t_exnp_out_process` ADD COLUMN IF NOT EXISTS `iframe_height` VARCHAR(4) NULL COMMENT '외부 연동 iframe 높이' AFTER `iframe_url`;
ALTER TABLE `t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_form` VARCHAR(1024) NULL COMMENT '외부 연동 본문 호출할 URL 정의' AFTER `iframe_height`;
ALTER TABLE `t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_save` VARCHAR(1024) NULL COMMENT '임시보관시 호출할 URL 정의' AFTER `interface_call_form`;
ALTER TABLE `t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_approval` VARCHAR(1024) NULL COMMENT '상신시 호출할 URL 정의' AFTER `interface_call_save`;
ALTER TABLE `t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_return` VARCHAR(1024) NULL COMMENT '반려시 호출할 URL 정의' AFTER `interface_call_approval`;
ALTER TABLE `t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_end` VARCHAR(1024) NULL COMMENT '종결시 호출할 URL 정의' AFTER `interface_call_return`;
ALTER TABLE `t_exnp_out_process` ADD COLUMN IF NOT EXISTS `interface_call_delete` VARCHAR(1024) NULL COMMENT '삭제시 호출할 URL 정의' AFTER `interface_call_end`;
ALTER TABLE `t_exnp_out_process` ADD COLUMN IF NOT EXISTS `licence` VARCHAR(64) NULL COMMENT '라이센스 키' AFTER `interface_call_delete`;

/*  - 비영리 회부시스템 연동 테이블 t_exnp_out_process_his 테이블 생성 */
CREATE TABLE IF NOT EXISTS `t_exnp_out_process_his` (
  `seq` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '호출 시퀀스',
  `create_seq` VARCHAR(32) NOT NULL COMMENT '생성자',
  `create_date` DATETIME NOT NULL COMMENT '생성일자',
  `modify_seq` VARCHAR(32) NOT NULL COMMENT '수정자',
  `modify_date` DATETIME NOT NULL COMMENT '수정일자',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `t_exnp_out_process_his` ADD COLUMN IF NOT EXISTS `interface_type` VARCHAR(8) NULL COMMENT '호출 타입 ( process id )' AFTER `seq`;
ALTER TABLE `t_exnp_out_process_his` ADD COLUMN IF NOT EXISTS `approval_status_code` VARCHAR(8) NULL COMMENT '전자결재 상태 값' AFTER `interface_type`;
ALTER TABLE `t_exnp_out_process_his` ADD COLUMN IF NOT EXISTS `interface_url` VARCHAR(8) NULL COMMENT 'API 호출 URL' AFTER `approval_status_code`;
ALTER TABLE `t_exnp_out_process_his` ADD COLUMN IF NOT EXISTS `interface_param` VARCHAR(8) NULL COMMENT 'API 전달 파라미터' AFTER `interface_url`;

/* ERPiU 기타소득자, 사업소득자 연동 정보 ( 지급일자, 귀속년월 ) */
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_belong_date` VARCHAR(8) NULL COMMENT 'ERPiU 기타,사업소득자 지급일자' AFTER `etc_belong_month`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_belong_yearmonth` VARCHAR(8) NULL COMMENT 'ERPiU 기타,사업소득자 귀속년월' AFTER `etc_belong_date`;

/* 2016. 12. 26. */
/* 2016. 12. 26. - 김상겸 */
/* 2016. 12. 26. - 김상겸 - 스마트 자금관리 테이블 추가 */
CREATE TABLE IF NOT EXISTS `t_smart_authcode` (
  `auth_code` VARCHAR(30) NOT NULL COMMENT '권한코드',
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '그룹웨어 시퀀스',
  `use_yn` CHAR(1) DEFAULT 'Y' COMMENT '사용여부',
  `order_num` INT(4) DEFAULT NULL COMMENT '정렬순서',
  `etc` VARCHAR(255) DEFAULT NULL COMMENT '비고',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '등록자',
  `create_date` DATETIME DEFAULT NULL COMMENT '등록일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`comp_seq`,`auth_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_smart_authcode_emp` (
  `auth_code` VARCHAR(30) NOT NULL COMMENT '권한코드',
  `emp_seq` VARCHAR(32) NOT NULL COMMENT '사용자 시퀀스',
  `comp_seq` VARCHAR(32) NOT NULL COMMENT '회사 시퀀스',
  `dept_seq` VARCHAR(32) NOT NULL COMMENT '부서 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '등록자 시퀀스',
  `create_date` DATETIME DEFAULT NULL COMMENT '등록일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자 시퀀스',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`auth_code`,`emp_seq`,`comp_seq`,`dept_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_smart_authcode_menu` (
  `auth_code` VARCHAR(30) NOT NULL COMMENT '권한코드',
  `menu_code` VARCHAR(30) NOT NULL COMMENT '메뉴코드',
  `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '사용자 시퀀스',
  `erp_co_cd` VARCHAR(32) NOT NULL COMMENT 'erp 회사코드',
  `erp_biz_cd` VARCHAR(32) DEFAULT NULL COMMENT 'erp 사업장코드',
  `erp_co_cd_name` VARCHAR(32) NOT NULL COMMENT 'erp 회사명칭',
  `erp_biz_cd_name` VARCHAR(32) DEFAULT NULL COMMENT 'erp 사업장명칭',
  `use_yn` CHAR(2) DEFAULT 'Y' COMMENT '사용여부',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '등록자 시퀀스',
  `create_date` DATETIME DEFAULT NULL COMMENT '등록일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자 시퀀스',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자'
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_smart_authcode_menu` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NOT NULL  COMMENT '그룹웨어 회사 시퀀스' AFTER `use_yn`;

CREATE TABLE IF NOT EXISTS `t_smart_authcode_multi` (
  `auth_code` VARCHAR(30) NOT NULL COMMENT '권한코드',
  `auth_code_nm` VARCHAR(60) NOT NULL COMMENT '권한코드 이름',
  `lang_code` VARCHAR(32) NOT NULL COMMENT '언어코드',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '등록자 시퀀스',
  `create_date` DATETIME DEFAULT NULL COMMENT '등록일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자 시퀀스',
  `modify_date` DATETIME DEFAULT NULL COMMENT '수정일자',
  PRIMARY KEY (`auth_code`,`lang_code`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* --------------------------------------------------------------------------------------------- */
/* \rel_script\mariadb\BizboxA\ANBOJO\01_anbojo_mariadb_table.sql */
/* \rel_script\mariadb\BizboxA\EX\01_ex_mariadb_table.sql */
/* \rel_script\mariadb\BizboxA\EZBARO\01_ez_mariadb_table.sql */
/* \rel_script\mariadb\BizboxA\G20\01_g20_mariadb_table.sql */
/* \rel_script\mariadb\BizboxA\NP\01_np_mariadb_table.sql */
/* \rel_script\mariadb\BizboxA\SMART\01_smart_mariadb_table.sql */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 0.0 */
/* 여기까지 배포 완료 ( 배포일 : 2018. 12. 13. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */


/* 여기까지 확인 */

CREATE TABLE IF NOT EXISTS `t_exnp_code_seq` (
  `seq` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '양식 코드 시퀀스',
   PRIMARY KEY (`seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


/* 배포 추가 확인 필요. */
CREATE TABLE IF NOT EXISTS `t_ex_smartoption` (
  `option_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  `code` VARCHAR(32) NOT NULL COMMENT '옵션코드',
  `value` VARCHAR(32) NOT NULL COMMENT '옵션 설정값',
  `note` VARCHAR(32) NOT NULL COMMENT '옵션 메모',
  PRIMARY KEY (`option_seq`)
) ENGINE=INNODB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;


/* 배포 추가 확인 필요. */
CREATE TABLE IF NOT EXISTS `t_ex_card_transfer` (
  `seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'seq',
  PRIMARY KEY (`seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사SEQ' AFTER `seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `sync_id` BIGINT(20) NULL COMMENT '카드 승인 내역 고유 키' AFTER `comp_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `card_num` VARCHAR(16) NULL COMMENT '카드번호' AFTER `sync_id`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `auth_num` VARCHAR(20) NULL COMMENT '카드승인번호' AFTER `card_num`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `auth_date` CHAR(8) NULL COMMENT '승인일자' AFTER `auth_num`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `auth_time` CHAR(6) NULL COMMENT '승인시간' AFTER `auth_date`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `partner_no` VARCHAR(32) NULL COMMENT '공급자 사업자등록번호' AFTER `auth_time`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `partner_name` VARCHAR(128) NULL COMMENT '공급자 명' AFTER `partner_no`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `amt` DECIMAL(19,0) NULL COMMENT '세금계산서 금액' AFTER `partner_name`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `transfer_seq` VARCHAR(32) NULL COMMENT '이관 한 사원 번호' AFTER `amt`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `transfer_name` VARCHAR(128) NULL COMMENT '이관 한 사원 이름' AFTER `transfer_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `receive_seq` VARCHAR(32) NULL COMMENT '이관 받은 사원 번호' AFTER `transfer_name`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `receive_name` VARCHAR(128) NULL COMMENT '이관 받은 사원 이름' AFTER `receive_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(2)  DEFAULT 'Y' COMMENT '사용 여부 ( 사용 : Y / 미사용 : N )' AFTER `receive_name`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `use_yn_emp_seq` VARCHAR(32) NULL COMMENT '사용 여부 설정 사용자 시퀀스' AFTER `use_yn`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `supper_key` VARCHAR(32) NULL COMMENT '조직도팝업 슈퍼키' AFTER `use_yn_emp_seq`;
ALTER TABLE `t_ex_card_transfer` ADD COLUMN IF NOT EXISTS `create_date` DATETIME NULL COMMENT '이관일자' AFTER `supper_key`;


/* 2019. 1. 10. */
/* 2019. 1. 10. - 이준성 */
/* 2019. 1. 10. - 이준성 - 국세청 번호 및 부서코드 (양식) 추가 */
ALTER TABLE `t_ex_etax_aq_tmp` ADD COLUMN hometax_iss_no VARCHAR(55) DEFAULT NULL COMMENT '국세청 번호';

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 6.7 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 01. 10. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

ALTER TABLE `t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(2)  DEFAULT 'Y' COMMENT '사용 여부 ( 사용 : Y / 미사용 : N )' AFTER `budget_seq`;
ALTER TABLE `t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS `use_yn_emp_seq` VARCHAR(32) NULL COMMENT '사용 여부 설정 사용자 시퀀스' AFTER `use_yn`;

/* 2019. 1. 16. */
/* 2019. 1. 16. - 허준녕 */
/* 2019. 1. 16. - 허준녕 - 21억 초과 금액 대응 속성 타입 변경 */
ALTER TABLE `g20_abdocu_b` MODIFY apply_am BIGINT(19);
ALTER TABLE `g20_abdocu_b` MODIFY open_am BIGINT(19);
ALTER TABLE `g20_abdocu_b` MODIFY left_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY wd_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY ndep_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY inad_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY intx_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY rstx_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY unit_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY sup_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY vat_am BIGINT(19);

/* 2019. 2. 7. */
/* 2019. 2. 7. - 박용욱 */
/* 2019. 2. 7. - 박용욱 - 법인카드 승인번호 컬럼 사이즈 조정 ( 기존 20 -> 50 )  */
ALTER TABLE `t_ex_card_aq_tmp` MODIFY auth_num VARCHAR(50);

/* 2019. 2. 15. */
/* 2019. 2. 15. - 최상배 */
/* 2019. 2. 15. - 최상배 - 비영리 2.0 회사 품의 전체 조회 권한 테이블 생성  */
CREATE TABLE IF NOT EXISTS `t_exnp_cons_auth` (
	`cons_auth_seq` INT(11) NOT NULL AUTO_INCREMENT COMMENT '회사 품의서 조회 권한 시퀀스',
	`create_seq` VARCHAR(32) DEFAULT NULL COMMENT '',
	`create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
	`modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '',
	`modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '',
	PRIMARY KEY (`cons_auth_seq`),
	KEY `cons_auth_seq` (`cons_auth_seq`)
) ENGINE=INNODB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_cons_auth` ADD IF NOT EXISTS `group_seq` VARCHAR(32) DEFAULT NULL COMMENT '고객사 group_seq' AFTER `cons_auth_seq`;
ALTER TABLE `t_exnp_cons_auth` ADD IF NOT EXISTS `emp_seq` VARCHAR(32) DEFAULT NULL COMMENT '고객사 group_seq' AFTER `cons_auth_seq`;
ALTER TABLE `t_exnp_cons_auth` ADD IF NOT EXISTS `emp_name` VARCHAR(128) DEFAULT NULL COMMENT '고객사 group_seq' AFTER `cons_auth_seq`;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 7.0 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 02. 15. 16:15 ) - 김상겸 */
/* --------------------------------------------------------------------------------------------- */

ALTER TABLE `t_exnp_cons_auth` ADD IF NOT EXISTS `comp_name` VARCHAR(128) DEFAULT NULL COMMENT '회사 명' AFTER cons_auth_seq;
ALTER TABLE `t_exnp_cons_auth` ADD IF NOT EXISTS `comp_seq` VARCHAR(32) DEFAULT NULL COMMENT '회사 키' AFTER comp_name;
ALTER TABLE `t_exnp_cons_auth` ADD IF NOT EXISTS `dept_name` VARCHAR(32) DEFAULT NULL COMMENT '부서 명' AFTER comp_seq;
ALTER TABLE `t_exnp_cons_auth` ADD IF NOT EXISTS `dept_seq` VARCHAR(128) DEFAULT NULL COMMENT '부서 키' AFTER dept_name;
ALTER TABLE `t_exnp_cons_auth` ADD IF NOT EXISTS `super_key` VARCHAR(60) DEFAULT NULL COMMENT '조직도 슈퍼 키' AFTER group_seq;


/* 2019. 1. 28. */
/* 2019. 1. 28. - 최상배 */
/* 2019. 1. 28. - 최상배 - 예산 7단계 옵션 대응 테이블 컬럼 추가 */
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level01_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 1단계' AFTER `erp_bgt4_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level01_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 1단계' AFTER `erp_level01_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level02_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 2단계' AFTER `erp_level01_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level02_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 2단계' AFTER `erp_level02_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level03_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 3단계' AFTER `erp_level02_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level03_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 3단계' AFTER `erp_level03_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level04_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 4단계' AFTER `erp_level03_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level04_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 4단계' AFTER `erp_level04_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level05_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 5단계' AFTER `erp_level04_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level05_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 5단계' AFTER `erp_level05_seq`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level06_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 6단계' AFTER `erp_level05_name`;
ALTER TABLE `t_exnp_resbudget` ADD COLUMN IF NOT EXISTS `erp_level06_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 6단계' AFTER `erp_level06_seq`;

ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level01_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 1단계' AFTER `erp_bgt4_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level01_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 1단계' AFTER `erp_level01_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level02_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 2단계' AFTER `erp_level01_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level02_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 2단계' AFTER `erp_level02_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level03_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 3단계' AFTER `erp_level02_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level03_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 3단계' AFTER `erp_level03_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level04_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 4단계' AFTER `erp_level03_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level04_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 4단계' AFTER `erp_level04_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level05_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 5단계' AFTER `erp_level04_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level05_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 5단계' AFTER `erp_level05_seq`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level06_seq`  NVARCHAR(64) NULL COMMENT '예산 7단계 코드_ 6단계' AFTER `erp_level05_name`;
ALTER TABLE `t_exnp_consbudget` ADD COLUMN IF NOT EXISTS `erp_level06_name` NVARCHAR(64) NULL COMMENT '예산 7단계 명칭_ 6단계' AFTER `erp_level06_seq`;

/* 2019. 1. 16. */
/* 2019. 1. 16. - 허준녕 */
/* 2019. 1. 16. - 허준녕 - 21억 초과 금액 대응 속성 타입 변경 */
ALTER TABLE `g20_abdocu_b` MODIFY apply_am BIGINT(19);
ALTER TABLE `g20_abdocu_b` MODIFY open_am BIGINT(19);
ALTER TABLE `g20_abdocu_b` MODIFY left_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY wd_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY ndep_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY inad_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY intx_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY rstx_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY unit_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY sup_am BIGINT(19);
ALTER TABLE g20_Abdocu_t MODIFY vat_am BIGINT(19);

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 7.0 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 03. 08. 16:15 ) - 허준 */


/* 2019. 3. 11. */
/* 2019. 3. 11. - 권오광 */
/* 2019. 3. 11. - 권오광 - [공통] 항목정보 수정 시 정렬순서 유지 기능개발을 위한 컬럼 추가 */
ALTER TABLE `t_ex_expend_list` ADD COLUMN IF NOT EXISTS `order_seq` INT(11) DEFAULT '0' COMMENT '정렬순서' AFTER `auto_calc_yn`;


ALTER TABLE `t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(2)  DEFAULT 'Y' COMMENT '사용 여부 ( 사용 : Y / 미사용 : N )' AFTER `budget_seq`;
ALTER TABLE `t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS `use_yn_emp_seq` VARCHAR(32) NULL COMMENT '사용 여부 설정 사용자 시퀀스' AFTER `use_yn`;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 7.3 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 03. 14. 17:27 ) - 이준 */

/* 2019. 4. 12. */
/* 2019. 4. 12. - 최상배 */
/* 2019. 4. 12. - 최상배 - [영리/비영리 공통]  추가 확장 인터페이스 기능을 위한 테이블 추가 */
CREATE TABLE IF NOT EXISTS `t_ex_adv_interinfo` (
	`method_name` VARCHAR(128) DEFAULT NULL COMMENT '추가 확장 메소드 명',
	`method_note` VARCHAR(128) DEFAULT NULL COMMENT '확장기능 기능 설명',
	`create_seq` VARCHAR(32) DEFAULT NULL COMMENT '최초 작성자',
	`create_date` DATETIME DEFAULT NULL COMMENT '최초 작성일',
	`modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '최종 수정자',
	`modify_date` DATETIME DEFAULT NULL COMMENT '최종 수정일'
) ENGINE=INNODB AUTO_INCREMENT=810 DEFAULT CHARSET=utf8;

/* 2019. 4. 29. */
/* 2019. 4. 29. - 허준녕 */
/* 2019. 4. 29. - 허준녕 - [비영리 2.0] 한글코드 거래처 주소 추가를 위한 테이블 컬럼 추가 */
ALTER TABLE t_exnp_restrade ADD COLUMN IF NOT EXISTS tr_addr VARCHAR(50) COMMENT '거래처 주소' AFTER tr_name;

/* 2019. 4. 29. */
/* 2019. 4. 29. - 허준녕 */
/* 2019. 4. 29. - 허준녕 - [비영리 2.0] IU 사업 계획명 길이 확장 */
ALTER TABLE t_exnp_resbudget MODIFY COLUMN erp_bizplan_name VARCHAR(128) DEFAULT NULL COMMENT '[U] 사업 계획 명';
ALTER TABLE t_exnp_resbudget MODIFY COLUMN erp_fiacct_name VARCHAR(128) DEFAULT NULL COMMENT '[U] 회계 계정 명';
ALTER TABLE t_exnp_resbudget MODIFY COLUMN erp_bgacct_name VARCHAR(128) DEFAULT NULL COMMENT '[U] 예산 계정 명';

ALTER TABLE t_exnp_consbudget MODIFY COLUMN erp_bizplan_name VARCHAR(128) DEFAULT NULL COMMENT '[U] 사업 계획 명';
ALTER TABLE t_exnp_consbudget MODIFY COLUMN erp_fiacct_name VARCHAR(128) DEFAULT NULL COMMENT '[U] 회계 계정 명';
ALTER TABLE t_exnp_consbudget MODIFY COLUMN erp_bgacct_name VARCHAR(128) DEFAULT NULL COMMENT '[U] 노드 [G:예산코드 U:예산계정] 명칭';

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 82 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 05. 23. 17:27 ) - 이준성  */

ALTER TABLE `t_ex_button` ADD COLUMN IF NOT EXISTS `ext_url` VARCHAR(1024)  DEFAULT NULL COMMENT '확장 URL ( 외부연동 대응용 )' AFTER `default_elemClass`;

ALTER TABLE t_ex_button MODIFY COLUMN ext_url VARCHAR(1024) DEFAULT NULL COMMENT '확장 URL ( 외부연동 대응용 )';


/* 2019-06-12 */
/* 2019-06-12 - 최상배 */
/* 2019-06-12 - 최상배 - [] */
ALTER TABLE t_exnp_restrade ADD COLUMN IF NOT EXISTS `etc_data_cd` VARCHAR(2) NULL COMMENT '기타소득자 거주구분 코드' AFTER `reg_date`;

/* 2019-06-19 */
/* 2019-06-19 - 김상겸 */
ALTER TABLE t_ex_mng_option MODIFY COLUMN ctd_name VARCHAR(100) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '관리항목 사용자 입력명';


/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 88 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 07. 04. 17:50 ) - 이준성  */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 89 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 07. 11. 17:50 ) - 김상겸  */


/* 2019-07-15 */
/* 2019-07-15 - 최상배 */
/* 법인카드 승인내역 조회 성능 오류 방지를 위한 INDEX추가 배포 */
ALTER TABLE t_ex_card_public ADD INDEX IF NOT EXISTS `orgIdx` (`org_div`, `org_id`); 
ALTER TABLE t_ex_card_transfer ADD INDEX IF NOT EXISTS `cardIdx` (`card_num`); 
ALTER TABLE t_ex_card ADD INDEX IF NOT EXISTS `cardIdx` (`card_num`); 

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 90 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 07. 18. 17:50 ) - 김상겸  */


/* 2019-07-31 */
/* 2019-07-31 - 이승환 */
/* 출장복명 2.0  테이블 추가 */
CREATE TABLE IF NOT EXISTS `t_exnp_trip_cons_doc` (
  `trip_cons_doc_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장 품의 문서 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`trip_cons_doc_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `doc_seq` VARCHAR(32) NULL COMMENT '전자결재 문서 코드' AFTER `trip_cons_doc_seq`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `doc_status` VARCHAR(32) NULL COMMENT '전자결재 문서 상태' AFTER `doc_seq`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `doc_no` VARCHAR(128) NULL COMMENT '전자결재 문서 번호' AFTER `doc_status`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `appro_date` DATETIME NULL COMMENT '기안일자' AFTER `doc_no`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `group_seq` VARCHAR(32) NULL COMMENT '그룹코드' AFTER `appro_date`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `group_seq`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `dept_seq` VARCHAR(32) NULL COMMENT '부서 코드' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `dept_name` VARCHAR(128) NULL COMMENT '부서 명' AFTER `dept_seq`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT '사용자 코드' AFTER `dept_name`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT '사용자 명' AFTER `emp_seq`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(32) NULL COMMENT 'ERP 회사 코드' AFTER `emp_name`;
ALTER TABLE `t_exnp_trip_cons_doc` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(32) NULL COMMENT 'ERP 사번 코드' AFTER `erp_comp_seq`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_cons_expense` (
  `expense_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장 품의 경비내역 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`expense_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `trip_cons_doc_seq` BIGINT(32) NULL COMMENT '출장 품의 문서 코드' AFTER `expense_seq`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `amt_class_code` VARCHAR(2) NULL COMMENT '경비 내역 구분 코드' AFTER `trip_cons_doc_seq`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `amt_class_name` VARCHAR(32) NULL COMMENT '경비 내역 구분 명' AFTER `amt_class_code`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `expense_amt` BIGINT(32) NULL COMMENT '경비 금액' AFTER `amt_class_name`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `expense_amt`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명칭' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT '경비 내역 사용자 코드' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT '경비 내역 사용자 명' AFTER `emp_seq`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `duty_item_seq` BIGINT(32) NULL COMMENT '직책 코드' AFTER `emp_name`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `duty_name` VARCHAR(128) NULL COMMENT '직책 명' AFTER `duty_item_seq`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `duty_group_seq` BIGINT(32) NULL COMMENT '직책 그룹 코드' AFTER `duty_name`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `transport_seq` BIGINT(32) NULL COMMENT '이동수단 코드' AFTER `duty_group_seq`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `location_seq` BIGINT(32) NULL COMMENT '출장지 코드' AFTER `transport_seq`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `amt_seq` BIGINT(32) NULL COMMENT '경비 설정 코드' AFTER `location_seq`;
ALTER TABLE `t_exnp_trip_cons_expense` ADD COLUMN IF NOT EXISTS `domestic_code` VARCHAR(2) NULL COMMENT '국내외 구분 0 : 국내, 1 : 국외' AFTER `amt_seq`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_cons_traveler` (
  `traveler_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장자 정보 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`traveler_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `trip_cons_doc_seq` BIGINT(32) NULL COMMENT '출장 품의 문서 코드' AFTER `traveler_seq`;
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `attend_seq` BIGINT(32) NULL COMMENT '출장 품의 출장 정보 코드' AFTER `trip_cons_doc_seq`;
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `attend_seq`;
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명칭' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `dept_seq` VARCHAR(32) NULL COMMENT '부서 코드' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `dept_name` VARCHAR(128) NULL COMMENT '부서 명' AFTER `dept_seq`;
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT '사용자 코드' AFTER `dept_name`;  
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT '사용자 명' AFTER `emp_seq`;  
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `duty_item_seq` BIGINT(32) NULL COMMENT '직책 코드' AFTER `emp_name`;
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `duty_name` VARCHAR(128) NULL COMMENT '직책 명' AFTER `duty_item_seq`;
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `duty_group_seq` BIGINT(32) NULL COMMENT '직책 그룹 코드' AFTER `duty_name`;  
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `schm_seq` VARCHAR(32) NULL COMMENT '일정 마스터 키' AFTER `duty_group_seq`;  
ALTER TABLE `t_exnp_trip_cons_traveler` ADD COLUMN IF NOT EXISTS `sch_seq` VARCHAR(32) NULL COMMENT '일정 키' AFTER `schm_seq`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_cons_attend` (
  `attend_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장 품의서 출장 정보 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`attend_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `trip_cons_doc_seq` BIGINT(32) NULL COMMENT '출장 품의서 문서 키' AFTER `attend_seq`;
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `domestic_code` VARCHAR(2) DEFAULT '0' COMMENT '국내외 구분 0 : 국내, 1 : 국외' AFTER `trip_cons_doc_seq`;
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `trip_from_date` DATETIME(6) NULL COMMENT '출장 시작 일시' AFTER `domestic_code`;
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `trip_to_date` DATETIME(6) NULL COMMENT '출장 종료 일시' AFTER `trip_from_date`;
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `calendar_seq` VARCHAR(32) NULL COMMENT '연동 일정 코드' AFTER `trip_to_date`;
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `calendar_name` VARCHAR(128) NULL COMMENT '연동 일정 명칭' AFTER `calendar_seq`;  
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `location_seq` BIGINT(32) NULL COMMENT '출장지 코드' AFTER `calendar_name`;  
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `location_name` VARCHAR(128) NULL COMMENT '출장지 명칭' AFTER `location_seq`;
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `location_adv` VARCHAR(128) NULL COMMENT '출장지 추가 입력 내용' AFTER `location_name`;
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `transport_seq` VARCHAR(512) NULL COMMENT '교통수단 코드' AFTER `location_adv`;  
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `transport_name` VARCHAR(512) NULL COMMENT '교통수단 명칭' AFTER `transport_seq`;  
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `purpose` VARCHAR(128) NULL COMMENT '목적' AFTER `transport_name`;
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `trip_expense_code` VARCHAR(2) NULL COMMENT '여비지급 대상여부 0: 대상, 1: 비 대상' AFTER `purpose`;
ALTER TABLE `t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `org_data_info` TEXT NULL COMMENT '출장자 정보 JSON' AFTER `trip_expense_code`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_cons_budget` (
  `trip_budget_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장 품의 예산 정보 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`trip_budget_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_trip_cons_budget` ADD COLUMN IF NOT EXISTS `trip_cons_doc_seq` BIGINT(32) NULL COMMENT '출장 품의서 문서 키' AFTER `trip_budget_seq`;
ALTER TABLE `t_exnp_trip_cons_budget` ADD COLUMN IF NOT EXISTS `cons_doc_seq` BIGINT(32) NULL COMMENT '비영리 2.0 품의 문서 키' AFTER `trip_cons_doc_seq`;
ALTER TABLE `t_exnp_trip_cons_budget` ADD COLUMN IF NOT EXISTS `budget_amt` BIGINT(32) NULL COMMENT '품의 총 금액' AFTER `cons_doc_seq`;
ALTER TABLE `t_exnp_trip_cons_budget` ADD COLUMN IF NOT EXISTS `conffer_budget_return_yn` VARCHAR(2) NULL COMMENT '품의서 환원 여부 N: 미환원, Y: 환원' AFTER `budget_amt`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_cons_budget_erp` (
  `budget_erp_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ERP 예산정보 테이블 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`budget_erp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `trip_cons_doc_seq` BIGINT(32) NULL COMMENT '출장 품의 문서 코드' AFTER `budget_erp_seq`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `trip_budget_seq` BIGINT(32) NULL COMMENT '출장 품의 예산 코드' AFTER `trip_cons_doc_seq`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT 'ERP 회계단위 코드' AFTER `trip_budget_seq`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(128) NULL COMMENT 'ERP 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `erp_mgt_seq` VARCHAR(32) NULL COMMENT 'ERP 프로젝트/부서 코드' AFTER `erp_div_name`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `erp_mgt_name` VARCHAR(128) NULL COMMENT 'ERP 프로젝트/부서 명' AFTER `erp_mgt_seq`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `erp_budget_seq` VARCHAR(32) NULL COMMENT 'ERP 예산과목 코드' AFTER `erp_mgt_name`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `erp_budget_name` VARCHAR(128) NULL COMMENT 'ERP 예산과목 명' AFTER `erp_budget_seq`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `erp_open_amt` BIGINT(32) NULL COMMENT 'ERP 편성금액' AFTER `erp_budget_name`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `erp_apply_amt` BIGINT(32) NULL COMMENT 'ERP 집행금액' AFTER `erp_open_amt`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `erp_left_amt` BIGINT(32) NULL COMMENT 'ERP 예산잔액' AFTER `erp_apply_amt`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_res_doc` (
  `trip_res_doc_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장 결의 문서 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  PRIMARY KEY (`trip_res_doc_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `doc_seq` VARCHAR(32) NULL COMMENT '전자결재 문서 코드' AFTER `trip_res_doc_seq`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `doc_status` VARCHAR(32) NULL COMMENT '전자결재 문서 상태' AFTER `doc_seq`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `doc_no` VARCHAR(128) NULL COMMENT '전자결재 문서 번호' AFTER `doc_status`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `appro_date` DATETIME NULL COMMENT '기안일자' AFTER `doc_no`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `group_seq` VARCHAR(32) NULL COMMENT '그룹 코드' AFTER `appro_date`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `group_seq`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `dept_seq` VARCHAR(32) NULL COMMENT '부서 코드' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `dept_name` VARCHAR(128) NULL COMMENT '부서 명' AFTER `dept_seq`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT '사용자 코드' AFTER `dept_name`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT '사용자 명' AFTER `emp_seq`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `erp_emp_seq` VARCHAR(32) NULL COMMENT 'ERP 사번 코드' AFTER `emp_name`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `erp_comp_seq` VARCHAR(32) NULL COMMENT 'ERP 회사 코드' AFTER `erp_emp_seq`;
ALTER TABLE `t_exnp_trip_res_doc` ADD COLUMN IF NOT EXISTS `conffer_trip_doc_seq` BIGINT(32) NULL COMMENT '참조 출장 품의 문서 코드' AFTER `erp_comp_seq`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_res_expense` (
  `expense_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장 품의 경비내역 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`expense_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `trip_res_doc_seq` BIGINT(32) NULL COMMENT '출장 결의 문서 코드' AFTER `expense_seq`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `amt_class_code` VARCHAR(2) NULL COMMENT '경비 내역 구분 코드' AFTER `trip_res_doc_seq`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `amt_class_name` VARCHAR(32) NULL COMMENT '경비 내역 구분 명' AFTER `amt_class_code`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `expense_amt` BIGINT(32) NULL COMMENT '경비 금액' AFTER `amt_class_name`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `expense_amt`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT '사용자 코드' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT '사용자 명' AFTER `emp_seq`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `duty_item_seq` BIGINT(32) NULL COMMENT '직책 코드' AFTER `emp_name`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `duty_name` VARCHAR(128) NULL COMMENT '직책 명' AFTER `duty_item_seq`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `duty_group_seq` BIGINT(32) NULL COMMENT '직책 그룹 코드' AFTER `duty_name`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `transport_seq` BIGINT(32) NULL COMMENT '이동수단 코드' AFTER `duty_group_seq`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `location_seq` BIGINT(32) NULL COMMENT '출장지 코드' AFTER `transport_seq`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `amt_seq` BIGINT(32) NULL COMMENT '경비 설정 코드' AFTER `transport_seq`;
ALTER TABLE `t_exnp_trip_res_expense` ADD COLUMN IF NOT EXISTS `domestic_code` VARCHAR(2) NULL COMMENT '국내외 구분 0 : 국내, 1 : 국외' AFTER `amt_seq`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_res_traveler` (
  `traveler_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장자 정보 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`traveler_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `trip_res_doc_seq` BIGINT(32) NULL COMMENT '출장 결의 문서 코드' AFTER `traveler_seq`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `attend_seq` BIGINT(32) NULL COMMENT '출장 결의 출장 정보 코드' AFTER `trip_res_doc_seq`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `attend_seq`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `dept_seq` VARCHAR(32) NULL COMMENT '부서 코드' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `dept_name` VARCHAR(128) NULL COMMENT '부서 명' AFTER `dept_seq`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT '사용자 코드' AFTER `dept_name`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT '사용자 명' AFTER `emp_seq`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `duty_item_seq` BIGINT(32) NULL COMMENT '직책 코드' AFTER `emp_name`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `duty_name` VARCHAR(128) NULL COMMENT '직책 명' AFTER `duty_item_seq`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `duty_group_seq` BIGINT(32) NULL COMMENT '직책 그룹 코드' AFTER `duty_name`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `schm_seq` VARCHAR(32) NULL COMMENT '일정 마스터 키' AFTER `duty_group_seq`;
ALTER TABLE `t_exnp_trip_res_traveler` ADD COLUMN IF NOT EXISTS `sch_seq` VARCHAR(32) NULL COMMENT '일정 연동 키' AFTER `schm_seq`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_res_attend` (
  `attend_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장 결의 출장 정보',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`attend_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `trip_res_doc_seq` BIGINT(32) NULL COMMENT '출장 결의 문서 키' AFTER `attend_seq`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `domestic_code` VARCHAR(2) DEFAULT '0' COMMENT '국내외 구분 0 : 국내, 1 : 국외' AFTER `trip_res_doc_seq`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `trip_from_date` DATETIME(6) NULL COMMENT '출장 시작 일시' AFTER `domestic_code`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `trip_to_date` DATETIME(6) NULL COMMENT '출장 종료 일시' AFTER `trip_from_date`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `calendar_seq` VARCHAR(32) NULL COMMENT '연동 일정 코드' AFTER `trip_to_date`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `calendar_name` VARCHAR(128) NULL COMMENT '연동 일정 명칭' AFTER `calendar_seq`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `location_seq` BIGINT(32) NULL COMMENT '출장지 코드' AFTER `calendar_name`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `location_name` VARCHAR(128) NULL COMMENT '출장지 명' AFTER `location_seq`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `location_adv` VARCHAR(128) NULL COMMENT '출장지 추가 입력 내용' AFTER `location_name`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `transport_seq` VARCHAR(512) NULL COMMENT '교통수단 코드' AFTER `location_adv`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `transport_name` VARCHAR(512) NULL COMMENT '교통수단 명칭' AFTER `transport_seq`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `purpose` VARCHAR(128) NULL COMMENT '목적' AFTER `transport_name`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `trip_expense_code` VARCHAR(2) NULL COMMENT '여비지급 대상여부 0: 대상, 1: 비 대상' AFTER `purpose`;
ALTER TABLE `t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `org_data_info` TEXT NULL COMMENT '출장자 조직도 정보 JSON' AFTER `trip_expense_code`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_res_budget` (  
  `trip_budget_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장 결의 금액 정보 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`trip_budget_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `t_exnp_trip_res_budget` ADD COLUMN IF NOT EXISTS `trip_res_doc_seq` BIGINT(32) NULL COMMENT '출장 결의 문서 코드' AFTER `trip_budget_seq`;
ALTER TABLE `t_exnp_trip_res_budget` ADD COLUMN IF NOT EXISTS `res_doc_seq` BIGINT(32) NULL COMMENT '비영리 2.0 결의 문서 키' AFTER `trip_res_doc_seq`;
ALTER TABLE `t_exnp_trip_res_budget` ADD COLUMN IF NOT EXISTS `budget_amt` BIGINT(32) NULL COMMENT '출장 결의 금액' AFTER `res_doc_seq`;
ALTER TABLE `t_exnp_trip_res_budget` ADD COLUMN IF NOT EXISTS `std_amt` BIGINT(32) NULL COMMENT '출장 결의 공급가액' AFTER `budget_amt`;
ALTER TABLE `t_exnp_trip_res_budget` ADD COLUMN IF NOT EXISTS `vat_amt` BIGINT(32) NULL COMMENT '출장 결의 부가세액' AFTER `std_amt`;
ALTER TABLE `t_exnp_trip_res_budget` ADD COLUMN IF NOT EXISTS `conffer_trip_doc_seq` BIGINT(32) NULL COMMENT '참조 출장 품의 문서 키' AFTER `vat_amt`;
ALTER TABLE `t_exnp_trip_res_budget` ADD COLUMN IF NOT EXISTS `conffer_trip_budget_seq` BIGINT(32) NULL COMMENT '참조 출장 품의 금액 키' AFTER `conffer_trip_doc_seq`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_res_budget_erp` (  
  `budget_erp_seq` BIGINT(32) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'ERP 예산정보 테이블 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`budget_erp_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `trip_res_doc_seq` BIGINT(32) NULL COMMENT '출장 결의 문서 코드' AFTER `budget_erp_seq`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `trip_budget_seq` BIGINT(32) NULL COMMENT '출장 결의 예산 코드' AFTER `trip_res_doc_seq`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `erp_div_seq` VARCHAR(32) NULL COMMENT 'ERP 회계단위 코드' AFTER `trip_budget_seq`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `erp_div_name` VARCHAR(128) NULL COMMENT 'ERP 회계단위 명' AFTER `erp_div_seq`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `erp_mgt_seq` VARCHAR(32) NULL COMMENT 'ERP 프로젝트/부서 코드' AFTER `erp_div_name`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `erp_mgt_name` VARCHAR(128) NULL COMMENT 'ERP 프로젝트/부서 명' AFTER `erp_mgt_seq`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `erp_budget_seq` VARCHAR(32) NULL COMMENT 'ERP 예산과목 코드' AFTER `erp_mgt_name`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `erp_budget_name` VARCHAR(128) NULL COMMENT 'ERP 예산과목 명' AFTER `erp_budget_seq`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `erp_open_amt` BIGINT(32) NULL COMMENT 'ERP 편성금액' AFTER `erp_budget_name`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `erp_apply_amt` BIGINT(32) NULL COMMENT 'ERP 집행금액' AFTER `erp_open_amt`;
ALTER TABLE `t_exnp_trip_res_budget_erp` ADD COLUMN IF NOT EXISTS `erp_left_amt` BIGINT(32) NULL COMMENT 'ERP 예산잔액' AFTER `erp_apply_amt`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_api` (
  `log_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'api 호출 시퀀스',
  `attend_seq` BIGINT(32) NOT NULL COMMENT '사용자 출장 정보 코드',
  `docu_mode` VARCHAR(2) NOT NULL DEFAULT '0' COMMENT '품의 결의 구분 0 : 품의, 1 : 결의',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`log_seq`,`docu_mode`,`attend_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `at_cons_doc_seq` BIGINT(32) NULL COMMENT '출장 품의 문서 코드' AFTER `docu_mode`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `at_res_doc_seq` BIGINT(32) NULL COMMENT '출장 결의 문서 코드' AFTER `at_cons_doc_seq`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `at_res_doc_seq`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `dept_seq` VARCHAR(32) NULL COMMENT '부서 코드' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `dept_name` VARCHAR(128) NULL COMMENT '부서 명' AFTER `dept_seq`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `emp_seq` VARCHAR(32) NULL COMMENT '사용자 코드' AFTER `dept_name`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `emp_name` VARCHAR(128) NULL COMMENT '사용자 명' AFTER `emp_seq`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `trip_from_date` DATETIME NULL COMMENT '출장 시작 일시' AFTER `emp_name`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `trip_to_date` DATETIME NULL COMMENT '출장 종료 일시' AFTER `trip_from_date`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `domestic_code` VARCHAR(2) NULL COMMENT '국내외 구분 0 : 국내, 1 : 국외' AFTER `trip_to_date`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `location_seq` VARCHAR(32) NULL COMMENT '출장지 정보 코드' AFTER `domestic_code`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `location_name` VARCHAR(128) NULL COMMENT '출장지 정보 명' AFTER `location_seq`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `duty_item_seq` VARCHAR(32) NULL COMMENT '직급 정보 코드' AFTER `location_name`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `duty_item_name` VARCHAR(128) NULL COMMENT '직급 정보 명' AFTER `duty_item_seq`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `transport_seq` VARCHAR(32) NULL COMMENT '교통수단 코드' AFTER `duty_item_name`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `transport_name` VARCHAR(128) NULL COMMENT '교통 수단 명' AFTER `transport_seq`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `api_send_yn` VARCHAR(2) DEFAULT 'N' COMMENT 'API 전송 여부' AFTER `transport_name`;
ALTER TABLE `t_exnp_trip_api` ADD COLUMN IF NOT EXISTS `attend_link_seq` VARCHAR(128) NULL COMMENT '근태 정보 연동 키' AFTER `api_send_yn`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_api_log` (
  `log_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'API 호출 로그 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`log_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `t_exnp_trip_api_log` ADD COLUMN IF NOT EXISTS `attend_seq` BIGINT(32) NULL COMMENT '출장 품의/결의 문서 코드' AFTER `log_seq`;
ALTER TABLE `t_exnp_trip_api_log` ADD COLUMN IF NOT EXISTS `api_call_action` VARCHAR(128) NULL COMMENT '호출 동작 설명' AFTER `attend_seq`;
ALTER TABLE `t_exnp_trip_api_log` ADD COLUMN IF NOT EXISTS `api_call_code` VARCHAR(32) NULL COMMENT '호출 동작 코드' AFTER `api_call_action`;
ALTER TABLE `t_exnp_trip_api_log` ADD COLUMN IF NOT EXISTS `api_call_url` VARCHAR(1024) NULL COMMENT '호출 URL' AFTER `api_call_code`;
ALTER TABLE `t_exnp_trip_api_log` ADD COLUMN IF NOT EXISTS `api_call_result` VARCHAR(1024) NULL COMMENT 'API 호출 결과' AFTER `api_call_url`;
ALTER TABLE `t_exnp_trip_api_log` ADD COLUMN IF NOT EXISTS `api_call_param` VARCHAR(1024) NULL COMMENT 'API 호출 파라미터' AFTER `api_call_result`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_set_amt` (
  `amt_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '경비 설정 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`amt_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `amt_seq`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `duty_group_seq` BIGINT(32) NULL COMMENT '직책 그룹 코드' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `location_seq` BIGINT(32) NULL COMMENT '출장지 코드' AFTER `duty_group_seq`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `transport_seq` BIGINT(32) NULL COMMENT '교통수단 코드' AFTER `location_seq`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `domestic_code` VARCHAR(2) DEFAULT '0' COMMENT '국내외 구분 0 : 국내, 1 : 국외' AFTER `transport_seq`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `apply_date` VARCHAR(8) NULL COMMENT '적용일자(yyyyMMdd)' AFTER `domestic_code`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `amt` BIGINT(32) NULL COMMENT '단가' AFTER `apply_date`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `amt_hold_code` VARCHAR(2) DEFAULT '0' COMMENT '단가 적용 0 : 고정, 1 : 실비' AFTER `amt`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `note` VARCHAR(1024) NULL COMMENT '비고' AFTER `amt_hold_code`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `amt_class_code` VARCHAR(2) NULL COMMENT '단가 관리 구분 1 : 일비, 2:식비, 3:숙박비, 4:기타1, 5:기타2' AFTER `note`;
ALTER TABLE `t_exnp_trip_set_amt` ADD COLUMN IF NOT EXISTS `amt_class_name` VARCHAR(32) NULL COMMENT '단가 관리 명' AFTER `amt_class_code`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_set_dutygroup` (
  `duty_group_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '직책 그룹 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`duty_group_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `domestic_code` VARCHAR(2) DEFAULT '0' COMMENT '국내외 구분 0 : 국내, 1 : 국외' AFTER `duty_group_seq`;
ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `domestic_code`;
ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(2) DEFAULT 'Y' COMMENT '사용여부 (Y:사용, N:미사용)' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `duty_group_name_kr` VARCHAR(128) NULL COMMENT '직책 그룹명 - 한글' AFTER `use_yn`;
ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `duty_group_name_en` VARCHAR(128) NULL COMMENT '직책 그룹명 - 영어' AFTER `duty_group_name_kr`;
ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `duty_group_name_jp` VARCHAR(128) NULL COMMENT '직책 그룹명 - 일본어' AFTER `duty_group_name_en`;
ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `duty_group_name_cn` VARCHAR(128) NULL COMMENT '직책 그룹명 - 중국어' AFTER `duty_group_name_jp`;
ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `note` VARCHAR(1024) NULL COMMENT '' AFTER `duty_group_name_cn`;
ALTER TABLE `t_exnp_trip_set_dutygroup` ADD COLUMN IF NOT EXISTS `order_num` VARCHAR(32) NULL COMMENT '정렬 순서' AFTER `note`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_set_dutyitem` (
  `duty_item_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '직책 정보 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`duty_item_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `t_exnp_trip_set_dutyitem` ADD COLUMN IF NOT EXISTS `duty_group_seq` BIGINT(32) NULL COMMENT '직책 그룹 키' AFTER `duty_item_seq`;
ALTER TABLE `t_exnp_trip_set_dutyitem` ADD COLUMN IF NOT EXISTS `duty_code` VARCHAR(32) NULL COMMENT '직책 코드' AFTER `duty_group_seq`;
ALTER TABLE `t_exnp_trip_set_dutyitem` ADD COLUMN IF NOT EXISTS `duty_name` VARCHAR(128) NULL COMMENT '직책 명' AFTER `duty_code`;
ALTER TABLE `t_exnp_trip_set_dutyitem` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `duty_name`;
ALTER TABLE `t_exnp_trip_set_dutyitem` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_set_dutyitem` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(2) DEFAULT 'Y' COMMENT '사용 여부' AFTER `comp_name`;


CREATE TABLE IF NOT EXISTS `t_exnp_trip_set_location` (
  `location_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '출장지 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`location_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `location_seq`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `domestic_code` VARCHAR(2) DEFAULT '0' COMMENT '국내외 구분 0 : 국내, 1 : 국외' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `location_name_kr` VARCHAR(128) NULL COMMENT '출장지 명 - 한글' AFTER `domestic_code`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `location_name_en` VARCHAR(128) NULL COMMENT '출장지 명 - 영어' AFTER `location_name_kr`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `location_name_jp` VARCHAR(128) NULL COMMENT '출장지 명 - 일본어' AFTER `location_name_en`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `location_name_cn` VARCHAR(128) NULL COMMENT '출장지 명 - 중국어' AFTER `location_name_jp`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `location_edit_yn` VARCHAR(2) DEFAULT 'Y' COMMENT '출장지 직접입력 Y : 허용, N : 불가' AFTER `location_name_cn`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(2) DEFAULT 'Y' COMMENT '사용여부 Y : 사용, N : 미사용' AFTER `location_edit_yn`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `order_num` VARCHAR(32) NULL COMMENT '정렬 순서' AFTER `use_yn`;
ALTER TABLE `t_exnp_trip_set_location` ADD COLUMN IF NOT EXISTS `note` VARCHAR(1024) NULL COMMENT '비고' AFTER `order_num`;

CREATE TABLE IF NOT EXISTS `t_exnp_trip_set_transport` (
  `transport_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '이동수단 시퀀스',
  `create_seq` VARCHAR(32) DEFAULT NULL COMMENT '생성자',
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `modify_seq` VARCHAR(32) DEFAULT NULL COMMENT '수정자',
  `modify_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`transport_seq`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `t_exnp_trip_set_transport` ADD COLUMN IF NOT EXISTS `comp_seq` VARCHAR(32) NULL COMMENT '회사 코드' AFTER `transport_seq`;
ALTER TABLE `t_exnp_trip_set_transport` ADD COLUMN IF NOT EXISTS `comp_name` VARCHAR(128) NULL COMMENT '회사 명' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_set_transport` ADD COLUMN IF NOT EXISTS `transport_name_kr` VARCHAR(128) NULL COMMENT '이동수단 명 - 한글' AFTER `comp_name`;
ALTER TABLE `t_exnp_trip_set_transport` ADD COLUMN IF NOT EXISTS `transport_name_en` VARCHAR(128) NULL COMMENT '이동수단 명 - 영어' AFTER `transport_name_kr`;
ALTER TABLE `t_exnp_trip_set_transport` ADD COLUMN IF NOT EXISTS `transport_name_jp` VARCHAR(128) NULL COMMENT '이동수단 명 - 일본어' AFTER `transport_name_en`;
ALTER TABLE `t_exnp_trip_set_transport` ADD COLUMN IF NOT EXISTS `transport_name_cn` VARCHAR(128) NULL COMMENT '이동수단 명 - 중국어' AFTER `transport_name_jp`;
ALTER TABLE `t_exnp_trip_set_transport` ADD COLUMN IF NOT EXISTS `use_yn` VARCHAR(2) DEFAULT 'Y' COMMENT '사용 여부 (Y:사용, N:미사용)' AFTER `transport_name_cn`;
ALTER TABLE `t_exnp_trip_set_transport` ADD COLUMN IF NOT EXISTS `order_num` VARCHAR(32) NULL COMMENT '정렬 순서' AFTER `use_yn`;
ALTER TABLE `t_exnp_trip_set_transport` ADD COLUMN IF NOT EXISTS `note` VARCHAR(1028) NULL COMMENT '비고' AFTER `order_num`;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 93 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 08. 22. 18:06 ) - 이준성  */

/* --------------------------------------------------------------------------------------------- */

/* 2019. 08. 29. - 김상겸 - 테이블 자료형 변경 */
ALTER TABLE `t_exnp_out_process_his`   
	CHANGE `interface_url` `interface_url` VARCHAR(1024) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT 'API 호출 URL',
	CHANGE `interface_param` `interface_param` VARCHAR(1024) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT 'API 전달 파라미터';
	
	
/* 2019 - 08 - 29 최상배 출장복명 테이블 컬럼 추가 */
ALTER TABLE `neos`.`t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `schm_seq` VARCHAR(32) NULL COMMENT '일정 연동 마스터 키 ' AFTER `calendar_name`;
ALTER TABLE `neos`.`t_exnp_trip_cons_attend` ADD COLUMN IF NOT EXISTS `sch_seq` VARCHAR(32) NULL COMMENT '일정 연동 키 ' AFTER `schm_seq`;
ALTER TABLE `neos`.`t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `schm_seq` VARCHAR(32) NULL COMMENT '일정 연동 마스터 키 ' AFTER `calendar_name`;
ALTER TABLE `neos`.`t_exnp_trip_res_attend` ADD COLUMN IF NOT EXISTS `sch_seq` VARCHAR(32) NULL COMMENT '일정 연동 키 ' AFTER `schm_seq`;	

/* 2019 - 09 - 05 최상배 사업소득자 학자금 상환액 컬럼 추가 */
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `etc_school_amt` BIGINT(64) NULL COMMENT '학자금 상환액' AFTER `etc_resident_vat_amt`;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 94 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 09. 06. 10:49  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */


/* 2019 - 09 - 16 최상배 출장 복명 테이블 스키마 변경 */
ALTER TABLE t_exnp_trip_res_budget_erp   CHANGE `budget_erp_seq` `budget_erp_seq` BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ERP 예산정보 테이블 시퀀스';

/* 2019 - 09 - 25 최상배 출장 복명 테이블 스키마 변경 */
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `cons_date` VARCHAR(32) NULL COMMENT '품의일자' AFTER `erp_div_name`;
ALTER TABLE `t_exnp_trip_cons_budget_erp` ADD COLUMN IF NOT EXISTS `res_date` VARCHAR(32) NULL COMMENT '결의일자' AFTER `erp_div_name`;


/* 2019 - 10 - 08 송준석 참조품의 권한부여 history 테이블 추가 */
CREATE TABLE IF NOT EXISTS `g20_cons_auth_history` (
  `history_seq` int(11) NOT NULL AUTO_INCREMENT,
  `history_type` varchar(4) NOT NULL,
  `auth_seq` int(11) NOT NULL ,
  `group_seq` varchar(32) NOT NULL,
  `emp_seq` varchar(32) NOT NULL,
  `gbn_org` varchar(2) DEFAULT NULL,
  `seq` varchar(32) DEFAULT NULL,
  `create_seq` varchar(32) DEFAULT NULL,
  `create_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_seq` varchar(32) DEFAULT NULL,
  `modify_dt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `insert_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_seq`, `auth_seq`,`group_seq`,`emp_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8


/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 96 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 10. 11. 14:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* 2019 - 10 - 23 최상배 지출결의서 테이블 스키마 변경 */
ALTER TABLE `t_exnp_resdoc` ADD COLUMN IF NOT EXISTS `save_yn` VARCHAR(2) DEFAULT 'N' COMMENT '즐겨찾기 저장 여부[Y/N]' AFTER `send_date`;


/* 2019 - 10 - 30 최상배 품의/결의/카드이관 테이블 스키마 변경 */
ALTER TABLE `t_exnp_consdoc` ADD INDEX IF NOT EXISTS `docSeq` (`doc_seq`); 	 
ALTER TABLE `t_ex_card_transfer` ADD INDEX IF NOT EXISTS `syncId` (`sync_id`); 	 
ALTER TABLE `t_exnp_consdoc` ADD INDEX IF NOT EXISTS `docSeq` (`doc_seq`); 

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.97 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 10. 31. 17:00  ) - 최상배  */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.97 2차 예정 11-04 배포 예정 */
/* 여기까지 배포 완료 ( 배포일 :   ) - 최상배  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_ex_card_public` ADD IF NOT EXISTS  `card_num2` VARCHAR(30) DEFAULT NULL COMMENT '- 없는 카드 번호 ' AFTER `card_num`;
ALTER TABLE `t_ex_card_public` ADD INDEX IF NOT EXISTS  `card_num2` (`card_num2`); 

/* 2019. 10. 31. - 권오광 - 항목 테이블 컬럼 추가 */
ALTER TABLE `t_ex_expend_list` ADD COLUMN IF NOT EXISTS `exchange_unit_code` VARCHAR(10) NULL COMMENT '환종코드' AFTER `order_seq`;
ALTER TABLE `t_ex_expend_list` ADD COLUMN IF NOT EXISTS `exchange_unit_name` VARCHAR(100) NULL COMMENT '환종명' AFTER `exchange_unit_code`;
ALTER TABLE `t_ex_expend_list` ADD COLUMN IF NOT EXISTS `exchange_rate` DECIMAL(19,6) NULL COMMENT '환율' AFTER `exchange_unit_name`;
ALTER TABLE `t_ex_expend_list` ADD COLUMN IF NOT EXISTS `foreign_currency_amount` DECIMAL(19,4) NULL COMMENT '외화금액' AFTER `exchange_rate`;
ALTER TABLE `t_ex_expend_list` ADD COLUMN IF NOT EXISTS `foreign_acct_yn` CHAR(1) NULL COMMENT '외화계정 여부(Y/N)' AFTER `foreign_currency_amount`;

/* 2019. 10. 31. - 권오광 - 분개 테이블 컬럼 추가 */
ALTER TABLE `t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `exchange_unit_code` VARCHAR(10) NULL COMMENT '환종코드' AFTER `row_no`;
ALTER TABLE `t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `exchange_unit_name` VARCHAR(100) NULL COMMENT '환종명' AFTER `exchange_unit_code`;
ALTER TABLE `t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `exchange_rate` DECIMAL(19,6) NULL COMMENT '환율' AFTER `exchange_unit_name`;
ALTER TABLE `t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `foreign_currency_amount` DECIMAL(19,4) NULL COMMENT '외화금액' AFTER `exchange_rate`;
ALTER TABLE `t_ex_expend_slip` ADD COLUMN IF NOT EXISTS `foreign_acct_yn` CHAR(1) NULL COMMENT '외화계정 여부(Y/N)' AFTER `foreign_currency_amount`;


/* 2019-11-11 최상배 세금계산세 테이블 컬럼 추가 */
ALTER TABLE `t_ex_etax_aq_tmp` ADD COLUMN IF NOT EXISTS  `iss_no2` VARCHAR(128) DEFAULT NULL COMMENT '세금계산서 키 (NEOE.NO_ISS)';

/* 2019-11-12 최상배 세금계산세 테이블 컬럼 추가 */
ALTER TABLE `t_ex_etax_transfer` ADD COLUMN IF NOT EXISTS  `iss_no2` VARCHAR(128) DEFAULT NULL COMMENT '세금계산서 키 (NEOE.NO_ISS)';

/* 2019-11-13 최상배 법인카드 승인내역 iCUBE 연동 키 추가 */
ALTER TABLE `t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS  `iss_dt` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE / G20 법이카드 승인내역 연동 키(승인일자)' AFTER sync_id;
ALTER TABLE `t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS  `iss_sq` VARCHAR(128) DEFAULT NULL COMMENT 'iCUBE / G20 법이카드 승인내역 연동 키(순번)' AFTER iss_dt;

/* [배포 취소] 2019-11-27 김상겸 법인카드 승인내역 iCUBE 연동 키 추가 */
-- ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK1 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
-- ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK2 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
-- ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK3 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
-- ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK4 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
-- ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK5 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
-- ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK6 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
-- ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK7 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';

/* [배포 취소] 2019-11-27 김상겸 법인카드 승인내역 iCUBE 연동 키 추가 */
/*
CREATE TABLE IF NOT EXISTS `t_ex_card_aq_tmp_sub` (  
  `co_cd` VARCHAR(4) NOT NULL COMMENT 'iCUBE 회사 코드',
  `iss_dt` VARCHAR(8) NOT NULL COMMENT 'iCUBE 카드 연동 키값',
  `iss_sq` VARCHAR(10) NOT NULL COMMENT 'iCUBE 카드 연동 키값',
  `PK1` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK2` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK3` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK4` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK5` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK6` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK7` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `sync_id` BIGINT COMMENT 't_ex_card_aq_tmp 키값',
  PRIMARY KEY (`co_cd`, `iss_dt`, `iss_sq`, `PK1`, `PK2`, `PK3`, `PK4`, `PK5`, `PK6`, `PK7`)
) ENGINE=INNODB CHARSET=utf8mb4;
*/

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.99 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 12. 02. 16:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* [100 버전 안나감.] 2019-11-27 김상겸 법인카드 승인내역 iCUBE 연동 키 추가 */
ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK1 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK2 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK3 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK4 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK5 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK6 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';
ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS PK7 VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';

/* [100 버전 안나감.] 2019-11-27 김상겸 법인카드 승인내역 iCUBE 연동 키 추가 */
CREATE TABLE IF NOT EXISTS `t_ex_card_aq_tmp_sub` (  
  `co_cd` VARCHAR(4) NOT NULL COMMENT 'iCUBE 회사 코드',
  `iss_dt` VARCHAR(8) NOT NULL COMMENT 'iCUBE 카드 연동 키값',
  `iss_sq` VARCHAR(10) NOT NULL COMMENT 'iCUBE 카드 연동 키값',
  `PK1` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK2` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK3` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK4` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK5` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK6` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `PK7` VARCHAR(40) NOT NULL COMMENT 'iCUBE CMS 데이터 키값',
  `sync_id` BIGINT COMMENT 't_ex_card_aq_tmp 키값',
  PRIMARY KEY (`co_cd`, `iss_dt`, `iss_sq`, `PK1`, `PK2`, `PK3`, `PK4`, `PK5`, `PK6`, `PK7`)
) ENGINE=INNODB CHARSET=utf8mb4;

ALTER TABLE `t_exnp_consdoc` ADD COLUMN IF NOT EXISTS `save_yn` VARCHAR(2) DEFAULT 'N' COMMENT '즐겨찾기 저장 여부[Y/N]' AFTER `out_process_interface_d_id`;

/* 2019. 12. 20. 김상겸 지출결의 항목 확장입력 컬럼 추가 */
ALTER TABLE t_ex_expend_list ADD IF NOT EXISTS extend_str1 VARCHAR(64) DEFAULT NULL COMMENT '항목 확장 입력 1';
ALTER TABLE t_ex_expend_list ADD IF NOT EXISTS extend_str2 VARCHAR(64) DEFAULT NULL COMMENT '항목 확장 입력 2';


CREATE TABLE IF NOT EXISTS t_exnp_consitem (  
  cons_item_seq BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '물품명세 키',
  cons_doc_seq BIGINT(32) UNSIGNED NOT NULL COMMENT '품의문서 키',
  cons_seq BIGINT(32) UNSIGNED NOT NULL COMMENT '품의서 키',
  item_name VARCHAR(40) DEFAULT NULL COMMENT '명칭',
  item_size VARCHAR(40) DEFAULT NULL COMMENT '규격/용량',
  item_unit VARCHAR(40) DEFAULT NULL COMMENT '단위',
  item_cnt VARCHAR(40) DEFAULT NULL COMMENT '수량',
  unit_amt VARCHAR(40) NOT NULL COMMENT '단가',
  item_amt VARCHAR(40) NOT NULL COMMENT '금액',
  item_note VARCHAR(40) DEFAULT NULL COMMENT '비고',
  PRIMARY KEY (cons_item_seq,cons_doc_seq,cons_seq)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS t_exnp_resitem (  
  res_item_seq BIGINT(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '물품명세 키',
  res_doc_seq BIGINT(32) UNSIGNED NOT NULL COMMENT '품의문서 키',
  res_seq BIGINT(32) UNSIGNED NOT NULL COMMENT '품의서 키',
  item_name VARCHAR(40) DEFAULT NULL COMMENT '명칭',
  item_size VARCHAR(40) DEFAULT NULL COMMENT '규격/용량',
  item_unit VARCHAR(40) DEFAULT NULL COMMENT '단위',
  item_cnt VARCHAR(40) DEFAULT NULL COMMENT '수량',
  unit_amt VARCHAR(40) NOT NULL COMMENT '단가',
  item_amt VARCHAR(40) NOT NULL COMMENT '금액',
  item_note VARCHAR(40) DEFAULT NULL COMMENT '비고',
  PRIMARY KEY (res_item_seq,res_doc_seq,res_seq)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

ALTER TABLE t_exnp_resdoc ADD IF NOT EXISTS form_seq VARCHAR(32) DEFAULT NULL COMMENT '양식 코드 키' AFTER doc_status ;


/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.102 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 09 17:00  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.102 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 15 17:55  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

--ALTER TABLE g20_abdocu_b MODIFY COLUMN div_nm2 VARCHAR(32) DEFAULT NULL;
--ALTER TABLE t_exnp_restrade ADD IF NOT EXISTS erp_etc_mng_seq VARCHAR(20) DEFAULT NULL COMMENT '[U] 소득자 키 (fi_chincome.cd_mng)' AFTER mdify_date ;
ALTER TABLE t_exnp_restrade ADD IF NOT EXISTS etc_biz_seq VARCHAR(10) DEFAULT NULL COMMENT '[U] 사업소득자 사업장 코드' AFTER erp_etc_mng_seq ;
ALTER TABLE t_exnp_restrade ADD IF NOT EXISTS etc_biz_name VARCHAR(10) DEFAULT NULL COMMENT '[U] 사업소득자 사업장 명' AFTER etc_biz_seq ;

/* 2020-01-23 */
/* 최상배 - 채주 거래처 법인카드 카드 코드 컬럼 사이즈 변경 varchar(10) - > varchar(20) */
ALTER TABLE t_exnp_restrade CHANGE `ctr_seq` `ctr_seq` VARCHAR(20) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '카드 거래처 코드'; 

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.103 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 23 15:00  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */

/* 스크립트 오류로 103 2차 재배포 필요 */
ALTER TABLE t_exnp_restrade ADD IF NOT EXISTS erp_etc_mng_seq VARCHAR(20) DEFAULT NULL COMMENT '[U] 소득자 키 (fi_chincome.cd_mng)' AFTER interface_seq ;
ALTER TABLE t_exnp_restrade ADD IF NOT EXISTS etc_biz_seq VARCHAR(10) DEFAULT NULL COMMENT '[U] 사업소득자 사업장 코드' AFTER erp_etc_mng_seq ;
ALTER TABLE t_exnp_restrade ADD IF NOT EXISTS etc_biz_name VARCHAR(10) DEFAULT NULL COMMENT '[U] 사업소득자 사업장 명' AFTER etc_biz_seq ;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.103 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 29 13:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

ALTER TABLE t_ex_card_aq_tmp MODIFY COLUMN georae_coll VARCHAR(128) DEFAULT NULL;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.103 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 01. 30 09:10  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* iCUBE CMS 연동 키 추가 >>>>> 104 버전 배포!! */
ALTER TABLE t_ex_card_aq_tmp ADD IF NOT EXISTS EBANK_KEY VARCHAR(100) DEFAULT NULL COMMENT 'iCUBE CMS 연동 키';

/* 물품명세 IU 대응 키 추가*/
ALTER TABLE t_exnp_resitem ADD IF NOT EXISTS budget_seq VARCHAR(32) DEFAULT NULL COMMENT '[U] 예산키' AFTER res_seq;
ALTER TABLE t_exnp_consitem ADD IF NOT EXISTS budget_seq VARCHAR(32) DEFAULT NULL COMMENT '[U] 예산키' AFTER cons_seq;
/* t_exnp_restrade 거래처 주소 길이 확장 */
ALTER TABLE t_exnp_restrade MODIFY COLUMN tr_addr VARCHAR(150) DEFAULT NULL COMMENT '거래처 주소';
/* iCUBE거래처 종목, 업태 컬럼 길이값 varchar(40)으로 확인되어 수정 */
ALTER TABLE t_ex_expend_partner MODIFY cls_job_gbn  VARCHAR(40);
ALTER TABLE t_ex_expend_partner MODIFY job_gbn  VARCHAR(40);

/* 2020-02-06 12:07 최상배 */
/* 거래처 컬럼 카드 거래처 명칭 G20최대 지원 값인 60자로 변경 */
ALTER TABLE t_exnp_restrade CHANGE `ctr_name` `ctr_name` VARCHAR(60) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '카드 명';
/* 거래처 컬럼 거래처 주소 최대길이 150으로 변경 */
ALTER TABLE t_exnp_restrade MODIFY COLUMN tr_addr VARCHAR(150) DEFAULT NULL COMMENT '거래처 주소';


/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.104 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 02. 10 14:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.104 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. . 02. 12 18:02  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* 2020-02-19 최상배 */
/* [1.2.105 배포] 거래처 급여 관련 테이블 구조 변경 */
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `salary_amt` BIGINT(64) DEFAULT 0 COMMENT '급여 지급 총금액' AFTER `etc_belong_month`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `salary_std_amt` BIGINT(64) DEFAULT 0 COMMENT '급여 실수령액' AFTER `salary_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `salary_income_vat_amt` BIGINT(64) DEFAULT 0 COMMENT '급여 실수령액' AFTER `salary_std_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `salary_resident_vat_amt` BIGINT(64) DEFAULT 0 COMMENT '급여 주민 세액' AFTER `salary_income_vat_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `salary_etc_amt` BIGINT(64) DEFAULT 0 COMMENT '급여 기타 공제액' AFTER `salary_resident_vat_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `salary_belong_year` VARCHAR(10) NULL COMMENT '급여 귀속년도' AFTER `salary_etc_amt`;
ALTER TABLE `t_exnp_restrade` ADD COLUMN IF NOT EXISTS `salary_belong_month` VARCHAR(6) NULL COMMENT '급여 귀속 월' AFTER `salary_belong_year`;

/* 2020-02-19 허준녕 */
/* [1.2.105 배포] 카드테이블 구조 변경 */
ALTER TABLE `t_ex_card_aq_tmp` CHANGE `edited_dt` `edited_dt` DATETIME NULL;
ALTER TABLE `t_ex_card_aq_tmp` CHANGE `edited_by` `edited_by` INT(11) NULL;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.105 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 02. 20 17:25  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* 2020-02-21 최상배 */
/* [1.2.105 2차 배포시 포함되어야 함] 품의/결의서 적요 컬럼 사이즈 변경 */
ALTER TABLE t_exnp_resdoc CHANGE `resdoc_note` `resdoc_note` VARCHAR(256) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '결의 문서 적요';
ALTER TABLE t_exnp_consdoc CHANGE `consdoc_note` `consdoc_note` VARCHAR(256) CHARSET utf8 COLLATE utf8_general_ci NULL COMMENT '품의 문서 적요';

/* 2020-02-26 이준성 */
/* 업종/업태 컬럼사이즈 크기 50으로 변경 */
ALTER TABLE `t_ex_expend_partner` CHANGE `job_gbn` `job_gbn` VARCHAR(50) NULL;
ALTER TABLE `t_ex_expend_partner` CHANGE `cls_job_gbn` `cls_job_gbn` VARCHAR(50) NULL;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.105 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 02. 26 17:25  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* 2020-02-27 이준성 */
/* 업종/업태 컬럼사이즈 크기 50으로 변경 및 코멘트 추가  */
ALTER TABLE `t_ex_expend_partner` CHANGE `job_gbn` `job_gbn` VARCHAR(50) NULL COMMENT '업태';
ALTER TABLE `t_ex_expend_partner` CHANGE `cls_job_gbn` `cls_job_gbn` VARCHAR(50) NULL COMMENT '종목';

/* 2020-02-27 김상겸 */
/* ERPiU 예산연동 변경프로세스 적용 기준 판단 컬럼 추가 */
ALTER TABLE t_ex_expend ADD IF NOT EXISTS erpiu_budget_ver varchar(8) NULL COMMENT 'ERPiU 예산체크 프로세스 변경 버전 기록';
ALTER TABLE t_ex_expend CHANGE erpiu_budget_ver erpiu_budget_ver varchar(8) NULL COMMENT 'ERPiU 예산체크 프로세스 변경 버전 기록' AFTER in_sq;

ALTER TABLE t_ex_expend_budget ADD IF NOT EXISTS cd_bglevel varchar(32) NULL COMMENT '실제 예산통제 계정(또는 예산단위)';
ALTER TABLE t_ex_expend_budget CHANGE cd_bglevel cd_bglevel varchar(32) NULL COMMENT '실제 예산통제 계정(또는 예산단위)' AFTER budget_control_yn;
ALTER TABLE t_ex_expend_budget ADD IF NOT EXISTS yn_control varchar(2) NULL COMMENT '예산통제여부 ( N : 통제안함, Y : 통제 ) ( ERPiU 연동 사용 )';
ALTER TABLE t_ex_expend_budget CHANGE yn_control yn_control varchar(2) NULL COMMENT '예산통제여부 ( N : 통제안함, Y : 통제 ) ( ERPiU 연동 사용 )' AFTER cd_bglevel;
ALTER TABLE t_ex_expend_budget ADD IF NOT EXISTS tp_control varchar(2) NULL COMMENT '예산통제기준 ( 1 : 예산단위통제, 2 : 예산계정통제 ) ( ERPiU 연동 사용 )';
ALTER TABLE t_ex_expend_budget CHANGE tp_control tp_control varchar(2) NULL COMMENT '예산통제기준 ( 1 : 예산단위통제, 2 : 예산계정통제 ) ( ERPiU 연동 사용 )' AFTER yn_control;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.106 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 03. 05 17:35  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* 2020-03-10 권오광 */
/* iCUBE CMS연동 휴폐업일 컬럼 추가 */
ALTER TABLE `t_ex_card_aq_tmp` ADD COLUMN IF NOT EXISTS `closed_business_date` VARCHAR(8) NULL COMMENT '휴폐업일' AFTER `EBANK_KEY`;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.106 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 03. 11 17:11  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.107 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 03. 19 17:58  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.107 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 03. 25 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.108 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 02 17:58  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.108 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 08 17:23  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.109 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 16 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

/* 거래처명 최대 저장 문자 60자로 증가 */
ALTER TABLE `t_exnp_restrade` CHANGE tr_name tr_name VARCHAR(60);
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.109 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 22 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.110 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 04. 22 16:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.111 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 05. 21 16:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_exnp_form` ADD IF NOT EXISTS `conf_yn` VARCHAR(1) DEFAULT '0' COMMENT '통합양식여부' AFTER `comp_seq`;
ALTER TABLE `t_exnp_trip_res_doc` ADD IF NOT EXISTS form_seq VARCHAR(32) COMMENT '양식 코드' AFTER `doc_no`;
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.111 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 05. 27 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.112 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 06. 4 16:51  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.113 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 06. 18 17:20  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.114 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 07. 02 17:20  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_ex_card_aq_tmp` ADD IF NOT EXISTS `maigrationYN` VARCHAR(1) COMMENT '마이그레이션 데이터 미사용 Y,N' AFTER `closed_business_date`;
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.114 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 07. 10 14:40  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.115 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 07. 10 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.116 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 07. 30 14:40  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.116 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 08. 05 17:20  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_exnp_reshead` ADD IF NOT EXISTS `pjtFromDt` VARCHAR(32) COMMENT '[I] 프로젝트/부서 시작기간' AFTER `mgt_name`;
ALTER TABLE `t_exnp_reshead` ADD IF NOT EXISTS `pjtToDt` VARCHAR(32) COMMENT '[I] 프로젝트/부서 종료기간' AFTER `pjtFromDt`;
ALTER TABLE `t_exnp_conshead` ADD IF NOT EXISTS `pjtFromDt` VARCHAR(32) COMMENT '[I] 프로젝트/부서 시작기간' AFTER `mgt_name`;
ALTER TABLE `t_exnp_conshead` ADD IF NOT EXISTS `pjtToDt` VARCHAR(32) COMMENT '[I] 프로젝트/부서 종료기간' AFTER `pjtFromDt`;
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.117 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 08. 05 14:35  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.117 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 08. 19 17:32  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.118 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 09. 02 17:32  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.119 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 09. 10 17:05  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_exnp_trip_res_attend` CHANGE `trip_from_date` `trip_from_date` VARCHAR(32) NULL COMMENT '출장 시작 일시';
ALTER TABLE `t_exnp_trip_res_attend` CHANGE `trip_to_date` `trip_to_date` VARCHAR(32) NULL COMMENT '출장 종료 일시';
ALTER TABLE `t_exnp_trip_cons_attend` CHANGE `trip_from_date` `trip_from_date` VARCHAR(32) NULL COMMENT '출장 시작 일시';
ALTER TABLE `t_exnp_trip_cons_attend` CHANGE `trip_to_date` `trip_to_date` VARCHAR(32) NULL COMMENT '출장 종료 일시';
ALTER TABLE `t_exnp_restrade` CHANGE `tr_seq` `tr_seq` VARCHAR(30) NULL COMMENT '거래처 코드';

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.120 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 09. 24 17:05  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.121 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 10. 15 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.121 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 10. 21 17:20  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_ex_langpack` CHANGE `basic_name` `basic_name` VARCHAR(300) NULL;
ALTER TABLE `t_ex_langpack` CHANGE `lang_name` `lang_name` VARCHAR(300) NULL;
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.121 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 10. 27 11:55  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.122 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 10. 29 17:20  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.122 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 11. 04 16:20  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.122 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 11. 09 15:40  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.123 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 11. 19 15:40  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_exnp_resbudget` CHANGE `erp_budget_name` `erp_budget_name` VARCHAR(64) NULL;
ALTER TABLE `t_exnp_consbudget` CHANGE `erp_budget_name` `erp_budget_name` VARCHAR(64) NULL;
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.124 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 12. 03 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.124 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 12. 14 13:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.125 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2020. 12. 17 17:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_exnp_restrade` CHANGE `etc_biz_name` `etc_biz_name` VARCHAR(64) NULL;
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.126 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 01. 06 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_exnp_restrade` ADD IF NOT EXISTS `etc_employment_amt` BIGINT(64) DEFAULT 0 COMMENT '고용보험료' AFTER `etc_resident_vat_amt`;
ALTER TABLE `t_exnp_restrade` ADD IF NOT EXISTS `depositno` VARCHAR(32) COMMENT '[IU] 계좌코드' AFTER `ba_nb`;
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.128 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 01. 28 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE t_ex_card_aq_tmp MODIFY merc_name varchar(100) NOT NULL;
ALTER TABLE t_ex_card_aq_tmp MODIFY merc_saup_no varchar(20);
ALTER TABLE t_ex_card_aq_tmp MODIFY merc_addr varchar(512);
ALTER TABLE t_ex_card_aq_tmp MODIFY merc_repr varchar(120);
ALTER TABLE t_ex_card_aq_tmp MODIFY merc_tel varchar(40);
ALTER TABLE t_ex_card_aq_tmp MODIFY merc_zip varchar(12);
INSERT IGNORE INTO `t_ex_button` ( `comp_seq`, `form_seq`, `page_seq`, `position`, `order_num`, `display_yn`, `license_yn`, `btn_size`, `nm_basic`, `nm_kr`, `nm_en`, `nm_jp`, `nm_cn`, `default_yn`, `default_code`, `default_elemId`, `default_elemClass`, `call_url`, `call_param` ) VALUES ( 'EXP_BUTTON', 0, 10, 20, 99, 'N', 'Y', 203, '카드사용내역(취소분 포함)', '카드사용내역(취소분 포함)', '', '', '', 'Y', 'cardUseHistoryWithCancel', '', '', 'fnDefault_cardUseHistoryWithCancel', '{}' );
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.128 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 02. 02 16:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.128 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 02. 03 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.130 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 03. 04 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

ALTER TABLE `t_exnp_restrade` ADD IF NOT EXISTS `pay_tr_seq` VARCHAR(32) COMMENT '[CUBE] 지급거래처 코드' AFTER `etc_biz_name`;
ALTER TABLE `t_exnp_restrade` ADD IF NOT EXISTS `pay_tr_name` VARCHAR(32) COMMENT '[CUBE] 지급거래처 명' AFTER `pay_tr_seq`;
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `paytr_seq` VARCHAR(32) COMMENT '[CUBE] 지급거래처 코드' AFTER `use_yn`;
ALTER TABLE `t_ex_card` ADD IF NOT EXISTS `paytr_name` VARCHAR(32) COMMENT '[CUBE] 지급거래처 명' AFTER `paytr_seq`;
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.130 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 03. 10 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE t_exnp_restrade MODIFY ceo_name varchar(50);

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.131 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 03. 18 17:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE `t_ex_cms_sync` ADD IF NOT EXISTS `run_yn` VARCHAR(32) COMMENT '카드 연동중 여부' AFTER `cms_base_day`;
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.131 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 03. 24 15:30  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.132 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 03. 24 15:44  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.132 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 04. 07 17:16  ) - 이준성  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.133 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 04. 15 17:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.133 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 04. 21 17:50  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.134 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 04. 28 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.135 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 05. 18 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE t_ex_card_aq_tmp MODIFY mcc_name varchar(100);
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.135 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 05. 25 13:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
ALTER TABLE t_ex_card_transfer MODIFY supper_key varchar(64);

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.136 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 05. 27 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.136 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 06. 02 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.139 3차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 07. 19 17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.140 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 07. 22 17:43  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.141 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 07. 04 17:43  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

ALTER TABLE t_expend_log MODIFY message mediumtext;
ALTER TABLE t_exnp_reshead MODIFY btr_seq varchar(30);
/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.142 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 08. 19 17:43  ) - 성기환  */
/* --------------------------------------------------------------------------------------------- */

ALTER TABLE t_ex_card_aq_tmp MODIFY PK1 varchar(100);
ALTER TABLE t_ex_card_aq_tmp MODIFY PK2 varchar(100);
ALTER TABLE t_ex_card_aq_tmp MODIFY PK3 varchar(100);
ALTER TABLE t_ex_card_aq_tmp MODIFY PK4 varchar(100);
ALTER TABLE t_ex_card_aq_tmp MODIFY PK5 varchar(100);
ALTER TABLE t_ex_card_aq_tmp MODIFY PK6 varchar(100);
ALTER TABLE t_ex_card_aq_tmp MODIFY PK7 varchar(100);
ALTER TABLE t_ex_card_aq_tmp MODIFY abroad varchar(3);

CREATE TABLE IF NOT EXISTS `acard_temp` (
	`sync_id` INT (10) AUTO_INCREMENT PRIMARY KEY,
	`iss_dt` VARCHAR (512),
	`iss_sq` VARCHAR (512),
	`owner_reg_no` VARCHAR (40),
	`card_code` VARCHAR (12),
	`card_name` VARCHAR (80),
	`card_num` VARCHAR (64),
	`user_name` VARCHAR (120),
	`auth_num` VARCHAR (200),
	`auth_date` CHAR (32),
	`auth_time` CHAR (24),
	`aqui_date` CHAR (32),
	`georae_coll` VARCHAR (512),
	`georae_stat` VARCHAR (16),
	`georae_cand` VARCHAR (32),
	`request_amount` DECIMAL (20),
	`amt_amount` DECIMAL (20),
	`vat_amount` DECIMAL (20),
	`ser_amount` DECIMAL (20),
	`fre_amount` DECIMAL (20),
	`amt_md_amount` DECIMAL (20),
	`vat_md_amount` DECIMAL (20),
	`georae_gukga` VARCHAR (12),
	`for_amount` DECIMAL (21),
	`usd_amount` DECIMAL (21),
	`merc_name` VARCHAR (400),
	`merc_saup_no` VARCHAR (80),
	`merc_addr` VARCHAR (2048),
	`merc_repr` VARCHAR (480),
	`merc_tel` VARCHAR (160),
	`merc_zip` VARCHAR (48),
	`mcc_name` VARCHAR (400),
	`mcc_code` VARCHAR (40),
	`mcc_stat` VARCHAR (8),
	`vat_stat` VARCHAR (4),
	`can_date` VARCHAR (32),
	`ask_site` VARCHAR (4),
	`site_date` VARCHAR (32),
	`ask_date` VARCHAR (32),
	`ask_time` VARCHAR (24),
	`gongje_no_chk` VARCHAR (4),
	`first_date` VARCHAR (32),
	`cancel_date` VARCHAR (32),
	`abroad` VARCHAR (12),
	`van_created_dt` DATETIME ,
	`van_edited_dt` DATETIME ,
	`created_by` INT (11),
	`created_dt` DATETIME ,
	`edited_dt` DATETIME ,
	`edited_by` INT (11),
	`edited_action` VARCHAR (1024),
	`createdate` VARCHAR (32),
	`createtime` VARCHAR (24),
	`sett_date` VARCHAR (32),
	`org_coll` VARCHAR (160),
	`aqui_rate` DECIMAL (21),
	`conversion_fee` DECIMAL (21),
	`auth_cd` VARCHAR (128),
	`auth_nm` VARCHAR (512),
	`summary_cd` VARCHAR (128),
	`summary_nm` VARCHAR (512),
	`pjt_cd` VARCHAR (128),
	`pjt_nm` VARCHAR (512),
	`detail` VARCHAR (400),
	`if_m_id` VARCHAR (128),
	`if_d_id` VARCHAR (128),
	`del_yn` VARCHAR (80),
	`app_div` VARCHAR (80),
	`send_yn` VARCHAR (4),
	`user_send_yn` VARCHAR (80),
	`emp_seq` VARCHAR (128),
	`summary_seq` VARCHAR (128),
	`auth_seq` VARCHAR (128),
	`project_seq` VARCHAR (128),
	`budget_seq` VARCHAR (128),
	`doc_seq` VARCHAR (128),
	`PK1` VARCHAR (100),
	`PK3` VARCHAR (100),
	`PK2` VARCHAR (100),
	`PK4` VARCHAR (100),
	`PK5` VARCHAR (100),
	`PK6` VARCHAR (100),
	`PK7` VARCHAR (100),
	`EBANK_KEY` VARCHAR (400),
	`closed_business_date` VARCHAR (32),
	`maigrationYN` VARCHAR (4),
	`erp_comp_seq` VARCHAR (128)
); 
ALTER TABLE acard_temp ADD INDEX PK ( PK1,PK2,PK3,PK4,PK5,PK6,PK7 );
ALTER TABLE t_ex_card_aq_tmp ADD INDEX PK ( PK1,PK2,PK3,PK4,PK5,PK6,PK7 );


/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.142 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 09. 01  17:00  ) - 허준녕  */
/* --------------------------------------------------------------------------------------------- */

ALTER TABLE `t_exnp_restrade` ADD `etc_employment_insurance_amt` bigint(64) DEFAULT 0 COMMENT '산재보험료' AFTER `etc_employment_amt`;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.142 2차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 09. 08  17:00  ) - 성기환  */
/* --------------------------------------------------------------------------------------------- */


ALTER TABLE `t_exnp_cause` ADD `payplan_date` varchar(8) COMMENT '지출/수입예정일' AFTER `inspect_date`;

/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 1.2.145 1차 배포  */
/* 여기까지 배포 완료 ( 배포일 : 2021. 10. 07  17:00  ) - 성기환  */
/* --------------------------------------------------------------------------------------------- */

