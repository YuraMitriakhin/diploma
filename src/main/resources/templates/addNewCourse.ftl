<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
    .a-main:hover {
        text-decoration: none;
        transform: scale(1.05);
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
    .input-topic-name{
        overflow-y: scroll;
        width: 40%;
        height: 30px;
        resize: none; /* Remove this if you want the user to resize the textarea */
        font-family: "Times New Roman";
        font-size: 25px
    }
    .input-short-description{
        overflow-y: scroll;
        height: 70px;
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
    .delete-course{
        background: white;
        font-size: 25px;
        width: 70%;
        height: 50px;
    }

    .radio-button{
        margin-left: 45%;
        text-align: left;
        font-size: 20px;
    }

    .tegs{
        margin-left: 33%;
        width: 35%;
        color: black;
    }
   .modal-content{
       padding: 25px;
       display: inline-block;
   }
    .modal-content button{
        margin-top: 15px;
        width:  40%;
    }
    .modal-content input{
        font-size: 18px;
        width:  100%;
    }



</style>
<script>


        function addTegInput() {
            var p = document.createElement("P");
            var input_block = document.getElementById("tegs");
            var input_teg = document.createElement('input');

            input_teg.type = "text";
            input_teg.name="tegs";
            input_teg.className = "input-link";


            //var name = prompt("Какое ваше имя?");
            p.textContent = "#";

            p.appendChild(input_teg);
            input_block.appendChild(p);
        };

        $('#myModal').on('shown.bs.modal', function () {
            $('#myInput').focus();
        });

        $(function() {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            $(document).ajaxSend(function(e, xhr, options) {
                xhr.setRequestHeader(header, token);
            });
        });

        function saveTopic(){
            var topic = document.getElementById("newTopic").value;

            $.ajax({
                method: "POST",
                type: "POST",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                url: "/topic/add",
                data: JSON.stringify(topic), // Note it is important
                success: function (code) {
                    console.log("Ok");
                    if(code == 200){
                        window.location.replace("/courses/add");
                    }else {
                        alert("Error! Try again latter.")
                    }
                }
            });
        }

        function deleteTopic(){
            var topic = document.getElementById("delete-course").value;
            console.log(topic);

            $.ajax({
                type: 'GET',
                url: "/topic/delete?id="+topic,
                dataType: 'json',
                success: function (data) {
                   if(data==200){
                       window.location.replace("/courses/add");
                   }else{
                       alert("Error! Try again latter.")
                   }
                },
            });
        }


</script>
<body>
<div class="main-font">
    <div class="label-heading">
        <label><a class = "a-main" href="/">Campus Study</a></label>
    </div>

    <form method="post" action="/courses/save" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="add-topic">
          <p><h2><@s.message "course.name"/><span class="red">*</span></p>
          <p><textarea type="text" name="name" class="input-topic-name" maxlength="50" minlength="3" required></textarea> </p>

          <p><@s.message "course.description"/><span class="red">*</span></p>
          <p><textarea type="text" name="description" class="input-short-description" maxlength="300" minlength="10" required></textarea> </p>

          <p><@s.message "course.level.difficulty"/><span class="red">*</span></p>
          <p><select class="choice-course" required name="difficulty" >
                      <tbody>
                      <option value="${easy}"><@s.message "course.difficulty.easy"/></option>
                      <option value="${medium}"><@s.message "course.difficulty.medium"/></option>
                      <option value="${easy}"><@s.message "course.difficulty.hard"/></option>
                      </tbody>
              </select></p>

          <p><@s.message "course.topic"/><span class="red">*</span></p>
          <p><select class="choice-course" required name="topicId" >
                  <#list Topics as t>
                      <tbody>
                      <option value="${t.topicId}">${t.name}</option>
                      </tbody>
                  </#list>
              </select></p>

          <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-sm"><@s.message "button.add.topic"/></button>
          <div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-sm">
                  <div class="modal-content">
                      <div class="show-topic"></div>
                      <input type="text" id="newTopic" placeholder="Topic">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal"><@s.message "button.close"/></button>
                      <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="saveTopic()"><@s.message "button.save"/></button>
                  </div>
              </div>
          </div>

          <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
              <@s.message "button.delete"/>
          </button>
          <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                  <div class="modal-content">
                      <div class="modal-body">
                          <select class="delete-course" required id="delete-course" >
                              <#list Topics as t>
                                  <tbody>
                                  <option value="${t.topicId}">${t.name}</option>
                                  </tbody>
                              </#list>
                          </select>
                      </div>
                      <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-dismiss="modal"><@s.message "button.close"/></button>
                          <button type="button" class="btn btn-primary" onclick="deleteTopic()"><@s.message "button.delete"/></button>
                      </div>
                  </div>
              </div>
          </div>

          <p><@s.message "course.type"/><span class="red">*</h2></span></p>
          <div class="radio-button">
              <p><input name="type" type="radio" value="false"> <@s.message "course.type.free"/></p>
              <p><input name="type" type="radio" value="true"> <@s.message "course.type.premium"/></p>
          </div>



          <p><h2><@s.message "course.tegs"/></h2></p>
          <div id="tegs" class="tegs">
          </div>
          <p><button type="button" class="button-add-photo" onclick="addTegInput()">+ <@s.message "course.button.add.tegs"/> ...</button></p>

         <p><button  type="submit" class="button-submit"><@s.message "button.save"/></button></p>
      </div>
    </form>

    <div class = "label-bottom">
        <div id="left">
            <label class="bolt">© 2020–... «Campus Study»</label>
        </div>

    </div>
</div>
</body>
</html>