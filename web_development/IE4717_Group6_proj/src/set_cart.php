<?php
    session_start();
    $_SESSION['cart'] = array();
    $_SESSION['cart'][0] = array('Item1',2.00,'red',5,'L');
    $_SESSION['cart'][1] = array('Item2',3.00,'blue',3,'S');
    $_SESSION['cart'][2] = array('Jean',12.00,'navy',7,'M');
    /*$array = array();
    $array[0] = array('A',2,'blue');
    $array[1] = array('B',1,'red');
    $array[2] = array('A',3,'black');
    var_dump($array);
    unset($array[1]);
    var_dump($array);
    $array = array_values($array);
    var_dump($array);*/
?>