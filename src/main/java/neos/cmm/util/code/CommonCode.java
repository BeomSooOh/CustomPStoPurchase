package neos.cmm.util.code;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import neos.cmm.util.code.service.impl.CommonCodeDAO;

@Controller
@RequestMapping(value = "/cmm/system/")
public class CommonCode {
    @Resource(name = "CommonCodeDAO")
    private CommonCodeDAO commonCodeDAO;

    /**
     * 코드 리스트 조회
     * 
     * @param codeID
     * @return
     * @throws Exception
     */
    @RequestMapping("commonCodeList.do")
    public ModelAndView getCodeList(String codeID) throws Exception {
        ModelAndView mv = new ModelAndView();
        List<Map<String, String>> list = CommonCodeUtil.getCodeList(codeID);
        mv.setViewName("jsonView");
        mv.addObject("list", list);
        return mv;
    }

    /**
     * 코드 리스트 조회(Child)
     * 
     * @param codeID
     * @return
     * @throws Exception
     */
    @RequestMapping("commonChildCodeList.do")
    public ModelAndView getChildCodeList(String codeID) throws Exception {
        ModelAndView mv = new ModelAndView();
        List<Map<String, String>> list = CommonCodeUtil.getChildCodeList(codeID);
        mv.setViewName("jsonView");
        mv.addObject("list", list);
        return mv;
    }

    /**
     * 코드 리스트 조회(Child)
     * 
     * @param codeID
     * @return
     * @throws Exception
     */
    @RequestMapping("commonChildCodeListAll.do")
    public ModelAndView getChildCodeListAll() throws Exception {
        ModelAndView mv = new ModelAndView();
        List<Map<String, String>> list = CommonCodeUtil.getChildCodeListAll();
        mv.setViewName("jsonView");
        mv.addObject("list", list);
        return mv;
    }


    /**
     * 코드이름 조회
     * 
     * @param codeId
     * @param code
     * @return
     * @throws Exception
     */
    @RequestMapping("commonCodeName.do")
    public ModelAndView getCodeName(String codeId, String code) throws Exception {
        ModelAndView mv = new ModelAndView();
        String codeName = CommonCodeUtil.getCodeName(codeId, code);
        mv.setViewName("jsonView");
        mv.addObject("codeName", codeName);
        return mv;
    }


    /**
     * 코드이름 조회(Child)
     * 
     * @param codeId
     * @param code
     * @return
     * @throws Exception
     */
    @RequestMapping("commonChildCodeName.do")
    public ModelAndView getChildCodeName(String codeId, String code) throws Exception {
        ModelAndView mv = new ModelAndView();
        String codeName = CommonCodeUtil.getChildCodeName(codeId, code);
        mv.setViewName("jsonView");
        mv.addObject("codeName", codeName);
        return mv;
    }

    /**
     * 코드캐쉬 초기화
     * 
     * @throws Exception
     */
    @RequestMapping("commonCodeReBuild.do")
    public ModelAndView getCodeReBuild() throws Exception {
        ModelAndView mv = null;
        try {
            mv = new ModelAndView();
            CommonCodeUtil.reBuild(commonCodeDAO);
            /* 공통코드 초기화시 메신저조직도도 초기화한다. */
            mv.setViewName("jsonView");
            mv.addObject("errorCode", "0");
        } catch (Exception e) {
            mv.addObject("errorCode", "1");
        }
        return mv;
    }

}
