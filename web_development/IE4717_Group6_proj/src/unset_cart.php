<?php
    session_start();
    unset($_SESSION['cart']);
    unset($_SESSION['subtotal']);
    unset($_SESSION['total']);
    session_destroy();
?>