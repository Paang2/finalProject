<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
해결 과제
	1. 모달창
		- 스크롤 내린 뒤 닫고 새 모달창을 열면 닫은 시점에서 열림
		- pdf 출력
	
	2. 그리드
		- 강의 평가 버튼
	
	3. 검색창
		- css 통일 문제
 -->


<style>
	.tui-grid-cell .tui-grid-cell-content {
		text-align: center;
	}
	
	#my_offer {
		display: none;
		width: 80%;
		height: 30%;
		padding: 30px 60px;
		background-color: #fefefe;
		border: 1px solid #888;
		border-radius: 3px;
	}
	
	#my_offer .modal_close_btn, #modal_offer .modal_close_btn{
		position: absolute;
		top: 10px;
		right: 10px;
	}
	
	.modal-body {
		font-size: 10pt;
	}
	
	.professorInfo { -
		-bs-table-bg: transparent; -
		-bs-table-striped-color: #212529; -
		-bs-table-striped-bg: rgba(0, 0, 0, 0.05); -
		-bs-table-active-color: #212529; -
		-bs-table-active-bg: rgba(0, 0, 0, 0.1); -
		-bs-table-hover-color: #212529; -
		-bs-table-hover-bg: rgba(0, 0, 0, 0.075);
		width: 100%;
		color: #212529;
		vertical-align: top;
		border-color: #dee2e6;
	}
	
	th, td {
		border: 1;
		border-color: inherit;
		border-style: solid;
		/*border-width: 0;*/
		text-align: center;
		padding: 10px;
		width: 150px;
	}
	
	td[data-column-name="pname"] {
		color : skyblue;
	}
	
	td[data-column-name="lname"] {
		color : skyblue;
	}
	
	/********************************************************************/
	/* 강의 계획서 모달에 쓰이는 스타일 */
	.container23{
		width: 1200px;
		border: 1px solid black;
		margin: 40px;
		padding: 30px;
	}
	
	.innercontainer23{
 		align : center;
		width: 100%;
	}
	
	.ns23{
		font-family: 'Noto Sans KR', sans-serif;
		align: center;
	}
	
	textarea{
		word-break: break-all;
	}
	
	.inbox{
		width: 180px;
		text-align: center;
		height:25px;
	}
	
	.schedulebox{
		width: 99%;
 		text-align: center;
 		height:25px;
	}
	
	#modal_offer {
	    /* overflow-y: initial !important; */
	    
	    display: none;
		width: 80%;
		height: 80%;
		padding: 30px 60px;
		background-color: #fefefe;
		border: 1px solid #888;
		border-radius: 3px;
	}
	
	/* 모달 스크롤 */
	#modal_offer .modal-body{
	    height: 100%;
	    overflow-y: auto;
	}
	.tui-grid-cell-header.tui-grid-cell-selected {
		background-color: unset;
	}
	.tui-grid-layer-selection {
		display: none;
	}
</style>
<title>강의 조회 페이지</title>

<!-- 본체 -->
<div align = "center">
	<h2>강의 조회 페이지</h2>
		<div class = "selectArea">
			<font>학과 : </font>
			<select name = "dname" id = "dname">
				<option value = "">전체</option>
				<c:forEach items = "${depart }" var = "depart">
					<option value = "${depart.dname }">${depart.dname }</option>
				</c:forEach>
			</select>
			<font>전공 : </font>
			<select name = "mcode" id = "mcode">
				<option value = "">전체</option>
			</select>
			<div class = "lecture_division">
				<font>구분 : </font>
				<input type = "radio" name = "division" value = "교양">교양
				<input type = "radio" name = "division" value = "전공">전공
				<input type = "radio" name = "division" value = "대학원">대학원	<!-- 없음 -->
				<input type = "radio" name = "division" value = "" checked>전체
			</div>
			<font>위치 : </font>
			<select name = "location">
				<option value = "">전체</option>
				 <c:forEach items = "${room }" var = "room">
				 	<option value = "${room.location }">${room.location }</option>
				 </c:forEach>
			</select>
			<br>
			<font>학년 : </font>
			<select name = "grade">
				<option value = "">전체</option>
				<option value = "1">1</option>
				<option value = "2">2</option>
				<option value = "3">3</option>
				<option value = "4">4</option>
			</select>
			<br>
			<font>요일 : </font>
			<select name = "day">
				<option value = "">전체</option>
				<option value = "월">월</option>
				<option value = "화">화</option>
				<option value = "수">수</option>
				<option value = "목">목</option>
				<option value = "금">금</option>
			</select>
			<font>교시 : </font>
			<select name = "time">
				<option value = "">전체</option>
				<option value = "1">1교시</option>
				<option value = "2">2교시</option>
				<option value = "3">3교시</option>
				<option value = "4">4교시</option>
				<option value = "5">5교시</option>
				<option value = "6">6교시</option>
				<option value = "7">7교시</option>
				<option value = "8">8교시</option>
				<option value = "9">9교시</option>
			</select>
			<button id = "searchBtn">검색</button>
		</div>
	<div id = "grid"></div>
</div>
<!-- 본체 끝 -->


<!-- 모달 뷰-->
<div id="my_offer" align="center">
	<a class="modal_close_btn">닫기</a>
	<div class="modal-body">
		<h2>교수 정보</h2>
		<table class="professorInfo" id="professorInfo" border="1">
			<thead>
				<tr>
					<th>교수</th>
					<th>연락처</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</div>
<!-- 모달 끝 -->


<!-- 모달 뷰2 -->
<div class="modal_offer" id = "modal_offer" align = "center">
	<a class = "modal_close_btn">닫기</a>
	<div class = "modal-body">
		<button id="createpdf" style= "float : right;">pdf 생성</button>
		<div class="container23" id="pdfwrap">
			<h1 align="center" class="ns23">강 의 계 획 서</h1>
			<p id = "plan_term"></p>
			<!-- ${spList.lyear}년도 ${spList.term} 학기 -->
			<div class="innercontainer23">
				<table align="center" bgcolor="#d2d2d2" width="100%"  class="ns23">
					<tr width="200" height="100%">
						<th><font size="3">교과목 명</font></th>			<th><input type="text" name = "plan_lname" class ="inbox" readonly> </th>
						<th ><font size="3">교수</font></th>			<th><input type="text" name = "plan_pname" class ="inbox" readonly> </th>
						<th ><font size="3">이메일</font></th>			<th><input type="text" name = "plan_email" class ="inbox" readonly> </th>
						<th ><font size="3">교수 연락처</font></th>		<th><input type="text" name = "plan_pphone" class ="inbox" readonly> </th>
					</tr>
				</table>
				<br>
				<table align="center" bgcolor="#d2d2d2" width="100%"  class="ns23">
					<tr>
						<th><font size="3">수강학과</font></th>			<th><input type="text" name = "plan_mname" class ="inbox" readonly></th>
						<th><font size="3">수강학부</font></th>			<th><input type="text" name = "plan_dname" class ="inbox" readonly> </th>
						<th><font size="3">강의실</font></th>	 			<th><input type="text" name = "plan_lrname" class ="inbox" readonly></th>
						<th><font size="3">교재</font></th>				<th><input type="text" name = "plan_book" class ="schedulebox" readonly></th>
					</tr>
					<tr>				
						<th>강의 코드</th> 								<td><input type="text" name = "plan_lnum" class ="inbox" readonly></td>
						<th> - </th> 									<td><input type="text" name = "plan_dividenum" class ="inbox" readonly></td>
						<th>강의 시간</th>									<td colspan="3"><input type="text" name = "plan_schedule" class="schedulebox" readonly>
					</tr>
					<tr>				
						<th ><font size="3">학점</font></th>	 			<th><input type="text" name = "plan_credit" class ="inbox" readonly></th>
						<th><font size="3">대상학년</font></th>			<th><input type="text" name = "plan_grade" class ="inbox" readonly> </th>
						<th ><font size="3">정원</font></th>				<th><input type="text" name = "plan_newlimitcount" class ="inbox" readonly></th>
						<th><font size="3">이수구분</font></th>			<th><input type="text" name = "plan_division" class ="schedulebox" readonly></th>
					</tr>
				</table>
			</div>
			<br>
			<%-- <input type="hidden" name="opennum" value="${spList.opennum}"> --%>
			<table width="100%"  align="center" bgcolor="#d2d2d2" class="ns23">						
				<tr>					
					<th><p align="left"> &nbsp; 1. 교과목 개요</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="plan_content" rows="3" style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
			</table>
			<br>
			<label class="ns23">3. 주차별 강의 진행 과정 <span style="color:#aaa;"> (최대 300자) </span></label>
			<table width="100%"  bgcolor="#d2d2d2" class="ns23">						
				<br>
				<tr>					
					<th><p align="left">&nbsp; 1주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w1" rows="3" style="resize: none;width:99%;" wrap="hard" readonly></textarea></td>				
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp; 2주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w2" rows="3"  style="resize: none;width:99%;"wrap="hard" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  3주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w3" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  4주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w4" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  5주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w5" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  6주차 강의</p></th>
				</tr>		
				<tr height="20">					
					<td><textarea name="w6" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  7주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w7" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  8주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea  placeholder="중간고사 기간" name="w8" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  9주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w9" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  10주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w10" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  11주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w11" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  12주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w12" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>
					<th><p align="left"> &nbsp;  13주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w13" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  14주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w14" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  15주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w15" rows="3"  style="resize: none;width:99%;" readonly></textarea></td>						
				</tr>					
				<tr></tr>
				<tr>					
					<th><p align="left"> &nbsp;  16주차 강의</p></th>
				</tr>					
				<tr height="20">					
					<td><textarea name="w16" rows="3"  style="resize: none;width:99%;" placeholder="기말고사 기간" readonly></textarea></td>						
				</tr>					
			</table>
		</div>
	</div>
</div>


<script>
	 
	// 아이디가 searchBtn인 버튼을 누르면 searchLecture function을 실행한다.
	document.getElementById('searchBtn').addEventListener('click', searchLecture);
	 
	function searchLecture() {
		 
		let mc = document.getElementsByName('mcode')[0].value;
		let dn = document.getElementsByName('dname')[0].value;
		 
		let divi_value;
		let divi = document.getElementsByName('division');
		for (let i = 0; i < divi.length; i++){
			if (divi[i].checked){
				divi_value = divi[i].value;
			}
		}
		 
		let loca 	= document.getElementsByName('location')[0].value;
		let gra 	= Number(document.getElementsByName('grade')[0].value);
		let day		= document.getElementsByName('day')[0].value;
		let time	= document.getElementsByName('time')[0].value;
		
		let timetable = day + time;
		 
		let data = {
				mcode 		: mc,
				dname 		: dn,
				division 	: divi_value,
				location 	: loca,
				grade 		: gra,
				timetable	: timetable
		};
		 
		grid.readData(1, data, true);
	}
	 
	 
	// 그리드
	// api 쓰게 되면서 얘 의미 없게 되긴 했는데, 주석 처리하자니 교수 이름 때문에 걸리네?
	// seq 값도 못 받음
	/* var lecData = [
		<c:forEach items = "${lec}" var = "lec" varStatus = "seq">{
			// 실질적 값
			seq			: '${seq.count}',
			lnum 		: '${lec.lnum}' + '-' + '${lec.dividenum}',
			lname 		: '${lec.lname}',
			division 	: '${lec.division}',
			credit 		: '${lec.credit}',
			target 		: '${lec.target}',
			pname		: '${lec.pname}',
			timetable 	: '${lec.timetable}',
			lrname 		: '${lec.lrname}',
			limitcount	: '${lec.limitcount}',
			
			// 필요에 의한 값 땡겨오기.
			// email		: '${lec.email}',
			// pphone		: '${lec.pphone}',
			// pid			: '${lec.pid}',
			// opennum		: '${lec.opennum}',
			// evaluation: '<button id="openbtn${lec.opennum}" onclick="openpage(${lec.opennum})">확인</button>'
			
		}
		<c:if test='${!empty lec.lnum}'>
		,
		</c:if>
		</c:forEach>
	]; */
	

	// 그리드를 보여준다
	const grid = new tui.Grid({
		
		el: document.getElementById('grid'),
		data: {
			api: {
				readData: {
					url: "wantLectureList", method: "POST" 
				},
			},
			contentType: "application/json"
		},
		//rowHeaders: ['checkbox'],
		pagination: true,		//페이징 처리
	    pageOptions: {
	    	useClient: true,	//페이징 처리
	    	perPage: 5   		//페이징 갯수
	    }
		,
		columns: [
			//{header: ' ', name: 'seq'},
			{header: '강의코드', name: 'lnum'},
			{header: '강의명', name: 'lname'},
			{header: '이수구분', name: 'division'},
			{header: '학점', name: 'credit'},
			{header: '대상학년', name: 'target'},
			{header: '교수', name: 'pname'},
			{header: '강의시간', name: 'timetable'},
			{header: '강의실', name: 'lrname'},
			{header: '수강정원', name: 'limitcount'},
			{header:'강의평가',name:'evaluation'}
		] //컬럼갯수
	});
	// grid.readData(1, lec, true);
	// grid.resetData(lecData) //그리드를 그려놓고 데이터를 넣음
	// 그리드 끝
	// 그리드 클릭 이벤트
	
	/*
	click 이벤트는 grid 전체 이벤트 클릭이다.
	ev.targetType을 보면 columnHeader와 
	cell: 데이터들
	근데 헤더를 누르면
	cell 데이터에 tui-grid-layer-selection 이라는 div가 생겨서 클릭을 막고있었다.
	css에서 display none 으로 숨겨서 클릭되게 했음.
	*/
	grid.on('click', ev => {
		
		var data = grid.getRow(ev.rowKey);
		const isHeader = ev.targetType === "columnHeader";
		// console.log(ev)
		if (ev.columnName == "pname" && !isHeader) {
			showOffer(data);
		}
		
		if (ev.columnName == "lname" && !isHeader) {
			modalOffer(data);
		}
	});
	
	
	function modalOffer(data) {
		
		modal('modal_offer');
		
		// 비동기로 쓸 받은 값
		let pid 	= data.pid;
		let opennum = data.opennum;
		
		// 비동기 결과 값 담기용 변수
		let p_term			= document.getElementById('plan_term');
		let p_lname 		= document.getElementsByName('plan_lname')[0];
		let p_pname 		= document.getElementsByName('plan_pname')[0];
		let p_email 		= document.getElementsByName('plan_email')[0];
		let p_pphone 		= document.getElementsByName('plan_pphone')[0];
		let p_mname 		= document.getElementsByName('plan_mname')[0];
		let p_dname 		= document.getElementsByName('plan_dname')[0];
		let p_lrname 		= document.getElementsByName('plan_lrname')[0];
		let p_book 			= document.getElementsByName('plan_book')[0];
		let p_lnum 			= document.getElementsByName('plan_lnum')[0];
		let p_dividenum 	= document.getElementsByName('plan_dividenum')[0];
		let p_schedule 		= document.getElementsByName('plan_schedule')[0];
		let p_credit 		= document.getElementsByName('plan_credit')[0];
		let p_grade 		= document.getElementsByName('plan_grade')[0];
		let p_newlimitcount = document.getElementsByName('plan_newlimitcount')[0];
		let p_division 		= document.getElementsByName('plan_division')[0];
		let p_content		= document.getElementsByName('plan_content')[0];
		let p_week = [
			'w1',
			'w2',
			'w3',
			'w4',
			'w5',
			'w6',
			'w7',
			'w8',
			'w9',
			'w10',
			'w11',
			'w12',
			'w13',
			'w14',
			'w15',
			'w16'
		];
		
		for (let i = 1; i <= p_week.length; i++) {
			p_week[i - 1] = document.getElementsByName('w' + [i])[0];
		}
		
		$.ajax({
			url: 'planView',
			data: {
				pid 	: pid,
				opennum : opennum
			},
			success: function(result){
				//$('#plan_lname').attr("value", result.lname);
				p_term.innerHTML		= result.lyear + '년도 ' + result.term + '학기';
				p_lname.value 			= result.lname;
				p_pname.value			= result.pname;
				p_email.value			= result.email;
				p_pphone.value			= result.pphone;
				p_mname.value			= result.mname;
				p_dname.value			= result.dname;
				p_lrname.value			= result.lrname;
				p_book.value			= result.book;
				p_lnum.value			= result.lnum;
				p_dividenum.value		= result.dividenum;
				p_schedule.value		= result.schedule;
				p_credit.value			= result.credit;
				p_grade.value			= result.grade;
				p_newlimitcount.value	= result.newlimitcount;
				p_division.value		= result.division;
				p_content.value			= result.content;
				
				for (let i = 1; i <= p_week.length; i++) {
					p_week[i - 1].value = result['w' + i];
				}
			},
			error: function(err){
				console.log(err);
			}
		});
		
	}
	
	function showOffer(data) {
		
		modal('my_offer');
		
		var pname = data.pname;
		var email = data.email;
		var pphone = data.pphone;
		
		$("#professorInfo tbody").empty();
		$('<tr>')
		.append($('<td>').html(pname))
		.append($('<td>').html(pphone))
		.append($('<td>').html(email))
		.appendTo("#professorInfo tbody");
		
	}
				
	function modal(mm) {
		
	    var zIndex = 9999;
	    var modal = document.getElementById(mm);

	    // 모달 div 뒤에 희끄무레한 레이어
	    var bg = document.createElement('div');
	    bg.setStyle({
	        position: 'fixed',
	        zIndex: zIndex,
	        left: '0px',
	        top: '0px',
	        width: '100%',
	        height: '100%',
	        overflow: 'auto',
	        // 레이어 색갈은 여기서 바꾸면 됨
	        backgroundColor: 'rgba(0,0,0,0.4)'
	    });
	    
	    document.body.append(bg);

	    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
	    modal.querySelector('.modal_close_btn').addEventListener('click', function() {
	        bg.remove();
	        modal.style.display = 'none';
	        // $(this).find('form')[0].reset();	초기화?
	    });

	    modal.setStyle({
	        position: 'fixed',
	        display: 'block',
	        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

	        // 시꺼먼 레이어 보다 한칸 위에 보이기
	        zIndex: zIndex + 1,

	        // div center 정렬
	        top: '50%',
	        left: '50%',
	        transform: 'translate(-50%, -50%)',
	        msTransform: 'translate(-50%, -50%)',
	        webkitTransform: 'translate(-50%, -50%)'
	    });
	}
	
	
	// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
	Element.prototype.setStyle = function(styles) {
	    for (var k in styles) this.style[k] = styles[k];
	    return this;
	};
	
	function openpage(data){
		var opennum = data;
		location.href="Eresultst?opennum="+opennum
	}
	
	// 검색 컬럼 변화
	$("#dname").change(function(){
		
		let v_dname = $(this).val();
		let v_mcode = `<option value = "">전체</option>`;
		
		if (v_dname != ""){
			//$("select[name = 'mcode']" option).remove();
			$(`select[name = mcode] option`).remove();
		
			$.ajax({
				url: 'customDcode',
				type: 'GET',
				data: {dname: v_dname},
				success: function(result) {
					$.each(result, function(i, v){
						//v_mcode += `<option value = ${v.mcode}>${v.mname}</option>`;
						v_mcode += '<option value="'+v.mcode+'">'+v.mname+'</option>';
					});
					$('#mcode').append(v_mcode);
				}
			});
		} else {
			$(`select[name = mcode] option`).remove();
			$('#mcode').append(v_mcode);
		}
	});
	
	
	// pdf
	$('#createpdf').click(function() {

		html2canvas($('#pdfwrap')[0]).then(function (canvas) {
			var filename = 'LecturePlan_' + Date.now() + '.pdf'; 
			var doc = new jsPDF('p', 'mm', 'a4'); 
			var imgData = canvas.toDataURL('image/png'); 
			var imgWidth = 210; 
			var pageHeight = 295; 
			var imgHeight = canvas.height * imgWidth / canvas.width; 
			var heightLeft = imgHeight; 
			var position = 0; doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight); heightLeft -= pageHeight; 
			while (heightLeft >= 0) { position = heightLeft - imgHeight; doc.addPage(); doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight); heightLeft -= pageHeight; } doc.save(filename); 
			alert('클릭됨');
		});
		
	});
</script>