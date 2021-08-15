<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="tiles"
uri="http://tiles.apache.org/tags-tiles"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib
uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
  <head>
    <!-- 부트스트랩 -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
      integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
      crossorigin="anonymous"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- toast grid -->
    <link
      rel="stylesheet"
      href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css"
    />
    <link
      rel="stylesheet"
      href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css"
    />
    <link href="tui-date-picker.css" rel="stylesheet" />
    <script
      type="text/javascript"
      src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"
    ></script>
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
    <link
      rel="stylesheet"
      href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css"
    />
    <script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

    <!-- 풀 캘린더 -->
    <!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.css" />
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.css" />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/locales-all.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/locales-all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.js"></script> -->

    <!-- 모달 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css"
    />

    <!-- <link rel="stylesheet" href="resources/css/mainCss.css" /> -->

    <!-- ZOTER -->
    <link rel="shortcut icon" href="resources/assets/images/favicon.ico" />

    <!-- jvectormap -->
    <link
      href="resources/assets/plugins/jvectormap/jquery-jvectormap-2.0.2.css"
      rel="stylesheet"
    />
    <link
      href="resources/assets/plugins/fullcalendar/vanillaCalendar.css"
      rel="stylesheet"
      type="text/css"
    />

    <link href="resources/assets/plugins/morris/morris.css" rel="stylesheet" />

    <link
      href="resources/assets/css/bootstrap.min.css"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="resources/assets/css/icons.css"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="resources/assets/css/style.css"
      rel="stylesheet"
      type="text/css"
    />

    <!-- jQuery  -->
    <script src="resources/assets/js/jquery.min.js"></script>
    <script src="resources/assets/js/popper.min.js"></script>
    <script src="resources/assets/js/bootstrap.min.js"></script>
    <script src="resources/assets/js/modernizr.min.js"></script>
    <script src="resources/assets/js/detect.js"></script>
    <script src="resources/assets/js/fastclick.js"></script>
    <script src="resources/assets/js/jquery.blockUI.js"></script>
    <script src="resources/assets/js/waves.js"></script>
    <script src="resources/assets/js/jquery.nicescroll.js"></script>

    <script src="resources/assets/plugins/jvectormap/jquery-jvectormap-2.0.2.min.js"></script>
    <script src="resources/assets/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>

    <script src="resources/assets/plugins/skycons/skycons.min.js"></script>
    <script src="resources/assets/plugins/fullcalendar/vanillaCalendar.js"></script>

    <script src="resources/assets/plugins/raphael/raphael-min.js"></script>
    <script src="resources/assets/plugins/morris/morris.min.js"></script>

    <script src="resources/assets/pages/dashborad.js"></script>

    <!-- App js -->
    <script src="resources/assets/js/app.js"></script>
    <link rel="stylesheet" href="resources/css/mainCss.css" />

    <!-- pdf 다운로더 -->
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
  </head>

  <body>
    <div class="AMScontainer">
      <div class="content-page">
        <header>
          <tiles:insertAttribute name="header" />
        </header>
        <nav>
          <tiles:insertAttribute name="nav" />
        </nav>
        <article>
          <tiles:insertAttribute name="content" />
        </article>
      </div>
    </div>
  </body>
</html>
