<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/join/joinView6.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script>
$(document).ready(function() {
	  // 체크박스 개수를 세는 변수
	  var checkboxCount = 0;
	  var nextButton = document.getElementById("next-btn");
	  
	  // 체크박스 변경 시 이벤트 핸들러
	  $('.ks-cboxtags input[type="checkbox"]').change(function() {
	    // 체크된 체크박스 개수를 업데이트
	    checkboxCount = $('.ks-cboxtags input[type="checkbox"]:checked').length;

	    // 체크된 체크박스 개수가 3개 이상이면 다음 버튼을 활성화, 아니면 비활성화
	    if (checkboxCount >= 3) {
	    	nextButton.disabled = false;
	        nextButton.style.backgroundColor = "RGB(66, 99, 235)";
	        nextButton.style.border = "1px solid RGB(66, 99, 235)";
	        nextButton.style.cursor = "pointer";
	        
	        // 체크된 체크박스 개수가 3개 이상일 경우 추가적인 체크를 막음
	        $('.ks-cboxtags input[type="checkbox"]:not(:checked)').prop('disabled', true);
	    } else {
	    	nextButton.disabled = true;
	        nextButton.style.backgroundColor = "RGB(59, 72, 105)";
	        nextButton.style.border = "1px solid RGB(59, 72, 105)";
	        nextButton.style.cursor = "default";
	        
	        // 체크된 체크박스 개수가 3개 미만일 경우 모든 체크박스를 활성화
	        $('.ks-cboxtags input[type="checkbox"]').prop('disabled', false);
	    }
	  });
	  
	  $('.next-btn').click(function() {
	        if(<%=session.getAttribute("join_name")%> == null){
	        	alert("회원가입을 처음부터 진행해주세요.")
	        	location.href="loginController";
	        }
	    });
	  
	});
	
</script>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
%>
</head>

<body>	
  <form id="join6" action="joinController" method="post">
    <div class="layout">
      <div class="content">
        <div class="sub_header">
          <div class="sub_inner">
            <button type="button" id="backButton" onclick="window.history.back();" class="backButton"><i class="fa-solid fa-chevron-left fa-xl" style="color: RGB(255, 255, 255)"></i></button>
            <h1>회원가입</h1>
          </div>
        </div>
        <div class="text_wrap">
          <h3 class="title">관심 카테고리</h3>
        </div>

        <div class="allCheck">
          <label class="checkbox-label" style="color: #EFEFEF;">관심있는 장르 3가지를 선택 해주세요.<br></label>
        </div>
        <hr class="line" style="color:#25304A">
        <div class="check">
          <div class="container">
            <ul class="ks-cboxtags">
          		<li><input type="checkbox"  name="genre[]" id="checkAction"   value="액션"><label for="checkAction">액션</label></li>
          		<li><input type="checkbox"  name="genre[]" id="checkCrime"    value="범죄"><label for="checkCrime">범죄</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkSF"       value="SF"><label for="checkSF">SF</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkComedy"   value="코미디"><label for="checkComedy">코미디</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkAni"      value="애니메이션"><label for="checkAni">애니메이션</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkRomance"  value="멜로/로맨스"><label for="checkRomance">멜로/로맨스</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkThriller" value="스릴러"><label for="checkThriller">스릴러</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkHorror"   value="공포(호러)"><label for="checkHorror">공포</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkWar"      value="전쟁"><label for="checkWar">전쟁</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkSports"   value="스포츠"><label for="checkSports">스포츠</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkFantasy"  value="판타지"><label for="checkFantasy">판타지</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkMusic"    value="음악"><label for="checkMusic">음악</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkMusical"  value="뮤지컬"><label for="checkMusical">뮤지컬</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkMystery"    value="미스터리"><label for="checkMystery">미스터리</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkhistory"    value="사극"><label for="checkhistory">사극</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkAdventure"    value="어드벤처"><label for="checkAdventure">어드벤처</label></li>
          		<li><input type="checkbox"  name="genre[]"  id="checkfamily"    value="가족"><label for="checkfamily">가족</label></li>
         	 	<li><input type="checkbox"  name="genre[]"  id="checkDrama"    value="드라마"><label for="checkDrama">드라마</label></li>
        	</ul>
          </div>
        </div>

        <div class="footer">
          <div class="progress-bar"></div>
          <button type="submit" id="next-btn" name="next" class="next-btn" value="7" disabled="disabled">완료</button>
        </div>
      </div>
    </div>
  </form>
</body>
</html>