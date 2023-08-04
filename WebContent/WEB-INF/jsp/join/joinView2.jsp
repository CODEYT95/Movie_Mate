<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/join/joinView2.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script>
$(document).ready(function() {
    $('#userId, #userPw, #userPwCk').on("input", function() {
        validateInputs();
    });
    
    $('#id-clear').hide();
    $('#pw-eye').hide();
    $('#pw-clear').hide();
    $('#pwck-eye').hide();
    $('#pwck-clear').hide();

    function validateInputs() {
        var userId = $('#userId').val();
        var userPw = $('#userPw').val();
        var userPwCk = $('#userPwCk').val();
        var checkId = $('#checkId');
        var checkPw = $('#ck_pw');
        var checkPwCk = $('#ck_pwck');
        var nextButton = document.getElementById('next-btn');

        var engNum = /^[a-zA-Z0-9]+$/;
        var engNumSpec = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~!@#$%^&*\(\)\\-_=+{}\[\]?.,<>/\|`~'"​;:])(?!.*\s).{8,16}$/;

        if (userId.trim() === "") {
            checkId.html('');
        } else if (userId.length < 6 || userId.length > 20) {
            checkId.html('아이디는 6자리 ~ 20자리 이내로 입력해주세요.');
            checkId.css('color', 'RGB(240, 62, 62)');
        } else if (userId.search(/\s/) !== -1) {
            checkId.html('아이디는 공백 없이 입력해주세요.');
            checkId.css('color', 'RGB(240, 62, 62)');
        } else if (!engNum.test(userId)) {
            checkId.html('아이디는 영문과 숫자만 입력해주세요.');
            checkId.css('color', 'RGB(240, 62, 62)');
        }

        if (userPw.trim() === "") {
            checkPw.html('');
            checkPwCk.html('');
        } else if (userPw.length < 8 || userPw.length > 20) {
            checkPw.html('비밀번호는 8자리 ~ 20자리 이내로 입력해주세요.');
            checkPw.css('color', 'RGB(240, 62, 62)');
        } else if (!engNumSpec.test(userPw)) {
            checkPw.html('영문과 숫자, 특수문자를 모두 포함해주세요.');
            checkPw.css('color', 'RGB(240, 62, 62)');
        } else {
            checkPw.html('유효한 비밀번호 입니다.');
            checkPw.css('color', '#00aa00');
        }

        if (userPwCk.trim() === "") {
            checkPwCk.html('');
        } else if (userPw !== userPwCk) {
            checkPwCk.html('비밀번호가 일치하지 않습니다.');
            checkPwCk.css('color', 'RGB(240, 62, 62)');
        } else {
            checkPwCk.html('비밀번호가 일치합니다.');
            checkPwCk.css('color', '#00aa00');
        }

        if (checkId.css('color') === "rgb(0, 170, 0)" && checkPw.css('color') === "rgb(0, 170, 0)" && checkPwCk.css('color') === "rgb(0, 170, 0)") {
            nextButton.disabled = false;
            nextButton.style.backgroundColor = 'RGB(66, 99, 235)';
            nextButton.style.border = '1px solid RGB(66, 99, 235)';
            nextButton.style.cursor = 'pointer';
        } else {
            nextButton.disabled = true;
            nextButton.style.backgroundColor = 'RGB(59, 72, 105)';
            nextButton.style.border = '1px solid RGB(59, 72, 105)';
            nextButton.style.cursor = 'default';
        }
    }

    $('#userId').keyup(function() {
        var userId = $('#userId').val();
        $.ajax({
            url: 'idCheckController',
            type: 'post',
            data: { userId: userId },
            success: function(result) {
                if (userId === "") {
                     $('#checkId').html("");
                 } else if (result == 0) {
                     $('#checkId').html('사용 가능한 아이디입니다.');
                     $('#checkId').css('color', '#00aa00');
                 } else {
                     $('#checkId').html('이미 사용중인 아이디입니다.');
                     $('#checkId').css('color', 'RGB(240, 62, 62)');
                 }
                validateInputs();
            },
            error: function() {
                alert("서버요청실패");
            }
        });
    });

    $('.pw-pwck').keyup(function() {
        let pass = $("#userPw").val();
        let passCk = $("#userPwCk").val();
        let num = pass.search(/[0-9]/g);
        let eng = pass.search(/[a-z]/ig);
        let spe = pass.search(/[`~!@#$%^&*|\\'";:\/?]/gi);

        if (pass !== "") {
            if (pass.length < 8 || pass.length > 20) {
                $("#ck_pw").html("8자리 ~ 20자리 이내로 입력해주세요.");
                $("#ck_pw").css('color', "RGB(240, 62, 62)");
            } else if (pass.search(/\s/) !== -1) {
                $("#ck_pw").html("비밀번호는 공백 없이 입력해주세요.");
                $("#ck_pw").css('color', "RGB(240, 62, 62)");
            } else if ((num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0)) {
                $("#ck_pw").html("영문, 숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.");
                $("#ck_pw").css('color', "RGB(240, 62, 62)");
            } else {
                $("#ck_pw").html("유효한 비밀번호 입니다.");
                $("#ck_pw").css('color', "#00aa00");
            }
        } else {
            $("#ck_pw").html("");
        }

        if (passCk !== "") {
            if (pass === passCk) {
                $("#ck_pwck").html('비밀번호가 일치합니다.');
                $("#ck_pwck").css('color', "#00aa00");
            } else {
                $("#ck_pwck").html("비밀번호가 일치하지 않습니다.");
                $("#ck_pwck").css('color', "RGB(240, 62, 62)");
            }
        } else {
            $("#ck_pwck").html("");
        }
        validateInputs();
    });
    
    $('#userId').keyup(function() {
        var userId = $('#userId').val();

        if (userId !== "") {
            $('#id-clear').show();
        } else {
            $('#id-clear').hide();
        }
    });
    
    $('#userPw').keyup(function() {
        var userPw = $('#userPw').val();

        if (userPw !== "") {
        	$('#pw-eye').show();
            $('#pw-clear').show();
        } else {
            $('#pw-eye').hide();
            $('#pw-clear').hide();
        }
    });

    $('#userPwCk').keyup(function() {
        var userPwCk = $('#userPwCk').val();

        if (userPwCk !== "") {
            $('#pwck-eye').show();
            $('#pwck-clear').show();
        } else {
            $('#pwck-eye').hide();
            $('#pwck-clear').hide();
        }
    });

    $('.btnClearId').click(function() {
        $('#userId').val('');
        $('#checkId').text('');
        $('#id-clear').hide();
    });

    $('.btnClearPw').click(function() {
        $('#userPw').val('');
        $('#ck_pw').text(''); 
        $('#pw-eye').hide();
        $('#pw-clear').hide();
    });

    $('.btnClearPwck').click(function() {
        $('#userPwCk').val('');
        $('#ck_pwck').text(''); 
        $('#pwck-eye').hide();
        $('#pwck-clear').hide();
    });

    $('.pw-eye').on('click', function() {
        var input = $('#userPw');
        input.attr('type', input.attr('type') === 'password' ? 'text' : 'password');
        $(this).toggleClass('fa-eye fa-eye-slash');
    });

    $('.pwck-eye').on('click', function() {
        var input = $('#userPwCk');
        input.attr('type', input.attr('type') === 'password' ? 'text' : 'password');
        $(this).toggleClass('fa-eye fa-eye-slash');
    });
});
</script>

</head>
<body>
    <form id="join2" action="joinController" method="post">
        <div class="layout">
            <div class="content">
                <div class="sub_header">
                    <div class="sub_inner">
                        <button type="button" id="backButton" onclick="window.history.back();" class="backButton">
                            <i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i>
                        </button>
                        <h1>회원가입</h1>
                    </div>
                </div>
                <div>
                    <div class="wrapper_id">
                        <label for="userId" class="label-id">아이디</label><br/>
                        <div class="input-container">
                            <input type="text" id="userId" name="userId" class="inputId" maxlength="20" placeholder="아이디 입력(6~20자)"><br/>
                            <div class="icon-container">
                                <button type="button" class="btnClearId">
                                    <i id="id-clear" class="fa-solid fa-circle-xmark fa-xl" style="color: #9297a0 ;" style="display: block;"></i>
                                </button>
                            </div>
                        </div>
                        <span id="checkId"></span>
                    </div>
                </div>
                <div class="pw-pwck">
                    <div class="wrapper_pw">
                        <label for="userPw" class="label-pw">비밀번호</label><br>
                        <div class="input-container">
                            <input type="password" id="userPw" name="userPw" class="inputPw" placeholder="비밀번호 입력(문자,숫자,특수문자 포함 8~20자)" maxlength="20">
                            <div class="pwBtn">
                                <i id="pw-eye" class="pw-eye fa fa-eye fa-lg fa-xl" style="color: #9297a0;"></i>
                                <button type="button" class="btnClearPw">
                                    <i id="pw-clear" class="pw-clear fa-solid fa-circle-xmark fa-xl" style="color: #9297a0;"></i>
                                </button>
                            </div>
                        </div>
                        <span id="ck_pw" class="ck_pw"></span>
                    </div>
                    <div class="wrapper_pwck">
                        <label for="userPwCk" class="label-pwck">비밀번호 확인</label><br>
                        <div class="input-container">
                            <input type="password" id="userPwCk" name="userPwCk" class="inputPwck" placeholder="비밀번호 다시 입력" maxlength="20">
                            <div class="pwBtn">
                                <i id="pwck-eye" class="pwck-eye fa fa-eye fa-lg fa-xl" style="color: #9297a0;"></i>
                                <button type="button" class="btnClearPwck">
                                    <i id="pwck-clear" class="pwck-clear fa-solid fa-circle-xmark fa-xl" style="color: #9297a0;"></i>
                                </button>
                            </div>
                        </div>
                        <span id="ck_pwck" class="ck_pwck"></span>
                    </div>
                </div>
                <div class="footer">
                    <div class="progress-bar">
                    </div>
                    <button type="submit" id="next-btn" name="next" class="next-btn" value="3" disabled="disabled">다음</button>
                </div>
            </div>
        </div>
    </form>
</body>
</html>