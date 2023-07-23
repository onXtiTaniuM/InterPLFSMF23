<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="spring.auth.AuthInfo" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>TEST</title>
        <link href="${path}/resources/css/styles.css" rel="stylesheet" />
        <link href="${path}/resources/css/customstyle.css" rel="stylesheet" />
        <link href="${path}/resources/css/bootstrap.css" rel="stylesheet" />
		<link href="${path}/resources/css/style.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="shortcut icon" href="favicon.ico">
        
    </head>
    
    <body class="sb-nav-fixed">
        <!-- Top Nav Area -->
        <script src="${path}/resources/js/kor_clock.js"></script>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="${path}/main">SMF 4조</a>
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
                            <div class="sb-sidenav-menu-heading">Check</div>
                            <a class="nav-link" href="${path}/plan">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                계획관리
                            </a>
                            <a class="nav-link" href="${path}/inventory">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                재고관리
                            </a>
                            <div class="sb-sidenav-menu-heading">Process</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                생산관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="${path}/process">공정명령</a>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                        공정결과
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="${path}/preport/pr_product">상품별</a>
                                            <a class="nav-link" href="${path}/preport/pr_line">라인별</a>
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
		            <div id="fh5co-container">
						<div id="fh5co-events" data-section="events"  data-stellar-background-ratio="0.5">
							<div class="fh5co-overlay"></div>
							<div class="container">
								<div class="container-fluid px-4">
			                        <h1 class="mt-4" >제품 선택</h1>
			                        <ol class="breadcrumb mb-4">
			                            <li class="breadcrumb-item active"></li>
			                        </ol>
			                    </div>
								<div class="row">
									<div class="col-md-4">
										<div class="fh5co-event">
											<h3>KBD001</h3>
											<span class="fh5co-event-meta">청축 키보드</span>
											<p>사용하는 라인</p>
											<p>KBB01</p>
											<p>KBB02</p>
											<p><a href="${path}/preport/product?prodNo=KBD001&planID=KBPL01">상세페이지</a></p>
										</div>
									</div>
									<div class="col-md-4">
										<div class="fh5co-event">
											<h3>KBD002</h3>
											<span class="fh5co-event-meta">갈축 키보드</span>
											<p>사용하는 라인</p>
											<p>KBB01</p>
											<p>KBB02</p>
											<p><a href="${path}/preport/product?prodNo=KBD002&planID=KBPL03">상세페이지</a></p>
										</div>
									</div>
									<div class="col-md-4">
										<div class="fh5co-event">
											<h3>KBD003</h3>
											<span class="fh5co-event-meta">적축, 흑축 키보드</span>
											<p>사용하는 라인</p>
											<p>KBB01</p>
											<p>KBB02</p>
											<p><a href="${path}/preport/product?prodNo=KBD003&planID=KBPL02">상세페이지</a></p>
										</div>
									</div>
									<div class="col-md-4">
										<div class="fh5co-event">
											<h3>KC001</h3>
											<span class="fh5co-event-meta">염료승화 키캡</span>
											<p>사용하는 라인</p>
											<p>KCS01</p>
											<p>KCS02</p>
											<p><a href="${path}/preport/product?prodNo=KC001&planID=KCPL02">상세페이지</a></p>
										</div>
									</div>
									<div class="col-md-4">
										<div class="fh5co-event">
											<h3>KC002</h3>
											<span class="fh5co-event-meta">이중사출 키캡</span>
											<p>사용하는 라인</p>
											<p>KCS01</p>
											<p>KCS02</p>
											<p><a href="${path}/preport/product?prodNo=KC002&planID=KCPL01">상세페이지</a></p>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${path}/resources/js/chart-pie-demo.js"></script>
        <script src="${path}/resources/js/datatables-simple-demo.js"></script>
        
        <div>
        <form>
	<p>계획번호 선택</p>
	<select name = "planID">
	<c:forEach var="lnames" items="${l_names}">
		<option value="${lnames.planID}">${lnames.planID}</option>
	</c:forEach>
	</select>
</form>
        </div>
    </body>
</html>
