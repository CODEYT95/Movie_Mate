<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.nreply.NreplyDTO"%>
<%@ page import="model.nreply.NreplyDAO"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Movie Mate | 게시글</title>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/notice/read_detail.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body>

<div id="root">
  <main id="contents">
    <section class="fixed-area">
      <header class="header-wrap">
        <div class="header-title">
          <h1>게시글 보기📝</h1>
        </div>
		<div class="left-wrap">
		    <a href="${pageContext.request.contextPath}/noticeBoardController" class="back-btn">
		        <button>
		            <i class="fa-solid fa-angle-left fa-xl" style="color:#efefef" id="icon"></i>
		        </button>
		    </a>
		</div>
        <div class="header-button">
          <button id="moreBtn"
        		<%String userNick = (String) session.getAttribute("userNick"); %>
        		<%System.out.println(userNick); %>
        		<%if(userNick != null) {%>
		<%if(!userNick.equals("관리자")) { %>
          style="display: none;"
        <%}
		}else{%>
			style="display: none";
		<%}%>
          ><i  class="fa-solid fa-ellipsis-vertical fa-xl" style="color: #ffffff;"></i></button>
        </div>
      </header>
    </section>
    <section class="content-area">
      <div class="main-content">
        <div class="section-divider">
          <div class="post-info-user">
            <div class="post-author-wrap">
              <span class="user-nickname">${memberNick}</span>
            </div>
            <div class="post-info-date">
              <span class="post-date" data-notice-regdate="${noticeRegDate}"></span>
            </div>
          </div>
          <div class="post-body">
            <h1 class="post-title">${noticeTitle}</h1>
            <div class="post-content">
              <div class="post-editor post-editor--readonly">
                <div class="post-editor-main">
                  <div class="main-writer">
                    <span id="content1">${noticeContent}</span>
                    <br>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="post-footer">
            <div class="badge">
              <i class="fa-solid fa-comment" style="color: #98a4b7;"></i>
              <span class="commentCount">${result.size()}</span>
            </div>
          </div>
        </div>
        <div class="comments-area">
          <h2 class="subtitle">댓글<span class="commentCount">${result.size()}</span></h2>
          <ul class="comment-list-wrap" id="commentList">
          <%
          	ArrayList<NreplyDTO> result = (ArrayList<NreplyDTO>) request.getAttribute("result");
          %>
          <%
          	for(NreplyDTO reply : result) {
          %>
            <li class="comment-list" >
              <div class="comment">
                <div class="comment-header">
                  <div class="left-area">
                    <span class="name" data-reply-nick="<%=reply.getMem_nick()%>"><%=reply.getMem_nick()%></span>
                  </div>
                  <div class="right-area">
                    <span class="date" data-comment-regdate="<%=reply.getNreply_regdate()%>"></span>
                    <button id="moreBtnComment" class="moreBtnComment" data-comment-no="<%=reply.getNotice_no() %>"  >
                    <i  class="fa-solid fa-ellipsis-vertical fa-l" style="color: #586a85; margin-top:2px;" onclick="test('<%=reply.getNreply_content() %>','<%=reply.getNreply_no()%>')"></i>
                    </button>
                  </div>
                </div>
                <p class="contents-area" id="content"><%=reply.getNreply_content() %></p>
              </div>
              <input id="test" style="display:none;" value="">
              <hr class="divider">
              <div class="modal-layer" id ="commentModalLayer">
			    <div class="outerModal">
			      <div class="innerModal" style="position:relative">
			        <div class="close-wrap">
			          <div class="close-mark"></div>
			        </div>
			        <ul class="contents-wrap">
			          <li><button class="modifyComment"  onclick="modifyComments()">수정하기</button></li>
			          <li><button id="deleteCommentBtn">삭제하기</button></li>
			        </ul>
			      </div>
			    </div>
			  </div>
            </li>
          <%} %>
          </ul>
        </div>
      </div>
      
      <div class="comment-input-area" id="commentInputArea">
        <form method="post" action="/ReadNoticeDetailController?no=<%= request.getAttribute("noticeNo") %>"  id="insertComment">
          <input type="hidden" name="no" value="<%= request.getAttribute("noticeNo") %>">
          <div class="input-wrap">
            <div class="textarea-wrap">
              <textarea id="commentTextarea" class="commentTextarea" name="comments" placeholder="댓글을 작성해 주세요" rows="1" class="origin"  style="--limit: 5;"></textarea>
              <div id="character-count"></div>
            </div>
            <button type="submit" class="addCommentBtn" id="addCommentBtn" name="submit" >등록</button>
            <button type="button" class="cancel" style="display: none;">취소</button>
        		<button type="submit" class="submit active"  id="submit" style="display: none;" >수정</button>
          </div>
        </form>
      </div>
      
    </section>
    	  <div class="scroll-top" style="--floatHeight:24px;">
       <button id="scrollTopBtn" class="scrollTopBtn"><i class="fa-solid fa-arrow-up fa-xl" style="color: #ffffff;"></i></button>
    </div>
  </main>
  <div class="modal-bg"></div>
  <div class="modal-layer" id="postModalLayer">
    <div class="outerModal">
      <div class="innerModal" style="position:relative">
        <div class="close-wrap">
          <div class="close-mark"></div>
        </div>
        <ul class="contents-wrap">
          <li><button onclick="modifyContents()">수정하기</button></li>
          <li><button id="deletePostBtn">삭제하기</button></li>
        </ul>
      </div>
    </div>
  </div>
  <div id="postDeleteModal" class="confirm-modal-container"> 
    <div class="confirm-modal-header">
      <h2 class="header">게시글을 삭제하시겠어요?</h2>
    </div>
    <div class="confirm-modal-body">
      <h3 class="body">등록된 댓글은 삭제되지 않습니다.</h3>
    </div>
    <div class="confirm-modal-footer">
      <div class="footer">
        <button id="postCloseButton" class="gray-btn">
          <span>뒤로가기</span>
        </button>
        <button id="postConfirmButton" class="blue-btn" onclick="deleteContents()">
          <span>삭제하기</span>
        </button>
      </div>
    </div>
  </div>
  <div id="commentDeleteModal" class="confirm-modal-container" >
    <div class="confirm-modal-header">
      <h2 class="header">댓글 삭제</h2>
    </div>
    <div class="confirm-modal-body">
      <h3 class="body">댓글을 삭제하시겠어요?</h3>
    </div>
    <div class="confirm-modal-footer">
      <div class="footer">
        <button id="commentCloseButton" class="gray-btn">
          <span>뒤로가기</span>
        </button>
        <button id="commentConfirmButton" class="blue-btn" onclick="deleteComments()">
          <span>삭제하기</span>
        </button>
      </div>
    </div>
  </div>
</div>


<script>

var sessionNick = sessionStorage.getItem('userNick');

var replyNick = document.querySelector('.name').getAttribute('data-reply-nick');

if (sessionNick !== replyNick) {
var commentNo = document.querySelector('.moreBtnComment').getAttribute('data-comment-no');
var commentButton = document.querySelector('[data-comment-no="' + commentNo + '"]');
commentButton.style.display = 'none';
}
</script>


<script>

var comment;
var num;

document.addEventListener("DOMContentLoaded", function () {
   var moreBtn = document.getElementById("moreBtn");
    var moreBtnComments = document.querySelectorAll(".moreBtnComment");
    var postModalLayer = document.getElementById("postModalLayer");
    var commentModalLayer = document.getElementById("commentModalLayer"); 
    var deletePostBtn = document.getElementById("deletePostBtn");
    var modalBg = document.querySelector(".modal-bg");
    var postDeleteModal = document.getElementById("postDeleteModal");
    var deleteCommentBtn = document.getElementById("deleteCommentBtn"); 
    var commentDeleteModal = document.getElementById("commentDeleteModal"); 
    var closeWraps = document.querySelectorAll(".close-wrap, .modal-bg");
    var modifyCommentBtn = document.querySelectorAll(".modifyComment");
    
    var commentTextarea = document.getElementById("commentTextarea");
    commentTextarea.addEventListener("input", function () {

      var addCommentBtn = document.getElementById("addCommentBtn");
      var updateBtn = document.getElementById("submit");

      if (commentTextarea.value.trim() !== '') {

        addCommentBtn.style.backgroundColor = "#4263eb";
        addCommentBtn.style.color = "#efefef";
        updateBtn.style.backgroundColor = "#4263eb";
        updateBtn.style.color = "#efefef";
      } else {

        addCommentBtn.style.backgroundColor = ""; 
        addCommentBtn.style.color = ""; 
      }
    });
    
    function showPostModal() {
        postModalLayer.style.visibility = "visible";
        modalBg.style.visibility = "visible";
        postDeleteModal.style.visibility = "hidden";
      }

     function showCommentModal() { 
       commentModalLayer.style.visibility = "visible";
       modalBg.style.visibility = "visible";
       commentDeleteModal.style.visibility = "hidden";
     }

     function hidePostModals() { 
       postModalLayer.style.visibility = "hidden";
       modalBg.style.visibility = "hidden";
       postDeleteModal.style.visibility = "hidden";
     }
     
   function hideCommentModals(){
       modalBg.style.visibility = "hidden";
       commentDeleteModal.style.visibility = "hidden";
   }
   
     moreBtn.addEventListener("click", function () {
       showPostModal();
     });

     moreBtnComments.forEach(function(moreBtnComment) {
          moreBtnComment.addEventListener("click", function() {
            showCommentModal();
          });
        });

     deletePostBtn.addEventListener("click", function () {
       postModalLayer.style.visibility = "hidden";
       modalBg.style.visibility = "visible";
       postDeleteModal.style.visibility = "visible";
       commentDeleteModal.style.visibility = "hidden"; 
     });
     
     if (deleteCommentBtn) {
     	deleteCommentBtn.addEventListener("click", function () { 
	       postModalLayer.style.visibility = "hidden";
	       commentModalLayer.style.visibility = "hidden";
	       modalBg.style.visibility = "visible";
	       postDeleteModal.style.visibility = "hidden";
	       commentDeleteModal.style.visibility = "visible";
	    });
     }
     
     var postCloseButton = document.getElementById("postCloseButton");
     postCloseButton.addEventListener("click", function () {
       hidePostModals();
     });

     var commentCloseButton = document.getElementById("commentCloseButton");
     commentCloseButton.addEventListener("click", function () {
    	commentModalLayer.style.visibility = "hidden";
       	hideCommentModals();
     });

     closeWraps.forEach(function (closeWrap) {
       closeWrap.addEventListener("click", function () {
    	  commentModalLayer.style.visibility = "hidden";
          hidePostModals();
          hideCommentModals();
       });
     });
 });
 

  function modifyContents() {
 	  // 게시물 수정 페이지로 이동
 	  var noticeNo = <%= request.getAttribute("noticeNo") %>;
 	  var contextPath = "${pageContext.request.contextPath}";
 	  var url = contextPath + "/UpdateNoticeController?no=" + noticeNo;
 	  window.location.href = url;
  }
  //게시물 삭제
  function deleteContents(){
	 
	  var no= $("input[name='no']").val();
	  
	  $.ajax({
		    type: "POST",
		    url: "${pageContext.request.contextPath}/DeleteNoticeController",
		    data: { no: no, n_isshow: 'N' },
		    success: function(response) {
		    	alert("게시글이 삭제되었습니다.");
		      window.location.href = "${pageContext.request.contextPath}/noticeBoardController";
		    },
		    error: function(xhr, status, error) {
		    	console.log("게시글삭제 실패");
		    	alert("게시글 삭제 실패.");
		    }
		  });
  }
  
  //댓글입력
   $('.addCommentBtn').click(function (event) {
       event.preventDefault(); // 기본 동작 중지

       var noticeNo = $('input[name="no"]').val();
       var contents = $('textarea[name="comments"]').val();
       console.log(contents);

       if (contents.trim() === '' ) {
     	  	alert('댓글을 입력해주세요.');
     	  	commentTextarea.value = "";
           return; // 폼 제출 중지
       }

       var formData = $('#insertComment').serialize();

       $.ajax({
     	    type: "POST",
     	    url: "${pageContext.request.contextPath}/InsertNoticeReplyController", 
     	    data: formData, 
     	    dataType: 'json',
     	    success: function (reply) {
     	    	window.location.reload();
     	    	
     	    	var commentCount = reply.length;
              $('.commentCount').text(commentCount);

     	    },
     	});
   });

  //댓글 수정
function test(content,rno) {
	comment = content; // 변수 선언에 `var` 사용
	num = rno;
	
	console.log("rno"+num);
}

  
  function modifyComments() {
	  
    document.querySelector(".addCommentBtn").style.display = "none";
    document.querySelector(".cancel").style.display = "block";
    document.querySelector(".submit").style.display = "block";
    document.getElementById("commentTextarea").value = comment;

    document.getElementById("commentModalLayer").style.visibility = "hidden";
    document.querySelector(".modal-bg").style.visibility = "hidden";
    
    $('.submit').click(function(event) {
        event.preventDefault();
        
        var editedContent = $('#commentTextarea').val();
        console.log("Edited Content:", editedContent);

        if (editedContent.trim() === '') {
          alert('댓글을 입력해주세요.');
          commentTextarea.value = "";
          return;
        }

        if (editedContent.trim() === comment.trim()) {
          alert('기존 내용과 동일합니다.');
          return;
        }

        $.ajax({
          type: "POST",
          url: "${pageContext.request.contextPath}/UpdateNoticeReplyController",
          data: {
            rno: num,
            content: editedContent
          },
          dataType: 'json',
          success: function() {
            window.location.reload(); 
          },
          error: function() {
            alert('댓글 수정 실패');
          },
        });
      });
    
  }
  
  //댓글삭제
  function deleteComments(){
	  var rno = num;
	  var no = $('input[name="no"]').val();
	  
    $.ajax({
		    type: "POST",
		    url: "${pageContext.request.contextPath}/DeleteNoticeReplyController",
		    data: { no: no, rno: rno, nr_isshow: 'N' },
		    success: function(response) {
		     	window.location.reload();
		    },
		    error: function() {
		      alert("댓글 삭제에 실패했습니다.");
		    }
		  });
  }
  
	  function showCommentInputArea() {
	    document.querySelector(".addCommentBtn").style.display = "block";
	    document.querySelector(".cancel").style.display = "none";
	    document.querySelector(".submit").style.display = "none";
	    document.getElementById("commentTextarea").value = ""; 
	  }

	  var cancelButton = document.querySelector(".cancel");
	  cancelButton.addEventListener("click", function () {
	    showCommentInputArea();
	  });
</script>

<script>
var commentTextarea = document.getElementById("commentTextarea");
var maxCharacters = 400;

commentTextarea.addEventListener("input", function() {
  var currentCharacters = commentTextarea.value.length;

  if (currentCharacters > maxCharacters) {
    commentTextarea.value = commentTextarea.value.slice(0, maxCharacters);
  }

  
  commentTextarea.style.overflow = "hidden";
  commentTextarea.style.height = "auto";
  commentTextarea.style.height = commentTextarea.scrollHeight + "px";
  commentTextarea.style.overflow = "auto";
});

$('#commentTextarea').on('input', function() {
    updateCharacterCount($(this).val());
    validateInput();
  });

 function updateCharacterCount(text) {
   var characterCount = text.length;
   var characterLimit = 400;

   if (characterCount > characterLimit) {
     text = text.slice(0, characterLimit);
     characterCount = characterLimit;
   }

   $('#character-count').text(characterCount + '/' + characterLimit);
 }

 function validateInput() {
   var text = $('#commentTextarea').val();
   var characterCount = text.length;
   var characterLimit = 400;

   if (characterCount > characterLimit) {
     text = text.slice(0, characterLimit);
     $('#commentTextarea').val(text);
   }
 }
function scrollTextarea() {
     var textarea = document.getElementById('commentTextarea');
     textarea.scrollTop = textarea.scrollHeight;
   }

</script>
<script>

 <%-- 날짜 --%>
 function timeSince(date) {
   var seconds = Math.floor((new Date() - new Date(date)) / 1000);

   if (seconds < 60) {
     return "방금 전";
   }

   var minutes = Math.floor(seconds / 60);
   if (minutes < 60) {
     return minutes + "분 전";
   }

   var hours = Math.floor(minutes / 60);
   if (hours < 24) {
     return hours + "시간 전";
   }

  /*
   .toISOString(): Date 개체에서 호출되며 ISO 8601 표준에 정의된 형식으로 날짜를 나타내는 문자열을 반환
   "yyyy-MM-ddTHH:mm:ss.sssZ" => "T"는 날짜와 시간을 구분하고 "Z"는 Zulu 시간대(UTC)
    .slice(0, 10): toISOString()에 의해 반환된 ISO 문자열에서 지정된 인덱스를 기반으로 문자열의 일부를 추출
    시작 인덱스로 0, 종료 인덱스(제외)로 10을 제공 =  "yyyy-MM-dd" 부분에 해당
    return formattedDate;: 이 함수는 추출된 "yyyy-MM-dd" 형식의 날짜를 문자열로 반환
  */
    var formattedDate = new Date(date).toISOString().slice(0, 10);
    return formattedDate;
  }

  var postDateElement = document.querySelector(".post-date");
  var postDate = new Date(postDateElement.getAttribute("data-notice-regdate"));
  postDateElement.textContent = timeSince(postDate);

  var commentDateElements = document.querySelectorAll(".date");
  commentDateElements.forEach((commentDateElement) => { 
    var commentDate = new Date(commentDateElement.getAttribute("data-comment-regdate"));
    commentDateElement.textContent = timeSince(commentDate);
  });
</script>

<script>
window.addEventListener("scroll", function() {
	  var scrollTopButton = document.getElementById("scrollTopBtn");

	  if (window.pageYOffset > 300) {
	    scrollTopButton.style.display = "block";
	  } else {
	    scrollTopButton.style.display = "none";
	  }
	});

	function smoothScrollToTop() {
	  window.scrollTo({
	    top: 0,
	    behavior: "smooth"
	  });
	}

	var scrollTopButton = document.getElementById("scrollTopBtn");
	scrollTopButton.addEventListener("click", smoothScrollToTop);

  </script>
</body>
</html>