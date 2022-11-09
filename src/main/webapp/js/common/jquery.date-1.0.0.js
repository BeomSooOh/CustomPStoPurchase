(function ($) {
	var methods = {
		fromTo: function () {

		}
	};
	$.fn.date = function (method) {
		if (typeof method === 'object' || !method) {
			// console.log('call methods[' + method + '] >> ' + $(this).prop('id') || '');
			return methods.init.apply(this, arguments);
		} else if (methods[method]) {
			// console.log('call methods[' + method + '] >> ' + $(this).prop('id') || '');
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else {
			$.error('Method ' + method + ' does not exist on method..');
		}
	};
})(jQuery);
