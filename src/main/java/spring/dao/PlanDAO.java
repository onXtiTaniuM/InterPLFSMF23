/*
 * BoardDAO : Oracle JDBC
 */
package spring.dao;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import config.db.*;
import config.db.DBConnectionMgr;
import spring.plan.PlanInfo;

public class PlanDAO {
	private static final String SAVEFOLDER = "D:\\Temp\\boards\\fileuploads";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5 * 1024 * 1024; // 5MB
	private static final int DOWNLOAD_BUFFER_SIZE = 1024 * 8; // 8KB 

	private DBConnectionMgr pool;

	public PlanDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시판 리스트
		public Vector<PlanInfo> getBoardList(String keyField, String keyWord, int start, int end) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<PlanInfo> vlist = new Vector<PlanInfo>();
			try {
				con = pool.getConnection();
				if (keyWord.equals("null") || keyWord.equals("")) {	//검색
					sql = "SELECT rownum, b.* "
							+ "	FROM (SELECT rownum rnum, b.*"
							+ "		FROM (SELECT * FROM board ORDER BY ref desc, pos)b"
							+ "		)b"
							+ "		WHERE rnum BETWEEN ? AND ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);
				} else {
					sql = "SELECT rownum, b.*"
							+ "	FROM (SELECT rownum rnum, b.*"
							+ "		FROM (SELECT * FROM board WHERE " + keyField + " like ? ORDER BY ref desc, pos)b"
							+ "		)b"
							+ "		WHERE rnum BETWEEN ? AND ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
				}
				rs = pstmt.executeQuery();
				while (rs.next()) {
					PlanInfo bean = new PlanInfo();
					bean.setNum(rs.getInt("num"));
					bean.setEmpName(rs.getString("empName"));
					bean.setProdName(rs.getString("prodName"));
					bean.setStartdate(rs.getDate("startdate"));
					bean.setEnddate(rs.getDate("enddate"));
					bean.setRef(rs.getInt("ref"));
					bean.setPos(rs.getInt("pos"));
					bean.setDepth(rs.getInt("depth"));
					bean.setRegdate(rs.getString("regdate"));
					vlist.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//총 게시물수
		public int getTotalCount(String keyField, String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if (keyWord.equals("null") || keyWord.equals("")) {
					sql = "select count(num) from Board";
					pstmt = con.prepareStatement(sql);
				} else {
					sql = "select count(num) from  Board where " + keyField + " like ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
				}
				rs = pstmt.executeQuery();
				if (rs.next()) {
					totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
		
		// 게시물 입력
		public void insertBoard(HttpServletRequest req) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MultipartRequest multi = null;
			int filesize = 0;
			String filename = null;
			try {
				con = pool.getConnection();
				sql = "select board_seq.nextval from dual";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int ref = 1;
				
				if (rs.next()) {
					ref = rs.getInt(1); //첫 번째 열의 값
				}
				File file = new File(SAVEFOLDER);
				if (!file.exists()) {
					file.mkdirs();
				}
				multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE,
						new DefaultFileRenamePolicy());

				if (multi.getFilesystemName("filename") != null) {
					filename = multi.getFilesystemName("filename");
					filesize = (int) multi.getFile("filename").length();
				}
				String content = multi.getParameter("content");
				if (multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
					content = UtilMgr.replace(content, "<", "&lt;");
				}
				sql = "insert into Board(num,empName,content,prodName,startdate,enddate,ref,pos,depth,regdate,pass,ip,filename,filesize)"
						+"values(board_seq.currval,?, ?, ?, ?, ?, ?, 0, 0, sysdate, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("empName"));
				pstmt.setString(2, content);
				pstmt.setString(3, multi.getParameter("prodName"));
				pstmt.setDate(4, java.sql.Date.valueOf(multi.getParameter("startdate")));
				pstmt.setDate(5, java.sql.Date.valueOf(multi.getParameter("enddate")));
				pstmt.setInt(6, ref);
				pstmt.setString(7, multi.getParameter("pass"));
				pstmt.setString(8, multi.getParameter("ip"));
				pstmt.setString(9, filename);
				pstmt.setInt(10, filesize);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);	//DB리소스 반환
			}
		}
		
		// 게시물 리턴
		public PlanInfo getBoard(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			PlanInfo bean = new PlanInfo();
			try {
				con = pool.getConnection();
				sql = "select * from Board where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean.setNum(rs.getInt("num"));
					bean.setEmpName(rs.getString("empName"));
					bean.setProdName(rs.getString("prodName"));
					bean.setStartdate(rs.getDate("startdate"));
					bean.setEnddate(rs.getDate("enddate"));
					bean.setContent(rs.getString("content"));
					bean.setPos(rs.getInt("pos"));
					bean.setRef(rs.getInt("ref"));
					bean.setDepth(rs.getInt("depth"));
					bean.setRegdate(rs.getString("regdate"));
					bean.setPass(rs.getString("pass"));
					bean.setFilename(rs.getString("filename"));
					bean.setFilesize(rs.getInt("filesize"));
					bean.setIp(rs.getString("ip"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}

		// 게시물 삭제
		public void deleteBoard(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "select filename from Board where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next() && rs.getString(1) != null) {
					if (!rs.getString(1).equals("")) {
						File file = new File(SAVEFOLDER + "/" + rs.getString(1));
						if (file.exists())
							UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
					}
				}
				sql = "delete from Board where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}

		// 게시물 수정
		public void updateBoard(PlanInfo bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update Board set empName = ?, prodName=?, startdate= ?, enddate= ?, content = ? where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getEmpName());
				pstmt.setString(2, bean.getProdName());
				pstmt.setDate(3, bean.getStartdate());
				pstmt.setDate(4, bean.getEnddate());
				pstmt.setString(5, bean.getContent());
				pstmt.setInt(6, bean.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}

		// 게시물 답변
		public void replyBoard(PlanInfo bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert into Board (num,empName,content,prodName,startdate,enddate,ref,pos,depth,regdate,pass,ip)";
				sql += "values(board_seq.nextval,?,?,?,?,?,?,?,?,sysdate,?,?)";
				int depth = bean.getDepth() + 1;
				int pos = bean.getPos() + 1;
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getEmpName());
				pstmt.setString(2, bean.getContent());
				pstmt.setString(3, bean.getProdName());
				pstmt.setDate(4, bean.getStartdate());
				pstmt.setDate(5, bean.getEnddate());
				pstmt.setInt(6, bean.getRef());
				pstmt.setInt(7, pos);
				pstmt.setInt(8, depth);
				pstmt.setString(9, bean.getPass());
				pstmt.setString(10, bean.getIp());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}

		// 답변에 위치값 증가
		public void replyUpBoard(int ref, int pos) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update Board set pos = pos + 1 where ref = ? and pos > ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, pos);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
				
		//파일 다운로드
			public void downLoad(HttpServletRequest req, HttpServletResponse res,
					JspWriter out, PageContext pageContext) {
				try {
					req.setCharacterEncoding("UTF-8");
					String filename = req.getParameter("filename");
					String filePath = SAVEFOLDER + File.separator+ filename;
					//File file = new File(UtilMgr.con(SAVEFOLDER + File.separator+ filename)); 현재 con에서 문제가 발생하므로 모든 문자타입을 UTF-8로 맞추고 변환기를 사용하지 않는다
					File file = new File(filePath);
				
					res.setHeader("Accept-Ranges", "bytes");
					String strClient = req.getHeader("User-Agent");
					
					
					String downfileName = new String(filename.getBytes("UTF-8"), "ISO-8859-1"); //UTF-8방식의 파일명을 바이트로 변환 후 iso-8859-1(윈도우 한글 코덱)으로 변경
			
					
					
					if (strClient.indexOf("MSIE6.0") != -1) {	//IE버전 판별(현재는 별 의미없음)
						res.setContentType("application/smnet;charset=UTF-8");
						res.setHeader("Content-Disposition", "filename=" + filename + ";");
					} else {
						res.setContentType("application/smnet;charset=UTF-8");
						res.setHeader("Content-Disposition", "attachment;filename="+ downfileName + ";");
					}
					
					out.clear();
					out = pageContext.pushBody();
					
					if (file.isFile()) {	//파일 버퍼에 관련된 소스
						/*
						BufferedInputStream fin = new BufferedInputStream(
								new FileInputStream(file));
						BufferedOutputStream outs = new BufferedOutputStream(
								res.getOutputStream());
						int read = 0;
						while ((read = fin.read(b)) != -1) {
							outs.write(b, 0, read);
						}*/
						
						FileInputStream fin = new FileInputStream(file);	//파일 읽기 객체 생성 (스트림)
						OutputStream outs = res.getOutputStream();			//응답 객체의 출력 스트림 객체
						
						//byte b[] = new byte[(int) file.length()]; 파일용량 전체를 버퍼 메로리로 사용할 경우 고용량 파일의 경우 리소스 낭비가 사료됨
						byte[] buffer = new byte[DOWNLOAD_BUFFER_SIZE]; //고정된 버퍼값을 사용
						
						while(true) {
							int readlen = fin.read(buffer);				//버퍼에 있는 파일 용량 읽기
							//System.out.println("read : len " + readlen);
							if(readlen < 0) {
								break;
							}
							
							outs.write(buffer, 0, readlen);
						}
						outs.close();
						fin.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			//파일(사진) 다운로드
			public void downImage(HttpServletRequest req, HttpServletResponse res,
					JspWriter out, PageContext pageContext) {
				try {
					req.setCharacterEncoding("UTF-8");
					String filename = req.getParameter("filename");
					String filePath = SAVEFOLDER + File.separator+ filename;
					File file = new File(filePath);
					
					res.setHeader("Accept-Ranges", "bytes");
					
					if (file.isFile()) {	//파일 버퍼에 관련된 소스
						
						FileInputStream fin = new FileInputStream(file);	
						OutputStream outs = res.getOutputStream();			
						
						byte[] buffer = new byte[DOWNLOAD_BUFFER_SIZE]; 
						
						while(true) {
							int readlen = fin.read(buffer);				
							System.out.println("read : len " + readlen);
							if(readlen < 0) {
								break;
							}
							
							outs.write(buffer, 0, readlen);
						}
						outs.close();
						fin.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		//페이징 및 블럭 테스트를 위한 게시물 저장 메소드 
		public void post1000(){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert into Board(empName,content,prodName,startdate,enddate,ref,pos,depth,regdate,pass,ip,filename,filesize)";
				sql+="values('aaa', 'bbb', 'ccc', now(), now(), 0, 0, 0, now(), '1111', '127.0.0.1', null, 0);";
				pstmt = con.prepareStatement(sql);
				for (int i = 0; i < 1000; i++) {
					pstmt.executeUpdate();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
		// main
		public static void main(String[] args) {
			new PlanDAO().post1000();
			System.out.println("SUCCESS");
		}
	}