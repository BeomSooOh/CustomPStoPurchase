<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<script>
	function compInfoSave() {
		var formData = $("#basicForm").serialize();
		$.ajax({
			type:"post",
			url:"compInfoSaveProc.do",
			datatype:"text",
			data: formData,
			success:function(data){
				alert(data.result);
			},			
			error : function(e){	//error : function(xhr, status, error) {
				alert("error");	
			}
		});	
	}
		
	function stampSave() {
		var formData = $("#stampImgForm").serialize();
		$.ajax({
			type:"post",
			url:"compInfoSaveProc.do",
			datatype:"text",
			data: formData,
			success:function(data){
				alert(data.result);
			},			
			error : function(e){	//error : function(xhr, status, error) {
				alert("error");	
			}
		});	
	}
		
	function langSave() {
		var formData = $("#langForm").serialize();
		$.ajax({
			type:"post",
			url:"compLangSaveProc.do",
			datatype:"text",
			data: formData,
			success:function(data){
				alert(data.result);
			},			
			error : function(e){	//error : function(xhr, status, error) {
				alert("error");	
			}
		});	
	}
</script>




	<div class="demo-section2 k-header">
		<div id="tabstrip">
              <ul>
                  <li class="k-state-active">
                      기본정보
                  </li>
                  <li>
                      인감정보
                  </li>
                  <li>
                      접속정보
                  </li>
                  <li>
                      다국어
                  </li>
              </ul>
			
			<div>
				<form id="basicForm" name="basicForm">
				 <input id="parentCompSeq" name="parentCompSeq" value="${compMap.parentCompSeq}" type="hidden" />
				 <input id="orderNum" name="orderNum" value="${compMap.orderNum}" type="hidden" />
				 <input id="groupSeq" name="groupSeq" value="${compMap.groupSeq}" type="hidden" />
				
				
                <h4>회사기본정보 </h4>
                <ul id="fieldlist">
                    <li>
                        <label for="compSeq">회사코드</label>
                        <input id="compSeq" name="compSeq" value="${compMap.compSeq}" type="hidden" /> ${compMap.compSeq}
                    </li> 
                    <li>
                        <label for="useYn">사용여부</label>
                        <input type="radio" id="useYn" name="useYn" value="Y" checked />사용 <input type="radio" id="useYn" value="N" <c:if test="${compMap.useYn == 'N'}">checked</c:if> />미사용
                    </li>  
                        <label for="compName">회사명</label>
                        <input id="compName" name="compName" value="${compMultiMap.compName}" />
                    </li>
                    <li>
                        <label for="ownerName">대표자명</label>
                        <input id="ownerName" name="ownerName" value="${compMultiMap.ownerName}" />
                    </li>
                    <li>
                        <label for="standardCode">정부기준코드</label>
                        <input id="standardCode" name="standardCode" value="${compMap.standardCode}" /> 
                    </li>
                    <li>
                        <label for="compRegistNum">사업자번호</label>
                        <input id="compRegistNum" name="compRegistNum" value="${compMap.compRegistNum}" /> 
                    </li>
                    <li>
                        <label for="compNum">법인번호</label>
                        <input id="compNum" name="compNum" value="${compMap.compNum}" /> 
                    </li>
                    <li>
                        <label for="bizCondition">업태</label>
                        <input id="bizCondition" name="bizCondition" value="${compMultiMap.bizCondition}" />
                    </li>
                     <li>
                        <label for="item">종목</label>
                        <input id="item" name="item" value="${compMultiMap.item}" />
                    </li>
                    <li> 
                        <label for="telNum">대표전화</label>
                        <input id="telNum" name="telNum" value="${compMap.telNum}" />
                    </li>
                    <li> 
                        <label for="faxNum">대표팩스</label>
                        <input id="faxNum" name="faxNum" value="${compMap.faxNum}" />
                    </li>
                    <li>
                        <label for="zipCode">회사주소</label>
                    	<input id="zipCode" name="zipCode" value="${compMap.zipCode}" /> <button id="findZip" class="saveBtn">찾기</button>
                        <p><input id="addr" name="addr" value="${compMultiMap.addr}" /></p>
                        <p><input id="detailAddr" name="detailAddr" value="${compMultiMap.detailAddr}" /></p>
                    </li> 
                    <li>
                        <label for="emailAddr">대표 이메일</label>
						<input id="emailAddr" name="emailAddr" value="${compMap.emailAddr}" />
                    </li>
                    <li>
                        <label for="homepgAddr">홈페이지주소</label>
                        <input id="homepgAddr" name="homepgAddr" value="${compMap.homepgAddr}" />
                    </li>
                    <li>
                        <label for="emailDomain">메일 도메인</label>
                        <input id="emailDomain" name="emailDomain" value="${compMap.emailDomain}" />
                    </li>
                   
                </ul>
                
                <h4>ERP / SMS 연동</h4>
                <ul id="fieldlist">
                	<%-- <li>
                        <label for=""></label>
                        <input id="" value="${compMap.}" />
                    </li>
                     <li>
                        <label for=""></label>
                        <input id="" value="${compMap.}" />
                    </li> --%>
                </ul>
                
                </form>
                <p style="text-align:center">
	              		<button id="saveCompInfoBtn" class="saveBtn">저장</button>
	            </p>
                
            </div>
            
            <div>
            	<h4>회사인감정보 </h4>
                <div id="sidebar">
	                <div id="profile" class="widget">
	                    <h3>법인인감</h3>
	                    <div>
	                    	<div>
	                    		<img src="<c:url value='/cmm/file/attachFileDownloadProc.do?fileId=${imgMap.IMG_COMP_STAMP2.fileId}&fileSn=0' />" width="71" height="71" />
				                <div class="demo-section k-header">
				                    <input name="IMG_COMP_STAMP1" class="file_stemp" type="file" />
				                    <input id="IMG_COMP_STAMP1" type="hidden" value="${imgMap.IMG_COMP_STAMP1.imgSeq}" />
				                </div>
				            </div>
	                    </div>
	                    
	                    <h3>사용인감</h3>
	                    <div>
	                        <img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_COMP_STAMP2.path}&fileName=${imgMap.IMG_COMP_STAMP2.imgFileName}' />" width="71" height="71" />
	                        <div class="demo-section k-header">
				                    <input name="IMG_COMP_STAMP2" class="file_stemp" type="file" />
				                    <input id="IMG_COMP_STAMP2" type="hidden" value="${imgMap.IMG_COMP_STAMP2.imgSeq}" />
				            </div>
	                    </div>
	                     
	                    <h3>회사직인</h3>
	                    <div>
	                        <img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_COMP_STAMP3.path}&fileName=${imgMap.IMG_COMP_STAMP3.imgFileName}' />" width="71" height="71" />
	                        <div class="demo-section k-header">
				                    <input name="IMG_COMP_STAMP3" class="file_stemp" type="file" />
				                    <input id="IMG_COMP_STAMP3" type="hidden" value="${imgMap.IMG_COMP_STAMP3.imgSeq}" />
				                </div>
	                    </div>
	                    
	                    <h3>회사발신명의</h3>
	                    <div>
	                        <img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_COMP_STAMP4.path}&fileName=${imgMap.IMG_COMP_STAMP4.imgFileName}' />" width="71" height="71" />
	                        <div class="demo-section k-header">
				                    <input name="IMG_COMP_STAMP4" class="file_stemp" type="file" />
				                    <input id="IMG_COMP_STAMP4" type="hidden" value="${imgMap.IMG_COMP_STAMP4.imgSeq}" />
				            </div>
				            <div>
				            	<form id="stampImgForm" name="stampImgForm">
				            		<input name="compSeq" value="${compMap.compSeq}" type="hidden" />
				            		<input name="senderName" value="${compMultiMap.senderName}" />
				            	</form>
				            </div>
	                    </div>
	                </div>
	                
	                <p style="text-align:center">
	              		<button id="saveStampImgBtn" class="saveBtn">저장</button>
	            	</p>
                </div> 
                <%-- <ul id="fieldlist">
                	<li>
                        <label for="">법인인감</label>
                        <input id="" value="${compMap.}" />
                    </li>
                     <li>
                        <label for=""></label>
                        <input id="" value="${compMap.}" />
                    </li>
                    <li>
                        <label for=""></label>
                        <input id="" value="${compMap.}" />
                    </li>
                </ul> --%>
            </div>
            
            <!-- 회사접속정보 탭 시작 -->
            
            <div>
            	<h4>회사접속정보 </h4>
                <ul id="fieldlist">
                    <li>
                        <label for="compDomain">도메인</label>
                        <input id="compDomain" name="compDomain" value="${compMap.compDomain}" />
                    </li> 
                    <li>
                        <label for="compDisplayName">타이틀명</label>
                        <input id="compDisplayName" name="compDisplayName" value="${compMultiMap.compDisplayName}" />
                    </li>  
                </ul>
                
                <h4>회사로그인 설정 </h4>
                <div>
	                <div>
	                	A타입 로그인로고
	                	<div class="demo-section k-header">
				        	<input name="IMG_COMP_LOGIN_LOGO_A" class="file_stamp" type="file" />
				            <input id="IMG_COMP_LOGIN_LOGO_A" type="hidden" value="${imgMap.IMG_COMP_LOGIN_LOGO_A.imgSeq}" />
				        </div>
		            	<img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_COMP_LOGIN_LOGO_A.path}&fileName=${imgMap.IMG_COMP_LOGIN_LOGO_A.imgFileName}' />" width="71" height="71" />
	                </div>
	                <div>
	                	A타입 로그인배너
	                	<div class="demo-section k-header">
				        	<input name="IMG_COMP_LOGIN_BANNER_A" class="file_stamp" type="file" />
				            <input id="IMG_COMP_LOGIN_BANNER_A" type="hidden" value="${imgMap.IMG_COMP_LOGIN_BANNER_A.imgSeq}" />
				        </div>
		            	<img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_COMP_LOGIN_BANNER_A.path}&fileName=${imgMap.IMG_COMP_LOGIN_BANNER_A.imgFileName}' />" width="71" height="71" />
	                </div> 
                </div>	
                <div>
	                <div>
	                	B타입 로그인로고
	                	<div class="demo-section k-header">
				        	<input name="IMG_COMP_LOGIN_LOGO_B" class="file_stamp" type="file" />
				            <input id="IMG_COMP_LOGIN_LOGO_B" type="hidden" value="${imgMap.IMG_COMP_LOGIN_LOGO_B.imgSeq}" />
				        </div>
		            	<img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_COMP_LOGIN_LOGO_B.path}&fileName=${imgMap.IMG_COMP_LOGIN_LOGO_B.imgFileName}' />" width="71" height="71" />
	                </div>
	                <div>
	                	B타입 로그인배경
	                	<div class="demo-section k-header">
				        	<input name="IMG_COMP_LOGIN_BG_B" class="file_stamp" type="file" />
				            <input id="IMG_COMP_LOGIN_BG_B" type="hidden" value="${imgMap.IMG_COMP_LOGIN_BG_B.imgSeq}" />
				        </div>
		            	<img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_COMP_LOGIN_BG_B.path}&fileName=${imgMap.IMG_COMP_LOGIN_BG_B.imgFileName}' />" width="71" height="71" />
	                </div> 
                </div>	
                <div>
	                <div>
	                	상단로고
	                	<div class="demo-section k-header">
				        	<input name="IMG_COMP_LOGO" class="file_stamp" type="file" />
				            <input id="IMG_COMP_LOGO" type="hidden" value="${imgMap.IMG_COMP_LOGO.imgSeq}" />
				        </div>
		            	<img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_COMP_LOGO.path}&fileName=${imgMap.IMG_COMP_LOGO.imgFileName}' />" width="71" height="71" />
	                </div>
	                <div>
	                	푸터
	                	<div class="demo-section k-header">
				        	<input name="IMG_COMP_FOOTER" class="file_stamp" type="file" />
				            <input id="IMG_COMP_FOOTER" type="hidden" value="${imgMap.IMG_COMP_FOOTER.imgSeq}" />
				        </div>
		            	<img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_COMP_FOOTER.path}&fileName=${imgMap.IMG_COMP_FOOTER.imgFileName}' />" width="71" height="71" />
	                </div> 
                </div>	
            </div>
            
            <!-- 회사접속정보 탭 끝 -->
            
            
            <!-- 다국어 탭 시작 -->
            <div>
            	<form id="langForm" name="langForm">
            		<input id="compSeq" name="compSeq" value="${compMap.compSeq}" type="hidden" />
            		<div id="grid"></div>
            	</form>
            	<p style="text-align:center">
	              		<button id="saveLangBtn" class="saveBtn">저장</button>
	            </p>
            
            </div>
            <!-- 다국어 탭 끝 -->    
                
    </div>
            

            <script>
                $(document).ready(function() {
                        $("#tabstrip").kendoTabStrip({
                            animation:  {
                                open: {
                                    effects: "fadeIn"
                                }
                            }
                        });
                        
                        
                        $(".file_stemp").kendoUpload({
                        async: {
                        	saveUrl: '/gw/cmm/file/fileUploadProc.do',
                            autoUpload: true
                        },
                        showFileList: false,
                        upload:function(e) { 
							var dataType = 'json';
							var pathSeq = '0090';
							var relativePath = '/stamp';
							
							var params = "dataType=" + dataType;
							params += "&pathSeq=" + pathSeq;
							params += "&relativePath=" + relativePath;
							
                        	e.sender.options.async.saveUrl = '/gw/cmm/file/fileUploadProc.do?'+params;
                        },
                        success: onSuccess 
                    });
                        
                        
                    function onSuccess(e) {
						if (e.operation == "upload") {
							var fileId = e.response.fileId;
							if (fileId != null && fileId != '') {
								
								var inputName =  $(e.sender).attr("name");
								var img_seq = $('#'+inputName).val();
								var comp_seq = '${compMap.compSeq}';
								
								$.ajax({
									type:"post",
									url:"/gw/cmm/systemx/orgUploadImage.do",
									datatype:"text",
									data: {imgSeq:imgSeq,orgSeq:comp_seq,fileId : fileId},
									success:function(data){
										alert(data.result);
									},			
									error : function(e){	//error : function(xhr, status, error) {
										alert("error");	
									}
								});	
								
								
							} else {
								alert(e.response);
							}
							
						}
					}  
                        
						
                       /*  $(".file_stemp").kendoUpload({
                            async: {
                                saveUrl: '<c:url value="/cmm/systemx/orgUploadImage.do" />',
                                removeUrl: '<c:url value="/cmm/systemx/compRemoveImage.do" />',
                                autoUpload: true
                            },
                            multiple: false,
                            upload:function(e) {
								var inputName =  $(e.sender).attr("name");
								var img_seq = $('#'+inputName).val();
								var comp_seq = '${compMap.compSeq}';
                            	e.sender.options.async.saveUrl = '<c:url value="/cmm/systemx/orgUploadImage.do" />'+"?imgSeq=" + img_seq+"&orgSeq="+comp_seq;
                            }

                        }); */

                        $("#zip_code").kendoMaskedTextBox({
                            mask: "000-000"
                        });
                        
                        
                        var dataSource = new kendo.data.DataSource({
                        	data: ${langList},
                            batch: true,
                            schema: {
                                model: {
                                    id: "detailCode",
                                    fields: {
                                    	detailName: { editable: false, nullable: true },
                                    	mainYn: { editable: false, nullable: true },
                                    	subYn: { editable: true, nullable: true}
                                    }
                                }
                            }
                        });

                    $("#grid").kendoGrid({
                        dataSource: dataSource,
                        pageable: false,
                        columns: [ 
                            { field: "detailName", title: "다국어", width: "150px"},
                            { field: "mainYn", title:"주사용언어", width: "100px", template: '<input type="radio" name="mainYn" #= mainYn=="Y" ? checked="checked" : "" # value="#=detailCode#"/> '},
                            { field: "subYn", title:"서브사용언어", width: "100px", template: '<input type="checkbox" name="subYn" #= subYn=="Y" ? checked="checked" : "" # value="#=detailCode#" />'}],  
                        editable: "inline",
                        refresh:true
                        /* ,
                        selectable:"row",
                        change: function(e) { 
                        	var selectedDataItem = e != null ? e.sender.dataItem(e.sender.select()) : null;
                          } */

                    });
                });
                
                function onClick(e) {
                	var id = $(e.event.target).attr("id");
                	
                	if (id == 'saveCompInfoBtn') {
                		compInfoSave();
                	} else if(id == 'saveStampImgBtn') {
                		stampSave();
                	} else if(id == 'saveLangBtn') {
                		langSave();
                	}
                }
                
                $(".saveBtn").kendoButton({
            	    click: onClick
            	});
            </script>

            <style>
                .demo-section2 {
                    width: 500px;
                } 

                #fieldlist
                {
                    margin:0;
                    padding:0;
                } 

                #fieldlist li
                {
                    list-style:none;
                    padding:10px 0;
                }

                #fieldlist label {
                    display: inline-block; 
                    width: 150px;
                    margin-right: 5px;
                    text-align: right;
                }
                
                
            </style>
        </div>

