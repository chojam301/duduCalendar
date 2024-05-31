<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dudu.HolidayVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dudu.service.ProjectVO"%>
<%@page import="dudu.service.DailyVO"%>
<%@page import="com.google.gson.Gson" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/TheJamsil/TheJamsil.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
	<link href="../../css/dudu/duducalendar.css" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<script>
var err_msg = "<%= session.getAttribute("err_msg") %>";
if (err_msg !== "null") {
    alert(err_msg);
    <% session.removeAttribute("err_msg"); %>
}

document.addEventListener('DOMContentLoaded', function() {
    var leftFrame = window.parent.frames['_left'];
    var holidayCheckbox = leftFrame.document.getElementById('holidayFilter');
    var projectCheckbox = leftFrame.document.getElementById('projectFilter');
    var dailyCheckbox = leftFrame.document.getElementById('dailyFilter');

    var calendarEl = document.getElementById('calendar');
    var today = new Date(); // 오늘 날짜를 얻음
    var initial = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
    <%if (request.getParameter("year") != null) {%>
    var year = <%=request.getParameter("year")%>;
    var month = '<%=request.getParameter("month")%>';
    initial = year + "-" + month + "-01";
    <%}%>
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        locale: 'ko',
        height: 800,
        initialDate: initial,
        nowIndicator: true,
        allDayText: '종일',
        eventOrder: 'displayOrder',
        editable: true,
        views: {
            dayGridMonth: {
                dayMaxEvents: 3,
                moreLinkText: "더 보기"
            },
            dayGridWeek: {
                dayHeaderFormat: { weekday: 'narrow', day: 'numeric' },
                dayHeaderContent: function(arg) {
                    var date = arg.date.getDate();
                    var weekday = arg.date.toLocaleDateString('ko-KR', { weekday: 'short' });
                    return date + ' ' + weekday;
                }
            }
        },
        headerToolbar: {
            start: "title",
            center: "",
            end: 'dayGridMonth,dayGridWeek prev,next,today'
        },
        titleFormat: { year: 'numeric', month: 'short' },
        buttonText: {
            today: '오늘',
            month: '월',
            week: '주',
        },
        // 클릭이벤트 이거 누르면 모달 떠야됨
        eventClick: function(info) {
        	var clickTime = new Date().getTime();
            var interval = 300;
            
            if (clickTime - calendar.lastClickTime < interval) {
	            if (info.event.classNames.includes('project')) { //프로젝트
	                var project = document.getElementById(info.event.id);
	                project.style.display = "inline-block";
	            } else if (info.event.classNames.includes('daily')) { //일일업무
	                var daily = document.getElementById(info.event.id);
	                daily.style.display = "inline-block";
	            }
            }
            calendar.lastClickTime = clickTime;
        },
        eventAllow: function(dropLocation, draggedEvent) {
            return draggedEvent.classNames.includes('daily');
        },
        eventDrop: function(info) {
            var eventId = info.event.id;
            var newStart = info.event.start;
            var eventIdNumber = eventId.match(/\d+/)[0];
            var currentDate = new Date();
            var formattedDate = new Date(newStart).toISOString().slice(0, 10);
            var formattedTime = currentDate.toTimeString().slice(0, 8);
            var result = formattedDate + ' ' + formattedTime;
            $.ajax({
                url: 'dailyMouseupdate.do',
                method: 'POST',
                data: {
                    dailyno: eventIdNumber,
                    dadate: result
                },
                success: function(response) {
                    rightNavUpdate();
                },
                error: function(error) {
                    console.error('이벤트 이동 중 오류가 발생하였습니다.');
                }
            });
        },
        dayCellContent: function(info) {
            var number = document.createElement("a");
            number.classList.add("fc-daygrid-day-number");
            number.innerHTML = info.dayNumberText.replace("일", "").replace("日", "");
            if (info.view.type === "dayGridMonth") {
                return {
                    html: number.outerHTML
                };
            }
            return {
                domNodes: []
            };
        }
    });

    if (holidayCheckbox != null) {
        holidayCheckbox.addEventListener('change', function() {
            calendar.removeAllEvents();
            addEventsToCalendar();
        });
    }
    if (projectCheckbox != null) {
        projectCheckbox.addEventListener('change', function() {
            calendar.removeAllEvents();
            addEventsToCalendar();
        });
    }
    if (dailyCheckbox != null) {
        dailyCheckbox.addEventListener('change', function() {
            calendar.removeAllEvents();
            addEventsToCalendar();
        });
    }

    // 캘린더에 이벤트 추가 함수
    function addEventsToCalendar() {
        //공휴일
        <%List<HolidayVO> holidayList = (List<HolidayVO>) request.getAttribute("holidayList");%>
        <%if (holidayList != null) {%>
            <%for (HolidayVO vo : holidayList) {%>
                calendar.addEvent({
                    title: '<%=vo.getHolidayName()%>',
                    start: '<%=vo.getHolidayStart()%>',
                    end: '<%=vo.getHolidayEnd()%>',
                    color: '#ff6363',
                    display: (holidayCheckbox && holidayCheckbox.checked) || holidayCheckbox === null ? 'block' : 'none',
                    className: 'holiday',
                    description: '<%=vo.getHolidayName()%>'
                });
            <%}%>
        <%};%>

        //프로젝트
        <% List<ProjectVO> projectList = (List<ProjectVO>) request.getAttribute("projectList");
            String projectListJson = new Gson().toJson(projectList);%>
        var projectList = JSON.parse('<%= projectListJson %>');
        <%if (projectList != null) {%>
            <%for (ProjectVO vo : projectList) {%>
                var event = {
                    title: '<%= vo.getPjtitle() %>',
                    start: '<%= vo.getPjstart() %>',
                    end: '<%= vo.getPjstart() %>',
                    color: '<%= vo.getPjcolor() %>',
                    display: (projectCheckbox && projectCheckbox.checked) || projectCheckbox === null ? 'block' : 'none',
                    className: ['<%= "project" %>', 'pjno_' + '<%= vo.getPjno() %>'],
                    id: 'pjno_' + '<%= vo.getPjno() %>'
                };
                calendar.addEvent(event);
            <%}%>
        <%};%>

        //일일업무
        <% List<DailyVO> dailyList = (List<DailyVO>) request.getAttribute("dailyList");
            String dailyListJson = new Gson().toJson(dailyList);%>
        var dailyList = JSON.parse('<%= dailyListJson %>');
        <%if (dailyList != null) {%>
            <%for (DailyVO vo : dailyList) {%>
                calendar.addEvent({
                    title: '<%=vo.getDatitle()%>',
                    start: '<%=vo.getDadate()%>',
                    end: '<%=vo.getDadate()%>',
                    color: '<%=vo.getDacolor()%>',
                    display: (dailyCheckbox && dailyCheckbox.checked) || dailyCheckbox === null ? 'block' : 'none',
                    className: ['<%= "daily" %>', 'da_' + '<%= vo.getDailyno() %>'],
                    id: 'da_' + '<%=vo.getDailyno()%>',
                });
            <%}%>
        <%};%>

        calendar.render();
    }
    addEventsToCalendar();


    //우클릭
    calendarEl.addEventListener('contextmenu', function(ev) {
        ev.preventDefault(); // 우클릭 메뉴를 띄우지 않음

        var fc_event = ev.target.closest('.fc-event');

        if (fc_event != null) { //이벤트 클릭

            // 이전에 생성된 메뉴를 모두 제거
            var existingMenu = document.querySelector('.custom-menu');
            if (existingMenu !== 'undefined' && existingMenu !== null) {
                try {
                    if (existingMenu.closest('.fc-event').classList.contains('z-1000')) {
                        existingMenu.closest('.fc-event').classList.remove('z-1000');
                    }
                } catch (e) {}
                existingMenu.remove();
            }

            var cnt = 0;
            var subDivs = fc_event.querySelectorAll('div');
            subDivs.forEach(function(subDiv) {
                if (subDiv.classList.contains('custom-project')) {
                    cnt++;
                }
            });
            if (cnt == 0) {
            	if(fc_event.classList.contains('project')){
            		if('${sessionScope.loginMember.position}' != '연구원'){
	            		//addMenu2();
            		}
            	}else if(fc_event.classList.contains('daily')){
	                addMenu();
            	}
                fc_event.classList.add('z-1000');
            }

            function addMenu() {
                var menuContainer = document.createElement('div');
                menuContainer.innerHTML = `<div class="menu-item" id="copy">복사</div><div class="menu-item" id="delete">삭제</div>`;
                menuContainer.classList.add('custom-menu');
                menuContainer.classList.add('custom-project');
                fc_event.appendChild(menuContainer);
            }
            function addMenu2() {
                var menuContainer = document.createElement('div');
                menuContainer.innerHTML = `<div class="menu-item" id="delete">삭제</div>`;
                menuContainer.classList.add('custom-menu');
                menuContainer.classList.add('custom-project');
                fc_event.appendChild(menuContainer);
            }

            //프로젝트 우클릭
            if (fc_event.classList.contains('project')) {
                var events = calendar.getEvents().filter(function(event) {
                    return event.classNames.includes('project');
                });
                
                var eventId  = null;
                for (var i of events) {
                    //일치하는 프로젝트
                    if (fc_event.classList.contains(i.id)) {
                    	eventId = i.id;
                    	splitId = eventId.split('_')[1];
                    }
                }
				
                document.addEventListener('click', clickMenu);
                function clickMenu(e) {
                    document.removeEventListener('click', clickMenu);
                    if(e.target.id=='delete'){//프로젝트 삭제
                    	$.ajax({
                            url: 'pjdelete.do?dudu=calendar',
                            method: 'POST',
                            data: {
                            	pjno: splitId
                            },
                            success: function(response) {
                                console.log('이벤트 삭제 완료.');
                                rightNavUpdate();
                                window.location.reload();
                            },
                            error: function(error) {
                                console.error('이벤트 삭제 실패.');
                            }
                        });	                    	
                    }
                }
                
            } //일일업무 우클릭
            else if (fc_event.classList.contains('daily')) {
                var events = calendar.getEvents().filter(function(event) {
                    return event.classNames.includes('daily');
                });
				
                var eventId  = null;
                for (var i of events) {
                    //일치하는 일일업무
                    if (fc_event.classList.contains(i.id)) {
                    	eventId = i.id;
                    	splitId = eventId.split('_')[1];
                    }
                }

                //메뉴 선택
                document.addEventListener('click', clickMenu);
                function clickMenu(e) {
                    document.removeEventListener('click', clickMenu);
                    if(e.target.id=='delete'){//일일업무 삭제
                    	$.ajax({
                            url: 'dailydelete.do',
                            method: 'POST',
                            data: {
                                dailyno: splitId
                            },
                            success: function(response) {
                                console.log('이벤트 삭제 완료.');
                                rightNavUpdate();
                                window.location.reload();
                            },
                            error: function(error) {
                                console.error('이벤트 삭제 실패.');
                            }
                        });	                    	
                    }else if(e.target.id=='copy'){//일일업무 복사
                    	document.getElementById('copy_paste').value = eventId;
                    	console.log(document.getElementById('copy_paste').value);
/*                     	navigator.clipboard.writeText(eventId)
                        .then(function() {
                            console.log('텍스트가 클립보드에 저장되었습니다.');
                        })
                        .catch(function(err) {
                            console.error('텍스트를 클립보드에 저장하는 중 오류가 발생했습니다:', err);
                        }); */
                    }
                }
            }

        } else { //날짜 클릭
            var fc_day = ev.target.closest('.fc-day');

            // 이전에 생성된 메뉴를 모두 제거
            var existingMenu = document.querySelector('.custom-menu');
            if (existingMenu !== 'undefined' && existingMenu !== null) {
                try {
                    if (existingMenu.closest('.fc-event').classList.contains('z-1000')) {
                        existingMenu.closest('.fc-event').classList.remove('z-1000');
                    }
                } catch (e) {}
                existingMenu.remove();
            }

            addMenu();
            
            function addMenu() {
                var menuContainer = document.createElement('div');
                var pasteValue = document.getElementById('copy_paste').value;
                
                var pattern = /^(pjno_|da_)/;
                if((pasteValue==""||!pattern.test(pasteValue))&&fc_day.classList.contains('fc-day-today')){
	                menuContainer.innerHTML = `<div class="menu-item" id="insert">등록</div><div class="menu-item" id="paste" style="pointer-events: none; opacity: 0.5;">붙여넣기</div>`;
                }else if(pasteValue==""||!pattern.test(pasteValue)){
	                menuContainer.innerHTML = `<div class="menu-item" id="paste" style="pointer-events: none; opacity: 0.5;">붙여넣기</div>`;
                }else if(fc_day.classList.contains('fc-day-today')){
		            menuContainer.innerHTML = `<div class="menu-item" id="insert">등록</div><div class="menu-item" id="paste">붙여넣기</div>`;
                }else{
		            menuContainer.innerHTML = `<div class="menu-item" id="paste">붙여넣기</div>`;
                }
                
                /* navigator.clipboard.readText()
                .then(function(text) {
                	var pattern = /^(pjno_|da_)/;
                	if((text==""||!pattern.test(text))&&fc_day.classList.contains('fc-day-today')){
	                	menuContainer.innerHTML = `<div class="menu-item" id="insert">등록</div><div class="menu-item" id="paste" style="pointer-events: none; opacity: 0.5;">붙여넣기</div>`;
                	}else if(text==""||!pattern.test(text)){
	                	menuContainer.innerHTML = `<div class="menu-item" id="paste" style="pointer-events: none; opacity: 0.5;">붙여넣기</div>`;
                	}else if(fc_day.classList.contains('fc-day-today')){
		                menuContainer.innerHTML = `<div class="menu-item" id="insert">등록</div><div class="menu-item" id="paste">붙여넣기</div>`;
                	}else{
		                menuContainer.innerHTML = `<div class="menu-item" id="paste">붙여넣기</div>`;
                	}
                }).catch(function(err) {
                	console.log('안읽힘');
                }); */
                menuContainer.classList.add('custom-menu');
                menuContainer.classList.add('custom-day');
                menuContainer.classList.add('z-1000');
                document.body.appendChild(menuContainer);
                var mouseY = event.clientY + 'px';
                var element = document.querySelector('.custom-day');
                
                if (event.clientX > 1390) {
	                if (event.clientY > 800) {
	                	mouseY = '800px';
	                }
	                element.style.right = window.innerWidth - 1390 - 55 + 'px';
                }else{
                	if (event.clientY > 800) {
	                	mouseY = '800px';
	                }
	                element.style.right = window.innerWidth - event.clientX - 55 + 'px';
                }
                element.style.top = mouseY;
            }
            
            //메뉴선택
            document.addEventListener('click', clickMenu);
            function clickMenu(e) {
            	var date = fc_day.getAttribute('data-date');
                document.removeEventListener('click', clickMenu);
                var current_calendar = document.getElementById('fc-dom-1').innerText;
                var year = current_calendar.split("년")[0];
				var month = current_calendar.split(" ")[1].split("월")[0];
				
				function getCurrentTime() {
				    var now = new Date(); 
				    var hours = now.getHours().toString().padStart(2, '0');
				    var minutes = now.getMinutes().toString().padStart(2, '0');
				    var seconds = now.getSeconds().toString().padStart(2, '0'); 
				    return hours + ':' + minutes + ':' + seconds; 
				}
				var currentTime = getCurrentTime(); 
                
				if(e.target.id=='paste'){ //붙여넣기
					var pasteValue = document.getElementById('copy_paste').value;
					
					$.ajax({
                        url: 'insertDaily.do',
                        method: 'GET',
                        data: {
                            dailyno: pasteValue.split('_')[1],
                            dadate: date+' '+currentTime,
                            year: year,
                            month: month
                        },
                        success: function(response) {
                        	rightNavUpdate();
                            window.location.reload();
                        },
                        error: function(error) {
                            console.error('이벤트 붙여넣기 실패.');
                            alert("error:",error);
                        }
                    });	  
				
					document.getElementById('copy_paste').value = "";
					
                	/* navigator.clipboard.readText()
                    .then(function(text) {
                        console.log('클립보드에서 가져온 텍스트:', text);
                        $.ajax({
                            url: 'insertDaily.do',
                            method: 'GET',
                            data: {
                                dailyno: text.split('_')[1],
                                dadate: date+' '+currentTime,
                                year: year,
                                month: month
                            },
                            success: function(response) {
                            	rightNavUpdate();
                                window.location.reload();
                            },
                            error: function(error) {
                                console.error('이벤트 붙여넣기 실패.');
                                alert("error:",error);
                            }
                        });	     
                    })
                    .catch(function(err) {
                        console.error('클립보드에서 텍스트를 가져오는 중 오류가 발생했습니다:', err);
                    }); */
                }else if(e.target.id=='insert'){
                	openDaily();
                }
            }

        }
        
        //클릭시 메뉴 삭제
        document.addEventListener('click', function(event) {
            var existingMenu = document.querySelector('.custom-menu');

            if (existingMenu !== 'undefined' && existingMenu !== null) {
                try {
                    if (existingMenu.closest('.fc-event').classList.contains('z-1000')) {
                        existingMenu.closest('.fc-event').classList.remove('z-1000');
                    }
                } catch (e) {}
                existingMenu.remove();
            }
        });

    });
});

	var leftNavHidden = false;
	
	function toggleLeftNav() {
		var frameset = window.parent.document.getElementsByTagName('frameset')[1];
	    
	    if (!leftNavHidden) {
	    	frameset.setAttribute('cols', '0,*,235px');
	        leftNavHidden = true;
	    } else {
	    	frameset.setAttribute('cols', '235px,*,235px');
	        leftNavHidden = false;
	    }
	}

</script>
<title>Insert title here</title>
</head>
<body>
	<div hidden="hidden" id="copy_paste"></div>
	<div id="userTeam" hidden="hidden" value="${sessionScope.loginMember.orgnztNm }"></div>
	<span class="material-symbols-outlined" onclick="toggleLeftNav()">
		left_panel_close </span>
	<div id="calendar"></div>
	<!-- 프로젝트 등록 -->
		<div id="modal1" class="modal">		
		<div class="modal_body">
		<form class="pjfrom" action="pjinsert.do" name="sub2" method="POST">
		<div style="width:100%; margin:40px 20px;">
			<div class="modaltitle">
				<div style="font-size:large; color:#2556a3;">프로젝트 등록</div>
				<div style="font-size:9pt;margin-left: 5px;">신규 프로젝트를 등록하세요</div>
				<div style="justify-content:flex-end; width:200px;"><a href="#this" class="aa" id="close">X</a></div>
			</div>
			<div class="pjinfo">* 프로젝트 정보를 입력하세요</div>
			<table>
				<tbody>
					<tr>
						<td>프로젝트 명</td>
						<td class="tableborder" style="text-align:center;"><input style="margin=0;" type="color" name="pjcolor" id="deco"></td>
						<td class="tableborder"><input class="pjtitle" type="text" maxlength="50" name="pjtitle" placeholder="프로젝트 명"></td>
					</tr>
					<tr>
						<td>프로젝트 기간</td>
						<td class="tableborder" colspan="2">
						<input type="date" name="pjstart">~<input type="date" name="pjend">
						</td>
					</tr>
					<tr>
						<td>프로젝트 내용</td>
						<td class="tableborder" colspan="2"><textarea class="pjcnt" name="pjcnt" maxlength="1000"></textarea></td>
					</tr>
					<tr>
						<td style="padding-top: 10px;" colspan="3">참가자 선택</td>
					</tr>
					<tr style="border:none;">
					<td colspan="3">
						<div class="pjmember">
							<div class="pjuser" style="border:none; width:160px;">
								<select id="username">
									<c:forEach items="${user}" var="user">
										<option value="${user.username}">${user.username}(${user.userdepartment})</option>
									</c:forEach>
								</select>
							</div>
							<div class="userbtn">
								<input type="button" id="add" value="추가">
								<input type="button" id="remove" value="삭제">
							</div>
							<div id="member" class="pjuser" style="overflow-y:scroll;padding: 10px;"></div>
						</div>
					</td>
					</tr>
					<tr style="height:100px; border:none">
						<td colspan="3">
							<div class="pjfoot">
								<div>
									<input type="button" id="pjregist" value="등록">
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<input type="hidden" name="useremail" value="${sessionScope.loginMember.email }">
		<input type="hidden" name="username" value="${sessionScope.loginMember.name }">
		<input type="hidden" name="pjdm" value="${sessionScope.loginMember.orgnztNm }">
		<input type="hidden" name="dudu" value="calendar">
		</form>
		</div>
	</div>
	
	<!-- 일일 업무 등록 -->
	<div id="modal2" class="modal">		
		<div class="modal_body" style="text-align:center; height: 550px;">
		<form class="pjfrom" action="dailyinsert.do" name="sub3" method="POST">
    		<div style="width:100%; margin:20px;">
				<div class="modaltitle">
					<div style="font-size:large; color:#2556a3;">일일 업무 등록</div>
					<div style="font-size:9pt;margin-left: 5px;">신규 일일 업무를 등록하세요</div>
					
				</div>
				<div class="pjinfo">* 일일 업무 정보를 입력하세요</div>
				<table>
					<tr>
						<td>일일 업무 명</td>
						<td class="tableborder" style="text-align:center;"><input style="margin=0;" type="color" name="dacolor" id="deco"></td>
						<td class="tableborder"><input class="pjtitle" type="text" maxlength="50" name="datitle" placeholder="일일 업무 명"></td>
					</tr>
					<tr>
						<td>일일 업무 내용</td>
						<td class="tableborder" colspan="2"><textarea class="pjcnt" name="dacnt" maxlength="1000" placeholder="일일 업무 내용"></textarea></td>
					</tr>
					<tr>
						<td>프로젝트 선택</td>
						<td class="tableborder" colspan="2">
						<div>
							<div style="display:flex; justify-content:center;">
								<select style="width: 200px;height: 40px;font-size: 12pt;margin: 5px;" id="daproject" name="daproject">
								<c:forEach items="${project}" var="project">
									<option value="${project.pjno}">${project.pjtitle}</option>
								</c:forEach>
							</select>
							</div>
						</div>
						</td>
					</tr>
					<tr>
						<td>작업 상태</td>
						<td class="tableborder" colspan="2">
							<div>
								<div style="display:flex; justify-content:center;">
									<select style="width: 200px;height: 40px;font-size: 12pt;margin: 5px;" name="dafinish">
										<option value="0">작업중</option>
										<option value="1">작업 완료</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr style="border-bottom: 1px solid #d3d3d3;">
						<td>작업 중요도</td>
						<td class="tableborder" colspan="2">
							<div>
								<div style="display:flex; justify-content:center;">
									<select style="width: 200px;height: 40px;font-size: 12pt;margin: 5px;" name="daimp">
			    						<option value=1>1</option>
							    		<option value=2>2</option>
							    		<option value=3>3</option>
							    		<option value=4>4</option>
							    		<option value=5>5</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr style="height:150px; border:none">
						<td colspan="3">
							<div class="pjfoot">
								<div>
									<input type="button" id="dailyregist" value="등록">
								</div>
								<div>
									<input type="button" id="closedaily" value="닫기">
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		
		<input type="hidden" name="useremail" value="${sessionScope.loginMember.email}">
		<input type="hidden" name="username" value="${sessionScope.loginMember.name }">
		<input type="hidden" name="pjno" id="pjno">
		<input type="hidden" name="dudu" value="calendar">
		</form>
		</div>
	</div>
	
	<!-- 일일업무 상세보기 -->
	<c:forEach items="${dailyList}" var="daily">
		<div id="da_${daily.dailyno}" class="modal">		
		<div class="modal_body" style="text-align:center;">
		<form class="pjfrom" id="${daily.dailyno}" method="POST">
			<div style="width:100%; margin:20px;">
				<div class="modaltitle">
					<div style="font-size:large; color:#2556a3;">일일 업무 정보</div>
				</div>
				<div class="pjinfo">* 일일 업무 정보입니다</div>
				<table>
					<tr>
						<td>일일 업무 명</td>
						<td class="tableborder" style="text-align:center;"><input style="margin=0;" type="color" name="dacolor" value="${daily.dacolor}"  id="deco"></td>
						<td class="tableborder"><input id="datitle_${daily.dailyno}" class="pjtitle" type="text" maxlength="50" name="datitle" placeholder="일일 업무 명" value="${daily.datitle}"></td>
					</tr>
					<tr>
						<td>일일업무 내용</td>
						<td class="tableborder" colspan="2"><textarea id="dacnt_${daily.dailyno}" class="pjcnt" name="dacnt" maxlength="1000" placeholder="일일 업무 내용">${daily.dacnt}</textarea></td>
					</tr>
					<tr>
						<td>프로젝트 선택</td>
						<td class="tableborder" colspan="2">
						<div>
							<div style="display:flex; justify-content:center;">
								<select style="width: 200px;height: 40px;font-size: 12pt;margin: 5px;" name="daproject" id="daproject_${daily.dailyno}">
								<c:set var="title" value="${daily.pjtitle}"/>
								<c:forEach items="${project}" var="project">
									<option value="${project.pjno}" ${title == project.pjtitle ? 'selected':''}>${project.pjtitle}</option>
								</c:forEach>
							</select>
							</div>
						</div>
						</td>
					</tr>
					<tr>
						<td>작업 상태</td>
						<td class="tableborder" colspan="2">
							<div>
								<div style="display:flex; justify-content:center;">
									<select style="width: 200px;height: 40px;font-size: 12pt;margin: 5px;" name="dafinish" id="dafinish_${daily.dailyno}">
										<option value="0">작업중</option>
										<option value="1">작업 완료</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr style="border-bottom: 1px solid #d3d3d3;">
						<td>작업 중요도</td>
						<td class="tableborder" colspan="2">
							<div>
								<div style="display:flex; justify-content:center;">
								<c:set var="imp" value="${daily.daimp}"/>
									<select style="width: 200px;height: 40px;font-size: 12pt;margin: 5px;" name="daimp" id="daimp_${daily.dailyno}">
			    						<option value=1 ${imp == '1'?'selected':''}>1</option>
							    		<option value=2 ${imp == '2'?'selected':''}>2</option>
							    		<option value=3 ${imp == '3'?'selected':''}>3</option>
							    		<option value=4 ${imp == '4'?'selected':''}>4</option>
							    		<option value=5 ${imp == '5'?'selected':''}>5</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr style="height:150px; border:none">
						<td colspan="3">
							<div class="pjfoot">
								<div>
									<input type="button" value="수정" onclick="dailyupdate('${daily.dailyno}')">
								</div>
								<div>
									<input type="button" onclick="dailydelete('${daily.dailyno}')" value="삭제">
								</div>
								<div>
									<input type="button" onclick="dailyclose('${daily.dailyno}')" value="닫기">
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		
		<input type="hidden" name="useremail" value="${sessionScope.loginMember.email}">
		<input type="hidden" name="username" value="${sessionScope.loginMember.name }">
		<input type="hidden" name="dailyno" value="${daily.dailyno}">
		<input type="hidden" name="pjno" id="pjno_${daily.dailyno}">
		
		</form>
		</div>
	</div>
	</c:forEach>
	
	<!-- 프로젝트 상세보기 -->
	<c:forEach items="${projectList}" var="modal">
	<div id="pjno_${modal.pjno}" class="modal">
		<div class="modal_body" style="text-align:center;">
		<form class="pjfrom" id="${modal.pjno}" name="${modal.pjno}" method="POST">
			<div style="width:100%; margin:20px;">
				<div class="modaltitle">
					<div style="font-size:large; color:#2556a3";>프로젝트 정보</div>
					<div style="justify-content:flex-end; width:345px;"><a href="#this" class="aa" onclick="closedd('${modal.pjno}')">X</a></div>
				</div>
				<div class="pjinfo">* 프로젝트 정보입니다.</div>
				<table>
				<tbody>
					<tr>
						<td>프로젝트 명</td>
						<td class="tableborder" style="text-align:center;"><input style="margin=0;" type="color" name="pjcolor" id="deco" value="${modal.pjcolor}"></td>
						<td class="tableborder"><input  id="pjtitle_${modal.pjno}" class="pjtitle" type="text" maxlength="50" name="pjtitle" value="${modal.pjtitle}"></td>
					</tr>
					<tr>
						<td>프로젝트 기간</td>
						<td class="tableborder" colspan="2">
						<input id="pjstart_${modal.pjno}" type="date" name="pjstart" value="${modal.pjstart}">~<input id="pjend_${modal.pjno}" type="date" name="pjend" value="${modal.pjend}">
						</td>
					</tr>
					<tr>
						<td>프로젝트 내용</td>
						<td class="tableborder" colspan="2"><textarea id="pjcnt2" class="pjcnt" name="pjcnt" maxlength="1000">${modal.pjcnt}</textarea></td>
					</tr>
					<tr>
						<td style="padding-top: 10px;" colspan="3">참가자 선택</td>
					</tr>
					<tr style="border:none;">
					<td colspan="3">
						<div class="pjmember">
							<div id="seldiv_${modal.pjno}" class="pjuser" style="border:none; width:160px; padding: 0;">
								<select id="username_${modal.pjno}">
									<c:forEach items="${user}" var="user">
										<option value="${user.username}">${user.username}(${user.userdepartment})</option>
									</c:forEach>
								</select>
							</div>
							<div class="userbtn">
								<input type="button" id="ad_${modal.pjno}" value="추가" onclick="add('${modal.pjno}')">
								<input type="button" id="rm_${modal.pjno}" value="삭제" onclick="drop('${modal.pjno}')">
							</div>
							<div id="member_${modal.pjno}" class="pjuser" style="overflow-y:scroll;">
								<c:forEach items="${modal.pjmember}" var="mem">
						    		<label style="font-size:9pt;display: flex;align-items: center;"><input id="pjmember_${modal.pjno}" name="pjmember" type='checkbox' value="${mem}">${mem}</label>
					    		</c:forEach>
							</div>
						</div>
					</td>
					</tr>
					<tr style="height:150px; border:none">
						<td colspan="3">
							<div class="pjfoot">
							<c:if test="${sessionScope.loginMember.auth >= '3' }">
								<div>
									<input type="button" id="up_${modal.pjno}" value="수정" onclick="updatedd('${modal.pjno}')">
								</div>
								</c:if>
								<c:if test="${modal.pjischange eq 1 }">
									<div>
										<input type="button" onclick="logdd('${modal.pjno}')" value="로그 확인">
									</div>
								</c:if>
								<c:if test="${sessionScope.loginMember.auth >= '3' }">
								<div>
									<input type="button" onclick="deletedd('${modal.pjno}')" id="de_${modal.pjno}" value="삭제">
								</div>
								</c:if>
								<div>
									<input type="button" onclick="opendailydd('${modal.pjno}')" value="일일업무">
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
		<input type="hidden" name="useremail" value="${sessionScope.loginMember.email}">
		<input type="hidden" name="pjno" value="${modal.pjno}">
		<input type="hidden" name="dudu" value="calendar">
		</form>
		</div>
	</div>	
</c:forEach>
<div class="pop_area">
      <div id="divpop1" class="divpop">    
          <div class="title_area">
          	
          	</div>
          <div style="height:80%; display:flex; flex-direction: column; align-items:center;">
         	<p>결재 대기중인 문서 ${wait}건</p>
          	<p>완료된 문서 ${finish}건</p>
          	<p>반려된 문서 ${back}건 있습니다.</p>
          </div>
           <div class="button_area">
               <input type='checkbox' name='chkbox' id='todaycloseyn' value='Y'>오늘 하루 이 창을 열지 않음    
               <a href='#' onclick="javascript:closeWin(1);"><B>[닫기]</B></a>
           </div>
      </div>
     </div>
	
</body>
</html>
<script>
<c:forEach items="${project}" var="project">
	console.log("${project}");
</c:forEach>


window.onload = function() {
	window.parent.frames["_right"].location.reload();
}
function rightNavUpdate() {
	window.parent.frames["_right"].location.reload();
}

//쿠키설정    
function setCookie( name, value, expiredays ) {
var todayDate = new Date();
todayDate.setDate( todayDate.getDate() + expiredays );
document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
}

//쿠키 불러오기
function getCookie(name) 
{ 
    var obj = name + "="; 
    var x = 0; 
    while ( x <= document.cookie.length ) 
    { 
        var y = (x+obj.length); 
        if ( document.cookie.substring( x, y ) == obj ) 
        { 
            if ((endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        
        if ( x == 0 ) break; 
    } 
    return ""; 
}

//닫기 버튼 클릭시
function closeWin(key)
{
    if($("#todaycloseyn").prop("checked"))
    {
        setCookie('divpop'+key, 'Y' , 1 );
    }
    $(".pop_area").hide();
}

$(function(){    
    if(getCookie("divpop1") !="Y"){
        $("#divpop1").show();
    }
});

<c:forEach items="${projectList}" var="btn">
if("${sessionScope.loginMember.auth}" >='3'){
	$('#up_${btn.pjno}').show();
	$('#de_${btn.pjno}').show();
	$('#ad_${btn.pjno}').show();
	$('#rm_${btn.pjno}').show();
	$('#seldiv_${btn.pjno}').show();
}
else{
	$('#up_${btn.pjno}').hide();
	$('#de_${btn.pjno}').hide();
	$('#ad_${btn.pjno}').hide();
	$('#rm_${btn.pjno}').hide();
	$('#seldiv_${btn.pjno}').hide();
}
</c:forEach>


function opendailydd(no){
	   const ff = no;
	   window.location.replace("dailyList.do?pjno="+ff);
}

function dailyupdate(title){
	if($('#datitle_'+title).val() == ""){
		alert("제목을 입력해주세요");
	}
	else if($('#dacnt_'+title).val() == ""){
		alert("내용을 입력해주세요");
	}
	else{
		const dailyform = document.getElementById(title);
		dailyform.setAttribute("action","dailyupdate.do");
		var pjtitle = document.createElement('input');
		pjtitle.type="hidden";
		pjtitle.name="pjtitle";
		pjtitle.value= $('#daproject_'+title+' option:selected').text();
		$('#pjno_'+title).val($('#daproject_'+title+' option:selected').val());
		dailyform.appendChild(pjtitle);
		dailyform.submit();
	}
}
function dailydelete(title){
	const dailyform = document.getElementById(title);
	$('#pjno_'+title).val($('#daproject_'+title+' option:selected').val());
	dailyform.setAttribute("action","dailydelete.do");
	dailyform.submit();
}

function dailyclose(no){
	var daily = document.getElementById("da_"+no);
	daily.style.display = "none";
}

$('#pjregist').click(function(){
	
	var start = new Date($('#pjstart').val());
	var end = new Date($("#pjend").val());
	
	var sub = Math.ceil((end-start)/(1000*60*60*24));
	

	if($('#pjtitle').val() == ""){
		alert("제목을 입력해주세요");
	}
	else if($('#pjcnt').val() ==""){
		alert("내용을 입력해주세요");
	}
	else if($('#pjstart').val() == "" || $('#pjend').val()==""){
		alert("날짜를 입력해주세요");
		
	}else if(sub < 0){
		alert("날짜를 정확하게 입력해주세요");
	}
	else if($('#pjmember').length == 0 ){
		alert("팀원을 등록해주세요");
	}
	else{

	$('input:checkbox[id="pjmember"]').prop("checked",true);
	document.sub2.submit();
	}
	
})

$('#dailyregist').click(function(){
	if($('#datitle').val() == ""){
		alert("제목을 입력해주세요");
	}
	else if($('#dacnt').val() == ""){
		alert("내용을 입력해주세요");
	}
	else{
	var pjtitle = document.createElement('input');
	pjtitle.type="hidden";
	pjtitle.name="pjtitle";
	pjtitle.value= $('#daproject option:selected').text();
	$('#pjno').val($('#daproject option:selected').val());
	console.log("pjno = "+$('#daproject option:selected').val());
	document.forms["sub3"].appendChild(pjtitle);
	document.sub3.submit();
	}
})
	
	function closedd(no){
	const cc = document.getElementById("pjno_"+no);
	cc.style.display = "none";
}
	
function updatedd(title){
	
	var start = new Date($('#pjstart_'+title).val());
	var end = new Date($("#pjend_"+title).val());
	
	var sub = Math.ceil((end-start)/(1000*60*60*24));
	
	if($('#pjtitle_'+title).val() == ""){
		alert("제목을 입력해주세요");
	}
	else if($('#pjcnt_'+title).val() ==""){
		alert("내용을 입력해주세요");
	}
	else if($('#pjstart_'+title).val() == "" || $('#pjend_'+title).val()==""){
		alert("날짜를 입력해주세요");
		
	}else if(sub < 0){
		alert("날짜를 정확하게 입력해주세요");
	}
	else if($('#pjmember_'+title).length == 0 ){
		alert("팀원을 등록해주세요");
	}
	else{
	$('input:checkbox[id="pjmember_'+title+'"]').prop("checked",true);
	const dd = document.getElementById(title);
	dd.setAttribute("action","pjupdate.do");
	dd.submit();
	console.log(dd);
	}

}
if("${sessionScope.loginMember.auth}" == "0"){
	<c:forEach items="${projectList}" var="btn">
		$('#pjupdate_${btn.pjno}').hide();
		$('#pjdelete_${btn.pjno}').hide();
		$('#pjadd_${btn.pjno}').hide();
		$('#pjremove_${btn.pjno}').hide();
	</c:forEach>
}

function deletedd(title){
	const dd = document.getElementById(title);
	dd.setAttribute("action","pjdelete.do");
	dd.submit();
	console.log(dd);
}

function logdd(no) {
    const dd = document.getElementById(no);
    dd.setAttribute("action", "pllist.do");
    dd.submit();
    console.log(dd);
 }
	
	function openProject(){
		var project = document.getElementById("modal1");		
		project.style.display = "inline-block";
	}
	
	function openDaily(){
		var daily = document.getElementById("modal2");
		daily.style.display = "inline-block";
	}
	
	var closeproject = document.getElementById("close");
	closeproject.onclick = function (){
		var project = document.getElementById("modal1");
		project.style.display = "none";

	}
	
	document.getElementById("closedaily").onclick = function(){
		
		var daily = document.getElementById("modal2");
		daily.style.display = "none";
	}
	
	
	document.getElementById("add").onclick = function(){
		var add = $("#username option:selected").text();
		$('#member').append("<label style='font-size: 9pt;'><input id='pjmember' name='pjmember' type='checkbox' value="+add+">"+add+"</label>");
		$('#username option:selected').remove();
	}
	
	document.getElementById("remove").onclick = function(){
		var result ="";
		$("input:checkbox[id='pjmember']").each(function(){
			if($(this).is(":checked")==true){
				result += $(this).val();
				$(this).parent().remove();
				$('#username').prepend("<option value='"+result+"'>"+result+"</option>");
			}


		})
		if(result == ""){
			alert("삭제할 참가자를 선택하세요");
			return false;
		}
	}

	function add(no){
		var ad = $("#username_"+no+" option:selected").text();
		$('#member_'+no).append("<label style='font-size:9pt;'><input id='pjmember_"+no+"'name='pjmember' type='checkbox' value="+ad+">"+ad+"</label>");
		$('#username_'+no+'option:selected').remove();
	}
	
	function drop(no){
		var result ="";
		$("input:checkbox[id='pjmember_"+no+"']").each(function(){
			if($(this).is(":checked")==true){
				result += $(this).val();
				$(this).parent().remove();
				$('#username_'+no).prepend("<option value='"+result+"'>"+result+"</option>");
			}	
		})
		if(result == ""){
			alert("삭제할 참가자를 선택하세요");
			return false;
		}
	}
	
	
</script>