/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	//config.extraPlugins = 'webkitdrag,tableresize,preview,imagepaste';
	config.font_defaultLabel = '굴림';
    config.font_names = '굴림/Gulim;돋움/Dotum;바탕/Batang;궁서/Gungsuh;Arial/Arial;Comic Sans MS/Comic Sans MS;Courier New/Courier New;Georgia/Georgia;Lucida Sans Unicode/Lucida Sans Unicode;Tahoma/Tahoma;Times New Roman/Times New Roman;Trebuchet MS/Trebuchet MS;Verdana/Verdana';
    config.filebrowserImageBrowseLinkUrl = '';

    config.toolbar = [
        ['Font', 'FontSize'],
        ['TextColor', 'BGColor', 'Bold', 'Italic', 'Underline'],
        ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
        ['Image', 'addImage', 'Table', 'HorizontalRule'], ['Source'], ['Preview']
    ];
    config.filebrowserUploadUrl = '/CM/CMCommon/CmCkeditorUploadAction';
    
    //외부에서 테이블이나 각종 스타일이 들어간 내용을 CKEDITOR로 붙여넣기할때CKEDITOR 설정
    config.pasteFromWordRemoveFontStyles = false;
    config.pasteFromWordRemoveStyles = false;
    config.allowedContent = true;
};
