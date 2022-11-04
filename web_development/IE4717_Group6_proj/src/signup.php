<?php
    session_start();
    if(isset($_SESSION['valid_user'])){
        // to redirect to profile page if user happen to reach here for some reasons
        echo '<script>alert("You are already logged in!");</script>';
        echo '<script>window.location.replace("login.php");</script>';
    }
    if(isset($_REQUEST['register']))
    {
        if(empty($_REQUEST['username']) || empty($_REQUEST['email']) || empty($_REQUEST['password']) || empty($_REQUEST['password2']))
        {
            echo '<script>alert("Please Fill in every detail!");</script>';

            // if header() function is used to redirect the page, it won't load JS alert.
            // use window.location.replace() instead
            echo '<script>window.location.replace("'.$_SERVER['PHP_SELF'].'");</script>';
        } else {
            include "dbconnect.php";
            $username = $_REQUEST['username'];
            $email = $_REQUEST['email'];
            $password = $_REQUEST['password'];
            $password2 = $_REQUEST['password2'];
    
            if($password != $password2){
                echo '<script>alert("Passwords do not match!");</script>';
                $dbcnx->close();
                echo '<script>window.location.replace("'.$_SERVER['PHP_SELF'].'");</script>';
            }
            $password = md5($password);

            $query = "select * from users where username = '$username'";
            $result = $dbcnx->query($query);
            if($result->num_rows > 0)
            {
                echo '<script>alert("'.$username.' already exists.");</script>';
                $dbcnx->close();
                echo '<script>window.location.replace("'.$_SERVER['PHP_SELF'].'");</script>';
            }
            $query = "INSERT INTO users(username, password, email) values ('$username', '$password', '$email')";
            $result = $dbcnx->query($query);
            if(!$result)
            {
                echo '<script>alert("Registration Failed!");</script>';
                $dbcnx->close();
                echo '<script>window.location.replace("'.$_SERVER['PHP_SELF'].'");</script>';
            } else {
                echo '<script>alert("Welcome '.$username.'");</script>';
                $dbcnx->close();
                //echo '<script>window.location.replace("/Design_Project/IE4717_Group6_proj/src/login.php");</script>';
                echo '<script>window.location.replace("login.php");</script>';
                exit;
            }
        }
    } else {
        ?>
        <!DOCTYPE html>
        <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link rel="stylesheet" href="../css/general_style.css">
                <style>
                    .body {
                        margin: auto;
                        background-color: rgb(195, 195, 195);
                        width: 80%;
                        margin-top: 0px;
                        padding: 2px 20px;
                        border-radius: 20px;
                        align-content: start;
                        min-width: 900px;
                    }body {
                        margin: 0px;
                    }
                    .body img, .body .signup{
                        margin-top: 20px; padding: 0% 40%;
                    }
                    .signup_input {
                        border-radius: 20px;
                        width: 300px;
                        padding-left: 10px;
                        height: 30px;
                        border-width: 3px;
                        background-color: rgb(243, 243, 243);
                    }
        
                    #signupsubmit {
                        width: 200px;
                        background-color: lightblue;
                        margin-left: 50px;
                    }
                    p {
                        margin-left: 50px;
                    }
                </style>
                <title>Sign Up</title>
            </head>
            <body>
                <div id="wrapper">
                    <?php include "header.php"?>
                    <div class="body">
                        <!-- https://www.freepik.com/free-vector/sign-up-concept-illustration_20602851.htm#query=signup&position=7&from_view=keyword -->
                        <img src="../assets/signup.png" alt="asd" height="300" width="300">
                        <div class="signup">
                            <form action="signup.php" method="POST">
                                <input type="text" class="signup_input" placeholder="Username" name="username" >
                                <br><br>
                                <input type="email" class="signup_input" placeholder="Email" name="email" >
                                <br><br>
                                <input type="password"  class="signup_input" placeholder="Password" name="password">
                                <br><br>
                                <input type="password"  class="signup_input" placeholder="Confirm Password" name="password2" >
                                <br><br>
                                <input type="submit"  class="signup_input" value="Sign Up" id="signupsubmit" name="register">
                            </form>
                            <p>Already have an account? <a href="login.php">Log In</a></p>
                        </div>
                    </div>
                    <div id="footer">
                        <script src="../JS/footer.js"></script>
                    </div>
                </div>
            </body>
        </html>
        <?php
    }
?>