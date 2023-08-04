<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/join/joinView4.css?after">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

     <script>
     $(document).ready(function() {
    	    $('#userTel').on('input', function() {
    	        var userTel = $(this).val();
    	        userTel = userTel.replace(/[^0-9]/g, '');
    	        $(this).val(userTel);

    	        if (userTel.length != 11 || !/^01(0|1|6|7|8|9)\d{8}$/.test(userTel)) {
    	            $('#ckTel').text('잘못된 번호입니다.');
    	            $('#ckTel').css('color', 'RGB(240, 62, 62)');
    	        } else {
    	            $.ajax({
    	                url: 'telCheckController',
    	                type: 'post',
    	                data: { userTel: userTel },
    	                success: function(result) {
    	                	console.log(result);
    	                    if (userTel == '') {
    	                        $('#ckTel').html('');
    	                    } else if (result == 0) {
    	                        $('#ckTel').html('사용 가능한 번호입니다.');
    	                        $('#ckTel').css('color', '#00aa00');
    	                    } else {
    	                        $('#ckTel').html('사용 할 수 없는 번호입니다.');
    	                        $('#ckTel').css('color', 'RGB(240, 62, 62)');
    	                    }
    	                    updateNextButtonState();
    	                },
    	                error: function() {
    	                    alert('서버 요청 실패');
    	                }
    	            });
    	        }

    	        if (userTel == '') {
    	            $('#tel-clear').hide();
    	        } else {
    	            $('#tel-clear').show();
    	        }
    	        updateNextButtonState();
    	    });

    	    $('.btnClearTel').click(function() {
    	        $('#userTel').val('');
    	        $('#tel-clear').hide();
    	        updateNextButtonState();
    	    });

    	    $('#userAddr_Gu').on('change', function() {
    	        updateNextButtonState();
    	    });

    	    updateNextButtonState();
    	});

    	function updateNextButtonState() {
    	    var userAddr_Gu = $('#userAddr_Gu').val();
    	    var userTel = $('#userTel').val();
    	    var checkTel = $('#ckTel').html();

    	    if ((userAddr_Gu === '종로구' || userAddr_Gu === '중구' || userAddr_Gu === '용산구' || userAddr_Gu === '성동구' || userAddr_Gu === '광진구' || userAddr_Gu === '동대문구' || userAddr_Gu === '중랑구' || userAddr_Gu === '성북구' || userAddr_Gu === '강북구' || userAddr_Gu === '도봉구'
    	        || userAddr_Gu === '노원구' || userAddr_Gu === '은평구' || userAddr_Gu === '서대문구' || userAddr_Gu === '마포구' || userAddr_Gu === '양천구' || userAddr_Gu === '강서구' || userAddr_Gu === '구로구' || userAddr_Gu === '금천구' || userAddr_Gu === '영등포구' || userAddr_Gu === '동작구'
    	        || userAddr_Gu === '관악구' || userAddr_Gu === '서초구' || userAddr_Gu === '강남구' || userAddr_Gu === '송파구' || userAddr_Gu === '강동구') && /^01(0|1|6|7|8|9)\d{8}$/.test(userTel) && checkTel == '사용 가능한 번호입니다.') {
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

    	function handleSubmit() {
    	    $('#join4').submit();
    	}
    </script>

  </head>
  <body>
    <form id="join4" action="joinController" method="post">
      <div class="layout">
        <div class=content>
          <div class="sub_header">
            <div class="sub_inner">
              <button type="button" id="backButton" onclick="window.history.back();" class="backButton"><i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i></button>
              <h1>회원가입</h1>
            </div>
          </div>
          <div>
            <div class="wrapper_tel">
              <label for="userTel" class="label-Tel">전화번호</label><br />
              <div class="input-container">
                <input type="text" id="userTel" name="userTel" class="inputTel" maxlength="11" placeholder="휴대폰 번호 입력('-'제외 11자리 입력)"><br />
                <button type="button" class="btnClearTel">
                  <i id="tel-clear" class="fa-solid fa-circle-xmark fa-xl" style="color: #9297a0; display: none;"></i>
                </button>
              </div>
              <span id="ckTel"></span>
            </div>
          </div>
          <div class="addr">
            <div class="wrapper_Si">
              <label for="userAddr_Si" class="label_Addr_Si">주소</label><br>
              <div class="input-container">
                <input type="text" id="userAddr_Si" name="userAddr_Si" class="inputAddr_Si" value="서울시" disabled>
                <div class="icon-container"></div>
              </div>
            </div>
            <div class="wrapper_Gu">
              <div class="input-container">
                <select id="userAddr_Gu" name="userAddr_Gu[]" class="inputAddr_Gu">
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
          <div class="footer">
            <div class="progress-bar">
            </div>
            <button type="submit" id="next-btn" name="next" class="next-btn" value="5" disabled="disabled">다음</button>
          </div>
        </div>
      </div>
    </form>
  </body>
</html>