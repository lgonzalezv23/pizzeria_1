<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Historial de Compras</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #333;
            color: #ddd;
            text-align: center;
        }
        h1 {
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
        tr:hover {
            background-color: #555;
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

<h1>Historial de Compras</h1>

<%
    String finalUser = (session != null) ? (String) session.getAttribute("username") : "guest";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int total = 0;

    try {
        String dbURL = "jdbc:sqlite:C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/pizzeria_1/WEB-INF/bd/pizz.sqlite";
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbURL);

        String sql = "SELECT pf.id AS pedido_id, pz.nombre AS pizza_nombre, t.nombre AS tamano_nombre, pr.precio " +
                     "FROM pedidosFinales pf " +
                     "JOIN pizzas pz ON pf.pizza_id = pz.id " +
                     "JOIN tamanos t ON pf.tamano_id = t.id " +
                     "JOIN precios pr ON pf.precio_id = pr.id " +
                     "WHERE pf.usuario = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, finalUser);
        rs = pstmt.executeQuery();

        out.println("<table border='1'>");
        out.println("<tr><th>Pedido ID</th><th>Nombre de Pizza</th><th>Tamaño</th><th>Precio</th></tr>");
        
        while (rs.next()) {
            int pedidoId = rs.getInt("pedido_id");
            String pizzaNombre = rs.getString("pizza_nombre");
            String tamanoNombre = rs.getString("tamano_nombre");
            int precio = rs.getInt("precio");
            total += precio;

            out.println("<tr>");
            out.println("<td>" + pedidoId + "</td>");
            out.println("<td>" + pizzaNombre + "</td>");
            out.println("<td>" + tamanoNombre + "</td>");
            out.println("<td>$" + precio + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        out.println("<p>Total gastado: $" + total + "</p>");

    } catch (Exception e) {
        out.println("<p>Error al recuperar el historial de compras: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>

<!-- Botón que dirige al usuario a la página principal 'index.jsp' -->
<form action="index.jsp" method="get">
    <input type="submit" value="Volver al Inicio" />
</form>

</body>
</html>
    