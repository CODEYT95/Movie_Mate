<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원탈퇴</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/setting/withdrawal2.css?after">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script>
var checkboxCount = 0; // 체크박스 선택 수
var agreeChecked = false; // 동의 체크 여부


$(document).ready(function() {
//체크박스 상태 변경 시 이벤트 핸들러
$(".reason-list input[type='checkbox'], #agree").on('click', function() {
    // 체크박스 선택 수 업데이트
    checkboxCount = $('.reason-list input[type="checkbox"]:checked').length;
    // 동의 체크 여부 업데이트
    agreeChecked = $("#agree").is(":checked");

    // 체크박스 개수가 0개이고, 동의 체크박스가 체크된 경우
    if (checkboxCount === 0 && agreeChecked) {
        // 동의 체크박스 해제
         $(".confirm-modal").css("display", "table");
        $("#agree").prop("checked", false);
        // 동의 체크 여부 업데이트
        agreeChecked = false;
    }

    // 체크박스 개수가 1개 이상인 경우
    if (checkboxCount >= 0) {
        // 동의 체크박스 체크 가능
        $("#agree").prop("disabled", false);
    } else {
        // 동의 체크박스 체크 불가능
        $("#agree").prop("disabled", true);
        $(".next-btn").css('background-color', 'RGB(59, 72, 105)');
	    $(".next-btn").css('border','1px solid RGB(59, 72, 105)');
	    $(".next-btn").css('cursor','default');
        // 동의 체크박스 해제
        $("#agree").prop("checked", false);
        // 동의 체크 여부 업데이트
        agreeChecked = false;
    }
});



	// 확인 버튼 클릭 시 모달창 닫기
	$(".modal-button-wrap").on("click", function() {
	  $(".confirm-modal").css("display", "none");

	  // 동의 체크박스 해제
	  $("#agree").prop("checked", false);
	  // 동의 체크 여부 업데이트
	  agreeChecked = false;
	});

	if(agreeChecked){
		$(".next-btn").prop();
	}

	$("#agree").on("change", function() {

		var userNick="<%=session.getAttribute("userNick")%>";
		console.log(userNick);
		
		  if ($(this).is(":checked") && userNick != "null") {
		    $(".next-btn").prop("disabled", false);
		    $(".next-btn").css('background-color', 'RGB(66, 99, 235)');
		    $(".next-btn").css('border','1px solid RGB(66, 99, 235)');
		    $(".next-btn").css('cursor','pointer');
		  } else {
		    $(".next-btn").prop("disabled", true);
		    $(".next-btn").css('background-color', 'RGB(59, 72, 105)');
		    $(".next-btn").css('border','1px solid RGB(59, 72, 105)');
		    $(".next-btn").css('cursor','default');
		  }
		});
});
</script>
<script>
$(document).ready(function() {
	  // textarea 요소의 최대 글자 수
	  var maxLength = 200;

	  // textarea 요소에 입력한 글자 수를 카운트하여 보여주는 함수
	  function countCharacters() {
	    // textarea 요소에 입력된 글자 수
	    var currentLength = $(".reason-content").val().length;

	    // 현재 입력한 글자 수를 보여주는 메시지
	    var message = currentLength + "/" + maxLength;

	    $(".content-count").text(message);

	    // 글자 수가 최대 글자 수를 초과하는 경우에는 입력을 제한
	    if (currentLength > maxLength) {
	      $(".reason-content").val($(".reason-content").val().substring(0, maxLength));
	    }
	  }

	  // textarea 요소에 입력 값이 변경될 때마다 글자 수를 카운트
	  $(".reason-content").on("input change", countCharacters);

	  // '기타' 체크박스가 체크되면, textarea 요소에 포커스를 준다.
	  $("#reason-3").on("change", function() {
	    if ($(this).is(":checked")) {
	      // textarea 요소에 포커스 주기
	      $(".reason-content").focus();
	    }
	  });

	  $(".reason-content").keyup(function(e) {
		  var val = e.currentTarget.value.trim();

		  if (val.length > 0) {
		    $("#reason-3").prop("checked", true);
		    $("#reason-3").prop("disabled", true);
		  } else {
		    $("#reason-3").prop("checked", false);
		    $("#reason-3").prop("disabled", false);
		    $("#agree").prop("checked", false);
		  }
		});
	});

</script>


</head>
<body>
<form action="withdrawalController" method="post">
	<div class="layout">
		<div class="content">
			<div class="sub_header">
				<div class="sub_inner">
					<button type="button" id="backButton" onclick="window.history.back();" class="backButton">
						<i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i>
					</button>
					<h1>회원 탈퇴</h1>
				</div>
			</div>
			<div class="wrapper">
				<div class="content-wrap">
					<div class="title-wrap">
						<h4>회원님의 <b>탈퇴 사유</b>를 선택해 주세요.</h4>
						<span>(다중 선택 가능)</span>
					</div>
					<div class="reason-list">
						<div class="check-item">
							<span>
								<input type="checkbox" id="reason-0" value="자주 사용하지 않아서">
								<label for="reason-0" class="checker"></label>
							</span>
							<span class="check-text">
								<label for="reason-0">자주 사용하지 않아서</label>
							</span>
						</div>
						<div class="check-item">
							<span>
								<input type="checkbox" id="reason-1" value="중복 계정이 있어서">
								<label for="reason-1" class="checker"></label>
							</span>
							<span class="check-text">
								<label for="reason-1">중복 계정이 있어서</label>
							</span>
						</div>
						<div class="check-item">
							<span>
								<input type="checkbox" id="reason-2" value="사용성(UI/UX)이 불편해서">
								<label for="reson-2" class="checker"></label>
							</span>
							<span class="check-text">
								<label for="reason-2">사용성(UI/UX)이 불편해서</label>
							</span>
						</div>
						<div class="check-item">
							<span>
								<input type="checkbox" id="reason-3" value="기타">
								<label for="reson-3" class="checker"></label>
							</span>
							<span class="check-text">
								<label for="reason-3">기타</label>
							</span>
						</div>
						<div class="reasonWrite-wrap">
							<span class="content-count" >0/200</span>
							<textarea class="reason-content" placeholder="위 항목 외의 탈퇴 사유를 자유롭게 작성해 주세요."></textarea>
						</div>
					</div>
					<div class="divider"></div>
					<div class="terms">
						<h4>반드시 아래 사항을 꼼꼼하게 확인하신 후<br><b>탈퇴 하기</b>를 눌러 주세요.</h4>
						<p>탈퇴 시 회원님의 개인정보는 즉시 삭제됩니다.</p>
						<p>회원정보 및 개인형 서비스의 데이터 역시 모두 삭제 됩니다.</p>
						<p>회원님의 삭제된 데이터는 복구할 수 없습니다.</p>
					</div>
					<div class="check-item">
						<span>
							<input type="checkbox" id="agree" class="agree">
							<label for="agree" class="checker"></label>
						</span>
						<span class="check-text">
							<label for="agree">위 내용을 모두 확인하였으며, 이에 동의합니다.</label>
						</span>
					</div>
					<div class="confirm-modal">
						<div class="confirm-modal-wrapper">
							<div class="confirm-modal-container">
								<div class="confirm-modal-header">
									<h4>탈퇴 사유를 <b>1개 이상</b> 선택해 주세요.</h4>
								</div>
								<div class="confirm-modal-body">
									<span></span>
								</div>
								<div class="confirm-modal-footer">
									<div class="modal-button-wrap">
										<button type="button" class="primary-btn">
											<span class="text">확인</span>
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="footer">
					<button type="submit" class="next-btn" disabled="disabled">탈퇴 하기</button>
				</div>
				<header class="header">
					<nav class="navi">
						<a class="navi_a" title="home" href="/"><i class="navi-i fa-solid fa-house fa-xl"></i><br>
							<span>홈</span></a>
						<a class="navi_a" title="search" href="/search"><i class="navi-i fa-sharp fa-solid fa-magnifying-glass fa-xl"></i><br>
							<span>발견</span></a>
						<a class="navi_a" title="community" href="/community/feed"><i class="navi-i fa-solid fa-comment-dots fa-flip-horizontal fa-xl"></i><br>
							<span>커뮤니티</span></a>
						<a class="navi_a" title="myPage" href="${pageContext.request.contextPath}/myPageController"><i class="navi-i fa-solid fa-user fa-xl"></i><br>
							<span>마이페이지</span></a>
					</nav>
				</header>
			</div>
		</div>
	</div>
	</form>
</body>
</html>
