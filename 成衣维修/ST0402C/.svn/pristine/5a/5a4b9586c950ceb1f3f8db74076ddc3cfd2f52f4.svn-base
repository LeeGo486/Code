package org.hy.filter;

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

import org.hy.model.UserInfo;



public class LoginCheckFilter implements Filter {

	

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		 request.setCharacterEncoding("UTF-8");
		 response.setContentType("text/html;charset=GBK");

		
				
		HttpServletRequest req = (HttpServletRequest) request;
		String requestURI = req.getRequestURI().substring(
				req.getRequestURI().lastIndexOf("/",
				req.getRequestURI().length()));
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession(false);
		
		
		 if (!"/login.jsp".equals(requestURI)&& !"/1122".equals(requestURI)
					&& !"/index.jsp".equals(requestURI)&& !"/login!login".equals(requestURI)) {
			 if (session == null) {
					resp.sendRedirect(req.getContextPath() + "/cm/login.jsp");
					return;
			}
			 chain.doFilter(request, response);
		 } else {
			 if("/index.jsp".equals(requestURI)){
				 resp.sendRedirect(req.getContextPath() + "/cm/login.jsp");
					return;
			 }
				chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	
	}

}
