<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
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
    }
    .main-font {
        background: #fff2bf;
        padding-bottom: 500px;
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
        background: #ff8b26;
        min-height:100%;
        text-align: center;
    }
    .add-topic{
        background: white;
        margin-left: 10%;
        margin-right: 10%;
        min-height: 100%;
        text-align: center;
        padding-top: 1%;
    }

    .button-submit{
        width: 10%;
        height: 40px;
        border-color: #ff8b26;
        font-size: 20px;
        min-width: 100px;
        border-radius: 7px;
    }
    .button-submit:hover{
        border-color: grey;
        transform: scale(1.05);
    }


    .button-add-photo{
        width: 20%;
        min-width: 250px;
        height: 20px;
        border: none;
        background: white;
        font-size: 20px;
        color: dodgerblue;
        outline: none;
    }

    .input-question{
        width: 50%;
        height: 25px;
        font-size: 20px;
    }
    .input-answer{
        width: 30%;
        height: 20px;
        font-size: 15px;
    }
    .button-add-answer{
        background: white;
        border-color: #ff8b26;
        border-width: 1px;
        font-size: 18px;
        border-radius: 7px;
    }
    .button-add-answer:hover{
        border-color: grey;
        transform: scale(1.05);

    }
    .select-type{
        height: 25px;
        font-size: 20px;
    }

</style>
<script>
    function addAnswer(num) {
        var p = document.createElement("P");
        var input_block = document.getElementById("answer-field-"+num);

       var n = parseInt(input_block.getAttribute('value'))+1;
       input_block.setAttribute('value',n);

       p.innerHTML = '<h6><@s.message "answer"/>'+n
           +'<input id="answers" type="text" name="answers" class="input-answer"><input type="checkbox" name="correct'+num+'" value="'+n
           +'"> <input type="hidden" name="numbers" value="'+ num +'">';

        input_block.appendChild(p);
    };
    function addQuestion() {
        var div = document.createElement("div");
        var input_block = document.getElementById("question-field");

        var num = parseInt(input_block.getAttribute('value'))+1;

        div.innerHTML = '<br><p><h2> <@s.message "enter.question"/>'+num+': <input id="questions" class="input-question" type="text" name="questions" num="'
            +num+'"></p>   <p><@s.message "course.type"/><select class="select-type" name="type">\n' +
            '                       <option value="LEC"><@s.message "grammatical"/></option>\n' +
            '                       <option value="GRAM"><@s.message "lexical"/></option>\n' +
            '               </select></p><div id="'
            + "answer-field-"+num +'" value="0"></div><button type="button" class="button-add-answer" onclick="addAnswer('
            +num+')"><@s.message "button.add.answer"/></button>';
        input_block.setAttribute('value', num);

        input_block.appendChild(div);
    };

    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    function post() {
        var n = parseInt(document.getElementById("question-field").getAttribute('value'));

        var correct = [];
        for(var i=1; i<=n; i++){
            var c = document.getElementsByName('correct'+i);
            var arr =[];
            for (var index = 0; index < c.length; index++) {
                if (c[index].checked) {
                    arr.push(c[index].value);
                }
            }
            correct.push(arr);
        }

        var post = {
            "lesson": $("input[name='lesson']").val(),
            "questions": $("input[name='questions']")
                .map(function(){return $(this).val();}).get(),
            "answers": $("input[name='answers']")
                .map(function(){return $(this).val();}).get(),
            "numbers": $("input[name='numbers']")
                .map(function(){return $(this).val();}).get(),
            "correct": correct,
            "types": $("select[name='type']").map(function(){return $(this).val();}).get()
        };


        $.ajax({
            method: "POST",
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            url: "/test/save",
            data: JSON.stringify(post), // Note it is important
            success: function (code) {
                window.location.replace("/");
            }
        });
    }
</script>
<body>
<div class="main-font">
    <div class="label-heading">
        <label><a class = "a-main" href="/">Campus Study</a></label>
    </div>

        <input type="hidden" name="lesson" value="${lesson.getId()}"/>

   <div class="add-topic">

       <div id="question-field" value="1">
           <p><h2><@s.message "enter.question"/>1: <input type="text" name="questions" class="input-question"></p>

           <p><@s.message "course.type"/><select class="select-type" name="type">
                       <option value="LEC"><@s.message "grammatical"/></option>
                       <option value="GRAM"><@s.message "lexical"/></option>
               </select></p>

          <div id="answer-field-1" value="0">
          </div>
           <button type="button" class="button-add-answer" onclick="addAnswer(1)"><@s.message "button.add.answer"/></button>
       </div>
       <p><button type="button" class="button-add-photo" onclick="addQuestion()">+ <@s.message "button.add.question"/> ...</button></p>

       <p><button  type="button" onclick="post()" class="button-submit"><@s.message "button.save"/></button></p>
   </div>


</div>
</body>
</html>