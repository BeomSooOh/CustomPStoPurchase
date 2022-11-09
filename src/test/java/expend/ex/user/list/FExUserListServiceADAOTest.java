package expend.ex.user.list;

import static org.junit.Assert.*;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendListVO;
import expend.TestCase;

/**
 * FExUserListServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-03-08.
 */
public class FExUserListServiceADAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserListServiceADAOTest.class);
	
	@Autowired
	private FExUserListServiceADAO fExUserListServiceADAO;

	/**
	 * 지출결의 - 지출결의 항목 그리드 목록 조회
	 * @param listVo
	 * @return
	 * @throws Exception
	 */
	@Test
	public void ExListGridInfoSelect() throws Exception {
		ExExpendListVO listVo = new ExExpendListVO();
		listVo.setCompSeq("EXP_iCUBE");
		listVo.setExpendSeq("1001");
		
		List<Map<String, Object>> result = fExUserListServiceADAO.ExListGridInfoSelect(listVo);
		
		assertTrue(result.size() > 0);
	}

	/**
	 * 지출결의 항목 생성
	 */
	@Test
	public void testExListInfoInsert() throws Exception {
		ExExpendListVO listVo = new ExExpendListVO();
		
		listVo.setExpendSeq("9999");
		listVo.setListSeq("1");
		listVo.setSummarySeq(2919);
		listVo.setAuthSeq(2846);
		listVo.setWriteSeq(7722);
		listVo.setEmpSeq(7725);
		listVo.setBudgetSeq(0);
		listVo.setProjectSeq(2897);
		listVo.setPartnerSeq(3318);
		listVo.setCardSeq(2808);
		listVo.setFeeSeq(0);
		listVo.setAuthDate("20170214");
		listVo.setNote("접대비");
		listVo.setStdAmt("6000.00");
		listVo.setTaxAmt("600.00");
		listVo.setAmt("6600.00");
		listVo.setSubStdAmt("6000.00");
		listVo.setSubTaxAmt("600.00");
		listVo.setInterfaceType("");
		listVo.setInterfaceMId("");
		listVo.setInterfaceDId("0");
		listVo.setJsonStr("");
		listVo.setCreateSeq("10033");
		listVo.setModifySeq("10033");
		listVo.setAutoCalcYn("");
		listVo.setOrderSeq(1);
		listVo.setExchangeUnitCode("001");
		listVo.setExchangeUnitName("USD");
		listVo.setExchangeRate("1100.00");
		listVo.setForeignCurrencyAmount("22000.0000");
		listVo.setForeignAcctYN("Y");
		
		ExExpendListVO result = fExUserListServiceADAO.ExListInfoInsert(listVo);
		
		assertTrue(Integer.valueOf(result.getListSeq()) > 0);
	}
	
	/**
	 * 항목정보의 정렬순서 순번 채번
	 * @throws Exception 
	 */
	@Test
	public void testExExpendListOrderInfoSelect() throws Exception {
		ExExpendListVO listVo = new ExExpendListVO();
		listVo.setExpendSeq("9999");
		
		int result = fExUserListServiceADAO.ExExpendListOrderInfoSelect(listVo);
		logger.info("### result = " + result);
		
		assertTrue(result > 0);
	}
	
	/**
	 * 지출결의 항목 삭제
	 * @throws Exception 
	 */
	@Test
	public void testExListInfoDelete() throws Exception {
		ExExpendListVO listVo = new ExExpendListVO();
		listVo.setExpendSeq("1001");
		listVo.setListSeq("1");
		
		ExCommonResultVO resultVo = fExUserListServiceADAO.ExListInfoDelete(listVo);
		
		logger.info("### resultVo = " + resultVo);
		
		assertEquals("SUCCESS", resultVo.getCode());
	}
	
	/**
	 * 정렬순서 채번 후 항목정보 등록 테스트
	 * @throws Exception 
	 */
	@Test
	public void testInsertExpendListAfterGetOrderSeq() throws Exception {
		int orderSeq = 0;
		
		ExExpendListVO listVo = new ExExpendListVO();
		listVo.setExpendSeq("1001");
		listVo.setListSeq("1");
		listVo.setOrderSeq(1);
		
		ExCommonResultVO resultVo = fExUserListServiceADAO.ExListInfoDelete(listVo);
		
		//항목정보 삭제 검증
		assertEquals("SUCCESS", resultVo.getCode());
		
		if(resultVo.getCode() == "SUCCESS") {
			//ExExpendListVO에 ListSeq가 없는 경우만 order_seq 채번
			if(listVo.getListSeq() == "") {
				orderSeq = fExUserListServiceADAO.ExExpendListOrderInfoSelect(listVo);
			//ListSeq가 있는 경우 ExExpendListVO에 orderSeq로 대체
			}else {
				orderSeq = listVo.getOrderSeq();
			}
			
			logger.info("### orderSeq = " + orderSeq);
			//항목정보 정렬순서 검증
			assertTrue(orderSeq > 0);
			
			listVo.setSummarySeq(2919);
			listVo.setAuthSeq(2846);
			listVo.setWriteSeq(7722);
			listVo.setEmpSeq(7725);
			listVo.setBudgetSeq(0);
			listVo.setProjectSeq(2897);
			listVo.setPartnerSeq(3318);
			listVo.setCardSeq(2808);
			listVo.setFeeSeq(0);
			listVo.setAuthDate("20170214");
			listVo.setNote("접대비");
			listVo.setStdAmt("6000.00");
			listVo.setTaxAmt("600.00");
			listVo.setAmt("6600.00");
			listVo.setSubStdAmt("6000.00");
			listVo.setSubTaxAmt("600.00");
			listVo.setInterfaceType("");
			listVo.setInterfaceMId("");
			listVo.setInterfaceDId("0");
			listVo.setJsonStr("");
			listVo.setCreateSeq("10033");
			listVo.setModifySeq("10033");
			listVo.setAutoCalcYn("");
			listVo.setOrderSeq(orderSeq);
			
			ExExpendListVO result = fExUserListServiceADAO.ExListInfoInsert(listVo);
			
			//항목정보 등록 검증
			assertTrue(Integer.valueOf(result.getListSeq()) > 0);
		}
	}

}
