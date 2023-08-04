<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
 <title></title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" /> 
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/board/write_board.css?after">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<!-- 스페이스바, 줄바꿈, 사진업로드 시 placeholder박스 지우게 하기 -->
<body>
<form id="insertForm" action="/ReadFreeDetailController" method="post">
  <div id="root">
    <main id="contents">
      <section class="fixed-area">
        <header class="header-wrap">
          <h1 class="header-title">자유게시판</h1>
          <div class="left">
            <button type="button" class="back-btn" onclick="window.history.back();">
              <i class="fa-solid fa-angle-left fa-xl" style="color:#efefef" id="icon"></i>
            </button>
          </div>
            <div class="header-button">
            <button type="submit" class="btn">저장</button>
            </div>
        </header>
      </section>
      <div class="content-area">
        <div class="post-editor">
          <div class="editor-header">
            <div class="textarea1">
              <textarea name="title" maxlength="100" placeholder="제목을 입력해주세요." autofocus="autofocus" rows="1" style="height: 21px;"></textarea>
            </div>
          </div>
          <div class="editor-main">
            <div class="main-placeholder">
              <div class="placeholder-title"></div>
              </div>
            <div class="main-writer" id="main-writer" contenteditable="true"></div>
            <div class="placeholder">
              <textarea class="writeSpace" id="writeSpace" placeholder="본문에 #를 입력하면 작품 검색 및 등록이 가능해요. 작품이 등록된 게시글은 따로 모아 확인할 수 있어요."></textarea>
              <ul class="in_write" id="inWriteList">
                <li>• 작품 비하인드 스토리를 알고 있다면 공유해주세요!</li>
                <li>• 나만의 감상 꿀 팁이나 정보를 알려주세요!</li>
                <li>• 작품에 대해 궁금한 점이 있다면 질문을 남겨보세요!</li>
                <li>• 나만의 결말 뇌피셜을 자유롭게 풀어보세요!</li>
              </ul>
              </div>
              </div>
          
          <div class="editor-footer">
            <div class="image-upload">
              <label for="file-input" style="cursor: pointer;"><i class="fa-regular fa-image" style="color: #c3c6d1;"></i></label>
              <input id="file-input" name="image"  type="file" accept="image/gif, image/jpeg, image/png, image/webp" multiple="multiple" style="display:none;">
              <span class="files-count">0/5</span>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
  <input type="hidden" name="content" id="contentField"> 
</form>
  <script>
  $(document).ready(function () {
  	  var imageCount = 0; // 업로드된 이미지 개수를 저장하는 변수
  	  var maxImageCount = 5; // 최대 업로드 가능한 이미지 개수

  	  function updateImageCount() {
  	    $('.files-count').text(imageCount + '/' + maxImageCount);
  	    // 이미지 개수를 표시하는 요소에 업데이트된 이미지 개수를 텍스트로 적용합니다.
  	  }

  	function handleFileSelect(event) {
  	  var files = event.target.files;
  	  var remainingSlots = maxImageCount - imageCount;

  	  for (var i = 0; i < Math.min(files.length, remainingSlots); i++) {
  	    var file = files[i];
  	    var reader = new FileReader();

  	    reader.onload = function (e) {
  	      var image = $('<img>').attr('src', e.target.result);
  	      $('.main-writer').append(image);
  	      imageClickListener();
  	    }

  	    reader.readAsDataURL(file);
  	    imageCount++;
  	    updateImageCount();
  	  }

  	  if (files.length > maxImageCount) {
  	    alert('이미지는 최대 ' + maxImageCount + '개까지만 업로드할 수 있습니다.');
  	  }

  	  togglePlaceholder(); // .main-placeholder를 숨깁니다.
  	}
  	function togglePlaceholder() {
  		if (imageCount == 0) {
  		  $('.in_write').show();
  		  $('#writeSpace').show();
  		} else {
  		  $('.in_write, #writeSpace').hide();
  		}
  	}
  	  function removeImage(imageElement) {
  	    if (imageElement !== undefined && imageElement.length > 0) {
  	      imageElement.remove();
  	      imageCount--;
  	      updateImageCount();
  	      // 이미지 요소를 제거하고, 이미지 카운트를 감소시키고, 업데이트된 이미지 카운트를 표시합니다.
  	    }
  	  }

  	  $('.main-writer').on('keydown input', function (event) {
  	    // main-writer 요소에서 키다운 및 입력 이벤트를 처리합니다.
  	    if (event.type === 'keydown' && event.keyCode === 8) {
  	      // 키다운 이벤트이고 백스페이스(삭제) 키를 누른 경우 실행합니다.
  	      var sel = window.getSelection();
  	      var range = sel.getRangeAt(0);

  	      if (range.startContainer.nodeName === 'IMG') {
  	        // 선택된 텍스트 노드의 시작 컨테이너가 이미지인 경우 실행합니다.
  	        removeImage($(range.startContainer));
  	        event.preventDefault();
  	        // 이미지를 제거하고, 이벤트의 기본 동작을 취소합니다.
  	      } else if (range.startOffset === 0 && range.startContainer.previousSibling && range.startContainer.previousSibling.nodeName === 'IMG') {
  	        // 선택된 텍스트 노드의 시작 컨테이너 앞에 이미지가 있는 경우 실행합니다.
  	        removeImage($(range.startContainer.previousSibling));
  	        event.preventDefault();
  	        // 이미지를 제거하고, 이벤트의 기본 동작을 취소합니다.
  	      }
  	    } else if (event.type === 'input') {
  	      // 입력 이벤트인 경우 실행합니다.
  	      var count = $('.main-writer img').length;
  	      imageCount = count;
  	      updateImageCount();
  	      // 이미지 요소의 개수를 가져와서 이미지 카운트를 업데이트합니다.
  	    }
  	  });

  	  $('#file-input').change(function (event) {
  	    handleFileSelect(event);
  	    // 파일 입력이 변경되었을 때 핸들러 함수를 호출합니다.
  	  });
  	  
      $('.btn').click(function (event) {
          event.preventDefault(); // 기본 동작 중지

          var title = $('textarea[name="title"]').val();
          var content = $('.main-writer').html(); // Use .html() to get the HTML content
          var imageCount = $('.main-writer img').length;

          if (title.trim() === '' || (content.trim() === '' && imageCount === 0)) {
              return false; // 폼 제출 중지
          }

          // Set the content as the value of the hidden input field
          $('#contentField').val(content);

          // Serialize the form data (including the hidden field for content)
          var formData = $('#insertForm').serialize();

          // AJAX call inside the button click event handler
          $.ajax({
              type: "POST",
              url: "${pageContext.request.contextPath}/InsertFreeController", // Correct URL based on your project
              data: formData, // Send the serialized form data
              dataType: 'json',
              success: function (result) {
                  window.location.href="${pageContext.request.contextPath}/ReadFreeDetailController?no=" +result;
              },
             
          });
      });
  });
  </script>
  
<script>
$(document).ready(function () {

    function togglePlaceholder() {
  var imageCount = $('.main-writer img').length;
  var content = $('.main-writer').text().trim();

  if (imageCount == 0 && content === '') {
    $('.placeholder, .in_write, #writeSpace').show();
  } else {
    $('.placeholder, .in_write, #writeSpace').hide();
  }
}

    $('.main-writer').on('keydown input', function (event) {
      // ... Your existing main-writer event handler ...
      togglePlaceholder(); // Call the function to toggle the placeholder
      // ... Your existing code ...
    });

    // Additional event listener to handle keydown for spacebar and enter key
    $('.main-writer').on('keydown', function (event) {
      if (event.keyCode === 32 || event.keyCode === 13) {
        // Spacebar (keyCode 32) or Enter (keyCode 13) key is pressed
        togglePlaceholder(); // Call the function to toggle the placeholder
      }
    });

    function focusMainWriter() {
      $('.main-placeholder').hide(); // Hide the placeholder
      $('.main-writer').focus(); // Focus on the main-writer div
    }

    // Event listener to handle clicks on the placeholder
    $('.main-placeholder').click(focusMainWriter);

    // Function to give focus to main-writer
    function focusMainWriterOnClick() {
      $('.main-writer').focus();
    }

    // Event listener to handle clicks on #inWriteList
    $('#inWriteList').click(focusMainWriterOnClick);

    // Event listener to handle clicks on #writeSpace
    $('#writeSpace').click(focusMainWriterOnClick);
    // ... Your existing code ...
  });

</script>



</body>
</html>