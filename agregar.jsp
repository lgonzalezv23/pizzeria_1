<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Procesando Pedido</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #333;
            color: #ddd;
            padding: 20px;
            text-align: center;
        }
        div {
            margin-top: 20px;
        }
        button {
            background-color: #555;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }
        button:hover {
            background-color: #666;
        }
        a {
            text-decoration: none;
        }
    </style>
</head>
<body>

<%
    // Configuración de la conexión a la base de datos
    String dbURL = "jdbc:sqlite:C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/pizzeria_1/WEB-INF/bd/pizz.sqlite";
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        // Carga del driver de SQLite y establecimiento de la conexión
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection(dbURL);

        // Obtención de los parámetros del formulario
        String usuario = request.getParameter("username");
        int pizzaId = Integer.parseInt(request.getParameter("pizza_id"));
        int tamanoId = Integer.parseInt(request.getParameter("tamano_id"));
        int precioId = Integer.parseInt(request.getParameter("precio_id"));

        // Preparación de la sentencia SQL para insertar el pedido
        String sqlInsert = "INSERT INTO pedidos (usuario, pizza_id, tamano_id, precio_id, fecha_pedido) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        pstmt = conn.prepareStatement(sqlInsert);
        pstmt.setString(1, usuario);
        pstmt.setInt(2, pizzaId);
        pstmt.setInt(3, tamanoId);
        pstmt.setInt(4, precioId);
        
        // Ejecución de la inserción
        int resultado = pstmt.executeUpdate();
        
        // Comprobación del resultado de la inserción
        if (resultado > 0) {
            out.println("<p>Pedido agregado con éxito.</p>");
            
        } else {
            out.println("<p>No se pudo agregar el pedido.</p>");
        }
    } catch (SQLException e) {
        out.println("<p>Error de SQL: " + e.getMessage() + "</p>");
    } catch (ClassNotFoundException e) {
        out.println("<p>No se encontró el controlador de SQLite: " + e.getMessage() + "</p>");
    } finally {
        // Cierre de los recursos de JDBC
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException ex) {
            out.println("<p>Error al cerrar pstmt: " + ex.getMessage() + "</p>");
            }
            }
            if (conn != null) {
            try { conn.close(); } catch (SQLException ex) {
            out.println("<p>Error al cerrar conn: " + ex.getMessage() + "</p>");
            }
            }
            }
            %>
            <div>
                <a href="ordenar.jsp"><button type="button">Seguir Comprando</button></a>
                <a href="carrito.jsp"><button type="button">Carrito</button></a>
            </div>
            </body>
            </html>
