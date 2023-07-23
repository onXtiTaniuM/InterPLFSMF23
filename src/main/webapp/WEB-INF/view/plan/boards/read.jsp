<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="spring.plan.PlanInfo"%>
<%@page import="spring.plan.ProdInfo"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="bMgr" class="spring.dao.PlanDao" />
<%
request.setCharacterEncoding("UTF-8");
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");
	  String keyWord = request.getParameter("keyWord");
	  
	  PlanInfo bean = bMgr.getBoard(num);//게시물 가져오기
	  String empname = bean.getEmpName();
	  String prodName = bean.getProdName();
	  String prodNo = bean.getProdNo();
      String regdate = bean.getRegdate();							
	  Date startdate = bean.getStartdate();
	  Date enddate = bean.getEnddate();
	  String content = bean.getContent();
	  String filename = bean.getFilename();
	  int filesize = bean.getFilesize();
	  String ip = bean.getIp();
	  session.setAttribute("bean", bean);//게시물을 세션에 저장

%>
<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function plan(){
	    document.planFrm.submit();
	 } 
	
	function down(filename){
		 document.downFrm.filename.value=filename;
		 document.downFrm.submit();
	}
</script>
</head>
<body>
<br/><br/>
<table align="center" width="800" cellspacing="3">
 <tr>
  <td bgcolor="#9CA2EE" height="25" align="center">상세보기</td>
 </tr>
 <tr>
  <td colspan="2">
   <table cellpadding="3" cellspacing="0" width="100%"> 
    <tr> 
  		<td align="center" bgcolor="#DDDDDD" width="10%"> 등록날짜 </td>
  		<td bgcolor="#FFFFE8"><%=regdate%></td>
  	</tr>
    <tr>
  		<td align="center" bgcolor="#DDDDDD" width="10%"> 담당자 </td>
  		<td bgcolor="#FFFFE8"><%=empname%></td>
 	</tr>
 		<td align="center" bgcolor="#DDDDDD" width="10%"> 생산기간 </td>
  		<td bgcolor="#FFFFE8"><%=startdate%> ~ <%=enddate%></td>
	 <tr> 
	    <td align="center" bgcolor="#DDDDDD"> 생산상품</td>
	    <td bgcolor="#FFFFE8" colspan="3"><%=prodName%></td>
	 </tr>
	 <tr>
	    <td align="center" bgcolor="#DDDDDD"> 상품코드</td>
	    <td bgcolor="#FFFFE8" colspan="3"><%=prodNo%></td>
	 </tr>
	 <tr>
	    <td align="center" bgcolor="#DDDDDD"> 생산계획</td>
	    <td bgcolor="#FFFFE8" colspan="3">ProdCnt</td>
	 </tr>
	 <tr>
	    <td align="center" bgcolor="#DDDDDD"> 재고현황</td>
	    <td bgcolor="#FFFFE8" colspan="3">[재고가표시]</td>
	 </tr>
	 <tr> 
	    <td align="center" bgcolor="#DDDDDD"> 비 고</td>
	    <td bgcolor="#FFFFE8" colspan="3"><%=content%></td>
	 </tr>
	 <tr> 
	     <td align="center" bgcolor="#DDDDDD">첨부파일</td>
	     <td bgcolor="#FFFFE8" colspan="3">
	     <% if( filename !=null && !filename.equals("")) {%> <%--파일 이름이(파일이)있는 경우 --%>
	  		<a href="javascript:down('<%=filename%>')"><%=filename%></a>
	  		 &nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)</font>  
	  		 <%} else{%> 등록된 파일이 없습니다.<%}%>
	     </td>
	 </tr>
	 <tr> 
	 	<td colspan="4"><br/><pre>제작중...</pre><br/></td>
	 </tr>
	 <tr>
	     <td colspan="4" align="right">
	     	오른쪽
	     </td>
	 </tr>
   </table>
  </td>
 </tr>

 <tr>
  <td align="center" colspan="2"> 
 <hr/>
 [ <a href="javascript:plan()" >Back</a> | 
 <a href="update.do?nowPage=<%=nowPage%>&num=<%=num%>" >Edit</a> |
 <a href="reply.do?nowPage=<%=nowPage%>" >Reply</a> |
 <a href="delete.do?nowPage=<%=nowPage%>&num=<%=num%>">Delete</a> ]<br/>
  </td>
 </tr>
</table>

<form name="downFrm" action="download.do" method="post">
	<input type="hidden" name="filename">
</form>

<form name="planFrm" method="post" action="plan.do">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<%if(!(keyWord==null || keyWord.equals(""))){ %>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>
</body>
</html>