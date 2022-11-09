<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

이 페이지는 비영리 회계모듈 기본 설정 확인 페이지 입니다.<br>
<br>
사용자 ERP 유형 : ${conVo.erpType}  / G20 여부 : ${conVo.g20Yn}<br> 
사용자 ERP 사번 : ${loginVo.empCode} <br>
<br>
<br>
* GW 설정 확인<br>
 <div class="type_div type A1" style="">
	 <table id="mainOptionsGw" >
		<colgroup>
			<col width="5%" />
			<col width="5%" />
			<col width="25%" />
			<col width="10%" />
			<col width="" />
		</colgroup>
	 </table>  
 </div>
<br>
<br>
 * ERP 설정 확인<br> 
 <div class="type_div type A1" style="">
	 <table id="mainOptionsErp" >
		<colgroup>
			<col width="5%" />
			<col width="5%" />
			<col width="25%" />
			<col width="10%" />
			<col width="" />
		</colgroup>
	 </table>  
 </div> 
 
 


<script>
	var optionMap = {};
	var optionSet = ${erp_optionSet} 
	for(var i=0; i< optionSet.length; i++){
		var item = optionSet[i];
		var tag = '';
		tag += '<tr>';
		tag += '	<td>';
		tag += '		' + item.MODULE_CD;
		tag += '	</td>';
		tag += '	<td>';
		tag += '		' + item.CTR_CD;
		tag += '	</td>';
		tag += '	<td>';
		tag += '		' + item.CTR_NM;
		tag += '	</td>';
		tag += '	<td>';
		tag += '		' + item.CTR_FG
		tag += '	</td>';
		tag += '	<td>';
		tag += '		' + item.SEL_DOC
		tag += '	</td>';			
		tag += '</tr>';
		$('#mainOptionsErp').append(tag);
		
		optionMap[item.MODULE_CD+'|'+item.CTR_CD] = {
				"MODULE_CD" : item.MODULE_CD
				, "CTR_CD" : item.CTR_CD
				, "CTR_NM" : item.CTR_NM 
				, "CTR_FG" : item.CTR_FG
				, "SEL_DOC" : item.SEL_DOC
		};
	}
	
	var optionMap2 = {};
	var optionSet2 = ${gw_optionSet};
	for(var i=0; i< optionSet2.length; i++){
		var item = optionSet2[i];
		var tag = '';
		tag += '<tr>';
		tag += '	<td>';
		tag += '		' + item.comp_seq;
		tag += '	</td>';
		tag += '	<td>';
		tag += '		' + item.form_seq;
		tag += '	</td>';
		tag += '	<td>';
		tag += '		' + item.option_gbn;
		tag += '	</td>';
		tag += '	<td>';
		tag += '		' + item.set_value;
		tag += '	</td>';
		tag += '	<td>';
		tag += '		' + item.set_name;
		tag += '	</td>';			
		tag += '</tr>';
		$('#mainOptionsGw').append(tag);
	}
</script>