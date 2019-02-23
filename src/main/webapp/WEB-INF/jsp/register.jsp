<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: macbook
  Date: 17/10/2018
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


    <link rel="stylesheet" href="../../resources/css/style.css">
    <link href="../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">
    <script>
        function firstDynamicValidate(id) {
            var value = "";
            if (id === "email") {
                value = document.getElementById(id).value.replace(/[^a-zA-z0-9_\-@.]/g, '');
            }
            if (id === "name") {
                value = document.getElementById(id).value.replace(/[^a-zA-Z0-9 _\-!]/g, '');
            }
            document.getElementById(id).value = value;
            secondDynamicValidate(id, value);
        }

        function secondDynamicValidate(id, value) {
            getCallback(id, myCallback)
        }

        getCallback = function (id, callback) // How can I use this callback?
        {
            var xhr = new XMLHttpRequest();
            var value = document.getElementById(id).value;
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    callback(xhr.responseText); // Another callback here
                }
            };
            xhr.open('GET', "/quizApp/dynamicValidate?input=" + id + "&value=" + value, true);
            xhr.send();
        };

        function myCallback(data) {
            data = data.replace(/(\\\\)/g, '\\');
            var json = JSON.parse(data);
            if (json.msg !== "ok") {
                document.getElementById("form-group-" + json.input).className = "form-group has-error";
                document.getElementById("error-" + json.input).innerHTML = "";
                for (var line in json.msg) {
                    document.getElementById("error-" + json.input).innerHTML += unescape(json.msg[line]) + "<br>";
                }
            } else {
                document.getElementById("form-group-" + json.input).className = "form-group ";
                document.getElementById("error-" + json.input).innerHTML = "";
            }
        }

        function checkPasswords(id1, id2) {
            var passwordLength = document.getElementById(id1).value.length;
            if (document.getElementById(id1).value.length < 3 || passwordLength > 39) {
                document.getElementById("form-group-" + id1).className = "form-group has-error";
                document.getElementById("error-" + id1).innerHTML =
                    '<spring:message code="Size.userForm.password"/>';
            } else {
                document.getElementById("form-group-" + id1).className = "form-group ";
                document.getElementById("error-" + id1).innerHTML = "";
            }
            if (document.getElementById(id1).value !== document.getElementById(id2).value) {
                document.getElementById("form-group-" + id2).className = "form-group has-error";
                document.getElementById("error-" + id2).innerHTML = '<spring:message code="Diff.userForm.confirmPassword"/>';
            }
            else {
                document.getElementById("form-group-" + id2).className = "form-group ";
                document.getElementById("error-" + id2).innerHTML = "";
            }
        }
    </script>
</head>
<body class="bodyWithBg">
<div style="display: flex;align-items: center;margin-right: 15px;">
    <div>
        <a href="?lang=en"><img src="../../resources/img/en.png" style="width:30px"> </a>
    </div>
    <div style="margin-top: -1px;">
        <p style="font-size: 30px;margin-block-start: 0; margin-block-end: 0;" class="divider">|</p>
    </div>
    <div>
        <a href="?lang=ru"> <img src="../../resources/img/ru.svg" style="width:30px"> </a>
    </div>
</div>
<div class="signUpContainer">
    <div onclick="window.location.href='<c:url value="/quizApp"/>'">
        <svg style="width:100px;height:100px" viewBox="0 0 24 24">
            <path fill="#62c0d4"
                  d="M12,3C13.74,3 15.36,3.5 16.74,4.35C17.38,3.53 18.38,3 19.5,3A3.5,3.5 0 0,1 23,6.5C23,8 22.05,9.28 20.72,9.78C20.9,10.5 21,11.23 21,12A9,9 0 0,1 12,21A9,9 0 0,1 3,12C3,11.23 3.1,10.5 3.28,9.78C1.95,9.28 1,8 1,6.5A3.5,3.5 0 0,1 4.5,3C5.62,3 6.62,3.53 7.26,4.35C8.64,3.5 10.26,3 12,3M12,5A7,7 0 0,0 5,12A7,7 0 0,0 12,19A7,7 0 0,0 19,12A7,7 0 0,0 12,5M16.19,10.3C16.55,11.63 16.08,12.91 15.15,13.16C14.21,13.42 13.17,12.54 12.81,11.2C12.45,9.87 12.92,8.59 13.85,8.34C14.79,8.09 15.83,8.96 16.19,10.3M7.81,10.3C8.17,8.96 9.21,8.09 10.15,8.34C11.08,8.59 11.55,9.87 11.19,11.2C10.83,12.54 9.79,13.42 8.85,13.16C7.92,12.91 7.45,11.63 7.81,10.3M12,14C12.6,14 13.13,14.19 13.5,14.5L12.5,15.5C12.5,15.92 12.84,16.25 13.25,16.25A0.75,0.75 0 0,0 14,15.5A0.5,0.5 0 0,1 14.5,15A0.5,0.5 0 0,1 15,15.5A1.75,1.75 0 0,1 13.25,17.25C12.76,17.25 12.32,17.05 12,16.72C11.68,17.05 11.24,17.25 10.75,17.25A1.75,1.75 0 0,1 9,15.5A0.5,0.5 0 0,1 9.5,15A0.5,0.5 0 0,1 10,15.5A0.75,0.75 0 0,0 10.75,16.25A0.75,0.75 0 0,0 11.5,15.5L10.5,14.5C10.87,14.19 11.4,14 12,14Z"/>
        </svg>
    </div>
    <div class="inputContainer">

        <form:form method="POST" modelAttribute="userForm">
            <spring:bind path="name">
                <div id="form-group-name" class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input id="name" type="text" path="name" onkeyup='firstDynamicValidate(this.id)'
                                placeholder="Full name"
                                autofocus="true"/>
                    <div id="error-name" style="margin-top: -10px; margin-bottom: 10px">
                        <form:errors id="name-error" path="name"/>
                    </div>
                </div>
            </spring:bind>

            <spring:bind path="email">
                <div id="form-group-email" class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input type="text" id="email" path="email" onkeyup='firstDynamicValidate(this.id)'
                                placeholder="E-mail"/>
                    <div id="error-email" style="margin-top: -10px; margin-bottom: 10px">
                        <form:errors id="email-error" path="email"/>
                    </div>
                </div>
            </spring:bind>

            <spring:bind path="password">
                <div id="form-group-password" class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input id="password" type="password" path="password"
                                onkeyup="checkPasswords(this.id,'confirmPassword')" placeholder="Password"/>
                    <div id="error-password" style="margin-top: -10px; margin-bottom: 10px">
                        <form:errors path="password"/>
                    </div>
                </div>
            </spring:bind>

            <spring:bind path="confirmPassword">
                <div id="form-group-confirmPassword" class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input id="confirmPassword" type="password" path="confirmPassword"
                                onkeyup="checkPasswords('password',this.id)" placeholder="Confirm your password"/>
                    <div id="error-confirmPassword" style="margin-top: -10px; margin-bottom: 10px">
                        <form:errors path="confirmPassword"/>
                    </div>
                </div>
            </spring:bind>
            <p class="registerAsTutor"><spring:message code="label.registerAsTutor"/>
                <form:checkbox id="3" path="role" value="ROLE_STUDENT"
                               onclick="this.value = this.checked ? 'ROLE_REQUEST' : 'ROLE_STUDENT'"/>
            </p>

            <div style="display: flex; justify-content: space-evenly">
                <button class="greenButton" type="submit"><spring:message
                        code="label.registration"/></button>
                <a href="login">
                    <button type="button"><spring:message code="label.login"/></button>
                </a>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>
