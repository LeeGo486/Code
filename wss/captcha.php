<?php
session_start();
//set some important CAPTCHA constants
define('CAPTCHA_NUMCHARS', 6);//字符数量
define('CAPTCHA_WIDTH', 100);//宽
define('CAPTCHA_HEIGHT', 25);//高

//getCHAR
$pass_phrase = "";
for ($i = 0; $i < CAPTCHA_NUMCHARS; $i++){
    $pass_phrase .= chr(rand(97, 122));
};
//session
$_SESSION['pass_phrase'] = sha1($pass_phrase);

//create img
$img = imagecreatetruecolor(CAPTCHA_WIDTH,CAPTCHA_HEIGHT);

//create color
$bg_color = imagecolorallocate($img,255,255,255);
$text_color = imagecolorallocate($img,53, 126, 189);
$graphic_color = imagecolorallocate($img,64,64,64);

//create background
imagefilledrectangle($img,0,0,CAPTCHA_WIDTH,CAPTCHA_HEIGHT,$bg_color);
//Draw some random lines
for($i=0;$i<2;$i++){
    imageline($img,0,rand()%CAPTCHA_HEIGHT,CAPTCHA_WIDTH,rand()%CAPTCHA_HEIGHT,$graphic_color);
};
//Draw some dots
for($i=0;$i<60;$i++){
    imagesetpixel($img,rand()%CAPTCHA_WIDTH,rand()%CAPTCHA_HEIGHT,$graphic_color);
};
//
imagettftext($img,18,0,5,CAPTCHA_HEIGHT-5,$text_color,"Courier New Bold.ttf",$pass_phrase);
//output png
header("Content-type:image/png");
imagepng($img);
//Clean up
imagedestroy($img);
?>