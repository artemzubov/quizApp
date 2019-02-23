<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student</title>
    <link rel="stylesheet" href="../../../resources/css/style.css">
    <link rel="stylesheet" href="../../../resources/css/table.css">

    <link href="../../../resources/img/favicon.ico" rel="icon" type="image/x-icon"/>

    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='http://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js'></script>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.0/js/materialize.min.js'></script>

    <link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">

</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<a href="/quizApp/student">
    <svg style="width:50px;height:50px; margin-top:-40px" viewBox="0 0 24 24" class="arrowBack">
        <path fill="#666666" d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z"/>
    </svg>
</a>
<div class="mainContainer">
    <p class="containerHeader"
       style="font-size: xx-large; font-weight: 900; margin-block-start: 0; margin-block-end: 10px;">${topic}
    </p>
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
                            <th style="width: 50%"><spring:message code="label.title"/></th>
                            <th style="width: 23%"><spring:message code="label.author"/></th>
                            <th style="width: 17%"><spring:message code="label.quantity"/></th>
                            <th style="width: 20%">🚀</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${quizzes}" var="quiz">
                            <tr style="font-size: larger;">
                                <td>${quiz.title}</td>
                                <td>${quiz.author.name}</td>
                                <td> ${quiz.questions.size()}</td>
                                <td>
                                    <a href="/quizApp/student/solve-quiz/${quiz.id}">
                                        <button class="smallGreenButtonSolve" >
                                            <spring:message code="label.solveTest"/>
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