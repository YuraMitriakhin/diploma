<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
</head>
<body>
   <div class="container">
       <div class="row">
           <div class="col-md-6 col-md-offset-3">
               <div class="panel panel-default" style="margin-top:45px">

                   <div class="panel-heading">
                       <h3 class="panel-title">ID ${users.id}</h3>
                   </div>

                   <div class="panel-body">

                       <div class="form-group">
                           <img src="">
                       </div>

                       <div class="form-group">
                           <label for="username">Username: ${users.username}
                           </label>
                       </div>

                       <div class="form-group">
                           <label for="username">Email: ${users.email}</label>
                       </div>

                           <button type="submit" class="btn btn-default"><a href="/tickets?cruiseId=${users.id}">Ok</a></button>
                   </div>
               </div>
           </div>
       </div>
   </div>
</body>
</html>