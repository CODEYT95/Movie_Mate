<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Caprasimo&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/admin/admin_main.css">

</head>
<body>
</head>
<body>
<div class="main">
    <div class="sub_header">
        <div class="sub_inner">
            <div>
                <button type="button" id="backButton" onclick="window.history.back();" class="backButton">
                    <i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i>
                </button>
            </div>
            
            <div>
                <h1>
                    <img class="icon" src="${pageContext.request.contextPath}/image/mainIcon.png">관리자페이지
                </h1>
            </div>
            
            <div>
                <span id="adminNick"><%= session.getAttribute("userNick") %> 로그인중!</span>
                <input  type="button" id="logBtn" class="logBtn" value="로그인">
            </div>
        </div>
    </div>
    <div class="adminList">
        <div class="adList">
            <h5>관리 목록</h5>
        </div>
        <ul class="list">
            <li><a href="${pageContext.request.contextPath}/SelectMemberController"><span>회원목록</span></a></li>
            <li><a href="${pageContext.request.contextPath}/noticeBoardController"><span>공지사항목록</span></a></li>
            <li><a href="${pageContext.request.contextPath}/ListMateController"><span>매칭보드목록</span></a></li>
            <li><a href="${pageContext.request.contextPath}/ListFreeController"><span>자유게시판목록</span></a></li>
            <li><a href="클릭시 링크"><span>공지사항댓글목록</span></a></li>
            <li><a href="클릭시 링크"><span>매칭보드 댓글목록</span></a></li>
            <li><a href="클릭시 링크"><span>자유게시판댓글목록</span></a></li>
        </ul>
        <div class="adList2">
            <h5>관리자 정보</h5>
        </div>
        <ul class="list">
            <li><a href="클릭시 링크"><span>개인정보 수정</span></a></li>
            <li><a href="클릭시 링크"><span>인증회원 신청</span></a></li>
        </ul>
    </div>

    <header class="header">
        <nav class="navi">
            <a title="home" href="<a href="${pageContext.request.contextPath}/AdminMainController">"><i class="fa-solid fa-house fa-xl"></i><br><span>홈</span></a>
            <a title="search" href="/search"><i class="fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br><span>발견</span></a>
            <a title="community" href="/community/feed"><i class="fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br><span>커뮤니티</span></a>
            <a title="myPage" href="/user/greetings"><i class="fa-solid fa-user fa-xl"></i><br><span>마이페이지</span></a>
        </nav>
    </header>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var logButton = document.getElementById("logBtn");

    var userNick = '<%= session.getAttribute("userNick") %>';

    if (userNick === "null") {
        userNick = "";
    }

    function redirectToLogin() {
        window.location.href = "http://localhost:8081/prc/LoginController";
    }

    function redirectToLogout() {
        $.ajax({
            type: "POST",
            url: "http://localhost:8081/prc/LogoutController",
            data: { userNick: userNick },
            success: function(response) {
                window.location.href = "메인컨트롤러로?"
            },
            error: function(xhr, status, error) {
                console.error("Logout error: " + status + " - " + error);
            }
        });
    }

    logButton.value = userNick === "" ? "로그인" : "로그아웃";

    logButton.onclick = function(event) {
        if (userNick === "") {
            redirectToLogin();
        } else {
            redirectToLogout();
        }
        event.preventDefault();
    };

    document.getElementById("myPage").onclick = function(event) {
        if (userNick == "") {
            location.href = "http://localhost:8081/prc/LoginController";
            event.preventDefault();
        } else {
            location.href = "http://localhost:8081/prc/prc/myPage.jsp";
            event.preventDefault();
        }
    };
});
</script>
</html>