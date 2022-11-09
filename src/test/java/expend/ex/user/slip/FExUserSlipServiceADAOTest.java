package expend.ex.user.slip;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Test;

import common.vo.ex.ExExpendSlipVO;
import expend.TestCase;

/**
 * FExUserSlipServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-10-29.
 */
public class FExUserSlipServiceADAOTest extends TestCase {
	
	@Resource ( name = "FExUserSlipServiceADAO" )
	private FExUserSlipServiceADAO exUserSlipServiceADAO;

	/**
	 * 지출결의 - 지출결의 항목 분개 생성
	 * @throws Exception 
	 */
	@Test
	public void testExSlipInfoInsert() throws Exception {
		ExExpendSlipVO slipVo = new ExExpendSlipVO();
		
		slipVo.setExpendSeq("99999");
		slipVo.setListSeq("1");
		slipVo.setSlipSeq("1");
		slipVo.setSummarySeq(1287);
		slipVo.setAuthSeq(1305);
		slipVo.setWriteSeq(3267);
		slipVo.setEmpSeq(3296);
		slipVo.setBudgetSeq(608);
		slipVo.setProjectSeq(1305);
		slipVo.setPartnerSeq(1374);
		slipVo.setDrcrGbn("dr");
		slipVo.setAcctCode("54900");
		slipVo.setAcctName("복리후생비");
		slipVo.setCardSeq(1239);
		slipVo.setFeeSeq(0);
		slipVo.setAuthDate("20190422");
		slipVo.setNote("복리후생비");
		slipVo.setAmt("1010.00");
		slipVo.setSubStdAmt("0.00");
		slipVo.setSubTaxAmt("0.00");
		slipVo.setInterfaceType("");
		slipVo.setInterfaceMId("");
		slipVo.setInterfaceDId("");
		slipVo.setJsonStr("");
		slipVo.setCreateSeq("1233");
		slipVo.setModifySeq("1233");
		slipVo.setExchangeUnitCode("001");
		slipVo.setExchangeUnitName("USD");
		slipVo.setExchangeRate("1100.00");
		slipVo.setForeignCurrencyAmount("22000.0000");
		slipVo.setForeignAcctYN("Y");

		ExExpendSlipVO result = exUserSlipServiceADAO.ExSlipInfoInsert(slipVo);
		assertTrue(Integer.valueOf(result.getSlipSeq()) > 0);
	}
	
	/**
	 * 지출결의 - 지출결의 항목 재분개 생성
	 * @throws Exception 
	 */
	@Test
	public void testExSlipInfoReInsert() throws Exception {
		ExExpendSlipVO slipVo = new ExExpendSlipVO();
		
		slipVo.setExpendSeq("99999");
		slipVo.setListSeq("1");
		slipVo.setSlipSeq("1");
		slipVo.setSummarySeq(1287);
		slipVo.setAuthSeq(1305);
		slipVo.setWriteSeq(3267);
		slipVo.setEmpSeq(3296);
		slipVo.setBudgetSeq(608);
		slipVo.setProjectSeq(1305);
		slipVo.setPartnerSeq(1374);
		slipVo.setDrcrGbn("dr");
		slipVo.setAcctCode("54900");
		slipVo.setAcctName("복리후생비");
		slipVo.setCardSeq(1239);
		slipVo.setFeeSeq(0);
		slipVo.setAuthDate("20190422");
		slipVo.setNote("복리후생비");
		slipVo.setAmt("1010.00");
		slipVo.setSubStdAmt("0.00");
		slipVo.setSubTaxAmt("0.00");
		slipVo.setInterfaceType("");
		slipVo.setInterfaceMId("");
		slipVo.setInterfaceDId("");
		slipVo.setJsonStr("");
		slipVo.setCreateSeq("1233");
		slipVo.setModifySeq("1233");
		slipVo.setExchangeUnitCode("001");
		slipVo.setExchangeUnitName("USD");
		slipVo.setExchangeRate("1100.00");
		slipVo.setForeignCurrencyAmount("22000.0000");
		slipVo.setForeignAcctYN("Y");

		ExExpendSlipVO result = exUserSlipServiceADAO.ExSlipInfoReInsert(slipVo);
		assertTrue(Integer.valueOf(result.getSlipSeq()) > 0);
	}
	
	/**
	 * 지출결의 - 지출결의 항목 분개 조회
	 * @throws Exception
	 */
	@Test
	public void testExSlipInfoSelect() throws Exception {
		ExExpendSlipVO slipVo = new ExExpendSlipVO();
		
		slipVo.setExpendSeq("5338");
		slipVo.setListSeq("1");
		slipVo.setSlipSeq("1");
		
		ExExpendSlipVO result = exUserSlipServiceADAO.ExSlipInfoSelect(slipVo);
		assertNotNull(result.getExpendSeq());
	}

}
