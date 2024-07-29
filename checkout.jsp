<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Proceder al Pago</title>
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
        form {
            margin: 0 auto;
            max-width: 500px;
            text-align: left;
        }
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            background-color: #555;
            border: 1px solid #777;
            color: #fff;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #555;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #666;
        }
        input::placeholder {
            color: #ccc;
        }
    </style>
</head>
<body>

    <h1>Resumen del Pedido</h1>
    <!-- Aquí incluyes el código para mostrar el resumen del pedido -->

    <form action="procesarDatos.jsp" method="post">
        <h2>Dirección de Envío</h2>
        <!-- Campos para la dirección de envío -->
        <input type="text" name="nombre" placeholder="Nombre Completo" required>
        <input type="text" name="direccion" placeholder="Dirección" required>
        
        <h2>Método de Pago</h2>
        <!-- Campos para el método de pago -->
        <select name="metodoPago">
            <option value="tarjetaCredito">Tarjeta de Crédito</option>
            <option value="paypal">PayPal</option>
            <!-- Añadir más opciones según sea necesario -->
        </select>

        <input type="submit" value="Confirmar Pedido y Procesar Pago">
    </form>

</body>
</html>
