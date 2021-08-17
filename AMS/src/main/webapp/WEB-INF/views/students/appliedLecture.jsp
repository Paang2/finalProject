<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	/* 교수 정보 모달 */
	#my_offer {
		display: none;
		width: 80%;
		height: 30%;
		padding: 30px 60px;
		background-color: #fefefe;
		border: 1px solid #888;
		border-radius: 3px;
	}

	#my_offer .modal_close_btn, 
	#modal_offer .modal_close_btn, 
	#modal_evaluation .modal_close_btn{
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
	
	.tui-grid-cell .tui-grid-cell-content {
		text-align: center;
	}
	
	td[data-column-name="lnum"] {
		color : skyblue;
	}

	td[data-column-name="pname"] {
		color : skyblue;
	}
	
	td[data-column-name="lname"] {
		color : skyblue;
	}
	
	.btn15 {
       height: 15px;
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
	
	/* 모달창 강의 계획서 */
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
	
	/* 모달창 강의 평가 */
	#modal_evaluation {
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
	
	/* 그리드 클릭 이벤트 방해하고 있던 것 */
	.tui-grid-cell-header.tui-grid-cell-selected {
		background-color: unset;
	}
	.tui-grid-layer-selection {
		display: none;
	}
</style>

<!-- Toast grid -->
<link rel="stylesheet" href="resources/css/studentsInfo.css" />

<title>수강 확인 :: No.M University</title>

<div class="content-page">
	<div class="card-body">
		<div align="center">
			<h2>수강 신청된 강의 리스트</h2>
			<div id="grid"></div>
			<div class="total">
				<div class="scheduleTime"></div>
				<p></p>
				<div id="scheduleShow"></div>
			</div>
		</div>
	</div>
</div>


<!-- 모달 뷰 : 교수 정보-->
<div id="my_offer" align="center">
	<a class="modal_close_btn">닫기</a>
	<div class="modal-body">
		<h2>교수 정보</h2>
		<table class="table table-bordered" id="professorInfo">
			<thead>
				<tr>
					<th>교수명</th>
					<th>연락처</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</div>
<!-- 모달 뷰 끝 -->


<!-- 모달 뷰2 : 강의 계획서 -->
<!-- 모달 뷰2 _ 강의 계획서 보기 -->
<div class="modal_offer" id="modal_offer" align="center">
	<a class="modal_close_btn">닫기</a>
	<div class="modal-body">
		<button id="createpdf" style="float: right">pdf 생성</button>
		
		<div class="container23" id="pdfwrap">
			<h1 align="center" class="ns23">강 의 계 획 서</h1>
			<p id="plan_term"></p>
			<div class="innercontainer23">
				<table style="align: center; background-color: #d2d2d2; width: 100%" class="ns23">
					<tr style="width: 200px; height: 100%">
						<th style="width: 200px"><font size="3">강의명</font></th>
						<th>
							<input type="text" name="plan_lname" class="inbox" readonly />
						</th>
						<th><font size="3">교수</font></th>
						<th>
							<input type="text" name="plan_pname" class="inbox" readonly />
						</th>
						<th><font size="3">이메일</font></th>
						<th>
							<input type="text" name="plan_email" class="inbox" readonly />
						</th>
						<th><font size="3">교수 연락처</font></th>
						<th>
							<input type="text" name="plan_pphone" class="inbox" readonly style="width: 200px"/>
						</th>
					</tr>
				</table>
				<br />
				<table style="align: center; background-color: #d2d2d2; width: 100%" class="ns23">
					<tr>
						<th style="width: 200px"><font size="3">학과</font></th>
						<th>
							<input type="text" name="plan_mname" class="inbox" readonly />
						</th>
						<th><font size="3">학부</font></th>
						<th>
							<input type="text" name="plan_dname" class="inbox" readonly />
						</th>
						<th><font size="3">강의실</font></th>
						<th>
							<input type="text" name="plan_lrname" class="inbox" readonly />
						</th>
						<th><font size="3">교재</font></th>
						<th>
							<input type="text" name="plan_book" class="schedulebox" readonly style="width: 200px"/>
						</th>
					</tr>
					<tr>
						<th>강의 코드</th>
						<td>
							<input type="text" name="plan_lnum" class="inbox" readonly />
						</td>
						<th>-</th>
						<td>
							<input type="text" name="plan_dividenum" class="inbox" readonly />
						</td>
						<th style="width: 200px">강의 시간</th>
						<td colspan="3">
							<input type="text" name="plan_schedule" class="schedulebox" readonly />
						</td>
					</tr>
					<tr>
						<th><font size="3">학점</font></th>
						<th>
							<input type="text" name="plan_credit" class="inbox" readonly />
						</th>
						<th><font size="3">대상학년</font></th>
						<th>
							<input type="text" name="plan_grade" class="inbox" readonly />
						</th>
						<th><font size="3">정원</font></th>
						<th>
							<input type="text" name="plan_newlimitcount" class="inbox" readonly />
						</th>
						<th><font size="3">이수구분</font></th>
						<th>
							<input type="text" name="plan_division" class="schedulebox" readonly />
						</th>
					</tr>
				</table>
			</div>
      		<br>
			<table style="width: 100%; align: center; background-color: #d2d2d2" class="ns23">
				<tr>
					<th><p align="left">&nbsp; 1. 교과목 개요</p></th>
				</tr>
		        <tr height="20">
					<td>
						<textarea name="plan_content" rows="3" style="resize: none; width: 99%" readonly></textarea>
					<td>
				</tr>
			</table>
			<br>
			<label class="ns23">3. 주차별 강의 진행 과정
				<span style="color: #aaa"> (최대 300자) </span>
			</label>
			<table style="width: 100%; background-color: #d2d2d2" class="ns23">
				<tr>
					<th><p align="left">&nbsp; 1주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w1" rows="3" style="resize: none; width: 99%" wrap="hard" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 2주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w2" rows="3" style="resize: none; width: 99%" wrap="hard" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 3주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w3" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 4주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w4" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 5주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w5" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 6주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w6" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 7주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w7" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 8주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea placeholder="중간고사 기간" name="w8" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 9주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w9" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 10주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w10" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 11주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w11" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 12주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w12" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 13주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w13" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 14주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w14" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 15주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
				    	<textarea name="w15" rows="3" style="resize: none; width: 99%" readonly></textarea>
					</td>
				</tr>
				<tr></tr>
				<tr>
					<th><p align="left">&nbsp; 16주차 강의</p></th>
				</tr>
				<tr height="20">
					<td>
						<textarea name="w16" rows="3" style="resize: none; width: 99%" placeholder="기말고사 기간" readonly></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<!-- 모달 뷰2 끝 -->


<!-- 모달3 _ 강의 평가 보기 -->
<div  id="modal_evaluation" align="center">
	<a class="modal_close_btn">닫기</a>
	<div class="modal-body">
		<h1>강의 만족도 결과 공개</h1>
		<table class = "table table-borderd" border="1" style = "align: center">
			<thead>
			<tr>
				<th>년도/학기</th> 
				<th>강의번호</th>
				<th>강의 명</th>
				<th>담당교수</th>
				<th>평점</th>
			</tr>
			</thead>
			<tbody id = "resultBody">
			<%-- <c:forEach items="${st }" var="st">
				<tr>
					<th>${st.lyear} - ${st.term}</th>
					<th>${st.lnum } - ${st.dividenum }</th>
					<th>${st.lname }</th>
					<th>${st.pname }</th>	
					<th>${st.a1 }</th>
				</tr>
			</c:forEach> --%>
			</tbody>
		</table>
	</div>
</div>


<!-- 히든 -->
<%-- <div id = "hiddenData">
	<c:forEach items = "${st }" var = "hi" varStatus = "seq">
		<input type = "hidden" id = "hidden_lname${seq.count }" value = "${hi.lname }">
		<input type = "hidden" id = "hidden_timetable${seq.count }" value = "${hi.timetable }">
		<input type = "hidden" id = "hidden_lrname${seq.count }" value = "${hi.lrname }">
	</c:forEach>
</div> --%>

<script>

	//boolean
	let isEmpty = 0;
	
	//강의 계획서 모달에 필요한 값
	let pid;
	let opennum;
		
	// 비동기 결과 값 담기용 변수
	let p_term = document.getElementById("plan_term");
	let p_lname = document.getElementsByName("plan_lname")[0];
	let p_pname = document.getElementsByName("plan_pname")[0];
	let p_email = document.getElementsByName("plan_email")[0];
	let p_pphone = document.getElementsByName("plan_pphone")[0];
	let p_mname = document.getElementsByName("plan_mname")[0];
	let p_dname = document.getElementsByName("plan_dname")[0];
	let p_lrname = document.getElementsByName("plan_lrname")[0];
	let p_book = document.getElementsByName("plan_book")[0];
	let p_lnum = document.getElementsByName("plan_lnum")[0];
	let p_dividenum = document.getElementsByName("plan_dividenum")[0];
	let p_schedule = document.getElementsByName("plan_schedule")[0];
	let p_credit = document.getElementsByName("plan_credit")[0];
	let p_grade = document.getElementsByName("plan_grade")[0];
	let p_newlimitcount = document.getElementsByName("plan_newlimitcount")[0];
	let p_division = document.getElementsByName("plan_division")[0];
	let p_content = document.getElementsByName("plan_content")[0];
	let p_week = [
		"w1",
		"w2",
		"w3",
		"w4",
		"w5",
		"w6",
		"w7",
		"w8",
		"w9",
		"w10",
		"w11",
		"w12",
		"w13",
		"w14",
		"w15",
		"w16",
	];
		
	for (let i = 1; i <= p_week.length; i++) {
		p_week[i - 1] = document.getElementsByName("w" + [i])[0];
	}

	let colorArr = ['table-danger', 'table-warning', 'table-info', 'table-success', 'table-primary', 'table-active'];
	//let totaltime = "";
	
	// 강의 시간을 한 문자로 묶기(ex : 월1화2...)
	let getValue = [];
 	<c:forEach items = "${st}" var = "st" varStatus = "seq">
		//totaltime += '${st.timetable}'
		getValue["${st.timetable }"] = ['${st.lname}','${st.lrname}', colorArr[${seq.index}]];
	</c:forEach>
	
	//console.log("밸류 : " ,getValue);	
		
	////////////////////////////////////
	
	// 그리드
	var lecData = [
		
		<c:forEach items = "${st}" var = "st">{
			// 이 페이지 실질적 데이터
			lnum 		: '${st.lnum}' +'-' + '${st.dividenum}',
			lname 		: '${st.lname}',
			division 	: '${st.division}',
			credit 		: '${st.credit}',
			timetable 	: '${st.timetable}',
			lrname 		: '${st.lrname}',
			pname 		: '${st.pname}',
			
			// 필요에 의한 값 땡겨오기.
			email		: '${st.email}',
			pphone		: '${st.pphone}',
			pid			: '${st.pid}',
			opennum		: '${st.opennum}',
			evaluation: '<button id="openbtn${st.opennum}" onclick="openpage(${st.opennum})" class ="btn btn-facebook m-l-10 waves-effect waves-light btn15">확인</button>'
				
		}
		<c:if test='${!empty st.lnum}'>
		,
		</c:if>
		</c:forEach>
	];
	
	// 그리드를 보여준다
	var grid = new tui.Grid({
		
		el: document.getElementById('grid'),
		data: lecData,
		columns: [
			{header: '강의코드', name: 'lnum'},
			{header: '강의명', name: 'lname'},
			{header: '이수구분', name: 'division'},
			{header: '학점', name: 'credit'},
			{header: '강의시간', name: 'timetable'},
			{header: '강의실', name: 'lrname'},
			{header: '교수', name: 'pname'},
			{header:'강의평가',name:'evaluation'}
			
		] //컬럼갯수
	});

	grid.resetData(lecData) //그리드를 그려놓고 데이터를 넣음
	// 그리드 끝

	// 클릭 이벤트
	grid.on('click', ev =>{
		
		var data = grid.getRow(ev.rowKey);
		const isHeader = ev.targetType === "columnHeader";
		
		// 강의 평가 보기
		if (ev.columnName == "lnum" && !isHeader) {
			
			evaluationData(data);
			
			if (isEmpty == -1) {
				alert("신설된 강의입니다. 평가 내용이 없습니다.");
				isEmpty = 0;
			} else if (isEmpty == 1) {
				modal("modal_evaluation");
				isEmpty = 0;
			}
		}
		
		// 교수 정보 보기
		if (ev.columnName == "pname" && !isHeader) {
			showOffer(data);
		}
		
		// 강의 계획서 보기
		if (ev.columnName == "lname" && !isHeader) {
			
			planData(data);
			
			if (isEmpty == -1) {
				alert("강의 계획서가 작성되어 있지 않은 강의입니다.");
				isEmpty = 0;
			} else if (isEmpty == 1) {
				modal("modal_offer");
				isEmpty = 0;
			}
		}
		
	});

	
	// 교수 정보 담기
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

	
	// 강의 계획서 정보 불러오기
	function planData(data) {
		// 비동기로 쓸 받은 값
		pid = data.pid;
		opennum = data.opennum;
			
		$.ajax({
			url: "planView",
			async: false,
			data: {
				pid: pid,
				opennum: opennum,
			},
			success: function (result) {
				if (result.content != null) {
					//$('#plan_lname').attr("value", result.lname);
					p_term.innerHTML = result.lyear + "년도 " + result.term + "학기";
					p_lname.value = result.lname;
					p_pname.value = result.pname;
					p_email.value = result.email;
					p_pphone.value = result.pphone;
					p_mname.value = result.mname;
					p_dname.value = result.dname;
					p_lrname.value = result.lrname;
					p_book.value = result.book;
					p_lnum.value = result.lnum;
					p_dividenum.value = result.dividenum;
					p_schedule.value = result.schedule;
					p_credit.value = result.credit;
					p_grade.value = result.grade;
					p_newlimitcount.value = result.newlimitcount;
					p_division.value = result.division;
					p_content.value = result.content;
					
					for (let i = 1; i <= p_week.length; i++) {
						p_week[i - 1].value = result["w" + i];
					}
					
					isEmpty = 1;
				} else {
					isEmpty = -1;
				}
			},
			error: function (err) {
				console.log(err);
			}
		});
	}
	
	// 강의 평가 정보 불러오기
	function evaluationData(data) {
		//let rBody = document.getElementById('resultBody');
			  lnum = data.lnum.substring(0,5);
			  $("#resultBody").empty();
			  
		$.ajax({
			url: "EresultSt",
			async: false,
			data: {lnum : lnum},
			success: function (result) {
				if (result.length != 0 && result[0].a1 != null) {
					isEmpty = 1;
					// 데이터 변수들 담기
					for (let i = 0; i < result.length; i++) {
						let tr = $('<tr />');
							tr.append(
								$('<td>' + result[i].lyear + " - " + result[i].term + '</td>'),
								$('<td />').html(result[i].lnum), // + " - " + result[i].dividenum 분반 필요하나
								$('<td />').html(result[i].lname),
								$('<td />').html(result[i].pname),
								$('<td />').html(result[i].a1)
							); 
						$("#resultBody").append(tr);	        	  
					}
				} else {
					  isEmpty = -1;
					}
				},
				error: function (err) {
				  console.log(err);
				}
		});
	}
	
	

	// 테이블에 타이틀 추가하기 기능
	function addTitle() {
		
		let thead = $("<thead />").attr("class", "thead-dark");
		let title = $('<tr />');
		title.append(
			$('<th scope="col" style="width: 15%"  />').html(''),
			$('<th scope="col" style="width: 17%" />').html('월'),
			$('<th scope="col" style="width: 17%" />').html('화'),
		   	$('<th scope="col" style="width: 17%" />').html('수'),
		   	$('<th scope="col" style="width: 17%" />').html('목'),
		   	$('<th scope="col" style="width: 17%" />').html('금')
		);
		thead.append(title);
		
		return thead;
	};

	document.addEventListener("DOMContentLoaded", function(){
		
		// 테이블 생성
		let sTable = $('<table />').attr('class', 'table showSchedule').attr("style", "width:1000px; height: 550px;");
		sTable.append(addTitle());
		
		let week = [
			"",
			"월",
			"화",
			"수",
			"목",
			"금"
		];
		
		let timeseq =[
			`1교시<br>09:00 ~ 10:15`,
			`2교시<br>10:30 ~ 11:45`,
			`3교시<br>12:00 ~ 13:15`,
			`4교시<br>13:30 ~ 14:45`,
			`5교시<br>15:00 ~ 16:15`,
			`6교시<br>16:30 ~ 17:45`,
			`7교시<br>18:00 ~ 19:15`,
			`8교시<br>19:30 ~ 20:45`,
			`9교시<br>21:00 ~ 22:15`,
		];
		/* "1교시" + "<br>" + "09:00 ~ 10:00",
		"2교시" + "<br>" + "09:00 ~ 10:00",
		"3교시" + "<br>" + "09:00 ~ 10:00",
		"4교시" + "<br>" + "09:00 ~ 10:00",
		"5교시" + "<br>" + "09:00 ~ 10:00",
		"6교시" + "<br>" + "09:00 ~ 10:00",
		"7교시" + "<br>" + "09:00 ~ 10:00",
		"8교시" + "<br>" + "09:00 ~ 10:00",
		"9교시" + "<br>" + "09:00 ~ 10:00" */
		
		for(let i = 0; i < timeseq.length; i++){
			let tr = $('<tr />');
			for(let j = 0; j < week.length; j++){
				
			//	console.log("위크 : " + week[j] + i);
			//	console.log("토탈 : " + totaltime.indexOf(week[j] + i));
				/* 
				let time = null;
				let lec = null;
				let room = null;
				try {
					// for문 반복 횟수보다 아이디가 부족할 경우 value 없다고 에러뜸
					
					time = document.getElementById('hidden_timetable' + i).value;
					lec = document.getElementById('hidden_lname' + i).value;
					room = document.getElementById('hidden_lrname' + i).value;
				} catch (e) {
					console.log(e);
				}
				 */
				// console.log('시간 : ' + time);
				// console.log('강의명 : ' + lec);
				// console.log('장소 : ' + room);
				
				if (j == 0){
					// 테이블 첫 번째 자리에 강의 시간 집어넣기
					
					// td에 아이디값 안 줘도 될 듯? 
					// tr.append($('<td class="table-secondary timeCol" id = "jackpot'+ i + '-' + j +'"/>').html(timeseq[i]));
					tr.append($(`<td class = table-secondary timeCol id = jackpot${i}-${j}>)`).html(timeseq[i]));
	
				} else {
					
					let curTime = week[j] + (i + 1);
					//console.log("컬타임 : " + curTime);
					
					//과목찾기
					let lectureName = "";
					let tColor = "";
					for(lectureTime in getValue){
						if(lectureTime.indexOf(curTime) != -1){
							tColor = " class = '" + getValue[lectureTime][2] + " detailCul'";
							lectureName = getValue[lectureTime][0] + "<br>" + lectureTime + "<br>" + getValue[lectureTime][1];
						}
					}
					//console.log(lectureName);
						
					// 강의 집어넣기
					tr.append($('<td '+ tColor +' id =  "jackpot'+ i+ '-' + j + '"/>').html(lectureName));
				}
			}
			sTable.append(tr);
		}
		$('#scheduleShow').append(sTable);
	});
	
	
	function openpage(data){
		var opennum = data;
		location.href="Evaluation?opennum="+opennum
	}
	
	
	// pdf 다운로드
	$("#createpdf").click(function () {
		html2canvas($("#pdfwrap")[0]).then(function (canvas) {
			var filename = "LecturePlan_" + Date.now() + ".pdf";
			var doc = new jsPDF("p", "mm", "a4");
			var imgData = canvas.toDataURL("image/png");
			var imgWidth = 210;
			var pageHeight = 295;
			var imgHeight = (canvas.height * imgWidth) / canvas.width;
			var heightLeft = imgHeight;
			var position = 0;
			doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
			
			heightLeft -= pageHeight;
			
			while (heightLeft >= 0) {
				position = heightLeft - imgHeight;
				doc.addPage();
				doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
				heightLeft -= pageHeight;
			}
			doc.save(filename);
		});
	});
	
</script>