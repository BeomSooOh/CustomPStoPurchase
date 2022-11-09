/*
단순하게, tr 과 td 로 구성
td 의 위치에 맞춰 textarea 가 함꼐 이동하는 형태
textarea 는 설정된 옵션에 따르 별도 이벤트 수행
*/

/* using jquery.mask.js : https://igorescobar.github.io/jQuery-Mask-Plugin/ */
/* using jquery.mask.js : http://digitalbush.com/projects/masked-input-plugin/ */
(function ($) {
	var alpha = {
		table: {
			get: {},
			set: {
				create: 'tableSetCreate',
				vars: 'tableSetVars',
			}
		},
		tr: {
			get: {},
			set: {}
		},
		td: {
			get: {
				fixedWidth: 'tdGetFixedWidth'
			},
			set: {}
		},
		title: {
			get: {
				name: 'titleGetName',
				emptyName: 'titleGetEmptyName'
			},
			set: {
				/* header left render */
				left: 'titleSetLeft',
				/* header right render */
				right: 'titleSetRight',
				total: {
					/* header total render */
					render: 'titleSetTotal',
					/* header total refresh */
					reload: 'titleSetTotalReload'
				}
			}
		},
		row: {
			get: {
				jsonData: 'rowGetJsonData',
				index: 'rowGetIndex'
			},
			set: {
				add: {
					/* row render */
					render: 'rowSetAddRender',
					/* row data add */
					data: 'rowSetAddData'
				},
				remove: {
					render: '',
					/* row data remove */
					data: 'rowSetRemoveData'
				},
				select: {
					/* TODO: row first col first selected */
					first: '',
					/* row last col first selected */
					last: 'rowSetSelectLast',
					/* row index selected */
					index: 'rowSetSelectIndex'
				}
			}
		},
		col: {
			get: {
				data: 'colGetData'
			},
			set: {
				/* cell focus move */
				move: 'colSetMove',
				select: {
					/* col index selected */
					index: 'colSetSelectIndex',
					/* selected col set style */
					style: 'colSetSelectStyle',
					/* selected row & col reset */
					reset: 'colSetSelectReset'
				},
				value: 'colSetValue'
			}
		},
		input: {
			get: {},
			set: {
				focus: 'inputSetFocus'
			}
		},
		autocomplete: {
			get: {
				select: 'autocompleteGetSelect'
			},
			set: {}
		},
		vars: {
			elem: {
				input: {
					checkboxAll: '[checkbox_all]',
					checkbox: '[checkbox]',
				},
				string: {
					no: '[no]'
				},
				tags: {
					th: {
						start: '<th>',
						end: '</th>'
					},
					tr: {
						start: '<tr>',
						end: '</tr>'
					},
					span: {
						start: '<span style="display: inline-block; width: 100%;">',
						end: '</span>'
					}
				}
			},
			type: {
				default: 'text',
				text: 'text',
				checkbox: 'checkbox',
				hidden: 'hidden',
				date: 'date',
				autocomplete: 'autocomplete',
				codepop: 'codepop',
				number: 'number'
			},
			colAlignments: {
				default: 'cen',
				left: 'le',
				center: 'cen',
				right: 'ri'
			},
			colWidth: {
				default: 100
			},
			table: {
				title: {
					left: {
						id: function (id) {
							return '#' + id + '_' + alpha.vars.table.title.left.name;
						},
						name: 'lht'
					},
					right: {
						id: function (id) {
							return '#' + id + '_' + alpha.vars.table.title.right.name;
						},
						name: 'rht'
					}
				},
				content: {
					left: {
						id: function (id) {
							return '#' + id + '_' + alpha.vars.table.content.left.name;
						},
						name: 'lct'
					},
					right: {
						id: function (id) {
							return '#' + id + '_' + alpha.vars.table.content.right.name;
						},
						name: 'rct'
					}
				},
				class: {
					selected: {
						row: {
							selector: '.rowOn',
							string: 'rowOn'
						},
						col: {
							selector: '.colOn',
							string: 'colOn'
						},
						td: {
							selector: '.highLight',
							string: 'highLight'
						},
						div: {
							selector: '.highLightIn',
							string: 'highLightIn'
						}
					}
				},
			},
			multiRow: 'mr',
			zero: 0,
			offsetDefault: 25,
			focus: {}
		},
		fnc: {
			isLht: function (param) {
				return (param.indexOf(alpha.vars.table.title.left.name) > -1 ? true : false);
			},
			isRht: function (param) {
				return (param.indexOf(alpha.vars.table.title.right.name) > -1 ? true : false);
			},
			isLct: function (param) {
				return (param.indexOf(alpha.vars.table.content.left.name) > -1 ? true : false);
			},
			isRct: function (param) {
				return (param.indexOf(alpha.vars.table.content.right.name) > -1 ? true : false);
			},
			isMr: function (param) {
				return (param.indexOf(alpha.vars.multiRow) > -1 ? true : false);
			},
			num: function (value, defaultValue) {
				value = (value || '-');
				defaultValue = (defaultValue || alpha.vars.zero);
				return isNaN(Number(value.toString().replace(/,/g, ''))) ? defaultValue : Number(value.toString().replace(/,/g, ''));
			},
			selectRow: function (selectElem) {
				return alpha.fnc.num(selectElem.parent().index());
			},
			selectCol: function (selectElem) {
				return alpha.fnc.num(selectElem.prop('id').split('-')[1].toString());
			}
		}
	};
	var methods = {
		/* [+] ## init ######################################################################################################################################################################################################## */
		init: function (options) {
			/* 기본 파라미터 정의 */
			var defaults = {
				/* lht : 왼쪽 헤더 테이블 / rht : 오른쪽 헤더 테이블 / lct : 왼쪽 본문 테이블 / rct : 오른쪽 본문 테이블 / mr : 다중행 */
				/* 헤더의 경우 상단 고정되며, 왼쪽 테이블이 틀고정 됩니다. */
				/* ex : 'layout': ['lht', 'rht', 'lct', 'rct', 'mr'] */
				'layout': [],
				/* 헤더의 타이틀을 정의합니다. ( 전체 크기에 영향이 있습니다. ) */
				/* [no] : 행번호를 반환합니다. / [checkbox_all] : 체크박스를 반환합니다. / [checkbox] : 체크박스를 반환합니다. */
				/* ex : 'colHeaders': ['No', '[checkbox_all]', '차량', '운행일자', '운행구분', '출발시간', '출발지'] */
				'colHeaders': [],
				'colKeys': [], // TODO: 미구현
				/* 각 컬럼의 너비를 정의합니다. */
				/* colHeaders 와 lenth 가 동일해야 합니다. */
				/* ex : 'colWidth': [32, 34, 50, 50, 50, 50, 50] */
				'colWidth': [],
				/* 각 컬럼의 정렬을 정의합니다. */
				/* colHeaders 와 lenth 가 동일해야 합니다. */
				/* ex : 'colAlignments': ['cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen'] */
				'colAlignments': [],
				/* 각 컬럼의 표현 여부를 정의합니다. */
				/* colHeaders 와 lenth 가 동일해야 합니다. */
				/* ex : 'colDisplays': ['block', 'block', 'block', 'block', 'block', 'block', 'block'] */
				// 'colDisplays': [], // TODO: 미구현
				// 'colFormats': [], // TODO: 미구현
				/* lht, lct 의 너비를 정의합니다. */
				/* colLeftFixed 가 2인 경우, colHeaders[0], colHeaders[1] 이 고정으로 적용된다. */
				/* ex : 'colLeftFixed': 2 */
				'colLeftFixed': 0,
				// 'contextMenu': '', // TODO: 미구현
				/* 수정 가능여부를 정의합니다. */
				/* true 인 경우 수정 가능 / false 인 경우 수정 불가 */
				/* ex : 'editable': true */
				'editable': true, // TODO: 미구현
				'autoAdd': false,
				// 'columnSorting': false, // TODO: 미구현
				// 'columnResize': false, // TODO: 미구현
				'total': {
					title: '',
					colspan: [],
					sumCol: []
				},
				/* 바인딩 데이터 */
				/* 데이터는 배열로 전달 */
				/* ex : 'data': [['a', 'b', 'c', 'd', 'e', 'f', 'g'], ['a', 'b', 'c', 'd', 'e', 'f', 'g'], ['a', 'b', 'c', 'd', 'e', 'f', 'g'], ['a', 'b', 'c', 'd', 'e', 'f', 'g'], ['a', 'b', 'c', 'd', 'e', 'f', 'g']] */
				/* data[ { type: 'input', 'source': [], 'editor': { 'openEditor': function(){}, 'closeEditor': function(){} } } ] */
				'data': [], // 최초 바인딩 데이터
				/* 컬럼 타입 및 이벤트등 정의 */
				/* 앞으로 추가될 기능이 정의될 수 있음 */
				'columns': [] // TODO:
			};

			/* 수신된 파라미터와 기본 파라미터 통합 ( 기본 파라미터를 수신된 파라미터로 덮어쓰기 한다. ) */
			options = $.extend(defaults, options);
			var sourceResult = [];

			/* 엘리먼트 정보 정의 */
			var id = ($(this).prop('id') === undefined ? '' : $(this).prop('id'));
			options.id = id;
			var main = $(this);

			/* 기본값 정의 - layout */
			if (options.layout.indexOf(alpha.vars.table.content.right.name) < alpha.vars.zero) {
				options.layout.push(alpha.vars.table.content.right.name);
			}

			/* 크기 확인 - 행 */
			options.rowSize = alpha.vars.zero;
			if (options.data.length > options.rowSize) {
				options.rowSize = options.data.length;
			}
			/* 크기 확인 - 열 */
			options.colSize = options.colHeaders.length;
			if (options.data.length > alpha.vars.zero && options.data[alpha.vars.zero].length > options.colSize) {
				options.colSize = options.data[alpha.vars.zero].length;
			}
			/* 크기 확인 - 고정 열 */
			options.colLeftFixed = alpha.fnc.isLht(options.layout) ? options.colLeftFixed : alpha.vars.zero;

			/* 기본값 정의 */
			for (var c = alpha.vars.zero; c < options.colSize; c++) {
				/* 기본값 정의 - 타이틀 */
				if (!options.colHeaders[c]) {
					options.colHeaders[c] = $.fn.dtable(alpha.header.get.title, c);
				}

				/* 기본값 정의 - 컬럼 */
				if (!options.columns[c]) {
					if (!options.columns[c]) {
						options.columns[c] = {
							'type': alpha.vars.type.default
						};
					} else if (!options.columns[c].type) {
						options.columns[c].type = alpha.vars.type.default;
					}

					/* 기본값 정의 - 소스 */
					if (!options.columns[c].source) {
						options.columns[c].source = [];
					}

					/* 기본값 정의 - 옵션 */
					if (!options.columns[c].options) {
						options.columns[c].options = [];
					}

					/* 기본값 정의 - 에디터 */
					if (!options.columns[c].editor) {
						options.columns[c].editor = null;
					}

					/* 기본값 정의 - 드롭다운리스트 소스 확인 */
					if (options.columns[c].type == alpha.vars.type.autocomplete) {
						// TODO:
						if (options.columns[c].url !== '') {
							sourceResult.push(
								$.ajax({
									url: options.columns[c].url,
									index: c,
									success: function (result) {
										options.columns[c].source = (result.data || result);
									}
								}));
						}
					}
				}

				/* 기본값 정의 - 정렬 */
				if (!options.colAlignments[c]) {
					options.colAlignments[c] = alpha.vars.colAlignments.center;
				}

				/* 기본값 정의 - 너비 */
				if (!options.colWidth[c]) {
					options.colWidth[c] = alpha.vars.colWidth.default;
				}
			}

			/* 테이블 생성 */
			var createTable = function () {
				/* 기존 내역 초기화 */
				$('#' + id).contents().unbind().remove();
				/* 옵션 저장 */
				if (!$.fn.dtable.options) {
					$.fn.dtable.options = [];
				} else {
					$.fn.dtable.options[id] = [];
				}
				$.fn.dtable.options[id] = options;

				/* 히스토리 기록 >> TODO: 미구현 */
				$.fn.dtable.options[id].history = [];
				$.fn.dtable.options[id].historyIndex = -1;

				/* 데이터 초기화 */
				if (!options.data) {
					options.data = [];
				}

				/* 입력 데이터 확인 */
				if (!$.fn.dtable.options[id].data.length) {
					$.fn.dtable.options[id].data = [];
				}

				main.dtable(alpha.table.set.create);
			};

			// JSON 로드 후 테이블 생성
			if (sourceResult.length > alpha.vars.zero) {
				$.when.apply(this, sourceResult).done(function () {
					/* 테이블 생성 */
					createTable();
				});
			} else {
				/* 테이블 생성 */
				createTable();
			}

			return;
		},
		/* [-] ## init ######################################################################################################################################################################################################## */

		/* [+] ## table ######################################################################################################################################################################################################## */
		tableSetCreate: function () {
			/* 변수정의 */
			var options = $.fn.dtable.options[$(this).prop('id')];

			/* 테이블 레이아웃 정의 */
			var table = '';
			table += '<div class="cus_ta_ea">';
			table += '	<table>';
			table += '		<tr>';
			if (alpha.fnc.isLht(options.layout) || alpha.fnc.isLct(options.layout)) {
				table += '			<td width="' + $(this).dtable(alpha.td.get.fixedWidth) + '" class="p0 scbg brn" valign="top">';
				if (alpha.fnc.isLht(options.layout)) {
					table += '				<div class="cus_ta_ea ovh leftHeader ta_bl ta_br">';
					table += '					<table id="' + options.id + '_' + alpha.vars.table.title.left.name + '">';
					table += '					</table>';
					table += '				</div>';
				}
				if (alpha.fnc.isLct(options.layout)) {
					if (alpha.fnc.isMr(options.layout)) {
						table += '				<div class="cus_ta_ea rowHeight ovh leftContents scbg ta_bl ta_br" style="height: 81px;">';
					} else {
						table += '				<div class="cus_ta_ea rowHeight ovh leftContents scbg ta_bl ta_br">';
					}
					table += '					<table id="' + options.id + '_' + alpha.vars.table.content.left.name + '">';
					table += '					</table>';
					table += '				</div>';
				}
				table += '			</td>';
			}
			if (alpha.fnc.isRht(options.layout) || alpha.fnc.isRct(options.layout)) {
				table += '			<td width="*" class="p0 scbg posi_re brn" valign="top">';
				if (alpha.fnc.isMr(options.layout)) {
					table += '				<span class="' + (options.total.sumCol.length > alpha.vars.zero ? 'scy_head3' : 'scy_head1') + '"></span>';
				}
				if (alpha.fnc.isRht(options.layout)) {
					table += '				<div class="cus_ta_ea ovh mr17 rightHeader ta_bl">';
					table += '					<table id="' + options.id + '_' + alpha.vars.table.title.right.name + '">';
					table += '					</table>';
					table += '				</div>';
				}
				if (alpha.fnc.isRct(options.layout)) {
					if (alpha.fnc.isMr(options.layout)) {
						table += '				<div class="cus_ta_ea rowHeight scroll_fix rightContents scbg ta_bl" style="height: 98px;">';
					} else {
						table += '				<div class="cus_ta_ea rowHeight scroll_fix rightContents scbg ta_bl">';
					}
					table += '					<table id="' + options.id + '_' + alpha.vars.table.content.right.name + '">';
					table += '					</table>';
					table += '				</div>';
				}
				table += '			</td>';
			}
			table += '		</tr>';
			table += '	</table>';
			table += '	<div id="divAutoComplete" class="posi_ab"></div>';
			table += '</div>';
			$(this).append(table);

			/* 테이블 변수 정의 */
			$(this).dtable(alpha.table.set.vars);

			/* 테이블 제목 정의 - lht */
			$(this).dtable(alpha.title.set.left);

			/* 테이블 제목 정의 - rht */
			$(this).dtable(alpha.title.set.right);

			/* 테이블 제목 정의 - total */
			$(this).dtable(alpha.title.set.total.render);

			/* 테이블 스크롤 이벤트 등록 */
			options.rct.parent().scroll(function (e) {
				options.rht.parent().scrollLeft($(this).scrollLeft());				
				options.lct.parent().scrollTop($(this).scrollTop());
				if(options.lct.parent().scrollTop() < $(this).scrollTop()){
					$(this).scrollTop(options.lct.parent().scrollTop());
				}

				var c = options.selectedCell.prop('id').toString().split('-')[1];
				/* 스크롤 이동에 따른 엘리먼트 위치 조정 */
				if (options.columns[c].type === alpha.vars.type.autocomplete) {
					$('#divAutoComplete').offset({
						top: ($(alpha.vars.table.class.selected.div.selector).offset().top) - options.rct.scrollTop(),
						left: ($(alpha.vars.table.class.selected.div.selector).offset().left + $(alpha.vars.table.class.selected.div.selector).parent().width())
					});
				}

				e.preventDefault();
			});

			options.lct.parent().on('mousewheel DOMMouseScroll', function (e) {
				options.rct.parent().scrollTop($(this).scrollTop());
				var c = alpha.fnc.selectCol(options.selectedCell);
				/* 스크롤 이동에 따른 엘리먼트 위치 조정 */
				if (options.columns[c].type === alpha.vars.type.autocomplete) {
					$('#divAutoComplete').offset({
						top: ($(alpha.vars.table.class.selected.div.selector).offset().top) - options.rct.scrollTop(),
						left: ($(alpha.vars.table.class.selected.div.selector).offset().left + $(alpha.vars.table.class.selected.div.selector).parent().width())
					});
				}

				e.preventDefault();
			});

			/* 행추가 */
			for (var r = alpha.vars.zero; r < options.data.length; r++) {
				$(this).dtable(alpha.row.set.add.render, r);
			}
			/* 테이블 초기화 */
			if (options.editable) {
				if (options.autoAdd) {
					/* 수정시 기본행 추가 */
					$(this).dtable(alpha.row.set.add.data, []);
					/* 집계 수행 */
					$(this).dtable(alpha.title.set.total.reload);
					/* 마지막행의 첫번째 입력란에 포커스 주기. */
					$(this).dtable(alpha.row.set.select.last);
				}
			}
		},
		tableSetVars: function () {
			/* 변수정의 */
			var options = $.fn.dtable.options[$(this).prop('id')];
			/* 각 테이블 정의 */
			$.fn.dtable.options[options.id].lht = $(this).find('#' + options.id + '_' + alpha.vars.table.title.left.name); /* 왼쪽 제목 */
			$.fn.dtable.options[options.id].rht = $(this).find('#' + options.id + '_' + alpha.vars.table.title.right.name); /* 오른쪽 제목 */
			$.fn.dtable.options[options.id].lct = $(this).find('#' + options.id + '_' + alpha.vars.table.content.left.name); /* 왼쪽 본문 */
			$.fn.dtable.options[options.id].rct = $(this).find('#' + options.id + '_' + alpha.vars.table.content.right.name); /* 오른쪽 본문 */
		},
		/* [-] ## table ######################################################################################################################################################################################################## */

		/* [+] ## tr ######################################################################################################################################################################################################## */

		/* [-] ## tr ######################################################################################################################################################################################################## */

		/* [+] ## td ######################################################################################################################################################################################################## */
		tdGetFixedWidth: function () {
			/* 변수정의 */
			var options = $.fn.dtable.options[$(this).prop('id')];
			var result = alpha.vars.zero;
			/* 왼쪽 고정 영역의 너비를 구하여 반환한다. */
			var widthPadding = alpha.vars.zero;
			options.colWidth.slice(alpha.vars.zero, options.colLeftFixed).forEach(function (item, c) {
				if (options.columns[c].type != alpha.vars.type.hidden) {
					result = (alpha.fnc.num(result) + alpha.fnc.num(item));
					widthPadding++;
				}
			});
			result = result + alpha.fnc.num(widthPadding);
			return result;
		},
		/* [-] ## td ######################################################################################################################################################################################################## */

		/* [+] ## title ######################################################################################################################################################################################################## */
		titleSetLeft: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			var ltr = '';
			for (var c = alpha.vars.zero; c < options.colLeftFixed; c++) {
				if (options.columns[c].type == alpha.vars.type.hidden) {
					ltr += '<th id="col-' + c + '" width="' + alpha.fnc.num(options.colWidth[c], alpha.vars.colWidth.default) + '" style="display:none;">' + $(this).dtable(alpha.title.get.name, c) + alpha.vars.elem.tags.th.end;
				} else {
					if(options.colReq[c] === 'Y'){
						ltr += '<th id="col-' + c + '" width="' + alpha.fnc.num(options.colWidth[c], alpha.vars.colWidth.default) + '"><img src="/exp/Images/ico/ico_check01.png" alt="" />&nbsp;' + $(this).dtable(alpha.title.get.name, c) + alpha.vars.elem.tags.th.end;
					} else {
						ltr += '<th id="col-' + c + '" width="' + alpha.fnc.num(options.colWidth[c], alpha.vars.colWidth.default) + '">' + $(this).dtable(alpha.title.get.name, c) + alpha.vars.elem.tags.th.end;
					}
				}
			}
			options.lht.append(alpha.vars.elem.tags.tr.start + ltr + alpha.vars.elem.tags.tr.end);
		},
		titleSetRight: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			var rtr = '';
			for (var c = options.colLeftFixed; c < options.colSize; c++) {
				if (options.columns[c].type == alpha.vars.type.hidden) {
					rtr += '<th id="col-' + c + '" width="' + alpha.fnc.num(options.colWidth[c], alpha.vars.colWidth.default) + '" style="display:none;">' + $(this).dtable(alpha.title.get.name, c) + alpha.vars.elem.tags.th.end;
				} else {
					if(options.colReq[c] === 'Y'){
						rtr += '<th id="col-' + c + '" width="' + alpha.fnc.num(options.colWidth[c], alpha.vars.colWidth.default) + '"><img src="/exp/Images/ico/ico_check01.png" alt="" />&nbsp;' + $(this).dtable(alpha.title.get.name, c) + alpha.vars.elem.tags.th.end;
					} else {
						rtr += '<th id="col-' + c + '" width="' + alpha.fnc.num(options.colWidth[c], alpha.vars.colWidth.default) + '">' + $(this).dtable(alpha.title.get.name, c) + alpha.vars.elem.tags.th.end;
					}
				}
			}
			options.rht.append(alpha.vars.elem.tags.tr.start + rtr + alpha.vars.elem.tags.tr.end);
		},
		titleSetTotal: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			if (options.total.sumCol.length > alpha.vars.zero) {
				/* 'total': { title: '합계', colspan: [0, 5], sumCol: [10, 11, 12, 16] } */
				if (!options.total) {
					options.title = '';
					options.colspan = [];
					options.sumCol = [];
				}
				var colStartIndex = alpha.fnc.num(options.total.colspan[alpha.vars.zero]),
					colEndIndex = alpha.fnc.num(options.total.colspan[1]),
					fixIndex = alpha.fnc.num(options.colLeftFixed),
					colMaxIndex = alpha.fnc.num(options.colSize);
				/* 1. 생성 불가한 상황 확인 : 시작이 종료보다 큰 경우 */
				if (colEndIndex < colStartIndex) {
					$.error('집계행 생성 실패하였습니다. total.colspan의 시작과 종료 범위를 확인해주세요.');
				}
				/* 2. 생성 불가한 상황 확인 : 테이블을 넘나드는 경우 */
				if (colStartIndex < fixIndex && fixIndex < colEndIndex) {
					$.error('집계행 생성 실패하였습니다. total.colspan 과 colLeftFixed 를 확인해주세요.');
				}
				/* 3. 생성 불가한 상황 확인 : 테이블의 크기보다 큰 경우 */
				if (colMaxIndex < colEndIndex) {
					$.error('집계행 생성 실패하였습니다. 테입블 열의 최대크기보다 total.colspan[1] 이 큽니다.');
				}
				/* 집계행 생성 */
				var ltr = '',
					rtr = '';
				for (var c = alpha.vars.zero; c < options.colSize; c++) {
					var temp = '';
					if (colStartIndex == c) {
						if (colEndIndex != colStartIndex) {
							var colSpan = ((alpha.fnc.num(options.total.colspan[1]) - alpha.fnc.num(options.total.colspan[alpha.vars.zero])) + 1);
							temp = '<th id="col-' + c + '" colspan="' + colSpan + '">' + options.total.title + alpha.vars.elem.tags.th.end;
						} else {
							temp = '<th id="col-' + c + '">' + options.total.title + alpha.vars.elem.tags.th.end;
						}
					} else if (colStartIndex < c && c <= colEndIndex) {
						continue;
					} else {
						temp = (options.columns[c].type === alpha.vars.type.hidden ? '<th class="ri" id="col-' + c + '" style="display:none;"></th>' : '<th class="ri" id="col-' + c + '"></th>');
					}

					if (c < options.colLeftFixed) {
						ltr += temp;
					} else {
						rtr += temp;
					}
				}
				options.lht.append(alpha.vars.elem.tags.tr.start + ltr + alpha.vars.elem.tags.tr.end);
				options.rht.append(alpha.vars.elem.tags.tr.start + rtr + alpha.vars.elem.tags.tr.end);
			}
		},
		/* [-] ## title ######################################################################################################################################################################################################## */



		rowSetAddRender: function (r) {
			var options = $.fn.dtable.options[$(this).prop('id')];
			r = (r === alpha.vars.zero ? r : alpha.fnc.num(r, -1));
			/* 데이터 검증 */
			if (r < alpha.vars.zero) {
				$.error('신규행의 정보가 없습니다. 기본값을 설정하여 사용하세요. ( ex : $(elem).dtable("rowSetAddData", []) )');
				return;
			}
			/* 행 추가 */
			var lct = '',
				rct = '';

			for (var c = alpha.vars.zero; c < options.colSize; c++) {
				var temp = '';

				if (options.columns[c].type == alpha.vars.type.hidden) {
					temp = '<td id="col-' + c + '" width="' + alpha.fnc.num(options.colWidth[c], alpha.vars.colWidth.default) + '" class="' + (options.colAlignments[c] || alpha.vars.colAlignments.center) + '" style="display:none;">' + $(this).dtable(alpha.col.get.data, r, c) + '</td>';
				} else {
					temp = '<td id="col-' + c + '" width="' + alpha.fnc.num(options.colWidth[c], alpha.vars.colWidth.default) + '" class="' + (options.colAlignments[c] || alpha.vars.colAlignments.center) + '">' + $(this).dtable(alpha.col.get.data, r, c) + '</td>';
				}

				if (c < options.colLeftFixed) {
					lct += temp;
				} else {
					rct += temp;
				}
			}
			/* 행 추가 */
			options.lct.append(alpha.vars.elem.tags.tr.start + lct + alpha.vars.elem.tags.tr.end);
			options.rct.append(alpha.vars.elem.tags.tr.start + rct + alpha.vars.elem.tags.tr.end);
			
			/* 이벤트 적용 */
			options.lct.find('tr:last td').click(function () {
				if (options.selectedCell) {
					options.beforeSelectedCell = options.selectedCell;
				}
				options.selectedCell = $(this);
				$('#' + options.id).dtable('inputSetFocus');
				
				if(options.callback){
					/* 행선택 이벤트 */
					if(options.callback.rowClick){
						if(options.selectedRowIndex === $('#' + options.id).dtable('rowGetIndex')){
							return;
						} else {
							options.selectedRowIndex = $('#' + options.id).dtable('rowGetIndex');
							options.callback.rowClick($('#' + options.id).dtable ( 'rowGetIndex' ), $('#' + options.id).dtable ( 'rowGetJsonData', $('#' + options.id).dtable ( 'rowGetIndex' ) ));
						}
					}
				}
			});
			options.rct.find('tr:last td').click(function () {
				if (options.selectedCell) {
					options.beforeSelectedCell = options.selectedCell;
				}
				options.selectedCell = $(this);
				$('#' + options.id).dtable('inputSetFocus');
				
				if(options.callback){
					/* 행선택 이벤트 */
					if(options.callback.rowClick){
						if(options.selectedRowIndex === $('#' + options.id).dtable('rowGetIndex')){
							return;
						} else {
							options.selectedRowIndex = $('#' + options.id).dtable('rowGetIndex');
							options.callback.rowClick($('#' + options.id).dtable ( 'rowGetIndex' ), $('#' + options.id).dtable ( 'rowGetJsonData', $('#' + options.id).dtable ( 'rowGetIndex' ) ));
						}
					}
				}
			});

			$(this).dtable(alpha.row.set.select.last);
		},
		colGetData: function (r, c) {
			var options = $.fn.dtable.options[$(this).prop('id')];
			var content = '';
			
			if(r >= 0){
				if (options.columns[c].type === 'codeonly' || options.columns[c].type == alpha.vars.type.text || options.columns[c].type == alpha.vars.type.autocomplete || options.columns[c].type == 'date' || options.columns[c].type == 'time') {
					content = ((options.data[r][c] === undefined || options.data[r][c] === '') ? '' : options.data[r][c]);
				} else {
					content = options.columns[c].type;
				}
	
				/* 반환 정보 가공 */
				switch (content) {
					case alpha.vars.type.checkbox:
						var name = options.id + '_chk';
						var id = options.id + '_chk_col_' + r;
						var onClick = 'onclick="javascript:$(' + "'" + '#' + options.id + '' + "'" + ').dtable(' + "'" + 'chkCheck' + "'" + ', this);"';
						var checkbox = '<input type="checkbox" name="' + name + '" id="' + id + '" style="visibility: hidden;" ' + onClick + '>';
						var label = '<label for="' + id + '"></label>';
						return (checkbox + label);
					case 'readonly':
						return alpha.vars.elem.tags.span.start + ((options.data[r][c] === undefined || options.data[r][c] === '') ? '' : options.data[r][c]) + alpha.vars.elem.tags.span.end;
					default:
						return alpha.vars.elem.tags.span.start + content + alpha.vars.elem.tags.span.end;
				}
			}
		},
		titleSetTotalReload: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			/* 'total': { title: '합계', colspan: [0, 5], sumCol: [10, 11, 12, 16] } */
			options.total.sumCol.forEach(function (c) {
				var calc = alpha.vars.zero;
				for (var r = alpha.vars.zero; r < options.data.length; r++) {
					calc = (alpha.fnc.num(calc) + alpha.fnc.num(options.data[r][c]));
				}

				if (c < options.colLeftFixed) {
					options.lht.find('tr:eq(1) th[id=col-' + c + ']').empty();
					options.lht.find('tr:eq(1) th[id=col-' + c + ']').append(calc);
				} else {
					options.rht.find('tr:eq(1) th[id=col-' + c + ']').empty();
					options.rht.find('tr:eq(1) th[id=col-' + c + ']').append(calc);
				}
			});
		},
		titleGetName: function (c) {
			var options = $.fn.dtable.options[$(this).prop('id')];
			if (options.colHeaders[c].toString().toUpperCase() === alpha.vars.elem.input.checkboxAll.toUpperCase()) {
				options.colHeaders[c] = alpha.vars.elem.input.checkboxAll.toString();

				var name = options.id + '_chk';
				var id = options.id + '_chkAll';
				var onClick = 'onclick="javascript:$(' + "'" + '#' + id + '' + "'" + ').dtable(' + "'" + 'chkAll' + "'" + ', this);"';
				var checkbox = '<input type="checkbox" name="' + name + '" id="' + id + '" style="visibility: hidden;" ' + onClick + '>';
				var label = '<label for="' + id + '"></label>';
				return (checkbox + label);
			} else {
				return (options.colHeaders[c]).toString();
			}
		},
		titleGetEmptyName: function (c) {
			var title = '';
			if (c > 701) {
				title += String.fromCharCode(64 + parseInt(c / 676));
				title += String.fromCharCode(64 + parseInt((c % 676) / 26));
			} else if (c > 25) {
				title += String.fromCharCode(64 + parseInt(c / 26));
			}
			title += String.fromCharCode(65 + (c % 26));

			return title;
		},
		rowSetSelectIndex: function (r) {
			var options = $.fn.dtable.options[$(this).prop('id')];
			options.lct.find(alpha.vars.table.class.selected.row.selector).removeClass(alpha.vars.table.class.selected.row.string);
			options.rct.find(alpha.vars.table.class.selected.row.selector).removeClass(alpha.vars.table.class.selected.row.string);

			if (!options.lct.find('tr:eq(' + r + ')').hasClass(alpha.vars.table.class.selected.row.string)) {
				options.lct.find('tr:eq(' + r + ')').addClass(alpha.vars.table.class.selected.row.string);
			}
			if (!options.rct.find('tr:eq(' + r + ')').hasClass(alpha.vars.table.class.selected.row.string)) {
				options.rct.find('tr:eq(' + r + ')').addClass(alpha.vars.table.class.selected.row.string);
			}
		},
		colSetSelectIndex: function (c) {
			var options = $.fn.dtable.options[$(this).prop('id')];
			options.rht.find(alpha.vars.table.class.selected.col.selector).removeClass(alpha.vars.table.class.selected.col.string);
			options.lht.find(alpha.vars.table.class.selected.col.selector).removeClass(alpha.vars.table.class.selected.col.string);
			options.lct.find(alpha.vars.table.class.selected.col.selector).removeClass(alpha.vars.table.class.selected.col.string);
			options.rct.find(alpha.vars.table.class.selected.col.selector).removeClass(alpha.vars.table.class.selected.col.string);

			if (c < options.colLeftFixed) {
				if (!options.lht.find('td[id=col-' + c + ']').hasClass(alpha.vars.table.class.selected.col.string)) {
					options.lht.find('th[id=col-' + c + ']').addClass(alpha.vars.table.class.selected.col.string);
				}
				if (!options.lct.find('td[id=col-' + c + ']').hasClass(alpha.vars.table.class.selected.col.string)) {
					options.lct.find('td[id=col-' + c + ']').addClass(alpha.vars.table.class.selected.col.string);
				}
			} else {
				if (!options.rht.find('td[id=col-' + c + ']').hasClass(alpha.vars.table.class.selected.col.string)) {
					options.rht.find('th[id=col-' + c + ']').addClass(alpha.vars.table.class.selected.col.string);
				}
				if (!options.rct.find('td[id=col-' + c + ']').hasClass(alpha.vars.table.class.selected.col.string)) {
					options.rct.find('td[id=col-' + c + ']').addClass(alpha.vars.table.class.selected.col.string);
				}
			}
		},
		colSetSelectStyle: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			if (!options.selectedCell.hasClass()) {
				options.lct.find(alpha.vars.table.class.selected.td.string).remove(alpha.vars.table.class.selected.td.string);

				options.rct.find(alpha.vars.table.class.selected.td.string).remove(alpha.vars.table.class.selected.td.string);
				options.selectedCell.addClass(alpha.vars.table.class.selected.td.string);
			}
		},
		colSetSelectReset: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			options.lht.find(alpha.vars.table.class.selected.col.selector).removeClass(alpha.vars.table.class.selected.col.string);
			options.rht.find(alpha.vars.table.class.selected.col.selector).removeClass(alpha.vars.table.class.selected.col.string);
			options.lct.find(alpha.vars.table.class.selected.row.selector).removeClass(alpha.vars.table.class.selected.row.string);
			options.rct.find(alpha.vars.table.class.selected.row.selector).removeClass(alpha.vars.table.class.selected.row.string);
		},
		rowSetAddData: function (data) {
			/* 변수정의 */
			var options = $.fn.dtable.options[$(this).prop('id')];
			data = (data || []);
			/* 데이터 검증 */
			if (data.length < options.colSize) {
				for (var c = alpha.vars.zero; c < options.colSize; c++) {
					if (data[c] === undefined) {
						data.push('');
					}
				}
			}
			/* 데이터 추가 */
			options.data.push(data);
			/* 신규행 생성 */
			$(this).dtable(alpha.row.set.add.render, options.data.length - 1);
			/* 집계행 재계산 */
			$(this).dtable(alpha.title.set.total.reload);
			/* 테이블 크기 재계산 */
			options.rowSize = options.rowSize + 1;
			if(options.bindData){
				options.bindData();
			}
			
			if(options.callback){
				/* 행추가 이벤트 */
				if(options.callback.rowAdd){
					options.callback.rowAdd($(this).dtable ( 'rowGetIndex' ), $(this).dtable ( 'rowGetJsonData', $(this).dtable ( 'rowGetIndex' ) ));
				}
			}
		},
		rowSetRemoveData: function (r) {
			/* 변수정의 */
			var options = $.fn.dtable.options[$(this).prop('id')];
			/* 데이터 검증 */
			if (r < 0) {
				return;
			}
			
			if(options.callback){
				/* 행 삭제 이벤트 */
				if(options.callback.rowRemove){
					options.callback.rowRemove($(this).dtable ( 'rowGetIndex' ), $(this).dtable ( 'rowGetJsonData', $(this).dtable ( 'rowGetIndex' ) ));
				}
			}
			
			options.data.splice(r, 1);
			options.lct.find('tr:eq(' + r + ')').unbind().remove();
			options.rct.find('tr:eq(' + r + ')').unbind().remove();
			/* 집계행 재계산 */
			$(this).dtable(alpha.title.set.total.reload);
			/* 테이블 크기 재계산 */
			options.rowSize = options.rowSize - 1;
			/* 포커스 이동 */
			if (options.selectedCell.parent().index() >= r) {
				$(this).dtable(alpha.row.set.select.last);
			}
			if(options.bindData){
				options.bindData();
			}
		},
		getCheckedList: function () {
			/* 변수정의 */
			var options = $.fn.dtable.options[$(this).prop('id')];
			var resultCheckbox = function (c) {
				if (c < options.colLeftFixed) {
					return options.lct.find('input[type=checkbox]:checked');
				} else {
					return options.rct.find('input[type=checkbox]:checked');
				}
			};
			/* 데이터 검증 */
			for (var c = alpha.vars.zero; c < options.colSize; c++) {
				if (options.columns[c].type === alpha.vars.type.checkbox) {
					return resultCheckbox(c);
					break;
				}
			}
		},
		chkAll: function (checkbox) {
			var chkElem = $('input[name=' + $(checkbox).attr('name') + ']').not('#' + $(checkbox).prop('id'));
			if ($(checkbox).prop('checked')) {
				chkElem.prop('checked', true);
			} else {
				chkElem.prop('checked', false);
			}
		},
		chkCheck: function (checkbox) {
			var chkIdInfo = $(checkbox).prop('id').toString().split('_');
			var chkAllId = $('#' + [chkIdInfo[alpha.vars.zero], 'chkAll'].join('_'));
			var chkElem = $('input[name=' + $(checkbox).attr('name') + ']').not('#' + $(checkbox).prop('id'));
			var checkedElem = $('input[name=' + $(checkbox).attr('name') + ']:checked').not(chkAllId);

			/* 전체 체크박스가 선택되면 자동으로 모든 체크박스 선택을 체크한다. */
			if (chkElem.length === checkedElem.length) {
				chkAllId.prop('checked', true);
			}
			/* 전체 체크박스가 선택되지 않으면 자동으로 모든체크박스 선택을 해제한다. */
			else {
				chkAllId.prop('checked', false);
			}
		},
		inputSetFocus: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			if (options.beforeSelectedCell !== undefined) {
				$('#' + options.id).dtable('setCellRemoveMod');
			}
			var r = alpha.fnc.selectRow(options.selectedCell);
			var c = alpha.fnc.selectCol(options.selectedCell);
			if (options.columns[c].type != alpha.vars.type.checkbox) {
				$('#' + options.id).dtable(alpha.row.set.select.index, r);
				$('#' + options.id).dtable(alpha.col.set.select.index, c);
				$('#' + options.id).dtable(alpha.col.set.select.style, c);
				$('#' + options.id).dtable('setCellMod');
				options.selectedCell.find('input').focus().select();
			} else {
				$('#' + options.id).dtable(alpha.col.set.select.reset);
			}

			var scrollElem = $(this).find('.highLight').parent().parent().parent().parent();
			if(scrollElem[0] && scrollElem[0].tagName === 'DIV'){
				var scrollPos = scrollElem.offset().left + scrollElem.innerWidth();
				var inputPos = $(this).find('.highLight').offset().left + $(this).find('.highLight').width();
	
				if (scrollPos < (inputPos + ($(this).find('.highLight').width() / 2))) {
					scrollElem.scrollLeft(scrollElem.scrollLeft() + (($(this).find('.highLight').width() / 2) + (inputPos - scrollPos)));
				}
			}
			
			if(options.callback){
				/* 행선택 이벤트 */
				if(options.callback.rowClick){
					if(options.selectedRowIndex === $('#' + options.id).dtable('rowGetIndex')){
						return;
					} else {
						options.selectedRowIndex = $('#' + options.id).dtable('rowGetIndex');
						options.callback.rowClick($('#' + options.id).dtable ( 'rowGetIndex' ), $('#' + options.id).dtable ( 'rowGetJsonData', $('#' + options.id).dtable ( 'rowGetIndex' ) ));
					}
				}
			}
		},
		setCellMod: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			var r = alpha.fnc.selectRow(options.selectedCell);
			var c = alpha.fnc.selectCol(options.selectedCell);
			var colType = options.columns[c].type.toString();
			var dateOptions = {
				altFormat: "yy-mm-dd",
				dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
				dateFormat: "yy-mm-dd",
				dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
				monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				showOtherMonths: true,
				selectOtherMonths: true,
				showMonthAfterYear: true,
				nextText: "Next",
				prevTex: "Prev"
			};
			var dispName = function (item) {
				var reuslt = '';
				options.columns[c].name.forEach(function (key) {
					reuslt += (item[key] !== undefined ? item[key] : key);
				});

				return reuslt;
			};

			/* 체크박스 예외처리 */
			if (colType === alpha.vars.type.checkbox) {
				return;
			} else {
				var input = $(document.createElement('input'));
				input.attr('type', 'text');
				if(options.columns[c].type === 'readonly'){
					input.attr('readonly', 'readonly');
				}
				
				input.attr('value', (options.data[r][c] || ''));
				options.selectedCell.empty().append('<div class="' + alpha.vars.table.class.selected.div.string + '"></div>');
				options.selectedCell.find('div').append(input[0]);
				/* type 별 예외처리 */
				if (colType === alpha.vars.type.date) {
					input.addClass('brn inpDateBox');
					input.datepicker(dateOptions);
				} else if (colType === alpha.vars.type.autocomplete) {
					input.addClass('inpTextBox');
				} else {
					input.addClass('inpTextBox');
				}
				if (options.columns[c].type.toString() === alpha.vars.type.autocomplete) {
					var li = '';
					for (var i = 0; i < options.columns[c].source.length; i++) {
						li += '<li>' + dispName(options.columns[c].source[i]) + '</li>';
					}
					$('#divAutoComplete').empty().append('<ul class="inp_list">' + li + '</ul>');
					$('#divAutoComplete').find('li').click(function () {
						$('#divAutoComplete').find('.on').removeClass('on');
						$(this).addClass('on');
					});
					$('#divAutoComplete').offset({
						top: ($(alpha.vars.table.class.selected.div.selector).offset().top) - options.rct.scrollTop(),
						left: ($(alpha.vars.table.class.selected.div.selector).offset().left + $(alpha.vars.table.class.selected.div.selector).parent().width())
					});

					$('#divAutoComplete').find('li:eq(0)').click();
				}

				if (options.columns[c].mask) {
					input.mask(options.columns[c].mask.toString().replace(/_/g, '9'), {
						placeholder: options.columns[c].mask
					});
				}
				
				options.selectedCell.find('input').focusout(function(event){
					var r = alpha.fnc.selectRow(options.selectedCell);
					var c = alpha.fnc.selectCol(options.selectedCell);
					options.data[r][c] = $(this).val();
					
					if(options.bindData){
						options.bindData();
					}
				});
				
				options.selectedCell.find('input').keyup(function(event){
					if(options.columns[c].type === 'codeonly'){
						if((event.keyCode || event.which) != 113 && (event.keyCode || event.which) != 13){
							options.selectedCell.find('input').val(options.selectedCell.find('input').val().replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, ''));
							// return false;
						}
					}
				});
				
				options.selectedCell.find('input').keydown(function (event) {
					if(options.columns[c].type === 'codeonly'){
						if((event.keyCode || event.which) != 113 && (event.keyCode || event.which) != 13){
							return false;
						}
					}
					
					if(options.columns[c].editor){
						if([113, 114, 13, 37, 39, 38, 40].indexOf((event.keyCode || event.which)) === -1){
							return;
						}
					}
					
					if ((event.keyCode || event.which) == 113) {
						if(options.columns[c].editor){
							if(options.columns[c].editor.openEditor){
								options.columns[c].editor.openEditor();
								options.selectedCell.find('input').attr('readonly', 'readonly');
							}
						}
						return false;
					} else if ((event.keyCode || event.which) == 114) {
						if(options.colKeys[c] === 'TR_CD'){
							if(options.columns[c].editor){
								if(options.columns[c].editor.openEditor){
									options.columns[c].editor.openEditor('EMP');
									options.selectedCell.find('input').attr('readonly', 'readonly');
								}
							}
							return false;
						}
					}else if ((event.keyCode || event.which) == 13) {
						/* enter */
						/* 필수 입력이면서 코드 도움인 경우 코드 도움 호출 ( 값이 없는 경우에만 ) */
						if(options.columns[c].editor){
							if($(this).val() === ''){
								if(options.columns[c].editor.openEditor){
									options.columns[c].editor.openEditor();
									options.selectedCell.find('input').attr('readonly', 'readonly');
									
									return false;
								}
							}
						} else if (colType === alpha.vars.type.autocomplete) {
							$('#' + options.id).find('input').val($('li.on').text());
							/* 데이터 바인딩 */
							var liIndex = $('li.on').index();
							/* jquery addClass 후, 맨 처음 index 호출시. 제대로 된 index 반환이 안됨. */
							liIndex = (((options.columns[c].source.length - 1) < liIndex) ? 0 : liIndex);
							$.each(Object.keys(options.columns[c].source[liIndex]), function (keyIndex, key) {
								if (options.colKeys.indexOf(key) > -1) {
									options.data[r][options.colKeys.indexOf(key)] = options.columns[c].source[liIndex][key];
									if(options.bindData){
										options.bindData();
									}
								}
							});
							$('#divAutoComplete').contents().unbind().remove();
							$('#divAutoComplete').offset({
								top: alpha.vars.zero,
								left: alpha.vars.zero
							});
						}

						$('#' + options.id).dtable(alpha.col.set.move, 1);

						if(options.columns[c].editor){
							if(options.columns[c].editor.moveFocus){
								options.columns[c].editor.moveFocus();
							}
						}
						return false;
					} else if ((event.keyCode || event.which) == 37) {
						/* left arrow */
						if (colType === alpha.vars.type.date) {
							if (options.selectedCell.find('input').val().replace(/-/g, '').replace(/_/g, '') === '') {
								var inst = $.datepicker._getInst(event.target);
								var isRTL = inst.dpDiv.is(".ui-datepicker-rtl");
								$.datepicker._adjustDate(event.target, (isRTL ? +1 : -1), "D");
								return;
							}
						}

						$('#ui-datepicker-div').hide()
						$('#' + options.id).dtable(alpha.col.set.move, -1);

						return false;
					} else if ((event.keyCode || event.which) == 39) {
						/* right arrow */
						if (colType === alpha.vars.type.date) {
							if (options.selectedCell.find('input').val().replace(/-/g, '').replace(/_/g, '') === '') {
								var inst = $.datepicker._getInst(event.target);
								var isRTL = inst.dpDiv.is(".ui-datepicker-rtl");
								$.datepicker._adjustDate(event.target, (isRTL ? -1 : +1), "D");
								return;
							}
						}

						$('#ui-datepicker-div').hide()
						$('#' + options.id).dtable(alpha.col.set.move, 1);

						return false;
					} else if ((event.keyCode || event.which) == 38) {
						/* top arrow */
						if (colType === alpha.vars.type.date) {
							$.datepicker._adjustDate(event.target, -7, "D");
						} else if (colType === alpha.vars.type.autocomplete) {
							if ($('li.on').prev('li').length > 0) {
								var li = $('li.on');
								li.prev('li').addClass('on');
								li.removeClass('on');
							}
						}

						return false;
					} else if ((event.keyCode || event.which) == 40) {
						/* bottom arrow */
						if (colType === alpha.vars.type.date) {
							$.datepicker._adjustDate(event.target, +7, "D");
						} else if (colType === alpha.vars.type.autocomplete) {
							if ($('li.on').next('li').length > 0) {
								var li = $('li.on');
								li.next('li').addClass('on');
								li.removeClass('on');
							}
						} else {
							return;
						}

						return false;
					} else {
						if (colType === alpha.vars.type.autocomplete) {
							return false;
						}
					}
				});
			}

			options.selectedCell.find('input').focus();
			return;
		},
		setCellRemoveMod: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			var r = options.beforeSelectedCell.parent().index();
			var c = options.beforeSelectedCell.prop('id').split('-')[1];
			if(options.data[r]){
				options.data[r][c] = options.beforeSelectedCell.find('input').val() || '';
				if(options.bindData){
					options.bindData();
				}
			}
			$('#divAutoComplete').offset({
				top: alpha.vars.zero,
				left: alpha.vars.zero
			});
			if (options.columns[c].type != alpha.vars.type.checkbox) {
				options.beforeSelectedCell.contents().unbind().remove();
				options.beforeSelectedCell.removeClass('colOn highLight');
				options.beforeSelectedCell.append($(this).dtable(alpha.col.get.data, r, c));
			}
		},
		colSetMove: function (addCol) {
			var options = $.fn.dtable.options[$(this).prop('id')];
			var r = alpha.fnc.selectRow(options.selectedCell);
			var c = alpha.fnc.selectCol(options.selectedCell);
			var nextCol = (alpha.fnc.num(c) + alpha.fnc.num(addCol));
			
			/* 필수 입력이 무시되면 안됨. */
			if(options.colReq[Number(options.selectedCell.attr('id').replace('col-', ''))] === 'Y' && options.selectedCell.find('input').val() === ''){
				return false;
			}

			if (options.colReq[c].toString() === 'Y') {
				if ($(this).find('.highLightIn input').val() === '') {
					/* 필수값 */
					return false;
				}
			}

			/* 다음 cell이 존재하는가? */
			if (nextCol >= alpha.vars.zero && nextCol < options.colSize) {
				if (options.columns[nextCol].type === alpha.vars.type.hidden) {
					return $('#' + options.id).dtable(alpha.col.set.move, (addCol > alpha.vars.zero ? addCol + 1 : addCol - 1));
				} else if(options.columns[nextCol].type === 'readonly'){
					return $('#' + options.id).dtable(alpha.col.set.move, (addCol > alpha.vars.zero ? addCol + 1 : addCol - 1));
				} else {
					switch (options.columns[nextCol].type) {
						case alpha.vars.type.checkbox:
							/* 다음 cell이 checkbox? */
							/* return $('#' + options.id).dtable(alpha.col.set.move, (addCol > 0 ? addCol + 1 : addCol - 1)); */
							options.selectedCell.find('input').focus();
							break;
						case alpha.vars.type.hidden:
							/* 다음 cell이 hidden인가? */
						default:
							if (nextCol < options.colLeftFixed) {
								options.beforeSelectedCell = options.selectedCell;
								options.selectedCell = options.lct.find('tr:eq(' + options.selectedCell.parent().index() + ')').find('td[id=col-' + nextCol + ']');
								$('#' + options.id).dtable('inputSetFocus');
							} else {
								options.beforeSelectedCell = options.selectedCell;
								options.selectedCell = options.rct.find('tr:eq(' + options.selectedCell.parent().index() + ')').find('td[id=col-' + nextCol + ']');
								$('#' + options.id).dtable('inputSetFocus');
							}
							break;
					}
				}
			} else {
				if (nextCol >= options.colSize) {
					if (options.rowSize == (r + 1)) {
// if (confirm('신규행을 생성하시겠습니까?')) {
// options.beforeSelectedCell = options.selectedCell;
// $(this).dtable(alpha.row.set.add.data, []);
// /* 마지막행의 첫번째 입력란에 포커스 주기. */
// for (var col = alpha.vars.zero; col < options.colSize; col++) {
// if (options.columns[c].type != alpha.vars.type.checkbox) {
// if (col < options.colLeftFixed) {
// options.selectedCell = options.lct.find('tr:last').find('td[id=col-' + c + ']');
// } else {
// options.selectedCell = options.rct.find('tr:last').find('td[id=col-' + c + ']');
// options.lct.parent().scrollTop($(this).scrollTop());
// }
//
// $(this).dtable('inputSetFocus');
// options.rct.parent().scrollTop(options.lct.parent().scrollTop());
// break;
// }
// }
// }
					}
				} else {
					options.selectedCell.find('input').focus();
				}
			}
			return;
		},
		getTableData: function (r, c) {
			var options = $.fn.dtable.options[$(this).prop('id')];
			r = (r === undefined ? -1 : r);
			c = (c === undefined ? -1 : c);

			if (r > -1) {
				if (r < options.rowSize) {
					if (c > -1) {
						if (c < options.colSize) {
							return options.data[r][c];
						} else {
							return '';
						}
					} else {
						return options.data[r];
					}
				} else {
					return [];
				}
			} else {
				return options.data;
			}
		},
		rowSetSelectLast: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			options.beforeSelectedCell = options.selectedCell;
			for (var c = alpha.vars.zero; c < options.colSize; c++) {
				if (options.columns[c].type != alpha.vars.type.checkbox) {
					if (c < options.colLeftFixed) {
						options.selectedCell = options.lct.find('tr:last').find('td[id=col-' + c + ']');
					} else {
						options.selectedCell = options.rct.find('tr:last').find('td[id=col-' + c + ']');
						options.lct.parent().scrollTop($(this).scrollTop());
					}

					$(this).dtable('inputSetFocus');
					options.rct.parent().scrollTop(options.lct.parent().scrollTop());
					break;
				}
			}
		},
		autocompleteGetSelect: function () {
			var options = $.fn.dtable.options[$(this).prop('id')];
			var dispText = $('#divAutoComplete .inp_list li.on').text();
			var value = JSON.parse(JSON.stringify($('#divAutoComplete .inp_list li.on').data('item')));
			$.each(Object.keys(value), function (itemIndex, itemValue) {
				var colIndex = (options.colKeys.indexOf(itemValue));
				if (colIndex > -1) {
					$('#' + options.id).dtable('colSetValue', options.selectedCell.parent().index(), colIndex, value[itemValue]);
				}
			});

			options.selectedCell.find('input').val(dispText);
			$('#divAutoComplete').offset({
				top: alpha.vars.zero,
				left: alpha.vars.zero
			});
		},
		colSetValue: function (r, c, value, bindContinue) {
			if(bindContinue !== false){
				bindContinue = true;
			}
			
			var options = $.fn.dtable.options[$(this).prop('id')];
			options.data[r][c] = value;
			
			if(c > options.colLeftFixed){
				options.rct.find('tr:eq(' + $(this).dtable ( 'rowGetIndex' ) + ') td:eq(' + (c - options.colLeftFixed) + ') span').contents().unbind().remove();
				options.rct.find('tr:eq(' + $(this).dtable ( 'rowGetIndex' ) + ') td:eq(' + (c - options.colLeftFixed) + ')').append($(this).dtable(alpha.col.get.data, r, c));
			} else {
				options.rct.find('tr:eq(' + $(this).dtable ( 'rowGetIndex' ) + ') td:eq(' + (c) + ') span').contents().unbind().remove();
				options.rct.find('tr:eq(' + $(this).dtable ( 'rowGetIndex' ) + ') td:eq(' + (c) + ')').append($(this).dtable(alpha.col.get.data, r, c));
			}
			
			if(bindContinue && options.bindData){
				options.bindData();
			}
		},
		colSetValues: function (value, moveYN) {
			if(value === null){
				return false;
			}
			
			moveYN = (moveYN === undefined ? true : moveYN);
			var options = $.fn.dtable.options[$(this).prop('id')];
			$.each(Object.keys(value), function (itemIndex, itemValue) {
				var colIndex = (options.colKeys.indexOf(itemValue));
				if (colIndex > -1) {
					$('#' + options.id).dtable('colSetValue', options.selectedCell.parent().index(), colIndex, value[itemValue]);
					if (options.selectedCell.prop('id').toString().replace('col-', '') === colIndex.toString()) {
						options.selectedCell.find('input').val(value[itemValue]);
					}
				}
			});
			
			if(options.columns[Number(options.selectedCell.prop('id').toString().split('-')[1])].editor){
				if(options.columns[Number(options.selectedCell.prop('id').toString().split('-')[1])].editor.closeEditor){
					options.columns[Number(options.selectedCell.prop('id').toString().split('-')[1])].editor.closeEditor(value);
				}
			}
			
			if(moveYN){
				$(this).dtable('colSetMove', 1);
			}
		},
		rowGetJsonData: function (r) {
			var options = $.fn.dtable.options[$(this).prop('id')];
			var result = {};
			if (options.rowSize > 0) {
				options.colKeys.forEach(function (key, keyIndex) {
					// result[((key || '') === '' ? options.columns[keyIndex].type : key)] = options.data[r][keyIndex];
					result[((key || '') === '' ? options.columns[keyIndex].type : key)] = (options.data[r] ? options.data[r][keyIndex] : "");
				});
			}

			result = JSON.parse(JSON.stringify(result));
			return result;
		},
		rowGetIndex: function(){
			var options = $.fn.dtable.options[$(this).prop('id')];
			if(options.selectedCell !== undefined){
				return options.selectedCell.parent().index();
			} else {
				return -1;
			}
		}
	};
	$.fn.dtable = function (method) {
		if (typeof method === 'object' || !method) {
			return methods.init.apply(this, arguments);
		} else if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else {
			$.error('Method ' + method + ' does not exist on method..');
		}
	};
})(jQuery);
