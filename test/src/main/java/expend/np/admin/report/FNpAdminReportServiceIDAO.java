package expend.np.admin.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.util.MapUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
//import common.helper.exception.NotFoundLoginSessionException;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.SqlSessionVO;
import common.vo.np.NpErpSendG20VO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FNpAdminReportServiceIDAO" )
public class FNpAdminReportServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog;
	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );
	/* 변수정의 */
	//private SqlSessionFactory sqlSessionFactory;

	/* 공통사용 */
	/* 공통사용 - 커넥션 */
	private SqlSessionVO connect ( ConnectionVO conVo ) throws Exception {
		String mapPath = "ex";
		if ( !MapUtil.hasKey( CommonErpConnect.connections, CommonConvert.CommonGetStr( conVo.getUrl( ) ) ) ) {
			SqlSessionVO sqlSessionVo = new SqlSessionVO( conVo, mapPath );
			CommonErpConnect.connections.put( CommonConvert.CommonGetStr( conVo.getUrl( ) ), sqlSessionVo );
		}
		return (SqlSessionVO) CommonErpConnect.connections.get( CommonConvert.CommonGetStr( conVo.getUrl( ) ) );
	}

	/* 공통사용 */
	/* 공통사용 - 파라미터 검증 */
	@SuppressWarnings ( "unused" )
	private class paramChecker {

		public String msg;
		public boolean resultCode;

		paramChecker ( ) {
			this.msg = "";
			this.resultCode = true;
		}
	}

	private paramChecker ParameterCheck ( Map<String, Object> params, String[] args ) {
		paramChecker c = new paramChecker( );
		for ( String item : args ) {
			if ( params.get( item ) == null ) {
				c.resultCode = false;
				c.msg = "not found parameter parameter " + item;
				return c;
			}
		}
		c.resultCode = true;
		c.msg = "success";
		return c;
	}

	/**
	 * ERP 결의서 키 조회
	 */
	public int selectERPAbdocuKey ( SqlSession session, Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		int result = 1;

		List<Map<String, Object>> list = session.selectList( "g20Procedure.selectERPAbdocuKey", params );
		result = Integer.parseInt( list.get( 0 ).get( "gisuSeq" ).toString( ) );

		return result;
	}

	/**
	 * ERP 예산 키 조회
	 */
	public int selectERPAbdocuBKey ( SqlSession session, Map<String, Object> params ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		int result = 1;
		List<Map<String, Object>> list = session.selectList( "g20Procedure.selectERPAbdocuBKey", params );
		result = Integer.parseInt( list.get( 0 ).get( "bgSeq" ).toString( ) );
		return result;
	}

	/**
	 * ERP 결의서 전송
	 */
	public synchronized ResultVO sendABDOCU ( NpErpSendG20VO sendVo, ConnectionVO conVo , Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		// connect( conVo );
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		Map<String, Object> doc = sendVo.getDoc( );
		/* 롤백 프로세스 준비 */
		List<String> erpCompSeqForRollBack = new ArrayList( );
		List<String> erpGisuDtsForRollBack = new ArrayList( );
		List<String> erpGisuSqsForRollBack = new ArrayList( );
		String erpCompSeq = "";
		String erpGisuDate = "";
		String erpGisuSeq = "";
		cmLog.CommonSetInfo("senABDOCU params : " + params.toString());


		try {
			int bgSeq = 1;
			int lnSeq = 1;
			int dLnSeq = 1; // abdocu_d.ln_sq
			sendVo.initIdx( );
			while ( sendVo.getNextHead123( ) != null ) {
				/* 헤더 정보 기준 Loop */
				Map<String, Object> head = sendVo.getHead( );
				int headKey = this.selectERPAbdocuKey( session, head );
				head.put( "erpGisuSeq", headKey );
				head.put( "erpGisuDate", head.get( "resDate" ) );
				head.put( "groupSeq", CommonConvert.NullToString(params.get("groupSeq")) );
				erpCompSeq = head.get( "erpCompSeq" ).toString( );
				erpGisuDate = head.get( "erpGisuDate" ).toString( );
				erpGisuSeq = head.get( "erpGisuSeq" ).toString( );
				int resultHeadCnt = session.insert( "g20Procedure.insertABDOCU", head );
				if ( resultHeadCnt == 0 ) {
					throw new Exception( "결의서 헤더 전송 오류" );
				}
				if(!CommonConvert.NullToString(head.get("causeDate")).equals("")) {
					int resultCauseCnt = session.insert( "g20Procedure.insertCauseDt", head );
					if ( resultCauseCnt == 0 ) {
						throw new Exception( "결의서 원인 행위 전송 오류" );
					}
				}
				
				
				while ( sendVo.getNextBudget( ) != null ) {
					/* 예산 정보 기준 Loop */
					Map<String, Object> budget = sendVo.getBudget( );
					budget.put( "erpGisuSeq", headKey );
					budget.put( "erpGisuDate", head.get( "resDate" ) );
					budget.put( "erpBgSeq", bgSeq );
					budget.put( "groupSeq", CommonConvert.NullToString(params.get("groupSeq")) );
					params.put("docNo", budget.get("docNo"));
					if(budget.get("budgetSendOpt").equals("0")) {
						budget.put("budgetNote", budget.get("docNo") + " " + budget.get("budgetNote"));
					}
					int resultBudgetCnt = session.insert( "g20Procedure.insertABDOCU_B", budget );
					if ( resultBudgetCnt == 0 ) {
						throw new Exception( "결의서 예산 전송 오류" );
					}
					while ( sendVo.getNextTrade( ) != null ) {
						/* 채주 정보 기준 Loop */
						Map<String, Object> trade = sendVo.getTrade( );
						trade.put( "erpGisuSeq", headKey );
						trade.put( "erpGisuDate", head.get( "resDate" ) );
						trade.put( "erpBgSeq", bgSeq );
						trade.put( "erpLnSeq", lnSeq );
						trade.put( "etYN", "1" );
						trade.put( "groupSeq", CommonConvert.NullToString(params.get("groupSeq")) );


						/* [1] 여입/반납 결의서 처리 */
						if ( CommonConvert.CommonGetStr(head.get( "docuFgCode" )).equals( "6" ) || CommonConvert.CommonGetStr(head.get( "docuFgCode" )).equals( "7" ) ) {
							trade.put( "amt", this.reverseAmount( trade.get( "amt" ) ) );
							trade.put( "stdAmt", this.reverseAmount( trade.get( "stdAmt" ) ) );
							trade.put( "vatAmt", this.reverseAmount( trade.get( "vatAmt" ) ) );
							trade.put( "ndepAmt", this.reverseAmount( trade.get( "ndepAmt" ) ) );
							trade.put( "inadAmt", this.reverseAmount( trade.get( "inadAmt" ) ) );
							trade.put( "intxAmt", this.reverseAmount( trade.get( "intxAmt" ) ) );
							trade.put( "rstxAmt", this.reverseAmount( trade.get( "rstxAmt" ) ) );
							trade.put( "wdAmt", this.reverseAmount( trade.get( "wdAmt" ) ) );
						}

						/* [2] 기타소득자 사용자 수기 입력 예외처리 */
						if(CommonConvert.CommonGetStr(budget.get( "trFgCode" )).equals( "4" ) && CommonConvert.CommonGetStr(trade.get( "trSeq" )).equals( "" )){
							trade.put( "erpDivSeq", "" );
							trade.put( "etcDataCd", "" );
							trade.put( "etYN", "" );
						}

						/* [3] 사업소득자 사용자 수기 입력 예외처리 */
						if(CommonConvert.CommonGetStr(budget.get( "trFgCode" )).equals( "9" ) && CommonConvert.CommonGetStr(trade.get( "trSeq" )).equals( "" ) ){
							trade.put( "erpDivSeq", "" );
							trade.put( "etcDataCd", "" );
							trade.put( "etYN", "" );
							trade.put( "etcIncomeSeq", "" );
						}
						
						if(!CommonConvert.NullToString(trade.get("payTrSeq")).equals("")) {
							trade.put( "trSeq", trade.get("payTrSeq") );
							trade.put( "trName", trade.get("payTrName") );
						}

						session.insert( "g20Procedure.insertABDOCU_T", trade );
						/* 상태값및 거래처 키 없데이트 진행 */
						int resultCnt = (int) update( "NpUserResA.updateResTradeERPKey", trade );
						if ( resultCnt == 0 ) {
							throw new Exception( "GW 거래처 정보 갱신 실패" );
						}
						lnSeq++;
						session.commit( );
					}
					/* 상태값및 예산 키 없데이트 진행 */
					int resultCnt = (int) update( "NpUserResA.updateResBudgetERPKey", budget );
					if ( resultCnt == 0 ) {
						throw new Exception( "GW 거래처 정보 갱신 실패" );
					}
					lnSeq = 1;
					bgSeq++;
				}
				while( sendVo.getNextItemSpec() != null) {
					Map<String, Object> itemSpec = sendVo.getItemSpec();
					itemSpec.put( "erpGisuSeq", headKey );
					itemSpec.put( "erpGisuDate", head.get( "resDate" ) );
					itemSpec.put( "erpLnSeq", dLnSeq );
					itemSpec.put( "groupSeq", CommonConvert.NullToString(params.get("groupSeq")) );
					int resultItemSpecCnt = session.insert( "g20Procedure.insertABDOCU_D", itemSpec );
					if ( resultItemSpecCnt == 0 ) {
						//throw new Exception( "결의서 예산 전송 오류" );
					}
					dLnSeq++;
				}
				bgSeq = 1;
				dLnSeq = 1;
				/* 상태값및 결의서 키 없데이트 진행 */
				int resultCnt = (int) update( "NpUserResA.updateResHeadERPKey", head );
				if ( resultCnt == 0 ) {
					throw new Exception( "GW 거래처 정보 갱신 실패" );
				}

			}
			/* ERP 전송 상태 변경 */
			try{
				LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
				doc.put( "sendEmpName", loginVo.getName( ) );
				doc.put( "sendEmpSeq", loginVo.getUniqId( ) );
			} catch(Exception ex){
				doc.put( "sendEmpName", "자동전송" );
				doc.put( "sendEmpSeq", "SYSTEM");
				doc.put( "groupSeq", CommonConvert.NullToString(params.get("groupSeq")) );
			}
			doc.put( "sendYN", "Y" );
			int resultCnt = (int) update( "NpUserResA.updateResDocErpSend", doc );
			if ( resultCnt == 0 ) {
				throw new Exception( "GW 거래처 정보 갱신 실패" );
			}


			session.commit( );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			ex.printStackTrace();
			session.rollback( );
			doc.put( "sendYN", "N" );
			update( "NpUserResA.updateResDocErpSend", doc );
			erpCompSeqForRollBack.add( erpCompSeq );
			erpGisuDtsForRollBack.add( erpGisuDate );
			erpGisuSqsForRollBack.add( erpGisuSeq );
			Map<String, Object> rollBackParams = new HashMap<>( );
			rollBackParams.put( "erpCompSeqs", erpCompSeqForRollBack );
			rollBackParams.put( "erpGisuDts", erpGisuDtsForRollBack );
			rollBackParams.put( "erpGisuSqs", erpGisuSqsForRollBack );
			this.deleteAbdocu( rollBackParams, conVo );
			result.setFail( "데이터 전송에 실패하였습니다." );
		}
		finally {
			session.close( );
		}
		return result;
	}

	private long reverseAmount ( Object o ) {
		long returnObj = 0;
		try {
			if ( o == null ) {
				returnObj = 0;
			}
			else {
				returnObj = Long.parseLong( o.toString( ) ) * -1;
			}
		}
		catch ( Exception ex ) {
			returnObj = 0;
		}
		return returnObj;
	}

	/**
	 * ERP 결의서 전송 취소
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO deleteAbdocu ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			/* parameter 검증 진행. */
			if ( params.get( "residence" ) == null ) {
				params.put( "residence", "" );
			}
			paramChecker c = ParameterCheck( params, new String[] { "erpCompSeqs", "erpGisuDts", "erpGisuSqs" } );
			if ( !c.resultCode ) {
				throw new Exception( c.msg );
			}
			List<String> erpCompSeqs = (List<String>) params.get( "erpCompSeqs" );
			List<String> erpGisuDts = (List<String>) params.get( "erpGisuDts" );
			List<String> erpGisuSqs = (List<String>) params.get( "erpGisuSqs" );
			if ( !(erpCompSeqs.size( ) == erpGisuDts.size( ) && erpCompSeqs.size( ) == erpGisuSqs.size( )) ) {
				result.setFail( "삭제 대상 결의서 검증에 실패하였습니다." );
			}
			for ( int i = 0; i < erpCompSeqs.size( ); i++ ) {
				Map<String, Object> deleteParam = new HashMap<>( );
				deleteParam.put( "erpCompSeq", erpCompSeqs.get( i ) );
				deleteParam.put( "erpGisuDt", erpGisuDts.get( i ) );
				deleteParam.put( "erpGisuSq", erpGisuSqs.get( i ) );
				session.delete( "g20Procedure.deleteABDOCU", deleteParam );
			}
			session.commit( );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			session.rollback( );
			result.setFail( "ERP DB연동 처리중 오류가 발생하였습니다.", ex );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 전송된 결의서 전표 키 조회
	 */
	public ResultVO selectERPIsuKey ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			/* parameter 검증 진행. */
			if ( params.get( "residence" ) == null ) {
				params.put( "residence", "" );
			}
			paramChecker c = ParameterCheck( params, new String[] { "erpCompSeq", "erpGisuDt", "erpGisuSq" } );
			if ( !c.resultCode ) {
				throw new Exception( c.msg );
			}
			List<Map<String, Object>> resultList = session.selectList( "g20Procedure.selectERPIsuKey", params );
			result.setAaData( resultList );
			result.setSuccess( );
		}
		catch ( Exception ex ) {
			result.setFail( "ERP DB연동 처리중 오류가 발생하였습니다.", ex );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 결의서 전송 / 취소 상태값 변경
	 */
	//public ResultVO sendCancelABDOCU ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	public ResultVO sendCancelABDOCU ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO( );
		try {
			params.put( "sendYN", "N" );
			int resultCnt = (int) update( "NpUserResA.updateResDocErpSend", params );
			if ( resultCnt == 0 ) {
				throw new Exception( "GW 거래처 정보 갱신 실패" );
			}
			result.setSuccess( );
		}
		catch ( Exception e ) {
			throw new Exception( " ERP 결의서 전송취소 실패 " );
		}
		return result;
	}

	/**
	 * 결의서 전송 / 법인카드 승인내역 정보 연동
	 */
	public ResultVO updateG20SendCardList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			session.update( "g20Procedure.updateG20SendCardList", params );
			result.setSuccess( );
			session.commit( );
		}
		catch ( Exception ex ) {
			result.setFail( "ERP DB연동 처리중 오류가 발생하였습니다.", ex );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 결의서 전송 / 법인카드 승인내역 정보 연동 취소
	 */
	public ResultVO updateG20DeSendCardList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			session.update( "g20Procedure.updateG20DeSendCardList", params );
			result.setSuccess( );
			session.commit( );
		}
		catch ( Exception ex ) {
			result.setFail( "ERP DB연동 처리중 오류가 발생하였습니다.", ex );
		}
		finally {
			session.close( );
		}
		return result;
	}

	/**
	 * 결의서 삭제 / 법인카드 승인내역 정보 연동 취소
	 */
	public ResultVO updateG20DeleteCardList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		ResultVO result = new ResultVO( );
		connect( conVo );
		SqlSession session = this.connect( conVo ).getSqlSessionFactory( ).openSession( );
		try {
			session.update( "g20Procedure.updateG20DeleteCardList", params );
			result.setSuccess( );
			session.commit( );
		}
		catch ( Exception ex ) {
			result.setFail( "ERP DB연동 처리중 오류가 발생하였습니다.", ex );
		}
		finally {
			session.close( );
		}
		return result;
	}
}
