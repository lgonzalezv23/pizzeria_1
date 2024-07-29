<%@ page import="javax.servlet.http.*, java.io.*, java.util.concurrent.TimeUnit, java.util.*" %>
<%
    // Obtener la sesión actual
    HttpSession userSession = request.getSession(false);

    // Verificar si hay una sesión
    if (userSession != null) {
        // Obtener el tiempo de inicio de sesión y el tiempo actual
        long loginTime = (Long) userSession.getAttribute("loginTime");
        long currentTime = System.currentTimeMillis();

        // Calcular la duración de la sesión en milisegundos
        long sessionDurationMillis = currentTime - loginTime;

        // Invalidar la sesión
        userSession.invalidate();

        // Calcular minutos y segundos transcurridos
        long elapsedMinutes = TimeUnit.MILLISECONDS.toMinutes(sessionDurationMillis);
        long elapsedSeconds = TimeUnit.MILLISECONDS.toSeconds(sessionDurationMillis) -
                              TimeUnit.MINUTES.toSeconds(elapsedMinutes);

        // Mostrar el mensaje emergente en el navegador usando JavaScript
%>
        <script>
            alert("¡Hasta luego! Has estado logeado durante <%= elapsedMinutes %> minutos y <%= elapsedSeconds %> segundos.");
            // Redirigir al formulario de inicio de sesión después de mostrar el mensaje
            window.location.href = 'login.jsp';
        </script>
<%
    } else {
        // Si no hay sesión activa, mostrar un mensaje o redirigir según tus necesidades
        response.getWriter().println("No hay sesión activa.");
    }
%>
