<?php

# ip.php by KasRoudra
# Author   : KasRoudra
# Github   : https://github.com/KasRoudra
# Email    : kasroudrard@gmail.com
# Messenger: https//m.me/KasRoudra
# Date     : 5-09-2021

error_reporting(E_ERROR | E_PARSE);

function get_client_ip()
{
    $ipaddress = '';
    if (isset($_SERVER['HTTP_CLIENT_IP'])) {
        $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
    } else if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
    } else if (isset($_SERVER['HTTP_X_FORWARDED'])) {
        $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
    } else if (isset($_SERVER['HTTP_FORWARDED_FOR'])) {
        $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
    } else if (isset($_SERVER['HTTP_FORWARDED'])) {
        $ipaddress = $_SERVER['HTTP_FORWARDED'];
    } else if (isset($_SERVER['REMOTE_ADDR'])) {
        $ipaddress = $_SERVER['REMOTE_ADDR'];
    } else {
        $ipaddress = 'UNKNOWN';
    }

    return $ipaddress;
}
$user_agent = $_SERVER['HTTP_USER_AGENT'];

function getOS() { 
    global $user_agent;
    $os_platform  = "Unknown OS Platform";
    $os_array     = array(
                          '/windows nt 10/i'      =>  'Windows 10',
                          '/windows nt 6.3/i'     =>  'Windows 8.1',
                          '/windows nt 6.2/i'     =>  'Windows 8',
                          '/windows nt 6.1/i'     =>  'Windows 7',
                          '/windows nt 6.0/i'     =>  'Windows Vista',
                          '/windows nt 5.2/i'     =>  'Windows Server 2003/XP x64',
                          '/windows nt 5.1/i'     =>  'Windows XP',
                          '/windows xp/i'         =>  'Windows XP',
                          '/windows nt 5.0/i'     =>  'Windows 2000',
                          '/windows me/i'         =>  'Windows ME',
                          '/win98/i'              =>  'Windows 98',
                          '/win95/i'              =>  'Windows 95',
                          '/win16/i'              =>  'Windows 3.11',
                          '/macintosh|mac os x/i' =>  'Mac OS X',
                          '/mac_powerpc/i'        =>  'Mac OS 9',
                          '/linux/i'              =>  'Linux',
                          '/ubuntu/i'             =>  'Ubuntu',
                          '/iphone/i'             =>  'iPhone',
                          '/ipod/i'               =>  'iPod',
                          '/ipad/i'               =>  'iPad',
                          '/android/i'            =>  'Android',
                          '/blackberry/i'         =>  'BlackBerry',
                          '/webos/i'              =>  'Mobile'
                    );

    foreach ($os_array as $regex => $value)
        if (preg_match($regex, $user_agent))
            $os_platform = $value;

    return $os_platform;
}

function getBrowser() {
    global $user_agent;
    $browser        = "Unknown Browser";
    $browser_array = array(
                            '/msie/i'      => 'Internet Explorer',
                            '/firefox/i'   => 'Firefox',
                            '/safari/i'    => 'Safari',
                            '/chrome/i'    => 'Chrome',
                            '/edge/i'      => 'Edge',
                            '/opera/i'     => 'Opera',
                            '/netscape/i'  => 'Netscape',
                            '/maxthon/i'   => 'Maxthon',
                            '/konqueror/i' => 'Konqueror',
                            '/mobile/i'    => 'Handheld Browser'
                     );

    foreach ($browser_array as $regex => $value)
        if (preg_match($regex, $user_agent))
            $browser = $value;

    return $browser;
}


$user_os        = getOS();
$user_browser   = getBrowser();

$PublicIP = get_client_ip();
$file       = 'ip.txt';
$ip         = "IP                   : ".$PublicIP;
$uaget      = "User Agent: ".$user_agent;
$bsr        = "Browser              : ".$user_browser;
$uos        = "User OS              : ".$user_os;
$ust= explode(" ", $user_agent);
$vr= $ust[3];
$ver=str_replace(")", "", $vr);
$version   = "Version              : ".$ver;
$details  = file_get_contents("http://ipwhois.app/json/$PublicIP");
$details  = json_decode($details, true);
$success  = $details['success'];
$fp = fopen($file, 'a');
if ($success==false) {
fwrite($fp, $ip."\n");
fwrite($fp, $uos."\n");
fwrite($fp, $version."\n");
fwrite($fp, $bsr."\n");
fclose($fp);
} else if ($success==true) {
$country  = $details['country'];
$city     = $details['city'];
$continent= $details['continent'];
$tp       = $details['type'];
$cn       = $details['country_phone'];
$is       = $details['isp'];
$latitude = $details['latitude'];
$longitude= $details['longitude'];
$crn      = $details['currency'];

$type       = "IP Type              : ".$tp;
$comma      = ", ";
$location   = "Location             : ".$city.$comma.$country.$comma.$continent;
$geolocation= "GeoLocation(lat, lon): ".$latitude.$comma.$longitude;
$isp        = "ISP                  : ".$is;
$currency   = "Currency             : ".$crn;
fwrite($fp, $ip."\n");
fwrite($fp, $type."\n");
fwrite($fp, $uos."\n");
fwrite($fp, $version."\n");
fwrite($fp, $bsr."\n");
fwrite($fp, $location."\n");
fwrite($fp, $geolocation."\n");
fwrite($fp, $currency."\n");

fclose($fp);
} else {
$status     = "Status               : ".$success;
fwrite($fp, $status."\n");
fwrite($fp, $uaget."\n");
fclose($fp);
}
?>