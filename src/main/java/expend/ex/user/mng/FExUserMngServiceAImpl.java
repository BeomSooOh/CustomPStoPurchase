package expend.ex.user.mng;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendMngVO;


@Service ( "FExUserMngServiceA" )
public class FExUserMngServiceAImpl implements FExUserMngService {

	/* 변수정의 */
	@Resource ( name = "FExUserMngServiceADAO" )
	private FExUserMngServiceADAO exUserMngServiceADAO;

	/* 공통코드 */
	/* 공통코드 - 지출결의 항목 분개 관리항목 목록 조회 */
	@Override
	public List<ExExpendMngVO> ExCodeMngListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		return mngListVo;
	}

	/* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 */
	@Override
	public List<ExExpendMngVO> ExCodeMngDListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		return mngListVo;
	}

	@Override
	public ResultVO ExExpendMngNecessaryOptionInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	/* 공통코드 - iCUBE 사용자 정의 관리항목 연동 항목 조회 */
	@Override
	public List<ExExpendMngVO> ExCutomMngRealInfoSelect(ExExpendMngVO mngVo, ConnectionVO conVo) throws Exception {
		return null;
	}
}