package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import app.dao.CommentDao;
import app.domain.CommentVo;

@WebServlet("/CommentController")
public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String location;

	public CommentController(String location) {
		this.location = location;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		if(location.equals("commentList.do")) {
			
			CommentDao cd = new CommentDao();
			ArrayList<CommentVo> list = cd.CommentSelectAll();
			int listCnt = list.size();
			int cidx = 0;
			String cwriter = "";
			String ccontents = "";
			String cwriteday = "";
			String str = "";
			
			for(int i=0; i<listCnt; i++) {
				cidx = list.get(i).getCidx();
				cwriter = list.get(i).getCwriter();
				ccontents = list.get(i).getCcontents();
				cwriteday = list.get(i).getCwriteday();
				
				String comma = "";
				if(i == listCnt-1) {
					comma = "";
				}else {
					comma = ",";
				}
				str = str + "{\"cidx\":\""+cidx+"\",\"cwriter\":\""+cwriter
						+"\",\"ccontents\":\""+ccontents+"\",\"cwriteday\":\""+cwriteday+"\"}"+comma;
				
			}
			
			//json파일 형식의 여러개의 데이터를 담는다
			//String am = "[{\"nm\":\"홍길동\"},{\"nm\":\"이순신\"}]";
			
			PrintWriter out = response.getWriter();
			out.println("["+str+"]");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
