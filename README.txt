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