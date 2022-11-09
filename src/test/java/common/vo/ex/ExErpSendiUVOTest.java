package common.vo.ex;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import expend.TestCase;

/**
 * ExErpSendiUVOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-05-17.
 */
public class ExErpSendiUVOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(ExErpSendiUVOTest.class);

	/**
	 * 적요 생성 메서드 테스트
	 */
	@Test
	public void testNM_PUMM() {
		String type0 = "NONAME";
		String type1 = "DOCNO(TITLE)";
		String type2 = "FORMNM:TITLE(DOCNO)";
		String type3 = "TITLE(DOCNO)";
		String type4 = "TITLE(FORMNM:DOCNO)";
		
		logger.info("### type0 = {}", NM_PUMM(type0));
		logger.info("### type1 = {}", NM_PUMM(type1));
		logger.info("### type2 = {}", NM_PUMM(type2));
		logger.info("### type3 = {}", NM_PUMM(type3));
		logger.info("### type4 = {}", NM_PUMM(type4));
	}
	
	private String NM_PUMM(String noteOptionValue) {
		String note = "테스트 입니다.";
		String doc_no = "제7호20190513";
		String doc_title = "자동전송_문서단위_iCUBE";
		String form_nm = "지출결의서(iCUBE)_부산";
		
		String nmPumm = note;
		
		//전표입력 화면의 품의내역 설정을 사용하는 경우(적요 설정 옵션)
		if(!(noteOptionValue.equals("") || noteOptionValue.equals("NONAME"))) {
			//문서번호
			if(noteOptionValue.indexOf("DOCNO") > -1) {
				noteOptionValue = noteOptionValue.replace("DOCNO", doc_no);
			}
			//문서제목
			if(noteOptionValue.indexOf("TITLE") > -1) {
				noteOptionValue = noteOptionValue.replace("TITLE", doc_title);
			}
			//양식명
			if(noteOptionValue.indexOf("FORMNM") > -1) {
				noteOptionValue = noteOptionValue.replace("FORMNM", form_nm);
			}
			
			nmPumm = noteOptionValue;
		}
		
		if ( nmPumm.length( ) > 100 ) {
			nmPumm = nmPumm.substring( 0, 100 );
		}
		
		return nmPumm;
	}

}
