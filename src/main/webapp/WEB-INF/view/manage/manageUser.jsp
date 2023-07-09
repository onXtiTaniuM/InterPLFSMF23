<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="spring.auth.AuthInfo" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Manage</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    	<link href="${path}/resources/css/jquery.dataTables.css" rel="stylesheet" type="text/css" >
        <script src="${path}/resources/js/jquery-3.6.0.js"></script>
    	<script src="${path}/resources/js/jquery.dataTables.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- script for jq link -->
        <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxwindow.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxscrollbar.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpanel.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxtabs.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcheckbox.js"></script>
	    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
	    <script type="text/javascript">
	    	//password, id checker
	    	var passchecked = false;
	    	var passExpchecked = false;
	    	var emptychecked = false;
	    	
	    	$("#passConfirm").css('display', 'none');
	    	$("#passLength").css('display', 'none');
	    	let passExp = new RegExp('(?=.{6,})');
	    	
	    	function passExpChecker(){
	    		var password = document.getElementById("password");
	    		 if(!passExp.test(password.value)){
	    			 $("#passLength").css('display', 'inline-block');
	    			 passExpchecked = false;
	    		 }else{
	    			 $("#passLength").css('display', 'none');
	    			 passExpchecked = true;
	    		 };
	    	};
	    
	    	function passwordChecker(){
	    		var password = document.getElementById("password");
	    		var confirm_password = document.getElementById("passwordCheck");
	    		if(password.value != confirm_password.value){
	    			$("#passConfirm").css('display', 'inline-block');
	    			passchecked = false;
	    		}else{
	    			$("#passConfirm").css('display', 'none');
	    			passchecked = true;
	    		};
	    	};
			
	    	function fn_isempty(){
	    		var empno = document.getElementById("empNo");
	    		var id = document.getElementById("id");
	    		var name = document.getElementById("name");
	    		var rank = document.getElementById("rank");
	    		
	    		if (!(empno.value === "" || id.value === "" || name.value === "" || rank.value === "")) {
	    		    emptychecked = true;
	    		  };
	    	};
	    	
    		//register user ajax func
    		var usertable;
    		
    		function reloadList() {
				usertable.ajax.reload();
    		};
    	
        	function fn_register() {
        		fn_isempty();
        		if(emptychecked==false){
        			alert("입력되지 않은 값이 있습니다");
        			return;
        		}
        		
        		if((passExpchecked==false) || (passchecked==false)){
        			alert("비밀번호를 확인하세요");
        			return;
        		}else{
	    			var form = $("#registerForm")
		    		var regiuser = form.serialize();
		    		$.ajax({
		       			type:"post",  
		       			url:form.attr("action"),
		       			data:regiuser,
		       			success:function (data, textStatus) {
		       				alert("입력완료");
		       				reloadList();
		       				$("#registerForm")[0].reset();
		       			},
		       			complete:function(data,textStatus){
		       			},
		       			error:function(data, textStatus){
		          			alert("에러발생: " + data);
		       			},
		    		});
	    		};
        	};

        	//popup elements
        	var singupPop = (function () {
	            //Adding event listeners
	            function _addEventListeners() {
	                $('#register').click(function () {
	                    $('#window').jqxWindow('open');
	                });
	                $('#regsubmit').click(fn_register);
	            };
	
	            //Creating all page elements which are jqxWidgets
	            function _createElements() {
	                $('#register').jqxButton({ width: 120, height: 40 });
	                $('#regsubmit').jqxButton({ width: '65px' });
	            };
	
	            //Creating the window
	            function _createWindow() {
	                var jqxWidget = $('#jqxWidget');
	                var content = $('#userlist');
	                var offset = content.offset();
	
	                $('#window').jqxWindow({
						autoOpen: false,
	                    position: { x: offset.left+250, y: offset.top } ,
	                    showCollapseButton: true, 
	                    height: 560, width: 500,
	                    initContent: function () {
	                        $('#window').jqxWindow('focus');
	                    }
	                });
	                $('#window').jqxWindow('resizable', false);
	                $('#window').jqxWindow('draggable', true);
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
        	
        	//page ready js script
	    	$(document).ready(function () {
	    		usertable = new DataTable('#userlist', {
	    		    ajax: 'http://localhost:8584/SMFPlatform/manage/userlist.json'
	    		});
	        	singupPop.init();
	        	$("#passConfirm").css('display', 'none');
	        });
        	
    	</script>
    </head>
    <body class="sb-nav-fixed">
        <!-- Top Nav Area -->
        <script src="${path}/resources/js/kor_clock.js"></script>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="${path}">Platform Name</a>
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
                            <a class="nav-link" href="${path}/logout">
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
                                            <a class="nav-link" href="login">Login</a>
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
                        <h1 class="mt-4">Manage</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Manage</li>
                        </ol>
	    				<div class="card mb-4">
	                    	<div class="card-header">
	                        	<i class="fas fa-table me-1"></i>
	                            사용자 목록
	                        </div>
	                    	<div class="card-body">
			    				<table id="userlist" class="display" style="width:100%">
							        <thead>
							            <tr>
							                <th>사번</th>
							                <th>이름</th>
							                <th>ID</th>
							                <th>rank</th>
							                <th>등록일</th>
							                <th>관리자 권한</th>
							            </tr>
							        </thead>
							        <tfoot>
							            <tr>
							                <th>사번</th>
							                <th>이름</th>
							                <th>ID</th>
							                <th>rank</th>
							                <th>등록일</th>
							                <th>관리자 권한</th>
							            </tr>
							        </tfoot>
							    </table>
							    <div id="jqxWidget">
								    <div>
	       								<input type="button" value="사용자 신규등록" id='register' />	
	       							</div>
							  		<div id="window">
					                	<div id="windowHeader">
					                    	<span>
					                        	사용자 신규등록
					                    	</span>
					                	</div>
						                <div style="overflow: hidden;" id="windowContent">
	                                        <form:form id="registerForm" modelAttribute="manageUserCommand" action="${path}/manage/usermanagement/register.do" method="post">
	                                            <div class="form-floating mb-3">
	                                                <form:input class="form-control" placeholder="EmpNo" path="empNo" autocomplete="off" />
	                                                <label for="empNo">사번</label>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:input class="form-control" placeholder="Name" path="name" autocomplete="off" />
	                                                <label for="name">이름</label>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:input class="form-control" placeholder="ID" path="id" autocomplete="off" />
	                                                <label for="id">ID</label>
	                                                <p>아이디확인</p>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:password class="form-control" placeholder="Password" path="password" id="password" onkeyup="passExpChecker()"/>
	                                                <label for="password">비밀번호</label>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:password class="form-control" placeholder="PasswordCheck" path="passwordCheck" id="passwordCheck" onkeyup="passwordChecker()"/>
	                                                <label for="passwordCheck">비밀번호 확인</label>
										     		<span id="passConfirm" display="none">비밀번호가 일치하지 않습니다.</span>
										     		<span id="passLength" display="none">비밀번호는 6자리 이상이어야 합니다.</span>
	                                            </div>
	                                            <div class="form-floating mb-3">
	                                                <form:input class="form-control" placeholder="Rank" path="rank" />
	                                                <label for="rank">직급</label>
	                                            </div>
                                        	</form:form>
  											<input type="button" value="입력" id="regsubmit"/>
						                </div>
							    	</div>
						    	</div>
						    </div>
						</div>
					</div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${path}/resources/js/scripts.js"></script>
    </body>
</html>
