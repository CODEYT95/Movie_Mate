<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/join/joinView1.css?after">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

    <!-- 다음 버튼활성화 -->
    <script>
        function checkName() {
            var nameCheck = /^[a-zA-Z가-힣\s]{2,20}$/;
            var name = $('#userName').val().trim();

            if (name.length < 2) {
                $('#checkName').text('이름을 입력해주세요. (2~20자)');
            } else if(!nameCheck.test(name)) {
                $('#checkName').text('이름을 다시 확인해주세요.');
            } else {
                $('#checkName').empty();
            }
        }

        function checkBirthYear() {
            var birthYear = document.getElementById("birth_year");
            var checkBirth = document.getElementById("checkbirth");

            if (birthYear.value !== "" && birthYear.value.length !== 4) {
                checkBirth.textContent = "년도를 4자리로 입력해주세요.";
            } else {
                checkBirth.textContent = "";
            }
        }

        $(document).ready(function() {
            $('#userName').keyup(checkName);
            $('#birth_year').keyup(checkBirthYear);
        });

        function activeEvent(userName, gender, birthYear, birthMonth, lastInput, nextButton) {
            var isBirthYearValid = birthYear.value.match(/^\d{4}$/); // 4자리 숫자인지 확인

            if (
                userName.value !== "" &&
                gender.value !== "" &&
                isBirthYearValid &&
                birthMonth.value !== "" &&
                lastInput.value.length > 0 &&
                $('#checkName').text().trim() === ""
            ) {
                nextButton.disabled = false;
                nextButton.style.backgroundColor = 'RGB(66, 99, 235)';
                nextButton.style.border = '1px solid RGB(66, 99, 235))';
                nextButton.style.cursor = 'pointer';
            } else {
                nextButton.disabled = true;
                nextButton.style.backgroundColor = 'RGB(59, 72, 105)';
                nextButton.style.border = '1px solid RGB(59, 72, 105))';
                nextButton.style.cursor = 'default';
            }
        }

        function checkFields() {
            var userName = document.getElementById("userName");
            var gender = document.querySelector('input[name="userGender"]:checked');
            var birthYear = document.getElementById("birth_year");
            var birthMonth = document.getElementById("birth_month");
            var birthDay = document.getElementById("birth_day");
            var nextButton = document.getElementById("next-btn");
            var lastInput = birthDay; // 마지막 입력 필드

            // 입력 필드 이벤트 등록
            userName.addEventListener("keyup", function() {
                activeEvent(userName, gender, birthYear, birthMonth, lastInput, nextButton);
            });

            gender.addEventListener("change", function() {
                activeEvent(userName, gender, birthYear, birthMonth, lastInput, nextButton);
            });

            birthYear.addEventListener("keyup", function() {
                activeEvent(userName, gender, birthYear, birthMonth, lastInput, nextButton);
            });

            birthMonth.addEventListener("change", function() {
                activeEvent(userName, gender, birthYear, birthMonth, lastInput, nextButton);
            });

            lastInput.addEventListener("keyup", function() {
                activeEvent(userName, gender, birthYear, birthMonth, lastInput, nextButton);
            });

            checkName();
            checkBirthYear();
            activeEvent(userName, gender, birthYear, birthMonth, lastInput, nextButton); // 초기 실행
        } 
    </script>

    <script>
        $(document).ready(function() {
            // 생년 입력란에 입력된 값이 변경되면 이벤트 발생
            $("#birth_year, #birth_day").on("input", function() {
                var notNum = $(this).val();
                // 숫자 이외의 값 제거
                notNum = notNum.replace(/[^0-9]/g, "");
                $(this).val(notNum);
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            // 날짜 입력란에 입력된 값이 변경되면 이벤트 발생
            $("#birth_day").on("input", function() {
                // 입력된 값이 31을 초과하면 31로 제한
                if (parseInt($(this).val()) > 31) {
                    $(this).val("31");
                }
            });
        });
    </script>
</head>
<body>
    <form id="joinView1" action="joinController" method="post">
        <div class="layout">
            <div class=content>
                <div class="sub_header">
                    <div class="sub_inner">
                        <button type="button" id="backButton" onclick="window.history.back();" class="backButton">
                            <i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i>
                        </button>
                        <h1>회원가입</h1>
                    </div>
                </div>
                <div>
                    <div class="wrapper_name">
                        <label for="userName" class="label-name">이름</label><br/>
                        <div>
                            <input type="text" id="userName" name="userName" class="inputName" onchange="checkFields()" maxlength="20" placeholder="이름 입력"><br/>
                            <div class="icon-container">
                                <button type="button" class="btnClearName">
                                    <i id="name-clear" class="fa-solid fa-circle-xmark fa-xl" style="color: #9297a0;"></i>
                                </button>
                            </div>
                        </div>
                        <span id="checkName"></span>
                    </div>
                </div>
                <div class="gender">
                    <label for="userGender" class="label-gender">성별</label>
                    <div class="radio_btn">
                        <input id="radio-1" type="radio" name="userGender" class="inputGender" value="남성" onchange="checkFields()">
                        <label for="radio-1" class="male-label">남성</label>

                        <input id="radio-2" type="radio" name="userGender" class="inputGender" value="여성" onchange="checkFields()">
                        <label for="radio-2" class="female-label">여성</label>
                    </div>
                </div>
                <div class="wrapper_birth">
                    <div style="margin-top: 25.6px;">
                        <label for="birth" class="label-birth">생년월일</label><br>
                        <input type="text" id="birth_year" name="year" class="inputBrith" maxlength="4" placeholder="년(4자)" size="6" onchange="checkFields()">
                        <select id="birth_month" name="month" class="inputBirth" onchange="checkFields()">
                            <option value="" selected disabled>월</option>
                            <option value="01">1</option>
                            <option value="02">2</option>
                            <option value="03">3</option>
                            <option value="04">4</option>
                            <option value="05">5</option>
                            <option value="06">6</option>
                            <option value="07">7</option>
                            <option value="08">8</option>
                            <option value="09">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                        </select>
                        <input type="text" id="birth_day" name="day" class="inputBirth" maxlength="2" placeholder="일" size="4" onchange="checkFields()">
                    </div> 
                    <span id="checkbirth"></span>
                </div>
                <div class="footer">
                    <div class="progress-bar">
                    </div>
                    <button type="submit" id="next-btn" name="next" class="next-btn" value="2" disabled="disabled">다음</button>
                </div>
            </div>
        </div>
    </form>
</body>  
</html>
