<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설정</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/setting/settingPage.css?after">
<link  rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Caprasimo&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>

 </head>
<body>
<div class="main">
<div class="sub_header">
  <div class="sub_inner">
  <button type="button" id="backButton" onclick="window.history.back();" class="backButton"><i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i></button>
  <h1>설정</h1>
  </div>
    </div>
     
<div class="settingList">
  <div class="actLog">
    <h5>활동로그</h5>
    </div>
    <ul class="list">
      <li><a><span>내가 좋아요한 리뷰</span></a></li>
      <li><a><span>리뷰 댓글 관리</span></a></li>
      <li><a><span>커뮤니티 글 / 댓글 관리</span></a></li>
      <li><a><span>나의 이벤트</span></a></li>
      <li><a><span>가져오기 / 내보내기</span></a></li>
      <li><a><span>푸쉬알림 설정</span></a></li>
      <li><a><span>활동 내역 초기화</span></a></li>
    </ul>
  <div class="accountSet">
    <h5>계정설정</h5>
    </div>
    <ul class="list">
      <li><a href="updateController"><span>개인정보 수정</span></a></li>
      <li><a><span>인증회원 신청</span></a></li>
    </ul>
  <div class="inquiry">
    <h5>문의하기</h5>
    </div>
    <ul class="list">
      <li><a><span>사용가이드</span></a></li>
      <li><a><span>고객센터</span></a></li>
    </ul>
  <div class="TermsPolicies">
    <h5>약관 및 정책</h5>
    </div>
    <ul class="list">
      <li><a href="privacyController"><span>개인정보 처리방침</span></a></li>
      <li><a href="termsController"><span>이용약관</span></a></li>
    </ul>
 <div class="divider">
 </div>
    <ul class="list">
      <li><a><span>로그아웃</span></a></li>
      <li><a href="withdrawalController"><span>회원탈퇴</span></a></li>
    </ul>
    
  </div>

<header class="header">
    <nav class="navi">
    <a title="home" href="http://localhost:8081/MovieMate/mainController"><i class="fa-solid fa-house fa-xl"></i><br><span>홈</span></a>
    <a title="search" href="http://localhost:8081/MovieMate/SearchMovie"><i class="fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br><span>검색</span></a>
    <a title="community" href="http://localhost:8081/MovieMate/freeCommunityController"><i class="fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br><span>커뮤니티</span></a>
    <a title="myPage" href="http://localhost:8081/MovieMate/myPageController"><i class="fa-solid fa-user fa-xl"></i><br><span>마이페이지</span></a>
    </nav>
  </header>
  </div>
</body>
</html>