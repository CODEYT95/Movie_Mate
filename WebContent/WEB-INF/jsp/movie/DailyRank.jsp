<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>

<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일일 박스오피스</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Base.css?after" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie/DailyRank.css?after" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
</head>
<body>
	<div class="container">
		<ul>
			<li class="rankTitle">
				<c:out value="${yDayMD}" />
				<span>박스 오피스</span>
			</li>
			<c:forEach var="rankList" items="${rankList}">
				<li>
					<c:url value="/movieInfo" var="url">
						<c:param name="movieCd" value="${rankList.movieCd}" />
					</c:url>
					<a href="${url}" class="aRank">
						<c:if test="${not empty rankList.poster}">
							<span>
								<img class="poster" alt="" src="${rankList.poster}" />
							</span>
						</c:if>
						<span class="rankBox">
							<span class="rankValue">
								<span class="rankNo">
									<c:out value="${rankList.rank}" />
								</span>
								<span class="rankNm">
									<c:out value="${rankList.movieNm}" />
								</span>
							</span>
							<c:set var="rank" value="${rankList.updateRank}"></c:set>
							<c:choose>
								<c:when test="${fn:contains(rank, '▲')}">
									<span class="rankUpdate" id="rankUp">
										<c:out value="${rankList.updateRank}" />
									</span>
								</c:when>
								<c:when test="${fn:contains(rank, '▼')}">
									<span class="rankUpdate" id="rankDown">
										<c:out value="${rankList.updateRank}" />
									</span>
								</c:when>
								<c:when test="${fn:contains(rank, 'NEW')}">
									<span class="rankUpdate" id="rankNew">
										<c:out value="${rankList.updateRank}" />
									</span>
								</c:when>
								<c:otherwise>
									<span class="rankUpdate" id="rankPlateau">
										<c:out value="${rankList.updateRank}" />
									</span>
								</c:otherwise>
							</c:choose>
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
