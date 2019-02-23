<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tutor</title>

    <link rel="stylesheet" href="../../resources/css/tabs.css">
    <link rel="stylesheet" href="../../resources/css/style.css">
    <link href="../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>

    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <sec:csrfMetaTags/>
    <script type="text/javascript" language="javascript">
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");
        var csrfToken = $("meta[name='_csrf']").attr("content");
    </script>

    <script>

        function sendRetake(quiz_id, user_id) {

            var passedQuiz = {
                quiz_id: quiz_id,
                user_id: user_id
            };

            var json = JSON.stringify(passedQuiz);
            var xhr = new XMLHttpRequest();
            xhr.open("POST", '/quizApp/teacher/remove-passedQuizzes', true);
            xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
            xhr.setRequestHeader(csrfHeader, csrfToken);
            xhr.send(json);

            alert("<spring:message code='label.retakeSent'/>");

            window.location.reload();
        }

    </script>

</head>
<body class="adminBody">
<jsp:include page="header.jsp"></jsp:include>
<div class="tab-set">

    <input id="tab-1" name="tab-group" class="tab" type="radio" checked>
    <label for="tab-1" class="tabLabel"> <spring:message code="label.testList"/>
    </label>

    <input id="tab-2" name="tab-group" class="tab" type="radio">
    <label for="tab-2" class="tabLabel"><spring:message code="label.testsPassedByStudents"/></label>


    <div class="tab__content">
        <p class="containerHeader">
            <button onclick="window.location.href='<c:url value="/quizApp/teacher/add-quiz"/>'">
                <span style="font-weight: 900;margin: 0">+</span>
            </button>
        </p>

        <c:forEach items="${quizList}" var="quiz">
            <div class="singleTestContainer" id="${quiz.id}">
                <span style="margin-top: 5px"><c:out value="${quiz.title}"/></span>
                <div class="twoButtons">
                    <a href="/quizApp/teacher/single-quiz/${quiz.id}">
                        <button class="smallButton">
                            <svg style="width:20px;height:20px" viewBox="0 0 24 24">
                                <path fill="#fff"
                                      d="M5,3C3.89,3 3,3.89 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V12H19V19H5V5H12V3H5M17.78,4C17.61,4 17.43,4.07 17.3,4.2L16.08,5.41L18.58,7.91L19.8,6.7C20.06,6.44 20.06,6 19.8,5.75L18.25,4.2C18.12,4.07 17.95,4 17.78,4M15.37,6.12L8,13.5V16H10.5L17.87,8.62L15.37,6.12Z"/>
                            </svg>
                        </button>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="tab__content">
        <c:forEach items="${resultList}" var="result">
            <div class="singleTestContainer"><span
                    style="margin-top: 5px">${result.user.name}  ${result.quiz.title}  ${result.correctAnswers} outo ${result.quiz.questions.size()} ${result.date}</span>
                <button class="smallGreenButton" onclick="sendRetake(${result.quiz.id}, ${result.user.id})">
                    <spring:message code="label.retake"/>
                </button>
            </div>
        </c:forEach>
    </div>

</div>
<a href="/quizApp">
    <svg style="width:24px;height:24px" viewBox="0 0 24 24" class="arrowBack">
        <path fill="#666666" d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"/>
    </svg>
</a>
</body>
</html>