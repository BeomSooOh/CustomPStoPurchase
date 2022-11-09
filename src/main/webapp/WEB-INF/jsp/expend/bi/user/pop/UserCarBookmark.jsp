<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Bizbox A</title>
    
    <!--css-->
	<link rel="stylesheet" type="text/css" href="../../../Scripts/jqueryui/jquery-ui.css"/>
    <link rel="stylesheet" type="text/css" href="../../../css/common.css">
	    
    <!--js-->
    <script type="text/javascript" src="../../../Scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="../../../Scripts/jqueryui/jquery.min.js"></script>
	<script type="text/javascript" src="../../../Scripts/jqueryui/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../../../Scripts/common.js"></script>
	
	<script>
		//휠스크롤
		function fixDataOnWheel(){
	        if(event.wheelDelta < 0){
	            DataScroll.doScroll('scrollbarDown');
	        }else{
	            DataScroll.doScroll('scrollbarUp');
	        }
	        table1Scroll();
	    }
		//각 테이블 스크롤 동기화
	    function table1Scroll() {
        	$(".table1 .leftContents").scrollTop($(".table1 .rightContents").scrollTop());
        	$(".table1 .rightHeader").scrollLeft($(".table1 .rightContents").scrollLeft());
	    }
	</script>
</head>

<body>
<div class="pop_wrap">
	<div class="pop_head">
		<h1>즐겨찾기</h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>

	<div class="pop_con">	
		<p class="tit_p fl mt7">등록</p>	
		<div class="controll_btn p0 fr">
			<button id="">삭제</button>
		</div>
		
		<!-- 등록 테이블 -->
		<div class="table1">
			<div class="cus_ta_ea">
				<table>
					<tr>
						<td class="p0 scbg brn" width="187" valign="top">
							<!-- LEFT HEADER(FIXED) -->
							<div id="" class="cus_ta_ea ovh leftHeader ta_bl ta_br">					               
								<table>
									<tr>
										<th width="34">
											<input type="checkbox" name="new_inp" id="new_inp" />
											<label for="new_inp"></label>
										</th>
										<th width="50">코드</th>
										<th width="100">즐겨찾기명</th>
									</tr>
								</table>
							</div>
							
							<!-- LEFT CONTENTS(FIXED) -->
							<div id="" class="cus_ta_ea rowHeight ovh leftContents scbg ta_bl ta_br" style="height:165px;" onmousewheel="fixDataOnWheel()" onScroll="table1Scroll()">
								<table>
									<tr>
										<td width="34">
											<input type="checkbox" name="new_inp1" id="new_inp1" />
											<label for="new_inp1"></label>
										</td>
										<td width="50"></td>
										<td width="100"></td>
									</tr>
									<tr class="rowOn">
										<td width="34">
											<input type="checkbox" name="new_inp2" id="new_inp2" />
											<label for="new_inp2"></label>
										</td>
										<td width="50"></td>
										<td width="100"></td>
									</tr>
									<tr>
										<td width="34">
											<input type="checkbox" name="new_inp3" id="new_inp3" />
											<label for="new_inp3"></label>
										</td>
										<td width="50"></td>
										<td width="100"></td>
									</tr>
								</table>
							</div>
						</td>

						<td class="p0 scbg posi_re brn" width="*" valign="top">
							<!-- SCROLL HEADER -->
							<span class="scy_head1"></span>
							
							<!-- RIGHT HEADER -->
							<div id="" class="cus_ta_ea ovh mr17 rightHeader ta_bl">
								<table>
									<tr>
										<th width="100">출발시간</th>
										<th width="100">도착시간</th>
										<th width="100">운행구분</th>
										<th width="100">출발구분</th>
										<th width="100">출발지</th>
										<th width="100">도착구분</th>
										<th width="100">도착지</th>
										<th width="100">주행</th>
										<th width="100">코드</th>
										<th width="100">비고</th>
										<th width="100">결제구분</th>
										<th width="100">통행료</th>
									</tr>
								</table>
							</div>
							
							<!-- RIGHT CONTENTS -->
							<div id="" class="cus_ta_ea rowHeight scroll_fix rightContents scbg ta_bl" style="height:182px;" onScroll="table1Scroll()">
								<table>
									<tr>											
										<td class="le" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"><input type="text" class="inpTextBox ar" value=""/></td> <!-- input내 텍스트 정렬:  오른쪽  ar / 가운데 ac -->

									</tr>
									<tr class="rowOn">											
										<td class="cen colOn highLight" width="100">
											<span class="highLightIn"><input type="text" class="inpTextBox" value=""/></span>
										</td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
									</tr>
									<tr>											
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
										<td class="cen" width="100"></td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<!-- 상세주소 -->
		<div class="vehicles_detail clear">
			<dl>
				<dt class="tit_p" width="100">출발지 상세주소</dt>
				<dd style="width:33%;"><input style="width:100%;" type="text" id="" /></dd>
				<dt class="tit_p" width="100">도착지 상세주소</dt>
				<dd style="width:33%;"><input style="width:100%;" type="text" id="" /></dd>
			</dl>
			
			<div class="cl pt10 f11 pl5 lh20">
				<ol>	
					<li>1. 즐겨찾기 코드는 <span class="text_blue">10 ~ 99까지 등록 가능</span>합니다.</li>
					<li>2. <span class="text_blue">[주행거리 조회] 버튼</span>을 통해 네이버지도 빠른길찾기의 주행거리를 조회할 수 있습니다.</li>
				</ol>
			</div>				
		</div>
									
	</div><!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="" value="저장" />
			<input type="button" class="gray_btn" value="취소" />
		</div>
	</div><!-- //pop_foot -->


</div><!-- //pop_wrap -->
</body>
</html>