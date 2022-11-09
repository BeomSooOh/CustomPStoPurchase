package expend.ex2.admin.code;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.exception.NotFoundLogicException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;

@Service ( "FEx2AdminCodeServiceU" )
public class FEx2AdminCodeServiceUImpl implements FEx2AdminCodeService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FEx2AdminCodeServiceUDAO" )
	private FEx2AdminCodeServiceUDAO dao;

	@Override
	public List<Map<String, Object>> Ex2AdminCommCodeSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		String codeType = params.get(commonCode.CODETYPE).toString();

		throw new NotFoundLogicException(String.format("처리 분기 {0}를 찾을 수 없습니다.", codeType), commonCode.ETC);

	}
}
