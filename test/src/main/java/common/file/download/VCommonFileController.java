package common.file.download;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import cmm.util.CommonUtil;
import common.helper.convert.CommonConvert;
import neos.cmm.util.AESCipher;

@Controller
public class VCommonFileController {

	@Resource(name = "CommonFileDAO")
	CommonFileDAO dao;

	@RequestMapping("/Common/File/Download.do")
	public void CommonFileDownload(HttpServletRequest request, @RequestParam Map<String, Object> param, HttpServletResponse response) {

		boolean exceptionStat = false;

		String groupSeq = "";
		String pathSeq = "";
		String fileId = "";
		String fileSn = "";
		String inLine = "N";
		String imgExt = "jpeg|bmp|gif|jpg|png";
		String applicationExt = "pdf";

		Map<String, Object> paramMap = new HashMap<String, Object>();
		Map<String, Object> groupPathMap = new HashMap<String, Object>();
		Map<String, Object> fileMap = new HashMap<String, Object>();

		try {
			inLine = CommonConvert.CommonGetStr(param.get("inLine"));
			String paramFileInfo = CommonConvert.CommonGetStr(param.get("file"));
			paramFileInfo = paramFileInfo.replaceAll(" ", "+");
			paramFileInfo = AESCipher.AES_Decode(paramFileInfo);

			groupSeq = paramFileInfo.split("_")[0];
			pathSeq = paramFileInfo.split("_")[1];
			fileId = paramFileInfo.split("_")[2];
			fileSn = paramFileInfo.split("_")[3];

			paramMap.put("groupSeq", groupSeq);
			paramMap.put("pathSeq", pathSeq);
            paramMap.put("osType", CommonUtil.osType());
			groupPathMap = dao.GetCommonFileGroupPath(paramMap);

			paramMap.put("fileId", fileId);
			paramMap.put("fileSn", fileSn);
			fileMap = dao.GetCommonFileSelect(paramMap);

			//System.out.println("groupSeq : " + groupSeq);
			//System.out.println("pathSeq : " + pathSeq);
			//System.out.println("fileId : " + fileId);
			//System.out.println("fileSn : " + fileSn);
			//System.out.println("paramMap : " + paramMap.toString());
			//System.out.println("groupPathMap : " + groupPathMap.toString());
			//System.out.println("fileMap : " + fileMap.toString());

			/* 파일 정보 점검 */
			if (groupPathMap == null) { throw new Exception("서버 저장경로 정보가 없습니다."); }
			if (fileMap == null) { throw new Exception("파일정보가 없습니다."); }
			String filePath = groupPathMap.get("absolPath") + File.separator + fileMap.get("fileStreCours");
			String fileName = fileMap.get("streFileName") + "." + fileMap.get("fileExtsn");
			String orgFileName = fileMap.get("orignlFileName") + "." + fileMap.get("fileExtsn");
			String fileExtsn = CommonConvert.CommonGetStr(fileMap.get("fileExtsn"));

			/* 파일 반환 준비 */
			File file = new File(filePath + File.separator + fileName);
			FileInputStream fileInputStream = new FileInputStream(file);
			BufferedInputStream bufferedInputStream = new BufferedInputStream(fileInputStream);
			ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();

			/* 파일 버퍼 기록 */
			int iByte;
			byte buffer[] = new byte[4096];
			while ((iByte = bufferedInputStream.read(buffer)) != -1) {
				byteArrayOutputStream.write(buffer, 0, iByte);
			}

			// 파일 인코딩
			String browser = request.getHeader("User-Agent");
			if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Edge")) {
				orgFileName = URLEncoder.encode(orgFileName, "UTF-8").replaceAll("\\+", "%20");
			}
			else {
				orgFileName = new String(orgFileName.getBytes("UTF-8"), "ISO-8859-1");
			}

			// 컨텐츠 타입 설정
			String type = "";
			if (fileExtsn != null && !fileExtsn.equals("")) {
				// 이미지 컨텐츠타입 설정
				if (imgExt.indexOf(fileExtsn.toLowerCase()) != -1) {

					if (fileExtsn.toLowerCase().equals("jpg")) {
						type = "image/jpeg";
					}
					else {
						type = "image/" + fileExtsn.toLowerCase();
					}
				}
				// 어플리케인션 컨텐츠타입 설정
				else if (applicationExt.indexOf(fileExtsn.toLowerCase()) != -1) {
					type = "application/" + fileExtsn.toLowerCase();
				}
			}

			if (!type.equals("")) {
				response.setHeader("Content-Type", type);
			}
			else {
				response.setContentType(this.GetContentType(file));
				response.setHeader("Content-Transfer-Encoding", "binary;");
			}

			response.setHeader("Content-Disposition", ((!type.equals("") && inLine.equals("Y")) ? "inline;filename=\"" + orgFileName + "\"" : "attachment;filename=\"" + orgFileName + "\""));
			response.setContentLength(byteArrayOutputStream.size());
			byteArrayOutputStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
		catch (Exception e) {
			exceptionStat = true;
		}

		if (exceptionStat) { return; }
	}

	@RequestMapping("/Common/File/DownloadMake.do")
	public ModelAndView CommonFileDownloadMake(HttpServletRequest request, @RequestParam Map<String, Object> param, HttpServletResponse response) {

		ModelAndView mv = new ModelAndView();
		String groupSeq = "";
		String pathSeq = "";
		String fileId = "";
		String fileSn = "";
		String file = "";

		groupSeq = CommonConvert.CommonGetStr(param.get("groupSeq"));
		pathSeq = CommonConvert.CommonGetStr(param.get("pathSeq"));
		fileId = CommonConvert.CommonGetStr(param.get("fileId"));
		fileSn = CommonConvert.CommonGetStr(param.get("fileSn"));

		try {
			file = AESCipher.AES_Encode(groupSeq + "_" + pathSeq + "_" + fileId + "_" + fileSn);
		}
		catch (Exception e) {
			file = "";
		}

		mv.setViewName("jsonView");
		mv.addObject("file", file);

		return mv;
	}

	private String GetContentType(File file) {
		String fileName = file.getName();
		int idx = fileName.lastIndexOf(".");

		String fileExtsn = fileName.substring(idx + 1);
		String contentType = "application/octet-stream";

		if (fileExtsn.toLowerCase().equals("aac")) {
			contentType = "audio/aac";
		}
		else if (fileExtsn.toLowerCase().equals("abw")) {
			contentType = "application/x-abiword";
		}
		else if (fileExtsn.toLowerCase().equals("arc")) {
			contentType = "application/octet-stream";
		}
		else if (fileExtsn.toLowerCase().equals("avi")) {
			contentType = "video/x-msvideo";
		}
		else if (fileExtsn.toLowerCase().equals("azw")) {
			contentType = "application/vnd.amazon.ebook";
		}
		else if (fileExtsn.toLowerCase().equals("bin")) {
			contentType = "application/octet-stream";
		}
		else if (fileExtsn.toLowerCase().equals("bz")) {
			contentType = "application/x-bzip";
		}
		else if (fileExtsn.toLowerCase().equals("bz2")) {
			contentType = "application/x-bzip2";
		}
		else if (fileExtsn.toLowerCase().equals("csh")) {
			contentType = "application/x-csh";
		}
		else if (fileExtsn.toLowerCase().equals("css")) {
			contentType = "text/css";
		}
		else if (fileExtsn.toLowerCase().equals("csv")) {
			contentType = "text/csv";
		}
		else if (fileExtsn.toLowerCase().equals("doc")) {
			contentType = "application/msword";
		}
		else if (fileExtsn.toLowerCase().equals("epub")) {
			contentType = "application/epub+zip";
		}
		else if (fileExtsn.toLowerCase().equals("gif")) {
			contentType = "image/gif";
		}
		else if (fileExtsn.toLowerCase().equals("htm")) {
			contentType = "text/html";
		}
		else if (fileExtsn.toLowerCase().equals("html")) {
			contentType = "text/html";
		}
		else if (fileExtsn.toLowerCase().equals("ico")) {
			contentType = "image/x-icon";
		}
		else if (fileExtsn.toLowerCase().equals("ics")) {
			contentType = "text/calendar";
		}
		else if (fileExtsn.toLowerCase().equals("jar")) {
			contentType = "application/java-archive";
		}
		else if (fileExtsn.toLowerCase().equals("jpeg")) {
			contentType = "image/jpeg";
		}
		else if (fileExtsn.toLowerCase().equals("jpg")) {
			contentType = "image/jpeg";
		}
		else if (fileExtsn.toLowerCase().equals("js")) {
			contentType = "application/js";
		}
		else if (fileExtsn.toLowerCase().equals("json")) {
			contentType = "application/json";
		}
		else if (fileExtsn.toLowerCase().equals("mid")) {
			contentType = "audio/midi";
		}
		else if (fileExtsn.toLowerCase().equals("midi")) {
			contentType = "audio/midi";
		}
		else if (fileExtsn.toLowerCase().equals("mpeg")) {
			contentType = "video/mpeg";
		}
		else if (fileExtsn.toLowerCase().equals("mpkg")) {
			contentType = "application/vnd.apple.installer+xml";
		}
		else if (fileExtsn.toLowerCase().equals("odp")) {
			contentType = "application/vnd.oasis.opendocument.presentation";
		}
		else if (fileExtsn.toLowerCase().equals("ods")) {
			contentType = "application/vnd.oasis.opendocument.spreadsheet";
		}
		else if (fileExtsn.toLowerCase().equals("odt")) {
			contentType = "application/vnd.oasis.opendocument.text";
		}
		else if (fileExtsn.toLowerCase().equals("oga")) {
			contentType = "audio/ogg";
		}
		else if (fileExtsn.toLowerCase().equals("ogv")) {
			contentType = "video/ogg";
		}
		else if (fileExtsn.toLowerCase().equals("ogx")) {
			contentType = "application/ogg";
		}
		else if (fileExtsn.toLowerCase().equals("pdf")) {
			contentType = "application/pdf";
		}
		else if (fileExtsn.toLowerCase().equals("ppt")) {
			contentType = "application/vnd.ms-powerpoint";
		}
		else if (fileExtsn.toLowerCase().equals("rar")) {
			contentType = "application/x-rar-compressed";
		}
		else if (fileExtsn.toLowerCase().equals("rtf")) {
			contentType = "application/rtf";
		}
		else if (fileExtsn.toLowerCase().equals("sh")) {
			contentType = "application/x-sh";
		}
		else if (fileExtsn.toLowerCase().equals("svg")) {
			contentType = "image/svg+xml";
		}
		else if (fileExtsn.toLowerCase().equals("swf")) {
			contentType = "application/x-shockwave-flash";
		}
		else if (fileExtsn.toLowerCase().equals("tar")) {
			contentType = "application/x-tar";
		}
		else if (fileExtsn.toLowerCase().equals("tif")) {
			contentType = "image/tiff";
		}
		else if (fileExtsn.toLowerCase().equals("tiff")) {
			contentType = "image/tiff";
		}
		else if (fileExtsn.toLowerCase().equals("ttf")) {
			contentType = "application/x-font-ttf";
		}
		else if (fileExtsn.toLowerCase().equals("vsd")) {
			contentType = "application/vnd.visio";
		}
		else if (fileExtsn.toLowerCase().equals("wav")) {
			contentType = "audio/x-wav";
		}
		else if (fileExtsn.toLowerCase().equals("weba")) {
			contentType = "audio/webm";
		}
		else if (fileExtsn.toLowerCase().equals("webm")) {
			contentType = "video/webm";
		}
		else if (fileExtsn.toLowerCase().equals("webp")) {
			contentType = "image/webp";
		}
		else if (fileExtsn.toLowerCase().equals("woff")) {
			contentType = "application/x-font-woff";
		}
		else if (fileExtsn.toLowerCase().equals("xhtml")) {
			contentType = "application/xhtml+xml";
		}
		else if (fileExtsn.toLowerCase().equals("xls") || fileExtsn.toLowerCase().equals("xlsx")) {
			contentType = "application/vnd.ms-excel";
		}
		else if (fileExtsn.toLowerCase().equals("xml")) {
			contentType = "application/xml";
		}
		else if (fileExtsn.toLowerCase().equals("xul")) {
			contentType = "application/vnd.mozilla.xul+xml";
		}
		else if (fileExtsn.toLowerCase().equals("zip")) {
			contentType = "application/zip";
		}
		else if (fileExtsn.toLowerCase().equals("7z")) {
			contentType = "application/x-7z-compressed";
		}

		return contentType;
	}
}
