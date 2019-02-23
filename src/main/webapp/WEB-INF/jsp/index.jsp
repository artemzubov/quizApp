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
</div>
<div>
    <div class="welcomeContainer">
        <div class="welcomeContainerRegistered">
            <div style=" display: flex;
                         justify-content: center;">
                <div class="welcomeContainerBg">
                    <div>
                        <button class="bigButton" style="font-size: 80px !important;"
                                onclick="window.location.href='<c:url value="/quizApp"/>'">
                            <spring:message code="label.mainPage"/>
                        </button>
                    </div>
                    <div>
                        <a href="https://docs.google.com/presentation/d/1agnm2um5Cogib76puHvCbMpP3U0wloAtIx9Rs7YF4Os/edit?usp=sharing">
                            <button class="bigButton" style="font-size: 80px !important;">
                                <spring:message code="label.viewPresentation"/>
                            </button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>