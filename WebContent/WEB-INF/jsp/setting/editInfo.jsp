<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/setting/editinfo.css?after">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

<script>
var engNumSpecRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~!@#$%^&*\(\)\\-_=+{}\[\]?.,<>/\|`~'"​;:])(?!.*\s).{8,16}$/;



function updateNextButtonState() {

	 var pwck = $('#pwck').html();
	  var nickck = $('#nickck').html();
	  var telck = $('#telck').html();
	  var userAddr_Gu = $('#userAddr_Gu').val();
	  
	  if (pwck.trim() == "유효한 비밀번호 입니다." && nickck.trim() == "사용 가능한 닉네임입니다." && telck.trim() == "사용 가능한 번호입니다." && userAddr_Gu.trim() != "1") {
		  $('#next-btn').prop('disabled', false)
          .css('cursor', 'pointer')
          .css('background-color', 'RGB(66, 99, 235)')
          .css('border', '1px solid RGB(66, 99, 235)');
		  } else {
			  $('#next-btn').prop('disabled', true)
	            .css('cursor', 'default')
	            .css('background-color', 'RGB(59, 72, 105)')
	            .css('border', '1px solid RGB(59, 72, 105)');
		  }
}

$(document).ready(function() {
	  $('#updatePw').keyup(function() {
	    var userPw = $('#updatePw').val();
	    var checkPw = $('#pwck');
	    
	    if (userPw.trim() === "") {
	      checkPw.html('');
	    } else if (userPw.length < 8 || userPw.length > 20) {
	      checkPw.html('비밀번호는 8자리 ~ 20자리 이내로 입력해주세요.');
	      checkPw.css('color', 'RGB(240, 62, 62)');
	    } else if (!engNumSpecRegex.test(userPw)) {
	      checkPw.html('영문과 숫자, 특수문자를 모두 포함해주세요.');
	      checkPw.css('color', 'RGB(240, 62, 62)');
	    } else {
	      checkPw.html('유효한 비밀번호 입니다.');
	      checkPw.css('color', '#00aa00');
	    }
	    updateNextButtonState();
	  });

	  $('.pw-eye').on('click', function() {
	        var input = $('#updatePw');
	        input.attr('type', input.attr('type') === 'password' ? 'text' : 'password');
	        $(this).toggleClass('fa-eye fa-eye-slash');
	    });
	  
	  $('#updateNick').keyup(function() {
	    var userNick = $('#updateNick').val().trim();
	    var checkNick = $('#nickck');
	    if (userNick == '') {
	      checkNick.empty();
	      return;
	    }

	    // 유효성 체크
	    var regex = /^(?!.*[ㄱ-ㅎㅏ-ㅣ])[a-zA-Z0-9가-힣-_]+$/;
	    if (!regex.test(userNick)) {
	      checkNick.html('한글, 영어, 숫자, 언더바(_)와 대쉬(-)만 사용 가능합니다.')
	               .css('color', '#f03e3e');
	      return;
	    }

	    // 최소 글자 수 체크
	    if (userNick.length < 2) {
	      checkNick.html('최소 글자 수를 채워주세요.').css('color', '#f03e3e');
	      return;
	    }

	    // 중복 체크 요청
	    $.ajax({
	      url: 'http://localhost:8081/MovieMate/nickCheckController',
	      type: 'post',
	      data: { userNick: userNick },
	      success: function(result) {
	        checkNick.html(result == 0 ? '사용 가능한 닉네임입니다.' : '이미 사용중인 닉네임입니다.')
	                 .css('color', result == 0 ? '#00aa00' : '#f03e3e');
	        updateNextButtonState();
	      },
	      error: function() {
	        alert('서버 요청 실패');
	        updateNextButtonState();
	      }
	    });
	  });

	  $('#updateTel').on('input', function() {
	        var userTel = $(this).val();
	        userTel = userTel.replace(/[^0-9]/g, '');
	        $(this).val(userTel);

	        if (userTel.length != 11 || !/^01(0|1|6|7|8|9)\d{8}$/.test(userTel)) {
	            $('#telck').text('잘못된 번호입니다.');
	            $('#telck').css('color', 'RGB(240, 62, 62)');
	            updateNextButtonState();
	        } else {
	            $.ajax({
	                url: 'http://localhost:8081/MovieMate/telCheckController',
	                type: 'post',
	                data: { userTel: userTel },
	                success: function(result) {
	                	console.log(result);
	                    if (userTel == '') {
	                        $('#telck').html('');
	                    } else if (result == 0) {
	                        $('#telck').html('사용 가능한 번호입니다.');
	                        $('#telck').css('color', '#00aa00');
	                    } else {
	                        $('#telck').html('사용 할 수 없는 번호입니다.');
	                        $('#telck').css('color', 'RGB(240, 62, 62)');
	                    }
	                    updateNextButtonState();
	                },
	                error: function() {
	                    alert('서버 요청 실패');
	                    updateNextButtonState();
	                }
	            });
	        }

	        if (userTel == '') {
	            $('#tel-clear').hide();
	        } else {
	            $('#tel-clear').show();
	        }
	    });

	  $('#updatePw').keyup(function() {
	        var updatePw = $('#updatePw').val();

	        if (updatePw !== "") {
	            $('#pw-eye').show();
	            $('#pw-clear').show();
	        } else {
	            $('#pw-eye').hide();
	            $('#pw-clear').hide();
	        }
	    });
	    $('.btnClearPw').click(function() {
	        $('#updatePw').val('');
	        $('#pwck').text(''); 
	        $('#pw-eye').hide();
	        $('#pw-clear').hide();
	    });
	    
	    $('.btnClearTel').click(function() {
	        $('#updateTel').val('');
	        $('#telck').text('');
	        $('#tel-clear').hide();
	    });

	    $('#userAddr_Gu').on('change', function() {
	    	updateNextButtonState();
	    });

	    updateNextButtonState();
	});
</script>


</head>
<body>
<form action="updateController" method="post">
	<div class="layout">
		<div class=content>
			<div class="sub_header">
				<div class="sub_inner">
					<button type="button" id="backButton"
						onclick="window.history.back();" class="backButton">
						<i class="fa-solid fa-chevron-left fa-xl"
							style="color: RGB(255, 255, 255)"></i>
					</button>
					<h1>개인정보 수정</h1>
				</div>
			</div>
			<div>
				<div>
					<label for="ID" class="label-ID">아이디(변경불가)</label> <input
						type="text" id="MyId" class="MyId"
						placeholder="<%=session.getAttribute("userId")%>"
						disabled="disabled">
				</div>
				<div>
					<label for="PW" class="label-PW">비밀번호</label> <input
						type="password" id="updatePw" name="updatePw" class="updatePw"
						placeholder="변경할 비밀번호 입력(문자,숫자,특수문자 포함 8~20자)" maxlength="20"> <span
						id="pwck"></span>
					<div class="pwBtn">
						<i id="pw-eye" class="pw-eye fa fa-eye fa-lg fa-xl"
							style="color: #9297a0;"></i>
						<button type="button" class="btnClearPw">
							<i id="pw-clear" class="pw-clear fa-solid fa-circle-xmark fa-xl"
								style="color: #9297a0;"></i>
						</button>
					</div>
				</div>
				<div>
					<label for="NICK" class="label-NICK">닉네임</label> <input type="text"
						id="updateNick" class="updateNick" name="updateNick"
						placeholder="변경할 닉네임 입력(한글/영문 2~20자)">
					<span id="nickck"></span>
				</div>
				<div>
					<label for="TEL" class="label-TEL">전화번호</label> 
					<div class="aa">
					<input type="text"
						id="updateTel" class="updateTel" maxlength="11" name="updateTel"
						placeholder="변경할 전화번호 11자리"> 
					</div>
						<span id="telck"></span>
				</div>
				<div class="addr">
					<div class="wrapper_Si">
						<label for="userAddr_Si" class="label_Addr_Si">주소</label><br>
						<div class="input-container">
							<input type="text" id="userAddr_Si" name="userAddr_Si"
								class="inputAddr_Si" value="서울시" disabled>
							<div class="icon-container"></div>
						</div>
					</div>
					<div class="wrapper_Gu">
						<div class="input-container">
							<select id="userAddr_Gu" name="userAddr_Gu[]"
								class="inputAddr_Gu">
								<option value="1" selected disabled>구 선택</option>
								<option value="종로구">종로구</option>
								<option value="중구">중구</option>
								<option value="용산구">용산구</option>
								<option value="성동구">성동구</option>
								<option value="광진구">광진구</option>
								<option value="동대문구">동대문구</option>
								<option value="중랑구">중랑구</option>
								<option value="성북구">성북구</option>
								<option value="강북구">강북구</option>
								<option value="도봉구">도봉구</option>
								<option value="노원구">노원구</option>
								<option value="은평구">은평구</option>
								<option value="서대문구">서대문구</option>
								<option value="마포구">마포구</option>
								<option value="양천구">양천구</option>
								<option value="강서구">강서구</option>
								<option value="구로구">구로구</option>
								<option value="금천구">금천구</option>
								<option value="영등포구">영등포구</option>
								<option value="동작구">동작구</option>
								<option value="관악구">관악구</option>
								<option value="서초구">서초구</option>
								<option value="강남구">강남구</option>
								<option value="송파구">송파구</option>
								<option value="강동구">강동구</option>
							</select>
						</div>
					</div>
				</div>
			</div>

			<div class="footer">
				<button type="submit" id="next-btn" name="next" class="next-btn"
					value="5" disabled="disabled">저장</button>
			</div>
		</div>
	</div>
	<header class="header">
		<nav class="navi">
			<a title="home" href="http://localhost:8081/MovieMate/mainController"><i class="fa-solid fa-house fa-xl"></i><br>
			<span>홈</span></a> <a title="search" href="http://localhost:8081/MovieMate/SearchMovie"><i
				class="fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br>
			<span>발견</span></a> <a title="community" href="http://localhost:8081/MovieMate/freeCommunityController"><i
				class="fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br>
			<span>커뮤니티</span></a> <a title="myPage" href="http://localhost:8081/MovieMate/myPageController"><i
				class="fa-solid fa-user fa-xl"></i><br>
			<span>마이페이지</span></a>
		</nav>
	</header>
</form>
</body>
</html>
