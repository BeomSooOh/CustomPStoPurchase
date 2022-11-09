<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>


<script>
function custfnCheckDivCdInclue(erpBizplanSeq){
	console.log('Call customize function cust001.custfnCheckDivCdInclue');
	var returnCode = 'fail';
	var param = {
		erpCompSeq : optionSet.loginVo.erpCoCd
		, erpBizplanSeq : erpBizplanSeq
		, erpPcSeq : $('#lbErpDivName').attr('seq')
	}
    $.ajax({
        async: true,
        type: "post",
        data: param,
        url: "<c:url value='/expend/np/user/CUST001NpUserCheckDivCdInclude.do' />",
        datatype: "json",
        async : false,
        success: function (result) {
            if (result.result.resultCode != 'SUCCESS') {
                alert('서버 오류 발생');
                console.log(result.result.errorTrace);
            } else {
            	returnCode = result.result.aData.resultCode;
            }
        },
        error: function (err) {
            console.log(err);
        }
    });
    return returnCode;
}
</script>