<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tutor</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

    <link href="../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <sec:csrfMetaTags/>
    <script type="text/javascript" language="javascript">
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");
        var csrfToken = $("meta[name='_csrf']").attr("content");
    </script>

    <script>

        function addNewAnswer(event) {
            var targetElement = event.target.previousElementSibling;
            $(targetElement).append("<div class='singleTestContainer' style='background-color: #EDEDED'>\n" +
                "<input class='answer_id' hidden='hidden' value='-1'>\n" +
                "    <div class='checkboxWrapPadd'>\n" +
                "        <input class='checkMe' type='checkbox' />\n" +
                "    </div>\n" +
                "    <div class='inputWrap' id='-1'>\n" +
                "        <input class='answerValue' id= '-1'  placeholder='<spring:message code='label.enterVariant'/> ' />\n" +
                "    </div>\n" +
                "<span style='margin-top: 12px; margin-left: 12px;' >" +
                "<svg style='width:35px;height:35px' viewBox='0 0 24 24' class='deleteIcon' onclick='deleteAnswer(event)'>" +
                "<path fill='#333333' class='deleteIcon' " +
                "d='M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z'/>"+
                "</svg>" +
                "</span>" +
                "</div>"
            );
        }

        function addNewQuestion(event) {
            var targetElement = event.target.previousElementSibling;
            $(targetElement).append(
                "<div class='mainContainer' id='mainContainer'>\n" +
                "<div id='blockVariantAdd'>\n" +
                "<input class='question_id' hidden='hidden' value='-1'>\n" +

                    "<button class=\"deleteButton\" style=\"float: right;margin-bottom: -30px;\">\n" +
                "                <svg onclick=\"deleteQuestion(event)\" style=\"width:24px;height:24px\" viewBox=\"0 0 24 24\"\n" +
                "                  >\n" +
                "                    <path fill=\"#ffffff\"\n" +
                "                          d=\"M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z\"/>\n" +
                "                </svg>\n" +
                "            </button>" +

                "    <input class='questionText' style='width:92%' placeholder='<spring:message code='label.enterQuestion'/> '>\n" +
                "\n" +
                "    <div class='singleTestContainer' style='background-color: #EDEDED'>\n" +
                "<input class='answer_id' hidden='hidden' value='-1'>\n" +
                "        <div class='checkboxWrapPadd'>\n" +
                "            <input class='checkMe' type='checkbox' />\n" +
                "        </div>\n" +
                "        <div class='inputWrap'>\n" +
                "            <input class='answerValue' id= '-1' placeholder='<spring:message code='label.enterVariant'/> '>\n" +
                "        </div>\n" +
                "<span style='margin-top: 12px; margin-left: 12px;' >" +
                "<svg style='width:35px;height:35px' viewBox='0 0 24 24' class='deleteIcon' onclick='deleteAnswer(event)'>" +
                "<path fill='#333333' class='deleteIcon' " +
                "d='M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z'/>"+
                "</svg>" +
                "</span>" +
                "    </div>\n" +
                "\n" +
                "</div>\n" +
                "<button id='variantAdd' onclick='addNewAnswer(event)' > <spring:message code='label.addVariant'/></button>" +
                "</div>");
        }

        function send() {

            var allQuestionsJSON = [];

            var quizContainer = document.getElementsByClassName("quizContainer").item(0);
            var questionsHTML = document.getElementsByClassName("mainContainer");

            var optionsSelectedIndex = quizContainer.getElementsByClassName("subject").item(0).options.selectedIndex;

            var topic = {
                id: quizContainer.getElementsByClassName("subject").item(0).options[optionsSelectedIndex].value
            };

            var quiz = {
                id: quizContainer.getElementsByClassName("quiz_id").item(0).value,
                title: quizContainer.getElementsByClassName("title").item(0).value,
                enabled: quizContainer.getElementsByClassName("checkMe").item(0).checked,
                questions: allQuestionsJSON,
                topic: topic
            };

            for (i = 0; i < questionsHTML.length; i++) {
                var allAnswers = [];
                var question = {
                    id: questionsHTML.item(i).getElementsByClassName("question_id").item(0).value,
                    questionText: questionsHTML.item(i).getElementsByClassName("questionText").item(0).value,
                    answers: allAnswers,
                    quiz_id: quiz.id
                };

                var answers = questionsHTML.item(i).getElementsByClassName("singleTestContainer");

                for (j = 0; j < answers.length; j++) {
                    var answer = {
                        question_id: question.id,
                        id: answers.item(j).getElementsByClassName("answer_id").item(0).value,
                        correct: answers.item(j).getElementsByClassName("checkMe").item(0).checked,
                        variant: answers.item(j).getElementsByClassName("answerValue").item(0).value
                    };

                    allAnswers.push(answer);
                }

                allQuestionsJSON.push(question);
            }

            var json = JSON.stringify(quiz);
            var xhr = new XMLHttpRequest();
            xhr.open("POST", '/quizApp/teacher/edit-quiz', true);
            xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
            xhr.setRequestHeader(csrfHeader, csrfToken);
            xhr.send(json);

            alert("<spring:message code='label.successfullySaved'/>");

            window.location.href='<c:url value="/quizApp/teacher"/>'
        }

        function deleteAnswer(event) {
            if (confirm('<spring:message code="label.areYouSure"/>')) {
                var elem = event.target.closest('span');
                var id = elem.previousElementSibling.getAttribute("id");

                event.target.closest('div').remove();

                var xhr = new XMLHttpRequest();
                xhr.open("POST", '/quizApp/teacher/delete-answer', true);
                xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
                xhr.setRequestHeader(csrfHeader, csrfToken);
                xhr.send(id);
            }
        }


        function deleteQuestion(event) {
            if (confirm('<spring:message code="label.areYouSure"/>')) {
                var elem = event.target.closest('button');
                var id = elem.previousElementSibling.getAttribute("id");

                event.target.closest('#mainContainer').remove();

                var xhr = new XMLHttpRequest();
                xhr.open("POST", '/quizApp/delete-question', true);
                xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
                xhr.setRequestHeader(csrfHeader, csrfToken);
                xhr.send(id);
            }
        }
    </script>

</head>
<body class="adminBody">
<jsp:include page="header.jsp"></jsp:include>
<div class="quizContainer"
     style="background-color: white;
    width: inherit;
    border: 2px solid #b6b6b6;
    padding: 20px;
    border-radius: 10px ;
    box-shadow: 0 0 10px rgba(0,0,0,0.5);
    margin-bottom: 20px;">
    <p class="subHeader"><spring:message code="label.editTest"/></p>

    <c:choose>
        <c:when test="${quizId >= 0}">
            <input class="quiz_id" hidden="hidden" value="${quizId}">
        </c:when>
        <c:otherwise>
            <input class="quiz_id" hidden="hidden" value="-1">
        </c:otherwise>
    </c:choose>
    <select class="subject">

        <option value="-1" selected> ----------</option>

        <c:forEach items="${topics}" var="topic">
            <c:choose>
                <c:when test="${topic.id eq quizTopic.id}">
                    <option value="${topic.id}" selected> ${topic.name} </option>
                </c:when>
                <c:otherwise>
                    <option value="${topic.id}"> ${topic.name} </option>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </select>

    <input class="title" placeholder="<spring:message code="label.enterTitle"/>" value="${quizTitle}">
    <p style="margin: 0"><spring:message code="label.isEnabled"/>
        <input class="checkMe" type="checkbox"
               <c:if test="${quizEnabled}">checked='checked'</c:if>  />
    </p>
</div>
<c:forEach items="${questions}" var="question">
    <div class="mainContainer" id="mainContainer">
        <div id="divVariantAdd">

            <c:choose>
                <c:when test="${question.id >= 0}">
                    <input class="question_id" hidden="hidden" value="${question.id}" id="${question.id}">
                </c:when>
                <c:otherwise>
                    <input class="question_id" hidden="hidden" value="-1" id="-1">
                </c:otherwise>
            </c:choose>

            <button class="deleteButton" style="float: right;margin-bottom: -30px;">
                <svg onclick="deleteQuestion(event)" style="width:24px;height:24px" viewBox="0 0 24 24">
                    <path fill="#ffffff"
                          d="M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z"/>
                </svg>
            </button>

            <input class="questionText" style="width:92%" value="<c:out value="${question.questionText}" />">
            <c:forEach items="${question.answers}" var="answer">
                <div class="singleTestContainer" style="background-color: #EDEDED">

                    <c:choose>
                        <c:when test="${answer.id >= 0}">
                            <input class="answer_id" hidden="hidden" value="${answer.id}" id="${answer.id}">
                        </c:when>
                        <c:otherwise>
                            <input class="answer_id" hidden="hidden" value="-1" id="-1">
                        </c:otherwise>
                    </c:choose>

                    <div class="checkboxWrapPadd">
                        <input type="checkbox" class="checkMe"
                               <c:if test="${answer.getCorrect()}">checked='checked'</c:if>     />
                    </div>
                    <div class="inputWrap" id="${answer.id}">
                        <input class="answerValue" value="<c:out value="${answer.variant}" />">
                    </div>
                    <span style="margin-top: 12px; margin-left: 12px;" >
                        <svg style="width:35px;height:35px" viewBox="0 0 24 24" class="deleteIcon" onclick="deleteAnswer(event)">
                            <path fill="#333333" class="deleteIcon"
                                  d="M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z"/>
                        </svg>
                    </span>
                </div>
            </c:forEach>
        </div>
        <button id="buttonVariantAdd" onclick="addNewAnswer(event)"><spring:message code="label.addVariant"/></button>
    </div>
</c:forEach>

<div id="divQuestionAdd"></div>
<button id="buttonQuestionAdd" onclick="addNewQuestion(event)"><spring:message code="label.addQuestion"/></button>
<button class="greenButton" onclick="send()"><spring:message code="label.saveTest"/></button>
<a href="/quizApp/teacher">
    <svg style="width:24px;height:24px" viewBox="0 0 24 24" class="arrowBack">
        <path fill="#666666" d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"/>
    </svg>
</a>
</body>
</html>
