<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib
uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
  <link
    href="http://fonts.googleapis.com/earlyaccess/notosanskr.css"
    rel="stylesheet"
  />
  
  <head>
  <script src="textarea_MaxCharacterLimit.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script
      type="text/javascript"
      src="http://code.jquery.com/jquery-latest.min.js"
    ></script>
    <script
      type="text/javascript"
      src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"
    ></script>
    <script
      type="text/javascript"
      src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"
    ></script>

    <style>
      .container23 {
        width: 1200px;
        border: 1px solid black;
        margin: 40px;
        padding: 30px;
      }
      .innercontainer23 {
        align: center;
        width: 100%;
      }
      .ns23 {
        font-family: "Noto Sans KR", sans-serif;
        align: center;
      }

      .inbox {
        width: 180px;
        text-align: center;
      }
      .schedulebox {
        width: 99%;
        text-align: center;
      }
    </style>

    <script type="text/javascript">
      function sub() {
        if (frm2.content.value == "") {
          alert("강의개요를 입력하세요");
          frm2.content.focus();
          return false;
        }
        frm2.submit();
        alert("정상등록 되었습니다");
      }
    </script>

    <meta charset="UTF-8" />
    <title>강의 계획서 수정 :: No.M University</title>
  </head>
  <body>
   
    <button id="createpdf">pdf 생성</button>

    <div class="content-page" id="pdfwrap">
      <div class="container23">
        <h1 align="center" class="ns23">강 의 계 획 서</h1>

        <p>${spList.lyear}년도 ${spList.term} 학기</p>

        <div class="innercontainer23">
          <table align="center" bgcolor="#d2d2d2" width="100%" class="ns23">
            <tr width="200" height="100%">
              <th><font size="3">교과목 명</font></th>
              <th>
                <input class="inbox" type="text" value="${spList.lname}" />
              </th>
              <th><font size="3">담당교수</font></th>
              <th>
                <input class="inbox" type="text" value="${spList.pname}" />
              </th>
              <th><font size="3">이메일</font></th>
              <th>
                <input type="text" class="inbox" value="${spList.email}" />
              </th>
              <th><font size="3">교수 연락처</font></th>
              <th>
                <input type="text" class="inbox" value="${spList.pphone} " />
              </th>
            </tr>
          </table>

          <br />

          <table align="center" bgcolor="#d2d2d2" width="100%" class="ns23">
            <tr>
              <th><font size="3">수강학과</font></th>
              <th>
                <input type="text" class="inbox" value="${spList.mname}" />
              </th>
              <th><font size="3">수강학부</font></th>
              <th>
                <input type="text" class="inbox" value="${spList.dname}" />
              </th>
              <th><font size="3">강의실</font></th>
              <th>
                <input type="text" class="inbox" value="${spList.lrname}" />
              </th>
              <th><font size="3">교재</font></th>
              <th>
                <input type="text" class="schedulebox" value="${spList.book}" />
              </th>
            </tr>
            <tr>
              <th>강의 코드</th>
              <td>
                <input type="text" class="inbox" value="${spList.lnum }" />
              </td>
              <th>-</th>
              <td>
                <input type="text" class="inbox" value="${spList.dividenum }" />
              </td>
              <th>강의 시간</th>
              <td colspan="3">
                <input
                  type="text"
                  class="schedulebox"
                  value="${spList.schedule }"
                />
              </td>
            </tr>

            <tr>
              <th><font size="3">학점</font></th>
              <th>
                <input type="text" value="${spList.credit}" class="inbox" />
              </th>
              <th><font size="3">대상학년</font></th>
              <th>
                <input type="text" value="${spList.grade}" class="inbox" />
              </th>
              <th><font size="3">정원</font></th>
              <th>
                <input
                  type="text"
                  value="${spList.newlimitcount}"
                  class="inbox"
                />
              </th>
              <th><font size="3">이수구분</font></th>
              <th>
                <input
                  type="text"
                  value="${spList.division}"
                  class="schedulebox"
                />
              </th>
            </tr>
          </table>

          <br />
          <form action="studyPlanUpdate" method="post" id="frm2">
            <sec:csrfInput />
            <input type="hidden" name="opennum" value="${spList.opennum}" />
            <table width="100%" align="center" bgcolor="#d2d2d2" class="ns23">
              <tr>
                <th><p align="left">&nbsp; 1. 교과목 개요</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="content"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.content}</textarea
                  >
                </td>
              </tr>
            </table>

            <br />
            <br />
            <label class="ns23"
              >3. 주차별 강의 진행 과정
              <span style="color: #aaa"> (최대 300자) </span></label
            >
            <table width="100%" bgcolor="#d2d2d2" class="ns23">
              <br />

              <tr>
                <th><p align="left">&nbsp; 1주차 강의</p></th>
              </tr>
              <tr height="20">
                <td>
                  <textarea
                    name="w1"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                    maxlength="300"
                  >
${spList.w1 }</textarea
                  >
                </td>
              </tr>

              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 2주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w2"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w2}</textarea
                  >
                </td>
              </tr>

              <tr></tr>

              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 3주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w3"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w3}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 4주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w4"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w4}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 5주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w5"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w5}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 6주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w6"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w6}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 7주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w7"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w7}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 8주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    placeholder="중간고사 기간"
                    name="w8"
                    id="limit"
                    rows="3"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w8}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 9주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w9"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w9}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 10주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w10"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w10}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 11주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w11"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                   maxlength="300"
                  >
${spList.w11}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 12주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w12"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w12}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 13주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w13"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w13}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 14주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w14"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w14}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 15주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w15"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                     maxlength="300"
                  >
${spList.w15}</textarea
                  >
                </td>
              </tr>
              <tr></tr>

              <tr>
                <th><p align="left">&nbsp; 16주차 강의</p></th>
              </tr>

              <tr height="20">
                <td>
                  <textarea
                    name="w16"
                    rows="3"
                    id="limit"
                    style="resize: none; width: 99%"
                    placeholder="기말고사 기간"
                     maxlength="300"
                  >
${spList.w16}</textarea
                  >
                </td>
              </tr>
            </table>

            <h3 align="center">
              <button type="button" class="ns23" value="submit" onclick="sub()">
                ●등록
              </button>
              <input type="reset" class="ns23" value="● 취소" />
              <input
                type="button"
                class="ns23"
                name="back"
                value="● 뒤로가기"
                onClick="location.href='studyPlanList'"
              />
            </h3>
          </form>
        </div>
      </div>
    </div>
  </body>
  <script>
    $("#createpdf").click(function () {
      //pdf_wrap을 canvas객체로 변환
      /* 	  html2canvas($('#pdfwrap')[0]).then(function(canvas) {
	    var doc = new jsPDF('p', 'mm', 'a4'); //jspdf객체 생성
	    var imgData = canvas.toDataURL('image/png'); //캔버스를 이미지로 변환
	    doc.addImage(imgData, 'PNG', 0, 0); //이미지를 기반으로 pdf생성
	    doc.save('LecturePlan-file.pdf'); //pdf저장
	    alert('클릭됨');
	  }); */

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
        alert("클릭됨");
      });
    });
  </script>
 
</html>
