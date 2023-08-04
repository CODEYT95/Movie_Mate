<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
 <title>Movie Mate | 공지사항 작성</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/notice/write_notice.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <style>
    .swal2-popup {
      background-color: #3b4869;
    }
    .swal2-title, .swal2-content {
      color: #efefef;
    }
    </style>
  <script>

	
  $(document).ready(function () {

	  $('#no-line-breaks').on('input', function () {
		  //줄바꿈을 ''으로 대체하여 줄바꿈을 제거
		  var content = $(this).val();
		  content = content.replace(/\n/g, '');
		  $(this).val(content);
		});
	  
  	  var imageCount = 0; // 업로드된 이미지 개수를 저장하는 변수
  	  var maxImageCount = 5; // 최대 업로드 가능한 이미지 개수

  	  function updateImageCount() {
  	    $('.files-count').text(imageCount + '/' + maxImageCount);
  	    // 이미지 개수를 표시하는 요소에 업데이트된 이미지 개수를 텍스트로 적용합니다.
  	  }

  	  function handleFileSelect(event) {
  	    var files = event.target.files;
  	    var remainingSlots = maxImageCount - imageCount;
  	    // 남은 슬롯(업로드 가능한 이미지 개수)을 계산합니다.

  	    for (var i = 0; i < Math.min(files.length, remainingSlots); i++) {
  	      // 업로드 가능한 슬롯 개수와 실제 업로드할 이미지 개수 중 작은 값을 사용하여 반복합니다.
  	      var file = files[i];
  	      var reader = new FileReader();

  	      reader.onload = function (e) {
  	        var image = $('<img>').attr('src', e.target.result);
  	        // FileReader를 사용하여 이미지를 읽고, 이미지 요소를 생성합니다.
  	        $('.main-writer').append(image);
  	        imageClickListener();
  	        // 이미지가 로드되면 이미지를 표시하고, 클릭 이벤트 리스너를 추가합니다.
  	      }

  	      reader.readAsDataURL(file);
  	      // 선택한 파일을 읽습니다.
  	      imageCount++;
  	      updateImageCount();
  	      // 이미지 카운트를 증가시키고, 업데이트된 이미지 카운트를 표시합니다.
  	    }

  	    if (files.length > maxImageCount) {
  	      alert('이미지는 최대 ' + maxImageCount + '개까지만 업로드할 수 있습니다.');
  	      // 최대 업로드 가능한 개수를 초과한 이미지가 있는 경우 알림을 표시합니다.
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
  	  
      function updateButtonColor() {
          var title = $('textarea[name="title"]').val().trim();
          var content = $('.main-writer').text().trim();

          var btnSave = $('.btn');
          if (title !== '' && content !== '') {
            btnSave.css({ background: '#4263eb', color: '#efefef' });
          } else {
            btnSave.css({ background: '', color: '' });
          }
        }

        // Attach event listeners to the title and main-writer elements
        $('textarea[name="title"], .main-writer').on('input', function () {
          updateButtonColor();
        });

  	  
      $('.btn').click(function (event) {
          event.preventDefault(); // 기본 동작 중지

          var title = $('textarea[name="title"]').val();
          var content = $('.main-writer').html(); // Use .html() to get the HTML content
          var imageCount = $('.main-writer img').length;

          if (title.trim() === '' || (content.trim() === '' && imageCount === 0)) {
        	  	alert('제목과 내용은 반드시 입력되어야 합니다.');
              return; // 폼 제출 중지
          }

          // Set the content as the value of the hidden input field
          $('#contentField').val(content);

          // Serialize the form data (including the hidden field for content)
          var formData = $('#insertForm').serialize();

          // AJAX call inside the button click event handler
          $.ajax({
        	    type: "POST",
        	    url: "${pageContext.request.contextPath}/InsertNoticeController", 
        	    data: formData, 
        	    dataType: 'json',
        	    success: function (notice) {
        	        Swal.fire(
        	      		  '저장되었습니다!',
        	      		  'You clicked the button!',
        	      		  'success'
        	      		)
        	        window.location.href = "${pageContext.request.contextPath}/ReadNoticeDetailController?no="+notice;
        	    },
        	});
      });
  });
  </script>

</head>
<body>
<form id="insertForm" action="${pageContext.request.contextPath}/ReadNoticeDetailController" method="get">
  <div id="root">
    <main id="contents">
      <section class="fixed-area">
        <header class="header-wrap">
          <h1 class="header-title">공지사항</h1>
          <div class="left">
           <a href="${pageContext.request.contextPath}/noticeBoardController"></a>
            <button class="back-btn" >
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
              <textarea id="no-line-breaks" name="title" maxlength="100" placeholder="제목을 입력해주세요." autofocus="autofocus" rows="1" style="height: 21px;"></textarea>
            </div>
          </div>
          <div class="editor-main">
            <div class="main-placeholder">
              <div class="placeholder-title"></div>
            </div>
              <div class="main-writer" contenteditable="true"></div>
          </div>
          <div class="editor-footer">
            <div class="image-upload">
              <label for="file-input" style="cursor: pointer;"><i class="fa-regular fa-image" style="color: #c3c6d1;"></i></label>
              <input hidden="hidden" id="file-input" name="image"  type="file" accept="image/gif, image/jpeg, image/png, image/webp" multiple="multiple" >
              <span class="files-count">0/5</span>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
  <input type="hidden" name="content" id="contentField"> 
</form>
</body>
</html>