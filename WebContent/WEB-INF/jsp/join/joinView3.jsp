<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/join/joinView3.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

<script>
$(document).ready(function() {
  $('#userNick').keyup(function() {
    var userNick = $('#userNick').val().trim();
    var checkNick = $('#checkNick');
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
      url: 'nickCheckController',
      type: 'post',
      data: { userNick: userNick },
      success: function(result) {
        checkNick.html(result == 0 ? '사용 가능한 닉네임입니다.' : '이미 사용중인 닉네임입니다.')
                 .css('color', result == 0 ? '#00aa00' : '#f03e3e');
        nextPageck();
      },
      error: function() {
        alert('서버 요청 실패');
      }
    });
  });

  $('.autoNick').click(function() {
    var nextButton = document.getElementById('nextButton');
    var userNick = generateRandomNickname();
    $('#userNick').val(userNick);
    $('#checkNick').text('');

    if (userNick.length >= 2) {
      nextButton.disabled = false;
      nextButton.style.backgroundColor = 'RGB(66, 99, 235)';
      nextButton.style.border = '1px solid RGB(66, 99, 235)';
      nextButton.style.cursor = 'pointer';
    }
  });

  $('.btnClearNick').click(function() {
    $('#userNick').val('');
    $('#checkNick').text('');
    var nextButton = document.getElementById('nextButton');
    nextButton.disabled = true;
    nextButton.style.backgroundColor = 'RGB(59, 72, 105)';
    nextButton.style.border = '1px solid RGB(59, 72, 105)';
    nextButton.style.cursor = 'default';
  });

  $("#userNick").on("keyup", function() {
    nextPageck();
  });

  $(document).on("input keyup", "#checkNick", function() {
    nextPageck();
  });
});


function generateRandomNickname() {
  var actorName = ["원빈", "마동석", "공유", "조진웅", "송강호", "조진웅","이병헌","유해진","황정민","이하늬","하지원","정우성","박해일",
                   "전도연","아이유","손예진","장동건","설경구","김혜수","배용준","강동원","김하늘","손석구","송중기","하정우","최민식","임지현","이도현",
                   "전지현","주지훈","유해진","송혜교","박신혜","김수현","박보영","김고은","유인나","권나라","최지우","크리스에반스","키아누리브스",
                   "브래드피트","톰쿠르즈","톰하디","조니뎁","크리스찬베일","디카프리오","오드리햅번","마를린먼로","톰홀랜드","멧데이먼","아놀드",
                   "브루스윌리스","빈디젤","니콜라스케이지","드웨인존슨","엠마왓슨","엠마스톤","스칼렛요한슨","클레이모레츠","나탈리포트먼","니콜키드먼",
                   "앤해서웨이","아만다사이프리드","안젤리나졸리","메간폭스","갤가돗","밀라조보비치","마고로비","제니퍼로렌스","제시카알바",  "드워프", "박윤태", "신수훈", "이윤지", "최도훈", "강민용"];

  var adjectives = ["가냘픈", "게으른", "괜찮은", "귀여운", "너그러운", "무서운","수다스러운" ,"슬픈","쌀쌀맞은", "맹랑한",
                    "아름다운","도도한","예쁜", "외로운","재미있는","젊은","즐거운","매력적인","짧은머리","긴머리","까칠한",
                    "신난","화난","피곤한","용감한","따뜻한", "활발한","겸손한","놀란","섹시한","앙증맞은","착한","수줍은", "똑똑한", "멍청한"];

  var randomAdjectiveIndex = Math.floor(Math.random() * adjectives.length);
  var randomActorNameIndex = Math.floor(Math.random() * actorName.length);
  var randomAdjective = adjectives[randomAdjectiveIndex];
  var randomActorName = actorName[randomActorNameIndex];
  var randomNumber = String(Math.floor(Math.random() * 1000)).padStart(3, '0');

  var randomNickname = randomAdjective + '_' + randomActorName + '_' + randomNumber;

  $('#userNick').val(randomNickname);

  $.ajax({
    url: 'nickCheckController',
    type: 'post',
    data: { userNick: randomNickname },
    success: function(result) {
      $('#checkNick').html(result == 0 ? '사용 가능한 닉네임입니다.' : '이미 사용중인 닉네임입니다.')
                     .css('color', result == 0 ? '#00aa00' : '#f03e3e');
      nextPageck();
    },
    error: function() {
      alert('서버 요청 실패');
    }
  });

  return randomNickname;
}

function nextPageck() {
  var checkNick = document.getElementById("checkNick");
  var nextButton = document.getElementById("next-btn");

  if (checkNick && checkNick.textContent.trim() == '사용 가능한 닉네임입니다.') {
    nextButton.disabled = false;
    nextButton.style.backgroundColor = 'RGB(66, 99, 235)';
    nextButton.style.border = '1px solid RGB(66, 99, 235)';
    nextButton.style.cursor = 'pointer';
  } else if (checkNick && checkNick.textContent.trim() == '이미 사용중인 닉네임입니다.') {
    nextButton.disabled = true;
    nextButton.style.backgroundColor = 'RGB(59, 72, 105)';
    nextButton.style.border = '1px solid RGB(59, 72, 105)';
    nextButton.style.cursor = 'default';
  } else {
    nextButton.disabled = true;
    nextButton.style.backgroundColor = 'RGB(59, 72, 105)';
    nextButton.style.border = '1px solid RGB(59, 72, 105)';
    nextButton.style.cursor = 'default';
  }
}
</script>

</head>
<body>
  <form id="join3" action="joinController" method="post">
    <div class="layout">
      <div class="content">
        <div class="sub_header">
          <div class="sub_inner">
            <button type="button" id="backButton" onclick="window.history.back();" class="backButton"><i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i></button>
            <h1>회원가입</h1>
          </div>
        </div>

        <div class="wrapper_nickname">
          <label for="userNick" class="label-nickname">닉네임</label><br/>
          <div class="input-container">
            <input type="text" id="userNick" name="userNick" class="inputNick" onchange="nextPageck()" maxlength="20" placeholder="한글/영문 2~20자 이내로 입력"><br/>
            <div class="icon-container">
              <button type="button" class="btnClearNick"><i id="nickname-clear" class="fa-solid fa-circle-xmark fa-xl" style="color: #9297a0;"></i></button>
            </div>
          </div>
          <button type="button" class="autoNick" onclick="generateRandomNickname()">자동생성<i class="fa-solid fa-arrow-rotate-left fa-flip-horizontal" style="color: #98A4B7;"></i></button>
          <span id="checkNick"></span>
        </div>

        <div class="footer">
          <div class="progress-bar"></div>
          <button type="submit" id="next-btn" name="next" class="next-btn" value="4" disabled="disabled">다음</button>
        </div>
      </div>
    </div>
  </form>
</body>
</html>