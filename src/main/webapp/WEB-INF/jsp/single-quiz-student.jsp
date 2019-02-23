<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../../../resources/css/style.css">
    <link href="../../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>

    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">

    <sec:csrfMetaTags />
    <script type="text/javascript" language="javascript">
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");
        var csrfToken = $("meta[name='_csrf']").attr("content");
    </script>
    <script>function send() {

        var questionsAndAnswers = [];
        var answeredQuestions = document.getElementsByClassName("questionContainer");
        var chosenAnswers = [];
        var answers;


        var quiz = {
            quiz_id: document.getElementById("quiz_id_container").value,
            answeredQuestions: questionsAndAnswers
        };

        for (i = 0; i < answeredQuestions.length; i++) {
            answers = answeredQuestions.item(i).getElementsByClassName("singleAnswerContainer");
            chosenAnswers = [];
            for (j = 0; j < answers.length; j++) {
                var answerIsChecked = answers.item(j).getElementsByClassName("checkbox").item(0).checked;

                if (answerIsChecked) {
                    chosenAnswers.push(answers.item(j).id);

                }
            }
            var questionAndItsAnswers = {
                questionId: answeredQuestions.item(i).id,
                answersId: chosenAnswers
            };
            questionsAndAnswers.push(questionAndItsAnswers);
        }


        var json = JSON.stringify(quiz);
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = getNewStatePost(xhr);
        xhr.open("POST", '/quizApp/student/resultOfQuiz', true);
        xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
        xhr.setRequestHeader(csrfHeader, csrfToken);
        xhr.send(json);
        window.location.href='#openModal';

        function getNewStatePost(xmlHttpRequest) {

            return function () {
                if (xmlHttpRequest.readyState == 4) {
                    if (xmlHttpRequest.status == 200) {
                        document.getElementById('NumberOfCorrectAnswers').textContent += xmlHttpRequest.responseText;

                    } else {
                        alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText);
                    }
                }
            }
        }

    }</script>


</head>
<body class="adminBody">
<jsp:include page="header.jsp"></jsp:include>
<p class="containerLargerHeader"><c:out value="${quizName}"/></p>
<input id='quiz_id_container' hidden='hidden' value="${quizId}">
<c:forEach items="${questions}" var="question">
    <div class="questionContainer" id ="${question.id}">

        <p class="containerHeader"><c:out value="${question.questionText}"/></p>
        <c:forEach items="${question.answers}" var="answer">
            <div class="singleAnswerContainer" style="background-color: #EDEDED" id="${answer.id}">
                <div class="checkboxWrapPadd">
                    <input type="checkbox" class="checkbox"/>
                </div>
                <div class="inputWrapAns">
                    <p><c:out value="${answer.variant}"/></p>
                </div>
            </div>
        </c:forEach>
    </div>
</c:forEach>
<button  onclick="send()">
    <spring:message code="label.submitQuiz"/>
</button>

<a href="/quizApp/student">
    <svg style="width:24px;height:24px" viewBox="0 0 24 24" class="arrowBack">
        <path fill="#666666" d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"/>
    </svg>
</a>

<div id="openModal" class="modalDialog">
    <div class="modalContainer" style="height: 20vh; padding: 50px; margin-top: 25vh;">
        <a href="/quizApp/student" title="Закрыть" class="close">X</a>
        <div style="text-align: center">
            <svg style="width:50px;height:50px" viewBox="0 0 24 24">
                <path fill="#62c0d4"
                      d="M12,3C13.74,3 15.36,3.5 16.74,4.35C17.38,3.53 18.38,3 19.5,3A3.5,3.5 0 0,1 23,6.5C23,8 22.05,9.28 20.72,9.78C20.9,10.5 21,11.23 21,12A9,9 0 0,1 12,21A9,9 0 0,1 3,12C3,11.23 3.1,10.5 3.28,9.78C1.95,9.28 1,8 1,6.5A3.5,3.5 0 0,1 4.5,3C5.62,3 6.62,3.53 7.26,4.35C8.64,3.5 10.26,3 12,3M12,5A7,7 0 0,0 5,12A7,7 0 0,0 12,19A7,7 0 0,0 19,12A7,7 0 0,0 12,5M16.19,10.3C16.55,11.63 16.08,12.91 15.15,13.16C14.21,13.42 13.17,12.54 12.81,11.2C12.45,9.87 12.92,8.59 13.85,8.34C14.79,8.09 15.83,8.96 16.19,10.3M7.81,10.3C8.17,8.96 9.21,8.09 10.15,8.34C11.08,8.59 11.55,9.87 11.19,11.2C10.83,12.54 9.79,13.42 8.85,13.16C7.92,12.91 7.45,11.63 7.81,10.3M12,14C12.6,14 13.13,14.19 13.5,14.5L12.5,15.5C12.5,15.92 12.84,16.25 13.25,16.25A0.75,0.75 0 0,0 14,15.5A0.5,0.5 0 0,1 14.5,15A0.5,0.5 0 0,1 15,15.5A1.75,1.75 0 0,1 13.25,17.25C12.76,17.25 12.32,17.05 12,16.72C11.68,17.05 11.24,17.25 10.75,17.25A1.75,1.75 0 0,1 9,15.5A0.5,0.5 0 0,1 9.5,15A0.5,0.5 0 0,1 10,15.5A0.75,0.75 0 0,0 10.75,16.25A0.75,0.75 0 0,0 11.5,15.5L10.5,14.5C10.87,14.19 11.4,14 12,14Z"/>
            </svg>
        </div>
        <p class="subHeader" style="text-align: center">
            <span id = "NumberOfCorrectAnswers" ><spring:message code="label.result"/></span>
            <spring:message code="label.resultOutOf"/> ${quizNumberOfAnswers}
        </p>

        <form action="/quizApp/student">
            <button type = "submit">OK</button>
        </form>
    </div>

</div>

</body>
</html>