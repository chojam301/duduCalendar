<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://webfontworld.github.io/TheJamsil/TheJamsil.css" rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<meta charset="UTF-8">
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<link href="../../css/dudu/leftNav.css" rel="stylesheet">
<script>
var err_msg = "<%= session.getAttribute("err_msg") %>";
if (err_msg !== "null") {
    alert(err_msg);
    <% session.removeAttribute("err_msg"); %>
}

	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth',
			locale : 'ko',
			height : 230,
			headerToolbar : {
				start : "title",
				center : "",
				end : 'today,prev,next'
			},
			buttonText : {
				today : '오늘',
			},
			dayCellContent : function(info) {
				var number = document.createElement("a");
				number.classList.add("fc-daygrid-day-number");
				number.innerHTML = info.dayNumberText.replace("일", "").replace(
						"日", "");
				if (info.view.type === "dayGridMonth") {
					return {
						html : number.outerHTML
					};
				}
				return {
					domNodes : []
				};
			},
			dateClick : function(info) {
				var dateStr = info.dateStr;
				var parts = dateStr.split('-');

				var year = parts[0];
				var month = parts[1];

				moveMainCalendar(year, month);
			}
		});
		calendar.render();
	});
</script>
<title>Insert title here</title>
</head>
<style>
.btndiv {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.leftbutton {
    font-size: 11px;
    background-color: transparent;
    padding: 10px 19px;
    font-weight: 400;
    text-transform: capitalize;
    letter-spacing: 0.5px;
    transition: all .3s;
    overflow: hidden;
    font-family: thejamsil;
    border: none;
    cursor: pointer;
}
</style>
<body>
	<nav class="leftNav">
		<div
			style="display: flex; margin: 10px; border: 1px solid #e1e1e1; height: 40px; border-radius: 5px; margin-top: 25px;">
			<c:if test="${sessionScope.loginMember.getAuth() >= 3}">
				<div class="btndiv">
					<button class="leftbutton" id="project" onclick="project()">프로젝트
						등록</button>
				</div>
				<div class="btndiv">
					<button class="leftbutton" id="daily" onclick="daily()">일일업무
						등록</button>
				</div>
			</c:if>
			<c:if test="${sessionScope.loginMember.getAuth() < 3}">
				<div class="btndiv">
					<button class="leftbutton" id="daily" onclick="daily()" style="width:100%; height:100%;">일일업무
						등록</button>
				</div>
			</c:if>
		</div>

		<div id="calendar"></div>

		<div id="filteringDiv">
			<div id="holidayFiltering">
				<input type="checkbox" id="holidayFilter" checked> 공휴일
			</div>
			<div id="projectFiltering">
				<input type="checkbox" id="projectFilter" checked> 프로젝트
			</div>
			<div id="dailyFiltering">
				<input type="checkbox" id="dailyFilter" checked> 일일업무
			</div>
		</div>
	</nav>

</body>
</html>
<script type="text/javascript">
	function moveMainCalendar(year, month) {
		var calendarFrame = window.parent.frames["_calendar"];
		if (month.length === 1) {
			month = "0" + month;
		}
		calendarFrame.location.href = "/duducalendar.do?year=" + year
				+ "&month=" + month;
	}

	function project() {
		var calendar = window.parent.frames["_calendar"];
		calendar.openProject();
	}

	function daily() {
		var daily = window.parent.frames["_calendar"];
		daily.openDaily();
	}
	
	console.log("여기는 왼쪽 ${param.username}");
	console.log(typeof " ${param.username}");
	<c:forEach items="${param.username}" var="userlist">
	console.log("${userlist}");
	</c:forEach>
</script>