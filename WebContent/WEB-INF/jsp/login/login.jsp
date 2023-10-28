<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
 
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login/login.css">
<link  rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Caprasimo&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function() {
	  $('.input-box i').on('click', function() {
	    var input = $(this).prev('input');
	    input.attr('type', input.attr('type') === 'password' ? 'text' : 'password');
	    $(this).toggleClass('fa-eye fa-eye-slash');
	  });
	});
 </script>
 
 <script>
    $(document).ready(function() {
        $('.pw-eye').on('click', function() {
            var input = $('#pw');
            input.attr('type', input.attr('type') == 'password' ? 'text' : 'password');
            $(this).toggleClass('fa-eye fa-eye-slash');
        });
    });
</script>
 
<script>
$(document).ready(function() {
    $('#loginBtn').click(function() {
        var Id = $('#id').val();
        var Pw = $('#pw').val();
        if (Id == "") {
            alert("아이디를 입력해주세요.");
        } else if (Pw == "") {
            alert("비밀번호를 입력해주세요.");
        } else {
            $.ajax({
                url: 'LoginCheckController',
                type: 'post',
                data: { 
                    userId: Id ,
                    userPw: Pw        
                },
                success: function(result) {
                    if (result == "1") {
                        alert("관리자로 로그인 하셨습니당 :)")
                        location.href = ""; 
            
                    } else if (result == "2") {
                        location.href = "mainController";
                        
                    } else if (result == "3") {
                        $('.checkLogin').html('아이디 혹은 비밀번호가 맞지 않습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    $('.checkLogin').html('존재하지 않는 아이디입니다.');
                }
            });
        }
    });
});

</script>

<style>

</style>
</head>

<body>
  <div class="sub_header">
  <div class="sub_inner">
  <button type="button"  id="backButton" onclick="window.history.back();" class="backButton" ><i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i></button>
  <img id="logo" src="${pageContext.request.contextPath}/img/login/logo.png">
  </div>
    </div>
<div class="main">  	
		<input type="checkbox" id="chk" aria-hidden="true">

			<div class="signup">
			</div>

			<div class="login">
					<label for="chk" aria-hidden="true">로그인</label>
					<input type="text" id="id" name="ID" placeholder="ID">
					<input type="password" id="pw" name="PW" placeholder="Password" >
					<i id="pw-eye" class="pw-eye fa fa-eye fa-lg fa-xl"></i>
					<span class="checkLogin"></span>
					<div class="btn">
					<button id="loginBtn">로그인</button>
					<a href="joinController">
					<button  class="join">회원가입</button>
					</a>
					</div>
			</div>
	</div>
   <header class="header">
    <nav class ="navi">
    <a title="home"   class="headerIcon" href="http://localhost:8081/MovieMate/mainController"  ><i class="fa-solid fa-house fa-xl"></i><br><span >홈</span></a>
    <a title="search"  class="headerIcon" href="http://localhost:8081/MovieMate/SearchMovie"><i class="fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br><span >검색</span></a>
    <a title="community"  class="headerIcon"href="http://localhost:8081/MovieMate/freeCommunityController"><i class="fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br><span >커뮤니티</span></a>
    <a title="myPage" class="headerIcon"href="http://localhost:8081/MovieMate/myPageController"><i class="fa-solid fa-user fa-xl"></i><br><span >마이페이지</span></a>
    </nav>
  </header>
</body>
</html>
