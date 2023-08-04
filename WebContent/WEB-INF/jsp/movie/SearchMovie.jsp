<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Base.css?after" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie/SearchMovie.css?after" type="text/css">
    <title>영화 검색</title>
    <script type="text/javascript">
        function preventEnterSubmit(event) {
            if (event.keyCode === 13 && event.target.value.trim() === '') {
                event.preventDefault();
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <form method="post" action="./SearchResult">
            <div class="form-bar">
                <input type="text" name="search" class="search" placeholder="작품명, 배우, 배역" onkeydown="preventEnterSubmit(event)" />
            </div>
        </form>
        <ul>
            <c:forEach var="searchRank" items="${hitsRank}" varStatus="rank">
                <li>
                    <c:url value="/movieInfo" var="url">
                        <c:param name="movieCd" value="${searchRank.movieCd}" />
                    </c:url>
                    <a href="${url}" class="aRank">
                        <span class="rankNm">
                            <c:out value="${searchRank.movieNm}" />
                        </span>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div class="header">
        <nav class="navi">
            <a title="home" class="headerIcon" href="http://localhost:8081/MovieMate/mainController">
                <i class="fa-solid fa-house fa-xl"></i><br>
                <span>홈</span>
            </a>
            <a title="search" class="headerIcon" href="http://localhost:8081/MovieMate/SearchMovie">
                <i class="fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br>
                <span>검색</span>
            </a>
            <a title="community" class="headerIcon" href="http://localhost:8081/MovieMate/freeCommunityController">
                <i class="fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br>
                <span>커뮤니티</span>
            </a>
            <a title="myPage" class="headerIcon" href="http://localhost:8081/MovieMate/myPageController">
                <i class="fa-solid fa-user fa-xl"></i><br>
                <span>마이페이지</span>
            </a>
        </nav>
    </div>
</body>
</html>
