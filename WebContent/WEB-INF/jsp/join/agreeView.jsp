<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원가입</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/join/agreeView.css?after">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

   <script>
    $(document).ready(function() {
      // 모두 동의 체크박스가 클릭되면 나머지 체크박스들도 함께 선택/해제되도록 처리
      $("#all_checkbox").click(function() {
        $(".checkbox").prop("checked", this.checked);
      });

      // 모두 동의 체크박스와 나머지 체크박스들의 상태를 모니터링하여 모두 체크되면 모두 동의 체크박스도 체크되도록 처리
      $(".checkbox").click(function() {
        if ($(".checkbox:checked").length === $(".checkbox").length) {
          $("#all_checkbox").prop("checked", true);
        } else {
          $("#all_checkbox").prop("checked", false);
        }
      });
      
      $('.all_checkbox').click(function() {
    	    var allChecked = $(this).is(":checked");
    	    var nextButton = document.getElementById('next-btn');
    	    // 전체 동의 체크박스가 체크되어 있으면 버튼 활성화
    	    if (allChecked) {
    	    	 $("#next-btn").prop("disabled", false);
    	          nextButton.style.backgroundColor = 'RGB(66, 99, 235)';
    	          nextButton.style.border = '1px solid RGB(66, 99, 235))';
    	          nextButton.style.cursor = 'pointer';
    	    }
    	    // 그렇지 않으면 버튼 비활성화
    	    else {
    	    	$("#next-btn").prop("disabled", true);
    	          nextButton.style.backgroundColor = 'RGB(59, 72, 105)';
    	          nextButton.style.border = '1px solid RGB(59, 72, 105)';
    	          nextButton.style.cursor = 'default';
    	    }
    	  });
      
      // 체크박스들이 활성화되면 다음 버튼 활성화 처리
      $(".checkbox").click(function() {
    	  var nextButton = document.getElementById('next-btn');
        if ($(".checkbox:checked").length === $(".checkbox").length) {
          $("#next-btn").prop("disabled", false);
          nextButton.style.backgroundColor = 'RGB(66, 99, 235)';
          nextButton.style.border = '1px solid RGB(66, 99, 235))';
          nextButton.style.cursor = 'pointer';
        } else {
          $("#next-btn").prop("disabled", true);
          nextButton.style.backgroundColor = 'RGB(59, 72, 105)';
          nextButton.style.border = '1px solid RGB(59, 72, 105)';
          nextButton.style.cursor = 'default';
        }
      });
    });
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
      <div class="box">
        <div class="text_wrap">
          <h3 class="title">약관 동의</h3>
          <span class="agree">
            가입을 하시려면 다음의 정책에 대한<br>
            동의가 필요합니다.
          </span>
        </div>
      </div>
      <div class="checkBox">
      <div class="allCheck">
        <input type="checkbox" id="all_checkbox" class="all_checkbox">
        <label for="all_checkbox" class="checkbox-label" style="color: #EFEFEF;">모두 동의합니다.</label>
      </div>
      <hr class="line" style="color: green;">
      <div class="check">
        <div class="1_checkbox">
          <input type="checkbox" id="1_checkbox" class="checkbox">
          <label for="1_checkbox" class="checkbox-label" style="color: #EFEFEF;">[필수] 이용약관에 동의합니다.</label>
          <button type="button" class="viewBtn1" onclick="location='termsController'">보기</button>
        </div>
        <div class="2_checkbox">
          <input type="checkbox" id="2_checkbox" class="checkbox">
          <label for="2_checkbox" class="checkbox-label" style="color: #EFEFEF;">[필수] 개인정보 수집 및 이용에 동의합니다.</label>
          <button type="button" class="viewBtn2" onclick="location='privacyController'">보기</button>
        </div>
        <div class="3_checkbox">
          <input type="checkbox" id="3_checkbox" class="checkbox">
          <label for="3_checkbox"class="checkbox-label" style="color: #EFEFEF;">[필수] 본인은 만 14세 이상입니다.</label>
        </div>
      </div>
      </div>
     <div class="footer">
    <div class="progress-bar">
   </div><button type="submit" id="next-btn"  name="next" class="next-btn"  value="1" disabled="disabled">다음</button>
  </div>
 </div>
</div>
</form>
</body>
</html>
