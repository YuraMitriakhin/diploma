<!DOCTYPE html>
<#import "/spring.ftl" as s/>
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
        padding-bottom: 300px;
    }
    .list-box {
        width: 40%;
        height: 100%;
        margin-left: 25%;
        margin-right: 25%;
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
        border-style: solid;
        border-radius: 10px;
        border-color: #ff8b26;
        font-size: 1.3vw;
        transition: 1s;
    }
    .list:hover {
        border-color: grey;
        transform: scale(1.15);
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

    .label-bottom{
        bottom: 0;
        width: 100%;
        position: absolute;
        background: #fcbf62;
        min-height:50px;
        text-align: center;
    }

    a {
        display: block; /* Ссылка как блочный элемент */
        height: 100%; /* Высота на весь слой */
        weight: 100%;
        color: black; /* Цвет ссылки */
        text-decoration: none;
    }
    .a-main {
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
        color: black;
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

    .bolt{
        font-weight: bold;
    }

    .search-field button{
        background: white;
        margin: 5% 5% 10px 28%;
        border-color: #ff8b26;
        font-size: 20px;
        border-radius: 7px;
    }
    .search-field button:hover{
        border-color: grey;
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
    .red{
        color: red;
    }
    .input-search{
        margin-top: 5px;
        margin-left: 30%;
        width: 50%;
        height: 30px;
        font-size: 1.4vw;
    }
    .button-search{
        top: 0;
        margin-left: 2px;
        border-style: solid;
        border-color: #ff8b26;
        background: white;
        border-width: 2px;
        border-radius: 7px;
    }
    .button-search:hover{
        border-color: grey;
    }


</style>
<script>
function searchUser() {
     var un = document.getElementById('search').value;
     var div = document.getElementById('listBox');
     var element = document.createElement("li");
     element.className = "list";
     if(un!=""){
         div.innerHTML="";
         <#list users as u>
             if(un=="${u.getUsername()}"|| un=="${u.getEmail()}" ){
                 element.innerHTML = '<a href="/user?id=${u.getId()}"><h2>${u.getUsername()}</h2>${u.getEmail()}\n' +
                     '                    <#if u.isPremium()>' +
                     '                        <span class="red">Premium</span>' +
                     '                    </#if>' +
                    '                    </a></li>';
                div.appendChild(element);
             }
         </#list>
     }else {
         div.innerHTML="";
         <#list users as u>
             var e = document.createElement("li");
             e.className = "list";
             e.innerHTML = '<a href="/user?id=${u.getId()}"><h2>${u.getUsername()}</h2>${u.getEmail()}\n' +
                 '                    <#if u.isPremium()>' +
                 '                        <span class="red">Premium</span>' +
                 '                    </#if>' +
                 '                    </a></li>';
             div.appendChild(e);
         </#list>
     }
}
</script>
<body>
<div class="main-font">
<div class="label-heading">
    <label><a class = "a-main" href="/">Campus Study</a></label>
</div>

  <div class="list-box">
      <input class="input-search" type="text" id="search" placeholder="<@s.message "username.or.email"/>"><button class="button-search" type="button" onclick="searchUser()"><@s.message "button.search"/></button>
      <div id="listBox">
       <ul>
         <div id="element">
           <#list users as u>
                <li class="list"><a href="/user?id=${u.getId()}"><h2>${u.getUsername()}</h2>${u.getEmail()}
                    <#if u.isPremium()>
                        <span class="red"><@s.message "course.type.premium"/></span>
                    </#if>
                    </a></li>
           </#list>
         </div>
       </div>
    </ul>
  </div>
</div>
<div class = "label-bottom">
    <label class="bolt">© 2020–... «Campus Study»</label>
</div>
</body>
</html>