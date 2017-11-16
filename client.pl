use IO::Socket::INET;
 
$| = 1;
 
my $socket = new IO::Socket::INET (
    PeerHost => '192.168.1.10',
    PeerPort => '7777',
    Proto => 'tcp',
);
die "cannot connect to the server $!\n" unless $socket;
print "connected to the server\n";
 
 my $file1 = "file1.txt";
 
my $req = "";
open(DATA, "<file1.txt") or die "Couldn't open file file.txt, $!";
while(<DATA>){
   $req .= "$_";
} 

my $size = $socket->send($req);
print "sent data of length $size\n";

shutdown($socket, 1);
 
my $response = "";
$socket->recv($response, 1024);
print "received response: $response\n";
 
$socket->close();