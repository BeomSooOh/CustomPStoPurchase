package egovframework.com.sym.mnu.mcm.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.sym.mnu.mcm.service.EgovMenuCreateManageService;
import egovframework.com.sym.mnu.mcm.service.MenuCreatVO;
import egovframework.com.sym.mnu.mcm.service.MenuSiteMapVO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
/**
 * 메뉴목록, 사이트맵 생성을 처리하는 비즈니스 구현 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2011.07.01  서준식          EgovMenuManageServiceImpl에서 메뉴 생성 관련 부분 분리
 *   2011.10.07  이기하          finally문을 추가하여 에러시 자원반환할 수 있도록 추가
 *   2011.10.12  이기하			 사이트맵 생성시 특수문자 치환
 *
 *
 * </pre>
 */
@Service("meunCreateManageService")
public class EgovMenuCreateManageServiceImpl extends AbstractServiceImpl implements EgovMenuCreateManageService{

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name="menuCreateManageDAO")
    private MenuCreateManageDAO menuCreateManageDAO;

	/**
	 * ID 존재여부를 조회
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
    public int selectUsrByPk(Map<String, Object> paramMap) throws Exception {
        return menuCreateManageDAO.selectUsrByPk(paramMap);
	}

    /**
	 * 메뉴생성 내역을 조회
	 * @param  vo MenuCreatVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMenuCreatList(MenuCreatVO vo) throws Exception {
   		return menuCreateManageDAO.selectMenuCreatList(vo);
	}

	/**
	 * 화면에 조회된 메뉴정보로 메뉴생성내역 데이터베이스에서 입력
	 * @param checkedAuthorForInsert  String
	 * @param checkedMenuNoForInsert String
	 * @exception Exception
	 */
	public void insertMenuCreatList(
			String checkedAuthorForInsert,
			String checkedMenuNoForInsert
			) throws Exception{
		MenuCreatVO menuCreatVO = null;
		int authorCnt    = 0;
		String [] insertMenuNo = checkedMenuNoForInsert.split(",");

		String     insertAuthor = checkedAuthorForInsert;
		menuCreatVO = new MenuCreatVO();
		menuCreatVO.setAuthorCode(insertAuthor);
		authorCnt = menuCreateManageDAO.selectMenuCreatCnt(menuCreatVO);

        // 이전에 존재하는 권한코드에 대한 메뉴설정내역 삭제
		if(authorCnt>0){
			menuCreateManageDAO.deleteMenuCreat(menuCreatVO);
		}
		for (int i=0; i<insertMenuNo.length ; i++){
			menuCreatVO.setAuthorCode(insertAuthor);
			menuCreatVO.setMenuNo(Long.parseLong(insertMenuNo[i]));
			menuCreateManageDAO.insertMenuCreat(menuCreatVO);
		}
	}

	/**
	 * 메뉴생성관리 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public Map<String, Object> selectMenuCreatManagList(Map<String, Object> paramMap, PaginationInfo paginationInfo) throws Exception {
		Map<String, Object> resultMap = null;
		resultMap = menuCreateManageDAO.selectMenuCreatManagList(paramMap,paginationInfo);
		return resultMap;
	}

	/**
	 * ID에 대한 권한코드를 조회
	 * @param vo ComDefaultVO
	 * @return MenuCreatVO
	 * @exception Exception
	 */
	public MenuCreatVO selectAuthorByUsr(ComDefaultVO vo) throws Exception{
        return menuCreateManageDAO.selectAuthorByUsr(vo);
	}



	/**
	 * 메뉴생성관리 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
    public int selectMenuCreatManagTotCnt(ComDefaultVO vo) throws Exception {
        return menuCreateManageDAO.selectMenuCreatManagTotCnt(vo);
	}

	/**
	 * 메뉴생성 사이트맵 내용 조회
	 * @param vo MenuSiteMapVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMenuCreatSiteMapList(MenuSiteMapVO vo) throws Exception {
   		return menuCreateManageDAO.selectMenuCreatSiteMapList(vo);
	}

	/**
	 * 사용자 권한별 사이트맵 내용 조회
	 * @param vo MenuSiteMapVO
	 * @return List
	 * @exception Exception
	 */
	public List selectSiteMapByUser(MenuSiteMapVO vo) throws Exception{
   		return menuCreateManageDAO.selectSiteMapByUser(vo);
	}

	/**
	 * 사이트맵 등록
	 * @param menuSiteMapvo MenuSiteMapVO
	 * @param vHtmlValue   String
	 * @return boolean
	 * @exception Exception
	 */
	public boolean creatSiteMap(MenuSiteMapVO menuSiteMapvo, String vHtmlValue ) throws Exception {
		boolean chkCreat     = false;
		String  vSiteMapName = null;
		int     siteMapCnt   = 0;
		String  newMapCreatId = null;
		MenuCreatVO menuCreatVO = new MenuCreatVO();

		menuCreatVO.setMenuNo(menuSiteMapvo.getMenuNo());
		menuCreatVO.setAuthorCode(menuSiteMapvo.getAuthorCode());
//		vSiteMapName  = menuSiteMapvo.getTmp_rootPath()+"/"+menuSiteMapvo.getBndeFileNm();
		vSiteMapName  = menuSiteMapvo.getTmpRootPath()+menuSiteMapvo.getBndeFilePath()+menuSiteMapvo.getBndeFileNm();
		chkCreat = siteMapCreat(vSiteMapName,vHtmlValue);
		if(chkCreat){
			siteMapCnt = menuCreateManageDAO.selectSiteMapCnt(menuSiteMapvo);
			if(siteMapCnt>0){
				menuCreatVO.setMapCreatId(menuSiteMapvo.getMapCreatId() + Integer.toString(siteMapCnt));
				menuSiteMapvo.setMapCreatId(menuSiteMapvo.getMapCreatId() + Integer.toString(siteMapCnt));
			}else{
				menuCreatVO.setMapCreatId(menuSiteMapvo.getMapCreatId());
			}
			menuCreateManageDAO.creatSiteMap(menuSiteMapvo);
   			menuCreateManageDAO.updateMenuCreat(menuCreatVO);

		}
		return chkCreat;
	}

	/**
	 * 메뉴생성 사이트맵 Html 파일 생성
	 * @param vSiteMapName String
	 * @param vHtmlValue   String
	 * @return boolean
	 * @exception Exception
	 */
	private boolean siteMapCreat(String vSiteMapName, String vHtmlValue)throws Exception{
		boolean success = false;
	    String fileName = null;
	    char fileSeparator     = File.separatorChar;
	    BufferedWriter out = null;
		try {
			fileName = vSiteMapName.replace('\\', fileSeparator).replace('/', fileSeparator);
			File file = new File(fileName);
			out = new BufferedWriter(new FileWriter(file));

			// 2011.10.12 사이트맵 생성시 특수문자 치환
			vHtmlValue = vHtmlValue.replaceAll("&lt;", "<");
			vHtmlValue = vHtmlValue.replaceAll("&gt;", ">");
			vHtmlValue = vHtmlValue.replaceAll("&quot;", "\"");
			vHtmlValue = vHtmlValue.replaceAll("&apos;", "'");

			out.write(vHtmlValue);
 			success = true;
		} catch (IOException e) {
	    	log.error("Exception:  "  +  e.getClass().getName());
	    	log.error("Exception  Message:  "  +  e.getMessage());
        // 2011.10.07 사용한 자원 반환 추가
		} finally {
			if (out !=null) {
				try {
					out.close();
				} catch(Exception ignore) {
					log.error("Exception:  "  +  ignore.getClass().getName());
					log.error("Exception  Message:  "  +  ignore.getMessage());
				}
			}
		}
		return  success ;
	}
}