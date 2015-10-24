package ep.org.clothingmaintenance.servlet;

import java.io.BufferedInputStream;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ep.org.clothingmaintenance.service.CloMaintenanceService;
import ep.org.clothingmaintenance.util.DBUtil;

public class ImageBrowseServlet extends HttpServlet {

	
	public ImageBrowseServlet() {
		super();
	}

	public void destroy() {
		super.destroy(); 
		
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		Connection conn = null;
		 Statement st = null;
		 ResultSet rs = null; 
		 InputStream is  = null;
		
		String guid = request.getParameter("guid");
		response.reset();
		response.setContentType("image/* ");
		OutputStream output = response.getOutputStream();
		byte[] buf = new byte[1024];
		int len = 0;
		BufferedInputStream br = null;
		try {
			 String sql = "select p1 from cywxdjtpb where guid ='"+guid+"'";
			 conn = DBUtil.getConnection();
			 st = conn.createStatement();
			 rs = st.executeQuery(sql);
			 if(rs.next()){
				is   =   rs.getBinaryStream("p1");   
			 }

			br = new BufferedInputStream(is);
			while ((len = br.read(buf)) > 0) {
				output.write(buf, 0, len);
			}
			output.flush();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			 
			output.close();
			br.close();
			if (is != null) {
				is.close();
			}
			
			if (rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			 if (st != null) {
					try {
						st.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
		 }
		

	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

	
	public void init() throws ServletException {
		// Put your code here
	}

}
