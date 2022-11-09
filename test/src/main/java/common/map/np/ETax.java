package common.map.np;

public final class ETax {

	public final static class Map {
		public final class Admin {
			/**
			 * <pre>
			 * # 관리자 매입전자세금계산서 목록 조회
			 * # mybatis
			 *    - path : /egovframework/sqlmap/mssql/iCUBE/expend/np/admin
			 *    - xml : NpAdminETaxSQL.xml
			 *    - id : AdminETaxList
			 *    - parameterType : java.util.Map
			 *      >> erpCompSeq, issDateFrom, issDateTo, partnerName, eTaxStat, partnerRegNo, eTaxIssNo, approvalEmpName
			 *    - resultType : java.util.Map
			 * # iCUBE :
			 * # ERPiU :
			 * </pre>
			 */
			public static final String LIST = "AdminETaxList";
		}

		public final class User {
			/**
			 * <pre>
			 * # 사용자 매입전자세금계산서 목록 조회
			 * # mybatis
			 *    - path : /egovframework/sqlmap/mssql/iCUBE/expend/np/user
			 *    - xml : NpETaxSQL.xml
			 *    - id : UserETaxList
			 *    - parameterType : java.util.Map
			 *    - resultType : java.util.Map
			 * # iCUBE :
			 * # ERPiU :
			 * </pre>
			 */
			public static final String LIST = "UserETaxList";

			/**
			 * <pre>
			 * # 사용자 매입전자세금계산서 목록 조회
			 * # mybatis
			 *    - path : /egovframework/sqlmap/mssql/iCUBE/expend/np/user
			 *    - xml : NpETaxSQL.xml
			 *    - id : UserETaxList2
			 *    - parameterType : java.util.Map
			 *    - resultType : java.util.Map
			 * # iCUBE :
			 * # ERPiU :
			 * </pre>
			 */
			public static final String LIST2 = "UserETaxList2";

			/**
			 * <pre>
			 * # 사용자 매입전자세금계산서 작성 예정 목록 조회
			 * # mybatis
			 *    - path : /egovframework/sqlmap/mssql/iCUBE/expend/np/user
			 *    - xml : NpETaxSQL.xml
			 *    - id : UserETaxApprovalList
			 *    - parameterType : java.util.Map
			 *    - resultType : java.util.Map
			 * # iCUBE :
			 * # ERPiU :
			 * </pre>
			 */
			public static final String APPROVALLIST = "UserETaxApprovalList";
		}

		/**
		 * 매입전자세금계산서 (이관)수신 목록 조회 <br />
		 * - t_ex_etax_aq_tmp <br />
		 * - parameters : compSeq, empSeq, issDateFrom, issDateTo <br />
		 * - return : compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	TRANSLIST	= "NpUserReportA.ETaxTransList";

		/**
		 * 매입전자세금계산서 (이관)수신 목록 조회 <br />
		 * - t_ex_etax_aq_tmp <br />
		 * - parameters : compSeq, empSeq, issDateFrom, issDateTo <br />
		 * - return : compSeq, issNo, issDt, partnerNo, partnerName, transferSeq, transferName, receiveSeq, receiveName, supperKey <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	RECEIVELIST	= "NpUserReportA.ETaxReceiveList";

		/**
		 * 매입전자세금계산서 데이터 존재 여부 확인 <br />
		 * - t_ex_etax_aq_tmp <br />
		 * - parameters : issNo, issDt <br />
		 * - return : syncId, issNo, issDt, trRegNb, compSeq, sendYn, note, ifMId, ifDId, useYn, useYnEmpSeq <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	EXISTS		= "NpUserReportA.ETaxExists";

		/**
		 * 매입전자세금계산서 이관 데이터 존재 여부 확인 <br />
		 * - t_ex_etax_aq_tmp <br />
		 * - parameters : compSeq, issNo, issDt <br />
		 * - return : eTaxTransSeq, compSeq, issNo, issDt, trRegNb, trName, reqAmt, transferSeq, transferName, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	TRANSEXISTS	= "NpUserReportA.ETaxTransExists";

		/**
		 * 매입전자세금계산서 상신 데이터 존재 여부 확인 <br />
		 * - t_ex_etax_aq_tmp <br />
		 * - parameters : issNo, issDt <br />
		 * - return : syncId, issNo, issDt, trRegNb, compSeq, sendYn, note, ifMId, ifDId, useYn, useYnEmpSeq <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	SENDEXISTS	= "NpUserReportA.ETaxSendExists";

		/**
		 * 매입전자세금계산서 연동 데이터 생성 - t_ex_etax_aq_tmp <br />
		 * - parameters : issNo, issDt, trRegNb, compSeq, empSeq <br />
		 * - return : sync_id ( select last_insert_id() ) <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	INSERT		= "NpUserReportA.ETaxInsert";

		/**
		 * 매입전자세금계산서 연동 데이터 이관 처리 - t_ex_etax_aq_tmp <br />
		 * - parameters : compSeq, issNo, issDt, trRegNb, trName, reqAmt, empSeq, empName, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey, issNo, issDt <br />
		 * - return : etax_trans_seq ( select last_insert_id() ) <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	TRANSINSERT	= "NpUserReportA.ETaxTransInsert";

		/**
		 * 매입전자세금계산서 연동 데이터 미사용 처리 - t_ex_etax_aq_tmp <br />
		 * - parameters : issNo, issDt, empSeq <br />
		 * - return : sync_id ( select last_insert_id() ) <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	USEUPDATEN	= "NpUserReportA.ETaxUseUpdateN";

		/**
		 * 매입전자세금계산서 연동 데이터 사용 처리 - t_ex_etax_aq_tmp <br />
		 * - parameters : issNo, issDt, empSeq <br />
		 * - return : sync_id ( select last_insert_id() ) <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	USEUPDATEY	= "NpUserReportA.ETaxUseUpdateY";

		/**
		 * 매입전자세금계산서 연동 데이터 상신 취소 처리 - t_ex_etax_aq_tmp <br />
		 * - parameters : issNo, issDt, empSeq <br />
		 * - return : sync_id ( select last_insert_id() ) <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	SENDUPDATEN	= "NpUserReportA.ETaxSendUpdateN";

		/**
		 * 매입전자세금계산서 연동 데이터 상신 처리 - t_ex_etax_aq_tmp <br />
		 * - parameters : issNo, issDt, empSeq <br />
		 * - return : sync_id ( select last_insert_id() ) <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	SENDUPDATEY	= "NpUserReportA.ETaxSendUpdateY";

		/**
		 * 매입전자세금계산서 연동 데이터 상신 처리 - t_ex_etax_aq_tmp <br />
		 * - parameters : compSeq, issNo, issDt, trRegNb, trName, reqAmt, empSeq, empName, receiveEmpSeq, receiveEmpName, receiveEmpSuperKey, eTaxTransSeq, issNo, issDt <br />
		 * - return : <br />
		 * - NpAdminReportSQL.xml
		 */
		public static final String	TRANSUPDATE	= "NpUserReportA.ETaxTransUpdate";
	}
}