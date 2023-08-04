<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최신 리뷰 모음</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/movie/Review.css?after"
	type="text/css">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

</head>
<body>
	<div class="layout">
		<div class="box">
			<main class="contents">
				<section class="sub_header">
					<div class="sub_inner">
						<button type="button" id="backButton"
							onclick="window.history.back();" class="backButton">
							<i class="fa-solid fa-chevron-left fa-xl"
								style="color: RGB(255, 255, 255)"></i>
						</button>
						<h1>최신 한줄평 모아보기</h1>
					</div>
				</section>
				<c:forEach var="reviewList" items="${reviewList }">
					<div class="reviews">
						<article class="review-box">
							<div class="review-header">
								<div class="header-info">
									<div class="info-title">
										<c:url value="/movieInfo" var="url">
											<c:param name="movieCd" value="${reviewList.movieCd}" />
										</c:url>
										<a href="${url }" class="title-link">
											<h5 class="movie-title">
												<c:out value="${reviewList.movieNm }" />
											</h5>
										</a> <span class="writeDate"><c:out
												value="${reviewList.writeDt }" /></span>
									</div>
									<div class="user-info">
										<span class="user-nick"><c:out
												value="${reviewList.memberNc }" /></span> <span
											class="user-rating-of">님의 한줄평</span>
									</div>
								</div>
							</div>
							<div class="review-contents">
								<h5 class="contents-title">
									<c:out value="${reviewList.review }" />
								</h5>
							</div>
						</article>
					</div>
				</c:forEach>
			</main>
			<header class="header">
				<nav class="navi">
					<a class="navi_a" title="home" href="${pageContext.request.contextPath}/mainController"> <i
						class="navi-i fa-solid fa-house fa-xl"></i><br> <span>홈</span>
					</a> <a class="navi_a" title="search" href="./SearchMovie"> <i
						class="navi-i fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br>
						<span>발견</span>
					</a> <a class="navi_a" title="community" href="/community/feed"
						style="color: #efefef;"> <i
						class="navi-i fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br>
						<span>커뮤니티</span>
					</a> <a class="navi_a" title="myPage" href="myPageController"> <i
						class="navi-i fa-solid fa-user fa-xl"></i><br> <span>마이페이지</span>
					</a>
				</nav>
			</header>
		</div>
	</div>
</body>
</html>