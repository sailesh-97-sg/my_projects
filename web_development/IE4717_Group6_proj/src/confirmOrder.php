<?php
    session_start();

    if(!isset($_SESSION['valid_user'])){
        echo '<script>alert("You are not logged in!");</script>';
        echo '<script>window.location.replace("login.php");</script>';
        exit;
    }

    if(!isset($_SESSION['cart'])){
        echo '<script>alert("Your cart is empty!");</script>';
        echo '<script>window.location.replace("products.php");</script>';
        exit;
    } else {
        if(empty($_SESSION['cart'])){
            echo '<script>alert("Your cart is empty!");</script>';
            echo '<script>window.location.replace("products.php");</script>';
            exit;
        }
    }

    // setting variables
    $username = $_SESSION['valid_user'];
    //$isBillingSame = $_REQUEST['set_billing_add'];
    $deli_address = $_REQUEST['delivery_add'];
    $deli_postal = $_REQUEST['delivery_postal_code'];
    $contact = $_REQUEST['contact'];
    //if($isBillingSame == "checked"){
    if(isset($_REQUEST['set_billing_add'])){
        $bill_address = $deli_address;
        $bill_postal = $deli_postal;
    } else {
        $bill_address = $_REQUEST['billing_add'];
        $bill_postal = $_REQUEST['billing_postal'];
    }

    if($_SESSION['shipping'] == 0.00){
        $shipping = "standard";
    } else {
        $shipping = "fast";
    }
    $total_qty = $_SESSION['total_qty'];
    $total_price = $_SESSION['total'];
    $products = $_SESSION['no_of_products'];

    // save to db
    include "dbconnect.php";
    $query = "insert into orders(username, total_qty, total_price, products, shipping, deli_address, deli_postal, deli_contact, bill_address, bill_postal) values (?,?,?,?,?,?,?,?,?,?)";
    $stmt = $dbcnx->prepare($query);
    $stmt->bind_param('sidissssss', $username, $total_qty, $total_price, $products, $shipping, $deli_address, $deli_postal, $contact, $bill_address, $bill_postal);
    $stmt->execute();

    if(!$stmt){
        echo "An error has occured while updating orders";
    }

    $query = "update users set contact = '$contact', address = '$deli_address', postal = '$deli_postal' where username = '$username'";
    $result = $dbcnx->query($query);
    //$num_rows = $result->num_rows;

    if($dbcnx->errno){
        echo "Could not update user's table: ".$dbcnx->error;
        $dbcnx->close();
        exit;
    }
    
    $useremail = "";
    $query = "select email from users where username = '$username'";
    $result = $dbcnx->query($query);
    $num_rows = $result->num_rows;

    if($num_rows == 0){
        echo "An error has occured while getting user's email";
        $dbcnx->close();
        exit;
    } else {
        $row = $result->fetch_assoc();
        $useremail = $row['email'];
    }
    $dbcnx->close();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/order_confirmation.css">
    <link rel="stylesheet" href="../css/general_style.css">
    <title>Document</title>
</head>

<body>
    <div class="confirmation_body">
        <div id="confirmationtexts">
            <h2>Order Confirmation</h2>
            <h4>Thank you for your purchase</h4>
            <p>Email confirmation will be sent to you shortly</p>
            <a href="products.php">
                <button>Continue Shopping</button>
            </a>

        </div>
    </div>

</body>

</html>

<!-- email code can be put here. -->
<?php 
$to = $useremail;
$subject = 'Receipt - FashionStore Purchase of Goods';
$message = 'Thank you for purchasing from FashionStore!'."\r\n".'Your order has been confirmed and will be ready for delivery shortly.'."\r\n"."Please confirm your order details below: "."\r\n\r\n";
$count = count($_SESSION['cart']);
$total_qty = 0;
$subtotal = 0;
for($i = 0; $i < $count; $i++){
    $name = $_SESSION['cart'][$i][0];
    $price = $_SESSION['cart'][$i][1];
    $color = $_SESSION['cart'][$i][2];
    $qty = $_SESSION['cart'][$i][3];
    $size = $_SESSION['cart'][$i][4];
    $total_qty = $total_qty + $qty;
    $subtotal = $subtotal + ($price * $qty);
    // $message = $message.$name."\r\n"."$".$price."\r\n"."Color: ".$color."\r\n"."Quantity: ".$qty."\r\n"."Size: ".$size;
    $message = $message.$name." "." x".$qty."\r\n"."Size: ".$size."\r\n"."Color: ".$color."\r\n\r\n";
}
$message = $message."\r\n"."Total Cost: $".$_SESSION['total'];
$headers = 'From: purchase@fashionstore' . "\r\n" .
'Reply-To: '.$useremail.'' . "\r\n" .
'X-Mailer: PHP/' . phpversion();
mail($to, $subject, $message, $headers,
'-'.$useremail.'');
echo ("mail sent to : ".$to);

?>

<?php
    unset($_SESSION['cart']);
    unset($_SESSION['total_qty']);
    unset($_SESSION['total']);
    unset($_SESSION['no_of_products']);
    unset($_SESSION['subtotal']);
    unset($_SESSION['shipping']);
?>