package neos.cmm.util.code.service.impl;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import neos.cmm.db.CommonSqlDAO;
import neos.cmm.util.code.service.SequenceService;

@Service("SequenceService")
public class SequenceServiceImpl implements SequenceService {
    @Resource(name = "commonSql")
    private CommonSqlDAO commonSql;

    @Override
    // @Transactional(propagation = Propagation.REQUIRES_NEW)
    public String getSequence(String seqName) {
        //System.out.println("seqName : " + seqName);
        return (String) commonSql.select("CommonCodeInfo.getSequence", seqName);
    }

}
