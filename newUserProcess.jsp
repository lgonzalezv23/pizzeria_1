<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.sqlite.JDBC");
        String dbPath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\pizzeria_1\\WEB-INF\\bd\\login.sqlite";
        conn = DriverManager.getConnection("jdbc:sqlite:" + dbPath);

        String sql = "INSERT INTO usuarios (username, password) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            // Redirección al login después de una inserción exitosa
            response.sendRedirect("login.jsp");
        } else {
            out.println("No se pudo crear el usuario.");
            // Opcionalmente, agregar un enlace para volver al formulario de registro
            out.println("<a href='newUser.jsp'>Volver al registro</a>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error al crear el usuario: " + e.getMessage());
        out.println("<a href='newUser.jsp'>Volver al registro</a>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
