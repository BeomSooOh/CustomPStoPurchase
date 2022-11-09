<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="main.web.BizboxAMessage"%>

<script type="text/javascript">
	var targetTbl = "tblOptionGbn";
	var options = {
		"optionItemsSet": [ {
			"optionName": "[레이아웃] 지출결의 표시범위 설정",
			"commonCode": "ex00005",
			"detailCode": "L",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "LSM",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001001",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "항목",
			"name": "지출결의 레이아웃",
			"setEmpValue": null,
			"baseName": "항목 + 분개 + 관리항목",
			"baseValue": "LSM",
			"setName": "항목 + 분개 + 관리항목"
		}, {
			"optionName": "[레이아웃] 지출결의 표시범위 설정",
			"commonCode": "ex00005",
			"detailCode": "LS",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "LSM",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001001",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "항목 + 분개",
			"name": "지출결의 레이아웃",
			"setEmpValue": null,
			"baseName": "항목 + 분개 + 관리항목",
			"baseValue": "LSM",
			"setName": "항목 + 분개 + 관리항목"
		}, {
			"optionName": "[레이아웃] 지출결의 표시범위 설정",
			"commonCode": "ex00005",
			"detailCode": "LSM",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "LSM",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001001",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "항목 + 분개 + 관리항목",
			"name": "지출결의 레이아웃",
			"setEmpValue": null,
			"baseName": "항목 + 분개 + 관리항목",
			"baseValue": "LSM",
			"setName": "항목 + 분개 + 관리항목"
		}, {
			"optionName": "[레이아웃] 지출결의 표시범위 설정",
			"commonCode": "ex00005",
			"detailCode": "S",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "LSM",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001001",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "분개",
			"name": "지출결의 레이아웃",
			"setEmpValue": null,
			"baseName": "항목 + 분개 + 관리항목",
			"baseValue": "LSM",
			"setName": "항목 + 분개 + 관리항목"
		}, {
			"optionName": "[레이아웃] 지출결의 표시범위 설정",
			"commonCode": "ex00005",
			"detailCode": "SM",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "LSM",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001001",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "분개 + 관리항목",
			"name": "지출결의 레이아웃",
			"setEmpValue": null,
			"baseName": "항목 + 분개 + 관리항목",
			"baseValue": "LSM",
			"setName": "항목 + 분개 + 관리항목"
		}, {
			"optionName": "[레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 )",
			"commonCode": "ex00006",
			"detailCode": "E",
			"orderNum": 2,
			"optionSelectType": "COMBOBOX",
			"setValue": "E",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001002",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "문서",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "문서",
			"baseValue": "E",
			"setName": "문서"
		}, {
			"optionName": "[레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 )",
			"commonCode": "ex00006",
			"detailCode": "L",
			"orderNum": 2,
			"optionSelectType": "COMBOBOX",
			"setValue": "E",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001002",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "항목",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "문서",
			"baseValue": "E",
			"setName": "문서"
		}, {
			"optionName": "[레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 )",
			"commonCode": "ex00006",
			"detailCode": "S",
			"orderNum": 2,
			"optionSelectType": "COMBOBOX",
			"setValue": "E",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001002",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "분개",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "문서",
			"baseValue": "E",
			"setName": "문서"
		}, {
			"optionName": "[레이아웃] 예산정보 입력 설정 ( 예산단위, 사업계획, 예산계정 )",
			"commonCode": "ex00006",
			"detailCode": "E",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001003",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "문서",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 예산정보 입력 설정 ( 예산단위, 사업계획, 예산계정 )",
			"commonCode": "ex00006",
			"detailCode": "L",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001003",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "항목",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 예산정보 입력 설정 ( 예산단위, 사업계획, 예산계정 )",
			"commonCode": "ex00006",
			"detailCode": "S",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001003",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "분개",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 프로젝트정보 입력 설정",
			"commonCode": "ex00006",
			"detailCode": "E",
			"orderNum": 4,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001004",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "문서",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 프로젝트정보 입력 설정",
			"commonCode": "ex00006",
			"detailCode": "L",
			"orderNum": 4,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001004",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "항목",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 프로젝트정보 입력 설정",
			"commonCode": "ex00006",
			"detailCode": "S",
			"orderNum": 4,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001004",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "분개",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 거래처정보 입력 설정",
			"commonCode": "ex00006",
			"detailCode": "E",
			"orderNum": 5,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001005",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "문서",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 거래처정보 입력 설정",
			"commonCode": "ex00006",
			"detailCode": "L",
			"orderNum": 5,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001005",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "항목",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 거래처정보 입력 설정",
			"commonCode": "ex00006",
			"detailCode": "S",
			"orderNum": 5,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001005",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "분개",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 카드정보 입력 설정",
			"commonCode": "ex00006",
			"detailCode": "E",
			"orderNum": 6,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001006",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "문서",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 카드정보 입력 설정",
			"commonCode": "ex00006",
			"detailCode": "L",
			"orderNum": 6,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001006",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "항목",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 카드정보 입력 설정",
			"commonCode": "ex00006",
			"detailCode": "S",
			"orderNum": 6,
			"optionSelectType": "COMBOBOX",
			"setValue": "L",
			"optionProcessType": "ELSM",
			"useSw": "ERPiU",
			"optionCode": "001006",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "분개",
			"name": "지출결의 화면설정",
			"setEmpValue": null,
			"baseName": "항목",
			"baseValue": "L",
			"setName": "항목"
		}, {
			"optionName": "[레이아웃] 기본입력 적요 설정",
			"commonCode": "ex00001",
			"detailCode": "N",
			"orderNum": 7,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "001007",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "미사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[레이아웃] 기본입력 적요 설정",
			"commonCode": "ex00001",
			"detailCode": "Y",
			"orderNum": 7,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "001007",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[공통팝업] 표준적요 상세 표시 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00001",
			"detailCode": "N",
			"orderNum": 8,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "001008",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "미사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[공통팝업] 표준적요 상세 표시 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00001",
			"detailCode": "Y",
			"orderNum": 8,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "001008",
			"useYn": "Y",
			"optionGbn": "001",
			"baseEmpValue": null,
			"detailName": "사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_10",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 10일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_15",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 15일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_20",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 20일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_25",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 25일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_31",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 31일 ( 말일 )",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_5",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 05일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_10",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 10일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_15",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 15일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_20",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 20일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_25",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 25일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_31",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 31일 ( 말일 )",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_5",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 05일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_p0",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "오늘 일자",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_10",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 10일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_15",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 15일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_20",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 20일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_25",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 25일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_31",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 31일 ( 말일 )",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_5",
			"orderNum": 1,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002001",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 05일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 작성자 편집 기능",
			"commonCode": "ex00004",
			"detailCode": "N",
			"orderNum": 2,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "002002",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "아니오",
			"name": "예/아니오",
			"setEmpValue": null,
			"baseName": "예",
			"baseValue": "Y",
			"setName": "예"
		}, {
			"optionName": "[일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 작성자 편집 기능",
			"commonCode": "ex00004",
			"detailCode": "Y",
			"orderNum": 2,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "002002",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "예",
			"name": "예/아니오",
			"setEmpValue": null,
			"baseName": "예",
			"baseValue": "Y",
			"setName": "예"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_10",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 10일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_15",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 15일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_20",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 20일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_25",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 25일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_31",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 31일 ( 말일 )",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "m1_5",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "전월 05일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_10",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 10일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_15",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 15일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_20",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 20일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_25",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 25일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_31",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 31일 ( 말일 )",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_5",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "당월 05일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p0_p0",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "오늘 일자",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_10",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 10일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_15",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 15일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_20",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 20일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_25",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 25일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_31",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 31일 ( 말일 )",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 설정",
			"commonCode": "ex00014",
			"detailCode": "p1_5",
			"orderNum": 3,
			"optionSelectType": "COMBOBOX",
			"setValue": "p0_p0",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "002003",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "익월 05일",
			"name": "일자설정",
			"setEmpValue": null,
			"baseName": "오늘 일자",
			"baseValue": "p0_p0",
			"setName": "오늘 일자"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 작성자 편집 기능",
			"commonCode": "ex00004",
			"detailCode": "N",
			"orderNum": 4,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "002004",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "아니오",
			"name": "예/아니오",
			"setEmpValue": null,
			"baseName": "예",
			"baseValue": "Y",
			"setName": "예"
		}, {
			"optionName": "[일자설정] 기본입력 지급요청일자 작성자 편집 기능",
			"commonCode": "ex00004",
			"detailCode": "Y",
			"orderNum": 4,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "002004",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": null,
			"detailName": "예",
			"name": "예/아니오",
			"setEmpValue": null,
			"baseName": "예",
			"baseValue": "Y",
			"setName": "예"
		}, {
			"optionName": "[마감설정] 마감 기준일자 설정",
			"commonCode": "",
			"detailCode": null,
			"orderNum": 5,
			"optionSelectType": "COMBOBOX",
			"setValue": "",
			"optionProcessType": "DATETIME",
			"useSw": "ERPiU",
			"optionCode": "002005",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": "",
			"detailName": null,
			"name": null,
			"setEmpValue": "",
			"baseName": "미사용",
			"baseValue": "",
			"setName": "미사용"
		}, {
			"optionName": "[마감설정] 작성 제한기간 설정",
			"commonCode": "",
			"detailCode": null,
			"orderNum": 6,
			"optionSelectType": "COMBOBOX",
			"setValue": "",
			"optionProcessType": "DATETIME",
			"useSw": "ERPiU",
			"optionCode": "002006",
			"useYn": "Y",
			"optionGbn": "002",
			"baseEmpValue": "",
			"detailName": null,
			"name": null,
			"setEmpValue": "",
			"baseName": "미사용",
			"baseValue": "",
			"setName": "미사용"
		}, {
			"optionName": "[일반설정] 카드번호 표시 설정 ( 기본 : 카드명칭 표시 )",
			"commonCode": "ex00007",
			"detailCode": "0",
			"orderNum": 2,
			"optionSelectType": "COMBOBOX",
			"setValue": "1",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003002",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "카드명칭 표시",
			"name": "카드번호 표시 설정",
			"setEmpValue": null,
			"baseName": "카드명칭 표시",
			"baseValue": "1",
			"setName": "카드명칭 표시"
		}, {
			"optionName": "[일반설정] 카드번호 표시 설정 ( 기본 : 카드명칭 표시 )",
			"commonCode": "ex00007",
			"detailCode": "1",
			"orderNum": 2,
			"optionSelectType": "COMBOBOX",
			"setValue": "1",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003002",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "카드명칭 표시",
			"name": "카드번호 표시 설정",
			"setEmpValue": null,
			"baseName": "카드명칭 표시",
			"baseValue": "1",
			"setName": "카드명칭 표시"
		}, {
			"optionName": "[일반설정] 카드번호 표시 설정 ( 기본 : 카드명칭 표시 )",
			"commonCode": "ex00007",
			"detailCode": "2",
			"orderNum": 2,
			"optionSelectType": "COMBOBOX",
			"setValue": "1",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003002",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "카드번호 가운데 8자리 * 표시",
			"name": "카드번호 표시 설정",
			"setEmpValue": null,
			"baseName": "카드명칭 표시",
			"baseValue": "1",
			"setName": "카드명칭 표시"
		}, {
			"optionName": "[일반설정] 카드번호 표시 설정 ( 기본 : 카드명칭 표시 )",
			"commonCode": "ex00007",
			"detailCode": "3",
			"orderNum": 2,
			"optionSelectType": "COMBOBOX",
			"setValue": "1",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003002",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "카드번호 끝 4자리 **** 표시",
			"name": "카드번호 표시 설정",
			"setEmpValue": null,
			"baseName": "카드명칭 표시",
			"baseValue": "1",
			"setName": "카드명칭 표시"
		}, {
			"optionName": "[일반설정] 지출결의 상신 시 결의내역 최대입력 건수 설정 ( 최대 : 100 건 )",
			"commonCode": null,
			"detailCode": null,
			"orderNum": 3,
			"optionSelectType": "TEXT",
			"setValue": "100",
			"optionProcessType": "COUNT",
			"useSw": "ERPiU",
			"optionCode": "003003",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": "100",
			"detailName": null,
			"name": null,
			"setEmpValue": null,
			"baseName": "100",
			"baseValue": null,
			"setName": "100"
		}, {
			"optionName": "[일반설정] 관리항목 필수입력 확인 설정 ( 기본 : 사용 )",
			"commonCode": "ex00001",
			"detailCode": "N",
			"orderNum": 4,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003004",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "미사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "사용",
			"baseValue": "Y",
			"setName": "사용"
		}, {
			"optionName": "[일반설정] 관리항목 필수입력 확인 설정 ( 기본 : 사용 )",
			"commonCode": "ex00001",
			"detailCode": "Y",
			"orderNum": 4,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003004",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "사용",
			"baseValue": "Y",
			"setName": "사용"
		}, {
			"optionName": "[일반설정] 기본입력 카드사용내역 검색기간 설정 ( 기본 : 5일 )",
			"commonCode": null,
			"detailCode": null,
			"orderNum": 5,
			"optionSelectType": "TEXT",
			"setValue": "5",
			"optionProcessType": "DATEADD",
			"useSw": "ERPiU",
			"optionCode": "003005",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": "5",
			"detailName": null,
			"name": null,
			"setEmpValue": null,
			"baseName": "5",
			"baseValue": null,
			"setName": "5"
		}, {
			"optionName": "[입력설정] 코드 도움창에서 검색결과가 1건인 경우 자동 입력 설정 ( 기본 : 사용 )",
			"commonCode": "ex00001",
			"detailCode": "N",
			"orderNum": 101,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003101",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "미사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "사용",
			"baseValue": "Y",
			"setName": "사용"
		}, {
			"optionName": "[입력설정] 코드 도움창에서 검색결과가 1건인 경우 자동 입력 설정 ( 기본 : 사용 )",
			"commonCode": "ex00001",
			"detailCode": "Y",
			"orderNum": 101,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003101",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "사용",
			"baseValue": "Y",
			"setName": "사용"
		}, {
			"optionName": "[입력설정] 적요란 표준적요 자동입력 설정 ( 기본입력 적요 설정 사용시 미적용 / 기본 : 사용 )",
			"commonCode": "ex00001",
			"detailCode": "N",
			"orderNum": 102,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003102",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "미사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "사용",
			"baseValue": "Y",
			"setName": "사용"
		}, {
			"optionName": "[입력설정] 적요란 표준적요 자동입력 설정 ( 기본입력 적요 설정 사용시 미적용 / 기본 : 사용 )",
			"commonCode": "ex00001",
			"detailCode": "Y",
			"orderNum": 102,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003102",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "사용",
			"baseValue": "Y",
			"setName": "사용"
		}, {
			"optionName": "[입력설정] 카드사용내역 연동시 금액 편집 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00001",
			"detailCode": "N",
			"orderNum": 103,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003103",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "미사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[입력설정] 카드사용내역 연동시 금액 편집 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00001",
			"detailCode": "Y",
			"orderNum": 103,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003103",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[입력설정] 예산 미연동시 마이너스 지출결의 작성 설정 ( 기본 : 미사용)",
			"commonCode": "ex00001",
			"detailCode": "N",
			"orderNum": 104,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003104",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": "",
			"detailName": "미사용",
			"name": "사용여부",
			"setEmpValue": "",
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[입력설정] 예산 미연동시 마이너스 지출결의 작성 설정 ( 기본 : 미사용)",
			"commonCode": "ex00001",
			"detailCode": "Y",
			"orderNum": 104,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003104",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": "",
			"detailName": "사용",
			"name": "사용여부",
			"setEmpValue": "",
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[예산연동] 예산연동 사용여부 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00028",
			"detailCode": "N",
			"orderNum": 301,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003301",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "미사용",
			"name": "지출결의(영리) 예산사용 여부",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[예산연동] 예산연동 사용여부 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00028",
			"detailCode": "Y",
			"orderNum": 301,
			"optionSelectType": "COMBOBOX",
			"setValue": "N",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003301",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "사용",
			"name": "지출결의(영리) 예산사용 여부",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "N",
			"setName": "미사용"
		}, {
			"optionName": "[예산연동] 예산정보 필수입력 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00009",
			"detailCode": "0",
			"orderNum": 302,
			"optionSelectType": "COMBOBOX",
			"setValue": "0",
			"optionProcessType": null,
			"useSw": "ERPiU",
			"optionCode": "003302",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "미사용",
			"name": "예산정보 필수입력 설정",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "0",
			"setName": "미사용"
		}, {
			"optionName": "[예산연동] 예산정보 필수입력 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00009",
			"detailCode": "1",
			"orderNum": 302,
			"optionSelectType": "COMBOBOX",
			"setValue": "0",
			"optionProcessType": null,
			"useSw": "ERPiU",
			"optionCode": "003302",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "예산단위 + 사업계획 + 예산계정 ( 필수 )",
			"name": "예산정보 필수입력 설정",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "0",
			"setName": "미사용"
		}, {
			"optionName": "[예산연동] 예산정보 필수입력 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00009",
			"detailCode": "2",
			"orderNum": 302,
			"optionSelectType": "COMBOBOX",
			"setValue": "0",
			"optionProcessType": null,
			"useSw": "ERPiU",
			"optionCode": "003302",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "예산단위 + 사업계획 + 예산계정 ( 필수아님 )",
			"name": "예산정보 필수입력 설정",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "0",
			"setName": "미사용"
		}, {
			"optionName": "[예산연동] 예산정보 필수입력 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00009",
			"detailCode": "3",
			"orderNum": 302,
			"optionSelectType": "COMBOBOX",
			"setValue": "0",
			"optionProcessType": null,
			"useSw": "ERPiU",
			"optionCode": "003302",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "예산단위 + 예산계정 ( 필수 )",
			"name": "예산정보 필수입력 설정",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "0",
			"setName": "미사용"
		}, {
			"optionName": "[예산연동] 예산정보 필수입력 설정 ( 기본 : 미사용 )",
			"commonCode": "ex00009",
			"detailCode": "4",
			"orderNum": 302,
			"optionSelectType": "COMBOBOX",
			"setValue": "0",
			"optionProcessType": null,
			"useSw": "ERPiU",
			"optionCode": "003302",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "예산단위 + 예산계정 ( 필수아님 )",
			"name": "예산정보 필수입력 설정",
			"setEmpValue": null,
			"baseName": "미사용",
			"baseValue": "0",
			"setName": "미사용"
		}, {
			"optionName": "[예산연동] 지출결의 유효성 확인시 등록내역 예산 초과 확인 여부 ( 기본 : 사용 )",
			"commonCode": "ex00001",
			"detailCode": "N",
			"orderNum": 303,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003303",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "미사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "사용",
			"baseValue": "Y",
			"setName": "사용"
		}, {
			"optionName": "[예산연동] 지출결의 유효성 확인시 등록내역 예산 초과 확인 여부 ( 기본 : 사용 )",
			"commonCode": "ex00001",
			"detailCode": "Y",
			"orderNum": 303,
			"optionSelectType": "COMBOBOX",
			"setValue": "Y",
			"optionProcessType": "YN",
			"useSw": "ERPiU",
			"optionCode": "003303",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "사용",
			"name": "사용여부",
			"setEmpValue": null,
			"baseName": "사용",
			"baseValue": "Y",
			"setName": "사용"
		}, {
			"optionName": "[자동전표] 자동전표 전송 범위 설정 ( 기본 : 문서단위 전송 )",
			"commonCode": "ex00029",
			"detailCode": "E",
			"orderNum": 401,
			"optionSelectType": "COMBOBOX",
			"setValue": "E",
			"optionProcessType": "EL",
			"useSw": "ERPiU",
			"optionCode": "003401",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "문서단위 전송",
			"name": "자동전표 전송 범위 설정",
			"setEmpValue": null,
			"baseName": "문서단위 전송",
			"baseValue": "E",
			"setName": "문서단위 전송"
		}, {
			"optionName": "[자동전표] 자동전표 전송 범위 설정 ( 기본 : 문서단위 전송 )",
			"commonCode": "ex00029",
			"detailCode": "L",
			"orderNum": 401,
			"optionSelectType": "COMBOBOX",
			"setValue": "E",
			"optionProcessType": "EL",
			"useSw": "ERPiU",
			"optionCode": "003401",
			"useYn": "Y",
			"optionGbn": "003",
			"baseEmpValue": null,
			"detailName": "항목단위 전송",
			"name": "자동전표 전송 범위 설정",
			"setEmpValue": null,
			"baseName": "문서단위 전송",
			"baseValue": "E",
			"setName": "문서단위 전송"
		} ],
		"ifSystem": "ERPiU"
	};
	/* document ready */
	$ ( document ).ready ( function ( ) {
		fnInit ( );
	} );
	/* init */
	function fnInit ( ) {
		commonFunc.setSelectItems ( $ ( '#selForm' ), [ {
			'formSeq': '1',
			'formName': '양식 12312312'
		} ], 'formSeq', 'formName' );
		fnInitEvent ( );
		return;
	}
	/* init event */
	function fnInitEvent ( ) {
		/* tab */
		$ ( '.tab_nor li' ).click ( function ( ) {
			var num = $ ( this ).index ( );
			var inx = $ ( ".tab_nor li.on" ).index ( );
			if ( num !== inx ) {
				$ ( ".tab" + num ).show ( );
				$ ( ".tab_nor li" ).eq ( num ).addClass ( "on" );
				$ ( ".tab" + inx ).hide ( );
				$ ( ".tab_nor li" ).eq ( inx ).removeClass ( "on" );

				var optionList = new Array ( );
				options.optionItemsSet.forEach ( function ( item, itemIndex ) {
					if ( options.ifSystem === item.useSw ) {
						if ( Number ( item.optionGbn ) === ( num + 1 ) ) {
							optionList.push ( item );
						}
					}
				} );

				fnOptionTableInit ( optionList );
			}
			return;
		} );
		// selForm
		// btnSave
		return;
	}
	/* option */
	/* option - table init */
	function fnOptionTableInit ( optionList ) {
		var optionGbn = '00' + ( $ ( ".tab_nor li.on" ).index ( ) + 1 );
		var target = $ ( '#' + targetTbl + optionGbn );
		target.contents ( ).unbind ( ).remove ( );
		var colGroup = '';
		colGroup += '<colgroup>';
		colGroup += '	<col width="70%" />';
		colGroup += '	<col width="" />';
		colGroup += '</colgroup>';
		colGroup += '<tr>';
		colGroup += '	<th>속성정보</th>';
		colGroup += '	<th>설정정보</th>';
		colGroup += '</tr>';
		target.append ( colGroup );

		if ( optionList.length > 0 ) {
			optionList.forEach ( function ( item, itemIndex ) {
				var tr = '';
				tr += '<td class="le">' + item.optionName + '</td>';
				tr += '<td class="le">' + item.setName + '</td>';
				target.append ( '<tr>' + tr + '</tr>' );
			} );
		} else {
			var tr = '';
			tr += '<td colspan="2">속성정보가 없습니다.</td>'
			target.append ( '<tr>' + tr + '</tr>' );
		}
		return;
	}
	/* option search */
	/* option save */
	/* ## [+] [ 공통화 필요 사항 ] ## */
	var commonFunc = {
		setSelectItems: function ( target, items, value, text, changeEvent ) {
			items.forEach ( function ( item, itemIndex ) {
				target.append ( '<option value="' + ( item [ value ] || '' ) + '" selected="selected">' + ( item [ text ] || '' ) + '</option>' );
			} );

			if ( typeof changeEvent === 'function' ) {
				target.change ( function ( ) {
					changeEvent ( );
				} );
			}

			target.css ( 'width', ( Number ( target.css ( 'width' ).toString ( ).replace ( 'px', '' ) ) + 20 ) );
			return;
		}
	};
	/* ## [-] [ 공통화 필요 사항 ] ## */
</script>

<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_form} <!--양식--></dt>
			<dd>
				<select id="selForm" class="selectmenu"></select>
			</dd>
		</dl>
	</div>
	<div id="" class="controll_btn">
		<button id="btnSave" class="k-button">${CL.ex_save} <!--저장--></button>
	</div>
	<!-- tab -->
	<div class="tab_nor mb20">
		<ul>
			<li class="on"><a href="#">${CL.ex_functionalOption} <!--기능옵션--></a></li>
			<li><a href="#">${CL.ex_dateOption} <!--일자옵션--></a></li>
			<li><a href="#">${CL.ex_screenOption} <!--화면옵션--></a></li>
		</ul>
	</div>
	<!-- tab_contents -->
	<div class="tab_area">
		<div class="tab0">
			<table style="width: 100%;">
				<colgroup>
					<col style="width: 70%;" />
					<col style="" />
				</colgroup>
				<tr>
					<td>
						<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
							<table id="tblOptionGbn001">
								<colgroup>
									<col width="70%" />
									<col width="" />
								</colgroup>
								<tr>
									<th>${CL.ex_attInfo} <!--속성정보--></th>
									<th>${CL.ex_setInfo} <!--설정정보--></th>
								</tr>
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
							</table>
				</div>
				</td>
				<td class="pl20">
					<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
						<table>
							<tr>
								<th>${CL.ex_setValue} <!--설정값--></th>
							</tr>
							<!-- <tr>
									<td class="le"><input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">사용</label></td>
								</tr> -->
							<!-- <tr>
									<td class="le"><input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">미사용</label></td>
								</tr> -->
						</table>
					</div>
				</td>
				<td></td>
				</tr>
			</table>
		</div>
		<!--// tab1 -->
		<div class="tab1" style="display: none;">
			<table style="width: 100%;">
				<colgroup>
					<col style="width: 70%;" />
					<col style="" />
				</colgroup>
				<tr>
					<td>
						<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
							<table id="tblOptionGbn002">
								<colgroup>
									<col width="70%" />
									<col width="" />
								</colgroup>
								<tr>
									<th>${CL.ex_attInfo} <!--속성정보--></th>
									<th>${CL.ex_setInfo} <!--설정정보--></th>
								</tr>
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">오늘일자</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">당월25일</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
							</table>
				</div>
				</td>
				<td class="pl20">
					<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
						<table>
							<tr>
								<th>${CL.ex_setValue} <!--설정값--></th>
							</tr>
							<!-- <tr>
									<td class="le"><input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">오늘일자</label></td>
								</tr> -->
							<!-- <tr>
									<td class="le"><input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">전월 05일</label></td>
								</tr> -->
						</table>
					</div>
				</td>
				<td></td>
				</tr>
			</table>
		</div>
		<!--// tab2 -->
		<div class="tab2" style="display: none;">
			<table style="width: 100%;">
				<colgroup>
					<col style="width: 70%;" />
					<col style="" />
				</colgroup>
				<tr>
					<td>
						<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
							<table id="tblOptionGbn003">
								<colgroup>
									<col width="70%" />
									<col width="" />
								</colgroup>
								<tr>
									<th>${CL.ex_attInfo} <!--속성정보--></th>
									<th>${CL.ex_setInfo} <!--설정정보--></th>
								</tr>
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">전표</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">분개</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
								<!-- <tr>
									<td class="le"><img src="../../../Images/ico/ico_option_bl.gif" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정</td>
									<td class="le">미사용</td>
								</tr> -->
							</table>
				</div>
				</td>
				<td class="pl20">
					<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
						<table>
							<tr>
								<th>${CL.ex_setValue} <!--설정값--></th>
							</tr>
							<!-- <tr>
									<td class="le"><input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">전표+분개</label></td>
								</tr> -->
							<!-- <tr>
									<td class="le"><input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">전표</label></td>
								</tr> -->
						</table>
					</div>
				</td>
				<td></td>
				</tr>
			</table>
		</div>
		<!--// tab3 -->
	</div>
	<!--// tab_area -->
</div>
<!-- //sub_contents_wrap -->