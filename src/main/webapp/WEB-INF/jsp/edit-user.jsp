<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student</title>
    <link rel="stylesheet" href="../../../resources/css/style.css">
    <link rel="stylesheet" href="../../../resources/css/table.css">

    <link href="../../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>

    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='http://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js'></script>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.0/js/materialize.min.js'></script>

    <sec:csrfMetaTags/>
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <script type="text/javascript" language="javascript">
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");
        var csrfToken = $("meta[name='_csrf']").attr("content");
    </script>
    <script>
        function sendUserChanges() {

            var roleIndex = document.getElementById("select").options.selectedIndex;
            var role = document.getElementById("select").options[roleIndex].value;

            var user = {
                id: ${user.id},
                enabled: document.getElementById("enabled").checked,
                role: "ROLE_" + role.toUpperCase()
            };
            var json = JSON.stringify(user);

            var xhr = new XMLHttpRequest();
            xhr.open("POST", '/quizApp/admin/save-user', true);
            xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
            xhr.setRequestHeader(csrfHeader, csrfToken);
            xhr.send(json);

            alert("<spring:message code='label.successfullySaved'/>");
        }

        function deleteUser() {
            if (confirm('<spring:message code="label.areYouSure"/>')) {
                var roleIndex = document.getElementById("select").options.selectedIndex;
                var role = document.getElementById("select").options[roleIndex].value;

                var user = {
                    id: ${user.id},
                    isEnabled: document.getElementById("enabled").checked,
                    role: "ROLE_" + role.toUpperCase()
                };
                var json = JSON.stringify(user);

                var xhr = new XMLHttpRequest();
                xhr.open("POST", '/quizApp/admin/delete-user', true);
                xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
                xhr.setRequestHeader(csrfHeader, csrfToken);
                xhr.send(json);
                window.location.href='<c:url value="/quizApp/admin"/>'

            }
        }

    </script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<a href="/quizApp/admin">
    <svg style="width:50px;height:50px; margin-top:-40px" viewBox="0 0 24 24" class="arrowBack">
        <path fill="#666666" d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"/>
    </svg>
</a>
<div class="mainContainer" style="display: flex; justify-content: center;">
    <div style="font-size: x-large;">
        <p><spring:message code="label.name"/> : ${user.name}</p>
        <p><spring:message code="label.loginName"/> : ${user.email}</p>
        <p><spring:message code="label.role"/> :
            <c:if test="${user.role eq 'ROLE_TEACHER'}">
                Teacher
            </c:if>
            <c:if test="${user.role eq 'ROLE_STUDENT'}">
                Student
            </c:if>
            <c:if test="${user.role eq 'ROLE_REQUEST'}">
                Request
            </c:if>
            <c:if test="${user.role eq 'ROLE_ADMIN'}">
                Admin
            </c:if>
            <c:if test="${user.role eq 'ROLE_REJECTED'}">
                Rejected
            </c:if>
        </p>
        <p>
            <spring:message code="label.changeRole"/> :
            <select id="select" style="margin-top: 8px;margin-bottom: 0; vertical-align: top;">
                <option
                        <c:if test="${user.role eq 'ROLE_TEACHER'}">selected</c:if> >
                    Teacher
                </option>
                <option
                        <c:if test="${user.role eq 'ROLE_STUDENT'}">selected</c:if> >
                    Student
                </option>
                <option
                        <c:if test="${user.role eq 'ROLE_REQUEST'}">selected</c:if> >
                    Request
                </option>
                <option
                        <c:if test="${user.role eq 'ROLE_ADMIN'}">selected</c:if> >
                    Admin
                </option>
                <option
                        <c:if test="${user.role eq 'ROLE_REJECTED'}">selected</c:if> >
                    Rejected
                </option>
            </select>
        </p>
        <p><spring:message code="label.userEnabled"/> :

            <input id="enabled" type="checkbox" style=" margin-top: 11px; margin-bottom: 0; vertical-align: top;"
                   <c:if test="${user.enabled}">checked </c:if> >

        </p>
        <button onclick="sendUserChanges()"><spring:message code="label.submit"/></button>
    </div>
    <div>
        <svg onclick="deleteUser()" style=" width:30px;height:30px" viewBox="0 0 24 24" class="deleteIcon">
            <path fill="#666666" class="deleteIcon"
                  d="M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z"/>
        </svg>
    </div>
</div>

</body>
</html>