package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.cj.xdevapi.PreparableStatement;

import app.dbconn.DbConn;
import app.domain.BoardVo;
import app.domain.Criteria;
import app.domain.SearchCriteria;

public class BoardDao {

	private Connection conn;
	private PreparedStatement pstmt;

	// 생성자를 만든다
	public BoardDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}

	public ArrayList<BoardVo> boardSelectAll(SearchCriteria scri) {
		// 무한배열클래스 객체생성해서 데이터 담을 준비를 한다.
		ArrayList<BoardVo> alist = new ArrayList<BoardVo>();
		ResultSet rs;

		String str = "";
		if (!scri.getKeyword().equals("")) {
			str = " and " + scri.getSearchType() + " like concat('%','" + scri.getKeyword() + "','%') ";
		}

		String sql = "select bidx, subject, writer, viewcnt, date_format(writeday,\"%Y-%m-%d\") as writeday "
				+ "from board0803 where delyn='N' " + str + "order by originbidx desc, level_ asc, depth asc limit ?,?";
		try {
			// 구문(쿼리)객체
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (scri.getPage() - 1) * scri.getPerPageNum());
			pstmt.setInt(2, scri.getPerPageNum());
			// DB에 있는 값을 담아오는 전용객체
			rs = pstmt.executeQuery();
			// rs.next() -> 다음값이 있는지 확인하는 메서드(있으면 true, 없으면 false)
			while (rs.next()) {
				BoardVo bv = new BoardVo();
				// rs에서 midx값 꺼내서 mv에 옮겨담는다.
				bv.setBidx(rs.getInt("bidx"));
				bv.setSubject(rs.getString("subject"));
				bv.setWriter(rs.getString("writer"));
				bv.setViewcnt(rs.getInt("viewcnt"));
				bv.setWriteday(rs.getString("writeday"));
				alist.add(bv);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return alist;
	}

	public int boardTotalCount(SearchCriteria scri) {
		int value = 0; // 결과값이 0인지 아닌지

		String str = "";
		if (!scri.getKeyword().equals("")) {
			str = " and " + scri.getSearchType() + " like concat('%','" + scri.getKeyword() + "','%') ";
		}

		String sql = "select count(*) as cnt from board0803 where delyn='N'" + str;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				value = rs.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}

	public int boardInsert(BoardVo bv) {
		int exec = 0;

		String sql = "INSERT INTO board0803(originbidx, depth, level_, SUBJECT, contents, writer, midx, pwd,filename)\r\n"
				+ "values(null, 0,0,?, ?, ?, ?, ?, ?)";
		String sql2 = "UPDATE board0803 set\r\n"
				+ "originbidx = (select a.bidx from (select max(bidx) as bidx from board0803) a)\r\n"
				+ "where bidx = (select a.bidx from (select max(bidx) as bidx from board0803) a)";

		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bv.getSubject());
			pstmt.setString(2, bv.getContents());
			pstmt.setString(3, bv.getWriter());
			pstmt.setInt(4, bv.getMidx());
			pstmt.setString(5, bv.getPwd());
			pstmt.setString(6, bv.getFilename());
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement(sql2);
			exec = pstmt.executeUpdate();

			conn.commit();

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}

		return exec;
	}

	public BoardVo boardSelectOne(int bidx) {
		BoardVo bv = null;
		String sql = "Select * from board0803 where bidx=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// 향상된 구문 클래스를 꺼낸다.
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				// bv 생성하고 결과값 옮겨담기
				bv = new BoardVo();
				bv.setSubject(rs.getString("subject"));
				bv.setContents(rs.getString("Contents"));
				bv.setWriter(rs.getString("writer"));
				bv.setBidx(rs.getInt("bidx"));
				bv.setViewcnt(rs.getInt("viewcnt"));
				bv.setOriginbidx(rs.getInt("originbidx"));
				bv.setDepth(rs.getInt("depth"));
				bv.setLevel_(rs.getInt("level_"));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bv;
	}

	public int boardCntUpdate(int bidx) {
		int exec = 0;

		String sql = "UPDATE board0803 set\r\n" + "viewcnt = viewcnt+1\r\n" + "where bidx = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidx);
			exec = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return exec;
	}

	public int boardModify(BoardVo bv) {
		int exec = 0;

		String sql = "UPDATE board0803 set\r\n" 
					+ "subject = ?,\r\n" 
					+ "contents = ?,\r\n" 
					+ "writer = ?,\r\n" 
					+ "modifyday= now(),\r\n" 
					+ "ip = ?\r\n" 
					+ "where bidx = ? and pwd = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bv.getSubject());
			pstmt.setString(2, bv.getContents());
			pstmt.setString(3, bv.getWriter());
			pstmt.setString(4, bv.getIp());
			pstmt.setInt(5, bv.getBidx());
			pstmt.setString(6, bv.getPwd());
			exec = pstmt.executeUpdate();
			//수정이 되면 1이 리턴된다.
		} catch (Exception e) {
			e.printStackTrace();
		}

		return exec;
	}
	
	public int boardDelete(int bidx, String pwd) {
		int value = 0;
		
		String sql = "UPDATE board0803 set\r\n" 
				+ "delyn = 'Y',\r\n" 
				+ "modifyday= now()\r\n" 
				+ "where bidx = ? and pwd = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidx);
			pstmt.setString(2, pwd);
			value = pstmt.executeUpdate();
			//수정이 되면 1이 리턴된다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return value;
	}
	
	public int boardReply(BoardVo bv) {
		int value = 0;
		
		String sql = "INSERT INTO board0803(originbidx, depth, level_, SUBJECT, contents, writer, midx, pwd)\r\n"
				+ "values(?, ?,?,?, ?, ?, ?, ?)";
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,bv.getOriginbidx());
			pstmt.setInt(2, bv.getDepth()+1);
			pstmt.setInt(3, bv.getLevel_()+1);
			pstmt.setString(4, bv.getSubject());
			pstmt.setString(5, bv.getContents());
			pstmt.setString(6, bv.getWriter());
			pstmt.setInt(7, bv.getMidx());
			pstmt.setString(8, bv.getPwd());
			//pstmt.setString(8, bv.getFilename());

			value = pstmt.executeUpdate();



		} catch (Exception e) {
			
			e.printStackTrace();
		}

		
		return value;
	}
}
