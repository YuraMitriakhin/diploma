<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</head>
<script>
    function hidd(){
        console.log(121);
        var div = document.getElementById('txt');
        div.hidden = true;
    }

</script>
<body>
<div id="txt">
    <h1>Hello</h1>
</div>
<button onclick="hidd()">Hidden</button>

<script>
    document.addEventListener("DOMContentLoaded", function(event) {
      //  window.onpopstate = function(event) {
      //      console.log(111111);
      //      alert("location: " + document.location + ", state: " + JSON.stringify(event.state));
      //  };

        window.onpopstate =function(e){
            alert("змінено запис в історії браузера");
        }
    });

</script>
</body>

</html>