(function ($) {
	var methods = {
		init: function (options) {
			var defaults = {
				codeHead: '업무용 승용차',
				colHeaders: ['코드', '명칭'],
				colKeys: ['code', 'name'],
				colWidth: [],
				buttonGroup: ['choice', 'cancel'],
				data: [['02가1234', '업무용 승용차']],
				pageShowCount: 0,
				callback: '',
				option: {
					url: '',
					width: 500,
					height: 500
				}
			};
			var options = $.extend(defaults, options);
			var id = $(this).prop('id');
			/* create code layer */
			var createCodeLayer = function () {
				if (!$.fn.codeLayer.options) {
					$.fn.codeLayer.options = [];
				}
				$.fn.codeLayer.options[id] = options;
				/* class 확인 */
				if (!$('#' + id).hasClass('pop_wrap_dir')) {
					$('#' + id).addClass('pop_wrap_dir');
				}
				$('#' + id).width($.fn.codeLayer.options[id].option.width);
				$('#' + id).height($.fn.codeLayer.options[id].option.height);
				/* Layer 제목 확인 */
				$('#' + id).codeLayer('setCodeHead');
				/* Layout 확인 */
				$('#' + id).codeLayer('setCodeLayout');
				/* Foot 확인 */
				$('#' + id).codeLayer('setCodeFoot');
				/* Title 확인 */
				$('#' + id).codeLayer('setCodeTitle');
				/* List 확인 */
				$('#' + id).codeLayer('setCodeList');
				/* Layer move */
				$('#divCodeLayer').offset({
					left: ($('.sub_wrap').offset().left + ($('.sub_wrap').width() / 2) - ($.fn.codeLayer.options[id].option.width / 2)),
					top: ($('.sub_wrap').offset().top  + ($('.sub_wrap').height() / 2) - ($.fn.codeLayer.options[id].option.height / 2))
				});
				$(window).resize(function () {
					$('#divCodeLayer').offset({
						left: ($('.sub_wrap').offset().left + ($('.sub_wrap').width() / 2) - ($.fn.codeLayer.options[id].option.width / 2)),
						top: ($('.sub_wrap').offset().top  + ($('.sub_wrap').height() / 2) - ($.fn.codeLayer.options[id].option.height / 2))
					});
				});
			};
			/* pre event */
			var result = [];
			if (options.option.url !== '') {
				result.push(
					$.ajax({
						url: options.option.url,
						success: function (result) {
							options.data = (result.data || result);
						}
					}));
			}

			if (result.length > 0) {
				$.when.apply(this, result).done(function () {
					createCodeLayer();
				});
			} else {
				createCodeLayer();
			}
		},
		setCodeHead: function () {
			var id = $(this).prop('id');
			if ($('#' + id).find('.pop_head').length === 0) {
				var head = '<h1>' + ($.fn.codeLayer.options[id].codeHead || '공통코드') + '</h1><a href="#n" class="clo"><img src="../Images/btn/btn_pop_clo02.png" alt="" /></a>';
				$('#' + id).append('<div class="pop_head">' + head + '</div>');
			}
		},
		setCodeLayout: function () {
			var id = $(this).prop('id');
			/* head 확인 */
			$('#' + id).codeLayer('setCodeHead');
			/* layout 생성 */
			if ($('#' + id).find('.pop_con').length === 0) {
				$('#' + id).append('<div class="pop_con"></div>');
			} else {
				$('#' + id).find('.pop_con').contents().unbind().remove();
			}
		},
		setCodeFoot: function () {
			var id = $(this).prop('id');
			/* layout 생성 */
			if ($('#' + id).find('.pop_foot').length === 0) {
				/* button 생성 */
				var btn = '';
				$.fn.codeLayer.options[id].buttonGroup.forEach(function (item) {
					switch (item) {
						case 'choice':
							btn += '<input type="button" value="확인" style="margin-right:5px;" />';
							break;
						case 'cancel':
							btn += '<input type="button" class="gray_btn" value="취소" />';
							break;
					}
				});
				$('#' + id).append('<div class="pop_foot"><div class="btn_cen pt12">' + btn + '</div></div>');
			} else {
				$('#' + id).find('.pop_foot').contents().unbind().remove();
			}
		},
		setCodeTitle: function () {
			var id = $(this).prop('id');
			/* layout 확인 */
			$('#' + id).codeLayer('setCodeLayout');
			/* title 생성 */
			if ($('#' + id).find('.com_ta2').length === 0) {
				var colGroup = '';
				var colTitle = '';
				for (var i = 0; i < $.fn.codeLayer.options[id].colKeys.length; i++) {
					if (i < ($.fn.codeLayer.options[id].colKeys.length - 1)) {
						colGroup += '<col width="' + ($.fn.codeLayer.options[id].colWidth[i] || ($.fn.codeLayer.options[id].option.width / $.fn.codeLayer.options[id].colHeaders.length)) + '"/>';
					}
					colTitle += '<th>' + ($.fn.codeLayer.options[id].colHeaders[i] || '') + '</th>';
				}
				colGroup = '<colgroup>' + colGroup + '<col width=""/></colgroup>';
				colTitle = '<tr>' + colTitle + '</tr>';
				$('#' + id).find('.pop_con').append('<div class="com_ta2"><table>' + colGroup + colTitle + '</table></div>');
			}
		},
		setCodeList: function () {
			var id = $(this).prop('id');
			/* title 확인 */
			$('#' + id).codeLayer('setCodeTitle');
			/* list 생성 */
			var colGroup = '';
			var colList = '';
			for (var i = 0; i < $.fn.codeLayer.options[id].colKeys.length; i++) {
				if (i < ($.fn.codeLayer.options[id].colKeys.length - 1)) {
					colGroup += '<col width="' + ($.fn.codeLayer.options[id].colWidth[i] || ($.fn.codeLayer.options[id].option.width / $.fn.codeLayer.options[id].colHeaders.length)) + '"/>';
				}
			}
			colGroup = '<colgroup>' + colGroup + '<col width=""/></colgroup>';
			$('#' + id).find('.pop_con').append('<div class="com_ta2 ova_sc cursor_p bg_lightgray" style="height:333px"><table id="' + id + '_list">' + colGroup + '</table></div>');

			for (var i = 0; i < 100; i++) {
				$('#' + id).find('#' + id + '_list').append('<tr><td>1111</td><td>01가2345</td></tr>');
			}
		}
	};

	$.fn.codeLayer = function (method) {
		if (typeof method === 'object' || !method) {
			return methods.init.apply(this, arguments);
		} else if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else {
			$.error('Method ' + method + ' does not exist on method..');
		}
	};
})(jQuery);
