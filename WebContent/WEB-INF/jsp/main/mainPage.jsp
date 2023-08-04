<%@page import="model.movie.RankDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="model.notice.NoticeDAO"%>
<%@ page import="model.notice.NoticeDTO"%>
<%@ page import="model.fboard.FboardDAO"%>
<%@ page import="model.fboard.FboardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main/mainPage.css?after">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
	  var logButton = document.getElementById("logBtn");

	  var userNick = '<%= session.getAttribute("userNick") %>';

	  if (userNick === "null") {
	    userNick = "";
	  }

	  function redirectToLogin() {
	    window.location.href = "LoginController";
	  }

	  function redirectToLogout() {
	    $.ajax({
	      type: "POST",
	      url: "LogoutController",
	      data: { userNick: userNick },
	      success: function(response) {
	        window.location.reload(); //새로고침
	      },
	      error: function(xhr, status, error) {
	        console.error("Logout error: " + status + " - " + error);
	      }
	    });
	  }

	  logButton.value = userNick === "" ? "로그인" : "로그아웃";

	  logButton.onclick = function(event) {
	    if (userNick === "") {
	      redirectToLogin();
	    } else {
	      redirectToLogout();
	    }
	    event.preventDefault();
	  };

	  const myPageLink = document.querySelector(".navi_a[title='myPage']");

	  myPageLink.addEventListener('click', function(event) {
	    if (userNick == "") {
	      location.href = "LoginController";
	    } else {
	      location.href = "myPageController";
	    }
	  });
	});
</script>

    <% ArrayList<RankDTO> rankList = (ArrayList<RankDTO>) request.getAttribute("rankList"); %>
</head>

<body>
    <div id="layout">
        <div id="root">
            <main id="contents" class="main web">
                <div class="header-wrap">
                    <div class="main-header">
                        <h1 class="main-title">
                            <img src="${pageContext.request.contextPath}/img/main/mainLogo.PNG">
                        </h1>
                    </div>
                    <div>
                        <input type="button" id="logBtn" class="logBtn" value="로그인" onClick="location.href='LoginController'">
                    </div>
                </div>
                <div class="main-content-wrap">
                    <div class="mainContent">
                        <div class="top-bar" id="topBar">
                            <div class="top-bar-section">
                                <div class="content"></div>
                            </div>
                            <div class="top-bar-section">
                                <div class="content"></div>
                            </div>
                            <div class="top-bar-section">
                                <div class="content"></div>
                            </div>
                            <div class="top-bar-section">
                                <div class="content"></div>
                            </div>
                            <div class="top-bar-section">
                                <div class="content"></div>
                            </div>
                            <div class="top-bar-section">
                                <div class="content"></div>
                            </div>
                            <div class="top-bar-section">
                                <div class="content"></div>
                            </div>
                            <!-- Section 8 -->
                            <div class="top-bar-section">
                                <div class="content"></div>
                            </div>
                            <!-- Section 9 -->
                            <div class="top-bar-section">
                                <div class="content"></div>
                            </div>
                        </div>
                    </div>
                    <div class="main-content-wrap">
                        <div class="mainContent">
                            <section class="home-community-wrap">
                                <div class="home-title-wrapper">
                                    <h3 class="home-title">최신 리뷰 한줄평 ✍🏻</h3>
                                    <a href="./Review" class="home-more-btn"> <span class="button-area"><i class="fa-solid fa-chevron-up fa-rotate-90 fa-lg"></i></span>
                                    </a>
                                </div>
                                <div class="ranking-wrapper">
                                    <div class="swiper-wrap">
                                        <div class="target observer-target"></div>
                                        <div class="swiper-container">
                                            <div class="swiper-wrapper">
                                                <c:forEach var="reviewList" items="${reviewList }">
                                                    <div class="swiper-slide">
                                             		<c:url value="/movieInfo" var="url">
													<c:param name="movieCd" value="${reviewList.movieCd}" />
													</c:url>
														<a href="${url}" class="aRank">
                                                            <article class="review-item">
                                                                <h5 class="review-movie-title">
                                                                    <c:out value="${reviewList.movieNm }" />
                                                                </h5>
                                                                <p>
                                                                    <c:out value="${reviewList.review }" />
                                                                </p>
                                                                <div class="review-item-user">
                                                                    <i class="fa-solid fa-circle" style="color: #50cd23;"></i>
                                                                    <div class="user-nickname">
                                                                        <span class="user-name"><c:out value="${reviewList.memberNc }"></c:out> </span> <span
                                                                            class="user-rating-of">님의 평가</span>
                                                                    </div>
                                                                </div>
                                                            </article>
                                                        </a>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                        </div>
                                        <button id="allReviewsPrev" class="fa-solid fa-angle-left fa-lg" tabindex="-1" role="button" aria-laber="Previous slide"
                                            aria-disabled="true"></button>
                                        <svg width="16" height="16" fill="none" viewBox="0 0 16 16" preserveAspectRatio="none" class="btnSvg">
                                        </svg>
                                        <button id="allReviewsNext" class="fa-solid fa-angle-left fa-rotate-180 fa-lg" tabindex="0" role="button" aria-label="Next slide"
                                            aria-disabled="false"></button>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                    <div class="main-content-wrap2">
                        <div class="mainContent2">
                            <section class="home-title-wrapper">
                                <h3 class="home-title">최신 게시글📌</h3>
                                <a href="http://localhost:8081/MovieMate/freeCommunityController" class="community-btn"> <span class="button-area"><i class="fa-solid fa-chevron-up fa-rotate-90 fa-lg"></i></span>
                                </a>
                            </section>
                            <div class="ranking-wrapper">
                                <div class="swiper-wrap">
                                    <div class="target observer-target"></div>
                                    <div class="swiper-container2">
                                        <% ArrayList<FboardDTO> fBoardList = (ArrayList<FboardDTO>) request.getAttribute("fBoardList"); %>
                                        <div class="swiper-wrapper">
                                        <% for (FboardDTO fDto : fBoardList) { %>
                                            <div class="swiper-slide swiper-slide-active">
                                                <a to="/review/all" class="reviewContentsSection" href="ReadFreeDetailController?no=<%=fDto.getFboard_no()%>">
                                                    <article class="review-item">
                                                        <p><%=fDto.getFb_title()%></p>
                                                        <div class="review-item-user">
                                                            <i class="fa-solid fa-circle" style="color: #efefef;"></i>
                                                            <div class="user-nickname">
                                                                <span class="user-name"><%=fDto.getMem_nick()%></span>
                                                            </div>
                                                        </div>
                                                    </article>
                                                </a>
                                            </div>
                                            <%} %>
                                          <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                       </div>
                                    </div>
                                        <button id="allReviewsPrev2" class="fa-solid fa-angle-left fa-lg" tabindex="-1" role="button" aria-laber="Previous slide"
                                            aria-disabled="true"></button>
                                        <svg width="16" height="16" fill="none" viewBox="0 0 16 16" preserveAspectRatio="none" class="btnSvg">
                                        </svg>
                                        <button id="allReviewsNext2" class="fa-solid fa-angle-left fa-rotate-180 fa-lg" tabindex="0" role="button" aria-label="Next slide"
                                            aria-disabled="false"></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="main-content-wrap">
                    <div class="mainContent">
                        <section class="home-title-wrapper">
                            <h3 class="home-title">공지사항</h3>
                        </section>
                        <div class="notice-wrapper">
                        <% ArrayList<NoticeDTO> noticeList = (ArrayList<NoticeDTO>) request.getAttribute("noticeList"); %>
                            <% for (NoticeDTO nDto : noticeList) { %>
                            <ul class="notice-list">
                                <li class="notice-item"><a href="ReadNoticeDetailController?no=<%=nDto.getNotice_no()%>"><%=nDto.getN_title()%></a></li>
                            </ul>
                                <%} %>
                        </div>
                    </div>
                </div>
                <header class="header">
                    <nav class="navi">
                        <a class="navi_a" title="home" href="${pageContext.request.contextPath}/mainController" style="color: #efefef;"><i class="navi-i fa-solid fa-house fa-xl"></i><br> <span>홈</span></a>
                        <a class="navi_a" title="search" href="${pageContext.request.contextPath}/SearchMovie"><i class="navi-i fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br> <span>검색</span></a>
                        <a class="navi_a" title="community" href="${pageContext.request.contextPath}/freeCommunityController"><i class="navi-i fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br> <span>커뮤니티</span></a>
                        <a class="navi_a" title="myPage" href="${pageContext.request.contextPath}/myPageController"><i class="navi-i fa-solid fa-user fa-xl"></i><br> <span>마이페이지</span></a>
                    </nav>
                </header>
            </main>
        </div>
    </div>
        <script>
            function createSection(content) {
                const section = document.createElement('div');
                section.classList.add('top-bar-section');
                const contentDiv = document.createElement('div');
                contentDiv.classList.add('content');
                contentDiv.innerHTML = content;
                section.appendChild(contentDiv);
                return section;
            }

            function changeContent() {
                const topBar = document.getElementById("topBar");
                const contentList1 = [
                    '<a href="movieInfo?movieCd=<%=rankList.get(0).getMovieCd()%>"><img src="${pageContext.request.contextPath}/<%=rankList.get(0).getPoster() %>"><span><%=rankList.get(0).getRank() %>위&nbsp;<%=rankList.get(0).getMovieNm() %></span></a>',
                    '<a href="movieInfo?movieCd=<%=rankList.get(1).getMovieCd()%>"><img src="${pageContext.request.contextPath}/<%=rankList.get(1).getPoster() %>"><span><%=rankList.get(1).getRank() %>위&nbsp;<%=rankList.get(1).getMovieNm() %></span></a>',
                    '<a href="movieInfo?movieCd=<%=rankList.get(2).getMovieCd()%>"><img src="${pageContext.request.contextPath}/<%=rankList.get(2).getPoster() %>"><span><%=rankList.get(2).getRank() %>위&nbsp;<%=rankList.get(2).getMovieNm() %></span></a>'
                ];

                const contentList2 = [
                    '<a href="movieInfo?movieCd=<%=rankList.get(3).getMovieCd()%>"><img src="${pageContext.request.contextPath}/<%=rankList.get(3).getPoster() %>"><span><%=rankList.get(3).getRank() %>위&nbsp;<%=rankList.get(3).getMovieNm() %></span></a>',
                    '<a href="movieInfo?movieCd=<%=rankList.get(4).getMovieCd()%>"><img src="${pageContext.request.contextPath}/<%=rankList.get(4).getPoster() %>"><span><%=rankList.get(4).getRank() %>위&nbsp;<%=rankList.get(4).getMovieNm() %></span></a>',
                    '<a href="movieInfo?movieCd=<%=rankList.get(5).getMovieCd()%>"><img src="${pageContext.request.contextPath}/<%=rankList.get(5).getPoster() %>"><span><%=rankList.get(5).getRank() %>위&nbsp;<%=rankList.get(5).getMovieNm() %></span></a>',
                    '<a href="movieInfo?movieCd=<%=rankList.get(6).getMovieCd()%>"><img src="${pageContext.request.contextPath}/<%=rankList.get(6).getPoster() %>"><span><%=rankList.get(6).getRank() %>위&nbsp;<%=rankList.get(6).getMovieNm() %></span></a>',
                    '<a href="movieInfo?movieCd=<%=rankList.get(7).getMovieCd()%>"><img src="${pageContext.request.contextPath}/<%=rankList.get(7).getPoster() %>"><span><%=rankList.get(7).getRank() %>위&nbsp;<%=rankList.get(7).getMovieNm() %></span></a>',
                    '<a href="movieInfo?movieCd=<%=rankList.get(8).getMovieCd()%>"><img src="${pageContext.request.contextPath}/<%=rankList.get(8).getPoster() %>"><span><%=rankList.get(8).getRank()%>위&nbsp;<%=rankList.get(8).getMovieNm()%></span></a>'
                ];

                let currentContentList = contentList1;
                let currentIndex = 0;

                function updateContent() {
                    topBar.innerHTML = '';

                    const startIndex = currentIndex;
                    const endIndex = Math.min(currentIndex + 3, currentContentList.length);

                    for (let i = startIndex; i < endIndex; i++) {
                        const section = createSection(currentContentList[i]);
                        topBar.appendChild(section);

                        setTimeout(() => {
                            section.classList.add('active');
                        }, 10);
                    }
                  currentIndex += 3;
                    if (currentIndex >= currentContentList.length) {
                        currentContentList = currentContentList === contentList1 ? contentList2 : contentList1;
                        currentIndex = 0;
                    }
                }

                updateContent();
                setInterval(updateContent, 5000);
            }

            changeContent();
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function(event) {
                var swiperContainer = document.querySelector('.swiper-container');
                var slideWidth = swiperContainer.offsetWidth; // 각 슬라이드의 가로 폭
                var scrollDistance = 682.9; // 스크롤할 거리 (한 슬라이드의 가로 폭과 동일)

                var isNextButtonClicked = false; // 'allReviewsNext' 버튼이 클릭되었는지 여부를 추적하는 플래그
                var isMouseDown = false;
                var startX, scrollLeft;

                function updateButtonVisibility() {
                    // 오른쪽으로 스크롤할 내용이 남아있는지 확인
                    var remainingScrollWidth = swiperContainer.scrollWidth - swiperContainer.scrollLeft - swiperContainer.offsetWidth;
                    var shouldShowNextButton = remainingScrollWidth > 0;
                    var shouldShowPrevButton = swiperContainer.scrollLeft > 0;

                    // 'allReviewsNext' 버튼의 표시 여부 결정
                    var allReviewsNextButton = document.getElementById('allReviewsNext');
                    if (shouldShowNextButton) {
                        allReviewsNextButton.style.display = 'block';
                    } else {
                        allReviewsNextButton.style.display = 'none';
                    }

                    // 'allReviewsPrev' 버튼의 표시 여부를 isNextButtonClicked 플래그와 연동하여 결정
                    var allReviewsPrevButton = document.getElementById('allReviewsPrev');
                    if (shouldShowPrevButton && isNextButtonClicked) {
                        allReviewsPrevButton.style.display = 'block';
                    } else {
                        allReviewsPrevButton.style.display = 'none';
                    }
                }

                // 버튼 표시 여부 초기 체크
                updateButtonVisibility();

                document.getElementById('allReviewsNext').addEventListener('click', function() {
                    // 현재 스크롤 위치와 이동할 위치 계산
                    var currentPosition = swiperContainer.scrollLeft;
                    var targetPosition = currentPosition + scrollDistance; // 오른쪽으로 스크롤하기 위해 "+" 사용

                    // 스크롤 애니메이션 적용
                    swiperContainer.scrollTo({
                        left: targetPosition,
                        behavior: 'smooth', // 부드럽게 애니메이션 효과 적용
                    });

                    // 'allReviewsNext' 버튼이 클릭되었다는 플래그를 true로 설정
                    isNextButtonClicked = true;

                    // 스크롤 애니메이션이 끝난 후 버튼 표시 상태 업데이트
                    setTimeout(updateButtonVisibility, 500); // 필요에 따라 timeout 값을 조정합니다.
                });

                document.getElementById('allReviewsPrev').addEventListener('click', function() {
                    // 현재 스크롤 위치와 이동할 위치 계산
                    console.log("aa");
                    var currentPosition = swiperContainer.scrollLeft;
                    var targetPosition = currentPosition - scrollDistance; // 왼쪽으로 스크롤하기 위해 "-" 사용

                    // 스크롤 애니메이션 적용
                    swiperContainer.scrollTo({
                        left: targetPosition,
                        behavior: 'smooth', // 부드럽게 애니메이션 효과 적용
                    });

                    // 스크롤 애니메이션이 끝난 후 버튼 표시 상태 업데이트 딜레이 적용
                    setTimeout(function() {
                        // 'allReviewsPrev' 버튼이 클릭되었을 때 isNextButtonClicked 플래그를 false로 설정
                        isNextButtonClicked = false;

                        // 스크롤 애니메이션이 끝난 후 버튼 표시 상태 업데이트
                        updateButtonVisibility();
                    }, 300); // 필요에 따라 timeout 값을 조정합니다.
                });

                swiperContainer.addEventListener('mousedown', function(e) {
                    isMouseDown = true;
                    startX = e.pageX - swiperContainer.offsetLeft;
                    scrollLeft = swiperContainer.scrollLeft;
                });

                swiperContainer.addEventListener('mouseleave', function() {
                    isMouseDown = false;
                });

                swiperContainer.addEventListener('mouseup', function() {
                    isMouseDown = false;
                });

                swiperContainer.addEventListener('mousemove', function(e) {
                    if (!isMouseDown) return;
                    e.preventDefault();
                    var x = e.pageX - swiperContainer.offsetLeft;
                    var walk = (x - startX) * 1.5;
                    swiperContainer.scrollLeft = scrollLeft - walk;
                    updateButtonVisibility();
                });
            });
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function(event) {
                var swiperContainer = document.querySelector('.swiper-container2');
                var slideWidth = swiperContainer.offsetWidth; // 각 슬라이드의 가로 폭
                var scrollDistance = 682.9; // 스크롤할 거리 (한 슬라이드의 가로 폭과 동일)

                var isNextButtonClicked = false; // 'allReviewsNext' 버튼이 클릭되었는지 여부를 추적하는 플래그
                var isMouseDown = false;
                var startX, scrollLeft;

                function updateButtonVisibility() {
                    // 오른쪽으로 스크롤할 내용이 남아있는지 확인
                    var remainingScrollWidth = swiperContainer.scrollWidth - swiperContainer.scrollLeft - swiperContainer.offsetWidth;
                    var shouldShowNextButton = remainingScrollWidth > 0;
                    var shouldShowPrevButton = swiperContainer.scrollLeft > 0;

                    // 'allReviewsNext' 버튼의 표시 여부 결정
                    var allReviewsNextButton = document.getElementById('allReviewsNext2');
                    if (shouldShowNextButton) {
                        allReviewsNextButton.style.display = 'block';
                    } else {
                        allReviewsNextButton.style.display = 'none';
                    }

                    // 'allReviewsPrev' 버튼의 표시 여부를 isNextButtonClicked 플래그와 연동하여 결정
                    var allReviewsPrevButton = document.getElementById('allReviewsPrev2');
                    if (shouldShowPrevButton && isNextButtonClicked) {
                        allReviewsPrevButton.style.display = 'block';
                    } else {
                        allReviewsPrevButton.style.display = 'none';
                    }
                }

                // 버튼 표시 여부 초기 체크
                updateButtonVisibility();

                document.getElementById('allReviewsNext2').addEventListener('click', function() {
                    // 현재 스크롤 위치와 이동할 위치 계산
                    var currentPosition = swiperContainer.scrollLeft;
                    var targetPosition = currentPosition + scrollDistance; // 오른쪽으로 스크롤하기 위해 "+" 사용

                    // 스크롤 애니메이션 적용
                    swiperContainer.scrollTo({
                        left: targetPosition,
                        behavior: 'smooth', // 부드럽게 애니메이션 효과 적용
                    });

                    // 'allReviewsNext' 버튼이 클릭되었다는 플래그를 true로 설정
                    isNextButtonClicked = true;

                    // 스크롤 애니메이션이 끝난 후 버튼 표시 상태 업데이트
                    setTimeout(updateButtonVisibility, 500); // 필요에 따라 timeout 값을 조정합니다.
                });

                document.getElementById('allReviewsPrev2').addEventListener('click', function() {
                    // 현재 스크롤 위치와 이동할 위치 계산
                    console.log("aa");
                    var currentPosition = swiperContainer.scrollLeft;
                    var targetPosition = currentPosition - scrollDistance; // 왼쪽으로 스크롤하기 위해 "-" 사용

                    // 스크롤 애니메이션 적용
                    swiperContainer.scrollTo({
                        left: targetPosition,
                        behavior: 'smooth', // 부드럽게 애니메이션 효과 적용
                    });

                    // 스크롤 애니메이션이 끝난 후 버튼 표시 상태 업데이트 딜레이 적용
                    setTimeout(function() {
                        // 'allReviewsPrev' 버튼이 클릭되었을 때 isNextButtonClicked 플래그를 false로 설정
                        isNextButtonClicked = false;

                        // 스크롤 애니메이션이 끝난 후 버튼 표시 상태 업데이트
                        updateButtonVisibility();
                    }, 300); // 필요에 따라 timeout 값을 조정합니다.
                });

                swiperContainer.addEventListener('mousedown', function(e) {
                    isMouseDown = true;
                    startX = e.pageX - swiperContainer.offsetLeft;
                    scrollLeft = swiperContainer.scrollLeft;
                });

                swiperContainer.addEventListener('mouseleave', function() {
                    isMouseDown = false;
                });

                swiperContainer.addEventListener('mouseup', function() {
                    isMouseDown = false;
                });

                swiperContainer.addEventListener('mousemove', function(e) {
                    if (!isMouseDown) return;
                    e.preventDefault();
                    var x = e.pageX - swiperContainer.offsetLeft;
                    var walk = (x - startX) * 1.5;
                    swiperContainer.scrollLeft = scrollLeft - walk;
                    updateButtonVisibility();
                });
            });
        </script>
    </body>
</html>
