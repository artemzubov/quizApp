function send() {

    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
    var csrfToken = $("meta[name='_csrf']").attr("content");

    var questionsAndAnswers = [];
    var answeredQuestions = document.getElementsByClassName("questionContainer");
    var chosenAnswers = [];
    var answers;


    var quiz = {
        QuizId: document.getElementsByClassName("quiz_id_container").value,
        questions: questionsAndAnswers
    };

    for (i = 0; i < answeredQuestions.length; i++) {
        answers = answeredQuestions.item(i).getElementsByClassName("singleAnswerContainer");
        for (j = 0; j < answers.length; j++) {
            var answerIsChecked = answers.item(j).getElementsByClassName("checkbox").checked;
            if (answerIsChecked) {
                chosenAnswers.push(answers.item(j).id);
            }
        }
        var questionAndItsAnswers = {
            AnswerId: answeredQuestions.item(i).getElementsByClassName("questionContainer").id,
            answers: chosenAnswers
        }
        questionsAndAnswers.push(questionAndItsAnswers);
    }


    var json = JSON.stringify(quiz);
    var xhr = new XMLHttpRequest();
    xhr.open("POST", '/resultOfQuiz', true);
    xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
    xhr.setRequestHeader(csrfHeader, csrfToken);
    xhr.send(json);


}