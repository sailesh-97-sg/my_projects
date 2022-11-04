<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/item.css">
    <link rel="stylesheet" href="../css/general_style.css">
    <title>Items Page</title>
</head>


<?php 
session_start();
if (!isset($_SESSION['cart'])) {
    $_SESSION['cart'] = array();
}

$productname = $_POST['productname'];
$productprice = $_POST['productprice'];

include "dbconnect.php"; // connect to database

$query = "select * from products where productname=\"".$productname."\" and productprice = \"".$productprice."\"";


$result = $dbcnx->query($query);

$num_results = $result->num_rows;
$row = $result->fetch_assoc();
?>

<body>
    <div id="wrapper">
        <?php include "header.php";?>
    </div>
    <form action="products.php" method="post">
        <div class="products_body">
            <div class="itemspage">
                <div class="productimage">
                    <img src="<?php echo $row['productimage']?>" alt="" height="300px" width="200px">
                    <p><strong><?php echo "".$row['productname'].""?></strong></p>
                    <p><strong><?php echo "$".$row['productprice'].""?></strong></p>


                </div>
                <div class="productdescription">
                    <p><strong><?php ?></strong></p>
                    <p><?php echo($row['productdescription']);?></p>
                    <div class="productsizes">
                        <p>Sizes: </p>
                        <input type="radio" name="itemsize" value="small" id="small" required checked>
                        <label for="small">Small</label>
                        <input type="radio" name="itemsize" value="medium" id="medium">
                        <label for="medium">Medium</label>
                        <input type="radio" name="itemsize" value="large" id="large">
                        <label for="large">Large</label>
                        <input type="radio" name="itemsize" value="extralarge" id="extralarge">
                        <label for="extralarge">Extra Large</label>
                    </div>

                    <div class="coloroption">
                        <p>Color Option:</p>
                        <select name="itemcolor" id="color" required>
                            <option value="red" style="background-color: red; color: white;">Red</option>
                            <option value="blue" style="background-color: blue; color: white">Blue</option>
                            <option value="green" style="background-color: green; color: white">Green</option>
                            <option value="yellow" style="background-color: yellow; color: black">Yellow</option>
                        </select>
                    </div>

                </div>
                <div class="productaddtocart">
                    <div class="quantity">
                        <p>Qty: </p>
                        <input type="number" min=1 max=10 name="itemquantity" style="text-align: center;" required>
                    </div>
                    <div class="addtocart">
                        <input type="submit" name="submit" id="submit" value="Add to Cart">

                    </div>
                    <div class="questionsredirect">
                        <p><strong>Have a question?</strong></p>
                        <p>Check our policy <a href="www.google.com">here</a>.</p>
                    </div>

                </div>
            </div>

        </div>
        <?php 
            echo "<input type=\"hidden\" name=\"itemname\" value=\"".$row['productname']."\">";
            echo "<input type=\"hidden\" name=\"itemprice\" value=\"".$row['productprice']."\">";
            ?>
    </form>
    <div id="footer">
        <script src="../JS/footer.js"></script>
    </div>

    </div>


</body>

</html>