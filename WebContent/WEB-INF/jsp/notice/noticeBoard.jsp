<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.helper.StringUtil"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="model.notice.NoticeDAO"%>
<%@ page import="model.notice.NoticeDTO"%>
<%@ page import="model.nreply.NreplyDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/notice/noticeBoard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            //닉네임 불러오기
            var userNick = '<%=session.getAttribute("userNick")%>';

            //닉네임이 일치할 경우 html코드 삽입
            if (userNick == '관리자') {
                var writeButtonHtml = `
                    <aside id="writeAside" class="side-item side-area side-area--home">
                        <div class="write-wrap">
                            <button class="write-btn"onclick="location.href='${pageContext.request.contextPath}/InsertNoticeController'">
                                <span class="write-btn-text">글 작성하기</span>
                                <i class="fa-solid fa-pencil" style="color: #efefef;"></i>
                            </button>
                        </div>
                    </aside> 
                `;

                $('.grid-container').append(writeButtonHtml);
            }
        });
    </script>
</head>
<body>
<div class="layout">
    <div class="box">
        <main class="contents">
            <section class="sub_header">
                <div class="sub_inner">
                    <h1>공지사항</h1>
                    <button id="communityHomeBtn" class="home-btn">
                        <a href="http://localhost:8081/MovieMate/freeCommunityController"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18">
                            <path d="M19 21.0001H5C4.44772 21.0001 4 20.5524 4 20.0001V11.0001L1 11.0001L11.3273 1.61162C11.7087 1.26488 12.2913 1.26488 12.6727 1.61162L23 11.0001L20 11.0001V20.0001C20 20.5524 19.5523 21.0001 19 21.0001ZM13 19.0001H18V9.15757L12 3.70302L6 9.15757V19.0001H11V13.0001H13V19.0001Z"></path>
                        </svg>
                        <span data-v-9938e184="">커뮤니티</span>
                    </button></a>
                </div>
            </section>
            <div class="content-area">
                <div class="grid-container">
                    <section class="list-item list-area list-area--home">
                        <div class="list-inner-wrap">
                            <% ArrayList<NoticeDTO> noticeList = (ArrayList<NoticeDTO>) request.getAttribute("noticeList"); %>
                            <ul>
                                <% for (NoticeDTO nDto : noticeList) { %>
                                <li class="list-gap">
                                    <article class="post-wrap">
                                    	<form action="${pageContext.request.contextPath}/ReadNoticeDetailController" method="get">
                                        <input type="number"  name="no" style="display:none;" value="<%=nDto.getNotice_no() %>">
	                                        <a class="post-look" href="${pageContext.request.contextPath}/ReadNoticeDetailController?no=<%=nDto.getNotice_no() %>">
                                            <header class="post-info-wrap">
                                                <div class="post-info-userNick">
                                                    <span class="userNick" style="color: white;"><%=nDto.getM_nick()%></span>
                                                    <span class="badge">관리자</span>
                                                </div>
                                                <div class="post-info-date">
                                                    <span class="postdate"  data-notice-regdate="<%=nDto.getN_regdate()%>"></span>
                                                </div>
                                            </header>
                                            <h2 class="post-title"><%=nDto.getN_title()%></h2>
                                            <p id="post-body"><%=nDto.getN_contents()%></p>
                                            <% 
								              // jsoup을 사용해 글 내용에서 img 태그 추출
								              String noticeContents = nDto.getN_contents();
								              Document doc = Jsoup.parse(noticeContents);
								              Elements imgTags = doc.select("img");
								              // 추출된 img 태그가 있는 경우
								              if (imgTags != null && imgTags.size() > 0) {
								                // 첫 번째 img 태그만 image-put 클래스에 출력
								                Element img = imgTags.first();
								                String imgSrc = (imgTags != null && imgTags.size() > 0) ? imgTags.first().attr("src") : null;
								                if (imgSrc != null && !imgSrc.equals("")) {
								                  String[] imgSplit = imgSrc.split("\\.");
								                  String imgType = imgSplit[imgSplit.length - 1];
								                  if (imgType.equalsIgnoreCase("jpg") || imgType.equalsIgnoreCase("jpeg") || imgType.equalsIgnoreCase("png") || imgType.equalsIgnoreCase("gif")) {
								            %>
								                      <div class="picture-wrap">
								                        <picture>
								                          <img class="notice-img" src="<%=imgSrc%>">
								                        </picture>
								                      </div>
								            <% 
								                  } else {
								                      // 처리 불가능한 이미지 타입인 경우 에러처리 또는 처리하지 않도록 구현
								                  }
								                }
								              }
								            %>
                                        <footer class="post-footer">
                                            <div class="count-wrap">
                                                <div class="count-reply">
                                                    <i class="fa-solid fa-comment" style="color: #7e838b;"></i>
                                                    <span><%= nDto.getCommentCount() %></span>
                                                </div>
                                            </div>
                                        </footer>
                                    </article>
                                </li>
                                <% } %>
                            </ul>
                        </div>
                    </section>
                </div>
            </div>
        </main>
        <header class="header">
            <nav class="navi">
                <a class="navi_a" title="home" href="${pageContext.request.contextPath}/mainController">
                    <i class="navi-i fa-solid fa-house fa-xl"></i><br>
                    <span>홈</span>
                </a>
                <a class="navi_a" title="search" href="http://localhost:8081/MovieMate/SearchMovie">
                    <i class="navi-i fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br>
                    <span>발견</span>
                </a>
                <a class="navi_a" title="community" href="http://localhost:8081/MovieMate/freeCommunityController" style="color: #efefef;">
                    <i class="navi-i fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br>
                    <span>커뮤니티</span>
                </a>
                <a class="navi_a" title="myPage" href="http://localhost:8081/MovieMate/myPageController">
                    <i class="navi-i fa-solid fa-user fa-xl"></i><br>
                    <span>마이페이지</span>
                </a>
            </nav>
        </header>
    </div>
</div>
<!--  
<script>
    // 초기 페이지 값
    var currentPage = 2;

    $(document).ready(function () {
        // 페이지 로딩 시 loadMoreData 함수 호출하여 초기 데이터 가져오기
        loadMoreData();

        // 사용자가 스크롤할 때마다 이벤트 처리
        $(window).scroll(function () {
            // 스크롤 위치가 페이지 끝 부분에 다다르면
            if ($(window).scrollTop() + $(window).height() >= $(document).height()) {
                // loadMoreData 함수 호출하여 추가 데이터 가져오기
                loadMoreData();
            }
        });
    });

    // 추가 데이터 가져오기 함수
    function loadMoreData() {
        console.log("아작스 들어옴");
        
        // Ajax를 이용하여 서버에 특정 페이지 데이터 요청
        $.ajax({
            url: 'noticeBoardController',  // 요청할 URL
            method: 'GET',  // 요청 방식
            data: { currentPage: currentPage },  // 현재 페이지 정보 전송
            dataType: 'html',  // 반환 데이터 형식 지정
            success: function (data) {
                // 반환된 데이터가 비어있지 않으면
                if (data.trim() !== '') {
                    // 서버에서 반환된 li 요소들을 $('.grid-container ul') 요소에 추가
                    $('.grid-container ul').append($(data).find('li'));

                    // 현재 페이지 값을 증가시킴
                    currentPage++;
                }
            },
            error: function (xhr, status, error) {
                // 에러 처리
            }
        });
    }
</script>
-->
<script>

function timeSince(date) {
    var seconds = Math.floor((new Date() - new Date(date)) / 1000);

    if (seconds < 60) {
        return "방금 전";
    }

    var minutes = Math.floor(seconds / 60);
    if (minutes < 60) {
        return minutes + "분 전";
    }

    var hours = Math.floor(minutes / 60);
    if (hours < 24) {
        return hours + "시간 전";
    }

    var formattedDate = new Date(date).toISOString().slice(0, 10);
    return formattedDate;
}

document.addEventListener("DOMContentLoaded", function () {
    var postDateElements = document.querySelectorAll(".postdate");
    postDateElements.forEach(function (element) {
        var postDate = new Date(element.getAttribute("data-notice-regdate"));
        element.textContent = timeSince(postDate);
    });
});

</script>

</body>
</html>
