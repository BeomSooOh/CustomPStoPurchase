<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

CustomLabelTestPage

<br><br>

CL.ex_account = ${CL.ex_account}  /  (jstl code : $ {CL.ex_account}) <br>
CL.ex_accountingCode = ${CL.ex_accountingCode}  /  (jstl code : $ {CL.ex_accountingCode}) <br>
CL.ex_accountingDate = ${CL.ex_accountingDate}  /  (jstl code : $ {CL.ex_accountingDate}) <br>

<br><br><br>
Controller Code : <br>
<br>		LoginVO loginVo = (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
<br>		String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
<br>		String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
<br>		CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode );
<br>		mv.addObject( "CL", vo.getData( ) );

	