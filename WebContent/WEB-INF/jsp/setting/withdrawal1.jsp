<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/setting/withdrawal1.css?after">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
</head>
<body>
<form action="withdrawalController" method="get">
	<div class="layout">
		<div class=content>
			<div class="sub_header">
				<div class="sub_inner">
					<button type="button" id="backButton"
						onclick="window.history.back();" class="backButton">
						<i class="fa-solid fa-chevron-left fa-xl"
							style="color: RGB(255, 255, 255)"></i>
					</button>
					<h1>회원 탈퇴</h1>
				</div>
			</div>
			<div class="wrapper">
				<div class="content-wrap">
					<div class="title-wrap">
						<h2>
							회원님 😭<br> 정말 탈퇴 하시려구요?
						</h2>
					</div>
					<div class="subTitle-wrap">
						<span class="subTitle">탈퇴 시 회원님의 소중한 데이터들은 모두 사라집니다.</span>
					</div>
					<div class="myData">
						<h3>커뮤니티 활동 내역</h3>
						<ul class="userDataList">
							<li>
								<div class="userData">
									<p>작성한 글</p>
									<p>0</p>
								</div>
							</li>
							<li>
								<div class="userData">
									<p>작성한 댓글</p>
									<p>0</p>
								</div>
							</li>
							<li>
								<div class="userData">
									<p>작성한 한줄 평</p>
									<p>0</p>
								</div>
							</li>
						</ul>
					</div>
				</div>

			</div>
			<div class="footer">
				<button type="submit" class="next-btn" name="next" value="1" >확인</button>
			</div>
			<header class="header">
				<nav class="navi">
					<a class="navi_a" title="home" href="http://localhost:8081/MovieMate/mainController"><i
						class="navi-i fa-solid fa-house fa-xl"></i><br>
					<span>홈</span></a> <a class="navi_a" title="search" href="http://localhost:8081/MovieMate/SearchMovie"><i
						class="navi-i fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br>
					<span>검색</span></a> <a class="navi_a" title="community"
						href="http://localhost:8081/MovieMate/freeCommunityController"><i
						class="navi-i fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br>
					<span>커뮤니티</span></a> <a class="navi_a" title="myPage"
						href="http://localhost:8081/MovieMate/myPageController"><i
						class="navi-i fa-solid fa-user fa-xl"></i><br>
					<span>마이페이지</span></a>
				</nav>
			</header>
		</div>
	</div>
</form>
</body>

</html>