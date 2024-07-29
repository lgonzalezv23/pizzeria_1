<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Confirmación de Pedido y Pago</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #333;
            color: #ddd;
            padding: 20px;
            text-align: center;
        }
        h1, h2 {
            color: #fff;
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }
        th, td {
            padding: 10px;
            border: 1px solid #555;
            text-align: left;
        }
        th {
            background-color: #555;
        }
        tr:nth-child(even) {
            background-color: #444;
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

<h1>Confirmación</h1>

<%
    // Recoger los datos del formulario
    String nombre = request.getParameter("nombre");
    String direccion = request.getParameter("direccion");
    String metodoPago = request.getParameter("metodoPago");

    // Imprimir los datos del formulario
    out.println("<h2>Detalles del Envío y Pago</h2>");
    out.println("<p>Nombre: " + nombre + "</p>");
    out.println("<p>Dirección: " + direccion + "</p>");
    out.println("<p>Método de Pago: " + metodoPago + "</p>");

    // Inicio de la conexión a la base de datos
    String dbURL = "jdbc:sqlite:C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/pizzeria_1/WEB-INF/bd/pizz.sqlite";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int total = 0;

    try {
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbURL);

        // Suponiendo que el nombre de usuario se pasa a través de la sesión
        HttpSession miSesion = request.getSession(false);
        String name = (miSesion != null) ? (String) miSesion.getAttribute("username") : "guest";

        // Consulta SQL para obtener los detalles del pedido
        String sql = "SELECT p.id AS pedido_id, pz.nombre AS pizza_nombre, t.nombre AS tamano_nombre, pr.precio " +
                     "FROM pedidos p " +
                     "JOIN pizzas pz ON p.pizza_id = pz.id " +
                     "JOIN tamanos t ON p.tamano_id = t.id " +
                     "JOIN precios pr ON p.precio_id = pr.id " +
                     "WHERE p.usuario = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        rs = pstmt.executeQuery();

        // Imprimir los detalles del pedido
        out.println("<h2>Detalle del Pedido</h2>");
        out.println("<table>");
        out.println("<tr><th>Pedido ID</th><th>Nombre de Pizza</th><th>Tamaño</th><th>Precio</th></tr>");
        while (rs.next()) {
            int pedidoId = rs.getInt("pedido_id");
            String pizzaNombre = rs.getString("pizza_nombre");
            String tamanoNombre = rs.getString("tamano_nombre");
            int precio = rs.getInt("precio");
            total += precio;
            out.println("<tr><td>" + pedidoId + "</td><td>" + pizzaNombre + "</td><td>" + tamanoNombre + "</td><td>$" + precio + "</td></tr>");
        }
        out.println("</table>");
        out.println("<p>Total: $" + total + "</p>");
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>


<form action="procesarPedidoFinal.jsp" method="post">
    <input type="submit" value="OK" />
</form>

</body>
</html>
