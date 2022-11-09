package devmanager.langpack;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.CommonInterface.commonCode;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Service ( "FDevManagerLangPackServiceMaria" )
public class FDevManagerLangPackServiceImplMaria implements FDevManagerLangPackService {

	@Resource ( name = "FDevManagerLangPackDAOMaria" )
	private FDevManagerLangPackDAOMaria langpackMariaDAO;

	@Override
	public Map<String, Object> SelectLanguageList ( Map<String, Object> params ) throws Exception {
		PaginationInfo paginationInfo = new PaginationInfo( );
		paginationInfo.setCurrentPageNo( EgovStringUtil.zeroConvert( params.get( "page" ) ) );
		paginationInfo.setPageSize( EgovStringUtil.zeroConvert( params.get( "pageSize" ) ) );
		if ( params.get( "code" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			return langpackMariaDAO.SelectLanguageList( params, paginationInfo );
		}
		else {
			return langpackMariaDAO.SelectLanguageEmptyList( params, paginationInfo );
		}
	}

	@Override
	public int InsertOrUpdateLanguageData ( Map<String, Object> params ) throws Exception {
		if ( params.get( commonCode.LANGCODE ).toString( ).equals( commonCode.EMPTYSTR ) ) {
			return langpackMariaDAO.InsertLanguageData( params );
		}
		else {
			return langpackMariaDAO.UpdateLanguageData( params );
		}
	}
}
