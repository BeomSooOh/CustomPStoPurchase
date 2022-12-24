package neos.cmm.util;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import org.codehaus.jackson.map.ObjectMapper;

import bizbox.orgchart.helper.ConnectionHelper;
import bizbox.orgchart.helper.ConnectionHelperFactory;
import neos.cmm.vo.EventRequest;

public class CommonEventSend {
	
	private static String urlEventSend = BizboxAProperties.getProperty("BizboxA.event.url");

    @SuppressWarnings("unchecked")
	public static String commonEventSend(Map<String,Object> parameters) throws IOException {
    	
		EventRequest eventRequest = new EventRequest();
		
		eventRequest.setEventType(parameters.get("eventType").toString());
		eventRequest.setEventSubType(parameters.get("eventSubType").toString());		
		eventRequest.setGroupSeq(parameters.get("groupSeq").toString());
		eventRequest.setCompSeq(parameters.get("compSeq").toString());
		eventRequest.setSenderSeq(parameters.get("empSeq").toString());
		
		if(!parameters.containsKey("alertYn") || "".equals(parameters.get("alertYn"))) {
			eventRequest.setAlertYn("Y");
		}else {
			eventRequest.setAlertYn(parameters.get("alertYn").toString());
		}
		
		if(!parameters.containsKey("pushYn") || "".equals(parameters.get("pushYn"))) {
			eventRequest.setPushYn("Y");
		}else {
			eventRequest.setPushYn(parameters.get("pushYn").toString());
		}
		
		if(!parameters.containsKey("talkYn") || "".equals(parameters.get("talkYn"))) {
			eventRequest.setTalkYn("Y");
		}else {
			eventRequest.setTalkYn(parameters.get("talkYn").toString());
		}
		
		if(!parameters.containsKey("mailYn") || "".equals(parameters.get("mailYn"))) {
			eventRequest.setMailYn("Y");
		}else {
			eventRequest.setMailYn(parameters.get("mailYn").toString());
		}
		
		if(!parameters.containsKey("smsYn") || "".equals(parameters.get("smsYn"))) {
			eventRequest.setSmsYn("Y");
		}else {
			eventRequest.setSmsYn(parameters.get("smsYn").toString());
		}
		
		if(!parameters.containsKey("portalYn") || "".equals(parameters.get("portalYn"))) {
			eventRequest.setPortalYn("Y");
		}else {
			eventRequest.setPortalYn(parameters.get("portalYn").toString());
		}
		
		if(!parameters.containsKey("timelineYn") || "".equals(parameters.get("timelineYn"))) {
			eventRequest.setTimelineYn("Y");
		}else {
			eventRequest.setTimelineYn(parameters.get("timelineYn").toString());
		}
		
		if(!parameters.containsKey("langCode") || "".equals(parameters.get("langCode"))) {
			eventRequest.setLangCode("kr");
		}else {
			eventRequest.setLangCode(parameters.get("langCode").toString());
		}		
		
		eventRequest.setRecvEmpBulk(parameters.get("recvEmpBulk") == null ? "" : parameters.get("recvEmpBulk").toString());
		eventRequest.setRecvEmpBulkList((List<String>)parameters.get("recvEmpBulkList"));
		eventRequest.setRecvEmpList((List<Map<String,Object>>)parameters.get("recvEmpList"));
		
		eventRequest.setUrl(parameters.get("url").toString());
		eventRequest.setIgnoreCntYn("Y");
		eventRequest.setData((Map<String, Object>)parameters.get("eventData"));
		
		org.apache.log4j.Logger.getLogger( CommonEventSend.class ).debug( "EventService.eventSend eventRequest : " + eventRequest );
		org.apache.log4j.Logger.getLogger( CommonEventSend.class ).debug( "EventService.eventSend urlEventSend : " + urlEventSend );
		
		ConnectionHelper connect = ConnectionHelperFactory.createInstacne(urlEventSend + "/event/EventSend");

		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(eventRequest);
		
		String reqestResult = connect.requestData(json);
		org.apache.log4j.Logger.getLogger( CommonEventSend.class ).debug( "EventService.eventSend reqestResult : " + reqestResult );

		return reqestResult;

    }

}
