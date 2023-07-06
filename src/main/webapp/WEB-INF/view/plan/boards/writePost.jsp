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