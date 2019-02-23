<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="../../resources/css/style.css">
    <link href="../../resources/img/favicon.ico" rel="icon" type="image/x-icon" />

    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">

</head>
<span>
    <a href="?lang=en"><img src="../../resources/img/en.png" style="width:30px"> </a>
    <span style="font-size: 30px">| </span>
    <a href="?lang=ru"> <img src="../../resources/img/ru.svg" style="width:30px"> </a>
</span>
<body class="bodyWithBg">
<div class="loginContainer">
    <svg style="width:100px;height:100px" viewBox="0 0 24 24">
        <path fill="#62c0d4"
              d="M12,3C13.74,3 15.36,3.5 16.74,4.35C17.38,3.53 18.38,3 19.5,3A3.5,3.5 0 0,1 23,6.5C23,8 22.05,9.28 20.72,9.78C20.9,10.5 21,11.23 21,12A9,9 0 0,1 12,21A9,9 0 0,1 3,12C3,11.23 3.1,10.5 3.28,9.78C1.95,9.28 1,8 1,6.5A3.5,3.5 0 0,1 4.5,3C5.62,3 6.62,3.53 7.26,4.35C8.64,3.5 10.26,3 12,3M12,5A7,7 0 0,0 5,12A7,7 0 0,0 12,19A7,7 0 0,0 19,12A7,7 0 0,0 12,5M16.19,10.3C16.55,11.63 16.08,12.91 15.15,13.16C14.21,13.42 13.17,12.54 12.81,11.2C12.45,9.87 12.92,8.59 13.85,8.34C14.79,8.09 15.83,8.96 16.19,10.3M7.81,10.3C8.17,8.96 9.21,8.09 10.15,8.34C11.08,8.59 11.55,9.87 11.19,11.2C10.83,12.54 9.79,13.42 8.85,13.16C7.92,12.91 7.45,11.63 7.81,10.3M12,14C12.6,14 13.13,14.19 13.5,14.5L12.5,15.5C12.5,15.92 12.84,16.25 13.25,16.25A0.75,0.75 0 0,0 14,15.5A0.5,0.5 0 0,1 14.5,15A0.5,0.5 0 0,1 15,15.5A1.75,1.75 0 0,1 13.25,17.25C12.76,17.25 12.32,17.05 12,16.72C11.68,17.05 11.24,17.25 10.75,17.25A1.75,1.75 0 0,1 9,15.5A0.5,0.5 0 0,1 9.5,15A0.5,0.5 0 0,1 10,15.5A0.75,0.75 0 0,0 10.75,16.25A0.75,0.75 0 0,0 11.5,15.5L10.5,14.5C10.87,14.19 11.4,14 12,14Z"/>
    </svg>
    <form method="post" action="<c:url value='/quizApp/j_spring_security_check' />">
        <div class="inputContainer">
            <input name="login" placeholder="<spring:message code="label.loginName"/>">

            <input type="password" name="password" placeholder="<spring:message code="label.password"/>">

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            <c:if test="${not empty msg}">
                <div class="msg">${msg}</div>
            </c:if>
        </div>
        <div class="buttonContainer">
            <a>
                <div>
                    <button type="button" onclick="window.location.href='<c:url value="/quizApp/register"/>'" class="greenButton">
                        <spring:message code="label.registration"/>
                </div>
            </a>
            <a>
                <div>
                    <button type="submit"><spring:message code="label.login"/></button>
                </div>
            </a>

            <a href="#openModal">
                <button class="errorButton" type="button"><spring:message code="label.forgetPass"/></button>
            </a>
        </div>

        <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}"/>
    </form>
    <div id="openModal" class="modalDialog">
        <div class="modalContainer">
            <a href="#close" title="Закрыть" class="close">X</a>
            <img src="https://memepedia.ru/wp-content/uploads/2017/04/JD-CafiHa4k-%E2%80%94-%D0%BA%D0%BE%D0%BF%D0%B8%D1%8F.jpg"
                 style="width:400px " class="nenado">
        </div>
    </div>
</div>

</body>
</html>