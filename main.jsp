<%@ page import="javax.servlet.http.*, java.io.*, java.util.concurrent.TimeUnit, java.util.*" %>
<html>
<head>
    <title>Main Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        body {
            background-color: #333;
            color: #ddd;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .jumbotron {
            background-color: #444;
            color: #fff;
        }
        .btn-primary {
            background-color: #555;
            border-color: #666;
        }
        .btn-primary:hover {
            background-color: #666;
            border-color: #777;
        }
    </style>
</head>
<body>

<%
    // Obtener el nombre de usuario de la sesión
    HttpSession userSession = request.getSession(false);
    String username = (userSession != null) ? (String) userSession.getAttribute("username") : null;

    // Verificar si el usuario está autenticado
    if (username != null && !username.isEmpty()) {
        // Obtener el tiempo actual y el tiempo de inicio de la sesión
        long currentTime = new Date().getTime();
        long sessionStartTime = userSession.getCreationTime();

        // Calcular la duración de la sesión en milisegundos
        long sessionDurationMillis = currentTime - sessionStartTime;

        // Calcular minutos y segundos transcurridos
        long elapsedMinutes = TimeUnit.MILLISECONDS.toMinutes(sessionDurationMillis);
        long elapsedSeconds = TimeUnit.MILLISECONDS.toSeconds(sessionDurationMillis) -
                              TimeUnit.MINUTES.toSeconds(elapsedMinutes);
%>
    <div class="container mt-3">
        <div class="jumbotron">
            <h1 class="display-4">Bienvenido, <%= username %>!</h1>
            <p class="lead">Este es un banner de bienvenida para el usuario <%= username %> en la pagina principal.</p>
            <hr class="my-4">
            <p>Nos da gusto que estes usando nuestra pagina</p>
            <p>Tiempo transcurrido de la sesion: <%= elapsedMinutes %> minutos y <%= elapsedSeconds %> segundos</p>
            <button class="btn btn-primary btn-lg" onclick="logout()">Salir</button>
            <button class="btn btn-primary btn-lg" onclick="returnTo()">Regresar</button>
            <button class="btn btn-primary btn-lg" onclick="history()">Historial de compras</button>
        </div>
    </div>

    <script>
        function logout() {
            // Redirigir a la página de logout
            window.location.href = 'logout.jsp';
        }
    </script>

<script>
    function history() {
        // Redirigir a la página de logout
        window.location.href = 'Final.jsp';
    }
</script>

<script>
    function returnTo() {
        // Redirigir a la página principal
        window.location.href = 'index.jsp';
    }
</script>
<%
    } else {
        // Si no hay sesión válida, redirigir al formulario de inicio de sesión
        response.sendRedirect("login.jsp");
    }
%>

</body>
</html>
