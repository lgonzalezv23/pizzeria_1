<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Eliminar Pedido</title>
</head>
<body>

<%
    String dbURL = "jdbc:sqlite:C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/pizzeria_1/WEB-INF/bd/pizz.sqlite";
    Connection conn = null;
    PreparedStatement pstmt = null;
    HttpSession miSesion = request.getSession(false);

    try {
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbURL);

        // Obtener el pedidoId de la solicitud
        int pedidoId = Integer.parseInt(request.getParameter("pedidoId"));

        // Verificar que el pedido pertenezca al usuario actual antes de eliminarlo
        String usuario = (miSesion != null) ? (String) miSesion.getAttribute("username") : "guest";
        String sql = "DELETE FROM pedidos WHERE id = ? AND usuario = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, pedidoId);
        pstmt.setString(2, usuario);
        int rowsAffected = pstmt.executeUpdate();

        // Redireccionar de vuelta al carrito
        response.sendRedirect("carrito.jsp");
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>

</body>
</html>
