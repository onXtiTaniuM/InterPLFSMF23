<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="spring.auth.AuthInfo" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!-- list.jsp Setting-->
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
<!-- /list.jsp Setting -->

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>TEST</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        
        <link href="style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
		function plan() {
			document.planFrm.action = "plan.do";
			document.planFrm.submit();
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
    <body class="sb-nav-fixed">
        <!-- Top Nav Area -->
        <script src="${path}/resources/js/kor_clock.js"></script>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="${path}/main">Platform Name</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
            <!-- Navbar Clock -->
            <div class="navbar-clock justify-content-end align-items-md-end text-end" id="navbar-clock">
		        <div id="date" class="date"></div>
		        <div id="time" class="time"></div>
            </div>
            <!-- Navbar-->
            <ul class="navbar-nav justify-content-end align-items-md-end">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <!-- contents for admin -->
                        <c:if test="${sessionScope.authInfo.getAdmin()}">
	                        <li><a class="dropdown-item" href="${path}/manage">Manage Settings</a></li>
	                        <li><hr class="dropdown-divider" /></li>
                        </c:if>
                        <li><a class="dropdown-item" href="${path}/logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <!-- Side and Main Area-->
        <div id="layoutSidenav">
            <!-- Side Nav Area-->
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Menu</div>
                            <a class="nav-link" href="${path}/plan">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                계획관리
                            </a>
                            <a class="nav-link" href="${path}/inventory">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                재고관리
                            </a>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                생산관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="${path}/process">공정명령</a>
                                    <a class="nav-link" href="${path}/report">공정결과</a>
                                </nav>
                            </div>
                            <a class="nav-link" href="${path}/report">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                보고서관리
                            </a>
                            <!-- Menu For Test-->
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                Pages
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        Authentication
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="${path}/login">Login</a>
                                            <a class="nav-link" href="register.html">Register</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        ${sessionScope.authInfo.getName()}
                    </div>
                </nav>
            </div>
            <!-- Inner Contents Area(main) -->
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <!-- list.jsp main-->
						<div align="center">
							<br/>
							<h2>Process Plan Board</h2>
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
												<td align="center" style="width: 70px;"><%=prodName%></a></td>
												<td align="center" style="width: 220px;"><%=startdate%> ~ <%=enddate%></td>
												<td align="center" style="width: 50px;">
												<%
													  if(depth>0){
														for(int j=0;j<depth;j++){
															out.println("&nbsp;&nbsp;");
															}
														}
												%>
												<a href="javascript:read('<%=num%>')">조회</a></td>
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
											<a href="javascript:plan()">[새로고침]</a>
										</td>
									</tr>
								</table>
							<hr width="600"/>
							<form  name="searchFrm"  method="get" action="plan.do">
							<table width="600" cellpadding="4" cellspacing="0">
						 		<tr>	
						  			<td align="center" valign="bottom">
						   				<select name="keyField" size="1" >
						    				<option value="empName"> 담당자</option>
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
							<form name="planFrm" method="post">
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
					<!-- /list.jsp main-->
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${path}/resources/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    </body>
</html>
