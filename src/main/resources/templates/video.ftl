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
        background: #ff8b26;
        min-height:100%;
        text-align: center;
    }

</style>
<script>

    function captureVideo () {
        let recording = document.querySelector('#recording');
        navigator.mediaDevices.getUserMedia({
            video: true
        }).then((stream) => {
            let preview = document.querySelector('#preview');
            preview.srcObject = stream;
           // preview.play();

            return new Promise(resolve => preview.onplaying = resolve);
        }).then(() => {
            let recorder = new MediaRecorder(preview.captureStream());
            let data = [];

            recorder.ondataavailable = event => data.push(event.data);
            recorder.start();
            console.log(recorder.state + " for " + (6000/1000) + " seconds...");

            let stopped = new Promise((resolve, reject) => {
                recorder.onstop = resolve;
                recorder.onerror = event => reject(event.name);
            });

            $('button.stop').click(function () {
                recorder.stop();
            });

            return Promise.all([stopped]).then(() => data);
        }).then ((recordedChunks) => {
            let recordedBlob = new Blob(recordedChunks, {
                type: "video/webm"
            });
            recording.src = URL.createObjectURL(recordedBlob);
            $('#preview').hide();
            $('#recording').show();
            console.log("Successfully recorded " + recordedBlob.size + " bytes of " +
                recordedBlob.type + " media.");
            $('button.upload').click(function() {
                sendVideoToAPI(recordedBlob);
            });
        });
    }
    function sendVideoToAPI (blob) {

        let fd = new FormData();
        let file = new File([blob], 'recording');

        fd.append('data', file);
        console.log(fd); // test to see if appending form data would work, it didn't this is completely empty.


        let form = new FormData();
        let request = new XMLHttpRequest();
        form.append("file",file);
        request.open("POST",  "/video/save", true);
        request.send(form); // hits the route but doesn't send the file
        console.log(request.response);// returns nothing

        request.onload = function () {
            if (request.readyState === request.DONE) {
                if (request.status === 200) {
                    console.log(request.response);
                }
            }
        };

        // I have also tried this method which hits the route and gets a response however the file is not present in the request when it hits the server.
        // $.ajax({
        //     url: Routing.generate('upload'),
        //     data: file,
        //     contentType: false,
        //     processData: false,
        //     error: function (res) {
        //         console.log(res);
        //     },
        //     success: function(res) {
        //         console.log(res);
        //     }
        // });
    }

    captureVideo();

</script>
<body>
<div class="main-font">
    <div class="label-heading">
        <label><a class = "a-main" href="/">Campus Study</a></label>
    </div>

    <video id="preview" autoplay width="400" height="300"></video>
    <video id="recording" width="400" height="300" style="display:none;" controls></video>

    <div>
        <div class="progress-bar"></div>
        <span>01:00</span>
    </div>
    <button class="record">Record</button>
    <button class="stop">Stop</button>
    <button class="upload">Upload</button>


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