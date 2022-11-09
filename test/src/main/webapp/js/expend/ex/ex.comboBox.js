/**
 * combo box
 */

function exComboBox(target, source, changeEvent, selectEvent) {
	var $comboBox = $(target);
	changeEvent = (changeEvent || '');

	if (typeof source === 'string') {
		source = JSON.parse(source);
	}

	if (typeof source === 'object') {
		if (JSON.stringify(source).indexOf('[') != 0) {
			source = JSON.parse('[' + JSON.stringify(source) + ']');
		}

		$comboBox.kendoComboBox({
			dataSource : source,
			dataTextField : 'commonName',
			dataValueField : 'commonCode',
			index : 0,
			change : function(e) {
				if (typeof changeEvent === 'function') {
					changeEvent();
				} else {
					return;
				}
			},
			select : function(e) {
				if (typeof selectEvent === 'function') {
					selectEvent();
				} else {
					return;
				}
			}
		});
	} else {
		return;
	}
}