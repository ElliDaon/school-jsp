package app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import app.dao.BoardDao;
import app.domain.BoardVo;
import app.domain.PageMaker;
import app.domain.SearchCriteria;

//HttpServlet를 상속받았기 때문에 클래스가 인터넷페이지가 된다.
@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String loaction;
	public BoardController(String location){
		this.loaction = location;
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		if (loaction.equals("boardList.do")) {
			//db에 있는 board0803 게시물 전체를 가지고온다.
			
			String searchType = request.getParameter("searchType");
			if(searchType == null) searchType = "subject";
			
			String keyword = request.getParameter("keyword");
			if(keyword == null) keyword = "";
			
			String page = request.getParameter("page");
			if(page == null) page="1";

			SearchCriteria scri = new SearchCriteria();
			scri.setPage(Integer.parseInt(page));
			scri.setSearchType(searchType);
			scri.setKeyword(keyword);
			
			PageMaker pm = new PageMaker();
			pm.setScri(scri);
			
			
			BoardDao bd = new BoardDao();
			ArrayList<BoardVo> list = bd.boardSelectAll(scri);
			int cnt = bd.boardTotalCount(scri); //전체 게시물 수
			pm.setTotalCount(cnt);
			
			request.setAttribute("list", list);
			request.setAttribute("pm", pm);
			
			String path = "/board/boardList.jsp";
			// 화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		}else if(loaction.equals("boardWrite.do")) {
			
			
			String path = "/board/boardWrite.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(loaction.equals("boardContents.do")) {
			
			String bidx = request.getParameter("bidx");
			BoardDao bd = new BoardDao();
			int bidx_int = Integer.parseInt(bidx);
			BoardVo bv = bd.boardSelectOne(bidx_int);
			
			request.setAttribute("bv", bv);
			
			String path = "/board/boardContents.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(loaction.equals("boardModify.do")) {
			String path = "/board/boardModify.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(loaction.equals("boardDelete.do")) {
			String path = "/board/boardDelete.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(loaction.equals("boardWriteAction.do")) {
			
			String savePath = "D:\\MDO\\mvcstudy0803\\src\\main\\webapp\\images";
			int sizeLimit = 15*1024*1024; //15메가바이트 제한
			String dataTy = "UTF-8";
			
			//파일이름 중복 정책
			DefaultFileRenamePolicy drp = null;
			drp = new DefaultFileRenamePolicy();
			
			//다양한 파일과 데이터를 넘겨받는 통신요청객체
			MultipartRequest multi = null;
			multi = new MultipartRequest(request,savePath,sizeLimit,dataTy,drp);
			
			String subject = multi.getParameter("subject");
			String contents = multi.getParameter("contents");
			String writer = multi.getParameter("writer");
			String pwd = multi.getParameter("pwd");
			
			//파일 넘겨받기
			//열거자의 넘어오는 여러 파일이름을 담는다
			Enumeration files = multi.getFileNames();
			//파일 객체를 꺼낸다
			String file = (String)files.nextElement();
			//그 파일의 이름을 추출한다(실제로 저장되는 파일이름)
			String fileName = multi.getFilesystemName(file);
			//원래 파일 이름 추출
			String originFileName = multi.getOriginalFileName(file);
			HttpSession session = request.getSession();
			int midx = 0;
			midx = (int)session.getAttribute("midx");
			
			BoardVo bv = new BoardVo();
			bv.setSubject(subject);
			bv.setContents(contents);
			bv.setWriter(writer);
			bv.setFilename(fileName);
			bv.setPwd(pwd);
			bv.setMidx(midx);
			
			BoardDao bd = new BoardDao();
			int value = bd.boardInsert(bv);
			
			
			if(value == 0) {
				//입력안되면
				String path = request.getContextPath()+"/board/boardWrite.do";
				response.sendRedirect(path);
			}else {
				//입력되면
				String path = request.getContextPath()+"/board/boardList.do";
				response.sendRedirect(path);
				
			}
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
