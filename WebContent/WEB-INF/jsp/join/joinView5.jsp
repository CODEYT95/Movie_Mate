<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/join/joinView5.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script>
function checkEmail() {
	  var email = $("#userEmail").val();
	  var option = $("#emailselect").val();
	  var emailCheck = /^[a-zA-Z0-9]+([\-_\.]?[a-zA-Z0-9]+)*$/;
	  var nextButton = $("#next-btn")[0];
	  var checkEmailText = $("#checkEmail");
	  var checkEmailColor = "";

	  if (email.length === 0 || option === null) {
	    nextButton.disabled = true;
	    checkEmailText.text("");
	  } else if (emailCheck.test(email) && option !== null) {
	    $.ajax({
	      url: 'emailCheckController',
	      type: 'post',
	      data: {
	        email: email,
	        option: option
	      },
	      success: function(result) {
	        if (email === "") {
	          checkEmailText.html("");
	        } else if (result == 0) {
	          checkEmailText.html('사용 가능한 이메일입니다.');
	          checkEmailColor = '#00aa00';
	          nextButton.disabled = false;
	        } else {
	          checkEmailText.html('사용 할 수 없는 이메일입니다.');
	          checkEmailColor = 'RGB(240, 62, 62)';
	          nextButton.disabled = true;
	        }
	        nextButton.style.backgroundColor = (checkEmailColor === '') ? "RGB(59, 72, 105)" : "RGB(66, 99, 235)";
	        nextButton.style.border = (checkEmailColor === '') ? "1px solid RGB(59, 72, 105)" : "1px solid RGB(66, 99, 235)";
	        nextButton.style.cursor = (checkEmailColor === '') ? "default" : "pointer";
	        checkEmailText.css('color', checkEmailColor);
	      },
	      error: function() {
	        alert("서버요청실패");
	      }
	    });
	  } else {
	    checkEmailText.text("올바른 형식의 이메일을 입력해주세요.");
	    checkEmailText.css('color', 'RGB(240, 62, 62)');
	    nextButton.disabled = true;
	    nextButton.style.backgroundColor = "RGB(59, 72, 105)";
	    nextButton.style.border = "1px solid RGB(59, 72, 105)";
	    nextButton.style.cursor = "default";
	  }

	  (email == '') ? $('.btnClearEmail').hide() : $('.btnClearEmail').show();

	  $('.btnClearEmail').click(function() {
	    $('#userEmail').val('');
	    $('#checkEmail').hide();
	    checkEmail();
	  });
	}

	$(document).ready(function() {
	  $("#userEmail").on("keyup", checkEmail);
	  $("#emailselect").on("change", checkEmail);
	});
</script>

</head>
<body>
<form id="join5" action="joinController" method="post">
    <div class="layout">
        <div class=content>
            <div class="sub_header">
                <div class="sub_inner">
                    <button type="button" id="backButton" onclick="window.history.back();" class="backButton"><i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i></button>
                    <h1>회원가입</h1>
                </div>
            </div>
            <div class="wrapper_email">
                <label for="userEmail" class="label-email">이메일</label>
                <div class="email-container">
                    <div class="input-container">
                        <div class="email">
                            <input type="text" id="userEmail" name="userEmail" class="inputEmail" maxlength="20" placeholder="이메일 입력">
                            <div>
                                <button type="button" class="btnClearEmail"><i id="email-clear" class="fa-solid fa-circle-xmark fa-xl" style="color: #9297a0;"></i></button>
                            </div>
                            <i class="at fa-solid fa-at fa-lg"></i>
                        </div>
                    </div>
                    <div class="select">
                        <select name="userEmail[]" id="emailselect" class="emailselect">
                            <option selected disabled> 선택 </option>
                            <option value="gmail.com"> gmail.com </option>
                            <option value="naver.com"> naver.com </option>
                            <option value="daum.com"> daum.net </option>
                            <option value="nate.com"> nate.com </option>
                        </select>
                    </div>
                </div>
                <span id="checkEmail"></span>
            </div>
            <div class="footer">
                <div class="progress-bar">
                </div><button type="submit" id="next-btn"  name="next" class="next-btn"  value="6" disabled="disabled">다음</button>
            </div>
        </div>
    </div>
</form>
</body>
</html>