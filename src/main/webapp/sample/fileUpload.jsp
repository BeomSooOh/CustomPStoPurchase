<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"  %>
    
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="../css/kendoui/kendo.common.min.css" />
    <link rel="stylesheet" href="../css/kendoui/kendo.default.min.css" />

    <script src="../js/kendoui/jquery.min.js"></script>
    <script src="../js/kendoui/kendo.all.min.js"></script>
    <script>
	    function onSuccess(e) {
			if (e.operation == "upload") {
				var groupSeq = $("#groupSeq").val();
				var empSeq = $("#empSeq").val();
				var fileId = e.response.fileId;
				var fileSn = e.response.fileSn;
				if (fileId != null && fileId != '') { 
					var html = '';
					html += "<div style='float:left;padding-left:20px'>";
					html += "<a href='/gw/cmm/file/attachFileDownloadProc.do?fileId="+fileId+"&fileSn="+fileSn+"&groupSeq="+groupSeq+"'>다운로드("+fileId+"/"+fileSn+")</a>";
					html += " <a href='/gw/cmm/file/attachFileDelProc.do?fileId="+fileId+"&fileSn="+fileSn+"&empSeq="+empSeq+"'>삭제("+fileId+"/"+fileSn+")</a>";
					html += "<p><img src='/gw/cmm/file/attachFileDownloadProc.do?fileId="+fileId+"&fileSn="+fileSn+"&groupSeq="+groupSeq+"' width='150px' height='150px' /></p>";
					html += "</div>";
					$("#imgContainer").append(html); 
				} else { 
					alert(e.response);
				}
				
			}
		}  
    </script>
</head> 
<body>

		<h2>Kendo Upload 샘플</h2>
        <div id="example">
            <div style="width:50%;float:left">
            	<h4>Single 업로드</h4>
            	<ul id="fieldlist">  
            		<li> 
            			<label for="groupSeq">groupSeq</label>
	                    <input class="k-textbox" id="groupSeq" name="groupSeq" value="1" />
	                </li>
            		 
            		<li>
            			<label for="empSeq">empSeq</label>
	                    <input class="k-textbox" id="empSeq" name="empSeq" value="12222" />
	                </li>
            		
            		<li> 
            			<label for="pathSeq">pathSeq</label>
	                    <input class="k-textbox" id="pathSeq" name="pathSeq" value="900" />0 : 기본경로, 100 : 전자결재 영리, 200 : 전자결재 비영리, 300 : 업무관리, 400 : 일정, 500 : 게시판, 600 : 문서, 700 : 메일, 800 : 메신저, 900 : 이미지, 1000 : 노트
	                </li>
            		
            		<li>
            			<label for="relativePath">relativePath</label>
	                    <input class="k-textbox" id="relativePath" name="relativePath" value="/photo" />
	                </li>
	                
	                <li>
            			<label for="dataType">dataType</label>
	                    <input class="k-textbox" id="dataType" name="dataType" value="json" />
	                </li>
	                
	                <li>
            			<label for="fileId">fileId(파일 추가시 입력)</label>
	                    <input class="k-textbox" id="fileId" name="fileId" value="" />
	                </li>
	                
	                <li>
            			<label for="fileSn">fileSn(파일 변경시 입력)</label>
	                    <input class="k-textbox" id="fileSn" name="fileSn" value="" />
	                </li>
            		
            	</ul>

	            <div>
	                <div class="demo-section k-header">
	                    <input name="files" id="files" type="file" />
	                </div>
	            </div>
	            
	            <div id="imgContainer"></div>
            </div> 
            <div style="width:50%;float:left">
            <h4>Multi 업로드</h4>
            	<iframe src="fileUploadMulti.jsp" width="100%" height="1000px" frameborder="0" scrolling="yes"></iframe>
            </div>
                
              

            <script>
                $(document).ready(function() {
                    $("#files").kendoUpload({
                        async: {
                        	saveUrl: '/gw/cmm/file/attachFileUploadProc.do',
                            autoUpload: true
                        },
                        showFileList: false,
                        upload:function(e) { 
                        	var groupSeq = $("#groupSeq").val();
							var empSeq = $("#empSeq").val();
							var dataType = $("#dataType").val();
							var pathSeq = $("#pathSeq").val();
							var relativePath = $("#relativePath").val();
							var fileId = $("#fileId").val();
							var fileSn = $("#fileSn").val();
							
							var params = "groupSeq=" + groupSeq;
							params += "&empSeq=" + empSeq;
							params += "&dataType=" + dataType;
							params += "&pathSeq=" + pathSeq;
							params += "&relativePath=" + relativePath;
							params += "&fileId=" + fileId;
							params += "&fileSn=" + fileSn;
							
                        	e.sender.options.async.saveUrl = '/gw/cmm/file/attachFileUploadProc.do?'+params;
                        },
                        success: onSuccess 
                    });
                });
                
                
            </script>
            
            <style>
                #fieldlist {
                    margin: 0;
                    padding: 0;
                }

                #fieldlist li {
                    list-style: none;
                    padding-bottom: .7em;
                    text-align: left;
                }

                #fieldlist label {
                    display: block;
                    padding-bottom: .3em;
                    font-weight: bold;
                    font-size: 12px;
                    color: #444; 
                }

                #fieldlist li.status {
                    text-align: center;
                }

                #fieldlist li .k-widget:not(.k-tooltip),
                #fieldlist li .k-textbox {
                    margin: 0 5px 5px 0;
                }
                
            </style>
        </div>


</body>
</html>
