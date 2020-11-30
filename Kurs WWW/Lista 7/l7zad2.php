<?php
$IsPostFormData = (isset($_POST["sent"]) && ($_POST["sent"]=="y"));
$nameErr = "";
$surnameErr = "";
$cardErr = "";
$expDateErr = "";
$cvcErr = "";
$emailErr = "";
$phoneErr = "";
$amountErr  = "";
$isAnyError = false;
?>

<?php
if ( $IsPostFormData ):
	if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (empty($_POST["name"])) {
        $nameErr = "Enter your name";
        $isAnyError = true;
    } else {
        if (!preg_match("/^[a-zA-Z]*$/", $_POST["name"])) {
            $nameErr = "Only letters are allowed";
            $isAnyError = true;
        }
    }

    if (empty($_POST["surname"])) {
        $surnameErr = "Enter your surname";
        $isAnyError = true;
    } else {
        if (!preg_match("/^[a-zA-Z]*$/", $_POST["surname"])) {
            $surnameErr = "Only letters are allowed";
            $isAnyError = true;
        }
    }

    if ($_POST["number"][0] == "" or $_POST["number"][1] == "" or $_POST["number"][2] == "" or $_POST["number"][3] == "") {
        $cardErr = "Enter card number";
        $isAnyError = true;
    } else {
        if (!preg_match("/^[0-9]{4}$/", $_POST["number"][0]) or !preg_match("/^[0-9]{4}$/", $_POST["number"][1]) or !preg_match("/^[0-9]{4}$/", $_POST["number"][2]) or !preg_match("/^[0-9]{4}$/", $_POST["number"][3])) {
            $cardErr = "Enter valid card number";
            $isAnyError = true;
        }
    }


    if ($_POST["month"] =="" or $_POST["year"] =="") {
        $expDateErr = "Enter expiriation date";
        $isAnyError = true;
    } else {
        if ((!preg_match("/^1[0-2]$/", $_POST["month"]) or !preg_match("/^|0[1-9]$/", $_POST["month"])) or !preg_match("/^[0-9]{4}$/",  $_POST["year"] )) {
            $expDateErr = "Enter valid date";
            $isAnyError = true;
        }
    }

    if (empty($_POST["cvc"])) {
        $cvcErr = "Enter CVC number";
        $isAnyError = true;
    } else {
        if (!preg_match("/^[0-9]{3}$/", $_POST["cvc"])) {
            $cvcErr = "Enter valid CVC number";
            $isAnyError = true;
        }
    }


     if (empty($_POST["email"])) {
         $emailErr = "Enter your e-mail adress";
         $isAnyError = true;
     } else {

         if (!filter_var($_POST["email"], FILTER_VALIDATE_EMAIL)) {
             $emailErr = "Enter valid e-mail adress";
             $isAnyError = true;
         }
     }

    if (empty($_POST["phone"])) {
        $phoneErr = "Enter your phone number";
        $isAnyError = true;
    } else {
        if (!preg_match("/^[0-9]{9}$/", $_POST["phone"])) {
            $phoneErr = "Enter valid phone number";
            $isAnyError = true;
        }
    }

    if (empty($_POST["amount"])) {
        $amountErr = "Enter money amount";
        $isAnyError = true;
    } else {
        if (!preg_match("/^[0-9]+$/", $_POST["amount"])) {
            $amountErr = "Enter valid money amount";
            $isAnyError = true;
        }
    }

}
endif;
?>

<!doctype HTML>
<head>
<meta charset="utf-8">
<style>
.error {color: #FF0000;}
.success {color: green;}
</style>
</head>
<body>
<form name="card" method="post" action="l7zad2.php">  
  Card number: 
  <input type="text" name="number[]" size="4" minlength="4" maxlength="4" value="<?php echo $_POST['number'][0]?>">
  <input type="text" name="number[]" size="4" minlength="4" maxlength="4" value="<?php echo $_POST['number'][1]?>">
  <input type="text" name="number[]" size="4" minlength="4" maxlength="4" value="<?php echo $_POST['number'][2]?>">
  <input type="text" name="number[]" size="4" minlength="4" maxlength="4" value="<?php echo $_POST['number'][3]?>">
  <span class="error">* <?php echo $cardErr;?></span>
  <br><br>
  Expiriation date: 
  <input type="text" name="month" size="2" minlength="2" maxlength="2" value="<?php echo $_POST['month']?>">
  <input type="text" name="year" size="4" minlength="4" maxlength="4" value="<?php echo $_POST['year']?>">
  <span class="error">* <?php echo $expDateErr;?></span>
  <br><br>
  CVC number: <input type="text" name="cvc" size="3" minlength="3" maxlength="3" value="<?php echo $_POST['cvc']?>">
  <span class="error">* <?php echo $cvcErr;?></span>
  <br><br>
  Name: <input type="text" name="name" size="15" minlength="2" maxlength="15" value="<?php echo $_POST['name']?>">
  <span class="error">* <?php echo $nameErr;?></span>
  <br><br>
  Surname: <input type="text" name="surname" size="15" minlength="2" maxlength="15" value="<?php echo $_POST['surname']?>">
  <span class="error">* <?php echo $surnameErr;?></span>
  <br><br>
  E-mail adress: <input type="text" name="email" size="15" minlength="6" maxlength="15" value="<?php echo $_POST['email']?>">
  <span class="error">* <?php echo $emailErr;?></span>
  <br><br>
  Phone number: <input type="text" name="phone" size="9" minlength="9" maxlength="9" value="<?php echo $_POST['phone']?>">
  <span class="error">* <?php echo $phoneErr;?></span>
  <br><br>
  Amount: <input type="text" name="amount" value="<?php echo $_POST['amount']?>">
  <span class="error">* <?php echo $amountErr;?></span>
  <br><br>
  
  <input type="submit" name="submit" value="Submit">
  <input name="sent" type="hidden" value="y">  
</form>
<span class="success">
    <?php if(!$isAnyError and $IsPostFormData) {echo "Form has been successfully sent!";} ?>
</span>




</body>