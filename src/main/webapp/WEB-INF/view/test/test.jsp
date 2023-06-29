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
        <script type="text/javascript" src="${path}/resources/jquery-3.6.0.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxwindow.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxscrollbar.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpanel.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxtabs.js"></script>
	    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcheckbox.js"></script>
	    <script type="text/javascript" src="${path}/resources/scripts/demos.js"></script>
	    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
    	<!-- jqWidgets popup window script -->
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
					                        <img src="../../../images/movie.png" alt="" style="margin-right: 15px" />Movies
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
					                            <img src="../../../images/avatar.png" style="float: left; margin: 10px;" alt="" />
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
					                            <img src="../../../images/endgame.png" style="float: left; margin: 10px;" alt="" />
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
					                            <img src="../../../images/twilight.png" style="float: left; margin: 10px;" alt="" />
					                            The project was in development for approximately three years at Paramount Pictures,
					                            during which time a screen adaptation that differed significantly from the novel
					                            was written. Summit Entertainment acquired the rights to the novel after three years
					                            of the project's stagnant development. Melissa Rosenberg wrote a new adaptation
					                            of the novel shortly before the 2007–2008 Writers Guild of America strike and sought
					                            to be faithful to the novel's storyline. Principal photography took 44 days, and
					                            completed on May 2, 2008; the film was primarily shot in Oregon
					                        </div>
					                        <div>
					                            <img src="../../../images/unstoppable.png" style="float: left; margin: 10px;" alt="" />
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
					                            <img src="../../../images/priest.png" style="float: left; margin: 10px;" alt="" />
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
