<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.fboard.FboardDAO, model.fboard.FboardDTO"%>
<%@ page import="model.movie.ReviewDTO"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/myPage/myPage.css?after">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Caprasimo&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script>
      $(document).ready(function() {
          function getColor(percent) {
              var color;
              if (percent >= 0 && percent <= 20) {
                color = "#868B94";
              } else if (percent > 20 && percent <= 32) {
                color = "#868B94";
              } else if (percent > 32 && percent <= 36.5) {
                color = "#0277B2";
              } else if (percent > 36.5 && percent <= 40) {
                color = "#019CEB";
              } else if (percent > 40 && percent <= 50) {
                color = "#2FC795";
              } else if (percent > 65.5 && percent <= 88) {
                color = "#F7BE68";
              } else {
                color = "#E83E0E";
              }
              return color;
          }

          var percent = <%=Float.parseFloat(session.getAttribute("userTemp").toString())%>;
          var color = getColor(percent);
          var colorBox = document.querySelector('#myTemp');

          if (colorBox) {
            colorBox.style.color = color;
            colorBox.style.setProperty('color', color);
          }

          function redirectToDetailPage(no) {
            location.href = "/ReadNoticeDetailController?no=" + no;
          }
      function modifyContents(boardNo) {
        console.log("선택한 boardNo:", boardNo);
      }
      
      function settingpage() {
        location.href = "http://localhost:8081/MovieMate/settingController";
      }
      
      function goToMovieInfo(movieCd) {
          window.location.href = 'http://localhost:8081/MovieMate/movieInfo?movieCd=' + movieCd;
      }

      function goTofboardDetail(no) {
          window.location.href = 'http://localhost:8081/MovieMate/ReadFreeDetailController?no=' + no;
      }
      
      // detailButtons 이벤트 처리
      var detailButtons = document.querySelectorAll('#reviewBtn');
      detailButtons.forEach(function(button) {
          button.addEventListener('click', function() {
              var movieCd = button.getAttribute('data-movie-cd');
              goToMovieInfo(movieCd);
          });
      });
      
      var detailButtons = document.querySelectorAll('#boardBtn');
      detailButtons.forEach(function(button) {
          button.addEventListener('click', function() {
              var no= button.getAttribute('data-fboard-no');
              goTofboardDetail(no);
          });
      });
      
      });
      
    </script>
  </head>

  <body>
    <div class="layout">
      <div class="content">
        <div class="first">
          <div class="ns-wrap">
            <div class="image-box" style="background: #3b4869;">
              <img class="profile" src="${pageContext.request.contextPath}/img/myPage/user.png">
            </div>
            <span class="myNICK" style="color: white; font-size: 20px;">
              <%=session.getAttribute("userNick")%>
            </span>

          </div>
          <div class="setBtn">
            <button type="button" id="setpage" onclick="javascript: location.href='http://localhost:8081/MovieMate/settingController';">
              <i class="fa-solid fa-gear fa-2xl" style="color: RGB(255, 255, 255)"></i>
            </button>
          </div>
        </div>

        <div class="second">
          <a class="dibsList"><i class="fa-regular fa-heart"></i><br>찜목록</a>
          <a class="myTicket"><i class="fa-solid fa-ticket"></i><br>예매내역</a>
          <div class="temperatura">
            <input type="text" id="myTemp" class="myTemp" value="<%=session.getAttribute("userTemp")%>°C" disabled>
          </div>
        </div>
        
        <div class="write-wrap">
          <label class="writeLabel">최근 작성한 게시글</label>
          <div class="third">
            <div class="myWrite">
              <div class="myWriteList">
                <% ArrayList<FboardDTO> fbList = (ArrayList<FboardDTO>) request.getAttribute("fbList"); %>
                <ul>
                  <% for (FboardDTO fbdto : fbList) { %>
                    <div class="writeLink">
                      <li><%=fbdto.getFb_title()%></li>
                      <button class="detailBtn" id="boardBtn" data-fboard-no="<%=fbdto.getFboard_no()%>">
                        <i class="fa-solid fa-chevron-up fa-rotate-90 fa-xl"></i>
                      </button>
                    </div>
                  <% } %>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <label class="review-label" >최근 작성한 한줄평</label>
        <div class="four">
          <div class="myComment">
            <div class="myCommentList">
              <% ArrayList<ReviewDTO> rvList = (ArrayList<ReviewDTO>) request.getAttribute("reviewList"); %>
              <ul>
                <% for (ReviewDTO rvdto : rvList) { %>
                  <div class="commentLink">
                    <li><%=rvdto.getReview()%></li>
                    <button class="detailBtn" id="reviewBtn" data-movie-cd="<%=rvdto.getMovieCd()%>">
                      <i class="fa-solid fa-chevron-up fa-rotate-90 fa-xl"></i>
                    </button>
                  </div>
                <% } %>
              </ul>
            </div>
          </div>
        </div>

        <header class="header">
          <nav class="navi">
            <a class="navi_a" title="home" href="http://localhost:8081/MovieMate/mainController">
              <i class="navi-i fa-solid fa-house fa-xl"></i><br>
              <span>홈</span>
            </a>
            <a class="navi_a" title="search" href="http://localhost:8081/MovieMate/SearchMovie">
              <i class="navi-i fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br>
              <span>검색</span>
            </a>
            <a class="navi_a" title="community" href="http://localhost:8081/MovieMate/freeCommunityController">
              <i class="navi-i fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br>
              <span>커뮤니티</span>
            </a>
            <a class="navi_a" title="myPage" href="http://localhost:8081/MovieMate/myPageController" style="color:#efefef;">
              <i class="navi-i fa-solid fa-user fa-xl"></i><br>
              <span>마이페이지</span>
            </a>
          </nav>
        </header>
      </div>
    </div>
  </body>
</html>
