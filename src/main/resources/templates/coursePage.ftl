<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://bootstraptema.ru/snippets/slider/2016/cbpFWSlider/cbpFWSlider.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://bootstraptema.ru/snippets/slider/2016/cbpFWSlider/cbpFWSlider.min.js"></script>
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
        transition: 0.5s;
    }
    .main-font {
        background: #fff2bf;
    }
    .a-main {
        color: black; /* Цвет ссылки */
        text-decoration: none;
    }
    .a-main:hover {
        transform: scale(1.1);
        color: grey; /* Цвет ссылки */
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

    .bolt{
        font-weight: bold;
    }
    .label-bottom{
        bottom: 0;
        background: #fcbf62;
        min-height:60px;
        width: 100%;
        text-align: center;
    }

    a {
        /* Ссылка как блочный элемент */
        height: 100%; /* Высота на весь слой */
        weight: 100%;
        color: black; /* Цвет ссылки */
        text-decoration: none;
    }
    a:visited {
        color: black; /* Цвет посещенных ссылок */
    }
    a:active {
        color: white; /* Цвет активных ссылок */
        text-decoration: none;
    }
    a:hover {
        text-decoration: none;
        color: black;
    }
    .main-inf{
        margin-top: 0;
        margin-left: 18%;
        margin-right: 18%;
        background: white;
        text-align: center;
        border-color: #ffb057;
        border-radius: 10px;
        border-style: solid solid solid solid;
    }
    .main-inf button:hover{
      border-color: grey;
        background: lightgrey;
    }
    .color-brown{
        color: #ff8b26;
    }
    .button-edit{
        margin: 10px;
        padding: 5px 3px 5px 3px;
        background: white;
        color: black;
        width: 13%;
        font-size: 1.2vw;
        border-style: solid;
        border-color: #ff8b26;
        border-radius: 3px;
    }
    .button-delete{
        padding: 5px 3px 5px 3px;
        color: black;
        background: none;
        width: 12%;
        font-size: 1.2vw;
        border-style: solid;
        border-color: #ff8b26;
        border-radius: 3px;
    }
    .button-lessons{
        padding: 3px 1px 3px 1px;
        background: white;
        color: black;
        width: 11%;
        font-size: 1.1vw;
        border-style: solid;
        border-color: #ff8b26;
        border-radius: 3px;
    }
    .button-add-lesson{
        padding: 5px 3px 5px 3px;
        margin-left: 5px;
        background: white;
        color: black;
        width: 18%;
        font-size: 1.2vw;
        border-style: solid;
        border-color: #ff8b26;
        border-radius: 3px;
    }
    .card{
        white-space: pre-line;
        background: white;
        margin-left: 33%;
        margin-right: 33%;
        border-style: solid ;
        border-radius: 10px;
        border-color: white;
        font-size: 1.2vw;
        transition: 0.5s;
        padding-right: 20px;
        padding-left: 20px;
        padding-bottom: 50px;
    }

    .card:hover {
        transform: scale(1.15); /* Увеличиваем масштаб */
        border: 2px solid lightgrey;
        color: black;
    }
    .cbp-fwslider{
        margin-left: 15%;
        margin-right: 15%;
        text-align: center;
    }
    .cbp-fwslider button{
        margin: 5px;
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


</style>
<script>

    $( function() {
        $( '#cbp-fwslider' ).cbpFWSlider();
    });

function deleteCourse() {
    var resultActionUser = confirm("Do you want to delete '${course.getName()}'?");
    if (resultActionUser) {
        $.ajax({
            type: 'GET',
            url: "/course/delete?id=${course.courseId}",
            dataType: 'json',
            success: function (data, status) {
                if(data==200){
                    window.location.replace("/")
                }else{
                    alert("Delete error!")
                }

            },
        });
    }
}

 function editCourse() {
                window.location.replace("/course/edit?id=${course.courseId}");
 }
function deleteLesson(id) {
    $.ajax({
        type: 'GET',
        url: "/lessons/delete?id="+id,
        dataType: 'json',
        success: function (data, status) {
            if(data==200){
                window.location.replace("/course?id=${course.courseId}")
            }else{
                alert("Delete error!")
            }

        },
    });
}
function editLesson(id) {
    window.location.replace("/lessons/edit?id="+id);
}
function addTest(id) {
    window.location.replace("/test/add?id="+id);
}
function addLesson(id) {
    window.location.replace("/lessons/add?id="+id);
}

</script>
<body>
<div class="main-font">
    <div class="label-heading">
        <a href="/"><label class="top-label">Campus Study</label></a>

        <div class="dropdown">
            <label><a class = "a-user" href="/">${user}</a></label>
            <div class="dropdown-content">
                <#if role>
                    <a href="/courses/add"><@s.message "course.add"/></a>
                    <a href="/users/all"><@s.message "users"/></a>
                    <a href="/logout"><@s.message "logout"/></a>
                <#else>
                    <a href="/logout"><@s.message "logout"/></a>
                    <a href="/user/results">Resoult</a>
                </#if>
            </div>
        </div>
    </div>

    <div class="main-inf">
        <h1>${course.name}</h1>
        <h3>${course.description}</h3>
        <h3<@s.message "number.of.lessons"/>: ${lessonsNum}</h3>
        <h3><@s.message "course.tegs"/>:
            <#list course.tegs as t>
                <span class="color-brown">${t.getName()}</span>,
            </#list>
        </h3>
        <#if role>
            <button class="button-edit" onclick="editCourse()"><@s.message "button.edit"/></button>
            <button class="button-delete" onclick="deleteCourse()"><@s.message "button.delete"/></button>
            <button class="button-add-lesson" onclick="addLesson(${course.getCourseId()})"><@s.message "button.add.lesson"/></button>
        </#if>
    </div>

    <div class="container-fluid">
        <div class="row">

            <div class="col-xs-12">

                <div id="cbp-fwslider" class="cbp-fwslider">
                    <ul>
                        <#list lessons as l>
                            <li><div class="card"><a href="/lesson?id=${l.getId()}">
                            <div class="card-block">
                            <@s.message "lesson"/>: ${l.number}
                            <h3>${l.name}</h3>
                            ${l.getDescription()}
                                    </a>
                            <#if role>
                                <br>
                                <button  onclick="editLesson(${l.getId()})"><@s.message "button.edit"/></button>
                                <button  onclick="deleteLesson(${l.getId()})"><@s.message "button.delete"/></button>
                                <#if l.getTest()??>
                                <#else>
                                    <button  onclick="addTest(${l.getId()})"><@s.message "button.add.test"/></button>
                                    </div>
                                    </div></li>
                                </#if>
                            </#if>
                        </#list>
                    </ul>

                </div>
            </div><!-- /.col-xs-12 -->
        </div><!-- /.row -->
    </div>

    <div class = "label-bottom">
        <div id="left">
            <label class="bolt">© «Campus Study»</label>
            <br>
            <a href="/?lang=ua">UA</a>/<a href="/?lang=en">EN</a>
        </div>
    </div>
</div>
</body>
</html>