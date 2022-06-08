<?php
    $usuario  = "Franco";
    $password = "11Ww222Ee";
    $servidor = "172.31.91.254";
    $basededatos = "Franco_db";
    $con = mysqli_connect($servidor, $usuario, $password) or die("No se ha podido conectar al Servidor");
    $db = mysqli_select_db($con, $basededatos) or die("Upps! Error en conectar a la Base de Datos");
?>

