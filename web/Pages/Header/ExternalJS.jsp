	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--Debug mode-->

	<script src="./common/JS/vendor/minimized/jquery-2.1.4.min.js"></script>
	<script src="./common/JS/vendor/minimized/underscore-min.js"></script>
	<script src="./common/JS/vendor/minimized/backbone-min.js"></script>
	<script src="./common/JS/vendor/minimized/d3.min.js"></script>
	<script src="./common/JS/vendor/minimized/moment.min.js"></script>
	<script src="./common/JS/vendor/minimized/moment-range.min.js"></script>
	<c:if test='${currents}'>
		<script src="./common/JS/vendor/minimized/spectrum.min.js"></script>
	</c:if>

	<!--this is the Mobile case-->
	<c:if test='${mobile}'>
		<script src="./common/JS/vendor/minimized/jquery.mobile.min.js"></script>
		<script src="./common/JS/vendor/minimized/jquery.slidePanel.js"></script>
		<script src="./common/JS/vendor/minimized/jquery_ui_datepicker/jquery-ui.min.js"></script>
                <script src="./common/JS/vendor/minimized/bootstrap.min.js"></script>
	</c:if>
	<!--this is the Desktop case-->
	<c:if test='${!mobile}'>
		<script src="./common/JS/vendor/minimized/jquery-ui.min.js"></script>
		<script> $.widget.bridge('uitooltip', $.ui.tooltip); </script>	
		<script src="./common/JS/vendor/minimized/bootstrap.min.js"></script>
	</c:if>
        <c:if test='${language.equals("ES")}'>
            <!--script src="./common/JS/vendor/minimized/jquery_ui_datepicker/datepicker-es.js"></script-->
        </c:if>
            
        <!--script src="./common/JS/vendor/minimized/highcharts.js"></script-->
        <script src="http://code.highcharts.com/highcharts.js"></script>
        <script src="http://code.highcharts.com/highcharts-more.js"></script>
        <script src="./common/JS/vendor/minimized/data.js"></script>
        <!--script src="./common/JS/vendor/minimized/exporting.js"></script-->
        <script src="http://code.highcharts.com/modules/exporting.js"></script>
        
        <!--script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.13/moment-timezone-with-data-2012-2022.min.js"></script>

        <!-- libraries for new calendars -->
        <script src="//cdn.webix.com/edge/webix.js"></script>
        <script src="//cdn.webix.com/edge/i18n/es.js"></script>