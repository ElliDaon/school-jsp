package app.controller;

import java.io.IOException;
import java.net.InetAddress;
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

	public BoardController(String location) {
		this.loaction = location;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (loaction.equals("boardList.do")) {
			// db에 있는 board0803 게시물 전체를 가지고온다.

			String searchType = request.getParameter("searchType");
			if (searchType == null)
				searchType = "subject";

			String keyword = request.getParameter("keyword");
			if (keyword == null)
				keyword = "";

			String page = request.getParameter("page");
			if (page == null)
				page = "1";

			SearchCriteria scri = new SearchCriteria();
			scri.setPage(Integer.parseInt(page));
			scri.setSearchType(searchType);
			scri.setKeyword(keyword);

			PageMaker pm = new PageMaker();
			pm.setScri(scri);

			BoardDao bd = new BoardDao();
			ArrayList<BoardVo> list = bd.boardSelectAll(scri);
			int cnt = bd.boardTotalCount(scri); // 전체 게시물 수
			pm.setTotalCount(cnt);

			request.setAttribute("list", list);
			request.setAttribute("pm", pm);

			String path = "/board/boardList.jsp";
			// 화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (loaction.equals("boardWrite.do")) {

			String path = "/board/boardWrite.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (loaction.equals("boardContents.do")) {

			String bidx = request.getParameter("bidx");
			BoardDao bd = new BoardDao();
			int bidx_int = Integer.parseInt(bidx);
			int exec = bd.boardCntUpdate(bidx_int);
			BoardVo bv = bd.boardSelectOne(bidx_int);

			request.setAttribute("bv", bv);

			String path = "/board/boardContents.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (loaction.equals("boardModify.do")) {
			String bidx = request.getParameter("bidx");
			BoardDao bd = new BoardDao();
			int bidx_int = Integer.parseInt(bidx);
			int exec = bd.boardCntUpdate(bidx_int);
			BoardVo bv = bd.boardSelectOne(bidx_int);

			request.setAttribute("bv", bv);

			String path = "/board/boardModify.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (loaction.equals("boardModifyAction.do")) {
			
			//수정데이터 넘겨받기
			String bidx = request.getParameter("bidx");
			String subject = request.getParameter("subject");
			String contents = request.getParameter("contents");
			String writer = request.getParameter("writer");
			String pwd = request.getParameter("pwd");
			String ip =InetAddress.getLocalHost().getHostAddress();
			
			//받은값 입력
			BoardVo bv = new BoardVo();
			bv.setSubject(subject);
			bv.setContents(contents);
			bv.setWriter(writer);
			bv.setPwd(pwd);
			bv.setBidx(Integer.parseInt(bidx));
			bv.setIp(ip);

			BoardDao bd = new BoardDao();
			int value = bd.boardModify(bv);

			if (value == 0) {
				// 수정안되면
				String path = request.getContextPath() + "/board/boardModify.do?bidx="+bidx;
				response.sendRedirect(path);
			} else {
				// 수정되면
				String path = request.getContextPath() + "/board/boardContents.do?bidx="+bidx;
				response.sendRedirect(path);

			}
			
		}else if (loaction.equals("boardDelete.do")) {
			
			String bidx = request.getParameter("bidx");
			int bidx_int = Integer.parseInt(bidx);
			
			BoardDao bd = new BoardDao();
			BoardVo bv = bd.boardSelectOne(bidx_int);

			request.setAttribute("bv", bv);
			
			String path = "/board/boardDelete.jsp";
			//화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다.
			//같은 지역이므로 공유해서 꺼내쓸 수 있다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		}else if(loaction.equals("boardDeleteAction.do")) {
			
			String bidx = request.getParameter("bidx");
			int bidx_int = Integer.parseInt(bidx);
			String pwd = request.getParameter("pwd");
			
			//처리하는 메소드를 만들어야 한다.
			int value = 0;
			
			BoardVo bv = new BoardVo();
			bv.setBidx(Integer.parseInt(bidx));
			bv.setPwd(pwd);

			BoardDao bd = new BoardDao();
			value = bd.boardDelete(bidx_int,pwd);
			
			//value 값은 처리가 되면 1이 되고 아니면 0이 나온다.
			if(value != 0) {
				
				String path = request.getContextPath() + "/board/boardList.do";
				response.sendRedirect(path);
			}else {
				String path = request.getContextPath() + "/board/boardDelete.do?bidx="+bidx;
				response.sendRedirect(path);
			}
			
		}else if (loaction.equals("boardWriteAction.do")) {

			String savePath = "D:\\MDO\\mvcstudy0803\\src\\main\\webapp\\images";
			int sizeLimit = 15 * 1024 * 1024; // 15메가바이트 제한
			String dataTy = "UTF-8";

			// 파일이름 중복 정책
			DefaultFileRenamePolicy drp = null;
			drp = new DefaultFileRenamePolicy();

			// 다양한 파일과 데이터를 넘겨받는 통신요청객체
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, savePath, sizeLimit, dataTy, drp);

			String subject = multi.getParameter("subject");
			String contents = multi.getParameter("contents");
			String writer = multi.getParameter("writer");
			String pwd = multi.getParameter("pwd");

			// 파일 넘겨받기
			// 열거자의 넘어오는 여러 파일이름을 담는다
			Enumeration files = multi.getFileNames();
			// 파일 객체를 꺼낸다
			String file = (String) files.nextElement();
			// 그 파일의 이름을 추출한다(실제로 저장되는 파일이름)
			String fileName = multi.getFilesystemName(file);
			// 원래 파일 이름 추출
			String originFileName = multi.getOriginalFileName(file);
			HttpSession session = request.getSession();
			int midx = 0;
			midx = (int) session.getAttribute("midx");

			BoardVo bv = new BoardVo();
			bv.setSubject(subject);
			bv.setContents(contents);
			bv.setWriter(writer);
			bv.setFilename(fileName);
			bv.setPwd(pwd);
			bv.setMidx(midx);

			BoardDao bd = new BoardDao();
			int value = bd.boardInsert(bv);

			if (value == 0) {
				// 입력안되면
				String path = request.getContextPath() + "/board/boardWrite.do";
				response.sendRedirect(path);
			} else {
				// 입력되면
				String path = request.getContextPath() + "/board/boardList.do";
				response.sendRedirect(path);

			}

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
