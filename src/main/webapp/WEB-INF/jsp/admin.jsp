<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin</title>
    <link rel="stylesheet" href="../../resources/css/style.css">
    <link rel="stylesheet" href="../../resources/css/tabs.css">
    <link rel="stylesheet" href="../../resources/css/table.css">

    <link href="../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>
    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">

    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='http://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js'></script>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.0/js/materialize.min.js'></script>
    <sec:csrfMetaTags/>
    <script type="text/javascript" language="javascript">
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");
        var csrfToken = $("meta[name='_csrf']").attr("content");
    </script>


    <script>

        function addNewTopic(event) {
            var targetElement = event.target.previousElementSibling;
            $(targetElement).append("<div style='display:flex'><input placeholder='<spring:message code='label.enterTopicTitleHere'/>' value='' id='-1' class='topicId'>" +
                "<button class='deleteButton'> <svg onclick='sendRemove(event)' style=\"width:24px;height:24px\" viewBox=\"0 0 24 24\" class=\"deleteIcon\">\n onclick='sendRemove(event)'" +
                "                                <path fill=\"#ffffff\"\n" +
                "                                      d=\"M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z\"/>\n" +
                "                            </svg> </button></div>");
        }

        function send() {

            var allJSONTopics = [];
            var allHTMLTopics = document.getElementsByClassName("topicId");

            for (i = 0; i < allHTMLTopics.length; i++) {
                var topic = {
                    id: allHTMLTopics.item(i).id,
                    name: allHTMLTopics.item(i).value
                };
                allJSONTopics.push(topic)
            }

            var json = JSON.stringify(allJSONTopics);
            var xhr = new XMLHttpRequest();
            xhr.open("POST", '/quizApp/admin/edit-topic', true);
            xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
            xhr.setRequestHeader(csrfHeader, csrfToken);
            xhr.send(json);

            alert("<spring:message code='label.successfullySaved'/>");

            window.location.reload();
        }

        function sendRemove(event) {

            if (confirm('<spring:message code="label.areYouSure"/>')) {
                var elem = event.target.closest('button');
                var id = elem.previousElementSibling.getAttribute("id");

                event.target.closest('div').remove();

                var xhr = new XMLHttpRequest();
                xhr.open("POST", '/quizApp/admin/delete-topic', true);
                xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
                xhr.setRequestHeader(csrfHeader, csrfToken);
                xhr.send(id);
            }
        }

        function sendUserReject(event, id) {

            if (confirm('<spring:message code="label.areYouSure"/>')) {

                event.target.closest('div').remove();

                var xhr = new XMLHttpRequest();
                xhr.open("POST", '/quizApp/admin/reject-request', true);
                xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
                xhr.setRequestHeader(csrfHeader, csrfToken);
                xhr.send(id);
            }
        }

        function sendUserApprove(event, id) {

            if (confirm('<spring:message code="label.areYouSure"/>')) {

                event.target.closest('div').remove();

                var xhr = new XMLHttpRequest();
                xhr.open("POST", '/quizApp/admin/approve-request', true);
                xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
                xhr.setRequestHeader(csrfHeader, csrfToken);
                xhr.send(id);
            }
        }

    </script>
</head>
<body class="adminBody">
<jsp:include page="header.jsp"/>


<div class="tab-set">

    <input id="tab-1" name="tab-group" class="tab" type="radio" checked>
    <label for="tab-1" class="tabLabel"> <spring:message code="label.requestsList"/>
    </label>

    <input id="tab-2" name="tab-group" class="tab" type="radio">
    <label for="tab-2" class="tabLabel"><spring:message code="label.editTopics"/></label>
    <input id="tab-3" name="tab-group" class="tab" type="radio">
    <label for="tab-3" class="tabLabel"><spring:message code="label.users"/></label>


    <div class="tab__content">

        <c:forEach items="${userList}" var="user">
            <div class="singleReqContainer" id="${user.id}">
                <span style="margin-top: 5px">${user.name}</span>
                <button class="smallButton" onclick="sendUserApprove(event, ${user.id})"><spring:message
                        code="label.approve"/></button>
                <button class="smallErrorButton" onclick="sendUserReject(event, ${user.id})">
                    <spring:message
                            code="label.reject"/></button>
            </div>

        </c:forEach>


    </div>

    <div class="tab__content">
        <div style="display: flex;justify-content: center">
            <div style="width: 70%; text-align: center">
                <div>
                    <c:forEach items="${topics}" var="topic">
                        <div style="display: flex">
                            <input value="${topic.name}" id="${topic.id}" class="topicId">

                            <button class="deleteButton">
                                <svg onclick="sendRemove(event)" style="width:24px;height:24px" viewBox="0 0 24 24"
                                     class="deleteIcon">
                                    <path fill="#ffffff"
                                          d="M19,4H15.5L14.5,3H9.5L8.5,4H5V6H19M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19Z"/>
                                </svg>
                            </button>
                        </div>
                    </c:forEach>
                </div>
                <button onclick="addNewTopic(event)"><spring:message code="label.addTopic"/></button>
                <button onclick="send()" class="greenButton"><spring:message code="label.submit"/></button>
            </div>

        </div>
    </div>
    <div class="tab__content" style="width: -webkit-fill-available;">
        <div class="row">
            <div id="admin" class="col s12">
                <div class="card material-table">
                    <div class="table-header">
                        <div class="actions">
                            <a href="#" class="search-toggle waves-effect btn-flat nopadding">
                                <svg style="width:24px;height:24px" viewBox="0 0 24 24">
                                    <path fill="#666666"
                                          d="M9.5,3A6.5,6.5 0 0,1 16,9.5C16,11.11 15.41,12.59 14.44,13.73L14.71,14H15.5L20.5,19L19,20.5L14,15.5V14.71L13.73,14.44C12.59,15.41 11.11,16 9.5,16A6.5,6.5 0 0,1 3,9.5A6.5,6.5 0 0,1 9.5,3M9.5,5C7,5 5,7 5,9.5C5,12 7,14 9.5,14C12,14 14,12 14,9.5C14,7 12,5 9.5,5Z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                    <div class="dataTables_wrapper no-footer" id="datatable_wrapper" style="overflow: auto">

                        <table id="datatable"
                               style="width: -webkit-fill-available; overflow: auto!important;"
                               class="datatableMain">
                            <thead>
                            <tr>
                                <th><spring:message code="label.name"/></th>
                                <th class="loginName"><spring:message code="label.loginName"/></th>
                                <th><spring:message code="label.enabledUser"/></th>
                                <th><spring:message code="label.role"/></th>
                                <th>🚀</th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach items="${allUsers}" var="user">
                                <tr style="font-size: larger;">
                                    <td>${user.name}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <c:if test="${user.enabled}">
                                            <svg style="width:24px;height:24px" viewBox="0 0 24 24">
                                                <path fill="#72D0E4"
                                                      d="M10,17L5,12L6.41,10.58L10,14.17L17.59,6.58L19,8M19,3H5C3.89,3 3,3.89 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V5C21,3.89 20.1,3 19,3Z"/>
                                            </svg>
                                        </c:if>
                                        <c:if test="${!user.enabled}">
                                            <svg style="width:24px;height:24px" viewBox="0 0 24 24">
                                                <path fill="#72D0E4"
                                                      d="M19,3H5C3.89,3 3,3.89 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V5C21,3.89 20.1,3 19,3M19,5V19H5V5H19Z"/>
                                            </svg>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${user.role eq 'ROLE_TEACHER'}">
                                            Teacher
                                        </c:if>
                                        <c:if test="${user.role eq 'ROLE_STUDENT'}">
                                            Student
                                        </c:if>
                                        <c:if test="${user.role eq 'ROLE_REQUEST'}">
                                            Request
                                        </c:if>
                                        <c:if test="${user.role eq 'ROLE_ADMIN'}">
                                            Admin
                                        </c:if>
                                        <c:if test="${user.role eq 'ROLE_REJECTED'}">
                                            Rejected
                                        </c:if>
                                    </td>
                                    <td>
                                        <a href="/quizApp/admin/edit-user/${user.id}">
                                            <button class="smallButton">
                                                <svg style="width:24px;height:24px" viewBox="0 0 24 24">
                                                    <path fill="#ffffff"
                                                          d="M20.71,7.04C21.1,6.65 21.1,6 20.71,5.63L18.37,3.29C18,2.9 17.35,2.9 16.96,3.29L15.12,5.12L18.87,8.87M3,17.25V21H6.75L17.81,9.93L14.06,6.18L3,17.25Z"/>
                                                </svg>
                                            </button>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>

<a href="/quizApp">
    <svg style="width:24px;height:24px" viewBox="0 0 24 24" class="arrowBack">
        <path fill="#666666" d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"/>
    </svg>
</a>
<script>(function (window, document, undefined) {

    var factory = function ($, DataTable) {
        "use strict";

        $('.search-toggle').click(function () {
            if ($('.hiddensearch').css('display') == 'none')
                $('.hiddensearch').slideDown();
            else
                $('.hiddensearch').slideUp();
        });

        $.extend(true, DataTable.defaults, {
            dom: "<'hiddensearch'f'>" +
                "tr" +
                "<'table-footer'lip'>",
            renderer: 'material'
        });

        /* Default class modification */
        $.extend(DataTable.ext.classes, {
            sWrapper: "dataTables_wrapper",
            sFilterInput: "form-control input-sm",
            sLengthSelect: "form-control input-sm"
        });

        DataTable.ext.renderer.pageButton.material = function (settings, host, idx, buttons, page, pages) {
            var api = new DataTable.Api(settings);
            var classes = settings.oClasses;
            var lang = settings.oLanguage.oPaginate;
            var btnDisplay, btnClass, counter = 0;

            var attach = function (container, buttons) {
                var i, ien, node, button;
                var clickHandler = function (e) {
                    e.preventDefault();
                    if (!$(e.currentTarget).hasClass('disabled')) {
                        api.page(e.data.action).draw(false);
                    }
                };

                for (i = 0, ien = buttons.length; i < ien; i++) {
                    button = buttons[i];

                    if ($.isArray(button)) {
                        attach(container, button);
                    } else {
                        btnDisplay = '';
                        btnClass = '';

                        switch (button) {

                            case 'first':
                                btnDisplay = lang.sFirst;
                                btnClass = button + (page > 0 ?
                                    '' : ' disabled');
                                break;

                            case 'previous':
                                btnDisplay = '<i><svg style="width:24px;height:24px" viewBox="0 0 24 24">\n' +
                                    '    <path fill="#000000" d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z" />\n' +
                                    '</svg></i>';
                                btnClass = button + (page > 0 ?
                                    '' : ' disabled');
                                break;

                            case 'next':
                                btnDisplay = '<i><svg style="width:24px;height:24px" viewBox="0 0 24 24">\n' +
                                    '    <path fill="#000000" d="M4,11V13H16L10.5,18.5L11.92,19.92L19.84,12L11.92,4.08L10.5,5.5L16,11H4Z" />\n' +
                                    '</svg></i>';
                                btnClass = button + (page < pages - 1 ?
                                    '' : ' disabled');
                                break;

                            case 'last':
                                btnDisplay = lang.sLast;
                                btnClass = button + (page < pages - 1 ?
                                    '' : ' disabled');
                                break;

                        }

                        if (btnDisplay) {
                            node = $('<li>', {
                                'class': classes.sPageButton + ' ' + btnClass,
                                'id': idx === 0 && typeof button === 'string' ?
                                    settings.sTableId + '_' + button : null
                            })
                                .append($('<a>', {
                                        'href': '#',
                                        'aria-controls': settings.sTableId,
                                        'data-dt-idx': counter,
                                        'tabindex': settings.iTabIndex
                                    })
                                        .html(btnDisplay)
                                )
                                .appendTo(container);

                            settings.oApi._fnBindAction(
                                node, {
                                    action: button
                                }, clickHandler
                            );

                            counter++;
                        }
                    }
                }
            };

            var activeEl;

            try {

                activeEl = $(document.activeElement).data('dt-idx');
            } catch (e) {
            }

            attach(
                $(host).empty().html('<ul class="material-pagination"/>').children('ul'),
                buttons
            );

            if (activeEl) {
                $(host).find('[data-dt-idx=' + activeEl + ']').focus();
            }
        };


        if (DataTable.TableTools) {
            $.extend(true, DataTable.TableTools.classes, {
                "container": "DTTT btn-group",
                "buttons": {
                    "normal": "btn btn-default",
                    "disabled": "disabled"
                },
                "collection": {
                    "container": "DTTT_dropdown dropdown-menu",
                    "buttons": {
                        "normal": "",
                        "disabled": "disabled"
                    }
                },
                "print": {
                    "info": "DTTT_print_info"
                },
                "select": {
                    "row": "active"
                }
            });

            $.extend(true, DataTable.TableTools.DEFAULTS.oTags, {
                "collection": {
                    "container": "ul",
                    "button": "li",
                    "liner": "a"
                }
            });
        }

    };

    if (typeof define === 'function' && define.amd) {
        define(['jquery', 'datatables'], factory);
    } else if (typeof exports === 'object') {
        factory(require('jquery'), require('datatables'));
    } else if (jQuery) {
        factory(jQuery, jQuery.fn.dataTable);
    }

})(window, document);

$(document).ready(function () {
    $('#datatable').dataTable({
        "oLanguage": {
            "sStripClasses": "",
            "sSearch": "",
            "sSearchPlaceholder": "Enter Keywords Here",
            "sInfo": "_START_ -_END_ of _TOTAL_",
            "sLengthMenu": '<span>Rows per page:</span><select class="browser-default">' +
                '<option value="10">10</option>' +
                '<option value="20">20</option>' +
                '<option value="30">30</option>' +
                '<option value="40">40</option>' +
                '<option value="50">50</option>' +
                '<option value="-1">All</option>' +
                '</select></div>'
        },
        bAutoWidth: false
    });
});
</script>

</body>
</html>