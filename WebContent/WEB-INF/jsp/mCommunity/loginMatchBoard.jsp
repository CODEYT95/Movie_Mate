<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.mboard.MboardDTO" %>
<%@ page import="model.mboard.MboardDAO" %>
<%@ page import="model.notice.NoticeDTO" %>
<%@ page import="model.notice.NoticeDAO" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.helper.StringUtil" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/community/loginfreeBoard.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

</head>
<body>
  <div class="layout">
    <div class="box">
      <main class=contents>
        <section class="sub_header">
          <div class="sub_inner">
            <div class="logo-wrap">
             <img class="logo" src="${pageContext.request.contextPath}/img/board/boardLogo.PNG">
            </div>
            <h1>커뮤니티</h1>
            <div class="searchIcon">
            <div class="tooltip-wrap">
              <a><i class="fa-solid fa-magnifying-glass fa-lg" style="color:#efefef"></i></a>
              </div>
            </div>
          </div>
          <button id="myCommunityButton" class="header-right-button my" onclick="">내 활동</button>
        </section>
        <div class="content-area">
          <div class="grid-container">
          <section class="top-item top-area divider-line top-area--home">
                <div class="ranking-area">
                  <div class="subtitle-morebtn">
                    <p class="ranking-subtitle">📢공지사항</p>
                    <a href="noticeBoardController">
                      <span>더보기</span>
                    </a>
                  </div>
                  <% ArrayList<NoticeDTO> noticeList = (ArrayList<NoticeDTO>) request.getAttribute("noticeList");%>
                  <div class="swiper-wrap">
                    <div class="swiper-container">
                      <div class="swiper-wrapper">
                       <% for(NoticeDTO nDto : noticeList) { %>
                        <div class="swiper-slide">
                          <a class="notice-post-link" href="ReadNoticeDetailController?no=<%=nDto.getNotice_no()%>">
                            <article class="notice-post-wrap">
                              <h2 class="notice-post-title"><%=nDto.getN_title()%></h2>
                              <div class="admin-info-wrap">
                                <p class="admin-nickname"><%=nDto.getM_nick()%></p>
                                <span class="badge">관리자</span>
                              </div>
                            </article>
                          </a>
                        </div>
                         <% } %>
                        </div>
                      </div>
                    </div>
					</div>
					<div>
                    <button class="swiper-button-prev" id="allReviewsPrev" tabindex="-1" role="button" aria-label="Previous slide" aria-disabled="true">
                      <svg width="16" height="16" fill="none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" preserveAspectRatio="none">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.293 3.05a1 1 0 000 1.415L8.828 8l-3.535 3.536a1 1 0 101.414 1.414l4.23-4.23a1 1 0 00.013-1.427L6.707 3.051a1 1 0 00-1.414 0z" fill="#586A85"></path>
                      </svg>
                    </button>

                    <button class="swiper-button-next" id="allReviewsNext" tabindex="0" role="button" aria-label="Next slide" aria-disabled="false">
                      <svg width="16" height="16" fill="none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" preserveAspectRatio="none">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.293 3.05a1 1 0 000 1.415L8.828 8l-3.535 3.536a1 1 0 101.414 1.414l4.23-4.23a1 1 0 00.013-1.427L6.707 3.051a1 1 0 00-1.414 0z" fill="#586A85"></path>
                      </svg>
                    </button>
                  </div>

              </section>
            <section class="list-item list-area list-area--home">
              <div class="list-inner-wrap">
<% ArrayList<MboardDTO> mBoardList = (ArrayList<MboardDTO>) request.getAttribute("mBoardList");int count=1; %>
                <ul id="postList">
                <% for(MboardDTO mDto : mBoardList) { %>
                  <li class="list-gap">
                <input class="num-count" value="<%count++;%>" style="display:none;">
                    <article class="post-wrap">
                      <a class="post-look" href="ReadMateDetailController?no=<%=mDto.getBoardNo()%>">
                        <header class="post-info-wrap">
                         <div class="post-info-userNick">
			               <span class="userNick" style="color:white;"><%= mDto.getMem_nick()%></span>          
                         </div>
                         <div class="post-info-date">
                         <span class="postdate" data-timestamp="<%= mDto.getBoardRegdate().getTime()%>"><%= mDto.getBoardRegdate() %></span>
                         </div>
                        </header>
                        <h2 class="post-title"><%= mDto.getBoardTitle() %></h2>
                        <p id="post-body"><%= mDto.getBoardContents()%></p>
                        <%
                            // jsoup을 사용해 글 내용에서 img 태그 추출
                            String boardContents = mDto.getBoardContents();
                            Document doc = Jsoup.parse(boardContents);
                            Elements imgTags = doc.select("img");
                            // 추출된 img 태그가 있는 경우
                            if (imgTags != null && imgTags.size() > 0) {
                              // 첫 번째 img 태그만 image-put 클래스에 출력
                              Element img = imgTags.first();
                              String imgSrc = img.attr("src");
                              if (StringUtils.isNotBlank(imgSrc)) { %>
                        
						<div class="picture-wrap">
						<picture>
						<img src="<%= imgSrc %>">
						</picture>
						</div>
						   <% }
                            } %>
                      </a>
                        <footer class="post-footer">
                        <div class="count-wrap">
                        <div class="count-look">
                        <i class="fa-sharp fa-solid fa-eye" style="color: #9199a6;"></i>
                        <span><%= mDto.getViewCount() %></span>
                        </div>
                        <div class="count-reply">
                        <i class="fa-solid fa-comment" style="color: #7e838b;"></i>
                        <span><%=mDto.getReplyCount() %></span>
                        </div>
                        </div>
                        </footer>
                    </article>
                  </li>
                  <% } %>
                </ul>
              </div>
            </section>
            <aside class="side-item side-area side-area--home">
            <div class="user-info-wrap">
             <p class="user-name"><%= session.getAttribute("userNick") %></p>
             <div class="my-link-wrap">
              <a>
              <div id="myPostButton" class="my-link">
              <span class="my-link-label">내가 쓴 글</span>
              <span class="my-count"><%=request.getAttribute("writeCount")%></span>
              </div>
              </a>
              <a>
              	<div id="myCommentButton" class="my-link">
                  <span class="my-link-label">내가 쓴 댓글</span>
                  <span class="my-count"><%=request.getAttribute("replyCount") %></span>
                </div>
              </a>
             </div>
            </div>
            <div class="write-wrap">
            <button class="write-btn" id="freeboard">
                      <span class="write-btn-matching">자유게시판</span>
                      <i class="fa-solid fa-users fa-custom"></i>
                    </button>
            <button class="write-btn" id="writePost">
            <span class="write-btn-text">글 작성하기</span>
            <i class="fa-solid fa-pencil" style="color: #efefef;"></i>
            </button>
            </div>
            </aside>
          </div>
          <div  class="scroll-top-wrap" style="--floatHeight: 24px;">
          <div id="scrollTopButton" class="scroll-top-button"><i class="fa-solid fa-arrow-up fa-lg" style="color: #ffffff;"></i></div>
          <!-- <svg width="32" height="32" fill="none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" class="">
          <path fill-rule="evenodd" clip-rule="evenodd" d="M15.905 26.376c-.78 0-1.412-.632-1.412-1.412V9.647L9.41 14.731a1.412 1.412 0 01-1.997-1.997l7.321-7.32a1.412 1.412 0 011.997 0l7.32 7.32a1.412 1.412 0 11-1.996 1.997l-4.738-4.738v14.971c0 .78-.632 1.412-1.412 1.412z" fill="#EFEFEF"> -->
          </path>
          </svg>
          </button>
          </div>
          
        </div>
      </main>
      <header class="header">
        <nav class="navi">
          <a class="navi_a" title="home" href="http://localhost:8081/MovieMate/mainController"><i class="navi-i fa-solid fa-house fa-xl"></i><br><span>홈</span></a>
          <a class="navi_a" title="search" href="http://localhost:8081/MovieMate/SearchMovie"><i class="navi-i fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br><span>검색</span></a>
          <a class="navi_a" title="community" href="http://localhost:8081/MovieMate/freeCommunityController" style="color:#efefef;"><i class="navi-i fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br><span>커뮤니티</span></a>
          <a class="navi_a" title="myPage" href="http://localhost:8081/MovieMate/myPageController"><i class="navi-i fa-solid fa-user fa-xl"></i><br><span>마이페이지</span></a>
        </nav>
      </header>
    </div>
  </div>
  <script>
  document.getElementById("freeboard").addEventListener("click", function() {
    window.location.href = "http://localhost:8081/MovieMate/freeCommunityController";
  });
</script>
  <script>
  $(document).ready(function () {
	  var userNick = '<%= session.getAttribute("userNick")%>';
	  document.getElementById('writePost').addEventListener('click', function() {
		if(userNick == "null"){
			alert("로그인 후 이용해주세요.");
			
		}else{
			
			location.href = "http://localhost:8081/MovieMate/InsertMateController";			
		}  
		  
	  });
});
  </script>
  <script>
  $(document).ready(function () {
	    function updateRelativeTime() {
	        var currentTimestamp = Date.now(); // Current timestamp in milliseconds
	        $('.postdate').each(function () {
	            var timestampMillis = parseInt($(this).data('timestamp')); // Timestamp in milliseconds from the data attribute
	            var diff = currentTimestamp - timestampMillis; // Difference between current time and post time
	            var seconds = Math.floor(diff / 1000);
	            var minutes = Math.floor(seconds / 60);
	            var hours = Math.floor(minutes / 60);
	            var days = Math.floor(hours / 24);

	            var relativeTime;
	            if (days > 0) {
	                var date = new Date(timestampMillis);
	                var yyyy = date.getFullYear();
	                var mm = String(date.getMonth() + 1).padStart(2, '0');
	                var dd = String(date.getDate()).padStart(2, '0');
	                relativeTime = yyyy + '.' + mm + '.' + dd;
	            } else if (hours > 0) {
	                relativeTime = hours + '시간 전';
	            } else if (minutes > 0) {
	                relativeTime = minutes + '분 전';
	            } else {
	                relativeTime = '방금 전';
	            }

	            $(this).text(relativeTime);
	        });
	    }

	    updateRelativeTime(); // Update relative time on page load

	    // Update relative time every minute (you can adjust the interval as needed)
	    setInterval(updateRelativeTime, 60000);

	    // Your other JavaScript code here
	});

</script>
 
  <script>
  
  // Initial page value
  var currentPage = 2;
  var loadingData = false; // Flag to prevent multiple AJAX requests

  $(document).ready(function () {
    // 페이지 로딩 시 loadMoreData 함수 호출하여 초기 데이터 가져오기
    loadMoreData();
	
    // 초기에 스크롤 상단 버튼 숨기기
    $("#scrollTopButton").hide();
    // 사용자가 스크롤할 때마다 이벤트 처리
    $(window).scroll(function () {
      // 스크롤 위치가 페이지 끝 부분에 다다르면
      if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
        // Avoid making multiple AJAX requests simultaneously
        if (!loadingData) {
          loadingData = true;
          // loadMoreData 함수 호출하여 추가 데이터 가져오기
          loadMoreData();
        }
      }

      // 스크롤 위치가 300px 이상이면 스크롤 상단 버튼 표시, 그 외에는 숨김
      if ($(window).scrollTop() >= 300) {
        $("#scrollTopButton").fadeIn();
      } else {
        $("#scrollTopButton").fadeOut();
      }
    });

    // 스크롤에서 맨 위로 버튼을 클릭하면 맨 위로 스크롤합니다
    $("#scrollTopButton").on("click", function () {
      scrollToTop();
    });
  });

  // 추가 데이터 가져오기 함수
  function loadMoreData() {
    console.log("아작스 들어옴");

    // Ajax를 이용하여 서버에 특정 페이지 데이터 요청
    $.ajax({
      url: 'mathCommunityController',  // 요청할 URL
      method: 'GET',  // 요청 방식
      data: { currentPage: currentPage },  // 현재 페이지 정보 전송
      dataType: 'html',  // 반환 데이터 형식 지정
      success: function (data) {
        // 반환된 데이터가 비어있지 않으면
        if (data.trim() !== '') {
          // 서버에서 반환된 li 요소들을 $('.list-area--home ul') 요소에 추가
          $('.list-area--home ul').append($(data).find('li'));

          // 현재 페이지 값을 증가시킴
          currentPage++;

          // Reset the loading flag to allow new AJAX requests
          loadingData = false;
        }
      },
      error: function (xhr, status, error) {
        // 에러 처리
        loadingData = false;
      }
    });
  }

  // Function to scroll to the top of the page
  function scrollToTop() {
    $("html, body").animate({ scrollTop: 0 }, 300);
  }
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
</body>
</html>