<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="<c:url value='../../css/dudu/admin.css'/>">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>회원 관리</title>
</head>
<body>
<button type="button" onclick="backToCalendar()" class="back">
		<span class="material-symbols-outlined">arrow_back</span>
	</button>
	<div class="mainDiv">
		<div class="adminTitle">회원 관리</div>
		<table class="adminTable">
			<thead>
				<tr>
					<th>선택</th>
					<th>이름</th>
					<th>이메일</th>
					<th>직급</th>
					<th>가입 상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${user}" var="user">
					<tr>
						<td><input type="checkbox" name="chk" value="${user.useremail}"></td>
						<td>${user.username}</td>
						<td>${user.useremail}</td>
						<td>${user.userrank}</td>
						<c:choose>
							<c:when test="${user.userstatus eq '승인'}">
								<td style="color:blue;">가입 승인</td>
							</c:when>
							<c:otherwise>
								<td style="color:red;">가입 미승인</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="buttonArea">
			<input class="adminButton" type="button" value="가입 승인" onclick="regist()">
			<input class="adminButton" type="button" value="직급 변경" onclick="openModal()">
		</div>
	</div>
	<div class="adminPaging">
	    <c:choose>
	        <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
	        <c:when test="${paging.page<=1}">
	            <span class="material-symbols-outlined" style="font-size: 15px; margin: 0;"> arrow_back_ios_new </span>
	        </c:when>
	        <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
	        <c:otherwise>
	            <a href="/admin.do?page=${paging.page-1}">
	            	<span class="material-symbols-outlined" style="font-size: 15px; margin: 0;"> arrow_back_ios_new </span>
				</a>
	        </c:otherwise>
	    </c:choose>
	
	    <%--  for(int i=startPage; i<=endPage; i++)      --%>
	    <c:forEach begin="${paging.startPage}" end="${paging.endpage}" var="i" step="1">
	        <c:choose>
	            <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
	            <c:when test="${i eq paging.page}">
	                <span style="color: #2277d7;">${i}</span>
	            </c:when>
	
	            <c:otherwise>
	                <a href="/admin.do?page=${i}">${i}</a>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	
	    <c:choose>
	        <c:when test="${paging.page>=paging.maxPage}">
	            <span style="font-size: 15px; margin: 0;" class="material-symbols-outlined"> arrow_forward_ios </span>
	        </c:when>
	        <c:otherwise>
	        	<a href="/admin.do?page=${paging.page+1}">
					<span style="font-size: 15px; margin: 0;" class="material-symbols-outlined"> arrow_forward_ios </span>
				</a>
	        </c:otherwise>
	    </c:choose>
	</div>
	
	<!-- 직급 변경 모달 -->
	<div id="tradeModal" class="modal">
		<div class="modalContent">
			<div  style="display: flex; justify-content: space-between;margin-bottom: 40px;">
				<div class="modalTitle">직급 변경</div>
				<div class="close" onclick="closeModal()">x</div>
			</div>
			<div style="text-align: center;">
				<select id="md">
					<option value="연구원">연구원</option>
					<option value="선임연구원">선임연구원</option>
					<option value="책임연구원">책임연구원</option>
					<option value="팀장">팀장</option>
				</select>
				<button onclick="trade()" class="modalBtn">확인</button>
			</div>
		</div>
	</div>
	
<script>
/* var frameset = window.parent.document.getElementsByTagName('frameset')[1];
frameset.setAttribute('cols', '0,*,235px'); */

function backToCalendar(){
	window.parent.frames['_calendar'].location.replace("duducalendar.do");
}
	
	function openModal() {
		document.getElementById("tradeModal").style.display = "block";
	}
	
	function closeModal() {
		document.getElementById("tradeModal").style.display = "none";
	}

	function regist(){
		const selected = document.querySelectorAll('input[name="chk"]:checked');
		const cnt = selected.length;
		
		if($('input:checkbox[name="chk"]').is(':checked')==false){
			alert("아이디를 선택해주세요");
			return false;
		}
		
		const form = document.createElement("form");
		form.setAttribute("method","get");
		form.setAttribute("action","adminregist.do");
		
		$('input:checkbox[name="chk"]').each(function(){
			if($(this).is(':checked')==true){
				const input1 = document.createElement("input");
				input1.setAttribute("type","hidden");
				input1.setAttribute("name","useremail");
				input1.setAttribute("value",$(this).val());
				form.appendChild(input1);
			}
		});

		document.body.appendChild(form);
		form.submit();
	}
	
	function trade(){
		var trade = $('#md option:selected').val();
		const form = document.createElement("form");
		form.setAttribute("method","get");
		form.setAttribute("action","admintrade.do");
		if($('input:checkbox[name="chk"]').is(':checked')==false){
			alert("아이디를 선택해주세요");
			return false;
		}
		$('input:checkbox[name="chk"]').each(function(){
			if($(this).is(':checked')==true){
				const rank = document.createElement("input");
				const email = document.createElement("input");
				const role = document.createElement("input");
				
				rank.setAttribute("type","hidden");
				rank.setAttribute("name","userrank");
				rank.setAttribute("value",trade);
				
				email.setAttribute("type","hidden");
				email.setAttribute("name","useremail");
				email.setAttribute("value",$(this).val());
				
				role.setAttribute("type","hidden");
				role.setAttribute("name","userrole");
				
				if(trade == "연구원"){
					role.setAttribute("value",0);
				}
				else if(trade == "선임연구원"){
					role.setAttribute("value",1);
				}else if(trade == "책임연구원"){
					role.setAttribute("value",2);
				}else if(trade == "팀장"){
					role.setAttribute("value",3);
				}
				
				form.appendChild(role);
				form.appendChild(email)
				form.appendChild(rank);
			}
		});
		console.log(form);
		document.body.appendChild(form);
		form.submit();
		
		closeModal();
	}
</script>
</body>
</html>
