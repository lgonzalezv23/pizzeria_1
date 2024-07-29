<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="error.jsp" %>
<html>
<head>
    <title>Procesamiento de Pedido Finalizado</title>
</head>
<body>

<%
    HttpSession miSesion = request.getSession(false);
    String usuario = (miSesion != null) ? (String) miSesion.getAttribute("username") : "guest";
    Connection conn = null;
    PreparedStatement pstmtInsert = null;
    PreparedStatement pstmtDelete = null;

    try {
        // Conexión a la base de datos
        String dbURL = "jdbc:sqlite:C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/pizzeria_1/WEB-INF/bd/pizz.sqlite";
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbURL);
        conn.setAutoCommit(false); // Usar transacciones

        // Transferir los datos de 'pedidos' a 'pedidosFinales'
        String sqlInsert = "INSERT INTO pedidosFinales (usuario, pizza_id, tamano_id, precio_id, fecha_pedido) " +
                           "SELECT usuario, pizza_id, tamano_id, precio_id, CURRENT_TIMESTAMP FROM pedidos WHERE usuario = ?";
        pstmtInsert = conn.prepareStatement(sqlInsert);
        pstmtInsert.setString(1, usuario);
        int insertedRows = pstmtInsert.executeUpdate();

        // Si se transfieren los datos correctamente, vaciar la tabla 'pedidos'
        if (insertedRows > 0) {
            String sqlDelete = "DELETE FROM pedidos WHERE usuario = ?";
            pstmtDelete = conn.prepareStatement(sqlDelete);
            pstmtDelete.setString(1, usuario);
            pstmtDelete.executeUpdate();
            conn.commit(); // Commit de la transacción
        }

        // Redirigir al usuario a una página de confirmación o historial
        response.sendRedirect("gracias.jsp");

    } catch (Exception e) {
        if (conn != null) try { conn.rollback(); } catch (SQLException ex) { } // Revertir en caso de error
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (pstmtInsert != null) try { pstmtInsert.close(); } catch (SQLException e) { }
        if (pstmtDelete != null) try { pstmtDelete.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>

</body>
</html>
