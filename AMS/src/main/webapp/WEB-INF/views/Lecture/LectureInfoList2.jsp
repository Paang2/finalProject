<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value='${toDay}' pattern='yyyy' var="nowDate"/>
<!DOCTYPE html>
<html>
<head>
<style>
	#my_offer {
        display: none;
        width: 80%;
        height: 40%;	
        padding: 30px 60px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }
     #my_offer .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
    .modal-body{
    	font-size: 10pt;
    }	
    
    .lecutretbl{
		--bs-table-bg: transparent;
		--bs-table-striped-color: #212529;
		--bs-table-striped-bg: rgba(0, 0, 0, 0.05);
		--bs-table-active-color: #212529;
		--bs-table-active-bg: rgba(0, 0, 0, 0.1);
		--bs-table-hover-color: #212529;
		--bs-table-hover-bg: rgba(0, 0, 0, 0.075);
		width: 100%;
	    color: #212529;
	    vertical-align: top;
	    border-color: #dee2e6;
	}
	th,td{
		border-color: inherit;
	    border-style: solid;
	    border-width: 0;
	    text-align: center;
	    padding: 10px; 
	}
	input{
		width: 100px;
	}
	.SaveBtn{
		margin: 10px;
		width: 100px;
		height: 40px;
	}
	.pagemove{
		display: block;
		color: black;
	}
	.tui-grid-cell .tui-grid-cell-content {
    text-align: center;
}
</style>
<meta charset="UTF-8">
<!-- Toast grid -->
	<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
	<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
	<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"></script>
	<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<title>수정 :: No.M University</title>
</head>
<body>
<div class="content-page">
<div align="center">
<h2>수강정보</h2>
<div align="right">
	<a href="ProfessorLectureList" class="pagemove">등록된 수강 목록</a>
</div>

</div>
<!-- model -->
<div id="my_offer" align="center">
    <a class="modal_close_btn">닫기</a>
    <div class="modal-body">
	   <h2> 수강 등록 </h2>
	   <form id = "frm" action="LectureInsert" >
	   <sec:csrfInput/>
	   <table class="lecutretbl" id="lecutretbl"  border="1">
	   		<thead>
	   		<tr>
	   			<th>년도</th>
	   			<th>학기</th>
	   			<th>강의번호</th>
	   			<th>강의이름</th>
	   			<th>교수번호</th>
	   			<th>정원</th>
	   			<th>교재</th>
	   			<th>시간표</th>
	   			<th>강의실 코드</th>
	   		</tr>
	   		</thead>
	   		
	   		<tbody></tbody>
	   </table>
	   <div align="center">
	   <button type="submit" class="SaveBtn">수강 등록하기</button>
	   </div>
	   </form>
	</div>
</div>
<!-- model end -->

<div id="grid"></div>
	<script> 
	//grid start
		var clsData = [
			<c:forEach items="${Lectures }" var="Lec">
			{
				lNum: '${Lec.LNum}', lName: '${Lec.LName}', pId: '${Lec.PId}',
				grade: '${Lec.grade}', limitCount: '${Lec.limitCount}', dCode: '${Lec.DCode}',
				division: '${Lec.division}', credit: '${Lec.credit}'
			},
			</c:forEach>
			]; //컬럼DATA

        // GRID 를 보여준다.
		var grid = new tui.Grid( {
			el: document.getElementById('grid'),
			pagination: true,   //페이징 처리
		    pageOptions: {
		    	useClient: true,   //페이징 처리
		    	perPage: 10   //페이징 갯수
		    }
			,
			columns: [
				{header: '강의번호',name: 'lNum'},
				{header: '강의이름',name: 'lName'},
				{header: '교수코드',name: 'pId'},
				{header: '학년',name: 'grade'},
				{header: '정원',name: 'limitCount'},
				{header: '이수코드',name: 'dCode'},
				{header: '이수구분',name: 'division'},
				{header: '학점',name: 'credit'},
			], //컬럼갯수
			data: clsData
		} );
	//grid end
			
	//그리드 이벤트
		$(function(){
			grid.on('dblclick', ev => {
				//console.log('더블클릭!', ev.rowKey);
				var data = grid.getRow(ev.rowKey); //그리드 한 행의 전체값
				showOffer(data);
			});
			
			//모달 start
			function showOffer(data) {
				modal('my_offer');
				console.log(data.lNum);
				var lnum = data.lNum;
				var lcode = data.lCode;
				var pid = data.pId;
				var grade = data.grade;
				var limitCount = data.limitCount;
				var lname = data.lName;
				var mcode = data.mCode;
				var dcode = data.dCode;
				var division = data.division;
				var credit = data.credit;
				

				$("#lecutretbl tbody").empty();
				$('<tr>')
				.append($('<td>').html('2021'))
				.append($('<td>').html($('<select id=\'term\' name=\'term\'>')
						.append($('<option value=\'1\'>1학기</option>'))
						.append($('<option value=\'2\'>2학기</option>'))))
				.append($('<td>').html(lnum))
				.append($('<td>').html(lname))
				.append($('<td>').html(pid))
				.append($('<td>').html($('<input type=\'text\' id=\'newLimitCount\' name=\'newLimitCount\'>').val(limitCount)))
				.append($('<td>').html($('<input type=\'text\' id=\'book\' name=\'book\'>')))
				.append($('<td>').html($('<input type=\'text\' id=\'timeTable\' name=\'timeTable\'>')))
				.append($('<td>').html($('<select id=\'lrCode\' name=\'lrCode\'>')
					 <c:forEach items="${LR }" var="lr">
					 .append($('<option value=\'${lr.lrCode}\'>${lr.lrName}</option>'))
					</c:forEach>
						))
				.append($('<input type=\'hidden\' id=\'lYear\' name=\'lYear\'>').val('2021'))
				.append($('<input type=\'hidden\' id=\'lNum\' name=\'lNum\'>').val(lnum))
				.append($('<input type=\'hidden\' id=\'pId\' name=\'pId\'>').val(pid))
				.appendTo("#lecutretbl tbody"); 
				
				
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
			
			
		});

		
	</script>
</div>
</body>
</html>