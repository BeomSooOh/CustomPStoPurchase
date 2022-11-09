package neos.cmm.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import common.helper.logger.ExpInfo;

public class HttpsFilter implements Filter {

    @SuppressWarnings("unused")
    private FilterConfig config;

    @SuppressWarnings("rawtypes")
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        // Calltime Check..
        long startMain = System.currentTimeMillis();

        /* ========================================================================= */
        request.setCharacterEncoding("UTF-8");
        HttpServletRequest hsr = (HttpServletRequest) request;
        String ipAddress = ((HttpServletRequest) request).getHeader("X-FORWARDED-FOR");
        if (ipAddress == null) {
            ipAddress = hsr.getRemoteAddr();
        }

        Map<String, Object> parameters = new HashMap<String, Object>();
        Enumeration params = request.getParameterNames();
        if (params.hasMoreElements()) {
            while (params.hasMoreElements()) {
                String paramName = (String) params.nextElement();
                parameters.put(paramName, request.getParameter(paramName));
            }
        } else {
            parameters = null;
        }

        // CLog..
        if (hsr.getRequestURL().indexOf(".do") > -1) {
            // 접속 로그 기록..
            // ExpInfo.CLog(hsr, parameters, ipAddress);
        }
        /* ========================================================================= */

        HttpsRequestWrapper httpsRequest = new HttpsRequestWrapper((HttpServletRequest) request);
        httpsRequest.setResponse((HttpServletResponse) response);
        chain.doFilter(httpsRequest, response);

        // Calltime Check..
        long endMain = System.currentTimeMillis();

        if (((endMain - startMain) / 1000) > 5) {
            // 5초 이상 소요되는 내역 체크 ( 여기서 점검이 될라나? )
            if (hsr.getRequestURL().indexOf(".do") > -1) {
                ExpInfo.SlowProcess("[*****] 5초 이상 소요되는 프로세스.. >> " + hsr.getRequestURL());
            }
        }
    }

    @Override
    public void destroy() {
        // TODO Auto-generated method stub
    }

    @Override
    public void init(FilterConfig config) throws ServletException {
        this.config = config;
    }
}
