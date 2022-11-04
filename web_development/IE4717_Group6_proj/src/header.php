<div id="header">
    <header>
        <div id="logo">
            <a href="home01.php"><img src="../assets/fashionstore.png" alt="Logo" height="55px" width="55px"></a>
        </div>
        <!-- tabs contents are not the same for every page. It will be edited in html files.-->
        <div id="tabs">
            <a href="home01.php">Home</a>
            <a href="products.php">Products</a>
            <a href="about_us.php">About Us</a>
            <a href="contact.php">Contact</a>
        </div>
        <!--Search bar will be re-written in JS after login and cart buttons are added-->
        <div id="search_bar">
            <form action="products.php" method="POST">
                <input type="text" placeholder="Search..." name="searchtext">
                <input type="image" src="../assets/search.png" name="search" width="35px" height="35px" alt="submit">
            </form>
        </div>
        <div id="cart">
            <a href="cart.php"><img src="../assets/cart.jpg" alt="cart_img" width="35px" height="35px"></a>
        </div>
        <div id="login_profile">
            <a href="login.php" target="_self" id="link_btn">
                <?php 
            if(isset($_SESSION['valid_user'])){
                echo $_SESSION['valid_user'];
            } else {
                echo "Login";
            }?></a>
        </div>
    </header>
</div>