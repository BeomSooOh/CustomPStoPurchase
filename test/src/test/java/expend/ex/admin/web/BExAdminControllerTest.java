package expend.ex.admin.web;

//import static org.mockito.Mockito.times;
//import static org.mockito.Mockito.verify;
//import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
//import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
//
//import org.junit.Before;
//import org.junit.Test;
//import org.mockito.ArgumentCaptor;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.http.MediaType;
//import org.springframework.test.web.servlet.MockMvc;
//import org.springframework.test.web.servlet.setup.MockMvcBuilders;
//import org.springframework.web.servlet.view.InternalResourceViewResolver;
//
//import com.fasterxml.jackson.core.JsonProcessingException;
//import com.fasterxml.jackson.databind.ObjectMapper;
//
//import common.vo.ex.ExReportCardVO;
//import expend.TestCase;
//import expend.ex.admin.report.BExAdminReportService;
//
///**
// * BExAdminControllerTest JUnit테스트
// * Created by Kwon Oh Gwang on 2019-08-02.
// * controller 테스트 시 pom.xml에 mockito 라이브러리 추가필요
// */
//public class BExAdminControllerTest extends TestCase {
//	private static final Logger logger = LoggerFactory.getLogger(BExAdminControllerTest.class);
//	
//	@Mock
//	BExAdminReportService reportService;
//	@InjectMocks
//	BExAdminController adminController;
//	
//	private MockMvc mockMvc;
//	
//	@Before
//	public void setUpControllerTest() {
//		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
//        viewResolver.setPrefix("/WEB-INF/");
//        viewResolver.setSuffix(".jsp");
//        
//		MockitoAnnotations.initMocks(this);
//	    mockMvc = MockMvcBuilders.standaloneSetup(adminController)
//	    						 .setViewResolvers(viewResolver)
//	    						 .build();
//	}
//	
//	/**
//	 * 지출결의 관리 - 카드 사용 현황 - 목록 조회
//	 * @throws JsonProcessingException 
//	 */
//	@Test
//	public void testExAdminCardReportListInfoSelect() throws Exception {
//		ExReportCardVO reportCardVO = new ExReportCardVO();
//		reportCardVO.setCompSeq("1241");
//		reportCardVO.setLangCode("kr");
//		reportCardVO.setCardNum("123");
//		reportCardVO.setCardName("");
//		reportCardVO.setFromDate("20190701");
//		reportCardVO.setToDate("20190801");
//		reportCardVO.setMercName("");
//		reportCardVO.setDocSts("");
//		reportCardVO.setUseYN("N");
//		
//		String jsonData = new ObjectMapper().writeValueAsString(reportCardVO);
//		
//		logger.info("### jsonData = {}", jsonData);
//		
//		mockMvc.perform(post("/ex/admin/card/cardReportList.do")
//						.session(session)
//						.contentType(MediaType.APPLICATION_JSON)
//						.content(jsonData)).andExpect(status().isOk());
//		
//		ArgumentCaptor<ExReportCardVO> argumentRportCardVO = ArgumentCaptor.forClass(ExReportCardVO.class); 
//		verify(reportService, times(1)).ExAdminCardReportListInfoSelect(argumentRportCardVO.capture());
//	}
//
//}
