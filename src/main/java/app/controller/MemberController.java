package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.MemberDao;
import app.domain.MemberVo;

//HttpServlet�� ��ӹ޾ұ� ������ Ŭ������ ���ͳ��������� �ȴ�.
@WebServlet("/MemberController")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String location;
	public MemberController(String location) {
		this.location = location;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(location.equals("memberList.do")) {
			
			MemberDao md = new MemberDao();
			ArrayList<MemberVo> list = md.memberSelectAll();
			
			request.setAttribute("list", list);
			
			String path = "/member/memberList.jsp";
			//ȭ��뵵�� �ּҴ� forward�� �佺�ؼ� �ش� �� �ּҷ� ������.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		} else if(location.equals("memberJoin.do")) {
			
			String path = "/member/memberJoin.jsp";
			//ȭ��뵵�� �ּҴ� forward�� �佺�ؼ� �ش� �� �ּҷ� ������.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		} else if(location.equals("memberJoinAction.do")) {
			
			
			//�����͸� �Ѱ��ָ� ��û��ü�� �� ���� �޾Ƽ� �Ѿ�� �Ű������� ��� ����
			//������ ���ο� ������ ��´�
			String memberId = request.getParameter("memberId");
			String memberName = request.getParameter("memberName");
			String memberPwd = request.getParameter("memberPwd");
			String memberPhone = request.getParameter("memberPhone");
			String memberEmail = request.getParameter("memberEmail");
			String memberYear = request.getParameter("memberYear");
			String memberMonth = request.getParameter("memberMonth");
			String memberDay = request.getParameter("memberDay");
			String memberGender = request.getParameter("memberGender");
			String memberAddr = request.getParameter("memberAddr");
			String[] memberHobby = request.getParameterValues("memberHobby");
			String str = "";
			for(int i=0; i<memberHobby.length; i++){
				str += memberHobby[i];
				str += ", ";
			}
			str = str.substring(0, str.length()-2); //������ ", " �����


			//������ ������ ��ü�� �����ؼ�
			//DB�� �Է��Ѵ�


			String memberBirth=memberYear+memberMonth+memberDay;

			//������ �����Ű�� ��ü��ȯ ���
			//stmt ��ü ���
			//Statement stmt = conn.createStatement();

			/* String new_index_q = "SELECT MAX(MIDX) FROM MEMBER0803";
			ResultSet new_index = stmt.executeQuery(new_index_q);
			int index_num =0;
			while(new_index.next()) {
				index_num = new_index.getInt(1) +1;
			} 
			-> ������ �˱� ���� �ڵ�*/
			MemberDao md = new MemberDao();
			int exec = md.memberInsert(memberId, memberPwd, memberName, memberBirth, memberGender, memberPhone, memberEmail, memberAddr, str);

			PrintWriter out = response.getWriter();
			//boolean tf = stmt.execute(sql);//�ش� ����(����)�� �����Ų��

			//System.out.println(sql);
			//System.out.println(tf);
			if(exec == 1){
				//�ڵ� �̵� �޼ҵ�
				//response.sendRedirect(request.getContextPath()+"/member/memberList.html");
				out.println("<script>alert(\"ȸ�����ԵǾ����ϴ�.\");"
				+"document.location.href='"+request.getContextPath()+"/member/memberList.do'</script>");
			}else{
				out.println("<script>history.back();</script>");
			}
			
		}else if(location.equals("memberLogin.do")) {
			String path = "/member/memberLogin.jsp";
			//ȭ��뵵�� �ּҴ� forward�� �佺�ؼ� �ش� �� �ּҷ� ������.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("memberLogout.do")) {
			HttpSession session = request.getSession();
			session.removeAttribute("memberId");
			session.removeAttribute("midx");
			session.invalidate(); //�ʱ�ȭ
			
			response.sendRedirect(request.getContextPath()+"/");
			
		}else if(location.equals("memberLoginAction.do")) {
			
			String memberId = request.getParameter("memberId");
			String memberPwd = request.getParameter("memberPwd");
			
			
			MemberDao md = new MemberDao();
			int midx = 0;
			midx = md.memberLoginCheck(memberId, memberPwd);
			if (midx!=0){ //���̵��� ��ġ
				//���ǿ� ȸ�� ���̵� ��´�
				HttpSession session = request.getSession();
				session.setAttribute("memberId", memberId);
				session.setAttribute("midx", midx);
				
				response.sendRedirect(request.getContextPath()+"/index.jsp");
				
			}else{//���̵� ��� ����ġ
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script language='javascript' type='text/javascript'> alert('�α��� ����'); </script>");
				out.println("<script>location.href='memberLogin.do';</script>");
				//response.sendRedirect("./memberLogin.do");
			}
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
