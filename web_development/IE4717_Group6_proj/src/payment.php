<?php
    session_start();
    if(!isset($_SESSION['valid_user'])){
        echo '<script>alert("You must log in first to proceed!");</script>';
        echo '<script>window.location.replace("login.php");</script>';
        exit;
    }
    if(!isset($_SESSION['subtotal']) && !isset($_SESSION['total']) && !isset($_SESSION['cart'])){
        // in case user reaches to payment without adding any item to cart
        echo '<script>alert("Your cart is empty!");</script>';
        //echo $_SERVER['HTTP_REFERER'];
        echo '<script>window.location.replace("cart.php");</script>';
    }
    if($_SESSION['subtotal'] == 0 && $_SESSION['total'] == 0){
        // in case user reaches to payment without adding any item to cart
        echo '<script>alert("Your cart is empty!");</script>';
        //echo $_SERVER['HTTP_REFERER'];
        echo '<script>window.location.replace("cart.php");</script>';
    }

    //get contact information from database
    $username = $_SESSION['valid_user'];
    $postal = "";
    $address = "";
    $contact_no = "";
    include "dbconnect.php";
    $query = "select contact, address, postal from users where username = '$username'";
    $result = $dbcnx->query($query);
    $num_results = $result->num_rows;
    if($num_results == 0){
        echo "There was an error retrieving data from database!";
        echo '<script>window.location.replace("'.trim(str_replace("http://localhost:8000","",$_SERVER['HTTP_REFERER'])).'");</script>';
        exit;
    } else {
        $row = $result->fetch_assoc();
        $postal = $row['postal'];
        $address = $row['address'];
        $contact = $row['contact'];
        //echo '<script>alert("'.$postal.'");</script>';
        //echo '<script>alert("'.$address.'");</script>';
        //echo '<script>alert("'.$contact.'");</script>';
    }
    $dbcnx->close();
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionStore</title>
    <link rel="stylesheet" href="../css/general_style.css">
    <style>
    body {
        margin: 0px;
    }

    #payment_body {
        background-color: rgb(195, 195, 195);
        width: 70%;
        margin: auto;
        padding: 20px 20px;
        border-radius: 20px;
        min-width: 900px;
        display: block;
    }

    .card {
        border-radius: 5px;
    }

    #payment_table,
    #delivery_table,
    #billing_table {
        margin: 0px 15%;
    }

    #payment_table tr td {
        font-size: 20px;
        padding: 15px;
    }

    #payment_table tr th {
        text-align: left;
        font-size: 25px;
        padding: 15px;
        background-color: rgb(94, 38, 38);
        color: white;
    }

    #delivery_table tr th {
        text-align: left;
        font-size: 25px;
        padding: 15px;
        background-color: rgb(94, 38, 38);
        color: white;
    }

    #delivery_table tr td {
        font-size: 20px;
        padding: 15px;
    }

    #billing_table tr th {
        text-align: left;
        font-size: 25px;
        padding: 15px;
        background-color: rgb(94, 38, 38);
        color: white;
    }

    #billing_table tr td {
        font-size: 20px;
        padding: 15px;
    }

    .delivery {
        border-radius: 5px;
    }

    .billing {
        border-radius: 5px;
    }

    #submit_order {
        border-radius: 5px;
        width: 30%;
        height: auto;
        font-size: 20px;
        color: white;
        background-color: rgb(94, 38, 38);
        margin: 20px 35%;
    }

    input[type=text],
    textarea {
        font-size: large;
    }
    </style>
    <script type="text/javascript" src="../JS/payment_form_validator.js"></script>
</head>

<body onload="enable_listener()">
    <div id="wrapper">
        <?php include "header.php"?>
        <div id="payment_body">
            <form action="confirmOrder.php" method="POST" autocomplete="off" id="order_form">
                <div id="payment">
                    <table border="1" id="payment_table" style="border-collapse:collapse; width: 70%;">
                        <tr>
                            <th colspan="3">Payment Method</th>
                        </tr>
                        <tr>
                            <td rowspan="3" style="width: 40%;">
                                <input type="radio" name="payment_method" value="credit" checked
                                    onchange="payment(this)">Card/Debit Card<br><br><br>
                                <input type="radio" name="payment_method" value="cash" onchange="payment(this)">Cash on
                                Delivery
                            </td>
                            <td colspan="2">Card Number<br><input type="text" class="card" name="card_no" id="card_no"
                                    placeholder="1111222233334444" maxlength="16" style="width: 90%;"></td>
                        </tr>
                        <tr>
                            <td id="expiry_date">Expiry Date <br>
                                <!--<input type="number" name="expiry_month" class="card" id="expiry_month" placeholder="MM" min = "1" max = "12" style="width: 40px;" onkeydown="return false;">-->
                                <select name="expiry_month" name="expiry_month" class="card" id="expiry_month">
                                    <option value="0">1</option>
                                    <option value="1">2</option>
                                    <option value="2">3</option>
                                    <option value="3">4</option>
                                    <option value="4">5</option>
                                    <option value="5">6</option>
                                    <option value="6">7</option>
                                    <option value="7">8</option>
                                    <option value="8">9</option>
                                    <option value="9">10</option>
                                    <option value="10">11</option>
                                    <option value="11">12</option>
                                </select>
                                /
                                <!--<input type="number" name="expiry_year" class="card" id="expiry_year" placeholder="YYYY" style="width: 80px;">-->
                                <select name="expiry_year" class="card" id="expiry_year">
                                    <option value="<?php echo date("Y");?>"><?php echo date("Y");?></option>
                                    <option value="<?php echo date("Y")+1;?>"><?php echo date("Y")+1;?></option>
                                    <option value="<?php echo date("Y")+2;?>"><?php echo date("Y")+2;?></option>
                                    <option value="<?php echo date("Y")+3;?>"><?php echo date("Y")+3;?></option>
                                    <option value="<?php echo date("Y")+4;?>"><?php echo date("Y")+4;?></option>
                                </select>
                            </td>
                            <td>Security Code<br>
                                <input type="text" name="security_code" class="card" placeholder="XXX"
                                    id="security_code" style="width: 50px;" maxlength="3">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">Name on Card<br>
                                <input type="text" name="name_onCard" placeholder="John Smith" class="card"
                                    id="name_onCard" style="width: 90%;">
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="delivery_address">
                    <table border="1" id="delivery_table" style="border-collapse:collapse; width: 70%;">
                        <tr>
                            <th colspan="2">Delivery Address</th>
                        </tr>
                        <tr>
                            <td>First Name<br><input type="text" placeholder="John" class="delivery" name="first_name">
                            </td>
                            <td>Last Name<br><input type="text" placeholder="Smith" class="delivery" name="last_name">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">Postal Code<br><input type="text" placeholder="123456" maxlength="6"
                                    name="delivery_postal_code" class="delivery">&nbsp;&nbsp;&nbsp;
                                <!-- These hidden inputs are not to be used. They are to store values from php variables for JS use. -->
                                <input type="hidden" name="temp_postal" id="temp_postal" value="<?php echo $postal; ?>">
                                <input type="hidden" name="temp_address" id="temp_address"
                                    value="<?php echo $address; ?>">
                                <input type="hidden" name="temp_contact" id="temp_contact"
                                    value="<?php echo $contact; ?>">
                                <!-- -->
                                <label for="get_address_btn">Use Previous Address Details</label>
                                <input type="checkbox" name="get_address" class="delivery" id="get_address_btn"
                                    value="Use Previous Address Details" onchange="getAddress(this)">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">Address<br>
                                <textarea name="delivery_add" class="delivery" id="delivery_addID" rows="2"
                                    style="width: 50%; resize:none;" maxlength="60" wrap="hard" required></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">Contact Number<br>
                                +65 <input type="text" class="delivery" name="contact" placeholder="12345678"
                                    maxlength="8" id="contact"><br><br>
                                <input type="checkbox" name="set_billing_add" id="set_billing_add" value="checked"
                                    checked onchange="isBillingAddSame(this)"> Use Delivery Address as Billing Address
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="billing_address">
                    <table border="1" id="billing_table" style="border-collapse:collapse; width: 70%;" hidden>
                        <tr>
                            <th colspan="2">Billing Address</th>
                        </tr>
                        <tr>
                            <td colspan="2">Postal Code<br><input type="text" placeholder="123456" name="billing_postal"
                                    id="billing_postalID" class="billing" disabled></td>
                        </tr>
                        <tr>
                            <td colspan="2">Address<br><textarea name="billing_add" class="billing" id="billing_addID"
                                    rows="2" style="width: 50%;resize:none;" maxlength="60" wrap="hard"
                                    disabled></textarea></td>
                        </tr>
                    </table>
                </div>
                <input type="button" value="Submit Order" name="submit_order" id="submit_order" onclick="submit_form()">
            </form>
        </div>
        <div id="footer">
            <script src="../JS/footer.js"></script>
        </div>
    </div>
</body>

</html>
<script type="text/javascript" src="../JS/check_paymentform.js"></script>
<script>
function isBillingAddSame(chk_btn) {
    if (chk_btn.checked == true) {
        document.getElementById('billing_table').hidden = true;
        document.getElementsByClassName('billing')[0].setAttribute("disabled", true);
        document.getElementsByClassName('billing')[1].setAttribute("disabled", true);
    } else {
        document.getElementById('billing_table').hidden = false;
        document.getElementsByClassName('billing')[0].removeAttribute("disabled");
        document.getElementsByClassName('billing')[1].removeAttribute("disabled");
    }
    return true;
}

function payment(dom) {
    if (dom.value == "credit") {
        document.getElementById('card_no').removeAttribute("disabled");
        document.getElementById('expiry_month').removeAttribute("disabled");
        document.getElementById('expiry_year').removeAttribute("disabled");
        document.getElementById('security_code').removeAttribute("disabled");
        document.getElementById('name_onCard').removeAttribute("disabled");
        enable_listener();
    } else if (dom.value == "cash") {
        disable_card(true);
        disable_listener();
    }
}

function disable_card(value) {
    document.getElementById('card_no').setAttribute("disabled", value);
    document.getElementById('expiry_month').setAttribute("disabled", value);
    document.getElementById('expiry_year').setAttribute("disabled", value);
    document.getElementById('security_code').setAttribute("disabled", value);
    document.getElementById('name_onCard').setAttribute("disabled", value);

}

function enable_listener() {
    var expiry_date = document.getElementById('expiry_date');
    expiry_date.addEventListener("mouseleave", chk_expiry_date, false);
    
    var card_no = document.getElementById('card_no');
    card_no.addEventListener("change", chk_card_no ,false);

    var security_code = document.getElementById('security_code');
    security_code.addEventListener("change", chk_security_code ,false);

    var card_name = document.getElementById('name_onCard');
    card_name.addEventListener("change", chk_name_onCard ,false);
}

function disable_listener() {
    var expiry_date = document.getElementById('expiry_date');
    expiry_date.removeEventListener("mouseleave", chk_expiry_date, false);
    flag1 = true;
    
    var card_no = document.getElementById('card_no');
    card_no.removeEventListener("change", chk_card_no ,false);
    flag2 = true;

    var security_code = document.getElementById('security_code');
    security_code.removeEventListener("change", chk_security_code ,false);
    flag3 = true;

    var card_name = document.getElementById('name_onCard');
    card_name.removeEventListener("change", chk_name_onCard ,false);
    flag4 = true;

}

function getAddress(dom) {
    var delivery_postal = document.getElementsByClassName('delivery')[2];
    var delivery_address = document.getElementsByClassName('delivery')[4];
    var delivery_contact = document.getElementsByClassName('delivery')[5];

    var billing_postal = document.getElementsByClassName('billing')[0];
    var billing_address = document.getElementsByClassName('billing')[1];
    if (dom.checked == true) {
        delivery_address.value = document.getElementById('temp_address').value;
        delivery_postal.value = document.getElementById('temp_postal').value;
        delivery_contact.value = document.getElementById('temp_contact').value;

        billing_address.value = document.getElementById('temp_address').value;
        billing_postal.value = document.getElementById('temp_postal').value;
    } else {
        delivery_address.value = "";
        delivery_postal.value = "";
        delivery_contact.value = "";

        billing_address.value = "";
        billing_postal.value = "";
        flag1 = flag2 = flag3 = flag4 = true;
    }
}

function submit_form() {
    var form = document.getElementById('order_form');
    var payment_method = document.getElementsByName('payment_method');
    
    if (flag1 && flag2 && flag3 && flag4 && flag5 && flag6 && flag7 && flag8) {
        form.submit();
    } else {
        alert("Please check your input(s)!");
    }
}
</script>