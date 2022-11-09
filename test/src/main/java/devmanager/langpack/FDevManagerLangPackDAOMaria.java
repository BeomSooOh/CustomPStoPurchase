package devmanager.langpack;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Repository ( "FDevManagerLangPackDAOMaria" )
public class FDevManagerLangPackDAOMaria extends EgovComAbstractDAO {

	public Map<String, Object> SelectLanguageList ( Map<String, Object> params, PaginationInfo paginationInfo ) {
		return (Map<String, Object>) this.listOfPaging2( params, paginationInfo, "LangPackInfoDAO.SelectLanguageList" );
	}

	public Map<String, Object> SelectLanguageEmptyList ( Map<String, Object> params, PaginationInfo paginationInfo ) {
		return (Map<String, Object>) this.listOfPaging2( params, paginationInfo, "LangPackInfoDAO.SelectLanguageEmptyList" );
	}

	public int InsertLanguageData ( Map<String, Object> params ) {
		//this.insert( "LangPackInfoDAO.InsertLanguageData", params );
		insert( "LangPackInfoDAO.InsertLanguageData", params );
		return 0;
	}

	public int UpdateLanguageData ( Map<String, Object> params ) {
		//this.update( "LangPackInfoDAO.UpdateLanguageData", params );
		update( "LangPackInfoDAO.UpdateLanguageData", params );
		return 0;
	}
}
