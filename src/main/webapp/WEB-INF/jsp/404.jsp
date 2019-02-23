<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <link rel="stylesheet" href="../../resources/css/style.css">
    <link href="../../resources/img/favicon.ico" rel="icon" type="image/x-icon" />

</head>
<body style="background-color: #FFFFFF">
<h1 style="text-align: center">Error 404</h1>

<div style="text-align: center; margin-top: 10vh">
    <h2 style="text-align: center;">
        ${title}
        <c:choose>
            <c:when test="${empty username}">
                <h3> Ooops,<spring:message code="label.youHave404"/></h3>
            </c:when>
            <c:otherwise>
                <h3>${username}, <spring:message code="label.youHave404"/></h3>
            </c:otherwise>
        </c:choose>

        <img src="../../resources/img/yoda.jpg" style="width: 230px"/>
        <div>
            <button onclick="window.location.href='<c:url value="/quizApp"/>'">
                <spring:message code="label.goBack"/>
            </button>
        </div>
    </h2>

</div>
</body>
</html>