<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://webfontworld.github.io/TheJamsil/TheJamsil.css"
	rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
	<link href="../../css/dudu/myPage.css" rel="stylesheet">
</head>
<body>

<button type="button" onclick="backToCalendar()" class="back">
	<span class="material-symbols-outlined">arrow_back</span>
</button>
<div id="overlay"></div>
	<div class="myPage">
		<div class="myInfo">
			<div class="title">마이페이지</div>
			<form action="userUpdate.do" method="post">
				<div class="userInfo">
					<div class="leftInfo">
						<div class="info">이름 <input type="text" name="cmpnyNm" size="20" maxlength="20"  value="<c:out value='${sessionScope.loginMember.name }' />"></div>
						<div class="info">이메일 <input type="email" readonly="readonly" name="applcntEmailAdres" value="<c:out value='${sessionScope.loginMember.email }' />"></div>
						<c:set var="pw" value="${sessionScope.loginMember.password }"></c:set>
						<div class="info">비밀번호 
							<div style="position: relative;">
								<input type="password" readonly="readonly" value="<c:out value='${fn:substring(pw, 0, 8)}' />">
								<button type="button" class="changepw" onclick="updatePw()">비밀번호 변경</button>
							</div>
						</div>
					</div>
					<div class="rightInfo">
						<div class="info">부서명 <input type="text" readonly="readonly" value="<c:out value='${sessionScope.loginMember.orgnztNm }' />"></div>
						<div class="info">직급 <input type="text" readonly="readonly" value="<c:out value='${sessionScope.loginMember.position }' />"></div>
					</div>
				</div>
				<button type="submit" hidden="hidden" id="update"></button>
			</form>
			<div class="botbutton"><button type="button" class="infoUpdate" onclick="updateAlert()">개인정보 업데이트</button></div>
		</div>
	</div>
	
	<!-- 모달 -->
	<div class="updateAlert">
		<div class="alertBody">
			<div>변경사항을 저장하시겠습니까?</div>
			<div class="alertButton">
				<button type="button" onclick="clickUpdate()" class="Button">저장</button>
				<button type="button" onclick="hideAlert()" class="Button">취소</button>
			</div>
		</div>
	</div>

	<div class="updatePw">
		<div class="updateBody">
			<div>기존 비밀번호를 입력해주세요.</div>
			 <input type="email" hidden="hidden" name="email" id="email" value="<c:out value='${sessionScope.loginMember.email }' />">
			<input type="password" name="password" id="password">
			<div class="alertButton">
				<button type="button" onclick="checkPw()" class="Button">입력</button>
				<button type="button" onclick="hidePw()" class="Button">취소</button>
			</div>
		</div>
	</div>
	
 	<div class="newPw">
		<div class="updateBody">
			<div>새로운 비밀번호를 입력해주세요.</div>
			<input type="password" name="password" id="newPassword" size="50" maxlength="20" placeholder="문자, 숫자 혼용, 6자리 이상" >
			<div class="alertButton">
				<button type="button" onclick="newPwd()" class="Button">변경</button>
				<button type="button" onclick="hideNew()" class="Button">취소</button>
			</div>
		</div>
	</div> 
</body>
<script type="text/javascript">
$('.updateAlert').hide();
$('.updatePw').hide();
$('.newPw').hide();
$('#overlay').hide();

function updateAlert(){
	$('.updateAlert').show();
	$('#overlay').show();
}

function hideAlert(){
	$('.updateAlert').hide();
	$('#overlay').hide();
}

function updatePw(){
	$('.updatePw').show();
	$('#overlay').show();
}

function hidePw(){
	$('.updatePw').hide();
	$('#overlay').hide();
}
function newPw(){
	$('.newPw').show();
	$('#overlay').show();
}

function hideNew(){
	$('.newPw').hide();
	$('#overlay').hide();
}

function clickUpdate(){
	$('#update').click();
}

function checkPw(){
	var pw = $('#password').val();
	var email = $('#email').val();
	$('#password').val("");
	
	if(pw.length === 0){
		alert("비밀번호를 입력해주세요");
	}else{
		$.ajax({
		      url: 'checkPw.do',
		      method: 'GET',
		      data: {
		         password: pw,
		         applcntEmailAdres : email,
		         id: email
		      },
		      success: function(response){
		         console.log(response);
		         if(response=='1'){
		            alert('비밀번호가 일치합니다');
		            hidePw();
		            newPw();
		         }else{
		            alert('비밀번호가 일치하지 않습니다.');
		         }
		      },
		      error: function(error){
		         console.error('비밀번호 체크 실패');
		      }
		   })
	}
}

function newPwd() {
	var pw = $('#newPassword').val();
	var email = $('#email').val();
	$('#newPassword').val("");
	
	if (pw.length < 6) {
		alert("비밀번호는 6자 이상으로 사용해야 합니다.");
		$('#newPassword').val("");
	}else if (!/^(?=.*[A-Za-z])(?=.*\d).+$/.test(pw)) {
		alert("비밀번호는 영문과 숫자를 포함하여 사용해야 합니다.");
		$('#newPassword').val("");
	}else{
		$.ajax({
			url : 'updatepwd.do',
			method : 'POST',
			data : {
				entrprsMberPassword : pw,
				applcntEmailAdres : email
			},
			success : function(response) {
				console.log(response);
				alert('비밀번호를 변경했습니다. 로그아웃을 진행합니다.');
				$('.newPw').hide();
				$('#overlay').hide();
				$.ajax({
					url: 'logout.do',
					method: 'POST',
					success: function(response){
						console.log(response);
						function removeFramesetAndLoadMain() {
						    window.parent.location.replace("/main.do");
						}
						removeFramesetAndLoadMain();
					},
					error: function(error){
						console.error(error);
					}
				});
			},
			error : function(error) {
				console.error('비밀번호 체크 실패');
			}
		})
	}
	
}

function backToCalendar(){
	window.parent.frames['_calendar'].location.replace("duducalendar.do");
}

<%
	String updateValue = (String) request.getAttribute("update");
%>
var update = '<%= updateValue %>';
if(update==1){
	alert('변경을 완료했습니다.');
}
</script>
</html>