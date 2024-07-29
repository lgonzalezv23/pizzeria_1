<%@ page import="java.sql.*, javax.servlet.http.*, java.io.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection("jdbc:sqlite:C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\pizzeria_1\\WEB-INF\\bd\\login.sqlite");

        String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            HttpSession userSession = request.getSession();
            userSession.setAttribute("username", username);
            userSession.setAttribute("loginTime", System.currentTimeMillis());

            // Redirigir a la página principal del usuario
            response.sendRedirect("index.jsp");
        } else {
            // Usuario o contraseña incorrecta. Redirigir a login.jsp con un mensaje de error.
            response.sendRedirect("login.jsp?error=invalid");
        }
    } catch (ClassNotFoundException cnfe) {
        cnfe.printStackTrace();
    } catch (SQLException sqle) {
        sqle.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
%>
