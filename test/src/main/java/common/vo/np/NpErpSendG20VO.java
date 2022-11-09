package common.vo.np;

import java.util.List;
import java.util.Map;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;


public class NpErpSendG20VO {

	private final List<Map<String, Object>> resDoc;
	private final List<Map<String, Object>> resHead;
	private final List<Map<String, Object>> resBudget;
	private final List<Map<String, Object>> resTrade;
	private final List<Map<String, Object>> resItemSpec;
	private int headIdx;
	private int budgetIdx;
	private int tradeIdx;
	private int itemSpecIdx;


	/**
	 * ERP iU 전송포멧에 맞게 준비
	 */
	public NpErpSendG20VO ( ResultVO resDoc, ResultVO resHead, ResultVO resBudget, ResultVO resTrade, ResultVO resItemSpec ) throws Exception {
		this.resDoc = resDoc.getAaData( );
		this.resHead = resHead.getAaData( );
		this.resBudget = resBudget.getAaData( );
		this.resTrade = resTrade.getAaData( );
		this.resItemSpec = resItemSpec.getAaData( );
		this.headIdx = -1;
		this.budgetIdx = -1;
		this.tradeIdx = -1;
		this.headIdx = -1;
		this.itemSpecIdx = -1;
		if ( CommonConvert.CommonGetStr(resDoc.getResultCode( )).equals( commonCode.FAIL ) ) {
			throw new Exception( resDoc.getResultName( ) );
		}
		if ( CommonConvert.CommonGetStr(resDoc.getResultCode( )).equals( commonCode.FAIL ) ) {
			throw new Exception( resDoc.getResultName( ) );
		}
		if ( CommonConvert.CommonGetStr(resBudget.getResultCode( )).equals( commonCode.FAIL ) ) {
			throw new Exception( resBudget.getResultName( ) );
		}
		if ( CommonConvert.CommonGetStr(resTrade.getResultCode( )).equals( commonCode.FAIL ) ) {
			throw new Exception( resTrade.getResultName( ) );
		}

		/* 헤더 정보 보정 진행 */
		advDataSetHead();
	}

	/**
	 * 	HEAD정보 보정 진행
	 */
	private void advDataSetHead(){
		if(this.resDoc.size( ) == 1){
			String docSeq = this.resDoc.get( 0 ).get( "docSeq" ).toString( );
			for(int i = 0;i < this.resHead.size( ); i++){
				this.resHead.get( i ).put( "docSeq", docSeq );
			}
		}
	}


	public void initIdx ( ) {
		this.headIdx = -1;
		this.budgetIdx = -1;
		this.tradeIdx = -1;
		this.itemSpecIdx = -1;
	}



	public Map<String, Object> getDoc ( ) throws Exception {
		return resDoc.get( 0 );
	}

	public Map<String, Object> getHead ( ) throws Exception {
		return resHead.get( this.headIdx );
	}

	public Map<String, Object> getBudget ( ) throws Exception {
		Map<String, Object> returnObj = resBudget.get( this.budgetIdx );
		/* 데이터 보정 */
		// returnObj.put( "budgetNote", returnObj.get( "note" ) );
		return returnObj;
	}

	public Map<String, Object> getTrade ( ) throws Exception {
		Map<String, Object> returnObj =resTrade.get( this.tradeIdx );
		/* 데이터 보정 */
		returnObj.put( "tradeNote", returnObj.get( "note" ) );
		return returnObj;
	}

	public Map<String, Object> getItemSpec ( ) throws Exception {
		Map<String, Object> returnObj =resItemSpec.get( this.itemSpecIdx );
		return returnObj;
	}

	public Map<String, Object> getNextHead123 ( ) throws Exception {
		//System.out.println( "CALL : public Map<String, Object> getNextHead ( ) throws Exception {" );
		//System.out.println( this.headIdx );
		this.headIdx =  this.headIdx + 1;

		if ( this.resHead.size( ) <= this.headIdx ) {
			return null;
		}
		else {
			return resHead.get( this.headIdx );
		}
	}

	public Map<String, Object> getNextBudget ( ) throws Exception {
		if ( (this.headIdx == -1) || (this.headIdx >= this.resHead.size( )) ) {
			throw new Exception( " header index boundery exception. " );
		}
		String usingHeadKey = this.resHead.get( this.headIdx ).get( "resSeq" ).toString( );
		int budgetNextIdx = (this.budgetIdx + 1);
		if ( this.resBudget.size( ) <= budgetNextIdx ) {
			return null;
		}
		else if ( CommonConvert.CommonGetStr(this.resBudget.get( budgetNextIdx ).get( "resSeq" )).equals( usingHeadKey ) ) {
			this.budgetIdx = budgetNextIdx;
			return this.resBudget.get( this.budgetIdx );
		}
		return null;
	}

	public Map<String, Object> getNextTrade ( ) throws Exception {
		if ( (this.headIdx == -1) || (this.headIdx >= this.resHead.size( )) ) {
			throw new Exception( " header index boundery exception. " );
		}
		if ( (this.budgetIdx == -1) || (this.budgetIdx >= this.resBudget.size( )) ) {
			throw new Exception( " budget index boundery exception. " );
		}
		String usingHeadKey = this.resHead.get( this.headIdx ).get( "resSeq" ).toString( );
		String usingBudgetKey = this.resBudget.get( this.budgetIdx ).get( "budgetSeq" ).toString( );
		int tradeNextIdx = (this.tradeIdx + 1);
		if ( this.resTrade.size( ) <= tradeNextIdx ) {
			return null;
		}
		else if ( CommonConvert.CommonGetStr(this.resTrade.get( tradeNextIdx ).get( "resSeq" )).equals( usingHeadKey ) && CommonConvert.CommonGetStr(this.resTrade.get( tradeNextIdx ).get( "budgetSeq" )).equals( usingBudgetKey ) ) {
			this.tradeIdx = tradeNextIdx;
			return this.resTrade.get( this.tradeIdx );
		}
		return null;
	}

	public Map<String, Object> getNextItemSpec ( ) throws Exception {
		if ( (this.headIdx == -1) || (this.headIdx >= this.resHead.size( )) ) {
			throw new Exception( " header index boundery exception. " );
		}
		String usingHeadKey = this.resHead.get( this.headIdx ).get( "resSeq" ).toString( );
		int itemSpecNextIdx = (this.itemSpecIdx + 1);
		if ( this.resItemSpec.size( ) <= itemSpecNextIdx ) {
			return null;
		}
		else if ( CommonConvert.CommonGetStr(this.resItemSpec.get( itemSpecNextIdx ).get( "resSeq" )).equals( usingHeadKey ) ) {
			this.itemSpecIdx = itemSpecNextIdx;
			return this.resItemSpec.get( this.itemSpecIdx );
		}
		return null;
	}
}
