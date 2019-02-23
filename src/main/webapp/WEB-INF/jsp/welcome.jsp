<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Welcome on quiz system!</title>

    <link rel="stylesheet" href="../../resources/css/tabs.css">
    <link rel="stylesheet" href="../../resources/css/style.css">
    <link href="../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>

    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">

</head>
<body class="welcomeBg" style="overflow-y: hidden">
<div class="topMenu">
    <div class="menuHeader" style="text-align: left">
        <svg style="width:50px;height:50px;margin-left: 20px" viewBox="0 0 24 24">
            <path fill="#ffffff"
                  d="M9,19V13H11L13,13H15V19H18V10.91L12,4.91L6,10.91V19H9M12,2.09L21.91,12H20V21H13V15H11V21H4V12H2.09L12,2.09Z"/>
        </svg>
    </div>
    <div style="display: flex;align-items: center;margin-right: 15px;">
        <div>
            <a href="?lang=en"><img src="../../resources/img/en.png" style="width:30px"> </a>
        </div>
        <div style="margin-top: -1px;">
            <p style="font-size: 30px; margin-top: 24px;" class="welcomeDivider">|</p>
        </div>
        <div>
            <a href="?lang=ru"> <img src="../../resources/img/ru.svg" style="width:30px"> </a>
        </div>
    </div>
    <c:if test="${role eq '[ROLE_ANONYMOUS]'}">
        <div style="margin-top: 15px">
            <input type="button" value=" <spring:message code="label.signIn"/>" class="signInButton"
                   onclick="window.location.href='<c:url value="/quizApp/login"/>'"/>
        </div>
        <div style="margin-top: 15px">
            <input type="button" value="<spring:message code="label.signUp"/>" class="signUpButton"
                   onclick="window.location.href='<c:url value="/quizApp/register"/>'"/>
        </div>
    </c:if>
    <c:if test="${role ne '[ROLE_ANONYMOUS]'}">
        <div style="margin-top: 15px">
            <input type="button" value="<spring:message code="label.Logout"/>" class="logOutButton"
                   onclick="window.location.href='<c:url value="/quizApp/logout"/>'"/>
        </div>
    </c:if>
</div>
<div>
    <c:if test="${role eq '[ROLE_TEACHER]'}">
    <div class="welcomeContainer">
        <div class="welcomeContainerRegistered">
            <div style=" display: flex;
                         justify-content: center;">
                <div class="welcomeContainerBg">
                    <h1><spring:message code="label.teacherSlogan"/></h1>
                    <h2><img src="../../resources/img/teacher.png" style="width: 300px"></h2>
                    <div style="margin-top: -100px">
                        <button class="bigButton"
                                onclick="window.location.href='<c:url value="/quizApp/teacher"/>'">
                            <spring:message code="label.mainPage"/>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</c:if>
<c:if test="${role eq '[ROLE_STUDENT]'}">
    <div class="welcomeContainer">
        <div class="welcomeContainerRegistered">
            <div style=" display: flex;
                         justify-content: center;">
                <div class="welcomeContainerBg">
                    <h1><spring:message code="label.studentSlogan"/></h1>
                    <h2>
                        <img src="../../resources/img/student.png" style="width: 300px">
                    </h2>
                    <div style="margin-top: -50px">
                        <button class="bigButton" style="margin-top: 0px"
                                onclick="window.location.href='<c:url value="/quizApp/student"/>'">
                            <spring:message code="label.mainPage"/>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${role eq '[ROLE_ADMIN]'}">
    <div class="welcomeContainer">
        <div class="welcomeContainerRegistered">
            <div style=" display: flex;
                         justify-content: center;">
                <div class="welcomeContainerBg">
                    <h1><spring:message code="label.adminSlogan"/></h1>

                    <h2>
                        <img src="../../resources/img/admin.png" style="width: 350px">
                    </h2>
                    <div style="margin-top: -40px">
                        <button class="bigButton" style="margin-top: 0px"
                                onclick="window.location.href='<c:url value="/quizApp/admin"/>'">
                            <spring:message code="label.mainPage"/>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${role eq '[ROLE_ANONYMOUS]'}">
    <div class="welcomeContainer">
        <div class="welcomeContainerInfo">
            <div style=" display: flex;
                         justify-content: center;">
                <div class="welcomeContainerBg">
                    <h1><spring:message code="label.welcome"/></h1>
                    <div class="slogan"><spring:message code="label.slogan"/> 🚀</div>
                    <button value="Sign up" class="bigButton"
                            onclick="window.location.href='<c:url value="/quizApp/register"/>'">
                        <spring:message code="label.start"/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${role eq '[ROLE_REQUEST]'}">
    <div class="welcomeContainer">
        <div class="welcomeContainerInfo">
            <div style=" display: flex;
                         justify-content: center;">
                <div class="welcomeContainerBg">
                    <h1><spring:message code="label.wait"/></h1>
                    <img src="../../resources/img/wait.png" style="width: 300px">
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${role eq '[ROLE_REJECTED]'}">
    <div class="welcomeContainer">
        <div class="welcomeContainerInfo">
            <div style=" display: flex;
                         justify-content: center;">
                <div class="welcomeContainerBg">
                    <h1><spring:message code="label.youAreRejected"/></h1>
                    <img src="../../resources/img/sad.png" style="width: 300px">
                </div>
            </div>
        </div>
    </div>
</c:if>

</body>
</html>