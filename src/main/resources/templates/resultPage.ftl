<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
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
        padding-bottom: 230px;
        background: #fff2bf;
        transition: 0.5s;
    }
    .a-main {
        color: black; /* Цвет ссылки */
        text-decoration: none;
        transition: 0.5s;
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
        margin-top: 10%;
        margin-left: 22%;
        margin-right: 22%;
        background: white;
        text-align: center;
        border-radius: 15px;
        border-color: #ff8b26;
        border-style: solid;
        padding-bottom: 40px;
        font-size: 28px;
    }
    .bolt{
        font-weight: bold;
    }
    .label-bottom{
        position: absolute;
        bottom: 0;
        right: 0;
        left: 0;
        background: #fcbf62;
        text-align: center;
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

    function recomendation() {
        var lex = ${result.getLexicalMistakes()};
        var gram = ${result.getGrammaticalMistakes()};
        var mist =  ${result.getMistakes()};

        var recomend = document.getElementById("result");
        var div = document.createElement('label');


        if(mist == 0){
            console.log(11);
            div.innerHTML= '<@s.message "result.no.mistake"/><br>';
        }else if(lex==gram){
            console.log(12);
            div.innerHTML='<@s.message "result.different.mistake"/><br>';
        }else if(lex>gram){
            console.log(13);
            div.innerHTML='<@s.message "result.lex.mistake"/><br>';
        }else{
            console.log(14);
            div.innerHTML='<@s.message "result.gram.mistake"/><br>';
        }
        recomend.appendChild(div);

    }


</script>
<body>
<div class="main-font">
    <div class="label-heading">
        <a class = "a-main" href="/"><label class="top-label">Campus Study</label></a>

        <div class="dropdown">
            <label class="username">${user}</label>
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

    <div id="result" class="main-inf">
        <h2><@s.message "mistake.number"/>: ${result.getMistakes()}</h2>
        <h2><@s.message "spent.time"/>: ${result.getTime()}<@s.message "minute"/></h2>

    </div>

    <div class = "label-bottom">
        <div id="left">
            <label class="bolt">©«Campus Study»</label>
        </div>

    </div>
</div>
<script>  recomendation(); </script>
</body>
</html>