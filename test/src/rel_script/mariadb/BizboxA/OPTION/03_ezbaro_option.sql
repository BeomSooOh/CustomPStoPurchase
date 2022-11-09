/* 이지바로 ( 비영리 ) 옵션 설정 쿼리 *\
 * 
 */




INSERT IGNORE 
INTO `t_co_code_detail` 
(	`detail_code`
	, `code`
	, `ischild`
	, `order_num`
	, `flag_1`
	, `flag_2`
	, `use_yn`
	, `create_seq`
	, `create_date`
	, `modify_seq`
	, `modify_date`) 
VALUES( '5021'
	, 'ea0060'
	, 'N'
	, '5021'
	, NULL
	, NULL
	, 'Y'
	, 'SYSTEM'
	, SYSDATE()
	, 'SYSTEM'
	, SYSDATE() 
);


INSERT IGNORE 
INTO `t_co_code_detail_multi` 
(	`detail_code`
	, `code`
	, `lang_code`
	, `detail_name`
	, `note`
	, `use_yn`
	, `create_seq`
	, `create_date`
	, `modify_seq`
	, `modify_date`) 
VALUES( '5021'
	, 'ea0060'
	, 'en'
	, 'Ezboro(iCUBE)'
	, NULL
	, 'N'
	, 'SYSTEM'
	, SYSDATE()
	, 'SYSTEM'
	, SYSDATE()
);

INSERT IGNORE 
INTO `t_co_code_detail_multi` (
	`detail_code`
	, `code`
	, `lang_code`
	, `detail_name`
	, `note`
	, `use_yn`
	, `create_seq`
	, `create_date`
	, `modify_seq`
	, `modify_date`) 
VALUES( '5021'
	, 'ea0060'
	, 'kr'
	, '이지바로(iCUBE)'
	, NULL
	, 'N'
	, 'SYSTEM'
	, SYSDATE()
	, 'SYSTEM'
	, SYSDATE()
);


INSERT IGNORE 
INTO `teag_out_process` 
(	`out_process_id`
	, `process_nm`
	, `contents_tp`
	, `contents_pos`
	, `form_api`
	, `send_api`
	, `cancel_api`
	, `end_api`
	, `reject_api`
	, `delete_api`
	, `app_api`
	, `created_by`
	, `created_dt`
	, `modify_by`
	, `modify_dt`
	, `co_id`
	, `group_id`
	, `apply_api`
	, `detail_code_div`
	, `isprocess_yn`) 
VALUES( 'EziCUBE'
	, '이지바로결의서(iCUBE)'
	, '1'
	, '1'
	, '/exp/ApprovalProcess.do'
	, '/exp/ApprovalProcess.do'
	, '/exp/ApprovalProcess.do'
	, '/exp/ApprovalProcess.do'
	, '/exp/ApprovalProcess.do'
	, '/exp/ApprovalProcess.do'
	, NULL
	, 'SYSTEM'
	, SYSDATE()
	, 'SYSTEM'
	, SYSDATE()
	, '0' 
	, 'varGroupId'
	, '/exp/expend/ez/user/EzMasterPop.do'
	, 'ea0060'
	, '1'
);
	
/* --------------------------------------------------------------------------------------------- */
/* 여기까지 배포 완료 ( 배포일 : 2017. 05. 16. ) - 신재호 */
/* --------------------------------------------------------------------------------------------- */