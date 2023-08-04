<%@page import="java.util.List"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Base.css?after" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie/SearchResult.css?after" type="text/css">
    <title>영화 검색</title>
    <script type="text/javascript">
        var count = 0;
        window.onscroll = function(e) {
            if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
                count++;
                $('article').append(addContent);
            }
        };
    </script>
</head>
<body>
    <div class="block">
        <ul>
            <c:forEach var="list" items="${searchList}">
                <c:url value="/movieInfo" var="url">
                    <c:param name="movieCd" value="${list.movieCd}">
                    </c:param>
                </c:url>
                <li>
                    <a href="${url}">
                        <span class="movieNm">
                            <c:out value="${list.movieNm}" />
                        </span>
                        <span class="openDt">
                            <c:out value="${list.openDt}" />
                        </span>
                    </a>
                </li>
                <br />
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
