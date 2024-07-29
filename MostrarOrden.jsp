<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Resumen de tu Orden</title>
</head>
<body>

<h1>Resumen de tu Orden</h1>

<%
    // Obtener los parámetros del formulario
    String username = request.getParameter("username");
    int pizzaId = Integer.parseInt(request.getParameter("pizza_id"));
    int tamanoId = Integer.parseInt(request.getParameter("tamano_id"));
    int precioId = Integer.parseInt(request.getParameter("precio_id"));

    // Aquí simplemente mostramos la información que sería insertada
    out.println("<p>Usuario: " + username + "</p>");
    out.println("<p>ID de Pizza: " + pizzaId + "</p>");
    out.println("<p>ID de Tamaño: " + tamanoId + "</p>");
    out.println("<p>ID de Precio: " + precioId + "</p>");
%>

</body>
</html>
