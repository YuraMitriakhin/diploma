<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Webcam start/stop</title>
    <script>
        let webcamStream;

        function startWebcam() {
            // запросить видео и аудио поток с веб-камеры пользователя
            navigator.mediaDevices.getUserMedia({
                audio: true,
                video: true
            }).then((stream) => {
                let video = document.querySelector('#video');
                video.srcObject = stream;
                video.play();

                webcamStream = stream;
            }).catch((error) => {
                console.log('navigator.getUserMedia error: ', error);
            });
        }

        function stopWebcam() {
            webcamStream.getTracks()[0].stop(); // audio
            webcamStream.getTracks()[1].stop(); // video
        }
    </script>
</head>
<body >
<video width=400 height=400 id="video" controls></video>
<p>
    <button onclick="startWebcam();">Start WebCam</button>
    <button onclick="stopWebcam();">Stop WebCam</button>
</p>
</body>
</html>
