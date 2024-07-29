<!DOCTYPE html>
<html>
<head>
    <title>Registro de Nuevo Usuario</title>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <style>
        body {
            background-color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            padding-top: 50px;
        }
        .span3.well {
            background-color: #444;
            border-color: #555;
            width: 50%; /* Aumentar el tamaño del div */
            margin: 0 auto; /* Centrar el div */
            padding: 20px; /* Agregar algo de padding para mejor visualización */
            color: #fff; /* Cambiar el color del texto a blanco */
        }
        .span3.well legend {
            color: #fff; /* Cambiar el color del título a blanco */
        }
        input[type="text"], input[type="password"] {
            background-color: #555;
            color: #fff;
            border-color: #666;
            width: 100%; /* Hacer los inputs más anchos */
        }
        .btn-warning {
            background-color: #555;
            border-color: #666;
        }
        .btn-warning:hover {
            background-color: #666;
        }
        a {
            color: #fff;
        }
        a:hover {
            color: #ccc;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="span3 well">
            <legend>Nuevo miembro? Sign up!</legend>
            <form accept-charset="UTF-8" action="newUserProcess.jsp" method="post">
                <input class="span3" name="username" placeholder="Username" type="text">
                <input class="span3" name="password" placeholder="Password" type="password"> 
                <button class="btn btn-warning" type="submit">Sign up</button>
                <p> </p>
                <p>Ya tienes Cuenta?</p>
                <a href="login.jsp">Regresar</a>
            </form>
        </div>
    </div>
</body>
</html>
