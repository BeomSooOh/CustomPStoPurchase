<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
 /**
  * @Class Name  : EgovCcmZipSearchPopup.jsp
  * @Description : EgovCcmZipSearchPopup 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *
  *  @author 공통서비스팀
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *
  */
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

$(function(){
	zipObj.init();			
});


var zipObj = {};
zipObj.isResize = false;

zipObj.init = function(){
	// 검색어란 key action
	zipObj.searchTextSet();	
};

zipObj.windowsResizeFunction = function(){
	//alert('windowsResizeFunction');

	var popHeight = document.getElementById("pop_area").offsetHeight; 
	//window.resizeTo(500,popHeight); 
	//self.dialogWidth;
	self.dialogHeight = popHeight+'px';
	//alert('popHeight '+popHeight);
	zipObj.isResize = true;
};

zipObj.searchTextSet = function(){
	$("#searchKeyword").bind({
		keypress : function(event){
			if(event.keyCode == 13){
				zipObj.search();
			}
		}
	});
};

zipObj.setAddress  = function(zip,addr){
	//alert('setAddress ');
	var retVal   = new Object();
	var sZip     = zip;
	var vZip     = zip.substring(0,3)+zip.substring(3,6);
	var sAddr    = addr.replace("/^\s+|\s+$/g","");
	retVal.sZip  = sZip;
	retVal.vZip  = vZip;
	retVal.sAddr = sAddr;
	parent.window.returnValue = retVal;
	parent.window.close();
};


zipObj.search = function(){	
	
	//$("#searchKeyword").val($("#searchKeyword").val().replace(/\-/, ""));
	var searchKeyword = $("#searchKeyword").val();	
	var searchList = $('#searchList>option:selected').val();	
	  		
	if(!$.trim(searchKeyword) || "예:구의동" == searchKeyword){
		alert("검색어를 입력하세요"); 
		return false;
	}
	//var formData = $("#searchForm").serialize(); 
	//  form tag 사용시 새창및.  새창제어(base target)시에는 조회후 새로고침되어 초기화되는 오류
	var formData = {"searchKeyword":searchKeyword, 'searchList':searchList};
	//alert('formData : '+formData);

	$.ajax({
		type:"post",
		url:'<c:url value="/sym/ccm/zip/EgovCcmZipSearchList.do"/>',
		datatype:"json",
		data:  formData,  //{"searchKeyword":searchKeyword, 'searchList':searchList},
		success:function(data){				
			var result = data.resultList;
			//alert('data.result : '+data.result);

			if (data.result!=0) {  // 편번호 찾기에 실패하였습니다.   잠시후에 이용해주시기 바랍니다.
				alert("<spring:message code='system.zipCode.search.fail' />\r\n<spring:message code='system.bm.sign.retryplz' />");  
			}else{
			
				var boardContent ="";
				var boardContent1= "";	
				var boardContent2 = "";
				var boardContent3 = "";
				boardContent1 += '<table width="100%" border="0" cellspacing="0" cellpadding="0" class="signTable_td"><col width="30" /><col width="70" /><col width="" />';
				boardContent3 += '</table>';
                
				$.each(result, function(index, value){	
					
					var address = value.ctprvnNm+' '+value.signguNm+' ';
					
					if(searchList=='1'){  // 일반 주소
						address = address +	value.emdNm;										
						if(value.liBuldNm!=null)		address = address +' '+ value.liBuldNm ;										
						if(value.lnbrDongHo!=null)		address = address +' '+ value.lnbrDongHo ;
						
					}else{ // 도로명 주소 
						address = address +	value.rdmn +' '+ value.bdnbrMnnm;
						if(value.bdnbrSlno!=null)		address = address +'-'+ value.bdnbrSlno ;
						if(value.buldNm!=null)			address = address +' '+ value.buldNm ;
						if(value.detailBuldNm!=null)	address = address +' '+ value.detailBuldNm ;
					}

					boardContent2 += '<tr><td align="center"><span>'+index+'</span></td><td align="center"><span>'+value.zip.substring(0,3) +'-'+ value.zip.substring(3,6)+'</span></td><td><a href="javascript:;" onclick=\'zipObj.setAddress("'+value.zip+'" , "'+ address+'")\'>'+address+'</a></td></tr>';
					
/* 					boardContent += '<li>';			
					boardContent += '<a href="javascript:;" '; 
					boardContent += 'onclick=\'zipObj.setAddress("'+value.zip+'" , "'+ address+'")\'>'; 
					boardContent += '<span>'+index+'</span>';  
					boardContent += '<span>'+value.zip.substring(0,3) +'-'+ value.zip.substring(3,6)+'</span>';  
					boardContent += address+'</a>';  
					boardContent += '</li>'; */
					
				});
				
				
				if(boardContent2=="")
				{
					//boardContent ='<li><spring:message code="common.nodata.msg" /></li>';// 데이터가 존재하지 않습니다.
					boardContent2 ='<tr><td align="center" colspan="3"><spring:message code="common.nodata.msg" /></td></tr>';// 데이터가 존재하지 않습니다.
				}
				//boardContent = '<ul>'+boardContent+'</ul>';	
				boardContent = boardContent1 + boardContent2+boardContent3;
				$("#postalcode_table").html(boardContent);	
			}
		}
	});
	// 검색(최초) 시에만 팝업창 리사이즈
	if(!zipObj.isResize){
		zipObj.windowsResizeFunction();
	}
	
};

</script>
	
    <div class="popupWarp" id="pop_area">
        <div class="popHead clearfx">
              <h1><spring:message code='system.zipCode.search' /></h1>
              <a href="javascript:window.close();" class="close"><img src="<c:url value='/images/popup/btn_close.gif'/>" width="60" height="27" alt="닫기" /></a>
        </div>  
	
	    <div class="popContents clearfx">
		      <h2 class="f11"><img src="<c:url value='/images/common/title_arrow.gif'/>" width="3" height="5" alt="" /> 찾으시려는 동(읍/리/면)을 입력해 주세요. (예:구의동)</h2>
		      <p class="graybgBox mT10">
		           <select name="searchList" id="searchList" class="text-pad"> 
                        <option value='1'><spring:message code='system.zipCode.address' /></option>
                        <option value='2'><spring:message code='system.zipCode.road.address' /></option>
                   </select> <input type="text"  name="searchKeyword" id="searchKeyword"  style="width:180px;" onfocus="this.className='input_focus'; if ( this.value == '예:구의동' ) this.value='';"   onblur="if ( this.value == '' ) { this.className='input_blur'; this.value='예:구의동'; }"  class="input_blur" maxlength="25" title="" value="예:구의동"/> 
                    <a href="#" class=" defaultBtn" onclick="zipObj.search(); return false;"><span><strong>검색</strong></span></a>
               </p>
		       <div class="select_sign" style="height:270px; margin-top:20px;">
        	       <table width="100%" border="0" cellspacing="0" cellpadding="0" class="signTable_th">
        	          <col width="30" />
                      <col width="70" />
                      <col width="" />
                      <tr>
                         <td>순번</td>
                         <td>우편번호</td>
                         <td>주소</td>
                      </tr>
                    </table>
                    <div class="select_sign_con" style="height:240px;" id="postalcode_table">
                    </div>
               </div>
	
         </div>
      </div>

<!-- 
<iframe name="ifcal" src="<c:url value='/sym/ccm/zip/EgovCcmZipSearchList.do'/>" style="width:500px; height:435px;" frameborder=0></iframe>
 -->
<!-- IE 
<iframe name="ifcal" src="<c:url value='/sym/ccm/zip/EgovCcmZipSearchList.do'/>" style="width:500px; height:325px;" frameborder=0></iframe>
 -->
<!-- FIREFOX 
<iframe name="ifcal" src="<c:url value='/sym/ccm/zip/EgovCcmZipSearchList.do'/>" style="width:700px; height:340px;" frameborder=0 title="우편번호팝업창호출"></iframe>
-->
