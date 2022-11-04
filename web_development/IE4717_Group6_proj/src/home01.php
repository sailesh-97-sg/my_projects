<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionStore</title>
    <link rel="stylesheet" href="../css/home01.css">
    <link rel="stylesheet" href="../css/general_style.css">

</head>

<body>
    <?php 
    include "dbconnect.php";
    $query = "select * from products order by rand() limit 5";
    $result = $dbcnx->query($query);
    $num_results = $result->num_rows;
    ?>
    <div id="wrapper">
        <?php include "header.php"?>
        <div id="content">
            <div class="introductionbackground">
                <div class="introductioncard">
                    <h2>FashionStore</h2>
                    <p>Tired of always having to track what the latest goods released by famous fashion stores are? Our
                        company automatically filters this information to you and only presents the latest goods on the
                        market in our site, thus there are always new goods every day!</p>
                </div>
            </div>
            <div class="randomproductdisplay">
                <div class="productsbox">

                    <?php 
                for($i=0;$i<$num_results;$i++) {
                    $row = $result->fetch_assoc();
                    echo "<div class = \"productitems\">";
                        echo "<form action = \"item.php\" method=\"POST\">";
                        echo "<input type=\"image\"  src=\"".$row['productimage']."\" alt=\"\" height=\"150\" width=\"130\">";
                        echo "<p><strong>".$row['productname']."</strong></p>";
                        echo "<input type=\"hidden\" name=\"productname\" value = \"".$row['productname']."\">";
                        echo "<input type=\"hidden\" name=\"productprice\" value = \"".$row['productprice']."\">";
                        echo "<p><em>$".$row['productprice']."</em></p>";
                        //use the below lines if you want to visually see the data inside the cart
                        // echo $_SESSION['cart'][2][1];
                        // echo '<pre>';
                        // var_dump($_SESSION['cart']);
                        // echo '</pre>';
                        echo "</form>";
                        echo "</div>";                    
                }
                ?>
                </div>

            </div>
        </div>
        <div id="footer">
            <script src="../JS/footer.js"></script>
        </div>
    </div>
</body>

</html>