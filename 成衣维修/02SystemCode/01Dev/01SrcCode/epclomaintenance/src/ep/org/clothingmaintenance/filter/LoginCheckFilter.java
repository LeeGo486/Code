package ep.org.clothingmaintenance.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ep.org.clothingmaintenance.bean.UserInfo;
import ep.org.clothingmaintenance.service.CloMaintenanceService;
import ep.org.clothingmaintenance.service.UserService;






public class LoginCheckFilter implements Filter {

	

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		 request.setCharacterEncoding("UTF-8");
		 response.setContentType("text/html;charset=UTF-8");

		
		HttpServletRequest req = (HttpServletRequest) request;
		String requestURI = req.getRequestURI().substring(
				req.getRequestURI().lastIndexOf("/",
						req.getRequestURI().length()));
		HttpServletResponse resp = (HttpServletResponse) response;
		if ( !"/loginWrong.jsp".equals(requestURI)&& !"/cloMaintenanceMain.do".equals(requestURI)) {
			HttpSession session = req.getSession(false);
			
			String username = request.getParameter("userID");
			String password = request.getParameter("pwd");
			if (session == null ||  (UserInfo)session.getAttribute("user_info")== null ||(username!=null&&!username.equals("")&&!((UserInfo)session.getAttribute("user_info")).getUserID().equals(username) )) {
				
				UserInfo userInfo = null;
				UserService userService = new UserService();
				CloMaintenanceService service = new CloMaintenanceService();
				try {
					String loginDeptID = service.checkUser(username, password);
					
					if(loginDeptID==null || loginDeptID.equals("")){
						resp.sendRedirect(req.getContextPath() + "/colmaintenance/loginWrong.jsp");
					}
					userInfo = userService.getUserInfo(username, password);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				
				if (userInfo == null || userInfo.getLoginDeptID() == null
						|| "".equals(userInfo.getLoginDeptID())) {
					resp.sendRedirect(req.getContextPath() + "/colmaintenance/loginWrong.jsp");
				}else{
					request.setAttribute("userID", userInfo.getUserID());
					request.setAttribute("loginDeptID", userInfo.getLoginDeptID());
					request.setAttribute("pwd", userInfo.getPwd());
					req.getSession().setAttribute("user_info", userInfo);
					chain.doFilter(request, response);
				}
			} else {
				chain.doFilter(request, response);
			}
		} else {
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

}
