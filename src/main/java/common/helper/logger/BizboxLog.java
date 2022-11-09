package common.helper.logger;

import org.json.simple.JSONObject;

import bizbox.statistic.data.dto.ActionDTO;
import bizbox.statistic.data.dto.CreatorInfoDTO;
import bizbox.statistic.data.enumeration.EnumActionStep1;
import bizbox.statistic.data.enumeration.EnumActionStep2;
import bizbox.statistic.data.enumeration.EnumActionStep3;
import bizbox.statistic.data.enumeration.EnumDevice;
import bizbox.statistic.data.enumeration.EnumModuleName;
import bizbox.statistic.data.service.ModuleLogService;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.vo.common.BizboxLogVO;

public class BizboxLog {

	public static void test() throws NotFoundLoginSessionException {
		BizboxLogVO logParam = new BizboxLogVO();
		logParam.setGroupSeq(CommonConvert.CommonGetEmpVO().getGroupSeq());
		logParam.setCompSeq(CommonConvert.CommonGetEmpVO().getCompSeq());
		logParam.setDeptSeq(CommonConvert.CommonGetEmpVO().getOrgnztId());
		logParam.setEmpSeq(CommonConvert.CommonGetEmpVO().getUniqId());
	}

	/* 작성 */
	/* 작성 - 항목 */
	/* 작성 - 항목 - 추가 */
	@SuppressWarnings("unchecked")
	public static void ExpendWriteListAdd(BizboxLogVO logParam) {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendWrite, EnumActionStep2.ExpendList,
				EnumActionStep3.ExpendAdd);

		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("expend_seq", logParam.getExpendSeq());
		actionID.put("interface_type", logParam.getInterfaceType());
		actionID.put("sync_id", logParam.getSyncId());
		actionID.put("erp_type", logParam.getErpType());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}

	/* 작성 - 카드 */
	/* 작성 - 카드 - 추가 */
	@SuppressWarnings("unchecked")
	public static void ExpendWriteCardAdd(BizboxLogVO logParam) {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendWrite, EnumActionStep2.ExpendCard,
				EnumActionStep3.ExpendAdd);

		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("expend_seq", logParam.getExpendSeq());
		actionID.put("interface_type", logParam.getInterfaceType());
		actionID.put("sync_id", logParam.getSyncId());
		actionID.put("erp_type", logParam.getErpType());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}

	/* 작성 - 계산서 */
	/* 작성 - 계산서 - 추가 */
	@SuppressWarnings("unchecked")
	public static void ExpendWriteEtaxAdd(BizboxLogVO logParam) {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendWrite, EnumActionStep2.ExpendEtax,
				EnumActionStep3.ExpendAdd);

		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("expend_seq", logParam.getExpendSeq());
		actionID.put("interface_type", logParam.getInterfaceType());
		actionID.put("sync_id", logParam.getSyncId());
		actionID.put("erp_type", logParam.getErpType());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}

	/* 작성 - 전자결재 연동 */
	@SuppressWarnings("unchecked")
	public static void ExpendOutProcess(BizboxLogVO logParam) {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendWrite, EnumActionStep2.ExpendOutProcess,
				EnumActionStep3.ActionNone);

		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("expend_seq", logParam.getExpendSeq());
		actionID.put("approkey", logParam.getApproKey());
		actionID.put("erp_type", logParam.getErpType());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}

	/* 연동 */
	/* 연동 - 계산서 */
	/* 연동 - 계산서 - 이관 */
	@SuppressWarnings("unchecked")
	public static void ExpendInterfaceEtaxTransfer(BizboxLogVO logParam) {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendInterface, EnumActionStep2.ExpendEtax,
				EnumActionStep3.ExpendTransfer);

		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("interface_type", logParam.getInterfaceType());
		actionID.put("sync_id", logParam.getSyncId());
		actionID.put("transfer_type", logParam.getTransferType());
		actionID.put("transfer_seq", logParam.getTransferSeq());
		actionID.put("receive_seq", logParam.getReceiveSeq());
		actionID.put("erp_type", logParam.getErpType());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}

	/* 연동 - 계산서 - 이관 취소 */
	@SuppressWarnings("unchecked")
	public static void ExpendInterfaceEtaxTransferReturn(BizboxLogVO logParam) {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendInterface, EnumActionStep2.ExpendEtax,
				EnumActionStep3.ExpendTransferReturn);

		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("interface_type", logParam.getInterfaceType());
		actionID.put("sync_id", logParam.getSyncId());
		actionID.put("transfer_type", logParam.getTransferType());
		actionID.put("transfer_seq", logParam.getTransferSeq());
		actionID.put("receive_seq", logParam.getReceiveSeq());
		actionID.put("erp_type", logParam.getErpType());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}

	/* 연동 - 카드 - 이관 */
	@SuppressWarnings("unchecked")
	public static void ExpendInterfaceCardTransfer(BizboxLogVO logParam) {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendInterface, EnumActionStep2.ExpendCard,
				EnumActionStep3.ExpendTransfer);

		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("interface_type", logParam.getInterfaceType());
		actionID.put("sync_id", logParam.getSyncId());
		actionID.put("transfer_type", logParam.getTransferType());
		actionID.put("transfer_seq", logParam.getTransferSeq());
		actionID.put("receive_seq", logParam.getReceiveSeq());
		actionID.put("erp_type", logParam.getErpType());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}

	/* 연동 - 카드 - 이관 취소 */
	@SuppressWarnings("unchecked")
	public static void ExpendInterfaceCardTransferReturn(BizboxLogVO logParam) {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendInterface, EnumActionStep2.ExpendCard,
				EnumActionStep3.ExpendTransferReturn);

		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("interface_type", logParam.getInterfaceType());
		actionID.put("sync_id", logParam.getSyncId());
		actionID.put("transfer_type", logParam.getTransferType());
		actionID.put("transfer_seq", logParam.getTransferSeq());
		actionID.put("receive_seq", logParam.getReceiveSeq());
		actionID.put("erp_type", logParam.getErpType());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}

	/* ERP연동 */
	/* ERP연동 - 자동전표 */
	/* ERP연동 - 자동전표 - 전송 */
	@SuppressWarnings("unchecked")
	public static void ExpendConnectERPAutoDocuSend(BizboxLogVO logParam) {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendConnectERP, EnumActionStep2.ExpendAutoDocu,
				EnumActionStep3.ExpendSendReturn);

		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("expend_seq", logParam.getExpendSeq());
		actionID.put("erp_send_yn", logParam.getErpSendYn());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}

	/* ERP연동 - 자동전표 - 전송 취소 */
	@SuppressWarnings("unchecked")
	public static void ExpendConnectERPAutoDocuSendReturn(BizboxLogVO logParam) throws Exception {
		ActionDTO aDTO = new ActionDTO(EnumActionStep1.ExpendConnectERP, EnumActionStep2.ExpendAutoDocu,
				EnumActionStep3.ExpendSendReturn);

		/* ==================================================================================================== */
		if(logParam.getGroupSeq() == null || logParam.getGroupSeq().equals("")) {
			throw new Exception("[로그수집기] 파라미터가 누락되었습니다. (groupSeq)");
		}
		else if(logParam.getCompSeq() == null || logParam.getCompSeq().equals("")) {
			throw new Exception("[로그수집기] 파라미터가 누락되었습니다. (compSeq)");
		}
		else if(logParam.getDeptSeq() == null || logParam.getDeptSeq().equals("")) {
			throw new Exception("[로그수집기] 파라미터가 누락되었습니다. (deptSeq)");
		}
		else if(logParam.getEmpSeq() == null || logParam.getEmpSeq().equals("")) {
			throw new Exception("[로그수집기] 파라미터가 누락되었습니다. (empSeq)");
		}
		else if(logParam.getExpendSeq() == null || logParam.getExpendSeq().equals("")) {
			throw new Exception("[로그수집기] 파라미터가 누락되었습니다. (expendSeq)");
		}
		else if(logParam.getErpSendYn() == null || logParam.getErpSendYn().equals("")) {
			throw new Exception("[로그수집기] 파라미터가 누락되었습니다. (erpSendYn)");
		}
		/* ==================================================================================================== */
		
		CreatorInfoDTO ciDTO = new CreatorInfoDTO();
		ciDTO.setGroupSeq(logParam.getGroupSeq());
		ciDTO.setCompSeq(logParam.getCompSeq());
		ciDTO.setDeptSeq(logParam.getDeptSeq());
		ciDTO.setEmpSeq(logParam.getEmpSeq());

		JSONObject actionID = new JSONObject();
		actionID.put("expend_seq", logParam.getExpendSeq());
		actionID.put("erp_send_yn", logParam.getErpSendYn());

		ModuleLogService.getInstance().writeStatisticLog(EnumModuleName.MODULE_EXPEND, ciDTO, aDTO, actionID,
				logParam.getActionIP(), EnumDevice.Web);
	}
}