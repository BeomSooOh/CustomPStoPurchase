/* Bizbox Alpha 회계모듈 전용 그리드 컴포넌트. */
/* # 기능정의 */
/*   - 입력 그리드 (엑셀형) */

(function ($) {
	var classes = {
		/* main div class 정의 */
		mainDiv: 'cus_ta_ea scbg posi_re',
		/* header left scroll class 정의 */
		scrollCover: 'scy_head1',
		/* header div class 정의 */
		rightHeaderDiv: 'cus_ta_ea ovh mr17 scbg ta_bl',
		/* content div class 정의 */
		rightContentDiv: 'cus_ta_ea rowHeight scroll_y_fix rightContents scbg ta_bl',
		/* 행선택시 반영 class 정의 */
		rowOn: 'rowOn',
		colOn: 'cen colOn highLight',
		spanOn: 'highLightIn'
	};

	var methods = {
		init: function (options) {
			/* ================================================== */
			/*
			$('#div').extable({
				columns: [{
					title: '품의구분',
					display: 'Y',
					displayKey: '',
					colKey: 'a',
					width: '20%',
					reqYN: 'Y',
					align: 'center'
				}, {
					title: '품의일자',
					display: 'Y',
					displayKey: '',
					colKey: 'b',
					width: '20%',
					reqYN: 'Y',
					align: 'center'
				}, {
					title: '품의내역',
					display: 'Y',
					displayKey: '',
					colKey: 'c',
					width: '40%',
					reqYN: 'N',
					align: 'center'
				}, {
					title: '금액',
					display: 'Y',
					displayKey: '',
					colKey: 'd',
					width: '20%',
					reqYN: 'N',
					align: 'center'
				}],
				datas: [{
					a: '품의구분1',
					b: '품의일자1',
					c: '품의내역1',
					d: '금액1'
				}, {
					a: '품의구분2',
					b: '품의일자2',
					c: '품의내역2',
					d: '금액2'
				}, {
					a: '품의구분3',
					b: '품의일자3',
					c: '품의내역3',
					d: '금액3'
				}],
				height: 135,
				rowClickBeforeCallback: function () {},
				rowClickAfterCallback: function () {},
				rowChangeBeforeCallback: function () {},
				rowChangeAfterCallback: function () {},
				colClickBeforeCallback: function () {},
				colClickAfterCallback: function () {},
				addBeforeCallback: function () {},
				addAfterCallback: function () {},
				removeBeforeCallback: function () {},
				removeAfterCallback: function () {},
				helpMessageCallback: function () {}
			});
			*/
			/* ================================================== */
			/* init : 옵션정의 */
			/* ================================================== */
			var defaults = {
				/* 자동 생성 */
				/* 그리드에서 columns을 기초로 자동 생성합니다. 타이틀 정보를 배열로 가집니다. */
				titles: [],
				/* 그리드에서 columns을 기초로 자동 생성합니다. 화면상 표현 여부 정보를 배열로 가집니다. */
				displays: [],
				/* 그리드에서 columns을 기초로 자동 생성합니다. 나타낼 문저열 조합의 정보를 배열로 가집니다. 구분자는 "▥" 를 사용합니다. */
				displayKeys: [],
				/* 그리드에서 columns을 기초로 자동 생성합니다. json 키 값 정보를 배열로 가집니다. */
				colKeys: [],
				/* 그리드에서 columns을 기초로 자동 생성합니다. 너비 정보를 배열로 가집니다. */
				widths: [],
				/* 그리드에서 columns을 기초로 자동 생성합니다. 필수 입력 정보를 배열로 가집니다. */
				reqYNs: [],
				/* 그리드에서 columns을 기초로 자동 생성합니다. 정렬 정보를 배열로 가집니다. */
				aligns: [],
				/* datas와 동기화 됩니다. datas는 json으로, arrayDatas는 배열로 정보를 저장합니다. */
				arrayDatas: [],
				/* y의 크기를 자동으로 저장합니다. */
				rowSize: 0,
				/* x의 크기를 자동으로 저장합니다. */
				colSize: 0,
				/* 현재 선택된 셀의 위치(x, y)를 저장합니다. */
				selectIdx: [0, 0],
				/* 본문 내용 테이블의 jquery selector를 저장합니다. */
				contentTable: null,
				/* 사용자 정의 */
				columns: [],
				datas: [],
				height: 135,
				rowClickBeforeCallback: function () {
					return true;
				},
				rowClickAfterCallback: function () {},
				rowChangeBeforeCallback: function () {
					return true;
				},
				rowChangeAfterCallback: function () {},
				colClickBeforeCallback: function () {
					return true;
				},
				colClickAfterCallback: function () {},
				addBeforeCallback: function () {
					return true;
				},
				addAfterCallback: function () {},
				removeBeforeCallback: function () {
					return true;
				},
				removeAfterCallback: function () {},
				helpMessageCallback: function () {
					return true;
				}
			};
			var defaultsColumns = {
				title: '',
				display: '',
				displayKey: '',
				colKey: '',
				width: '100',
				reqYN: 'N',
				align: 'center'
			};
			/* ================================================== */
			/* 자동생성 데이터 정의 */
			var options = $.extend(defaults, options);
			$.each(options.columns, function (idx, column) {
				column = $.extend(defaultsColumns, column);
				options.titles[idx] = (column.title || '');
				options.displays[idx] = (column.display || '');
				options.displayKeys[idx] = (column.displayKey || '');
				options.colKeys[idx] = (column.colKey || '');
				options.widths[idx] = (column.width || '');
				options.reqYNs[idx] = (column.reqYN || '');
				options.aligns[idx] = (column.align || '');
			});
			/* ================================================== */
			/* json 데이터 배열로 변환 */
			$.each(options.datas, function (idx, data) {
				var tempData = [];
				$.each(options.colKeys, function (keyIdx, key) {
					tempData[keyIdx] = data[key];
				});
				options.arrayDatas.push(tempData);
			});
			/* ================================================== */
			/* 테이블 크기, 셀 위치 정의 */
			options.rowSize = options.datas.length;
			options.colSize = options.colKeys.length;
			$.each(options.displays, function (idx, display) {
				if ((display || '').toString().toUpperCase() === 'Y') {
					options.selectIdx = [idx, 0];
					return false;
				}
			});
			options.selectIdx = [options.selectIdx[0], (options.rowSize > 0 ? options.rowSize - 1 : options.rowSize)];
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			/* 테이블 생성 */
			var createTable = function () {
				/* ==================================================================================================== */
				/* 기존 정의된 테이블 및 이벤트 초기화 */
				main.contents().unbind().remove();
				/* ==================================================================================================== */
				if (!$.fn.extable.options) {
					$.fn.extable.options = [];
				} else {
					$.fn.extable.options[id] = [];
				}
				$.fn.extable.options[id] = options;
				/* ==================================================================================================== */
				main.extable('render');
				/* ==================================================================================================== */
			}
			/* ================================================== */
			createTable();
			/* ================================================== */
			return;
			/* ================================================== */
		},
		render: function () {
			/* ================================================== */
			/* 테이블 생성 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			/* main element 점검 */
			if (!(main[0].tagName.toString().toUpperCase() === 'DIV')) {
				$.error('DIV가 선택되지 않았습니다.');
				return;
			}
			/* ================================================== */
			/* main element class 지정 */
			if (!main.hasClass(classes.mainDiv)) {
				main.addClass(classes.mainDiv);
			}
			/* ================================================== */
			/* scrollCovert 정의 및 class 지정 */
			var scrollCover;
			scrollCover = document.createElement('span');
			$(scrollCover).addClass(classes.scrollCover);
			/* ================================================== */
			/* right header div 정의 및 class 지정 */
			var rightHeaderDiv;
			rightHeaderDiv = document.createElement('div');
			$(rightHeaderDiv).addClass(classes.rightHeaderDiv);
			/* ================================================== */
			/* right header table 정의 및 class 지정 */
			var rightHeaderTable;
			rightHeaderTable = document.createElement('table');
			/* ==================================================================================================== */
			/* right header colgroup 정의 및 class 지정 */
			var headerColGroup = '';
			$.each($.fn.extable.options[id].widths, function (idx, item) {
				headerColGroup += '<col width="' + item + '"/>';
			});
			$(rightHeaderTable).append('<colgroup>' + headerColGroup + '</colgroup>');
			/* ==================================================================================================== */
			/* right header th 정의 및 class 지정 */
			var th = '';
			$.each($.fn.extable.options[id].titles, function (idx, item) {
				if ($.fn.extable.options[id].reqYNs[idx].toString().toUpperCase() === 'Y') {
					th += '<th><img src="../../../Images/ico/ico_check01.png" alt="" />&nbsp;' + item + '</th>';
				} else {
					th += '<th>' + item + '</th>';
				}
			});
			$(rightHeaderTable).append('<tr>' + th + '</tr>');
			/* ==================================================================================================== */
			/* right header 정의 */
			$(rightHeaderDiv).append(rightHeaderTable);
			/* ================================================== */
			/* right content div 정의 및 class 지정 */
			var rightHeaderContent;
			rightHeaderContent = document.createElement('div');
			$(rightHeaderContent).addClass(classes.rightContentDiv);
			if ($.fn.extable.options[id].height) {
				$(rightHeaderContent).css('height', $.fn.extable.options[id].height);
			}
			/* ================================================== */
			/* right content table 정의 */
			var rightContentTable;
			rightContentTable = document.createElement('table');
			/* ==================================================================================================== */
			/* right content colgroup 정의 및 class 지정 */
			var contentColGroup = '';
			$.each($.fn.extable.options[id].widths, function (idx, item) {
				contentColGroup += '<col width="' + item + '"/>';
			});
			$(rightContentTable).append('<colgroup>' + contentColGroup + '</colgroup>');
			/* ==================================================================================================== */
			/* right content tr & td 정의 및 class 지정 */
			$.each($.fn.extable.options[id].arrayDatas, function (rowIdx, items) {
				var tr = document.createElement('tr');
				$.each(items, function (colIdx, item) {
					var displayKey = ($.fn.extable.options[id].displayKeys[colIdx] || '');
					var td = document.createElement('td');
					if (displayKey !== '') {
						$(td).addClass($.fn.extable.options[id].aligns[colIdx]);
						var dispValue = '';
						$.each(displayKey.split('▥'), function (itemIdx, itemKey) {
							dispValue += $.fn.extable.options[id].arrayDatas[rowIdx][$.fn.extable.options[id].colKeys.indexOf[itemKey]];
						});
						$(td).append(dispValue);
					} else {
						$(td).append(item);
					}

					$(tr).append(td);

					$(td).click(function (event) {
						if ($.fn.extable.options[id].selectIdx[0] === $(this).index() &&
							$.fn.extable.options[id].selectIdx[1] === $(this).parent().index()) {
							/* 기존 선택과 같다면 이벤트 진행하지 않고 종료한다. */
							return false;
						}
						if (!main.extable('commonCallback', 'colClickBeforeCallback')) {
							return false;
						}
						$.fn.extable.options[id].selectIdx = [$(this).index(), $(this).parent().index()];
						main.extable('colClickEvent');
						main.extable('commonCallback', 'colClickAfterCallback');
						return false;
					});
				});

				$(tr).click(function () {
					if (!main.extable('commonCallback', 'rowClickBeforeCallback')) {
						return false;
					}
					main.extable('commonCallback', 'rowClickAfterCallback');
					return false;
				});

				$(rightContentTable).append(tr);
			});
			/* ==================================================================================================== */
			/* right content 정의 */
			$(rightHeaderContent).append(rightContentTable);
			/* ================================================== */
			/* right content 저장 */
			$.fn.extable.options[id].contentTable = $(rightContentTable);
			/* ================================================== */
			/* ex table 완성 */
			main.append(scrollCover);
			main.append(rightHeaderDiv);
			main.append(rightHeaderContent);
			/* ================================================== */
			return;
			/* ================================================== */
		},
		addRow: function (data) {
			/* ================================================== */
			/* 행추가 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			/* 행추가 전 callback ( 반환값 true인 경우 진행 ) */
			if (!main.extable('commonCallback', 'addBeforeCallback')) {
				return;
			}
			/* ================================================== */
			/* data 기본값 정의 */
			data = (data || {});
			if (Object.keys(data).length === 0) {
				$.each($.fn.extable.options[id].colKeys, function (idx, key) {
					data[key] = '';
				});
			} else {
				$.each($.fn.extable.options[id].colKeys, function (idx, key) {
					if (!data[key]) {
						data[key] = '';
					}
				});
			}
			/* ================================================== */
			/* data 추가 */
			main.extable('addData', data);
			/* ================================================== */
			/* row draw */
			main.extable('drawRow', ($.fn.extable.options[id].rowSize - 1));
			/* ================================================== */
			/* 행 추가 완료 callback */
			main.extable('commonCallback', 'addAfterCallback');
			/* ================================================== */
			return;
			/* ================================================== */
		},
		addData: function (data) {
			/* ================================================== */
			/* 데이터 추가 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			var tempArrayData = [];
			var tempJsonData = [];
			/* ================================================== */
			/* json 및 array data 생성 */
			$.each($.fn.extable.options[id].colKeys, function (idx, key) {
				tempArrayData[idx] = data[key];
				tempJsonData[key] = data[key];
			});
			/* ================================================== */
			/* json 및 array data 저장 */
			$.fn.extable.options[id].arrayDatas.push(tempArrayData);
			$.fn.extable.options[id].datas.push(tempJsonData);
			/* ================================================== */
			/* table 크기 재계산 */
			$.fn.extable.options[id].rowSize = $.fn.extable.options[id].arrayDatas.length;
			/* ================================================== */
			return;
			/* ================================================== */
		},
		drawRow: function (rowIdx) {
			/* ================================================== */
			/* 행 추가 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			/* parameter 점검 */
			if (rowIdx === '' || rowIdx === undefined || isNaN(rowIdx)) {
				rowIdx = -1;
			}
			/* ================================================== */
			/* 비정상 parameter인 경우 반환 처리 진행 */
			if (rowIdx < 0) {
				return;
			}
			/* ================================================== */
			/* right content tr & td 정의 및 생성 */
			var tr = document.createElement('tr');
			$.each($.fn.extable.options[id].arrayDatas[rowIdx], function (colIdx, item) {
				var displayKey = ($.fn.extable.options[id].displayKeys[colIdx] || '');
				var td = document.createElement('td');
				if (displayKey !== '') {
					$(td).addClass($.fn.extable.options[id].aligns[colIdx]);
					var dispValue = '';
					$.each(displayKey.split('▥'), function (itemIdx, itemKey) {
						dispValue += $.fn.extable.options[id].arrayDatas[rowIdx][$.fn.extable.options[id].colKeys.indexOf[itemKey]];
					});
					$(td).append(dispValue);
				} else {
					$(td).append(item);
				}

				$(tr).append(td);

				$(td).click(function (event) {
					if ($.fn.extable.options[id].selectIdx[0] === $(this).index() &&
						$.fn.extable.options[id].selectIdx[1] === $(this).parent().index()) {
						/* 기존 선택과 같다면 이벤트 진행하지 않고 종료한다. */
						return false;
					}
					if (!main.extable('commonCallback', 'colClickBeforeCallback')) {
						return false;
					}
					$.fn.extable.options[id].selectIdx = [$(this).index(), $(this).parent().index()];
					main.extable('colClickEvent');
					main.extable('commonCallback', 'colClickAfterCallback');
					return false;
				});
			});

			$(tr).click(function () {
				if (!main.extable('commonCallback', 'rowClickBeforeCallback')) {
					return false;
				}
				main.extable('commonCallback', 'rowClickAfterCallback');
			})
			$.fn.extable.options[id].contentTable.append(tr);
			/* ================================================== */
			return;
			/* ================================================== */
		},
		removeRow: function (rowIdx) {
			/* ================================================== */
			/* 행삭제 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			/* 비정상 parameter인 경우 반환 처리 진행 */
			if (isNaN(rowIdx) || Number(rowIdx) < 0) {
				$.error('! rowIdx가 정상적으로 수신되지 않았습니다.');
				return;
			}
			/* ================================================== */
			/* 행 삭제 전 callback ( 반환값 true인 경우 정상 처리 ) */
			if (!main.extable('commonCallback', 'removeBeforeCallback')) {
				return;
			}
			/* ================================================== */
			/* data 삭제 */
			main.extable('removeData', rowIdx);
			/* ================================================== */
			/* tr 삭제 */
			main.extable('removeDrawRow', rowIdx);
			/* ================================================== */
			/* 행삭제 완료 callback */
			main.extable('commonCallback', 'removeAfterCallback');
			/* ================================================== */
			return;
			/* ================================================== */
		},
		removeData: function (rowIdx) {
			/* ================================================== */
			/* 데이터삭제 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			/* json 데이터 삭제 */
			$.fn.extable.options[id].datas.splice(rowIdx, 1);
			/* ================================================== */
			/* array 데이터 삭제 */
			$.fn.extable.options[id].arrayDatas.splice(rowIdx, 1);
			/* ================================================== */
			return;
			/* ================================================== */
		},
		removeDrawRow: function (rowIdx) {
			/* ================================================== */
			/* 행 삭제 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			/* right content tr 이벤트 해제 및 삭제 */
			$.fn.extable.options[id].contentTable.find('tr').eq(rowIdx).unbind().remove();
			/* ================================================== */
			return;
			/* ================================================== */
		},
		removeSelected: function () {
			/* ================================================== */
			/* 포커스 class 제거 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			/* input 제거 */
			main.extable('removeSelectedInput');
			/* ================================================== */
			/* 행선택시 반영 class 정의 */
			$.each(classes.spanOn.split(' '), function (idx, styleCls) {
				$.fn.extable.options[id].contentTable.find('.' + styleCls).removeClass(styleCls);
			});
			$.each(classes.colOn.split(' '), function (idx, styleCls) {
				if (styleCls === 'cen') {
					$.fn.extable.options[id].contentTable.find('td.' + styleCls).removeClass(styleCls);
				} else {
					$.fn.extable.options[id].contentTable.find('.' + styleCls).removeClass(styleCls);
				}
			});
			$.each(classes.rowOn.split(' '), function (idx, styleCls) {
				$.fn.extable.options[id].contentTable.find('.' + styleCls).removeClass(styleCls);
			});
		},
		removeSelectedInput: function () {
			/* ================================================== */
			/* input 제거 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			$.fn.extable.options[id].contentTable.find('span').unbind().remove();
			/* ================================================== */
			return;
			/* ================================================== */
		},
		addSelected: function () {
			/* ================================================== */
			/* 포커스 class 적용 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			var x = $.fn.extable.options[id].selectIdx[0];
			var y = $.fn.extable.options[id].selectIdx[1];
			/* ================================================== */
			$.fn.extable.options[id].contentTable.find('tr:eq(' + y + ')').addClass(classes.rowOn);
			$.fn.extable.options[id].contentTable.find('tr:eq(' + y + ') td:eq(' + x + ')').addClass(classes.colOn);
			$.fn.extable.options[id].contentTable.find('tr:eq(' + y + ') td:eq(' + x + ')').append('<span class="' + classes.spanOn + '"><input type="text" class="inpTextBox" value=""></span>');
		},
		colClickEvent: function () {
			/* ================================================== */
			/* Cell 선택 이벤트 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			main.extable('removeSelected');
			/* ================================================== */
			main.extable('addSelected');
			/* ================================================== */
			main.extable('setDefaultFocus');
			/* ================================================== */
			return;
			/* ================================================== */
		},
		setDefaultFocus: function () {
			/* ================================================== */
			/* 선택된 셀 포커스 지정 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			var x = $.fn.extable.options[id].selectIdx[0];
			var y = $.fn.extable.options[id].selectIdx[1];
			/* ================================================== */
			$.fn.extable.options[id].contentTable.find('tr:eq(' + y + ') td:eq(' + x + ') span input').focus();
			/* ================================================== */
			return;
			/* ================================================== */
		},
		commonCallback: function (type, paramValue) {
			console.log('commonCallback : ' + type);
			/* ================================================== */
			/* 공통콜백 */
			/* ================================================== */
			var id = ($(this).prop('id') || '');
			var main = $(this);
			/* ================================================== */
			type = (type || '');
			/* ==================================================================================================== */
			if ($.fn.extable.options[id][type]) {
				var parameters;
				switch (paramValue) {
					case 'row':
						/* 행정보 / 현재 선택된 셀정보 / 행데이터(json) / 행데이터(array) */
						paramValue = {};
						break;
					case 'col':
						/* 행정보 / 열정보 / 현재 선택된 셀정보 / 행데이터(json) / 행데이터(array) */
						paramValue = {};
						break;
					default:
						parameters = {};
						break;
				}
				if (typeof $.fn.extable.options[id][type] === 'string') {
					if (window[$.fn.extable.options[id][type]]) {
						return window[$.fn.extable.options[id][type]](parameters);
					}
				} else if (typeof $.fn.extable.options[id][type] === 'function') {
					return $.fn.extable.options[id][type](parameters);
				} else {
					$.error('! ' + type + '이 정의되지 않았습니다.');
				}
			}
			/* ==================================================================================================== */
			return false;
			/* ================================================== */
		}
	};

	$.fn.extable = function (method) {
		if (typeof method === 'object' || !method) {
			return methods.init.apply(this, arguments);
		} else if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else {
			$.error('! 존재하지 않는 기능입니다..');
		}
	};
})(jQuery)
