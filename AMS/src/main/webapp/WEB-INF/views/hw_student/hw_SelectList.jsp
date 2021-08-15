<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 현재날짜 -->
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd hh:mm:ss" /></c:set> 
<!DOCTYPE html>
<html>
<head>
<title>과제 리스트 :: No.M University</title>
<style>

		.tui-grid-cell .tui-grid-cell-content {
    text-align: center;
}
.btn-hover.color-9 {
    background-image: linear-gradient(to right, #25aae1, #4481eb, #04befe, #3f86ed);
    box-shadow: 0 4px 15px 0 rgba(65, 132, 234, 0.75);
}
.btn-hover.color-10 {
        background-image: linear-gradient(to right, #ed6ea0, #ec8c69, #f7186a , #FBB03B);
    box-shadow: 0 4px 15px 0 rgba(236, 116, 149, 0.75);
}
.btn-hover.color-11 {
       background-image: linear-gradient(to right, #eb3941, #f15e64, #e14e53, #e2373f);  box-shadow: 0 5px 15px rgba(242, 97, 103, .4);
}
.btn-hover {
    font-size: 11px;
    color: #fff;
    cursor: pointer;
    text-align:center;
    border: none;
    
    border-radius: 50px;
    moz-transition: all .4s ease-in-out;
    -o-transition: all .4s ease-in-out;
    -webkit-transition: all .4s ease-in-out;
    transition: all .4s ease-in-out;
}

.btn-hover:hover {
    background-position: 100% 0;
    moz-transition: all .4s ease-in-out;
    -o-transition: all .4s ease-in-out;
    -webkit-transition: all .4s ease-in-out;
    transition: all .4s ease-in-out;
}

.btn-hover:focus {
    outline: none;
}
	.underline{
	    text-decoration: underline;
	}
		.menu01 {
				width:100%;
				height: 80px;
			    padding: 1em;
			    margin-left: -40px;
				}
				.menu01 ul li{
					list-style-type:none;
					float:left;			
					margin-left:20px;
					font-weight:bold;		
				}
				.modalBtn{ 
				margin-left: -30px;
		  border-radius: 1em;
		    background-color: lightpink;
		    color: white;
		    padding-left: 2em;
		    padding-right: 2em;
		    padding-top: 8px;
		    padding-bottom: 5px;
		    font-size: 20px;
		    border: none;
	     	}	

	.tui-grid-border-line-top {
    border: none;
    }


</style>
</head>
<body>
<div class="content-page">
	<div class="menu01">		
					<ul>
						<li><a class="modalBtn" href="hwStudent">과제 메인페이지 이동</a></li>			
					</ul>
			
				
	</div>
	<div style="    padding-bottom: 40px;">
			<h4> * 선택한 강의과제 목록 *</h4>
			
			<h6  style="float: right;    text-decoration: underline;"> # 제출기한이 지나면 수정이 불가능합니다. </h6>
			<h6 style="clear:both;float:right;"> # 제출하려고 하는 과제는 더블클릭 </h6>
			<br>
			<br>
	</div>

			<div id="grid" ></div>
	
			<script>
			
					  		//grid start
					  			var a=1;
					  				var clsData = [
								<c:forEach items="${result }" var="list">
								
								{
									
									lname: '${list.lname}'
									, lyear: '${list.lyear}'
									, term : '${list.term}'
									,pcomment: '<div class="underline">${list.pcomment}</div>'
									,pperiod: '<fmt:formatDate value="${list.registerDate }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${list.pperiod }" pattern="yyyy-MM-dd"/><c:if test="${list.hwstatus >= 0 }"><br><span style="color:red;">진행중</span> </c:if><c:if test="${list.hwstatus < 0}"><br><span style="color:blue;">마감</span></c:if>'
									,score: '<c:if test="${list.score eq null}">등록된 점수없음</c:if> ${list.score}'
									,submitCheck: '<c:if test="${list.submitCheck > 0 }"><button class="btn-hover color-9">제출완료</button></c:if> <c:if test="${list.submitCheck == 0 }"><button class="btn-hover color-11">미제출</button></c:if>'
									,registerId: '${list.registerId}'
									,opennum:'${list.opennum}'
									,hwstatus:'${list.hwstatus}'
									,submitCheckVal:'${list.submitCheck}'
								},
								
								</c:forEach>
								]; //컬럼DATA	

					  		
					  	       // GRID 를 보여준다.
					  			var grid = new tui.Grid( {
					  				bodyHeight:300,
									el: document.getElementById('grid'),
									pagination: true,   //페이징 처리
								    pageOptions: {
								    	useClient: true,   //페이징 처리
								    	perPage: 6  //페이징 갯수
								    }
									,
					  			columns: [
					  				{header: '강의명',name: 'lname',width:100},
					  				{header: '년도',name: 'lyear',width:60}, //강의번호+분반
					  				{header: '학기',name: 'term',width:90}, //년도+학기
					  				{header: '과제제목',name: 'pcomment',width:350},
					  				{header: '제출기간',name: 'pperiod'},
					  				{header: '점수',name: 'score',width:140},
					  				{header: '제출여부',name: 'submitCheck',width:120},
					  			], //컬럼갯수
					  			data: clsData
					  		} );
						
								
					  			grid.on('dblclick', ev => {	
					        		//console.log('더블클릭!', ev.rowKey);
					        		var data = grid.getRow(ev.rowKey); //그리드 한 행의 전체값
					        		var a=data.registerId;
					        		var b=data.opennum;
									var c=data.submitCheckVal;
									var d=data.hwstatus;
									console.log(d);
									if(d<=0){
									 alert("마감되었습니다");
									}else{
											if(c>0){
												alert("제출한 과제입니다.")
											}else{
												hwSInsertFrm.registerId.value=a;
							        			hwSInsertFrm.opennum.value=b;
							        			hwSInsertFrm.submit();
											}
									 }
									
					        	});
								
					  			
					  			
					  			</script>
			
			
			
			
			
			
			
			
			<!-- 클릭한 해당과제 제출페이지로 이동할값 -->		  			
			<form action="hwSInsert" method="post" id="hwSInsertFrm" name="hwSInsertFrm">
				<sec:csrfInput/>
					<input type="hidden" id="registerId" name="registerId">
					<input type="hidden" id="opennum" name="opennum">
			</form>		  		
			
</div>		
</body>
</html>