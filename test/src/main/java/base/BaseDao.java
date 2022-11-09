package base;

import org.springframework.stereotype.Repository;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import model.common.Mconnect;

@Repository("BaseDao")
public class BaseDao extends EgovComAbstractDAO {

    // get t_co_erp
    public Mconnect GetCoErp(String compSeq) {
        return (Mconnect) this.select("Base.GetCoErp", compSeq);
    }
}
