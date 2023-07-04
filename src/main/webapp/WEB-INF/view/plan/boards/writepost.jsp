<%@ page contentType="text/html; charset=UTF-8" %>
<html>

<head>
<title>Process_Plan</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFCC">
<div align="center">
<br/><br/>
<table width="600" cellpadding="3">
	<tr>
		<td bgcolor="84F399" height="25" align="center">공정계획</td>
	</tr>
</table>
<br/>
<form name="postFrm" method="post" action="boardPost.do" enctype="multipart/form-data">
<table width="600" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			
			<tr>
				<td>생성일자</td>
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
					 <input type="button" value="리스트" onClick="javascript:location.href='list.do'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
</form>
</div>
</body>
</html>