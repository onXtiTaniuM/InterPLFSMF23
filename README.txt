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