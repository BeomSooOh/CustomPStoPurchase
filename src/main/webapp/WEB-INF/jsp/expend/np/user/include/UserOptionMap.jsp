<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>


<script>

	/* [Map] declare javascipt hashmap prototype
	========================================*/
	Map = function () {
		this.map = new Object();
	};
	Map.prototype = {
		put: function (key, value) {
			this.map[key] = value;
		},
		get: function (key) {
			return this.map[key];
		},
		containsKey: function (key) {
			return key in this.map;
		},
		containsValue: function (value) {
			for (var prop in this.map) {
				if (this.map[prop] == value) return true;
			}
			return false;
		},
		isEmpty: function (key) {
			return (this.size() == 0);
		},
		clear: function () {
			for (var prop in this.map) {
				delete this.map[prop];
			}
		},
		remove: function (key) {
			delete this.map[key];
		},
		keys: function () {
			var keys = new Array();
			for (var prop in this.map) {
				keys.push(prop);
			}
			return keys;
		},
		values: function () {
			var values = new Array();
			for (var prop in this.map) {
				values.push(this.map[prop]);
			}
			return values;
		},
		size: function () {
			var count = 0;
			for (var prop in this.map) {
				count++;
			}
			return count;
		}
	};

		
	var optionSet = {};
	(function(){
		/* 로그인 VO정의 */
		<c:if test="${empty loginVo}">
		var OPTION_LOGINVO = 'EMPTY'
		</c:if>
		<c:if test="${not empty loginVo}">
		var OPTION_LOGINVO = ${loginVo}
		</c:if>
		if(OPTION_LOGINVO === 'EMPTY'){
			console.log(' !!!! [ERROR] not found LOGIN INFOMATION.');
			optionSet.loginVo = {};
		}else{
			optionSet.loginVo = OPTION_LOGINVO;
		}
		
		/* 커넥션 VO정의 */
		<c:if test="${empty conVo}">
		var OPTION_CONVO = 'EMPTY'
		</c:if>
		<c:if test="${not empty conVo}">
		var OPTION_CONVO = ${conVo}
		</c:if>
		if(OPTION_CONVO === 'EMPTY'){
			console.log(' !!!! [ERROR] not found CONNECTION INFOMATION.');
			optionSet.conVo = {};
		}else{
			optionSet.conVo = OPTION_CONVO;
		}
		
		/* erp option map 정의 */
		<c:if test="${empty erp_optionSet}">
		var OPTION_ERP = 'EMPTY'
		</c:if>
		<c:if test="${not empty erp_optionSet}">
		var OPTION_ERP = ${erp_optionSet}
		</c:if>		
		if(OPTION_ERP === 'EMPTY'){
			console.log(' !!!! [ERROR] not found ERP INFOMATION.');
			optionSet.erp = {};
		}else{
			var erpMap = {};
			
			if(OPTION_CONVO.erpTypeCode === 'ERPiU'){
				for(var i=0; i < OPTION_ERP.length ; i++){
					var item = OPTION_ERP[i];
					if( !(erpMap[item.TP_ENV]) ){
						erpMap[item.TP_ENV] = {};
					}
					erpMap[item.TP_ENV] = item;
				}
				erpMap['TP_BUDGETMNG'] = erpMap['TP_BUDGETMNG'] || {'CD_ENV':'1'};
			} else {
				for(var i=0; i < OPTION_ERP.length ; i++){
					var item = OPTION_ERP[i];
					if( !(erpMap[item.MODULE_CD]) ){
						erpMap[item.MODULE_CD] = {};
					}
					erpMap[item.MODULE_CD][item.CTR_CD] = item;
				}
			}
			optionSet.erp = erpMap;
		}
		
		/* gw option map 정의 */
		<c:if test="${empty gw_optionSet}">
		var OPTION_GW = 'EMPTY'
		</c:if>
		<c:if test="${not empty gw_optionSet}">
		var OPTION_GW = ${gw_optionSet}
		</c:if>
		if(OPTION_GW === 'EMPTY'){
			console.log(' !!!! [ERROR] not found GW INFOMATION.');
			optionSet.gw = {};
		}else{
			var gwMap = {};
			for(var i=0; i < OPTION_GW.length ; i++){
				var item = OPTION_GW[i];
				if( !(gwMap[item.optionGbn]) ){
					gwMap[item.optionGbn] = {};
				}
				gwMap[item.optionGbn][item.optionCode] = item;
			}
			optionSet.gw = gwMap;
		}
		
		/* gw cust option map 정의 */
		<c:if test="${empty gw_customOptionSet}">
		var CUSTOM_OPTION_GW = 'EMPTY'
		</c:if>
		<c:if test="${not empty gw_customOptionSet}">
		var CUSTOM_OPTION_GW = ${gw_customOptionSet}
		</c:if>
		if(CUSTOM_OPTION_GW === 'EMPTY'){
			console.log(' !!!! [ERROR] not found CUSTOM GW INFOMATION.');
			optionSet.customOption = {};
		}else{
			var gwCustomMap = {};
			if(CUSTOM_OPTION_GW.commonCode){
				console.log(' !!!! [INFO] use CUSTOM OPTION.');
				var customs = CUSTOM_OPTION_GW.commonCode.split('|');
				for(var i = 0; i < customs.length; i++){
					var item = customs[i];
					if(item.indexOf('EXNP_CUST_') > -1){
						gwCustomMap[item.replace('EXNP_', '')] = true;
					}
				}
				optionSet.customOption = gwCustomMap;
			}else{
				optionSet.customOption = {};
				console.log(' !!!! [INFO] not use CUSTOM OPTION.');
			}
		}
		
		/* erp base data map 정의 */
		<c:if test="${empty erpBaseInfo}">
		var ERP_BASE_INFO = 'EMPTY'
		</c:if>
		<c:if test="${not empty erpBaseInfo}">
		var ERP_BASE_INFO = ${erpBaseInfo}
		</c:if>
		if(ERP_BASE_INFO === 'EMPTY'){
			console.log(' !!!! [ERROR] not found ERP BASE DATA..');
			optionSet.erpEmpInfo = {};
		}else{
			optionSet.erpEmpInfo = ERP_BASE_INFO[0];
		}
		
		/* ea, eap base data map 정의 */
		<c:if test="${empty eaBaseInfo}">
		var EA_BASE_INFO = 'EMPTY'
		</c:if>
		<c:if test="${not empty eaBaseInfo}">
		var EA_BASE_INFO = ${eaBaseInfo}
		</c:if>		
		if(ERP_BASE_INFO === 'EMPTY'){
			console.log(' !!!! [ERROR] not found EA BASE DATA..');
			optionSet.formInfo = {};
		}else{
			optionSet.formInfo = EA_BASE_INFO[0];
		}
		
		<c:if test="${empty erpGisu}">
		var ERP_GISU = 'EMPTY'
		</c:if>
		<c:if test="${not empty erpGisu}">
		var ERP_GISU = ${erpGisu}
		</c:if>		
		if(ERP_GISU === 'EMPTY'){
			console.log(' !!!! [ERROR] not found ERP GISU DATA..');
			optionSet.erpGisu = {};
		}else{
			optionSet.erpGisu = ERP_GISU[0];
		}
		
		<c:if test="${empty erpAbsDocu}">
		var ERP_ABSDOCU = 'EMPTY'
		</c:if>
		<c:if test="${not empty erpAbsDocu}">
		var ERP_ABSDOCU = ${erpAbsDocu}
		</c:if>
		if(ERP_ABSDOCU === 'EMPTY'){
			console.log(' !!!! [ERROR] not found ERP GISU DATA..');
			optionSet.erpAbsdocu = {};
		}else{
			optionSet.erpAbsdocu = ERP_ABSDOCU[0];
		}
	})();

</script>





