<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="main.web.BizboxAMessage"%>

<!-- jQuery plugin -->
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.mask.js"></c:url>'></script>

<!-- e나라도움 연계 참조 -->
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.ucdevtable.1.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.uckeydevtable.1.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.anbojo.var.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.anbojo.js"></c:url>'></script>

<script type="text/javascript">
	/* #. 변수정의 */
	var BSNSYEAR = '${param.BSNSYEAR}' /* '2017' */
		, ASSTN_TAXITM_CODE = '${param.ASSTN_TAXITM_CODE}' /* '11003' */
		, GISU = '${param.GISU}' /* 2 */
		, FR_DT = '${param.FR_DT}' /* '20170101' */
		, TO_DT = '${param.TO_DT}' /* '20171231' */
		, BGT_FR_DT = '${param.BGT_FR_DT}'; /* '20170101'; */
	var budgetInfoList = [ ];
	var budgetInfoSerchInfo = {
		/* 부분검색 - 예산과목명 */
		"searchBudgetName": "",
		/* 부분검색 - 예산과목코드 */
		"searchBudgetCode": "",
		/* 예산과목표시 */
		"searchType1": "",
		/* 사용기한 */
		"searchType2": "",
		/* 상위과목표시 */
		"searchTeyp3": "",
		/* 예산그룹표시 */
		"searchType4": "",
	};
	/* 예산4단계 / 7단계 적용으로 동적 변경 */
	var gridHeaderInfo = [ {
		"title": "예산그룹",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "관",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "항",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "목",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "세",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "코드",
		"format": "string",
		"align": "center",
		"width": "120px"
	} ];



	/* [+] ## document ready ################################################## */
	$ ( document ).ready ( function ( ) {
		
		// fnTableAddRow({ "budgetGroup": "예산과목체계", "gan": "A5관 지출", "hang": "A5항 일반관리비", "mok": "A5목-인건비", "se": "", "code": "A500010200", });
		// fnTableAddRow({ "budgetGroup": "예산과목체계", "gan": "A5관 지출", "hang": "A5항 일반관리비", "mok": "A5목-인건비", "se": "", "code": "A500010200", });
		// 이지바로 테이블 로우 선택 

		var iFocus = $('#budgetListPop').find( '.rightContents.cus_ta table tr td input' );

		iFocus.click ( function ( ) {
			iFocus.removeClass ( 'focus' ), $ ( this ).addClass ( 'focus' );
		} );
	} );

	


</script>

<!-- 예산과목 자료조회 팝업 -->
<div id="budgetListPop" style="display: block">
	<!-- modal -->
	<div class="modal posi_fix" style="z-index: 101"></div>

	<div class="pop_wrap_dir posi_ab" style="width: 800px; height: 676px; top: 50%; left: 50%; margin: -338px 0 0 -400px; z-index: 102">
		<div class="pop_head">
			<h1>예산과목 코드도움</h1>
			<a id="btnBudgetListLayerColse" href="#n" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
		</div>

		<div class="pop_con">
			<!-- 테이블 -->
			<div class="popTable table1">
				<div class="cus_ta">
					<table id="tblBudgetList">
						<tr>
							<td class="p0 brn posi_re" width="*" valign="top">
								<!-- SCROLL HEADER --> <span class="scy_head1"></span> <!-- RIGHT HEADER -->
								<div id="" class="cus_ta ovh mr17 rightHeader">
									<table>
										<tr>
											<!-- <th style="width:120px;">예산그룹</th> -->
											<!-- <th style="width:120px;">관</th> -->
											<!-- <th style="width:120px;">항</th> -->
											<!-- <th style="width:120px;">목</th> -->
											<!-- <th style="width:120px;">세</th> -->
											<!-- <th style="width:120px;">코드</th> -->
										</tr>
									</table>
								</div> <!-- RIGHT CONTENTS -->
								<div id="" class="cus_ta scroll_fix rightContents" style="height: 307px;" onScroll="table1Scroll()">
									<table>
										<tr class="lineOn onSel">
											<!-- <td style="width:120px;" class="le"><span>예산과목체계</span></td> -->
											<!-- <td style="width:120px;" class="le"><span>A5관 지출</span></td> -->
											<!-- <td style="width:120px;" class="le"><span>A5항 일반관리비</span></td> -->
											<!-- <td style="width:120px;" class="le"><span>A5목-인건비</span></td>ㅍ
                                                <!-- <td style="width:120px;" class="le"><span></span></td> -->
											<!-- <td style="width:120px;" class="le"><span>A500010200</span></td> -->
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<!-- 부분검색 -->
			<div class="top_box mt20">
				<dl>
					<dl>
						<dt style="width: 110px;">부분검색</dt>
						<dt>예산과목명</dt>
						<dd style="width: 200px;">
							<input class="input_search" id="txtBudgetName" type="text" value="" style="width: 166px;" />
							<!--<a href="#" class="btn_search"></a>-->
						</dd>
						<dt>예산과목코드</dt>
						<dd style="width: 200px;">
							<input class="input_search" id="txtBudgetCode" type="text" value="" style="width: 166px;" />
							<!--<a href="#" class="btn_search"></a>-->
						</dd>
					</dl>

					<dl class="mt-20">
						<dt style="width: 120px;">예산과목표시</dt>
						<dd>
							<input type="radio" name="type1_radio" id="type1Radio1" value="1" class="ml10" checked=""> <label for="type1Radio1">모든 예산과목 표시</label> <input type="radio" name="type1_radio" id="type1Radio2" value="2" class="ml20"> <label for="type1Radio2">당기 예산편성된 과목만 표시</label> <input type="radio" name="type1_radio" id="type1Radio3" value="3" class="ml20"> <label for="type1Radio3">프로젝트기간 예산편성된 과목만 표시</label>
						</dd>
					</dl>

					<dl class="mt-20">
						<dt style="width: 120px;">사용기한</dt>
						<dd>
							<input type="radio" name="type2_radio" id="type2Radio1" value="1" class="ml10" checked=""> <label for="type2Radio1">모두표시</label> <input type="radio" name="type2_radio" id="type2Radio2" value="2" style="margin-left: 76px;"> <label for="type2Radio2">사용기한 경과분 숨김</label>
						</dd>
					</dl>

					<dl class="mt-20">
						<dt style="width: 120px;">상위과목표시</dt>
						<dd>
							<input type="radio" name="type3_radio" id="type3Radio1" value="1" class="ml10" checked=""> <label for="type3Radio1">모두표시</label> <input type="radio" name="type3_radio" id="type3Radio2" value="2" style="margin-left: 76px;"> <label for="type3Radio2">최하위 표시</label>
						</dd>
					</dl>

					<!-- <dl class="mt-20">
                            <dt style="width:120px;">예산그룹표시</dt>
                            <dd>
                                <input type="radio" name="type4_radio" id="type4Radio1" class="ml10" checked="">
                                <label for="type4Radio1">표시</label>
                                <input type="radio" name="type4_radio" id="type4Radio2" style="margin-left:100px;">
                                <label for="type4Radio2">숨김</label>
                            </dd>
                        </dl> -->
				</dl>
			</div>

		</div>
		<!--// pop_con -->

		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input id="btnBudgetListSearch" type="button" value="검색(F8)" /> <input id="btnBudgetAccept" type="button" value="확인" />
				<!-- <input type="button" class="gray_btn" value="취소" /> -->
			</div>
		</div>
		<!-- //pop_foot -->
	</div>
	<!--// pop_wrap -->
</div>
<!--// 예산과목 자료조회 팝업 -->
</body>

<!--//
<body>
    <div id="" style="display:block">
        <div class="modal posi_fix" style="z-index:101"></div>

        <div class="pop_wrap_dir posi_ab" style="width:800px;height:676px;top:50%;left:50%;margin:-338px 0 0 -400px;z-index:102">
            <div class="pop_head">
                <h1>예산과목 코드도움</h1>
                <a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt=""></a>
            </div>

            <div class="pop_con">
                <div class="popTable table1">
                    <div class="cus_ta">
                        <table>
                            <tr>
                                <td class="p0 brn posi_re" width="*" valign="top">
                                    <span class="scy_head1"></span>

                                    <div id="" class="cus_ta ovh mr17 rightHeader">
                                        <table>
                                            <tr>
                                                <th style="width:120px;">예산그룹</th>
                                                <th style="width:120px;">관</th>
                                                <th style="width:120px;">항</th>
                                                <th style="width:120px;">목</th>
                                                <th style="width:120px;">세</th>
                                                <th style="width:120px;">코드</th>
                                            </tr>
                                        </table>
                                    </div>

                                    <div id="" class="cus_ta scroll_fix rightContents scbg_img" style="height:307px;" onScroll="table1Scroll()">
                                        <table>
                                            <tr class="lineOn onSel">
                                                <td style="width:120px;" class="le"><span>예산과목체계</span></td>
                                                <td style="width:120px;" class="le"><span>A5관 지출</span></td>
                                                <td style="width:120px;" class="le"><span>A5항 일반관리비</span></td>
                                                <td style="width:120px;" class="le"><span>A5목-인건비</span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span>A500010200</span></td>
                                            </tr>

                                            <tr>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                            </tr>
                                            <tr>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                                <td style="width:120px;" class="le"><span></span></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="top_box mt20">
                    <dl>
                        <dl>
                            <dt style="width:110px;">부분검색</dt>
                            <dt>예산과목명</dt>
                            <dd style="width:200px;">
                                <input class="input_search" id="" type="text" value="" style="width:166px;" />
                                <a href="#" class="btn_search" style="display:none;"></a>
                            </dd>
                            <dt>예산과목코드</dt>
                            <dd style="width:200px;">
                                <input class="input_search" id="" type="text" value="" style="width:166px;" />
                                <a href="#" class="btn_search" style="display:none;"></a>
                            </dd>
                        </dl>

                        <dl class="mt-20">
                            <dt style="width: 120px;">예산과목표시</dt>
                            <dd>
                                <input type="radio" name="type1_radio" id="type1Radio1" class="ml10" checked=""> <label for="type1Radio1">모든 예산과목 표시</label>
                                <input type="radio" name="type1_radio" id="type1Radio2" class="ml20"> <label for="type1Radio2">당기 예산편성된 과목만 표시</label>
                                <input type="radio" name="type1_radio" id="type1Radio3" class="ml20"> <label for="type1Radio3">프로젝트기간 예산편성된 과목만 표시</label>
                            </dd>
                        </dl>

                        <dl class="mt-20">
                            <dt style="width:120px;">사용기한</dt>
                            <dd>
                                <input type="radio" name="type2_radio" id="type2Radio1" class="ml10" checked="">
                                <label for="type2Radio1">모두표시</label>
                                <input type="radio" name="type2_radio" id="type2Radio2" style="margin-left:76px;">
                                <label for="type2Radio2">사용기한 경과분 숨김</label>
                            </dd>
                        </dl>

                        <dl class="mt-20">
                            <dt style="width:120px;">상위과목표시</dt>
                            <dd>
                                <input type="radio" name="type3_radio" id="type3Radio1" class="ml10" checked="">
                                <label for="type3Radio1">모두표시</label>
                                <input type="radio" name="type3_radio" id="type3Radio2" style="margin-left:76px;">
                                <label for="type3Radio2">최하위 표시</label>
                            </dd>
                        </dl>

                        <dl class="mt-20">
                            <dt style="width:120px;">예산그룹표시</dt>
                            <dd>
                                <input type="radio" name="type4_radio" id="type4Radio1" class="ml10" checked="">
                                <label for="type4Radio1">표시</label>
                                <input type="radio" name="type4_radio" id="type4Radio2" style="margin-left:100px;">
                                <label for="type4Radio2">숨김</label>
                            </dd>
                        </dl>
                    </dl>
                </div>

            </div>
            <div class="pop_foot">
                <div class="btn_cen pt12">
                    <input type="button" value="확인" />
                    <input type="button" class="gray_btn" value="취소" />
                </div>
            </div>
        </div>
    </div>
</body>
 -->