<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <link rel="stylesheet" href="../../../resources/css/style.css">
    <link href="../../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>

</head>
<body style="background-color: #FFFFFF">
<h1 style="text-align: center">Error</h1>

<div style="text-align: center; margin-top: 5vh">
    <h2 style="text-align: center;">

        <h3>
            <spring:message code="label.youHaveAnError"/>
        </h3>
        <img src="../../../resources/img/developer.png" style="width: 400px; margin-left: -46px;"/>

        <div>
            <button onclick="window.location.href='<c:url value="/quizApp"/>'">
                <spring:message code="label.goBack"/>
            </button>
        </div>
    </h2>

</div>
</body>
</html>