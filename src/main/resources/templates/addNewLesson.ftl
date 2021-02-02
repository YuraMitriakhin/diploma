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
    #center {

        text-align: center;
    }
    .bolt{
        font-weight: bold;
    }
    .label-bottom{
        background: #fcbf62;
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
        padding-bottom: 1%;
    }
    .input-description{
        overflow-y: scroll;
        height: 300px;
        width: 70%;
        resize: none; /* Remove this if you want the user to resize the textarea */
        font-family: "Times New Roman";
        font-size: 20px;
    }
    .input-topic-name{
        overflow-y: scroll;
        width: 40%;
        max-height: 25px;
        resize: none; /* Remove this if you want the user to resize the textarea */
        font-family: "Times New Roman";
        font-size: 20px
    }
    .input-short-description{
        overflow-y: scroll;
        height: 50px;
        width: 40%;
        font-family: "Times New Roman";
        font-size: 20px;
        resize: none; /* Remove this if you want the user to resize the textarea */
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

    .red{
        color: red;
    }
    .choice-course{
        font-size: 20px;
        width: 25%;
        height: 40px;
    }
    .choose-number{
        font-size: 20px;
        width: 8%;
        height: 25px;
    }

    .input-link{
        width: 30%;
        height: 20px;
    }

</style>
<script>

        function checkFileSize (f)  {
            const file = Math.round(f.files.item(0).size / 1024);
            console.log("size-", file);
            if (file > 1000) {
                alert("File too Big, please select a file less than 1mb");
                f.value = "";
            }

        }

        function addFileInput() {
            var p = document.createElement("P");
            var input_block = document.getElementById("file-input");
            var input_file = document.createElement('input');
            var input_description = document.createElement('input');

            input_file.type = "file";
            input_file.name="files";
            input_file.onchange = function() {
                checkFileSize(this);
            };

            input_description.type = "text";
            input_description.name="descriptionToFiles";

            p.appendChild(input_file);
            p.appendChild(input_description);

            input_block.appendChild(p);
        };

        function addLinkInput() {
            var p = document.createElement("P");
            var input_block = document.getElementById("links");
            var input_file = document.createElement('input');

            input_file.type = "url";
            input_file.name="links";
            input_file.className = "input-link"

            p.appendChild(input_file);
            input_block.appendChild(p);
        };

        function l() {
            var num = document.getElementById("num");
            var vel = num.value;
            var m = false;
            <#list Lessons as l>
                 if(vel==${l.number}){
                     m=true;
                 };
            </#list>
            if (m==true){
                console.log("error");
                alert("<@s.message "error.use.number"/>");
                num.value=null;
            }
        };

</script>
<body>
<div class="main-font">
    <div class="label-heading">
        <label><a class = "a-main" href="/">Campus Study</a></label>
    </div>

    <form method="post" action="/lessons/save" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="add-topic">
          <p><h2><@s.message "topic.choose.course"/><span class="red">*</span></p>
          <p><select class="choice-course" required name="courseId" >
                      <tbody>
                      <option value="${Course.courseId}" selected>${Course.getName()} </option>
                      </tbody>
              </select></p>

          <p><@s.message "topic.number"/><span class="red">*</span></p>
         <p><input type="number" name="number" class="choose-number" onchange="l()" id="num" required></p>

        <p><@s.message "topic.name"/><span class="red">*</span></p>
        <p><textarea type="text" name="name" class="input-topic-name" maxlength="50" minlength="3" required></textarea> </p>
        <p><@s.message "topic.description"/><span class="red">*</span></p>
        <p><textarea type="text" name="description" class="input-short-description" maxlength="150" minlength="10" required></textarea> </p>
        <p><@s.message "topic.text"/><span class="red">*</span></p>
        <p ><textarea type="text" name="text" class="input-description" minlength="100" required></textarea></p>
        <p><@s.message "topic.add.photo"/></p>
          <div id="file-input">
          </div>
          <p><button type="button" class="button-add-photo" onclick="addFileInput()">+ <@s.message "button.add.photo"/> ...</button></p>

          <p><@s.message "topic.add.link"/></h2></p>
          <div id="links">
          </div>
          <p><button type="button" class="button-add-photo" onclick="addLinkInput()">+ <@s.message "button.add.link"/> ...</button></p>

         <p><button  type="submit" class="button-submit"><@s.message "button.save"/></button></p>
      </div>
    </form>

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