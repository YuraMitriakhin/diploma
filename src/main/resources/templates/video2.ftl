<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    html, body {
        height: 100%;
    }

    body {
        font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
        font-size: 0.8rem;
    }

    .wrapper {
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    h1, h2 {
        font-size: 2rem;
        text-align: center;
        font-weight: normal;
        padding: 0.5rem 0 0 0;
    }

    .main-controls {
        padding: 0.5rem 0;
    }

    canvas {
        display: block;
        margin-bottom: 0.5rem;
    }

    #buttons {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
    }

    #buttons button {
        font-size: 1rem;
        padding: 1rem;
        width: calc(50% - 0.25rem);
    }

    button {
        font-size: 1rem;
        background: #0088cc;
        text-align: center;
        color: white;
        border: none;
        transition: all 0.2s;
        padding: 0.5rem;
    }

    button:hover, button:focus {
        box-shadow: inset 0px 0px 10px rgba(255, 255, 255, 1);
        background: #0ae;
    }

    button:active {
        box-shadow: inset 0px 0px 20px rgba(0,0,0,0.5);
        transform: translateY(2px);
    }


    /* Make the clips use as much space as possible, and
     * also show a scrollbar when there are too many clips to show
     * in the available space */
    .sound-clips {
        flex: 1;
        overflow: auto;
    }

    section, article {
        display: block;
    }

    .clip {
        padding-bottom: 1rem;
    }

    audio {
        width: 100%;
        display: block;
        margin: 1rem auto 0.5rem;
    }

    .clip p {
        display: inline-block;
        font-size: 1rem;
    }

    .clip button {
        font-size: 1rem;
        float: right;
    }

    button.delete {
        background: #f00;
        padding: 0.5rem 0.75rem;
        font-size: 0.8rem;
    }

    /* Checkbox hack to control information box display */

    label {
        font-size: 3rem;
        position: absolute;
        top: 2px;
        right: 3px;
        z-index: 5;
        cursor: pointer;
        background-color: black;
        border-radius: 10px;
    }

    input[type=checkbox] {
        position: absolute;
        top: -100px;
    }

    aside {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        transform: translateX(100%);
        transition: 0.3s all ease-out;
        background-color: #efefef;
        padding: 1rem;
    }

    aside p {
        font-size: 1.2rem;
        margin: 0.5rem 0;
    }

    aside a {
        color: #666;
    }

    /* Toggled State of information box */
    input[type=checkbox]:checked ~ aside {
        transform: translateX(0);
    }

    /* Cursor when clip name is clicked over */

    .clip p {
        cursor: pointer;
    }

    /* Adjustments for wider screens */
    @media all and (min-width: 800px) {
        /* Don't take all the space as readability is lost when line length
           goes past a certain size */
        .wrapper {
            width: 90%;
            max-width: 1000px;
            margin: 0 auto;
        }
    }

</style>
<script>
    function f() {
        window.location.replace("/");
    }
</script>
<body>
<div class="wrapper">

    <header>
        <h1>Web dictaphone</h1>
    </header>

    <section class="main-controls">
        <canvas class="visualizer" height="60px"></canvas>
        <div id="buttons">
            <button id="stop" class="stop">Stop</button>
        </div>
    </section>

</div>
<script>
    const stop = document.getElementById('stop');
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
                f();
            };

            mediaRecorder.onstop = function(e) {
                console.log("recorder stopped End");
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
            alert("Error!");
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
</body>
</html>