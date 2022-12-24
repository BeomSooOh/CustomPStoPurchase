INSERT IGNORE INTO neos.t_alert_setting
(comp_seq, group_seq, alert_type, alert_yn, push_yn, talk_yn, mail_yn, sms_yn, portal_yn, timeline_yn, use_yn, create_seq, create_date, modify_seq, modify_date, divide_type, link_event)
VALUES('SYSTEM', 'SYSTEM', 'PURCHASE001', 'Y', 'Y', 'N', 'N', 'N', 'Y', 'N', 'Y', '0', NULL, NULL, NULL, 'CM', NULL);

INSERT IGNORE INTO neos.t_co_event_setting
(`type`, code, portal_yn, timeline_yn, datas, seq, sub_seq, content_type, view_type, web_view_type, messenger_view_type, action_type, web_action_type)
VALUES('CUST', 'PURCHASE001', 'Y', 'N', 'title|contents', '', '', '0', 'B', 'Z', 'Z', 'Z', 'Z');

INSERT IGNORE INTO neos.t_co_event_message
(`type`, code, lang_code, message_no_preview, param_no_preview, message_title_push, param_title_push, message_push, param_push, message_talk, param_talk, message_sms, param_sms, message_mail, param_mail, message_portal, param_portal, message_title_talk, param_title_talk, message_title_sms, param_title_sms, message_title_mail, param_title_mail, message_title_portal, param_title_portal)
VALUES('CUST', 'PURCHASE001', 'cn', '', '', '%s', 'title', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'title', '%s', 'title', '%s', 'title', '%s', 'title');
INSERT IGNORE INTO neos.t_co_event_message
(`type`, code, lang_code, message_no_preview, param_no_preview, message_title_push, param_title_push, message_push, param_push, message_talk, param_talk, message_sms, param_sms, message_mail, param_mail, message_portal, param_portal, message_title_talk, param_title_talk, message_title_sms, param_title_sms, message_title_mail, param_title_mail, message_title_portal, param_title_portal)
VALUES('CUST', 'PURCHASE001', 'en', '', '', '%s', 'title', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'title', '%s', 'title', '%s', 'title', '%s', 'title');
INSERT IGNORE INTO neos.t_co_event_message
(`type`, code, lang_code, message_no_preview, param_no_preview, message_title_push, param_title_push, message_push, param_push, message_talk, param_talk, message_sms, param_sms, message_mail, param_mail, message_portal, param_portal, message_title_talk, param_title_talk, message_title_sms, param_title_sms, message_title_mail, param_title_mail, message_title_portal, param_title_portal)
VALUES('CUST', 'PURCHASE001', 'jp', '', '', '%s', 'title', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'title', '%s', 'title', '%s', 'title', '%s', 'title');
INSERT IGNORE INTO neos.t_co_event_message
(`type`, code, lang_code, message_no_preview, param_no_preview, message_title_push, param_title_push, message_push, param_push, message_talk, param_talk, message_sms, param_sms, message_mail, param_mail, message_portal, param_portal, message_title_talk, param_title_talk, message_title_sms, param_title_sms, message_title_mail, param_title_mail, message_title_portal, param_title_portal)
VALUES('CUST', 'PURCHASE001', 'kr', '', '', '%s', 'title', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'contents', '%s', 'title', '%s', 'title', '%s', 'title', '%s', 'title');

INSERT IGNORE INTO neos.t_alert_admin
select
b.comp_seq, b.group_seq, a.alert_type, a.alert_yn, a.push_yn, a.talk_yn, a.mail_yn, a.sms_yn, a.portal_yn, a.timeline_yn, a.use_yn, a.create_seq, a.create_date, a.modify_seq, a.modify_date, a.divide_type, a.link_event
from neos.t_alert_setting a
join neos.t_co_comp b on b.comp_seq is not null
where a.alert_type = 'PURCHASE001';