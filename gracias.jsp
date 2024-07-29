<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Agradecimiento</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #333;
            color: #ddd;
            padding: 20px;
            text-align: center;
        }
        h1 {
            color: #fff;
        }
        p {
            color: #ccc;
        }
        form {
            margin-top: 20px;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #555;
            border: none;
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #666;
        }
    </style>
</head>
<body>

    <h1>¡Gracias por su visita!</h1>
    <p>Esperamos que haya disfrutado de su experiencia en nuestra pizzería.</p>

    <!-- Botón que dirige al usuario a la página principal 'index.jsp' -->
    <form action="index.jsp" method="get">
        <input type="submit" value="Volver al Inicio" />
    </form>

    <!-- Botón que dirige al usuario a la página 'Final.jsp' -->
    <form action="Final.jsp" method="get">
        <input type="submit" value="Ver Historial de Compras" />
    </form>

</body>
</html>
