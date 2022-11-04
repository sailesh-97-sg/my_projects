<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/about_us.css">
    <link rel="stylesheet" href="../css/general_style.css">
    <title>About Us</title>
</head>

<body>
    <div id="wrapper">
        <?php include "header.php"?>
        <div class="about_us_body">
            <h3>About FashionStore</h3>
            <div id="introduction">
                <img src="../assets/fashion1.jpg" alt="" height="300" width="300">
                <div id="introductiontext">
                    <p>FashionStore was founded in 1998 by an upcoming entrepreneur at the time with the name of Htet,
                        who
                        had studied in London Imperial College under Fashion Design. He then started his first store in
                        London with the name of FashionStore, which grew in popularity within a decade and became one of
                        the
                        leading fashion stores in all of Europe. By 2005, it had already expanded to over 6 nearby
                        countries, quickly gathering attention for its sale of high end clothing made using quality
                        fabrics.</p>
                </div>
            </div>
            <div class="spacer"></div>
            <div id="owner1">
                <img src="../assets/fashion2.jpg" alt="" height="300" width="300">
                <div id="owner1text">
                    <p>In 2010, FashionStore acquired the company DesignStore which was run by Sailesh, and changed from
                        a model where they sold many items of differing qualities to
                        focusing on selling just a few items which are of higher quality designed by the best fashion
                        designers around the globe. Currently, FashionStore sells about 9 items, which
                        have been chosen to be on display after an extensive period of consideration with regards to
                        what is the best way in which to cater to the customers
                        who are looking for truly quality goods.
                    </p>
                </div>
            </div>
        </div>
        <div id="footer">
            <script src="../JS/footer.js"></script>
        </div>
    </div>
</body>

</html>