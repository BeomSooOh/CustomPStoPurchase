package common.helper.exception;

import java.util.Map;

import common.vo.ex.ExErpSendiCUBEVO;
import common.vo.ex.ExErpSendiUVO;

@SuppressWarnings ( "serial" )
public class ErpSendFailException extends Exception {

	private final Map<String, Object> map;
	public ErpSendFailException(ExErpSendiCUBEVO.aData data){
		super( "ERP iCUBE 자동 전표 생성 실패" );
		this.map = data.getMap( );
	}
	public ErpSendFailException(ExErpSendiUVO.aData data){
		super( "ERP iU 자동 전표 생성 실패" );
		this.map = data.getMap( );
	}

	public Map<String, Object> getMap(){
		return this.map;
	}
}
