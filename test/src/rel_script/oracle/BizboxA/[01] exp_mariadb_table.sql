/* --------------------------------------------------------------------------------------------- */
/* Bizbox Version => 6.7 */
/* 여기까지 배포 완료 ( 배포일 : 2019. 01. 10. ) - 이준성 */
/* --------------------------------------------------------------------------------------------- */

ALTER TABLE  t_ex_etax_aq_tmp ADD (
	use_yn varchar2(2)
	, use_yn_emp_seq varchar2(32)
);

/* 2019. 1. 16. */
/* 2019. 1. 16. - 허준녕 */
/* 2019. 1. 16. - 허준녕 - 21억 초과 금액 대응 속성 타입 변경 */
ALTER TABLE g20_abdocu_b MODIFY(
	apply_am BIGINT(19)
	, open_am BIGINT(19)
	, left_am BIGINT(19)
);

ALTER TABLE g20_Abdocu_t MODIFY(
	wd_am BIGINT
	, ndep_am BIGINT
	, inad_am BIGINT
	, intx_am BIGINT
	, rstx_am BIGINT
	, unit_am BIGINT
	, sup_am BIGINT
	, vat_am BIGINT
);

/* 2019. 1. 28. */
/* 2019. 1. 28. - 최상배 */
/* 2019. 1. 28. - 최상배 - 예산 7단계 옵션 대응 테이블 컬럼 추가 */
ALTER TABLE  t_exnp_resbudget ADD (
	erp_level01_seq varchar2(2)
	, erp_level01_name varchar2(32)
	, erp_level02_seq varchar2(64)
	, erp_level02_name varchar2(64)
	, erp_level03_seq varchar2(64)
	, erp_level03_name varchar2(64)
	, erp_level04_seq varchar2(64)
	, erp_level04_name varchar2(64)
	, erp_level05_seq varchar2(64)
	, erp_level05_name varchar2(64)
	, erp_level06_seq varchar2(64)
	, erp_level06_name varchar2(64)
);

ALTER TABLE  t_exnp_consbudget ADD (
	erp_level01_seq varchar2(2)
	, erp_level01_name varchar2(32)
	, erp_level02_seq varchar2(64)
	, erp_level02_name varchar2(64)
	, erp_level03_seq varchar2(64)
	, erp_level03_name varchar2(64)
	, erp_level04_seq varchar2(64)
	, erp_level04_name varchar2(64)
	, erp_level05_seq varchar2(64)
	, erp_level05_name varchar2(64)
	, erp_level06_seq varchar2(64)
	, erp_level06_name varchar2(64)
);

/* 2019. 2. 7. */
/* 2019. 2. 7. - 박용욱 */
/* 2019. 2. 7. - 박용욱 - 법인카드 승인번호 컬럼 사이즈 조정 ( 기존 20 -> 50 )  */
ALTER TABLE t_ex_card_aq_tmp MODIFY(
	auth_num varchar2(50)
);