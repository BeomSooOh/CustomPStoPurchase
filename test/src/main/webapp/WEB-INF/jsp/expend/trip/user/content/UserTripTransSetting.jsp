<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Bizbox A</title>

	<!--css-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pudd.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pudding/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/animate.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/re_pudd.css">

	<!--js-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudd/pudd-1.1.172.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudding/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudding/common.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function() {
	//grid1
	var dataSource1 = new Pudd.Data.DataSource({
			data : exData = [
					{ "no": "10000", "???????????????": "", "????????????": "?????????"}
			   ,	{ "no": "10000", "???????????????": "", "????????????": "?????????"}
			  
		   ]	// ?????? data??? ????????? ???????????? ?????? ????????? ???
		   ,	pageSize : 1000	// grid??? ???????????? ?????? grid > pageable > pageList ????????? ?????? ??????????????? ???
		   ,	serverPaging : false
	   });
 
	Pudd( "#grid" ).puddGrid({ 
		dataSource : dataSource1 
	,	scrollable : true 
	,	sortable : true
	,	pageable : {
			buttonCount : 10
		,	pageList : [ 10, 20, 30, 40, 50 ]
		} 
	,	resizable : true	
	,	ellipsis : false
	,	gridContent : { 
			attributes : { style : "min-height:226px;"}
		}
	,	columns : [ 
			{
				field : "no"
			,	title : "no"
			,	width : 80
			}
		,	{
				field:"???????????????"
			,	title:"???????????????"
			}
		,	{
				field:"????????????"
			,	title:"????????????"
			,	width : 20
			,	widthUnit : "%"	
			}
		]
	});


	//?????? ????????????
	function twinboxInit( set ){
		var body = $(".sub_contents").height(); //????????? ??????
		// var body = $("body").height(); ????????? ??????
		var location = $(".location_info").outerHeight(true);				
		var twinHeight = body - location;
		$(".sub_contents_wrap .twinbox .twinbox_td").height(twinHeight - 151);
	}


	function gridHeightChange(minusVal) {
		var puddGrid = Pudd( "#grid").getPuddObject();
		var cHeight = document.body.clientHeight;

		var newGridHeight = cHeight - minusVal;
		if( newGridHeight > 100 ) {// ????????????
			puddGrid.gridHeight( newGridHeight );
		}
	}

	gridHeightChange(450); // ????????? ?????? ??????????????????????????????
	twinboxInit(); //???????????? ???????????? (?????? ?????? ??? if??? ?????? ??? ???????????? false ?????????)

	$(window).resize(function () {
		twinboxInit( true );//???????????? ????????????
		gridHeightChange(450);	
	});			
});
</script>
<div class="iframe_wrap">
					<!-- ???????????????????????? -->
					<div class="sub_title_wrap">
						<div class="location_info">
							 <ul>
								<li><a href="#n"><img src="../../../Images/ico/ico_home01.png" alt=""></a></li>
								<li><a href="#n">??????</a></li>
								<li><a href="#n">??????????????????</a></li>
								<li class="on"><a href="#n">??????????????????</a></li>
							 </ul>
						</div>
						<div class="title_div">
							<h4>??????????????????</h4>
						</div>
					</div>
					<div class="sub_contents_wrap mb0">
					
						<div class="posi_re">
							<div id="" class="posi_ab" style="right:0px; z-index:1;">
								<input type="button" class="puddSetup" value="??????" />
								<input type="button" class="puddSetup" value="??????" />
								<input type="button" class="puddSetup" value="??????" />
							</div>
						</div>
							
						<div id="exTab">
							<ul>
								<li>??????</li>
								<li>??????</li>
							</ul>

							<div>							
								<div class="twinbox mt20">
									<table style="min-height:0">
										<colgroup>
											<col width="40%"/>
											<col />
										</colgroup>
										<tr>
											<td class="twinbox_td">
												<p class="tit_p fl">??????????????????</p>
												<div class="top_box">
													<dl>
														<dt>?????????</dt>
														<dd><input type="text" autocomplete="off" style="width:200px;" class="puddSetup" value="" /></dd>
														<dd><input type="button" class="puddSetup submit" value="??????" /></dd>
													</dl>
												</div>
												<div id="grid1" class="mt14"></div>											
											</td>


											<td class="twinbox_td">
												<div class="tablecon">
													<p class="tit_p fl">????????????</p>
													<div class="com_ta">
														<table>
															<colgroup>
																<col width="100"/>
																<col width="100"/>
																<col width=""/>
															</colgroup>
															<tr>
																<th rowspan="4"><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
																<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
																<td><input type="text" autocomplete="off" pudd-style="width:100%;" class="puddSetup" value="" /></td>
															</tr>
															<tr>
																<th>??????</th>
																<td><input type="text" autocomplete="off" pudd-style="width:100%;" class="puddSetup" value="" /></td>
															</tr>
															<tr>
																<th>?????????</th>
																<td><input type="text" autocomplete="off" pudd-style="width:100%;" class="puddSetup" value="" /></td>
															</tr>
															<tr>
																<th>?????????</th>
																<td><input type="text" autocomplete="off" pudd-style="width:100%;" class="puddSetup" value="" /></td>
															</tr>													
															<tr>
																<th colspan="2">????????????</th>
																<td><input type="text" autocomplete="off" pudd-style="width:100%;" class="puddSetup" value="" /></td>
															</tr>
															<tr>
																<th colspan="2">??????</th>
																<td><input type="text" autocomplete="off" pudd-style="width:100%;" class="puddSetup" value="" /></td>
															</tr>
														</table>
													</div>
												</div>
												<p class="tit_p mt15">???????????? <span class="text_red">(??????)</span></p>
												<p class="text_blue f11 mt-5 mb10"><span class="f12">???</span> ??????????????? &gt; ???????????????????????? ????????? ????????? ???????????????.</p>
												<div id="grid2"></div>					
											</td>
										</tr>
									</table>
								</div>
							</div>
							<div>
								Tab ????????? 2
							</div>
						</div>


					</div><!--// sub_contents_wrap -->
				</div><!--// iframe wrap -->
</html>