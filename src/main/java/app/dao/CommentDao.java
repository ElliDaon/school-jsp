package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.CommentVo;
import app.domain.MemberVo;

public class CommentDao {
	
	private Connection conn;
	private PreparedStatement pstmt;

	// �����ڸ� ������� DB����
	public CommentDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	
	public ArrayList<CommentVo> CommentSelectAll(){
		//���ѹ迭Ŭ���� ��ü�����ؼ� ������ ���� �غ� �Ѵ�.
		ArrayList<CommentVo> alist = new ArrayList<CommentVo>();
		ResultSet rs;
		String sql="select * from comment0803 where delyn='N' order by cidx desc";
		try{
			//����(����)��ü
			pstmt = conn.prepareStatement(sql);
			//DB�� �ִ� ���� ��ƿ��� ���밴ü
			rs = pstmt.executeQuery();
			//rs.next() -> �������� �ִ��� Ȯ���ϴ� �޼���(������ true, ������ false)
			while(rs.next()){
				CommentVo cv = new CommentVo();
				//rs���� midx�� ������ mv�� �Űܴ�´�.
				cv.setCidx( rs.getInt("cidx") ); 
				cv.setMidx( rs.getInt("midx") );
				cv.setBidx(rs.getInt("bidx"));
				cv.setCwriter(rs.getString("cwriter"));
				cv.setCcontents(rs.getString("ccontents"));
				cv.setCwriteday(rs.getString("cwriteday"));
				alist.add(cv);
				//�ݺ��� ���������� â�� �߰��ؼ� ��´�
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return alist;
	}
}
