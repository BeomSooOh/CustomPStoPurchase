package expend;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.SqlSessionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import expend.np.user.cons.FNpUserConsServiceADAO;

/**
 * 테스트 케이스 설정
 * 
 * @remark 상속 받아서 사용하면 테스트 케이스 작성에 용이 created by Jinhak Kim on 2019-01-09
 */
@Transactional
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/test/resources/egovframework/spring/com/*.xml"})
public class TestCase extends EgovComAbstractDAO {
	
	@Autowired
	public FNpUserConsServiceADAO fnpusercons;
	
	protected LoginVO loginVO;
    protected MockHttpSession session;
    protected MockHttpServletRequest request;
    protected SqlSession erpSession;

    @Before
    public void setUp() {
        // 로그인 세션설정
        
         loginVO = new LoginVO();
         loginVO.setGroupSeq( "dragons_test" );
         loginVO.setCompSeq( "1241" );
         loginVO.setBizSeq( "1241" );
         loginVO.setOrgnztId( "1242" );
         loginVO.setUniqId( "1244" );
         loginVO.setLangCode( "kr" );
         loginVO.setUserSe( "ADMIN" );
         loginVO.setEaType( "eap" );
         loginVO.setErpEmpCd( "000059" );
         loginVO.setErpCoCd( "10000" );
        
         session = new MockHttpSession();
         session.setAttribute("loginVO", loginVO);
        
         request = new MockHttpServletRequest();
         request.setSession(session);
         RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));
    }

    @After
    public void tearDown() {}

    /**
     * erp 연결설정
     * 
     * @throws Exception
     */
    public void erpConnectionConfig(ConnectionVO conVo) throws Exception {
        erpSession = this.connect(conVo).getSqlSessionFactory().openSession();
    }

    /* 공통사용 - 커넥션 */
    private SqlSessionVO connect(ConnectionVO conVo) throws Exception {
        String mapPath = "ex";
        if (!MapUtil.hasKey(CommonErpConnect.connections, CommonConvert.CommonGetStr(conVo.getUrl()))) {
            SqlSessionVO sqlSessionVo = new SqlSessionVO(conVo, mapPath);
            CommonErpConnect.connections.put(CommonConvert.CommonGetStr(conVo.getUrl()), sqlSessionVo);
        }
        return (SqlSessionVO) CommonErpConnect.connections.get(CommonConvert.CommonGetStr(conVo.getUrl()));
    }
    
//    public void nptest() {
//    	
//    	Map<String, Object> params = new HashMap<String, Object>( );
////    	params.put('consDocSeq', '');
////
////		'consSeq',
////		'erpBqSeq', 
////		'erpBkSeq', 
////		'erpBudgetSeq',
////		'erpBudgetName',
////		'erpBizplanSeq',
////		'erpBizplanName',
////		'erpBgt1Name',
////		'erpBgt1Seq',  
////		'erpBgt2Name', 
////		'erpBgt2Seq', 
////		'erpBgt3Name', 
////		'erpBgt3Seq', 
////		'erpBgt4Name', 
////		'erpBgt4Seq', 
////		'erpOpenAmt', 
////		'erpApplyAmt', 
////		'erpResAmt',
////		'erpLeftAmt', 
////		'budgetStdAmt', 
////		'budgetTaxAmt', 
////		'budgetAmt', 
////		'erpBgacctSeq', 
////		'erpBgacctName', 
////		'setFgCode',
////		'setFgName', 
////		'vatFgCode', 
////		'vatFgName', 
////		'trFgCode',
////		'trFgName', 
////		'ctlFgCode', 
////		'ctlFgName', 
////		'budgetNote', 
////		'erpDivSeq', 
////		'erpDivName', 
////		'empSeq',
////		'erpFiacctSeq',
////		'erpFiacctName',
////		'erpLevel01Seq' , 
////		'erpLevel01Name',
////		'erpLevel02Seq' , 
////		'erpLevel02Name',
////		'erpLevel03Seq' , 
////		'erpLevel03Name',
////		'erpLevel04Seq' , 
////		'erpLevel04Name',
////		'erpLevel05Seq' , 
////		'erpLevel05Name',
////		'erpLevel06Seq' , 
////		'erpLevel06Name'
//    	
//    	try {
//			ResultVO result = fnpusercons.insertConsBudget(params);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//    }

}
