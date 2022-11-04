<?php
    session_start();
    if(isset($_REQUEST['chkout_btn'])){
        if(!isset($_SESSION['valid_user'])){
            echo '<script>alert("You must log in first to proceed!");</script>';
            echo '<script>window.location.replace("login.php");</script>';
            exit;
        }
        //echo gettype($_REQUEST['subtotal']);
        //echo gettype($_REQUEST['gst']);
        //echo $_REQUEST['subtotal'];
        //echo $_REQUEST['gst'];
        if(isset($_REQUEST['subtotal'])==false && isset($_REQUEST['total'])==false){
            echo '<script>alert("The cart is empty!");</script>';
            echo '<script>window.location.replace("cart.php");</script>';
        }
        if($_REQUEST['subtotal'] == 0 && $_REQUEST['total'] == 0) {
            echo '<script>alert("The cart is empty!");</script>';
            echo '<script>window.location.replace("cart.php");</script>';
        }
        $_SESSION['subtotal'] = $_REQUEST['subtotal'];
        $_SESSION['total'] = $_REQUEST['total'];
        $_SESSION['shipping'] = $_REQUEST['shipping'];
        $_SESSION['total_qty'] = $_REQUEST['total_qty'];
        $_SESSION['no_of_products'] = count($_SESSION['cart']);
        echo '<script>alert("Proceeding to Payment");</script>';
        echo '<script>window.location.replace("payment.php");</script>';
        exit;
    }
    if(isset($_REQUEST['update_qty'])){
        if(isset($_SESSION['cart'])){
            $cart_count = count($_SESSION['cart']);
            for ($i = 0; $i < $cart_count; $i++){
                $new_qty = $_REQUEST[$i.'_qty'];
                if($new_qty > 0){
                    $_SESSION['cart'][$i][3] = $new_qty;
                } else {
                    unset($_SESSION['cart'][$i]);
                }
            }
            $_SESSION['cart'] = array_values($_SESSION['cart']);
        }
    }
    // Debug (To be removed later)----------------------------------------------
    /*if(isset($_SESSION['cart'])){
        for($a = 0; $a < count($_SESSION['cart']); $a++){
            echo 'Item '.$a+1 .'\'quantity is: '.$_SESSION['cart'][$a][3];
        }
    }*/
    //---------------------------------------------------------------------------
?>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>FashionStore</title>
        <link rel="stylesheet" href="../css/general_style.css">
        <link rel="stylesheet" href="../css/cart.css">
    </head>
    <body>
        <div id="wrapper">
            <?php include "header.php"?>
            <div id="cart_body">
                <div id = "left_column">
                    <div id = "item_list">
                        <header style="padding: 0px 20px; background-color: rgb(42, 87, 154);"><h2>Your Cart</h2></header>
                        <div style="height: 300px; overflow-x: hidden; overflow-y: auto;">
                        <?php
                            if(!isset($_SESSION['cart'])){
                                ?>
                                <h3>There is no item in the cart.</h3>
                                <?php
                            } else {
                                if(count($_SESSION['cart']) == 0){
                                    ?>
                                    <h3>There is no item in the cart.</h3>
                                    <?php
                                } else {
                                ?>
                                <form action="cart.php" method="GET" id = "cart_from">
                                <table border="1" id = "item_table">
                                    <?php
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
                                        echo '<tr>';
                                        echo '<td>'.$name.'   Size: '.$size.'   Color: '.$color.'</td>';
                                        echo '<td rowspan = "2" style="width:100px;"><span class = "item_total_price"><input type="text" id="'.$i.'_price" value="'.$price*$qty.'" disabled></span></td>';
                                        //echo '<td rowspan = "2"><span id = "'.$name.'_price">$'.$qty * $price.'</span></td>';
                                        echo '</tr>';
                                        echo '<tr>';
                                        //echo '<input type="hidden" id = "'.$i.'" name = "'.$i.'" value = "'.$i.'">';
                                        echo '<td>Qty: <input type="number" min="0" id="'.$i.'_qty" name="'.$i.'_qty" value="'.$qty.'" onchange="update_price('.$price.',\''.$i.'_qty\',\''.$i.'_price\')"
                                                onkeydown = "return false;"></td>';
                                        echo '</tr>';
                                    }
                                    ?>
                                </table>
                                <input type="submit" id = "update_qty" name = "update_qty" hidden>
                                </form>
                                <?php
                            }}
                        ?>
                        </div>
                    </div>
                    <div id = "shipping_option">
                        <table id = "shipping_table">
                            <tr>
                                <th style="text-align: left;">
                                    <h2>Shipping Option</h2>
                                </th>
                            </tr>
                            <tr>
                                <td><input type="radio" class = "options" name="shipping" value="0.00" onclick="set_shippingFees()" checked>Standard Shipping</td>
                                <td>$0.00</td>
                            </tr>
                            <tr>
                                <td><input type="radio" class = "options" name="shipping" value="4.99" onclick="set_shippingFees()">Fast Delivery</td>
                                <td>$4.99</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div id = "right_column">
                    <form action="cart.php" method="POST" id = "checkout_form">
                        <table id = "balance_table">
                            <tr>
                                <th><strong>SUMMARY</strong></th>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0" id="subtotol_table">
                                        <tr>
                                            <td>Subtotal</td>
                                            <td>$<input type="text" id="subtotal" name = "subtotal" placeholder="$0" value="<?php 
                                            if(!isset($_SESSION['cart']) || count($_SESSION['cart']) == 0){
                                                echo "0.00";
                                            } else {
                                                echo number_format($subtotal, 2,'.',''); 
                                            }
                                            ?>" readonly></td>
                                            <!--<td><span id = "subtotal"><?php //echo "$".$subtotal; ?></span></td>-->
                                            <input type="hidden" name="total_qty" id="total_qty" value="<?php echo $total_qty; ?>">
                                        </tr>
                                        <tr>
                                            <td>GST 7%</td>
                                            <td>$<input type="text" id="gst" name = "gst" placeholder="$0" value="<?php 
                                            if(!isset($_SESSION['cart']) || count($_SESSION['cart']) == 0){
                                                echo "0.00";
                                            } else { $gst = $subtotal * 0.07;
                                                    echo number_format($gst, 2,'.','');
                                            }
                                            ?>" readonly></td>
                                            <!--<td><span id = "gst"><?php 
                                                    //$gst = $subtotal * 0.07;
                                                    //echo "$".$gst;
                                                ?></span></td>-->
                                        </tr>
                                        <tr>
                                            <td>Discount</td>
                                            <td>$<input type="text" id="discount" name = "discount" placeholder="0.00" value="0.00" readonly></td>
                                            <!--<td><span id="discount">$0.00</span></td>-->
                                        </tr>
                                        <tr>
                                            <td>Shipping</td>
                                            <td>$<input type="text" id="shipping_price" name = "shipping" placeholder="0.00" value="0.00" readonly></td>
                                            <!--<td><span id = "shipping_price"></span></td>-->
                                        </tr>
                                        <tr>
                                            <td style="padding-top: 50px;"><strong>TOTAL</strong></td>
                                            <td style="padding-top: 50px;">$<input type="text" id="total" name = "total" value="<?php 
                                            if(!isset($_SESSION['cart']) || count($_SESSION['cart']) == 0){
                                                echo "0.00";
                                            } else { $total_price = $subtotal + $gst;
                                                    echo number_format($total_price, 2,'.','');
                                            }
                                            ?>" readonly></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td><input type="submit" value="Proceed to Checkout" name="chkout_btn" id = "checkout" ></td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
            <div id="footer">
                <script src="../JS/footer.js"></script>
            </div>
        </div>
    </body>
</html>
<script>
    function update_price(price, qty, subtotal){
        var summarysubtotal_box = document.getElementById('subtotal');
        var total_price = document.getElementById('total');
        var old_summarysubtotal = summarysubtotal_box.value;
        //alert("old_summary subtotal: "+typeof(old_summarysubtotal));
        
        var single_price = price;
        var dom = document.getElementById(subtotal);
        var old_subtotal = dom.value;
        //alert("old_ subtotal: "+typeof(old_subtotal));
        var quantity = document.getElementById(qty).value;
        var updated_price = single_price * quantity;
        dom.setAttribute("value", updated_price);
        
        if(old_subtotal <= updated_price){
            var updated_summarySubTotal = Number(old_summarysubtotal) + (updated_price - Number(old_subtotal));
            var updated_gst = updated_summarySubTotal * 0.07;
            summarysubtotal_box.setAttribute("value", updated_summarySubTotal.toFixed(2));
            document.getElementById('gst').setAttribute("value", updated_gst.toFixed(2));
        } else {
            var updated_summarySubTotal = Number(old_summarysubtotal) - (Number(old_subtotal) - updated_price);
            var updated_gst = updated_summarySubTotal * 0.07;
            summarysubtotal_box.setAttribute("value", updated_summarySubTotal.toFixed(2));
            document.getElementById('gst').setAttribute("value", updated_gst.toFixed(2));
        }
        var updated_totalprice = updated_summarySubTotal + updated_gst;
        total_price.setAttribute("value", updated_totalprice.toFixed(2));

        document.getElementById('update_qty').click();
    }
    
    function set_shippingFees(){
        var dom = document.getElementsByName('shipping');
        var total_price = document.getElementById('total');
        var summary_shippingFees = document.getElementById('shipping_price');
        var shipping_fees = Number(summary_shippingFees.value);
        for(var i = 0; i < dom.length; i++){
            if(dom[i].checked){
                var new_shipping_fees = Number(dom[i].value);
                summary_shippingFees.value = new_shipping_fees.toFixed(2);
            }
        }
        if(shipping_fees <= new_shipping_fees){
            var updated_price = Number(total_price.value) + (new_shipping_fees - shipping_fees);
        } else {
            var updated_price = Number(total_price.value) - (shipping_fees - new_shipping_fees);
        }
        total_price.setAttribute("value", updated_price.toFixed(2));
    }
</script>