<?php
session_start();


if((isset($_POST['nameforfb'])and $_POST['nameforfb'] != '') and (isset($_POST['emailforfb'])and $_POST['emailforfb'] != '') and (isset($_POST['subjectforfb'])and $_POST['subjectforfb'] != '')) {
    $feedbackname = $_POST['nameforfb'];
    $feedbackemail = $_POST['emailforfb'];
    $feedbacksubject = $_POST['subjectforfb'];
    $to = 'f31ee@localhost';
$subject = 'Feedback from '.$feedbackemail.'';
$message = $feedbacksubject;
$headers = 'From: '.$feedbackemail.'' . "\r\n" .
'Reply-To: f31ee@localhost' . "\r\n" .
'X-Mailer: PHP/' . phpversion();
mail($to, $subject, $message, $headers,
'-'.$feedbackemail.'');
echo ("<script>document.forms['form_name'].reset();</script>");
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/contact.css">
    <link rel="stylesheet" href="../css/general_style.css">
    <title>Contact Us</title>
</head>

<body>
    <div id="wrapper">
        <?php include "header.php"?>
        <div class="contact_body">
            <div class="contactdetails">
                <p> </p>
                <div class="divider"></div>
                <p> </p>
                <p><strong>Address</strong></p>
                <p><strong>Phone</strong></p>
                <p><strong>Email</strong></p>
                <p><strong>Contact</strong></p>
                <p class=""> </p>
                <p>Store 01</p>
                <p>Kaki Bukit Avenue 3, KB Commercial Building, #01-226, S102391</p>
                <p>92823948</p>
                <p>kakibukit@fashionstore.com</p>
                <p> </p>
                <p class=""> </p>
                <p>Store 02</p>
                <p>181 Orchard Rd, Singapore 238896, #03-162 </p>
                <p>82736482</p>
                <p>orchard@fashionstore.com</p>
            </div>
            <div class="message">
                <p><strong>Leave Us A Message</strong></p>
                <form action="" method="POST">
                    <div class="messageinput">
                        <div class="nameandemail">
                            <div class="feedbackname">
                                <label for="nameforfeedback">Name:</label>
                                <input type="text" id="nameforfeedback" name="nameforfb">
                            </div>
                            <div class="feedbackemail">
                                <label for="emailforfeedback">Email:</label>
                                <input type="email" id="emailforfeedback" name="emailforfb">
                            </div>
                            <div class="feedbacksubmit">
                                <input type="submit" id="submitform">
                            </div>
                        </div>
                        <div class="feedbacksubject">
                            <label for="subjectforfeedback">Message:</label>
                            <input type="text" id="subjectforfeedback" name="subjectforfb">
                        </div>
                    </div>
                </form>
            </div>
            <div class="contactdetails">
                <p> </p>
                <div class="divider"></div>
                <p><strong>Location</strong></p>
                <p><strong>Position</strong></p>
                <p><strong>Job Type</strong></p>
                <p> </p>
                <p><strong>Career</strong></p>
                <p class=""> </p>
                <p>Kaki Bukit Avenue 3, KB Commercial Building, #01-226, S102391</p>
                <p>Devops Engineer</p>
                <p>Backend</p>
                <p></p>
                <p> </p>
                <p class=""> </p>
                <p>181 Orchard Rd, Singapore 238896, #03-162 </p>
                <p>Flutter Developer</p>
                <p>Frontend</p>
                <p></p>
            </div>
        </div>
        <div id="footer">
            <script src="../JS/footer.js"></script>
        </div>
    </div>
</body>

</html>
<script>
var nameFB = document.getElementById('nameforfeedback');
var emailFB = document.getElementById('emailforfeedback');

nameFB.addEventListener("change", () => {
    var pos = nameFB.value.search(/([a-z]+ ?){1,4}/);

    if (pos != 0) {
        nameFB.setCustomValidity("Name must not include invalid characters and digits");
        nameFB.reportValidity();
        setTimeout(function() {
            nameFB.setCustomValidity("");
        }, 2000);
        nameFB.focus();
        nameFB.select();
        return false;
    }
}, false);

emailFB.addEventListener("change", () => {
    var pos = emailFB.value.search(/^[\w.-]+@([a-z]{2,5}\.){1,3}[a-z]{2,3}$/);

    if (pos != 0) {
        emailFB.setCustomValidity("Email format should be emailuser@domain.com");
        emailFB.reportValidity();
        setTimeout(function() {
            emailFB.setCustomValidity("");
        }, 2000);
        emailFB.focus();
        emailFB.select();
        return false;
    }
}, false);
</script>