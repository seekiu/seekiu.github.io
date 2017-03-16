/* function FindProxyForURL(url, host) { */
/*   return "DIRECT; PROXY 127.0.0.1:1080"; */ 
/* } */ 

var Shadow_Proxy = "SOCKS5 127.0.0.1:1080";

function FindProxyForURL(url, host) {
   if (0
            || shExpMatch(url,"*bandwagonhost.com*")
            || shExpMatch(url,"*blogger.com*")
            || shExpMatch(url,"*blogspot.com*")
            || shExpMatch(url,"*facebook.com*")
            || shExpMatch(url,"*facebook.net*")
            || shExpMatch(url,"*feedburner.com*")
            || shExpMatch(url,"*ggpht.com*")
            || shExpMatch(url,"*google.com*")
            || shExpMatch(url,"*googleapis.com*")
            || shExpMatch(url,"*googlevideo.com*")
            || shExpMatch(url,"*gstatic.com*")
            || shExpMatch(url,"*instagram.com*")
            || shExpMatch(url,"*ittips.eu*")
            || shExpMatch(url,"*theoldreader.com*")
            || shExpMatch(url,"*twitter.com*")
            || shExpMatch(url,"*twimg.com*")
            || shExpMatch(url,"*youtube.com*")
            || shExpMatch(url,"*ytimg.com*")
       ) {
     return Shadow_Proxy;
   }
   if (isInNet(host, "10.0.0.0",  "255.0.0.0")){
     return "DIRECT";
   }
   return "DIRECT"; Shadow_Proxy;
}


