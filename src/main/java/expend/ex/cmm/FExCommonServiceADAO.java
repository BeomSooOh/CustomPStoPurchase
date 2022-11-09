package expend.ex.cmm;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository ( "FExCommonServiceADAO" )
public class FExCommonServiceADAO extends EgovComAbstractDAO {

    public Map<String, Object> CommonCodeSelect (Map<String, Object> params ) throws Exception {
        Map<String, Object> resultMap = new HashMap<String, Object>( );
        try {
            resultMap = (Map<String, Object>) select( "CommonCodeInfo.selectCommonInfo", params );
        }
        catch ( Exception e ) {
            //e.printStackTrace();
            throw e;
        }
        return resultMap;
    }

    public Map<String, Object> GroupInfoSelect (Map<String, Object> params ) throws Exception {
        Map<String, Object> resultMap = new HashMap<String, Object>( );
        try {
            resultMap = (Map<String, Object>) select( "OrgChart.selectGroupInfo", params );
        }
        catch ( Exception e ) {
            //e.printStackTrace();
            throw e;
        }
        return resultMap;
    }

}
