<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>TEST</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- jqWidgets script -->
        <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxwindow.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxscrollbar.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpanel.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxtabs.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcheckbox.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxinput.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxlistbox.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxdropdownlist.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxradiobutton.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxpasswordinput.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxnumberinput.js"></script>
    	<script type="text/javascript" src="${path}/resources/jqwidgets/jqxform.js"></script>
	    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
    	<!-- jqWidgets popup window script -->
    	<script type="text/javascript">    		        
    		//rank dropdown array
    		var options;
            function fetchDataAndSetDropdownOptions() {
                $.ajax({
                  type: 'POST',
                  url: 'http://localhost:8584/SMFPlatform/manage/ranklist.json',
                  dataType: 'json',
                  async: false,
                  success: function(data) {
                    options = data.map(function(item) {
                      return { label: item, value: item };
                    });
                  },
                  error: function(xhr, status, error) {
                    console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
                  }
                });
              }
            fetchDataAndSetDropdownOptions();  
            
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
	                	autoOpen: false,
	                    position: { x: offset.left + 50, y: offset.top + 50} ,
	                    showCollapseButton: true, 
	                    maxHeight: 400, maxWidth: 700, 
	                    minHeight: 200, minWidth: 200, 
	                    height: 400, width: 500,
	                    initContent: function () {
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
			
	        var template = [
                {
                    bind: 'empno',
                    type: 'text',
                    label: 'Text input',
                    labelPosition: 'left',
                    labelWidth: '30%',
                    align: 'left',
                    width: '250px',
                    required: true
                },
                {
                    bind: 'name',
                    type: 'text',
                    label: 'Text input',
                    labelPosition: 'left',
                    labelWidth: '30%',
                    align: 'left',
                    width: '250px',
                    required: true
                },
                {
                    bind: 'id',
                    type: 'text',
                    label: 'Text input',
                    labelPosition: 'left',
                    labelWidth: '30%',
                    align: 'left',
                    width: '250px',
                    required: true
                },
                {
                    bind: 'password',
                    type: 'password',
                    label: 'Password input',
                    labelPosition: 'left',
                    labelWidth: '30%',
                    align: 'left',
                    width: '250px',
                    required: true
                },
                {
                    bind: 'rank',
                    type: 'option',
                    label: 'Drop down list',
                    labelPosition: 'left',
                    labelWidth: '30%',
                    align: 'left',
                    width: '250px',
                    required: true,
                    component: 'jqxDropDownList',
                    options:  options
                },
                {
                    columns: [
                        {
                            columnWidth: '140px',
                            bind: 'admin',
                            type: 'boolean',
                            label: '관리자 권한',
                            labelPosition: 'left',
                            align: 'left',
                            labelPadding: {left: 5, top: 5, right: 0, bottom: 5}
                        } 
                    ]
                },
                {
                    type: 'blank',
                    rowHeight: '20px',
                },
                {
                    name: 'submitButton',
                    type: 'button',
                    text: 'Submit Form Data',
                    align: 'right',
                    padding: {left: 0, top: 5, bottom: 5, right: 40}
                }
            ];
            var sampleValue = {
                'empno': '사번',
                'name': '이름',
                'id': '아이디',
                'password': 'password123',
                'rank': 'Guest',
                'admin': false,
            };
            
	        $(document).ready(function () {  
	            //Initializing the demo
	            basicDemo.init();
	            var sampleForm = $('#sampleForm');
	            sampleForm.jqxForm({
	                template: template,
	                value: sampleValue,
	                padding: { left: 10, top: 10, right: 0, bottom: 10 }
	            });
	            var btn = sampleForm.jqxForm('getComponentByName', 'submitButton');
	            btn.on('click', function () {
	                // function: submit
	                // arg1: url
	                // arg2, optional: target, default is _blank
	                // arg3, optional: submit method - GET or POST, default is POST
	                sampleForm.jqxForm('submit', "https://www.jqwidgets.com/form_demo/", "_blank", 'POST');
	            });
	        });
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
                        <h1 class="mt-4">Test</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Test</li>
                        </ol>
                        
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
					                        Test
					                    </span>
					                </div>
					                <div style="overflow: hidden;" id="windowContent">
					                    <div id='sampleForm' style="width: 420px; height: auto;"></div>   
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
