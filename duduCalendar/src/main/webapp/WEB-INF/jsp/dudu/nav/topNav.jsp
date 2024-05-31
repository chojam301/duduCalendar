<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://webfontworld.github.io/TheJamsil/TheJamsil.css" rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<link href="../../css/dudu/topNav.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="topNav">
		<a href="#" onclick="main()"><img src="<c:url value='/images/dudu/blue_duduCalendar_logo.svg' />"></a>
		<div class="btn">
		</div>
		<div class="btn">
			<%-- ${sessionScope.loginMember.name }님 안녕하세요 --%>
			<button class="topbutton" id="admin" type="button" onclick="admin()">관리자 페이지</button>
			<button class="topbutton" onclick="approval()">결재함</button>
			<button class="topbutton" onclick="pjlist()">프로젝트 목록</button>
			<button class="topbutton" onclick="myPage()">마이페이지</button>
			<button class="topbutton" onclick="logout()" id="logout">로그아웃</button>
			<div class="searchBox" style="width: 177px;">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
					fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
 					<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
				</svg>
				<input id="searchInput" spellcheck="false">
			</div>
		</div>
	</nav>
<script type="text/javascript">
var err_msg = "<%= session.getAttribute("err_msg") %>";
if (err_msg !== "null") {
    alert(err_msg);
    <% session.removeAttribute("err_msg"); %>
}

if("${sessionScope.loginMember.auth}"=="5"){
	$('#admin').show()
} else{
	$('#admin').hide();
}

function admin(){
	window.parent.frames['_calendar'].location.replace("admin.do");
}

function approval(){
	window.parent.frames['_calendar'].location.replace("approval.do");
}

function logout(){
	window.parent.location.replace("./main.do");
}

function main(){
	window.parent.location.replace("./test.do");
}

function myPage(){
	window.parent.frames['_calendar'].location.replace("mypage.do");
}

function pjlist(){
	window.parent.frames['_calendar'].location.replace("pjlist.do");
}
	
function searchList(event) {
	const keyCode = event.keyCode || event.which;
    if (keyCode === 13) {
      	window.parent.frames['_calendar'].location.replace("searchlist.do?keyword="+document.getElementById('searchInput').value);
    }
}
	
document.getElementById('searchInput').addEventListener('keypress', searchList);
</script>
</body>
</html>