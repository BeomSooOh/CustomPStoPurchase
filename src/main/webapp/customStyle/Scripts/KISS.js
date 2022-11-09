/**************************************************
   KISS.js
**************************************************/

$(document).ready(function() {
	setTimeout(function(){
		pjperMotion();//프로젝트 퍼센트 모션
		task_posi();//task 단 체크
		scroll_hei();//스크롤 높이
		pjTableOnScrollChk();//프로젝트 테이블 스크롤 체크
		task_set_btn();//업무 버튼보일 시 width값설정
		task_mxWid();//업무 텍스트 maxwidth값 설정
		tsLayerClose()
	},16);//setTimeout으로 딜레이를 주는 이유는 최초 로드시 width/height 값을 제대로 못가져오는 오류를 방지하기 위함.
	
	$(window).resize(function(){
		pjperMotion();//프로젝트 퍼센트 모션
		task_posi();//task 단 체크
		scroll_hei();//스크롤 높이
		pjTableOnScrollChk();//프로젝트 테이블 스크롤 체크
		task_set_btn();//업무 버튼보일 시 width값설정
		task_mxWid();//업무 텍스트 maxwidth값 설정
		tsLayerClose()
	});
	
	//공통 터치모션
	var el = [".condi",".pic_div",".project_more",".btn_more"]; //모션이 필요한 요소를 추가
	
	for(var i = 0 ; i < el.length ;  i++){
		$(el[i]).on("click",function(e){
			e.preventDefault();
			var This = $(this);
			This.addClass("animated05s zoomInBig");
			setTimeout(function(){This.removeClass("animated05s zoomInBig")},500);
		});
	};
	
	//즐겨찾기 모션
	$(".star").on("click",function(e){
		e.preventDefault();
		var This = $(this);
	
		if(!This.hasClass("on")){
			This.addClass("on animated05s zoomInBig");
			setTimeout(function(){This.removeClass("animated05s zoomInBig")},500);
		}else {
			This.removeClass("on").addClass("animated05s zoomInBig");
			setTimeout(function(){This.removeClass("on animated05s zoomInBig")},500);
		};
	});
	
	//프로젝트 퍼센트 모션
	function pjperMotion(){
		var perVal = new Array("86", "80", "60", "0", "90", "75", "85", "0", "60", "100", "90", "80");
		var bar = $(".task_box1 .bar");
		var per = $(".task_box1 .per");

		//퍼센트 바 모션
		$.each( bar, function( index ) {
			$(".task_box1 .bar").attr("style","");
			setTimeout(function(){
				bar.eq(index).css("width",perVal[index]+"%");
			},500);
		});

    	// 퍼센트 숫자 자동증가
		// ex)  autoIncrementVal( obj, val, durationVal );
		$.each( per, function( index ) {
			autoIncrementVal( per.eq(index) , perVal[index], 1000 );
			function autoIncrementVal (obj, val, durationVal){
				$({someValue: 0}).animate({someValue: val}, {
					duration: durationVal,
					easing:'swing',
					step: function() {
						$(obj).html( Math.ceil(this.someValue) + '<span class="dan">%</span>' );
					}
				});
			};
		});
	};
	
	//태스크 퍼센트 모션
	function tsperMotion(){
		var perVal = new Array("25", "100", "50", "0", "0", "100", "100", "100", "100", "100", "100", "100");
		var txtVal = new Array("진행", "완료", "진행", "대기", "대기", "완료", "완료", "완료", "완료", "완료", "완료", "완료");
		var corVal = new Array("col2", "col4", "col2", "col1", "col1", "col4", "col4", "col4", "col4", "col4", "col4", "col4");
		var bar = $(".task_box2 .bar");
		var per = $(".task_box2 .per");

		//퍼센트 바 모션
		$.each( bar, function( index ) {
			$(".task_box2 .bar").attr("style","");
			setTimeout(function(){
				bar.eq(index).css("width",perVal[index]+"%");
			},500);
			bar.eq(index).parent().parent().removeClass().addClass("progress_div " + corVal[index]);
			bar.eq(index).parent().parent().siblings(".pro_condi").removeClass().addClass("pro_condi " + corVal[index]).text(txtVal[index]);
		});

    	// 퍼센트 숫자 자동증가
		// ex)  autoIncrementVal( obj, val, durationVal );
		$.each( per, function( index ) {
			autoIncrementVal( per.eq(index) , perVal[index], 1000 );
			function autoIncrementVal (obj, val, durationVal){
				$({someValue: 0}).animate({someValue: val}, {
					duration: durationVal,
					easing:'swing',
					step: function() {
						$(obj).html( Math.ceil(this.someValue) + '<span class="dan">%</span>' );
					}
				});
			};
		});

		//$(".task_tit .ico_chk").removeClass("on");//임시해제 실데이타 사용시 제거
		//$(".task_div").removeClass("complete");//임시해제 실데이타 사용시 제거
	};
	
	//1단 가기
	$(".mypro").on("click",function(e){
		e.preventDefault();

		$(".task_con").addClass("task_set1");
		$(".task_con").removeClass("task_set2");
		$(".task_con").removeClass("task_set3");
		$(".project_ta tr").removeClass("on");
		task_posi();
		task_mxWid();
		pjperMotion();
		close_pop();
	});
	
	//1단에서 2단가기
	$(".project_div .tit").on("click",function(e){
		e.preventDefault();

		$(".task_con").addClass("task_set2");
		$(".task_con").removeClass("task_set1");
		$(".task_con").removeClass("task_set3");
		$(".project_ta.ta_body tr").removeClass("on animated05s zoomIn");
		$(".project_div .tit").css({"float":"none","display":"inline-block"});
		$(this).parent().parent().parent().addClass("on animated05s zoomIn");

		setTimeout(function(){
			$(".project_div .tit").css({"float":"left","display":""});
			$(".project_ta.ta_body tr").removeClass("animated05s zoomIn");
		},500);

		task_posi();
		task_mxWid();
		task_set_btn();
		tsperMotion();
		close_pop();
	});
	
	//2단에서 3단가기
	$(".task_div .txt_div").on("click",function(e){
		e.preventDefault();

		$(".task_con").addClass("task_set3");
		$(".task_con").removeClass("task_set1");
		$(".task_con").removeClass("task_set2");
		$(".task_div").removeClass("on");
		$(this).parent().parent().parent().addClass("on");
		$(".ts_detail_in").hide();
		$(".task_dtl").css("width","")

		setTimeout(function(){
			$(".ts_detail_in").show().addClass("animated03s fadeInRight");
			$(".reply_texta").hide();
			setTimeout(function(){
				$(".ts_detail_in").removeClass("animated03s fadeInRight");
				setTimeout(function(){
					$(".reply_texta").show().addClass("animated05s fadeInUp");
					setTimeout(function(){
						$(".reply_texta").removeClass("animated05s fadeInUp");
					},500);
				},500);
			},300);
		},300);

		task_posi();
		task_mxWid();
		task_set_btn();
		close_pop();
	});
	
	//업무더보기 버튼 보기
    $(".task_btn .btn_more").on("click",function(e){
		e.preventDefault();

		$(".task_div").removeClass("set_on");
		$(this).parent().parent().parent().addClass("set_on");
		task_set_btn();
    });

    //업무더보기 버튼 닫기
	$(".task_dtl").on("click",function(e){
		e.preventDefault();

		if($(this).parent().parent().hasClass("set_on")){
        	$(this).parent().parent().removeClass("set_on");
	        $(this).next().find("btn_set").css("display","none");
	        $(this).next().find("btn_more").css("display","block");
	        $(".task_dtl").css("width","");
		}
    });
	
	//2단 업무 체크/언체크
	$(".task_tit .ico_chk input[type='checkbox']").on("click",function(e){
		e.preventDefault();

		var This = $(this).parent().parent();

		if($(this).parent().find("input:checkbox").is(":checked")){
			This.addClass("on");//체크모션

			setTimeout(function(){
				This.parents(".task_div").addClass("complete animated1s bounce");//업무완료 모션
				This.parent().siblings(".task_dtl").find(".progress_div").removeClass().addClass("progress_div col4");
				This.parent().siblings(".task_dtl").find(".pro_condi").removeClass().addClass("pro_condi col4 animated1s rotateIn").text("완료");
				setTimeout(function(){
					This.parents(".task_div").removeClass("animated1s bounce");//업무완료 모션해제
					This.parent().siblings(".task_dtl").find(".pro_condi").removeClass("animated1s rotateIn");
				},1000);
			},1000);

			//업무완료 퍼센트/숫자 모션
			This.parent().siblings(".task_dtl").find(".bar").css("width","100%");

			autoIncrementVal( This.parent().siblings(".task_dtl").find(".per") , 100, 1000 );

			function autoIncrementVal (obj, val, durationVal){
				$({someValue: 0}).animate({someValue: val}, {
					duration: durationVal,
					easing:'swing',
					step: function() {
						$(obj).html( Math.ceil(this.someValue) + '<span class="dan">%</span>' );
					}
				});
			};

		}else{

			This.removeClass("on");//언체크 모션

			setTimeout(function(){
				This.parents(".task_div").removeClass("complete").addClass("animated1s fadeIn");
				This.parent().siblings(".task_dtl").find(".progress_div").removeClass().addClass("progress_div col1");
				This.parent().siblings(".task_dtl").find(".pro_condi").removeClass().addClass("pro_condi col1 animated1s rotateIn").text("대기");
				setTimeout(function(){
					This.parents(".task_div").removeClass("animated1s fadeIn");
					This.parent().siblings(".task_dtl").find(".pro_condi").removeClass("animated1s rotateIn");
				},1000);
			},1000);

			//업무완료 퍼센트/숫자 모션해제
			This.parent().siblings(".task_dtl").find(".bar").css("width","0");
			This.parent().siblings(".task_dtl").find(".per").html('0 <span class="dan">%</span>' );
		};
    });
	
	//팝업 메뉴 공통 모션
    $(".pop_menu").on("click",function(e){
    	e.preventDefault();

		var This = $(this);

		This.addClass("on animated05s zoomIn");
		setTimeout(function(){This.removeClass("on animated05s zoomIn")},1000);
		setTimeout(close_pop,500);
    });

    //프로젝트 더보기메뉴 팝업
    $(".task_box1 .btn_more").on("click",function(e){
    	e.preventDefault();

    	var posi = $(this).offset();
    	var posiTop = posi.top;
    	var posiLeft = posi.left;
    	var boxHeight = $(".task_box1").height();
    	var popHeight = $(".task_box1 .pop_wrapper").height();
    	var posiPopHeight = (popHeight + posiTop);
    	var editHeight = (posiPopHeight - boxHeight);

    	$(".task_box1 .pop_wrapper .semo").css({"visibility":"hidden"});

    	//팝업의 위치 지정
    	if(posiPopHeight > boxHeight){
    		$(".task_box1 .pop_wrapper").css({"top":(posiTop-((editHeight/2)+50))+"px","left":(posiLeft-183)+"px"}).show().addClass("animated05s fadeInRight");
    		setTimeout(function(){
    			$(".task_box1 .pop_wrapper .semo").css({"top":(posiTop+17)+"px","left":(posiLeft)+"px","visibility":""}).addClass("animated05s fadeIn");
    			setTimeout(function(){
    				$(".task_box1 .pop_wrapper .semo").removeClass("animated05s fadeIn")
    			},500);
			},500);
    	}else{
    		$(".task_box1 .pop_wrapper").css({"top":(posiTop)+"px","left":(posiLeft-183)+"px"}).show().addClass("animated05s fadeInRight");
    		setTimeout(function(){
    			$(".task_box1 .pop_wrapper .semo").css({"top":(posiTop+17)+"px","left":(posiLeft)+"px","visibility":""}).addClass("animated05s fadeIn");
    			setTimeout(function(){
    				$(".task_box1 .pop_wrapper .semo").removeClass("animated05s fadeIn")
    			},500);
			},500);
    	};

    	setTimeout(function(){$(".task_box1 .pop_wrapper").removeClass("animated05s fadeInRight")},500);
    });
    
    //프로젝트 중요도 팝업
    $(".project_div .condi").on("click",function(e){
    	e.preventDefault();

    	var posi = $(this).offset();
    	var posiTop = posi.top;
    	var posiLeft = posi.left;
    	var boxHeight = $(".task_box1").height();
    	var popHeight = $(".pop_time_core").height();
    	var posiPopHeight = (popHeight + posiTop);
    	var editHeight = (posiPopHeight - boxHeight);
    	
    	$(".pop_time_core .semo").css({"visibility":"hidden"});
    	
    	//팝업의 위치 지정
    	if(posiPopHeight > boxHeight){
    		$(".pop_time_core").css({"top":(posiTop-((editHeight/2)+20))+"px","left":(posiLeft+82)+"px"}).show().addClass("animated05s fadeInLeft");
    		setTimeout(function(){
    			$(".pop_time_core .semo").css({"top":(posiTop+12)+"px","left":(posiLeft+69)+"px","visibility":""}).addClass("animated05s fadeIn");
    			setTimeout(function(){
    				$(".pop_time_core .semo").removeClass("animated05s fadeIn")
    			},500);
			},500);
    	}else{
    		$(".pop_time_core").css({"top":(posiTop)+"px","left":(posiLeft+82)+"px"}).show().addClass("animated05s fadeInLeft");
    		setTimeout(function(){
    			$(".pop_time_core .semo").css({"top":(posiTop+12)+"px","left":(posiLeft+69)+"px","visibility":""}).addClass("animated05s fadeIn");
    			setTimeout(function(){
    				$(".pop_time_core .semo").removeClass("animated05s fadeIn")
    			},500);
			},500);
    	};

    	setTimeout(function(){$(".pop_time_core").removeClass("animated05s fadeInLeft")},500);

		//중요도 상태전달
		var This = $(this);
		var ThisCls = $(this).attr("class");
		var ThisIdx = $(".project_div .condi").index(this);

		$(".pop_time_core .btnbox").removeClass("on animated05s zoomIn");

		setTimeout(function(){
			if(This.hasClass("colT")){//즉시
				$(".pop_time_core .btnbox.colT").addClass("on animated05s zoomIn");
				setTimeout(function(){$(".pop_time_core .btnbox.colT").removeClass("animated05s zoomIn")},500);
			}else if(This.hasClass("colCT")){//긴급
				$(".pop_time_core .btnbox.colCT").addClass("on animated05s zoomIn");
				setTimeout(function(){$(".pop_time_core .btnbox.colCT").removeClass("animated05s zoomIn")},500);
			}else if(This.hasClass("colC")){//중요
				$(".pop_time_core .btnbox.colC").addClass("on animated05s zoomIn");
				setTimeout(function(){$(".pop_time_core .btnbox.colC").removeClass("animated05s zoomIn")},500);
			}else if(This.hasClass("colE")){//일반
				$(".pop_time_core .btnbox.colE").addClass("on animated05s zoomIn");
				setTimeout(function(){$(".pop_time_core .btnbox.colE").removeClass("animated05s zoomIn")},500);
			};
		},500);

		$(".project_div .condi").removeClass("t");
		$(".project_div .condi").eq(ThisIdx).addClass("t");
	});


    //중요도 팝업에서 선택
    $(".pop_time_core .btnbox").on("click",function(e){
    	e.preventDefault();

    	var This = $(this);
		var ThisCls = $(this).attr("class");

		$(".pop_time_core .btnbox").removeClass("on");
		This.addClass("on animated05s bounceIn");
		setTimeout(function(){
			This.removeClass("animated05s bounceIn");
			close_pop();
		},500);

    	if(This.hasClass("colT")){//즉시
			$(".condi.t").removeClass("t colE colC colT colCT").addClass("colT").text("즉시");
		}else if(This.hasClass("colCT")){//긴급
			$(".condi.t").removeClass("t colE colC colT colCT").addClass("colCT").text("긴급");
		}else if(This.hasClass("colC")){//중요
			$(".condi.t").removeClass("t colE colC colT colCT").addClass("colC").text("중요");
		}else if(This.hasClass("colE")){//일반
			$(".condi.t").removeClass("t colE colC colT colCT").addClass("colE").text("일반");
		};
	});


    //업무상세 더보기메뉴 팝업
    $(".ts_btn .btn_more").on("click",function(e){
    	$(".task_box3 .pop_wrapper").show().addClass("animated05s fadeInUp");
    	setTimeout(function(){$(".task_box3 .pop_wrapper").removeClass("animated05s fadeInUp")},500);
    });
    
    //스크롤시 터치이벤트 차단
	$(".scroll_div").scroll(function(e){
		e.preventDefault();
		e.stopPropagation();
		close_pop();
	});
	
	//업무상세 스크롤 퍼센트 조작 (단위값 구현 필요)
	$('#dragBar').draggable({
		axis: "x",
		containment: "parent",
	    drag: function(){
	        var This = $(this);
	        var offset = This.position();
	        var w = This.parent().width();
	        var xPos = offset.left;
	        Xpercent = Math.ceil(xPos / (w-20) * 100);
	    	This.parent().find(".bar").css({"width":Math.ceil(Xpercent)+"%","transition":"all ease"});
	    	This.parent().siblings(".per").html( Math.ceil(Xpercent) + '<span class="dan">%</span>' );
	    }
	    //,stop: function( event, ui ) {}
	});
	
	//태스트 등록 값에 따라 박스표현
	$(".add_set input[type='text']").focusin(function(){
		$(".focus-border").addClass("on");
	}).focusout(function(){
		if( $(this).val() == "" ){
			$(".focus-border").removeClass("on");
		}
	})

});//document ready

/*//////////////////////////////////////////////////////////////////////////////////////////////////*/

//task 단 체크
function task_posi(){
	var wrapWid = $(".KISS_wrap").width();
	var taskBox1Wid = 278; //1단 가로사이즈
	var taskBox3Wid = 345; //3단 가로사이즈

	if($(".task_con").hasClass("task_set1")){
		
		$(".task_box1").width(wrapWid-30);
		$(".task_box2").width(0);
		$(".task_box3").width(0);
		$(".project_ta tr th:first-child").css("padding-left","");
		$(".project_ta tr td").not(":first-child").not(":last-child").css({"width":"0"});
		$(".project_ta tr th").not(":first-child").not(":last-child").css({"width":"0"});
		$(".project_ta colgroup col").not(":first-child").not(":last-child").css({"width":"0"});
		$(".project_ta tr th").not(":first-child").not(":last-child").children().hide();
		$(".project_ta tr td").not(":first-child").not(":last-child").children().hide();

		setTimeout(function(){
			$(".project_ta tr th:first-child").css("padding-left","");
			$(".project_ta tr td").not(":first-child").not(":last-child").css({"width":"","visibility":""});
			$(".project_ta tr th").not(":first-child").not(":last-child").css({"width":"","visibility":""});
			$(".project_ta colgroup col").not(":first-child").not(":last-child").css({"width":"","visibility":""});
			$(".project_ta tr th").not(":first-child").not(":last-child").children().show();
			$(".project_ta tr td").not(":first-child").not(":last-child").children().show();	
		},300);

		$(".task_div").removeClass("set_on");
		$(".pjAdd").css("display","block");
		$(".taskG1").css("display","block");
		$(".taskG2").css("display","none");

		setTimeout(function(){
			var pjWid = $(".project_div").width();
			$(".project_div .tit").css({"width":(pjWid-100)+"px"});
		},300);
		
		scroll_hei();
		
	}else if($(".task_con").hasClass("task_set2")) {
		
		$(".task_box1").width(taskBox1Wid);
		$(".task_box2").width(wrapWid-45-taskBox1Wid);
		$(".task_box3").width(0);
		$(".project_ta tr th:first-child").css("padding-left","23px");
		$(".project_ta tr td").not(":first-child").not(":last-child").css({"width":"0","visibility":"hidden"});
		$(".project_ta tr th").not(":first-child").not(":last-child").css({"width":"0","visibility":"hidden"});
		$(".project_ta colgroup col").not(":first-child").not(":last-child").css({"width":"0","visibility":"hidden"});
		$(".project_ta tr th").not(":first-child").not(":last-child").children().hide();
		$(".project_ta tr td").not(":first-child").not(":last-child").children().hide();
		$(".task_btn").css("display","block");
		$(".pjAdd").css("display","none");
		$(".taskG1").css("display","none");
		$(".taskG2").css("display","block");		
		$(".task_dtl").addClass("animated03s fadeInRight");
		
		setTimeout(function(){
			var pjWid = $(".project_div").width();
			$(".project_div .tit").css({"width":(pjWid-100)+"px"});
			$(".task_dtl").removeClass("animated03s fadeInRight");
		},300);
		
		scroll_hei();
		
    }else if($(".task_con").hasClass("task_set3")) {
		
		$(".task_box1").width(taskBox1Wid);
		$(".task_box2").width(wrapWid-45-taskBox1Wid-taskBox3Wid);
		$(".task_box3").width(taskBox3Wid);
		$(".task_btn").css("display","none");
		$(".task_div").removeClass("set_on");
		$(".pjAdd").css("display","none");
		$(".taskG1").css("display","none");
		$(".taskG2").css("display","block");
		
		scroll_hei();
    };
};

//업무 텍스트 maxwidth값 설정
function task_mxWid(){
	setTimeout(function(){
		var taskWid = $(".task_list").width();
		if($(".task_con").hasClass("task_set3")){
			$("ul .task_div .txt_div .tit, ul .task_div .txt_div .dat").css("width",taskWid-225);
			$("ul ul .task_div .txt_div .tit, ul ul .task_div .txt_div .dat").css("width",taskWid-225-20);
			$("ul ul ul .task_div .txt_div .tit, ul ul ul .task_div .txt_div .dat").css("width",taskWid-225-40);
		}else{
			$("ul .task_div .txt_div .tit, ul .task_div .txt_div .dat").css("width",taskWid-570);
			$("ul ul .task_div .txt_div .tit, ul ul .task_div .txt_div .dat").css("width",taskWid-570-20);
			$("ul ul ul .task_div .txt_div .tit, ul ul ul .task_div .txt_div .dat").css("width",taskWid-570-40);
		}
	},300);
};

//업무 버튼보일 시 width값설정
function task_set_btn(){ 
	var taskWid = $(".task_list").width();
	$("ul .task_div.set_on .task_dtl").width(taskWid-110);
	$("ul ul .task_div.set_on .task_dtl").width(taskWid-185);
	$("ul ul ul .task_div.set_on .task_dtl").width(taskWid-150);
}


//스크롤 높이
function scroll_hei(){
	var wrapHei =$(".KISS_wrap").height();
	var searchHei =$(".searchBox").height();
	$(".task_box1 .scroll_div").height((wrapHei-(searchHei+14))-101);
	$(".task_box2 .scroll_div").height((wrapHei-(searchHei+14))-134);
	$(".task_box3 .scroll_div").height((wrapHei-(searchHei+14))-257);
	$(".ts_detail").height((wrapHei-(searchHei+14))-70);
}

//더보기 팝업 종료
function close_pop(){
	$(".semo").css({"visibility":"hidden"});

	if($(".task_con").hasClass("task_set1")){
		$(".pop_wrapper").addClass("animated05s fadeOutRight");
		$(".pop_time_core").addClass("animated05s fadeOutLeft");
		setTimeout(function(){
			$(".pop_wrapper").hide().removeClass("animated05s fadeOutRight");
			$(".pop_time_core").hide().removeClass("animated05s fadeOutLeft");
			$(".semo").css({"visibility":""});
		},500);
	}else{
		$(".task_box1 .pop_wrapper, .task_box1  .pop_time_core").addClass("animated05s fadeOutLeft");
		$(".task_box3 .pop_wrapper").addClass("animated05s fadeOutDown");
		setTimeout(function(){
			$(".pop_wrapper, .pop_time_core").hide().removeClass("animated05s fadeOutLeft fadeOutRight fadeOutDown");
			$(".semo").css({"visibility":""});
		},500);
	};
};

//커스텀상세 클로즈
function tsLayerClose(){
	$(".ts_layer .btn_clo").on("click",function(e){
		e.preventDefault();
		$(".ts_layer").removeClass("on").css({"left":"100%"});
		$(".dim").addClass("animated05s fadeOut");
		setTimeout(function(){
			$(".dim").hide().removeClass("animated05s fadeOut");
		},500);
	});

	$(".ts_detail .btn_clo").on("click",function(e){
		e.preventDefault();

		if($(".ts_layer").hasClass("on")){
			$(".ts_layer").removeClass("on").css({"left":"100%"});
			$(".dim").addClass("animated05s fadeOut");
			setTimeout(function(){
				$(".dim").hide().removeClass("animated05s fadeOut");
				$(".task_con").addClass("task_set2");
				$(".task_con").removeClass("task_set1");
				$(".task_con").removeClass("task_set3");
				task_posi();
				task_mxWid();
				task_set_btn();
				close_pop();
			},200);
		}else{
			e.preventDefault();

			$(".task_con").addClass("task_set2");
			$(".task_con").removeClass("task_set1");
			$(".task_con").removeClass("task_set3");
			task_posi();
			task_mxWid();
			task_set_btn();
			close_pop();
		};
	});
};

//프로젝트 테이블 스크롤 체크
function pjTableOnScrollChk(){
	var tableHeader =$(".ta_head > table").outerWidth(true);
	var tableBody =$(".ta_body > table").outerWidth(true);
	
	$(".project_ta.ta_head").css("padding-right",Math.round(tableHeader-tableBody)+"px")
}