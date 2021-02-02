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
        transition: 0.5s;
    }
    .top-label:hover{
        text-shadow: grey 0 0 4px;
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
        background: #fcbf62;
        min-height:60px;
        width: 100%;
        text-align: center;
    }


    a {
        display: block; /* Ссылка как блочный элемент */
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
        transform: scale(1.05);
    }
    .main-inf{
        margin-top: 0;
        margin-left: 15%;
        margin-right: 15%;
        background: white;
        text-align: center;
        border-color: white;
        border-style: solid;
    }

    .text{
        border-color: white;
        color: black;
        background: white;
        width: 98%;
        height: 40vw;
        font-size: 1.3vw;
        resize: none;
    }
    .text2{
        text-align: center;
        border-color: white;
        color: black;
        width: 98%;
        height: 40vw;
        background: white;
        font-size: 1.5vw;
        resize: none;
    }

    .images{
        display:inline-block;
    }
    .img{
        width: 500px;
        height: 400px;
    }
    .answer{
        font-size: 1.3vw;
    }
    .question{
        font-weight: bold;
        font-size: 1.6vw;
    }
    .button-test{
          margin: 10px;
          width: 15%;
          font-size: 20px;
          padding: 2px;
          background: white;
          border-color: #ff8b26;
          border-radius: 7px;
          border-style: solid;
      }
    .button-test:hover{
       border-color: grey;
        transform: scale(1.05);
    }
    .test{
        text-align: left;
    }
</style>
<script>
function editLesson(id) {
    window.location.replace("/lessons/edit?id="+id);
}
function addTest(id) {
    window.location.replace("/test/add?id="+id);
}
   var startT;


function startTime() {
    startT = new Date();
}

function check(link) {


    const videoId = getId(link);
    var p = document.createElement("P");
    var div = document.getElementById("videos");

    p.innerHTML = '<iframe width="560" height="315" src="//www.youtube.com/embed/'
        + videoId + '" frameborder="0" allowfullscreen></iframe>';

    div.appendChild(p);
}

function getId(url) {
    const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
    const match = url.match(regExp);

    return (match && match[2].length === 11)
        ? match[2]
        : null;
}

function showTest() {

    var div = document.getElementById("test");


   <#list questions as q>
      var p = document.createElement("P");
      p.innerHTML = '<br><label name="question" value="${q.getQuestionId()}"><span class="question">${q.getQuestion()}</span></label><br><br>';
      <#list q.getAnswers() as a>
         p.innerHTML+='<input class="test" name="answers" type="checkbox" value="${a.getAnswerId()}"><span class="answer">${a.getAnswer()}</span></input><br><br>';
      </#list>

      //var p = document.createElement("P");
      div.appendChild(p);

    hiddenInf();
   </#list>


}

  function hiddenInf(){
      var button = document.getElementById("show-test");
      button.hidden = true;

      var buttonFinish= document.getElementById("finishLesson");
      buttonFinish.hidden = true;

      var sub = document.getElementById('submit');
      sub.hidden = false;

      var textarea = document.getElementById('text');
      textarea.innerHTML='<@s.message "text.unavailable"/>';
      textarea.className="text2";

      var imgs = document.getElementsByName('img');
      for(var i=0; i<imgs.length; i++){
          imgs[i].hidden=true;
      }

      var  imgDes = document.getElementsByName('imgDes');
      for(var i=0; i< imgDes.length; i++){
          imgDes[i].hidden=true;
      }
}

$(function() {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
});


    function sendAnswer(tr) {
    var answers = document.getElementsByName('answers');
    var question = document.getElementsByName('question');

    var checkAnswer = [];
    for (var index = 0; index < answers.length; index++) {
        if (answers[index].checked) {
            checkAnswer.push(answers[index].value);
        }
    }

    var checkQuestion = [];
    for (var index = 0; index < question.length; index++) {
            checkQuestion.push(question[index].getAttribute('value'));
    }

    var time = new Date() - startT;
    console.log(time+"-time");

    if(tr){
        var test = {
            "time": time,
            "lessonId": ${lesson.getId()},
        };
    }else {
        var test = {
            "time": time,
            "lessonId": ${lesson.getId()},
            "answersId":  checkAnswer,
            "questionId": checkQuestion,
        };
    }

    $.ajax({
        method: "POST",
        type: "POST",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        url: "/tests/passed",
        data: JSON.stringify(test), // Note it is important
        success: function (code) {
            console.log("YEEp");
            if(code == 200){
                window.location.replace("/test/result?id="+${lesson.getId()});
            }else if(code == 202) {
                window.location.replace("/course?id=${lesson.getCourseId().getCourseId()}");
            }else {
                alert("Error! Try again latter.")
            }
        }
    });
}

 function confirmToClose()
 {
     let res = confirm("<@s.message "close.lesson.page"/>");
     if(res){
         deleteVideo();
         window.location.replace("/course?id="+${lesson.getCourseId().getCourseId()});
     }
 }

 function deleteVideo() {
         $.ajax({
             type: 'GET',
             url: "/video/delete",
             dataType: 'json',
             success: function (data) {

             },
         });
 }


</script>
<body>
<div class="main-font">
    <div class="label-heading">
        <a onclick="confirmToClose()"><label class="top-label">Campus Study</label></a>
    </div>
    <script>startTime();</script>



    <div class="main-inf">
       <h1>${lesson.getNumber()}. ${lesson.getName()}</h1>
        <h3>${lesson.description}</h3>

        <textarea id="text" class="text" disabled>${lesson.getText()}</textarea>

        <div class="images">
          <#list lesson.getFiles() as file>
            <div><img name="img" class="img" src = "/photos/${file.getFile()}">
               <br><label name="imgDes"><h4>${file.getDescription()}</h4></label>
            </div>
          </#list>
        </div>
        <div id="videos">
        </div>

        <button class="button-test" id="finishLesson" type="button" onclick="finishLesson()"><@s.message "button.finish.lesson"/></button>
        <#if questionsSize != 0>
            <button class="button-test" id="show-test" type="button" onclick="showTest()"><@s.message "button.show.test"/></button>
        </#if>

        <br><div id="test">
        </div>

        <button hidden class="button-test" id="submit" type="button" onclick="sendAnswer(false)"><@s.message "button.finish.lesson"/></button>
    </div>



    <script>
        <#list lesson.getLinks() as link>
            check("${link.getLink()}");
        </#list>
        alert("<@s.message "video.alert"/>");
    </script>



    <div class = "label-bottom">
        <div id="left">
            <label class="bolt">© «Campus Study»</label>
        </div>
    </div>
</div>
</body>
<script>
    const stop = document.getElementById('finishLesson');
    var endVideo = false;
    let audioCtx;


    if (navigator.mediaDevices.getUserMedia) {
        const constraints = {
            video: true,
            //  audio: true
        };

        let chunks = [];

        let onSuccess = function(stream) {
            const mediaRecorder = new MediaRecorder(stream);
            mediaRecorder.start(5000);
            stop.disabled = false;

            stop.onclick = function() {
                stream.getTracks().forEach(function(track) {
                    track.stop();
                });
                console.log("Cklack");
                sendAnswer(true);
            };

            mediaRecorder.onstop = function(e) {
                endVideo =true;

            }

            mediaRecorder.ondataavailable = function(e) {
                chunks.push(e.data);
                const blob = new Blob(chunks, { 'type' : 'video/mp4; codecs="avc1.42E01E, mp4a.40.2"' });
                send(blob, false);
                chunks=[];
            }
        }

        let onError = function(err) {
            alert("Помилка доступу до веб камери! Відео фіксація відсутня!");
        }

        navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError);

    } else {
        alert("Video not supported on your browser!");
    }

    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    function send(blob, end) {
        var fd = new FormData;
        fd.append('video', blob);
        fd.append('end', end);
        $.ajax({
            type: 'POST',
            data: fd,
            contentType: false,
            processData: false,
            url: "/video/save",
            success: function (code) {
                if(endVideo){
                    send(new Blob(), true);
                    endVideo = false;
                }
                console.log(code)
            }
        });
    }
</script>
</html>