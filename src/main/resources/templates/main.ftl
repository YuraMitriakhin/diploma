<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<html>
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<style>
    .main-font {
        background: #fff2bf;
    }
    .list-box {
        width: 60%;
        height: 100%;
        margin-left: 25%;
        margin-right: 15%;
        margin-bottom: 8%;
        display:inline-block;
    }
    .list {
        white-space: pre-line;
        width: 100%;
        padding: 1%; /* Поля вокруг текста */
        margin-top: 20px;
        color: white; /* Цвет ссылки */
        list-style-type: none;
        background: white;
        border-radius: 10px;
        border-style: solid dotted none dotted;
        border-color: #ff8b26;
        font-size: 1.3vw;
        transition: 0.7s;
    }
    .list:hover{
        transform: scale(1.08);
    }

    .label-heading{
        width: 100%;
        background: #fcbf62; /* Цвет фона */
        padding-top: 1%;
        padding-bottom: 1%;
        font-family: Marker Felt, fantasy;
        letter-spacing: 1px;
        font-size: 52px;
        color: white;
        text-align: center;
    }
    .label-heading-information{
        font-size: 24px;
        text-align: right;
        padding-right: 10%;
    }
    .label-bottom{
        bottom: 0;
        background: #fcbf62;
        min-height:50px;
        text-align: center;
    }

    a {
         /* Ссылка как блочный элемент */
        height: 100%; /* Высота на весь слой */
        weight: 100%;
        color: black; /* Цвет ссылки */
        text-decoration: none;
    }
    .a-main {
        color: black; /* Цвет ссылки */
        text-decoration: none;
    }
    .a-user {
        position: absolute;
        left: 85%;
        top: 85px;
        font-size: 18px;
        color: black; /* Цвет ссылки */
        text-decoration: none;
    }
    .a-user:visited {
        color: black; /* Цвет ссылки */
        text-decoration: none;
    }
    .a-main:visited {
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
        color: grey;
    }
    h2 {
        font-weight: bold;
    }

    h5{
        padding-left: 15%;
    }
    h6{
        font-size: 3vw;
    }


    #center {
        text-align: center;
    }
    .bolt{
        font-weight: bold;
    }
    .search-bar{
        position: absolute;
        width: 20%;
        min-width: 150px;
        background: white;
        display:inline-block;
        border-color: #ff8b26;
        border-right-style: solid;
        border-bottom-style: solid;
        border-width: 2px;
        font-size: 20px;

    }
    .search-field{
        padding-left: 7%;
        border-bottom-color: #ff8b26;
        border-bottom-style: solid;
        border-width: 1px;
        display: block;
        position: relative;
    }
    .search-field button{
        background: white;
        border-radius: 8px;
        margin: 5% 5% 10px 28%;
        border-color: #ff8b26;
        font-size: 20px;
    }
    .search-field button:hover{
        border-color: grey;
    }
    .box{white-space:nowrap}

    .radio_buttons {
        margin: 5%;
        margin-bottom: 15%;
        font-size: 100%;

    }
    .radio_buttons div {
        margin: 1%;
        float: left;
    }
    .radio_buttons input {
        position: absolute;
        left: -9999px;
    }
    .radio_buttons label {
        display: block;
        margin: 0 0 0 -1px;
        padding: 5px;
        border: 1px solid #BBBBBB;
        box-shadow: 0 2px 5px rgba(0, 0, 0, .12);
        border-radius: 20px;
        cursor: pointer;
    }
    .radio_buttons input:checked + label {
        background:  #ffc266;
        box-shadow: inset 0 3px 6px rgba(0, 0, 0, .2);
    }
    .button-search{
        margin-left: 5%;
        margin-top: 10%;
        position: absolute;
    }

    .button-show-all{
        width: 20%;
        min-width: 200px;
        height: 20px;
        border: none;
        background: white;
        font-size: 18px;
        color: grey;
        outline: none;
    }
    .color-red{
        color: #ff3b14;
        font-size: 20px;
    }
    .local{
        display: inline-block;
    }

    .dropbtn {
        background-color: #4CAF50;
        color: white;
        padding: 16px;
        font-size: 16px;
        border: none;
    }

    /* The container <div> - needed to position the dropdown content */
    .dropdown {
        top: 0;
        left: 90%;
        font-size: 14px;
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

    /* Change the background color of the dropdown button when the dropdown content is shown */
    .dropdown:hover .dropbtn {background-color: #3e8e41;}

    .search{
        margin-left: 35%;
    }
    .search input{
        width: 50%;
        font-size: 25px;
        height: 30px;
    }
    .search button{
       background: white;
        border-style: ridge;
        border-color: #ff8b26;
    }
    .top-label:hover{
        text-shadow: grey 0 0 4px;
        transform: scale(1.05);
    }


</style>
<script>

    function getTegs() {
        $.ajax({
            type: 'GET',
            url: "/tags/get",
            dataType: 'json',
            success: function (data, status) {
                var index;
                for (index = 0; index < data.length; ++index) {
                    addFileInput(JSON.parse(JSON.stringify(data[index])));
                }
            },
        });
    }

    function addFileInput(teg) {
        var div = document.createElement("div");
        var divCheckbox = document.getElementById("radioButtons");
        var button = document.getElementById("show-tegs-button");

        div.innerHTML = '<input type="checkbox" name="tegs" id="'+teg.tegId+'">\n' + '<label for="'+teg.tegId+'">'+teg.name+'</label></div>';
        button.hidden = true;
        divCheckbox.appendChild(div);
    };

    function search() {
        var course = {
            "type": $('input[name=type]:checked').val(),
            "topics": $("#topics").is(':checked'),
            "difficulty": $("#difficulty").is(':checked'),
            "tegs": $("#tegs").is(':checked')
        };

        var type = document.getElementsByClassName('type');
        var topics = document.getElementsByClassName('topics');
        var difficulty = document.getElementsByClassName('difficulty');
        var tegs = document.getElementsByClassName('tegs');

        var topicsChecked = []; // можно в массиве их хранить, если нужно использовать
        var difficultyChecked = [];
        var tegsChecked = [];
        var typeChecked;

        for (var index = 0; index < topics.length; index++) {
            if (topics[index].checked) {
                console.log(topics[index].value);
                topicsChecked.push(topics[index].value); // положим в массив выбранный
               // alert(checkboxes[index].value);  // делайте что нужно - это для наглядности
            }
        }
        for (var index = 0; index < difficulty.length; index++) {
            if (difficulty[index].checked) {
                difficultyChecked.push(difficulty[index].value); // положим в массив выбранный
                // alert(checkboxes[index].value);  // делайте что нужно - это для наглядности
            }
        }
        for (var index = 0; index < tegs.length; index++) {
            if (tegs[index].checked) {
                tegsChecked.push(tegs[index].value); // положим в массив выбранный
                // alert(checkboxes[index].value);  // делайте что нужно - это для наглядности
            }
        }
        for (var index = 0; index < type.length; index++) {
            if (type[index].checked) {
                typeChecked=type[index].value; // положим в массив выбранный
                //alert(type[index].value);  // делайте что нужно - это для наглядности
            }
        }

        course.topics = topicsChecked;
        course.difficulty = difficultyChecked;
        course.tegs = tegsChecked;
        course.type = typeChecked;

        $.ajax({
            type: 'GET',
            url: "/courses/get",
            dataType: 'json',
            success: function (data, status) {
                var index;
                getData(data)

            },
        });

        function getData(dt) {

            var findCourse = [];
            var erT = false;
            var erT2 = true;

            for (j = 0; j < course.topics.length; ++j) {
                erT = true;
                for (index = 0; index < dt.length; ++index) {
                    if (course.topics[j] == dt[index].topic) {
                        console.log("11");
                        findCourse.push(dt[index]);
                        erT=false;
                        erT2 = false;
                    }
                }
            };

            if(erT && erT2){
                console.log("stop");
                showCourses(findCourse);
                return;
            }

            if ((course.type == "null" && findCourse == 0) || (course.type==null && findCourse == 0)) {
                console.log("12");
                findCourse = dt;
            }else if (course.type == "null" || course.type==null){

            }else if (findCourse == 0) {
                for (index = 0; index < dt.length; ++index) {
                    if (course.type == dt[index].type.toString()) {
                        console.log("13");
                        findCourse.push(dt[index]);
                    }
                }

            }else {
                for (index = 0; index < findCourse.length; ++index) {
                   // console.log(course.type);
                  //  console.log(findCourse[index].type.toString());
                  //  console.log(course.type);
                    if (course.type != findCourse[index].type.toString()) {
                        findCourse.splice(index, 1);
                        index--;
                    }
                }
            }


            if (course.difficulty.length != 0) {
                if (findCourse == 0) {
                    for (var j = 0; j < course.difficulty.length; ++j) {
                        for (var index = 0; index < dt.length; ++index) {
                            if (course.difficulty[j] == dt[index].difficulty) {
                                findCourse.push(dt[index]);
                            }
                        }
                    }
                } else {
                        for (var index = 0; index < findCourse.length; ++index) {
                            var r = true;
                            for (var j = 0; j < course.difficulty.length; ++j) {
                                if (course.difficulty[j] == findCourse[index].difficulty) {
                                    r = false;
                                }
                            }
                            if (r) {
                                findCourse.splice(index, 1);
                                index--;
                            }
                        }
                }
            };


            if (course.tegs.length != 0) {
                    for (var j = 0; j < course.tegs.length; ++j) {
                        for (var index = 0; index < findCourse.length; ++index) {
                            var r = true;

                            var str = findCourse[index].tegs;
                            str = str.substring(0, str.length - 1);
                            str = str.substring(1);
                            str = str.split(',')

                            for (var l = 0; l < str.length; ++l) {

                                if (course.tegs[j] == str[l]) {
                                    r = false;
                                }
                            }
                            if (r) {
                                findCourse.splice(index, 1);
                                index--;
                            }
                        }

                    }
            }
                console.log(findCourse);
                showCourses(findCourse);
        }

        function showCourses(courses) {
            var divCourses = document.getElementById("list-courses");
            while(divCourses.firstChild){
                divCourses.removeChild(divCourses.firstChild);
            }

           for(var i=0; i<courses.length; i++){
               var li = document.createElement("div");
              // console.log(courses[i].courseId);
               var prem = "";
               if(courses[i].type==true){
                  prem="(premium)"
               }
               li.innerHTML = '<li class="list"><a href="/course?id='+courses[i].courseId+'"><h2>'+courses[i].name+
                   '<span class="color-red">'+prem+'</span>'+'</h2>'+courses[i].description+'</a></li>';
               divCourses.appendChild(li);
           }
        }

    }


</script>
<body>
<div class="main-font">
<div class="label-heading">
    <a class = "a-main" href="/"><label class="top-label">Campus Study</label></a>

    <div class="dropdown">
        <label><a class = "a-user" href="/">${user}</a></label>
      <div class="dropdown-content">
        <#if role>
            <a href="/courses/add"><@s.message "course.add"/></a>
            <a href="/users/all"><@s.message "users"/></a>
            <a href="/logout"><@s.message "logout"/></a>
            <#else>
                <a href="/logout"><@s.message "logout"/></a>
                <a href="/user/results"><@s.message "result"/></a>
          </#if>
      </div>
    </div>
</div>

<div class="box">
  <div class="search-bar">
     <div class="search-field">
         <button type="button" onclick="search()"><@s.message "button.search"/></button>
      <p ><h5><@s.message "search.course.topic"/></h5>
        <#list topics as t>
            <input class="topics" id="topics" type="checkbox" name="topics" value="${t.topicId}" >${t.name}<br>
        </#list>
       </p>
    </div>
      <div class="search-field"> 
         <p><h5><@s.message "course.type"/></h5>
          <input class="type" id="type" name="type" type="radio" value="null"><@s.message "all"/><br>
          <input class="type" id="type" name="type" type="radio" value=false><@s.message "course.type.free"/><br>
          <input class="type" id="type" name="type" type="radio" value=true><@s.message "course.type.premium"/><br>
          </p>
      </div>
      <div class="search-field">
          <p><h5><@s.message "course.level.difficulty"/></h5>
          <input class="difficulty" id="difficulty" name="difficulty" type="checkbox" value="${easy}"><@s.message "course.difficulty.easy"/><br>
          <input class="difficulty" id="difficulty" name="difficulty" type="checkbox" value="${medium}"><@s.message "course.difficulty.medium"/><br>
          <input class="difficulty" id="difficulty" name="difficulty" type="checkbox" value="${hard}"><@s.message "course.difficulty.hard"/><br>
          </p>
      </div>
             <p><h5><@s.message "course.tegs"/></h5></p>
          <div id="radioButtons" class="radio_buttons">
          <#list tegs as teg>
              <div>
                  <input class="tegs" type="checkbox" name="tegs" value="${teg.tegId}" id="${teg.tegId}">
                  <label for="${teg.tegId}">${teg.getName()}</label>
              </div>
          </#list>
              <div><button id="show-tegs-button" type="button" class="button-show-all" onclick="getTegs()"><@s.message "button.show.all"/></button></div>
         </div>
  </div>

  <div class="list-box">
    <ul>
      <div id="list-courses">
          <#list courses as c>
              <#if c.type == true>
                  <li class="list"><a href="/course?id=${c.courseId}"><h2>${c.name}<span class="color-red">(premium)</span></h2>${c.description}</a></li>
              <#else>
                <li class="list"><a href="/course?id=${c.courseId}"><h2>${c.name}</h2>${c.description}</a></li>
              </#if>
          </#list>
      </div>
    </ul>
  </div>
</div>
</div>
<div class = "label-bottom">
    <label class="bolt">© «Campus Study»</label>
    <br>
    <a href="/?lang=ua">UA</a>/<a href="/?lang=en">EN</a>
</div>
</body>
</html>