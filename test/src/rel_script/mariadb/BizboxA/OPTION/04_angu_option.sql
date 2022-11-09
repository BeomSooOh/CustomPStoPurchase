/* 국고보조통합시스템 ( 비영리 ) 옵션 설정 쿼리 */

/* 1. 외부시스템 연동 프로세스 추가 */
/* 1.1 [iCUBE G20] 외부시스템 연동 프로세스 추가 */
INSERT IGNORE INTO `neos`.`teag_out_process` ( 
        `out_process_id`, `process_nm`, `contents_tp`, `contents_pos`
        , `form_api`
        , `send_api`
        , `cancel_api`
        , `end_api`
        , `reject_api`
        , `delete_api`
        , `app_api`, `apply_api`, `co_id`
        , `group_id`
        , `detail_code_div`, `isprocess_yn`, `created_by`, `created_dt`, `modify_by`, `modify_dt` )
VALUE (
        'ANGUI', '국고보조통합시스템연계(iCUBE G20)', '1', '1'
        , CONCAT('http://', IFNULL((SELECT comp_domain FROM t_co_comp WHERE IFNULL(comp_domain, '') != '' LIMIT 1), ''), '/exp/ApprovalProcess.do') /* 적용시 업체별 확인 필요 */
        , CONCAT('http://', IFNULL((SELECT comp_domain FROM t_co_comp WHERE IFNULL(comp_domain, '') != '' LIMIT 1), ''), '/exp/ApprovalProcess.do') /* 적용시 업체별 확인 필요 */
        , CONCAT('http://', IFNULL((SELECT comp_domain FROM t_co_comp WHERE IFNULL(comp_domain, '') != '' LIMIT 1), ''), '/exp/ApprovalProcess.do') /* 적용시 업체별 확인 필요 */
        , CONCAT('http://', IFNULL((SELECT comp_domain FROM t_co_comp WHERE IFNULL(comp_domain, '') != '' LIMIT 1), ''), '/exp/ApprovalProcess.do') /* 적용시 업체별 확인 필요 */
        , CONCAT('http://', IFNULL((SELECT comp_domain FROM t_co_comp WHERE IFNULL(comp_domain, '') != '' LIMIT 1), ''), '/exp/ApprovalProcess.do') /* 적용시 업체별 확인 필요 */
        , CONCAT('http://', IFNULL((SELECT comp_domain FROM t_co_comp WHERE IFNULL(comp_domain, '') != '' LIMIT 1), ''), '/exp/ApprovalProcess.do') /* 적용시 업체별 확인 필요 */
        , NULL, '/exp/ExpendPop.do', '0'
        , IFNULL(( SELECT group_seq FROM t_co_group LIMIT 1 ), '' ) /* 적용시 업체별 확인 필요 */
        , 'ea0060', '0', 'SYSTEM', NOW(), 'SYSTEM', NOW() );