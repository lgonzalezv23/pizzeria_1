<%@ page import="java.util.Base64" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ordenar Pizza</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #333;
            color: #ddd;
            padding: 20px;
            text-align: center;
        }
        h2 {
            color: #fff;
        }
        form {
            max-width: 500px;
            margin: 0 auto;
            text-align: left;
        }
        label {
            display: block;
            margin: 10px 0;
        }
        input[type="radio"], input[type="submit"] {
            margin-right: 10px;
        }
        input[type="submit"] {
            background-color: #555;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #666;
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
        a {
            color: #ddd;
            text-decoration: none;
        }
        img {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<%! // Declaración para definir el método dentro de la JSP
    public String blobToBase64(Blob blob) {
        String base64Image = "";
        try {
            if (blob != null) {
                byte[] bytes = blob.getBytes(1, (int) blob.length());
                base64Image = Base64.getEncoder().encodeToString(bytes);
            }
        } catch (SQLException e) {
            // Manejar el error adecuadamente
            e.printStackTrace();
        }
        return base64Image;
    }
%>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String dbURL = "jdbc:sqlite:C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/pizzeria_1/WEB-INF/bd/pizz.sqlite";

    try {
        // Cargar el driver de SQLite y establecer la conexión
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbURL);

        HttpSession session_s = request.getSession();
        String username = (session_s != null) ? (String) session.getAttribute("username") : "guest";
%>

<form action="agregar.jsp" method="post">
    <h2>Elige tu Pizza:</h2>
    <% 
    pstmt = conn.prepareStatement("SELECT id, nombre, ingredientes, imagen FROM pizzas");
    rs = pstmt.executeQuery();
    while(rs.next()) {
        byte[] imgBytes = rs.getBytes("imagen"); // Utiliza getBytes en lugar de getBlob
        String base64Image = Base64.getEncoder().encodeToString(imgBytes); // Codifica directamente los bytes a Base64
%>
        <label>
            <input type="radio" name="pizza_id" value="<%= rs.getInt("id") %>">
            <%= rs.getString("nombre") %> - <%= rs.getString("ingredientes") %>
            <% if (imgBytes != null) { %>
                <img src="data:image/png;base64,<%= base64Image %>" alt="Imagen de pizza" height="100" width="100">
            <% } %>
        </label><br>
    <% 
        }
        rs.close();
        pstmt.close();
    %>

   

    <h2>Elige el tamaño:</h2>
    <% 
        pstmt = conn.prepareStatement("SELECT * FROM tamanos");
        rs = pstmt.executeQuery();
        while(rs.next()) {
    %>
        <label>
            <input type="radio" name="tamano_id" value="<%= rs.getInt("id") %>">
            <%= rs.getString("nombre") %>
        </label><br>
    <% 
        }
        rs.close();
        pstmt.close();
    %>

    <h2>Elige el precio (según el tamaño):</h2>
    <%
        pstmt = conn.prepareStatement("SELECT * FROM precios");
        rs = pstmt.executeQuery();
        while(rs.next()) {
    %>
        <label>
            <input type="radio" name="precio_id" value="<%= rs.getInt("id") %>">
            $<%= rs.getInt("precio") %>
        </label><br>
    <%
        }
        rs.close();
        pstmt.close();
    %>

    <input type="hidden" name="username" value="<%= username %>">
    <input type="submit" value="Agregar al carrito">
</form>

<a href="carrito.jsp"><button type="button">Carrito</button></a>
<a href="index.jsp"><button type="button">Regresar al inicio</button></a>


<%
    } catch(Exception e) {
        out.println("Error al conectar con la base de datos: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

</body>
</html>
