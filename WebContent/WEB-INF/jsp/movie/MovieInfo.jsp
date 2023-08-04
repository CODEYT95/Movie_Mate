<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="util.JDBCUtil"%>
<%@ page import="model.movie.MovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Base.css?after" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie/MovieInfo.css?after" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <%
        List<MovieDTO> mList = (List<MovieDTO>) request.getAttribute("movieList");
        MovieDTO mDTO = new MovieDTO();
        mDTO = mList.get(0);
        String movieCd = mDTO.getMovieCd();
        String userId = (String) session.getAttribute("userId");
        JDBCUtil util = new JDBCUtil();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*), review FROM review WHERE movieCd=? AND memberId=?";
        int reviewCnt = 0;
        String reviewT = null;
        String movieNm = mList.get(0).getMovieNm();
        try {
            conn = util.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, movieCd);
            pstmt.setString(2, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                reviewCnt = rs.getInt("COUNT(*)");
                reviewT = rs.getString("review");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            util.close(rs, pstmt, conn);
        }
    %>
<script>
    $(document).ready(function() {
        var reviewCnt = <%=reviewCnt%>;

        if (reviewCnt > 0) {
            updateCharacterCount('update-review-txt');
        } else {
            updateCharacterCount('insert-review-txt');
        }

        var curDown = false, curXPos = 0;
        $("#scroll").mousedown(function(m) {
            curXPos = m.pageX;
            curDown = true;
            $(this).addClass("grabbing");
        });

        $(document).mousemove(function(m) {
            if (curDown) {
                $("#scroll").scrollLeft($("#scroll").scrollLeft() + (curXPos - m.pageX));
                curXPos = m.pageX;
            }
        });

        $(document).mouseup(function() {
            curDown = false;
            $("#scroll").removeClass("grabbing");
        });

        var userId = '<%=userId%>';
        var userNc = '<%=(String) session.getAttribute("userNc")%>';

        function toggleReviewSection() {
            if (userId == "" || userId == null || userId == "null") {
                $(".review-chk-btn").hide();
                $(".review-box").hide();
                $(".insert-review-box").hide();
                $(".update-review-box").hide();
                $("#insert-review-btn").hide();
                $("#update-review-btn").hide();
                $("#delete-review-btn").hide();
            } else {
                if (reviewCnt > 0) {
                    $(".insert-review-box").hide();
                    $(".update-review-box").show();
                    $("#insert-review-btn").hide();
                    $("#update-review-btn").show();
                    $("#delete-review-btn").show();
                } else {
                    $(".insert-review-box").show();
                    $(".update-review-box").hide();
                    $("#insert-review-btn").show();
                    $("#update-review-btn").hide();
                    $("#delete-review-btn").hide();
                }
            }
        }

        toggleReviewSection();

        $("#insert-review-btn").click(function() {
            var reviewText = $("#insert-review-txt").val();
            var movieList = [
                <c:forEach var="movie" items="${movieList}" varStatus="status">
                    { movieCd: '<c:out value="${movie.movieCd}" />' }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];

            if (movieList.length > 0) {
                var movieCd = movieList[0].movieCd;
            }

            if (reviewText !== "") {
                $.ajax({
                    type: "POST",
                    url: "InsertReview",
                    data: {
                        userId: userId,
                        userNc: userNc,
                        reviewText: reviewText,
                        movieCd: movieCd
                    },
                    success: function(data) {
                        console.log("한줄평이 등록되었습니다.");
                        document.location.reload();
                    },
                    error: function() {
                        console.log("한줄평이 등록되지 않았습니다.");
                    }
                });
            }
        });

        $("#update-review-btn").click(function() {
            var reviewText = $("#update-review-txt").val()
            var movieList = [
                <c:forEach var="movie" items="${movieList}" varStatus="status">
                    {
                        movieCd: '<c:out value="${movie.movieCd}" />',
                    }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];

            if (movieList.length > 0) {
                var movieCd = movieList[0].movieCd;
            }

            if (reviewText !== "") {
                $.ajax({
                    type: "POST",
                    url: "UpdateReview",
                    data: {
                        userId: userId,
                        userNc: userNc,
                        reviewText: reviewText,
                        movieCd: movieCd
                    },
                    success: function(data) {
                        console.log("한줄평이 수정되었습니다.");
                        document.location.reload();
                    },
                    error: function() {
                        console.log("한줄평이 수정되지 않았습니다.");
                    }
                });
            }
        });

        $("#delete-review-btn").click(function() {
            var reviewText = $("#update-review-txt").val()
            var movieList = [
                <c:forEach var="movie" items="${movieList}" varStatus="status">
                    {
                        movieCd: '<c:out value="${movie.movieCd}" />',
                    }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];

            if (movieList.length > 0) {
                var movieCd = movieList[0].movieCd;
            }

            $.ajax({
                type: "POST",
                url: "DeleteReview",
                data: {
                    movieCd: movieCd,
                    userId: userId
                },
                success: function(data) {
                    console.log("한줄평이 삭제되었습니다.");
                    document.location.reload();
                },
                error: function() {
                    console.log("한줄평이 삭제되지 않았습니다.");
                }
            });
        });

        function updateCharacterCount(textareaId) {
            var textarea = document.getElementById(textareaId);
            var characterCount = textarea.value.length;
            var characterLimit = 100;

            if (characterCount > characterLimit) {
                textarea.value = textarea.value.slice(0, characterLimit);
                characterCount = characterLimit;
            }

            document.getElementById('character-count').innerText = characterCount + '/' + characterLimit;
        }

        $("#insert-review-txt").on("input", function() {
            updateCharacterCount('insert-review-txt');
        });

        $("#update-review-txt").on("input", function() {
            updateCharacterCount('update-review-txt');
        });

        $("#insert-review-txt").keydown(function(event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                $("#insert-review-btn").click();
            }
        });

        $("#update-review-txt").keydown(function(event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                $("#update-review-btn").click();
            }
        });
    });
</script>

    <title><%=movieNm %></title>
</head>

<body>
  <div class="container">
    <c:if test="<%=movieCd == null%>">
    </c:if>

    <c:if test="<%=movieCd != null%>">
      <c:forEach var="movieInfo" items="${movieList}" varStatus="status">
        <div>
          <h2>
            <c:out value="${movieInfo.movieNm}" />
          </h2>
        </div>
        <br />
        <hr />

        <c:if test="${not empty movieInfo.nationNm}">
          #<c:out value="${movieInfo.nationNm}" />
          &nbsp;
        </c:if>

        <c:if test="${!empty movieInfo.watchGradeNm}">
          #<c:out value="${movieInfo.watchGradeNm}" />
          &nbsp;
        </c:if>

        <c:if test="${not empty movieInfo.openDt}">
          #<c:out value="${movieInfo.openDt}" />
          &nbsp;
        </c:if>

        <c:if test="${!empty movieInfo.showTm}">
          #<c:out value="${movieInfo.showTm}분" />
          &nbsp;
        </c:if>

        <c:if test="${not empty movieInfo.genre}">
          <c:forEach var="genre" items="${movieInfo.genre}">
            #<c:out value="${genre}" />
            &nbsp;
          </c:forEach>
        </c:if>

        <hr />
        <div>
          <c:if test="${not empty movieInfo.actor}">
            <h4>출연진</h4>
            <div class="swiper-wrapper" id="scroll">
              <c:forEach var="actor" items="${movieInfo.actor}">
                <div class="swiper-actor">
                  <div>
                    <p>
                      <c:out value="${actor.key}" />
                    </p>
                    <p>
                      <c:out value="${actor.value}" />
                    </p>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:if>
        </div>
      </c:forEach>

      <br />
      <br />

      <div>
        <h3>한줄평</h3>
      </div>
      <div class="review-chk-btn">
        <span id="character-count">0/100</span>
        <span class="review-btn">
          <button id="insert-review-btn">등록</button>
        </span>
        <span class="review-btn">
          <button id="update-review-btn">수정</button>
        </span>
        <span class="delete-btn">
          <button id="delete-review-btn">삭제</button>
        </span>
      </div>

      <div class="review-box">
        <div class="insert-review-box">
          <span class="review">
            <textarea id="insert-review-txt" name="review" placeholder="한줄평을 남겨주세요." oninput="updateCharacterCount('insert-review-txt')"></textarea>
          </span>
        </div>
        <div class="update-review-box">
          <span class="review">
            <textarea id="update-review-txt" name="review" oninput="updateCharacterCount('update-review-txt')"><%=reviewT%></textarea>
          </span>
        </div>
      </div>

      <div>
        <c:forEach var="review" items="${reviewList}">
          <div class="review-box-list">
            <div class="review-text">
              <div class="userNick">
                <c:out value="${review.getMemberNc()}" />
              </div>
              <div class="review">
                <pre><c:out value="${review.getReview()}" /></pre>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:if>

    <div class="header">
      <nav class="navi">
        <a title="home" class="headerIcon" href="http://localhost:8081/MovieMate/mainController">
          <i class="fa-solid fa-house fa-xl"></i>
          <br>
          <span>홈</span>
        </a>
        <a title="search" class="headerIcon" href="http://localhost:8081/MovieMate/SearchMovie">
          <i class="fa-sharp fa-solid fa-magnifying-glass fa-xl"></i>
          <br>
          <span>검색</span>
        </a>
        <a title="community" class="headerIcon" href="http://localhost:8081/MovieMate/freeCommunityController">
          <i class="fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i>
          <br>
          <span>커뮤니티</span>
        </a>
        <a title="myPage" class="headerIcon" href="http://localhost:8081/MovieMate/myPageController">
          <i class="fa-solid fa-user fa-xl"></i>
          <br>
          <span>마이페이지</span>
        </a>
      </nav>
    </div>
  </div>
</body>
</html>