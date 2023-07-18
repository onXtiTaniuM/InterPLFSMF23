[list.jsp]
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="boards.dao.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Date"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<jsp:useBean id="bMgr" class="boards.dao.BoardDAO" />
<%	
	request.setCharacterEncoding("UTF-8");
	
	String contextPath = request.getContextPath();
	System.out.println("contextPath : " + contextPath);
	
	int totalRecord=0; //전체레코드수
	int numPerPage=10; // 페이지당 레코드 수 
	int pagePerBlock=15; //블럭당 페이지수 
	
	int totalPage=0; //전체 페이지 수
	int totalBlock=0;  //전체 블럭수 
	
	int nowPage=1; // 현재페이지
	int nowBlock=1;  //현재블럭
	
	
	int start=0; //디비의 select 시작번호
	int end=10; //시작번호로 부터 가져올 select 갯수
	
	
	int listSize=0; //현재 읽어온 게시물의 수
	 
	//키워드 키필드 초기화(검색관련)
	String keyWord = "",
	keyField = ""; 
	
	Vector<BoardBean> vlist = null;		//게시글 목록, 즉 bean을 vector로 배열
	if (request.getParameter("keyWord") != null) {	//검색이 있을때 반영
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if (request.getParameter("reload") != null){	//처음으로 상호작용시 반응
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage * numPerPage)-numPerPage;
	end = (nowPage * numPerPage);
	 
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	  
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
%>
<html>
<head>
	<title>Board</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function list() {
			document.listFrm.action = "<=%contextPath%>/boards/list.do";
			document.listFrm.submit();
		}
		
		function pageing(page) {
			document.readFrm.nowPage.value = page;
			document.readFrm.submit();
		}
		
		function block(value){
			 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
			 document.readFrm.submit();
		} 
		
		function read(num){
			document.readFrm.num.value=num;
			document.readFrm.action="<%=contextPath%>/boards/read.do";
			document.readFrm.submit();
		}
		
		function check() {
		     if (document.searchFrm.keyWord.value == "") {
				alert("검색어를 입력하세요.");
				document.searchFrm.keyWord.focus();
				return;
		     }
		  document.searchFrm.submit();
		 }
	</script>
</head>
<body bgcolor="#FFFFCC">
<div align="center">
	<br/>
	<h2>Board</h2>
	<br/>
	<table align="center" width="800" cellpadding="3">
		<tr>
			<td>Total : <%=totalRecord%>개(<font color="red">
			<%=nowPage%>/<%=totalPage%>Pages</font>)</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
			<%
				  vlist = bMgr.getBoardList(keyField, keyWord, start, end);
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물 번호
				  if (vlist.isEmpty()) {
					out.println("등록된 기사가 없습니다.");
				  } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td align="center" style="width: 30px;">번 호</td>
						<td align="center" style="width: 150px;">생성일자</td>
						<td align="center" style="width: 70px;">생산상품</td>
						<td align="center" style="width: 220px;">생산계획기간</td>
						<td align="center" style="width: 50px;">생성</td>
						<td align="center" style="width: 150px;">비고</td>
						<td align="center" style="width: 70px;">담당자</td>
					</tr>
					<%
						  for (int i = 0; i<numPerPage; i++) {
							if (i == listSize) break;
							BoardBean bean = vlist.get(i);
							
							int num = bean.getNum();
							String empName = bean.getEmpName();							
							String content = bean.getContent();
							String prodName = bean.getProdName();
							Date startdate = bean.getStartdate();
							Date enddate = bean.getEnddate();
							String regdate = bean.getRegdate();
							int depth = bean.getDepth();
					%>
					<tr>
						<td align="center">
							<%=(nowPage-1)*numPerPage+i+1%>
						</td>
						<td align="center" style="width: 150px;"><%=regdate.toString().substring(0, 16)%></td>
						<td align="center" style="width: 70px;">
						<%
							  if(depth>0){
								for(int j=0;j<depth;j++){
									out.println("&nbsp;&nbsp;");
									}
								}
						%>
							<a href="javascript:read('<%=num%>')"><%=prodName%></a>
						</td>
						<td align="center" style="width: 220px;"><%=startdate%> ~ <%=enddate%></td>
						<td align="center" style="width: 50px;"><a href = "">조회</a></td>
						<td align="center" style="width: 150px;"><%=content != null ? content : "--"%></td>
						<td align="center" style="width: 70px;"><%=empName%></td>
					</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
		<tr>
			<td colspan="2"><br /><br /></td>
		</tr>
		<tr>
			<td>
			<!-- 페이징 및 블럭 처리 Start--> 
			<%
   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
   				  int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
   				  //하단 페이지 끝번호
   				  if(totalPage !=0){
    			  	if (nowBlock > 1) {%>
    			  		<a href="javascript:block('<%=nowBlock-1%>')">prev...</a><%}%>&nbsp; 
    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
     			     	<a href="javascript:pageing('<%=pageStart %>')"> 
     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
     					[<%=pageStart %>] 
     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
    					<%}//for%>&nbsp; 
    					<%if (totalBlock > nowBlock ) {%>
    					<a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
    				<%}%>&nbsp;  
   				<%}%>
 				<!-- 페이징 및 블럭 처리 End-->
				</td>
				<td align="right">
					<a href="writePost.do">[신규]</a>
					<a href="javascript:list()">[새로고침]</a>
				</td>
			</tr>
		</table>
	<hr width="600"/>
	<form  name="searchFrm"  method="get" action="list.do">
	<table width="600" cellpadding="4" cellspacing="0">
 		<tr>	
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" >
    				<option value="empName"> 이 름</option>
    				<option value="prodName"> 생산상품</option>
    				<option value="content"> 내 용</option>
   				</select>
   				<input size="16" name="keyWord">
   				<input type="button"  value="찾기" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
  			</td>
 		</tr>
	</table>
	</form>
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>
	<form name="readFrm" method="get">
		<input type="hidden" name="num"> 
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="keyField" value="<%=keyField%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
	</form>
</div>
</body>
</html>
---------------------------------------------------------------------------------------------------------------------
[popup.jsp]
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="keywords" content="jQuery Window, Window Widget, Window" />
    <meta name="description" content="The jqxWindow is a floating window which have two main parts - title and content. In the title you can have any html content and close button.
                                      In the content you could put any html content." />
    <title id='Description'>You can use the jqxWindow to direct a user’s attention to a particular activity in your application,
    such as entering data or viewing information. Consider using a jqxWindow when you want greater customization, 
    you want to block the user interface outside the window, or when you want to retrieve a DialogResult and other data from the popup window. 
    jqxWindow can be displayed as a modal dialog window that blocks user interaction with the underlying user interface or as a standard window 
    without blocking the web page's user interface.</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />	
    <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/demos.js"></script> 
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxwindow.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpanel.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxtabs.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcheckbox.js"></script> 
    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
    <script type="text/javascript">
        var basicDemo = (function () {
            //Adding event listeners
            function _addEventListeners() {
                $('#resizeCheckBox').on('change', function (event) {
                    if (event.args.checked) {
                        $('#window').jqxWindow('resizable', true);
                    } else {
                        $('#window').jqxWindow('resizable', false);
                    }
                });
                $('#dragCheckBox').on('change', function (event) {
                    if (event.args.checked) {
                        $('#window').jqxWindow('draggable', true);
                    } else {
                        $('#window').jqxWindow('draggable', false);
                    }
                });
                $('#showWindowButton').click(function () {
                    $('#window').jqxWindow('open');
                });
                $('#hideWindowButton').click(function () {
                    $('#window').jqxWindow('close');
                });
            };
            //Creating all page elements which are jqxWidgets
            function _createElements() {
                $('#showWindowButton').jqxButton({ width: '70px' });
                $('#hideWindowButton').jqxButton({ width: '65px' });
                $('#resizeCheckBox').jqxCheckBox({ width: '185px', checked: true });
                $('#dragCheckBox').jqxCheckBox({ width: '185px', checked: true });
            };
            //Creating the demo window
            function _createWindow() {
                var jqxWidget = $('#jqxWidget');
                var offset = jqxWidget.offset();
                $('#window').jqxWindow({
                    position: { x: offset.left + 50, y: offset.top + 50} ,
                    showCollapseButton: true, maxHeight: 400, maxWidth: 700, minHeight: 200, minWidth: 200, height: 300, width: 500,
                    initContent: function () {
                        $('#tab').jqxTabs({ height: '100%', width:  '100%' });
                        $('#window').jqxWindow('focus');
                    }
                });
            };
            return {
                config: {
                    dragArea: null
                },
                init: function () {
                    //Creating all jqxWindgets except the window
                    _createElements();
                    //Attaching event listeners
                    _addEventListeners();
                    //Adding jqxWindow
                    _createWindow();
                }
            };
        } ());
        $(document).ready(function () {  
            //Initializing the demo
            basicDemo.init();
        });
    </script>
</head>
<body class='default'>
    <div id="jqxWidget">
        <div style="float: left;">
            <div>
                <input type="button" value="Open" id="showWindowButton" />
                <input type="button" value="Close" id="hideWindowButton" style="margin-left: 5px" />
            </div>
            <div style="margin-top: 10px;">
                <div id="resizeCheckBox">
                    Resizable
                </div>
                <div id="dragCheckBox">
                    Enable drag
                </div>
            </div>
        </div>
        <div style="width: 100%; height: 650px; margin-top: 50px;" id="mainDemoContainer">
            <div id="window">
                <div id="windowHeader">
                    <span>
                        <img src="../../images/movie.png" alt="" style="margin-right: 15px" />Movies
                    </span>
                </div>
                <div style="overflow: hidden;" id="windowContent">
                    <div id="tab">
                        <ul style="margin-left: 30px;">
                            <li>Avatar</li>
                            <li>End Game</li>
                            <li>Twilight</li>
                            <li>Unstoppable</li>
                            <li>Priest</li>
                        </ul>
                        <div>
                            <img src="../../images/avatar.png" style="float: left; margin: 10px;" alt="" />
                            Avatar is a 2009 American[6][7] epic science fiction film written and directed by
                            James Cameron, and starring Sam Worthington, Zoe Saldana, Stephen Lang, Michelle
                            Rodriguez, Joel David Moore, Giovanni Ribisi and Sigourney Weaver. The film is set
                            in the mid-22nd century, when humans are mining a precious mineral called unobtanium
                            on Pandora , a lush habitable moon of a gas giant in the Alpha Centauri star system.
                            The expansion of the mining colony threatens the continued existence of a local
                            tribe of Na'vi—a humanoid species indigenous to Pandora. The film's title refers
                            to the genetically engineered Na'vi-human hybrid bodies used by a team of researchers
                            to interact with the natives of Pandora.
                     </div>   <div>
                            <img src="../../images/endgame.png" style="float: left; margin: 10px;" alt="" />
                            End Game is a 2006 action/thriller film, written and directed by Andy Cheng. The
                            film stars Cuba Gooding, Jr. as Secret Service agent Alex Thomas, who is shot in
                            the hand, while unsuccessfully trying to protect the President (played by Jack Scalia)
                            from an assassin's bullet. Later, with the help of a persistent newspaper reporter
                            named Kate Crawford (played by Angie Harmon), he uncovers a vast conspiracy behind
                            what initially appeared to be a lone gunman. James Woods, Burt Reynolds, and Anne
                            Archer co–star in this film that was originally set to be shown in cinemas by MGM
                            in 2005, but was delayed by the takeover from Sony and eventually sent direct to
                            DVD.
                        </div>
                        <div>
                            <img src="../../images/twilight.png" style="float: left; margin: 10px;" alt="" />
                            The project was in development for approximately three years at Paramount Pictures,
                            during which time a screen adaptation that differed significantly from the novel
                            was written. Summit Entertainment acquired the rights to the novel after three years
                            of the project's stagnant development. Melissa Rosenberg wrote a new adaptation
                            of the novel shortly before the 2007–2008 Writers Guild of America strike and sought
                            to be faithful to the novel's storyline. Principal photography took 44 days, and
                            completed on May 2, 2008; the film was primarily shot in Oregon
                        </div>
                        <div>
                            <img src="../../images/unstoppable.png" style="float: left; margin: 10px;" alt="" />
                            Meanwhile, in a rail yard within the northern town of Fuller, two AWVR hostlers,
                            Dewey (Ethan Suplee) and Gilleece (T.J. Miller), are ordered by Fuller operations
                            dispatcher Bunny (Kevin Chapman) to move a freight train led by locomotive #777
                            (nicknamed "Triple Seven") off its current track to clear the track for an excursion
                            train carrying schoolchildren. Dewey attempts to take shortcuts, instructing Gilleece
                            to leave the hoses for the air brakes disconnected for the short trip. Dewey later
                            leaves the moving cab to throw a misaligned rail switch along the train's path,
                            but is unable to climb back on, as the train's throttle jumps from idle, to full
                            power. He is forced to report the train as a "coaster" to Fuller yardmaster Connie
                            Hooper (Rosario Dawson)...
                        </div>
                        <div>
                            <img src="../../images/priest.png" style="float: left; margin: 10px;" alt="" />
                            Priest is a 2011 American post-apocalyptic sci-fi western and supernatural action
                            film starring Paul Bettany as the title character. The film, directed by Scott Stewart,
                            is based on the Korean comic of the same name. In an alternate world, humanity and
                            vampires have warred for centuries. After the last Vampire War, the veteran Warrior
                            Priest (Bettany) lives in obscurity with other humans inside one of the Church's
                            walled cities. When the Priest's niece (Lily Collins) is kidnapped by vampires,
                            the Priest breaks his vows to hunt them down. He is accompanied by the niece's boyfriend
                            (Cam Gigandet), who is a wasteland sheriff, and a former Warrior Priestess (Maggie
                            Q).
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
[완성된popup]
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="keywords" content="jQuery Window, Window Widget, Window" />
    <meta name="description" content="The jqxWindow is a floating window which have two main parts - title and content. In the title you can have any html content and close button.
                                      In the content you could put any html content." />
    <title id='Description'>You can use the jqxWindow to direct a user’s attention to a particular activity in your application,
    such as entering data or viewing information. Consider using a jqxWindow when you want greater customization, 
    you want to block the user interface outside the window, or when you want to retrieve a DialogResult and other data from the popup window. 
    jqxWindow can be displayed as a modal dialog window that blocks user interaction with the underlying user interface or as a standard window 
    without blocking the web page's user interface.</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />	
    <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxwindow.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpanel.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxtabs.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/demos.js"></script> 
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxscrollbar.js"></script>
    <%-- <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcheckbox.js"></script>  --%>
    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
    <script type="text/javascript">
        var basicDemo = (function () {
        	
            //Adding event listeners( Checkbox )
            /* function _addEventListeners() {
                $('#resizeCheckBox').on('change', function (event) {
                    if (event.args.checked) {
                        $('#window').jqxWindow('resizable', true);
                    } else {
                        $('#window').jqxWindow('resizable', false);
                    }
                });
                $('#dragCheckBox').on('change', function (event) {
                    if (event.args.checked) {
                        $('#window').jqxWindow('draggable', true);
                    } else {
                        $('#window').jqxWindow('draggable', false);
                    }
                });
                $('#showWindowButton').click(function () {
                    $('#window').jqxWindow('open');
                });
                $('#hideWindowButton').click(function () {
                    $('#window').jqxWindow('close');
                });
            }; */
            
            // Creating Checkbox
            /* function _createElements() {
                $('#showWindowButton').jqxButton({ width: '70px' });
                $('#hideWindowButton').jqxButton({ width: '65px' });
                $('#resizeCheckBox').jqxCheckBox({ width: '185px', checked: true });
                $('#dragCheckBox').jqxCheckBox({ width: '185px', checked: true });
            }; */
            
            //Creating the demo window
            function _createWindow() {
                var jqxWidget = $('#jqxWidget');
                var offset = jqxWidget.offset();
                $('#window').jqxWindow({
                    position: { x: offset.left + 50, y: offset.top + 50} ,
                    showCollapseButton: true, maxHeight: 400, maxWidth: 700, minHeight: 200, minWidth: 200, height: 300, width: 500,
                    initContent: function () {
                        $('#tab').jqxTabs({ height: '100%', width:  '100%' });
                        $('#window').jqxWindow('focus');
                    }
                });
            };
            return {
                config: {
                    dragArea: null
                },
                init: function () {
                   
                    /* _createElements(); */
                    
                    /* _addEventListeners(); */
                    
                    _createWindow();
                }
            };
        } ());
        $(document).ready(function () {  
            //Initializing the demo
            basicDemo.init();
        });
    </script>
</head>
<body class='default'>
    <div id="jqxWidget">
        <!-- <div style="float: left;">
            <div>
                <input type="button" value="Open" id="showWindowButton" />
                <input type="button" value="Close" id="hideWindowButton" style="margin-left: 5px" />
            </div>
            <div style="margin-top: 10px;">
                <div id="resizeCheckBox">
                    Resizable
                </div>
                <div id="dragCheckBox">
                    Enable drag
                </div>
            </div>
        </div> -->
        <div style="width: 100%; height: 650px; margin-top: 50px;" id="mainDemoContainer">
            <div id="window">
                <div id="windowHeader">
                    <span>
				        공정계획
				    </span>
                </div>
                <div style="overflow: hidden;" id="windowContent">
                    <div id="tab">
                        <!-- <ul style="margin-left: 30px;">
                            <li>Avatar</li>
                            <li>End Game</li>
                            <li>Twilight</li>
                            <li>Unstoppable</li>
                            <li>Priest</li>
                        </ul> -->
                        <div>
                            context
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

[BoardMain]
package spring.plan;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import config.db.UtilMgr;

public class BoardMain {

	private config.db.DBConnectionMgr pool;
	private static final String  SAVEFOLDER = "C:/Temp";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;
	private static final int DOWNLOAD_BUFFER_SIZE = 1024*8;

	public BoardMain() {
		try {
			pool = config.db.DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시판 리스트
	public Vector<PlanBean> getBoardList(String keyField, String keyWord, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PlanBean> vlist = new Vector<PlanBean>();
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
				PlanBean bean = new PlanBean();
				bean.setNum(rs.getInt("num"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setProdName(rs.getString("prodName"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setEmpName(rs.getString("empName"));
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
			sql = "insert into Board(num,empName,content,prodName,ref,pos,depth,regdate,pass,ip,filename,filesize)"
						+"values(board_seq.currval,?, ?, ?, ?, 0, 0, sysdate, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("empName"));
			pstmt.setString(2, content);
			pstmt.setString(3, multi.getParameter("prodName"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, multi.getParameter("pass"));
			pstmt.setString(6, multi.getParameter("ip"));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);	//DB리소스 반환
		}
	}
	
	// 게시물 리턴
	public PlanBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PlanBean bean = new PlanBean();
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
	public void updateBoard(PlanBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update Board set empName = ?, prodName=?, content = ? where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getEmpName());
			pstmt.setString(2, bean.getProdName());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 게시물 답변
	public void replyBoard(PlanBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into Board (num,empName,content,prodName,ref,pos,depth,regdate,pass,ip)";
			sql += "values(board_seq.nextval,?,?,?,?,?,?,sysdate,?,?)";
			int depth = bean.getDepth() + 1;
			int pos = bean.getPos() + 1;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getEmpName());
			pstmt.setString(2, bean.getContent());
			pstmt.setString(3, bean.getProdName());
			pstmt.setInt(4, bean.getRef());
			pstmt.setInt(5, pos);
			pstmt.setInt(6, depth);
			pstmt.setString(7, bean.getPass());
			pstmt.setString(8, bean.getIp());
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
			sql = "insert into Board(empName,content,prodName,ref,pos,depth,regdate,pass,ip,filename,filesize)";
			sql+="values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1111', '127.0.0.1', null, 0);";
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
	
	//main
	public static void main(String[] args) {
		new BoardMain().post1000();
		System.out.println("SUCCESS");
	}
}

[writePost.jsp]
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>

<head>
<title>Process_Plan</title>
<link href="style.css" rel="stylesheet" type="text/css">
<!-- popup head -->
   <meta name="keywords" content="jQuery Window, Window Widget, Window" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />	
    <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxwindow.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpanel.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxtabs.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/demos.js"></script> 
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxscrollbar.js"></script>
    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
    <script type="text/javascript">
        var basicDemo = (function () {
        	
        	 function _addEventListeners() {
        		 $('#showWindowButton').click(function () {
                     $('#window').jqxWindow('open');
                 });
        	 }
            
            //Creating the demo window
            function _createWindow() {
                var writePost = $('#writePost');
                var offset = writePost.offset();
                $('#window').jqxWindow({
                    position: { x: offset.left + 50, y: offset.top + 50} ,
                    showCollapseButton: true, maxHeight: 400, maxWidth: 700, minHeight: 200, minWidth: 200, height: 300, width: 500,
                    initContent: function () {
                        $('#tab').jqxTabs({ height: '100%', width:  '100%' });
                        $('#window').jqxWindow('focus');
                    }
                });
            };
                      
            return {
                config: {
                    dragArea: null
                },
                init: function () {
                    _createWindow();
                }
            };
        } ());
        $(document).ready(function () {  
            //Initializing the demo
            basicDemo.init();
        });
    </script>
<!-- /popup head -->
</head>

<body class='default'>
    <div id="writePost">
        <div style="width: 100%; height: 650px; margin-top: 50px;" id="mainDemoContainer">
            <div id="window">
                <div id="windowHeader">
                    <span>
				        공정계획
				    </span>
                </div>
                <div style="overflow: hidden;" id="windowContent">
                    <div>
                        <div><!--context-->
						<div>
						<form name="postFrm" method="post" action="boardPost.do" enctype="multipart/form-data">
						<table width="700" cellpadding="3" align="center">
							<tr>
								<td align=center>
								<table align="center">
									
									<tr>
										<td>생산기간</td>
										<td>
											<input type ="date" name="startdate" value="" max="9999-12-31" size="10" maxlength="30">&nbsp;&nbsp;~&nbsp;&nbsp;
											<input type ="date" name="enddate" value="" max="9999-12-31" size="10" maxlength="30">
										</td>
									</tr>
									<tr>
									  	<td>생산상품</td>
										<td>
										    <select name="prodName">
										      <option value="" disabled selected hidden>상품을 선택하세요</option>
										      <option value="KBD001">Keyboard_click</option>
										      <option value="KBD002">Keyboard_nclick</option>
										      <option value="KBD003">Keyboard_linear</option>
										      <option value="KBD003">KeyCap_Dye</option>
										      <option value="KBD003">KeyCap_Shot</option>
										    </select>
										    &nbsp;&nbsp;상품코드<input name="prodNo" size="5" maxlength="8">
										</td>
									</tr>
									<tr>
										<td>생산계획</td>
										<td><input name="prodCnt" size="7" maxlength="20">개</td>
									</tr>
									<tr>
										<td>재고현황</td>
										<td>
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">개
										</td>
									</tr>
									<tr>
										<td></td>
										<td>
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">개
										</td>
									</tr>
									<tr>
										<td></td>
										<td>
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">개
										</td>
									</tr>
									<tr>
										<td></td>
										<td>
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">개
										</td>
									</tr>
									<tr>
										<td>비 고</td>
										<td><textarea name="content" rows="3" cols="50"></textarea></td>
									</tr>
									<tr>
										<td width="10%">담당자</td>
										<td width="90%">
										<input name="empName" size="15" maxlength="8"></td>
									</tr>
									<tr>
										<td>비밀 번호</td>
										<td><input type="password" name="pass" size="15" maxlength="15"></td>
									</tr>
									<tr>
									 <tr>
						     			<td>파일찾기</td> 
						     			<td><input type="file" name="filename" size="50" maxlength="50"></td>
						    		</tr>
						 			<tr>
						 				<td>내용타입</td>
						 				<td> HTML<input type=radio name="contentType" value="HTTP" >&nbsp;&nbsp;&nbsp;
						  			 	TEXT<input type=radio name="contentType" value="TEXT" checked>
						  			 	</td>
						 			</tr>
									<tr>
										<td colspan="2"><hr/></td>
									</tr>
									<tr>
										<td colspan="2">
											 <input type="submit" value="등록">
											 <input type="reset" value="다시쓰기">
											 <input type="button" value="리스트" onClick="javascript:location.href='plan.do'">
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
						</form>
						</div>
						</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

[BomController.java]

package controller.plan;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.plan.BomInfo;
import spring.dao.PlanDAO;

@Controller
@RequestMapping("/ajax")
public class BomController {

	@GetMapping("/prodVal.do")
	public void prodValSubmit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.print("success");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		//
		String[] prodValArray = (String[]) request.getParameterValues("prodVal");

		JSONArray json = new JSONArray();

		for (String str : prodValArray) {
			json.add(str);
		}
		
		//
		String prodNo = null;
		
		PlanDAO planDAO = new PlanDAO();
		
		Vector<BomInfo> bom = planDAO.getBomList(prodNo);
		
		for( BomInfo bominfo : bom) {
			String materNo = bominfo.getProdNo();
			String materprice = bominfo.getProdPrice();
			int materQty = bominfo.getMaterQty();
			
			json.add(bominfo);
		}
		
		//
		String jsonStr = json.toJSONString();
		PrintWriter writer = response.getWriter();
		writer.print(jsonStr);
	
		}

	}
----------------------------------------------------------------------------------
