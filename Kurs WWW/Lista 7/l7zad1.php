<!doctype HTML>
<head>
<meta charset="utf-8">
</head>
<body>
<h1>phpinfo()</h1>
<?php echo phpinfo() ?>

<h1>tablica $_SERVER</h1>
<?php

	foreach ($_SERVER as $name => $value) {
		echo "$name: $value <br />";
}

?>
</body>