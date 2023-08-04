<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.member.memberDto"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/select_member.css">
  <title>회원조회</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
    var currentPage = 2;

    $(document).ready(function () {
        loadMoreData();

        $(window).scroll(function () {
            if ($(window).scrollTop() + $(window).height() >= $(document).height()) {
                
                loadMoreData();
            }
        });
    });

    function loadMoreData() {
        console.log("아작스 들어옴");
        
        $.ajax({
            url: 'SelectMemberController',
            method: 'GET',
            data: { currentPage: currentPage },
            dataType: 'html',
            success: function (data) {
                if (data.trim() !== '') {
                    $('.client-wrapper ul').append($(data).find('ul').children());

                    currentPage++;
                }
            },
            error: function (xhr, status, error) {
                console.log('Error occurred while fetching more data:', error);
            }
        });
    }
</script>
</head>
<body>
  <div id="root">
    <main id="contents">
      <section class="fixed-area">
        <header class="header-wrap">
          <div class="header-title">
            <h1>회원조회👀</h1>
          </div>
			<div class="left-wrap">
			  <a href="${pageContext.request.contextPath}/AdminMainController">
			    <button class="back-btn">
			      <i class="fa-solid fa-angle-left fa-2xl" style="color: #efefef"></i>
			    </button>
			  </a>
			</div>
          <div class="search">
            <div class="input-wrapper">
              <i class="fa-solid fa-magnifying-glass fa-lg" style="color: #ffffff;"></i>
              <input type="search" class="search-input" id="search" name="search" placeholder="ID 입력" oninput="searchMember()">
            </div>
          </div>
        </header>
      </section>
      <section class="profile-info-area">
        <div class="client-info-wrap">
          <div class="client-wrapper">
            <p id="mem-value"></p>
            <%
              ArrayList<memberDto> member = (ArrayList<memberDto>) request.getAttribute("memberList");
              for(memberDto mDto : member) {
            %>
            <ul>
              <li>
                <div class="info-header">
                  <div class="deleteBtn">
                    <button onclick="showModal('<%=mDto.getM_id()%>')">
                      <i class="fa-solid fa-user-minus fa" style="color: #ffffff;"></i>
                    </button>
                  </div>
                </div>
              </li>
              <li>
                <div class="id-nick">
                  <div class="input-id">
                    <label class="input-label">ID</label>
                    <input type="text" value="<%=mDto.getM_id()%>" class="primary-dark-input" readonly="readonly">
                  </div>
                  <div class="input-nick">
                    <label class="input-label">닉네임</label>
                    <input type="text" value="<%=mDto.getM_nick()%>" class="primary-dark-input" readonly="readonly">
                  </div>
                </div>
              </li>
              <li>
                <div class="name-birth">
                  <div class="input-name">
                    <label class="input-label">이름</label>
                    <input type="text" value="<%=mDto.getM_name()%>" class="primary-dark-input" readonly="readonly">
                  </div>
                  <div class="input-birth">
                    <label class="input-label">생년월일</label>
                    <input type="text" value="<%=mDto.getM_birth()%>" class="primary-dark-input" readonly="readonly">
                  </div>
                </div>
              </li>
              <li>
                <div class="email-gender">
                  <div class="input-email">
                    <label class="input-label">이메일</label>
                    <input type="text" value="<%=mDto.getM_email()%>" class="primary-dark-input" readonly="readonly">
                  </div>
                  <div class="input-gender">
                    <label class="input-label">성별</label>
                    <input type="text" value="<%=mDto.getM_gender()%>" class="primary-dark-input" readonly="readonly">
                  </div>
                </div>
              </li>
              <li>
                <div class="address-temp">
                  <div class="input-address">
                    <label class="input-label">주소</label>
                    <input type="text" value="<%=mDto.getM_address()%>" class="primary-dark-input" readonly="readonly">
                  </div>
                  <div class="input-temp">
                    <label class="input-label">온도</label>
                    <input type="text" value="<%=mDto.getM_temp()%>" class="primary-dark-input" readonly="readonly">
                  </div>
                </div>
                <hr class="divider">
              </li>
            </ul>
            <div id="memDeleteModal" class="confirm-modal-container">
              <div class="confirm-modal-header">
                <h2 class="header">회원을 삭제하시겠어요?</h2>
              </div>
              <div class="confirm-modal-body">
                <h3 class="body">돌이킬 수 없어요!</h3>
              </div>
              <div class="confirm-modal-footer">
                <div class="footer">
                  <button id="closeButton" class="gray-btn">
                    <span>뒤로가기</span>
                  </button>
                  <button id="confirmButton" class="blue-btn" onclick="deleteMember('<%=mDto.getM_id()%>')">
                    <span>삭제하기</span>
                  </button>
                </div>
              </div>
            <%  } %>
            </div>
          </div>
        </div>
      </section>
    </main>
    <div class="modal-bg"></div>
  </div>
</body>
  <script>
    function showModal(memberId) {
      console.log(memberId);
      document.querySelector('.modal-bg').style.visibility = 'visible';
      document.querySelector('#memDeleteModal').style.visibility = 'visible';
    }

    function hideModal() {
      document.querySelector('.modal-bg').style.visibility = 'hidden';
      document.querySelector('#memDeleteModal').style.visibility = 'hidden';
    }

    var deleteBtns = document.querySelectorAll('.deleteBtn button');
    if (deleteBtns) {
      deleteBtns.forEach(function (btn) {
        btn.addEventListener('click', showModal);
      });
    }

    var closeButton = document.querySelector('#closeButton');
    if (closeButton) {
      closeButton.addEventListener('click', hideModal);
    }
    document.querySelector('.modal-bg').addEventListener('click', hideModal);

    function deleteMember(memberId) {
      hideModal();
      console.log("Ajax ID" + memberId);
      // Ajax request to delete member
      $.ajax({
        url: 'DeleteMemberController',
        method: 'POST',
        data: { memberId: memberId },
        success: function (data) {
          console.log(memberId);
          // page reload when ajax request is successfully processed
          window.location.reload();
          // For example display deletion success message, update member list, etc.
          alert('The member has been deleted.');
        },
        error: function (xhr, status, error) {
          // Create action when Ajax request fails
          alert('Failed to delete member!');
        },
      });
    }

    function clearSearchResults() {
      $('.client-wrapper ul').remove(); // Delete the ul element.
      $('.search-empty').empty(); // Delete the no search results message.
      $("#mem-value").empty();
    }

    function searchMember() {
      var searchTerm = document.getElementById('search').value;
      if (searchTerm.trim() === '') {
        clearSearchResults();
        loadAllMembers();
      } else {
        clearSearchResults(); // Delete the existing results.
        
        $('.client-wrapper ul').remove();

        $.ajax({
          url: 'SearchMemberController',
          method: 'POST',
          data: { searchKeyword: searchTerm },
          dataType: 'json',
          success: function (data) {
            clearSearchResults();
            if (data.length == 0) {
              $('.search-empty').append('<p>No search results.</p>');
            } else {
              $.each(data, function (index, member) {
                $("#mem-value").append(
                  "<ul><li><div class=info-header><div class=deleteBtn><button onclick=showModal('" +
                    member.m_id +
                    "')><i class=fa-solid fa-user-minus fa style=color: #ffffff;></i></button></div></div></li><li><div class=id-nick ><div class=input-id><label class=input-label>ID</label><input type=text value=" +
                    member.m_id +
                    " class=primary-dark-input readonly=readonly></div ><div class=input-nick><label class=input-label>닉네임</label><input type=text value=" +
                    member.m_nick +
                    " class=primary-dark-input readonly=readonly></div ></div></li><li><div class=name-birth><div class=input-name><label class=input-label>이름</label><input type=text value=" +
                    member.m_name +
                    " class=primary-dark-input readonly=readonly></div><div class=input-birth><label class=input-label>생일</label><input type=text value=" +
                    member.m_birth +
                    " class=primary-dark-input readonly=readonly></div></div></li><li><div class=email-gender><div class=input-email><label class=input-label>이메일</label><input type=text value=" +
                    member.m_email +
                    " class=primary-dark-input readonly=readonly></div><div class=input-gender><label class=input-label>성별</label><input type=text value=" +
                    member.m_gender +
                    " class=primary-dark-input readonly=readonly></div></div></li><li> <div class=address-temp><div class=input-address><label class=input-label>주소</label><input type=text value=" +
                    member.m_address +
                    " class=primary-dark-input readonly=readonly></div><div class=input-temp><label class=input-label>온도</label><input type=text value=" +
                    member.m_temp +
                    " class=primary-dark-input readonly=readonly></div></div><hr class=divider></li></ul>"
                );
              });
            }
            // Initialize the currentPage so that no more unnecessary scrolling requests occur.
            currentPage = 2;
          },
          error: function (xhr, status, error) {
            console.log('An error occurred while getting search data:', error);
          },
        });
      }
    }

    function loadAllMembers() {
      $.ajax({
        url: 'SelectMemberController',
        method: 'GET',
        data: { currentPage: 1 }, // Load the first page by setting currentPage to 1.
        dataType: 'html',
        success: function (data) {
          $('.client-wrapper').append($(data).find('ul')); // Add only the ul element.
          currentPage = 2; // Reset currentPage to 2 to load the next page.
        },
        error: function (xhr, status, error) {
          console.log('An error occurred while loading all members:', error);
        },
      });
    }
  </script>
</html>