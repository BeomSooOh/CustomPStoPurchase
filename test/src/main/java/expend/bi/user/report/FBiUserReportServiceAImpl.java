package expend.bi.user.report;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


@Service ( "FBiUserReportServiceA" )
public class FBiUserReportServiceAImpl implements FBiUserReportService {

	@Resource ( name = "FBiUserReportServiceADAO" )
	private FBiUserReportServiceADAO daoA;
}