<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Carrito de Compras</title>
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
        a {
            color: #f00;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        button {
            background-color: #555;
            color: #fff;
            border: none;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
        }
        button:hover {
            background-color: #666;
        }
    </style>
</head>
<body>

<h1>Tu Carrito de Compras</h1>

<%
    String dbURL = "jdbc:sqlite:C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/pizzeria_1/WEB-INF/bd/pizz.sqlite";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    HttpSession miSesion = request.getSession(false);
    int total = 0;

    try {
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbURL);
        String name = (miSesion != null) ? (String) miSesion.getAttribute("username") : "guest";

        String sql = "SELECT p.id AS pedido_id, pz.nombre AS pizza_nombre, t.nombre AS tamano_nombre, pr.precio " +
                     "FROM pedidos p " +
                     "JOIN pizzas pz ON p.pizza_id = pz.id " +
                     "JOIN tamanos t ON p.tamano_id = t.id " +
                     "JOIN precios pr ON p.precio_id = pr.id " +
                     "WHERE p.usuario = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        rs = pstmt.executeQuery();
%>
        <table>
            <tr>
                <th>Pedido ID</th>
                <th>Nombre de Pizza</th>
                <th>Tamaño</th>
                <th>Precio</th>
                <th>Eliminar</th>
            </tr>
<%
        while (rs.next()) {
            int pedidoId = rs.getInt("pedido_id");
            String pizzaNombre = rs.getString("pizza_nombre");
            String tamanoNombre = rs.getString("tamano_nombre");
            int precio = rs.getInt("precio");
            total += precio;
%>
            <tr>
                <td><%= pedidoId %></td>
                <td><%= pizzaNombre %></td>
                <td><%= tamanoNombre %></td>
                <td>$<%= precio %></td>
                <td><a href="eliminar.jsp?pedidoId=<%= pedidoId %>">Eliminar</a></td>
            </tr>
<%
        }
%>
        </table>
<p>Total: $<%= total %></p>

<%
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>

<a href="ordenar.jsp"><button type="button">Seguir Comprando</button></a>
<a href="checkout.jsp"><button type="button">Proceder al Pago</button></a>

</body>
</html>
