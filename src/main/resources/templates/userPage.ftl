<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</head>
<style>
    .label-heading{
        width: 100%;
        background: #fcbf62; /* Цвет фона */
        padding-top: 2%;
        padding-bottom: 2%;
        font-family: Marker Felt, fantasy;
        letter-spacing: 1px;
        font-size: 52px;
        color: white;
        text-align: center;
    }
    .main-font {
        background: #fff2bf;
    }
    .a-main {
        color: black; /* Цвет ссылки */
        text-decoration: none;
    }
    .a-main:visited {
        color: black; /* Цвет ссылки */
        text-decoration: none;
    }
    #left {
        padding-left: 40%;
        text-align: left;
    }
    .main-inf{
        margin-left: 10%;
        margin-right: 10%;
        background: white;
        text-align: center;
        border-color: white;
        border-radius: 10px;
        border-style: solid;
        font-size: 1.5vw;
    }
    .bolt{
        font-weight: bold;
    }
    .label-bottom{
        margin-top: 150px;
        min-height: 100%;
        background: #fcbf62;
        text-align: center;
    }
    .check-box{
        width: 20px;
        height: 20px;
    }
    .table{
        width: 96%;
        margin-left: 2%;
        margin-right: 20%;
        font-size: 1.3vw;
        text-align: center;
        border-radius: 10px;
    }

    .button-save{
        border-style: solid;
        border-color: #ff8b26;
        background: white;
        font-size: 1.3vw;
        border-radius: 7px;
    }
    .button-save:hover{
        border-color: grey;
        transform: scale(1.05);
    }
    .top-label:hover{
        text-shadow: grey 0 0 4px;
        transform: scale(1.05);
    }

    .dropdown {
        top: 100px;
        left: 90%;
        font-size: 18px;
        position: absolute;
        display: inline-block;
    }

    /* Dropdown Content (Hidden by Default) */
    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f1f1f1;
        min-width: 120px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
    }

    /* Links inside the dropdown */
    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    /* Change color of dropdown links on hover */
    .dropdown-content a:hover {background-color: #ddd;}

    /* Show the dropdown menu on hover */
    .dropdown:hover .dropdown-content {display: block;}
    .username{
        color: black;
        font-size: 16px;
    }


</style>
<script>

    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    function changeType() {
        var type = document.getElementById('type');
        if(type.checked){
            send(true);
        }else{
            send(false);
        }
    }

    function send(type) {
        $.ajax({
            method: "POST",
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            url: "/user/change_type?id=${user.getId()}",
            data: JSON.stringify(type), // Note it is important
            success: function (code) {
                if(code == 200){
                    alert("Type changed!")
                }else{
                    alert("Error! Try again latter.")
                }

            }
        });
    }

</script>
<body>
<div class="main-font">
    <div class="label-heading">
        <a class = "a-main" href="/"><label class="top-label">Campus Study</label></a>

        <div class="dropdown">
            <label class="username">${logUser.getUsername()}</label>
            <div class="dropdown-content">
                    <a href="/courses/add"><@s.message "course.add"/></a>
                    <a href="/users/all"><@s.message "users"/></a>
                    <a href="/logout"><@s.message "logout"/></a>
            </div>
        </div>
    </div>

    <div class="main-inf">
        <h1>${user.getUsername()}</h1>
        <h2>${user.getEmail()}</h2>
        <#if user.isPremium()>
             Premium <input  id="type" class="check-box" type="checkbox" checked>
          <#else>
              Premium <input id="type" class="check-box" type="checkbox">
        </#if>
        <p><button class="button-save" type="button" onclick="changeType()"><@s.message "button.save"/></button></p>

        <@s.message "result"/>
        <table class="table" border="1">
            <thead class="thead-light">
            <tr>
                <th><@s.message "course"/></th>
                <th><@s.message "lesson"/></th>
                <th><@s.message "Test"/></th>
                <th><@s.message "mistake.number"/></th>
                <th><@s.message "spent.time"/></th>
            </tr>
            </thead>
            <tbody>
            <#list user.getResults() as r>
                <tr><td>${r.getLesson().getCourseId().getName()}</td><td>${r.getLesson().getName()}</td>
                    <td>
                        <#if r.isTestAvailable()>
                            <@s.message "pass"/>
                        <#else>
                            <@s.message "no.pass"/>
                        </#if>

                    </td>
                    <td>${r.getMistakes()}</td><td>${r.getTime()} <@s.message "minute"/></td></tr>
            </#list>
        </table>
    </div>

    <div class = "label-bottom">
        <div id="left">
            <label class="bolt">© 2020–... «Campus Study»</label>
            <br>
            <label>Контакти</label>
        </div>

    </div>
</div>
</body>
</html>