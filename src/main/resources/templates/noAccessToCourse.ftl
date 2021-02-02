<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</head>
<style>
    .label-heading{
        width: 100%;
        background: #ff8b26; /* Цвет фона */
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
    .bolt{
        font-weight: bold;
    }
    .label-bottom{
        bottom: 0;
        position: absolute;
        background: #ff8b26;
        min-height: 50px;
        width: 100%;
        text-align: center;
    }
    .central-label{
        padding-top: 16%;
        padding-bottom: 16%;
        text-align: center;
        font-size: 45px;
        font-weight: bold;
    }
    .label2{
        font-size: 30px;
    }

</style>
<script>


</script>
<body>
<div class="main-font">
    <div class="label-heading">
        <label><a class = "a-main" href="/">Campus Study</a></label>
    </div>
    <div class="central-label">
        <@s.message "label.no.access"/>
        <br><span class="label2"><@s.message "label.problem.solving"/></span>
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