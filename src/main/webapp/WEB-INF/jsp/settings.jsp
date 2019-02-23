<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Settings</title>
    <link rel="stylesheet" href="../../resources/css/style.css">
    <link rel="stylesheet" href="../../resources/css/tabs.css">


    <link href="../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>

    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='http://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js'></script>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.0/js/materialize.min.js'></script>

    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <sec:csrfMetaTags/>

    <script type="text/javascript" language="javascript">
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");
        var csrfToken = $("meta[name='_csrf']").attr("content");
    </script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<script>
    function submitUserMetaChanges() {
        var user = {
            name: document.getElementById("name").value

        };

        var json = JSON.stringify(user);
        var xhr = new XMLHttpRequest();
        xhr.open("POST", '/quizApp/update-user', true);
        xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
        xhr.setRequestHeader(csrfHeader, csrfToken);
        xhr.send(json);

        alert("<spring:message code='label.successfullySaved'/>");
    }

    function submitUserChanges() {
        var user = {
            password: document.getElementById("password").value

        };
        if (document.getElementById("password").value !== document.getElementById("confirmPassword").value) {
            alert("<spring:message code='label.passwodrsDoesntMatch'/>")
        } else {
            var json = JSON.stringify(user);
            var xhr = new XMLHttpRequest();
            xhr.open("POST", '/quizApp/update-user-password', true);
            xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
            xhr.setRequestHeader(csrfHeader, csrfToken);
            xhr.send(json);

            alert("<spring:message code='label.successfullySaved'/>");
        }
    }
</script>

<a href="/quizApp">
    <svg style="width:50px;height:50px; margin-top:-40px" viewBox="0 0 24 24" class="arrowBack">
        <path fill="#666666" d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"/>
    </svg>

</a>
<div class="tab-set">
    <input id="tab-1" name="tab-group" class="tab" type="radio" checked>
    <label for="tab-1" class="tabLabel"> <spring:message code="label.name"/>
    </label>

    <input id="tab-2" name="tab-group" class="tab" type="radio">
    <label for="tab-2" class="tabLabel"><spring:message code="label.password"/></label>


    <div class="tab__content">
        <p><spring:message code="label.name"/>:<input id="name" value="${user.name}"></p>

        <button type="submit" onclick="submitUserMetaChanges()"><spring:message
                code="label.submit"/></button>
    </div>

    <div class="tab__content">
        <p><spring:message code="label.newPassword"/><input type ="password" id="password"></p>
        <p><spring:message code="label.сonfirmPassword"/><input type ="password" id="confirmPassword"></p>

        <button onclick="submitUserChanges()"><spring:message
                code="label.submit"/></button>

    </div>

</div>

</body>
</html>