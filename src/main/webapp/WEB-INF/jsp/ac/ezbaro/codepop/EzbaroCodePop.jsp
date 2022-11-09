<%@ page language="java" contentType="text/html; charset=utf-8" import="main.web.BizboxAMessage" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript"
	src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>


<script type="text/javascript">

/* ------------------------------------------------------------- */
/* 변수정의 */
/* ------------------------------------------------------------- */
var clickCount = 0;
var codeParam = {};
var type = '${type}';
var bindId = '${bindId}';

/* ------------------------------------------------------------- */
/* 문서로드 */
/* ------------------------------------------------------------- */
$(document).ready(function() {

	if (type == '' || type == 'undefeind') {
		alert("<%=BizboxAMessage.getMessage("TX000002383","잘못된 접근입니다")%>");
		return;
	}
	console.log(type);
	switch (type) {
	case "ProJect": //연구과제
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.PRJNO = '${PRJNO}';
		break;
	case "Details": //세목
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.OFCODE = '${OFCODE}';
		codeParam.BIZGRP = '${BIZGRP}';
		break;
	case "Use": //사용용도
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.CODIV = '${CODIV}';
		codeParam.OFCODE = '${OFCODE}';
		codeParam.BIZGRP = '${BIZGRP}';
		codeParam.BMCODE = '${BMCODE}';
		break;
	case "G20BgSubj": //G20예산과목

		break;
	case "ExecMethod": //집행방법
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.CODIV = '${CODIV}';
		codeParam.OFCODE = '${OFCODE}';
		break;
	case "ExecReqGb": //집행요청구분
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.CODIV = '${CODIV}';
		codeParam.OFCODE = '${OFCODE}';
		break;
	case "G20Partner"://g20거래처
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.P_HELP_TY = '${P_HELP_TY}';
		codeParam.P_CO_CD = '${P_CO_CD}';
		codeParam.P_CODE = '${P_CODE}';
		codeParam.P_CODE2 = '${P_CODE2}';
		codeParam.P_CODE3 = '${P_CODE3}';
		codeParam.P_USE_YN = '${P_USE_YN}';
		codeParam.P_NAME = '${P_NAME}';
		codeParam.P_STD_DT = '${P_STD_DT}';
		codeParam.P_WHERE = '${P_WHERE}';
		break;
	case "CardNum"://카드번호
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.OFCODE = '${OFCODE}';
		codeParam.PRJNO = '${PRJNO}';
		break;
	case "Entrant"://출장자
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.RESPERSONNO = '${RESPERSONNO}';
		break;
	case "BankName"://지급은행 
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.CODIV = '${CODIV}';
		codeParam.OFCODE = '${OFCODE}';
		break;
	case "Researcher":
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.RESPERSONNO = '${RESPERSONNO}';
		break;
	case "GoodsGb"://물품구분
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.CODIV = '${CODIV}';
		codeParam.OFCODE = '${OFCODE}';
		break;
	case "InOutGb"://시내외구분
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.CODIV = '${CODIV}';
		codeParam.OFCODE = '${OFCODE}';
		break;
	case "SosokGb"://소속구분
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.CODIV = '${CODIV}';
		codeParam.OFCODE = '${OFCODE}';
		break;
	case "PeopleRegNum"://연구자등록번호
		break;
	case "UseMethod"://활용방법
		codeParam.LANGKIND = '${LANGKIND}';
		codeParam.CO_CD = '${CO_CD}';
		codeParam.CODIV = '${CODIV}';
		codeParam.OFCODE = '${OFCODE}';
		break;
	}
	//데이터 조회
	fnEzCodeSearch();
	
	
	//검색이벤트 바인딩
	fnSetSearchConfig();
	
	//검색 이벤트 지정
	// $('#txtEzCodeSearchStr').click(function() {
		
	// });
	
	/* $('#txtEzCodeSearchStr').bind('keydown', function (){
		console.log($(this).val());
		$('#tblEzCodeList_filter').find('input').val($(this).val());
		$('#tblEzCodeList_filter').find('input').trigger('keyup');
	}); */
	
	$('#txtEzCodeSearchStr').keyup(function(event){

			$('#tblEzCodeList_filter').find('input').val($('#txtEzCodeSearchStr').val());
			$('#tblEzCodeList_filter').find('input').trigger('keyup');
	});
	
	/* $('#txtEzCodeSearchStr').keypress(function (){
		alert(1);
		console.log($(this).val());
		$('#tblEzCodeList_filter').find('input').val($(this).val());
		$('#tblEzCodeList_filter').find('input').trigger('keypress');
	}); */
	
	$('#txtEzCodeSearchStr').focus();
	
});



	/* 	[최상배 생성] / 콜백 파라미터 리턴
	-----------------------------------------------------------------*/
	function fnGetParamMap() {

		console.log('fnGetParamMap호출');
		codeParam.searchStr = ($("txtEzCodeSearchStr").val() || '');
		codeParam.type = type;
		codeParam.LANGKIND = VarManager.g_EzPopupParam.LANGKIND || '';
		codeParam.P_CO_CD = codeParam.P_CO_CD || VarManager.g_EzPopupParam.CO_CD;
		codeParam.CDDIV = codeParam.CDDIV || "A07";
		codeParam.P_CODE = codeParam.P_CODE || VarManager.g_EzPopupParam.P_CODE;
		codeParam.P_CODE2 = codeParam.P_CODE2 || VarManager.g_EzPopupParam.P_CODE2;
		codeParam.P_CODE3 = codeParam.P_CODE3 || VarManager.g_EzPopupParam.P_CODE3;
		codeParam.P_NAME = codeParam.P_NAME || VarManager.g_EzPopupParam.P_NAME;
		codeParam.P_STD_DT = codeParam.P_STD_DT || VarManager.g_EzPopupParam.P_STD_DT;
		codeParam.P_WHERE = codeParam.P_WHERE || VarManager.g_EzPopupParam.P_WHERE;

		// 테스트 파라미터 - 삭제 대기
		//codeParam.RESPERSONNO = '10053584';

		
		
		console.log('*** Call Popup, run fnGetParamMap - paramater is');
		console.log(JSON.stringify(codeParam));
		return codeParam;
	}

	/* ------------------------------------------------------------- */
	/* parameter */
	/* ------------------------------------------------------------- */

	var dataType = {
		/* 연구과제 */
		"ProJect" : {
			"source" : "",
			"result" : [ {
				"key" : "CO_CD"
			}, {
				"key" : "PJT_CD"
			}, {
				"key" : "OFCODE"
			}, {
				"key" : "PRJNO",
				"result" : "code"
			}, {
				"key" : "INSERT_ID"
			}, {
				"key" : "INSERT_DT"
			}, {
				"key" : "INSERT_IP"
			}, {
				"key" : "MODIFY_ID"
			}, {
				"key" : "MODIFY_DT"
			}, {
				"key" : "MODIFY_IP"
			}, {
				"key" : "PRJNAME",
				"result" : "name"
			}, {
				"key" : "PJT_NM"
			}, {
				"key" : "BIZGRP"
			} ]
		},
		/* 세목 */
		"Details" : {
			"source" : "",
			"result" : [ {
				"key" : "CO_CD"
			}, {
				"key" : "BM_CD"
			}, {
				"key" : "BM_FG"
			}, {
				"key" : "INSERT_IP"
			}, {
				"key" : "BMCODE",
				"result" : "code"
			}, {
				"key" : "BM_NM"
			}, {
				"key" : "BMNAME",
				"result" : "name"
			}, {
				"key" : "INSERT_DT"
			}, {
				"key" : "OFCODE"
			}, {
				"key" : "BIZGRP"
			}, {
				"key" : "INSERT_ID"
			} ]
		},
		/* 세목 */
		"Use" : {
			"source" : "",
			"result" : [ {
				"key" : "CODDIV"
			}, {
				"key" : "CODE",
				"result" : "code"
			}, {
				"key" : "OFCODE"
			}, {
				"key" : "CDNM",
				"result" : "name"
			} ]
		},
		/* 집행방법 */
		"ExecMethod" : {
			"source" : "",
			"result" : [ {
				"key" : "CODDIV"
			}, {
				"key" : "CODE",
				"result" : "code"
			}, {
				"key" : "OFCODE"
			}, {
				"key" : "CDNM",
				"result" : "name"
			} ]
		},
		/* 집행요청구분 */
		"ExecReqGb" : {
			"source" : "",
			"result" : [ {
				"key" : "CODDIV"
			}, {
				"key" : "CODE",
				"result" : "code"
			}, {
				"key" : "OFCODE"
			}, {
				"key" : "CDNM",
				"result" : "name"
			} ]
		},
		/* 연구자 */
		"Researcher" : {
			"source" : "",
			"result" : [ {
				"key" : "BELONG"
			}, {
				"key" : "MOBILE"
			}, {
				"key" : "EMP_PER_CD"
			}, {
				"key" : "NM",
				"result" : "name"
			}, {
				"key" : "EMP_PER_NM"
			}, {
				"key" : "LAWBIRTH"
			}, {
				"key" : "EMAIL"
			}, {
				"key" : "RESSEX"
			}, {
				"key" : "EMP_FG"
			}, {
				"key" : "RESPERSONNO",
				"result" : "code"
			} ]
		}
		/* G20거래처 */
		,
		"G20Partner" : {
			"source" : "",
			"result" : [ {
				"key" : "INTER_RT"
			}, {
				"key" : "TR_NMK"
			}, {
				"key" : "TR_NM",
				"result" : "name"
			}, {
				"key" : "TR_FG"
			}, {
				"key" : "REG_NB"
			}, {
				"key" : "ATTR_NM"
			}, {
				"key" : "LIQ_RS"
			}, {
				"key" : "JEONJA_YN"
			}, {
				"key" : "CEO_NM"
			}, {
				"key" : "BA_NB"
			}, {
				"key" : "TR_CD",
				"result" : "code"
			}, {
				"key" : "TR_FG_NM"
			} ]
		}
		/* 지급은행 */
		,
		"BankName" : {
			"source" : "",
			"result" : [ {
				"key" : "OFCODE"
			}, {
				"key" : "CDDIV"
			}, {
				"key" : "CDNM",
				"result" : "name"
			}, {
				"key" : "CODE",
				"result" : "code"
			} ]
		}
		/* 출장자 */
		,
		"Entrant" : {
			"source" : "",
			"result" : [ {
				"key" : "BELONG"
			}, {
				"key" : "MOBILE"
			}, {
				"key" : "EMP_PER_CD"
			}, {
				"key" : "POSI"
			}, {
				"key" : "NM",
				"result" : "name"
			}, {
				"key" : "EMP_PER_NM"
			}, {
				"key" : "LAWBIRTH"
			}, {
				"key" : "EMAIL"
			}, {
				"key" : "RESSEX"
			}, {
				"key" : "EMP_FG"
			}, {
				"key" : "RESPERSONNO",
				"result" : "code"
			} ]
		}
		/* 물품구분 */
		,
		"GoodsGb" : {
			"source" : "",
			"result" : [ {
				"key" : "OFCODE"
			}, {
				"key" : "CDDIV"
			}, {
				"key" : "CDNM",
				"result" : "name"
			}, {
				"key" : "CODE",
				"result" : "code"
			} ]
		}
		/* 시내외구분 */
		,
		"InOutGb" : {
			"source" : "",
			"result" : [ {
				"key" : "OFCODE"
			}, {
				"key" : "CDDIV"
			}, {
				"key" : "CDNM",
				"result" : "name"
			}, {
				"key" : "CODE",
				"result" : "code"
			} ]
		}
		/* 소속구분 */
		,
		"SosokGb" : {
			"source" : "",
			"result" : [ {
				"key" : "OFCODE"
			}, {
				"key" : "CDDIV"
			}, {
				"key" : "CDNM",
				"result" : "name"
			}, {
				"key" : "CODE",
				"result" : "code"
			} ]
		}
		/* 연구자등록번호 */
		,
		"PeopleRegNum" : {
			"source" : "",
			"result" : [ {
				"key" : "BELONG"
			}, {
				"key" : "MOBILE"
			}, {
				"key" : "EMP_PER_CD"
			}, {
				"key" : "POSI"
			}, {
				"key" : "NM",
				"result" : "name"
			}, {
				"key" : "EMP_PER_NM"
			}, {
				"key" : "LAWBIRTH"
			}, {
				"key" : "EMAIL"
			}, {
				"key" : "RESSEX"
			}, {
				"key" : "EMP_FG"
			}, {
				"key" : "RESPERSONNO",
				"result" : "code"
			} ]
		}
		/* 성명 */
		,
		"Name" : {
			"source" : "",
			"result" : [ {
				"key" : "BELONG"
			}, {
				"key" : "MOBILE"
			}, {
				"key" : "EMP_PER_CD"
			}, {
				"key" : "POSI"
			}, {
				"key" : "NM",
				"result" : "name"
			}, {
				"key" : "EMP_PER_NM"
			}, {
				"key" : "LAWBIRTH"
			}, {
				"key" : "EMAIL"
			}, {
				"key" : "RESSEX"
			}, {
				"key" : "EMP_FG"
			}, {
				"key" : "RESPERSONNO",
				"result" : "code"
			} ]
		}
		/* 카드번호 */
		,
		"CardNum" : {
			"source" : "",
			"result" : [ {
				"key" : "OFCODE",
				"result" : "code"
			}, {
				"key" : "PRJNO"
			}, {
				"key" : "CARDNO",
				"result" : "name"
			}, {
				"key" : "FRCVDATE"
			}, {
				"key" : "RCVDATE"
			}, {
				"key" : "RCVTIME"
			}, {
				"key" : "CARDGB"
			}, {
				"key" : "CARDGB_NM"
			}, {
				"key" : "TRSEQ"
			}, {
				"key" : "TRDATE"
			}, {
				"key" : "MCHT_NM"
			}, {
				"key" : "APPRNO"
			}, {
				"key" : "DEMCOST"
			}, {
				"key" : "EXTTAX"
			} ]
		}
		/* 활용방법 */
		,
		"UseMethod" : {
			"source" : "",
			"result" : [ {
				"key" : "OFCODE"
			}, {
				"key" : "CDDIV"
			}, {
				"key" : "CDNM",
				"result" : "name"
			}, {
				"key" : "CODE",
				"result" : "code"
			} ]
		}

	};

	var EzCodeGridSet = {
		"ProJect" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009966","연구과제")%><%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "PRJNO",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009966","연구과제")%><%=BizboxAMessage.getMessage("TX000000152","명칭")%>",
				"mDataProp" : "PRJNAME",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"Details" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009965","세목")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "BMCODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009965","세목")%> <%=BizboxAMessage.getMessage("TX000000152","명칭")%>",
				"mDataProp" : "BMNAME",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"Use" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009964","사용용도")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "CODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009964","사용용도")%> <%=BizboxAMessage.getMessage("TX000000152","명칭")%>",
				"mDataProp" : "CDNM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"ExecMethod" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009963","집행방법")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "CODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009963","집행방법")%> <%=BizboxAMessage.getMessage("TX000000152","명칭")%>",
				"mDataProp" : "CDNM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"ExecReqGb" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009962","집행요청구분")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "CODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009962","집행요청구분")%> <%=BizboxAMessage.getMessage("TX000000152","명칭")%>",
				"mDataProp" : "CDNM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"Researcher" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009960","연구자")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "RESPERSONNO",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009960","연구자")%><%=BizboxAMessage.getMessage("TX000000152","명칭")%>",
				"mDataProp" : "NM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"G20Partner" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000000520","거래처")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "TR_CD",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000000520","거래처")%>",
				"mDataProp" : "TR_NM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"BankName" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009664","은행")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "CODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009959","지급은행")%>",
				"mDataProp" : "CDNM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"Entrant" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009960","연구자")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "RESPERSONNO",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009960","연구자")%> <%=BizboxAMessage.getMessage("TX000000152","명칭")%>",
				"mDataProp" : "NM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"GoodsGb" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000002726","물품")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "CODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000002726","물품")%> <%=BizboxAMessage.getMessage("TX000000214","구분")%>",
				"mDataProp" : "CDNM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"InOutGb" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000000214","구분")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "CODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009943","시내외구분")%>",
				"mDataProp" : "CDNM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"SosokGb" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000000214","구분")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "CODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000006534","소속구분")%>",
				"mDataProp" : "CDNM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"PeopleRegNum" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009960","연구자")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "RESPERSONNO",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009960","연구자")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "NM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"Name" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009960","연구자")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "RESPERSONNO",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009960","연구자")%> <%=BizboxAMessage.getMessage("TX000000641","코드")%>",
				"mDataProp" : "NM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"CardNum" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000005378","카드코드")%>",
				"mDataProp" : "OFCODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000004699","카드번호")%>",
				"mDataProp" : "CARDNO",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		},
		"UseMethod" : {
			"columnDefs" : [],
			"aoColumns" : [ {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000016469","활용코드")%>",
				"mDataProp" : "CODE",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "30%"
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000009937","활용방법")%>",
				"mDataProp" : "CDNM",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "70%",
				"sClass" : "td_le"
			} ]
		}

	};

	
	
	/* ------------------------------------------------------------- */
	/* 검색어 설정 */
	/* ------------------------------------------------------------- */
	function fnSetSearchConfig()
	{
		$('#txtEzCodeSearchStr')
	}

	/* ------------------------------------------------------------- */
	/* 데이터 조회 */
	/* ------------------------------------------------------------- */
	function fnEzCodeSearch() {

		$.ajax({
			async : true,
			type : "post",
			data : fnGetParamMap(),
			url : "<c:url value='/expend/ezbaro/EzbaroCodeSearch.do' />",
			datatype : "json",
			success : function(result) {
				// TO DO : 거래처[사용자/업체] 담당 구분 예외처리 추가 적으로 코드 정리 필요함/
				result = fnGetExptResult(result);
				//console.log('서버 콜백  : ' + JSON.stringify(result.aaData));
				fnEzCodeInitGrid(result.aaData);
			},
			error : function(err) {
				alert("<%=BizboxAMessage.getMessage("TX000009970","데이터 조회 중 오류가 발생하였습니다")%>");
				console.log(err);
			}
		});

	}

	/*	[예외처리] 콜백 다중화를 위한 예외처리 루틴 시작
	-----------------------------------------------*/
	function fnGetExptResult(data) {
		if ('${type}' === 'G20Partner'
				&& (data.aaData.length && data.aaData[0].EMP_CD)) {
			var length = data.aaData.length;
			var returnData = {};
			returnData.aaData = [];
			for (var i = 0; i < length; i++) {
				var item = data.aaData[i];
				returnData.aaData.push({
					"INTER_RT" : '',
					"TR_NMK" : item.FOR_NMK || '',
					"TR_NM" : item.KOR_NM || '',
					"TR_FG" : '',
					"REG_NB" : '',
					"ATTR_NM" : item.KOR_NM || '',
					"LIQ_RS" : '',
					"JEONJA_YN" : item.REFR_YN || '',
					"CEO_NM" : item.KOR_NM || '',
					"BA_NB" : '',
					"TR_CD" : item.EMP_CD || '',
					"TR_FG_NM" : item.FOR_NMK || ''
				});
			}
			data = returnData;
		}
		return data;
	}

	/* ------------------------------------------------------------- */
	/* 그리드 정의 */
	/* ------------------------------------------------------------- */
	/* 그리드 정의 */
	function fnEzCodeInitGrid(param) {
		// console.log('fnEzCodeInitGrid');
		var columnDefs = [];
		var aoColumns = [];

		try {
			if (typeof EzCodeGridSet['${type}']['columnDefs'] != 'undefined') {
				columnDefs = EzCodeGridSet['${type}']['columnDefs'] || [];
			}

			if (typeof EzCodeGridSet['${type}']['aoColumns'] != 'undefined') {
				aoColumns = EzCodeGridSet['${type}']['aoColumns'] || [];
			}
		} catch (data) {
			alert("<%=BizboxAMessage.getMessage("TX000009970","데이터 조회 중 오류가 발생하였습니다")%>");
			return;
		}

		$("#tblEzCodeList").dataTable(
				{
					"fixedHeader" : true,
					"select" : true,
					"lengthMenu" : [ [ 6, 15, -1 ], [ 6, 15, "All" ] ],
					"sScrollY" : 223,
					"bAutoWidth" : false,
					"destroy" : true,
					"language" : {
						"lengthMenu" : "보기 _MENU_",
						"zeroRecords" : "<%=BizboxAMessage.getMessage("TX000001063","데이터가 없습니다.")%>",
						"info" : "_PAGE_ / _PAGES_",
						"infoEmpty" : "<%=BizboxAMessage.getMessage("TX000001063","데이터가 없습니다.")%>",
						"infoFiltered" : "(전체 _MAX_ 중.)"
					},
					"data" : param,
					"fnRowCallback" : function(nRow, aData, iDisplayIndex,
							iDisplayIndexFull) {
						$(nRow).css("cursor", "pointer");
						$(nRow).on('click', (function() {
							clickCount++;
							/* 클릭과, 더블블릭을 별도 인식하기 위해서, 시간차를 두었음. 별도 인식 이유는 ajax 호출로 인하여 로딩이 표현되므로 더블클릭 이벤트가 발생되지 않는 문제점이 있음. */
							if (clickCount === 1) {
								singleClickTimer = setTimeout(function() {
									clickCount = 0;
									fnEzCodeInitGridClick(aData);
								}, 400);
							} else if (clickCount === 2) {
								clearTimeout(singleClickTimer);
								clickCount = 0;
								fnEzCodeInitGridDblClick(aData);
							}

							return;
						}));

						return nRow;
					},
					"columnDefs" : columnDefs,
					"aoColumns" : aoColumns
				});

		return;
	}
	/* 그리드 정의 - 행 클릭 */
	function fnEzCodeInitGridClick(param) {
		// console.log('fnEzCodeInitGridClick');

		var result = {};

		$.each(dataType['${type}']['result'], function(idx, item) {
			if (typeof param[item.key] != 'undefined') {
				if (typeof item.result != 'undefined') {
					result[item.result] = (param[item.key] || '');
					result[item.key] = (param[item.key] || '');
				} else {
					result[item.key] = (param[item.key] || '');
				}
			} else {
				result[item.key] = '';
			}
		});
		console.log(result);
		fnEzCodeCallback(result);

		return;
	}
	/* 그리드 정의 - 행 더블클릭 */
	function fnEzCodeInitGridDblClick(param) {
		// console.log('fnEzCodeInitGridDblClick');

		var result = {};

		$.each(dataType['${type}']['result'], function(idx, item) {
			if (typeof param[item.key] != 'undefined') {
				if (typeof item.result != 'undefined') {
					result[item.result] = (param[item.key] || '');
					result[item.key] = (param[item.key] || '');
				} else {
					result[item.key] = (param[item.key] || '');
				}
			} else {
				result[item.key] = '';
			}
		});
		console.log(result);
		fnEzCodeCallback(result);

		return;
	}

	/* ------------------------------------------------------------- */
	/* 함수 */
	/* ------------------------------------------------------------- */

	/* 반영 */
	function fnEzCodeSelect() {
		// console.log('fnEzCodeSelect');
		return;
	}
	/* 닫기 */
	function fnEzCodeClose() {
		// console.log('fnEzCodeClose');
		return;
	}

	/* 콜백 */
	function fnEzCodeCallback(param) {
		console.log('${callback}');
		param.bindId = (bindId || '');
		param.type = (type || '');

		if ('${callback}' != '') {
			if (window['${callback}']) {
				window['${callback}'](param);
			} else {
				return;
			}
		} else {
			return;
		}
	}
</script>


<div class="pop_wrap_dir" id="layerCommonCode" style="width: 458px;">
	<div class="pop_con" style="height: 367px;">
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000000399","검색어")%></dt>
				<dd style="width: 152px;">
					<input id="txtEzCodeSearchStr" type="text"
						style="width: 120px; text-indent: 8px;" /> <span
						class="dod_search mr26"><a href="#" class="btn_sear"
						id="btnEzCodeSearch"></a></span>
				</dd>
			</dl>
		</div>
		<div class="com_ta4 mt20 " style="">
			<table id="tblEzCodeList">
			</table>
		</div>
	</div>
	<!--// pop_con -->
</div>
<!--// pop_wrap -->