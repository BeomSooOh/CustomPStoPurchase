<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
		
<html>
    <head>
        <title> title </title>
        <script>
            $(document).ready(function() {
                
            });

            function fnSelect(){
            	$.ajax({
					type : 'post',
					url : '/exp/practice/selectReportPage.do',
					datatype : 'json',
					async : false,
					data : {},
					success : function(result) {
						setGrid(result.menu);
					},
					error : function(result) {
					}
				}); 
            }
            
            function setGrid(data){
                for(var idx in data){
                    var htmlCode = '<tr>';
                    for(var key in data[idx]){
                        htmlCode += '<td>'
                        htmlCode += data[idx][key];
                        htmlCode += '</td>';
                    }
                    htmlCode += '</tr>'

                    $('tbody').append(htmlCode);
                }

            }
        </script>
    </head>
    <body>
        <h1>건담 리스트</h1>
        <div>
            <span> 등급 </span>
            <input type="text" value="" id="gradeText"> 
            <span> 이름 </span>
            <input type="text" value="" id="nameText"> 
            <span> 가격 </span>
            <input type="text" value="" id="fromPriceText"> 
            ~
            <input type="text" value="" id="toPriceText2"> 
            <span> 평점 </span>
            <input type="text" value="" id="ratingText"> 
            <input type="button" onClick='fnSelect()' value="조회"></input>
        </div>
        <table style="border: 1px solid;">
            <thead >
                <tr>
                    <th>
                        가격
                    </th>
                    <th>
                        구분
                    </th>
                    <th>
                        메뉴
                    </th>
                    <th>
                        작성자
                    </th>
                    <th>
                        칼로리
                    </th>
                </tr>
            </thead>
            <tbody>
               
            </tbody>

        </table>
    </body>    
</html>