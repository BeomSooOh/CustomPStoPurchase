package expend.ex.admin.etax;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FExAdminConfigServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FExAdminETaxServiceA" )
public class FExAdminETaxServiceAImpl implements FExAdminETaxService {

	/* 변수정의 - DAO */
	@Resource ( name = "FExAdminETaxServiceADAO" )
	private FExAdminETaxServiceADAO daoA;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	
	/* 세금계산서 권한 설정 페이지 - 회사 귀속 모든 권한 리스트 조회 */
	public ResultVO AdminETaxAuthAllListSelect ( ResultVO param ) throws Exception{
		daoA.ExAdminETaxAuthAllListSelect(param);
		return param;
	}
	
	/* 세금계산서 권한 설정 페이지 - 권한 리스트 조회 */
	@Override
	public ResultVO ExAdminETaxAuthListSelect ( ResultVO param ) throws Exception {
		daoA.ExAdminETaxAuthListSelect(param);
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 추가 */
	@Override
	public ResultVO ExAdminETaxAuthInsert ( ResultVO param ) throws Exception {
		daoA.ExAdminETaxAuthInsert(param);
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 삭제 */
	@Override
	public ResultVO ExAdminETaxAuthDelete ( ResultVO param ) throws Exception {
		daoA.ExAdminETaxAuthDelete(param);
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 수정 */
	@Override
	public ResultVO ExAdminETaxAuthUpdate ( ResultVO param ) throws Exception {
		daoA.ExAdminETaxAuthUpdate(param);
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 추가 */
	@Override
	public ResultVO ExAdminETaxAuthPublicInsert ( ResultVO param ) throws Exception{
		daoA.ExAdminETaxAuthPublicInsert(param);
		return param;
	}

	/* 세금계산서 권한 설정 페이지 - 권한 공개범위 삭제 */
	@Override
	public ResultVO ExAdminETaxAuthPublicDelete ( ResultVO param ) throws Exception {
		daoA.ExAdminETaxAuthPublicDelete(param);
		return param;
	}

	
}
