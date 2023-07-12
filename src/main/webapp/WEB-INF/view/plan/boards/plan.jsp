<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="spring.auth.AuthInfo" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!-- list.jsp Setting-->
<%@page import="spring.plan.PlanInfo"%>
<%@page import="spring.plan.ProdInfo"%>
<%@page import="spring.dao.PlanDAO"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Date"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<jsp:useBean id="bMgr" class="spring.dao.PlanDAO" />
<%
	/* request.setCharacterEncoding("UTF-8");

	String contextPath = request.getContextPath();
	System.out.println("contextPath : " + contextPath); */
	
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
	
	Vector<PlanInfo> vlist = null;		//게시글 목록, 즉 bean을 vector로 배열
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

<!-- writepost.jsp -->
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

<script type="text/javascript" src="${path}/resources/jqwidgets/jqxribbon.js"></script>
<script type="text/javascript" src="${path}/resources/jqwidgets/jqxlayout.js"></script>
<script type="text/javascript" src="${path}/resources/jqwidgets/jqxtree.js"></script>

<link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
<script type="text/javascript">
        var basicDemo = (function () {
        	
        	function down(filename){
	       		 document.downFrm.filename.value=filename;
	       		 document.downFrm.submit();
       		}
        	
        	function _addEventListeners() {
          		 $('#writePost').click(function () {
                       $('#window').jqxWindow('open');
                   });
          		 
          		$('#read').click(function () {
                    $('#window').jqxWindow('open');
                });
          	 	}
            
            //Creating the demo window
            function _createWindow() {
                var writePost = $('#writePost');
                var offset = writePost.offset();
                $('#window').jqxWindow({
                	autoOpen: false,
                    position: { x: offset.left + 50, y: offset.top + 50} ,
                    showCollapseButton: true, maxHeight: 1000, maxWidth: 2000,
                    						  minHeight: 800, minWidth: 400,
                    						  height: 760, width: 1300,
                    						  position: { x: '20%', y: '13%' },
                    initContent: function () {
                        /* $('#tab').jqxTabs({ height: '100%', width:  '100%' }); */
                        $('#window').jqxWindow('focus');
                    }
                });
            };
            
/*           //Creating the demo window
            function _createWindow() {
                var writePost = $('#read');
                var offset = writePost.offset();
                $('#window').jqxWindow({
                	autoOpen: false,
                    position: { x: offset.left + 50, y: offset.top + 50} ,
                    showCollapseButton: true, maxHeight: 800, maxWidth: 1000,
                    						  minHeight: 400, minWidth: 400,
                    						  height: 760, width: 1000,
                    						  position: { x: '25%', y: '13%' },
                    initContent: function () {
                        $('#tab').jqxTabs({ height: '100%', width:  '100%' }); 
                        $('#window').jqxWindow('focus');
                    }
                });
            }; */
                      
            return {
                config: {
                    dragArea: null
                },
                init: function () {
                	
                	_addEventListeners();
                	
                    _createWindow();
                }
            };
        } ());
        $(document).ready(function () {  
            //Initializing the demo
            basicDemo.init();
        });
    </script>
    
    
<!-- /writepost.jsp -->
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
			document.readFrm.action="${path}/boards/read.do";
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
		//상품코드 자동입력
		function updateProdNo(selectElement) {
		    var selectedOption = selectElement.options[selectElement.selectedIndex];
		    var prodNoInput = document.getElementById('prodNoInput');
		    prodNoInput.value = selectedOption.value;
		}
		
	</script>
	
	<style>
		.new_form_table_col_1 {
        padding-right: 10px;
        padding-top: 10px;
        padding-bottom: 10px;
    	}
    	
    	.new_form_table_col_2 {
        padding: 10px;
    	}
    	
    	.jqx-layout-group-auto-hide-content-vertical
        {
            width: 200px;
        }
	</style>
	
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
                            <a class="nav-link" href="${path}/boards/plan.do">
                                <div class="b-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
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
										out.println("등록된 데이터가 없습니다.");
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
											PlanInfo bean = vlist.get(i);
											
											int num = bean.getNum();
											String content = bean.getContent();
											String prodName = bean.getProdName();
											String prodNo = bean.getProdNo();
											String regdate = bean.getRegdate();
											String empName = bean.getEmpName();							
											Date startdate = bean.getStartdate();
											Date enddate = bean.getEnddate();
											int depth = bean.getDepth();
											%>
											<tr>
												<td align="center">
													<%=(nowPage-1)*numPerPage+listSize-i%>
												</td>
												<td align="center" style="width: 150px;"><%=regdate.toString().substring(0, 16)%></td>
												<td align="center" style="width: 70px;"><%=prodName%></td>
												<td align="center" style="width: 220px;"><%=startdate%> ~ <%=enddate%></td>
												<td align="center" style="width: 50px;">
												<%
													  if(depth>0){
														for(int j=0;j<depth;j++){
															out.println("&nbsp;&nbsp;");
															}
														}
												%>
												<a href="javascript:read('<%=num%>')" id="read">조회</a></td>
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
											<!-- <a href="popup.do">[팝업]</a>
											<a href="writePost.do">[신규]</a> -->
											<input type="button" value="New" id="writePost"/>
											<input type="button" value="Refresh" onclick="plan()">

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
        <!-- wirtePost_PopupForm -->
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
						<table width="1200" cellpadding="5" align="center">
							<tr>
								<td align=center>
								<table align="left">
									<tr>
										<br/>
										<br/>
										<td class="new_form_table_col_1" nowrap>생산기간</td>
										<td>
											<input type ="date" name="startdate" value="" max="9999-12-31" size="10" maxlength="30">&nbsp;&nbsp;~&nbsp;&nbsp;
											<input type ="date" name="enddate" value="" max="9999-12-31" size="10" maxlength="30">
										</td>
									</tr>
									<tr>
									  	<td class="new_form_table_col_1" nowrap>생산상품</td>
										<td class="new_form_table_col_1" nowrap>
				
										    <select name="prodName" style="width:235px" onchange="updateProdNo(this)">
										      <option value="" disabled selected hidden>상품을 선택하세요</option>
										      <%= bMgr.prodOptions()%>
									          <!-- <option value="KBD001">Keyboard_click</option>
										      <option value="KBD002">Keyboard_nclick</option>
										      <option value="KBD003">Keyboard_linear</option>
										      <option value="KBD004">KeyCap_Dye</option>
										      <option value="KBD005">KeyCap_Shot</option> -->
										    </select>
										    <span class="new_form_table_col_2" nowrap >상품코드</span>
										    <input type="text" name="prodNo" id="prodNoInput" size="10" maxlength="8">
										</td>
									</tr>
									<tr>
										<td class="new_form_table_col_1" nowrap>생산계획</td>
										<td>
											<input type="number" name="prodCnt" size="18">
											<input type="button" name="bomList" value="확인" onClick="javascript:location.href='bomList.do'">
										</td>
									</tr>
									<tr>
										<td class="new_form_table_col_1" nowrap>재고현황</td>
										<td class="new_form_table_col_1" nowrap>
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">&nbsp;&nbsp;
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">&nbsp;&nbsp;
										</td>
									</tr>
									<tr>
										<td></td>
										<td class="new_form_table_col_1" nowrap>
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">&nbsp;&nbsp;
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">&nbsp;&nbsp;
										</td>
									</tr>
									<tr>
										<td></td>
										<td class="new_form_table_col_1" nowrap>
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">&nbsp;&nbsp;
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">&nbsp;&nbsp;
										</td>
									</tr>
									<tr>
										<td></td>
										<td class="new_form_table_col_1" nowrap>
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">&nbsp;&nbsp;
											<input name="" size="10" maxlength="20">
											<input name="" size="7" maxlength="20">&nbsp;&nbsp;
										</td>
									</tr>
									<tr>
										<td class="new_form_table_col_1" nowrap>비 고</td>
										<td><textarea name="content" rows="2" cols="48"></textarea></td>
									</tr>
									<tr>
										<td width="10%" class="new_form_table_col_1" nowrap>담당자</td>
										<td width="90%">
										<input name="empName" size="21" maxlength="8"></td>
									</tr>
									<tr>
										<td class="new_form_table_col_1" nowrap>패스워드</td>
										<td><input type="password" name="pass" size="21" maxlength="15"></td>
									</tr>
									<tr>
									 <tr>
						     			<td class="new_form_table_col_1" nowrap>파일찾기</td> 
						     			<td><input type="file" name="filename" size="50" maxlength="50"></td>
						    		</tr>
						 			<tr>
						 				<td class="new_form_table_col_1" nowrap>내용타입</td>
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
    <!-- /wirtePost_PopupForm -->
       
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${path}/resources/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    </body>
</html>
