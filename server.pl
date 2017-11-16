use IO::Socket::INET;
use strict;
use warnings;

$| = 1;
 
my $socket = new IO::Socket::INET (
    LocalHost => '0.0.0.0',
    LocalPort => '7777',
    Proto => 'tcp',
    Listen => 5, 
    Reuse => 1
);
die "cannot create socket $!\n" unless $socket;
print "server waiting for client connection on port 7777\n";
 

    my $file2 = "file1.txt";
    open(my $fh, '>', $file2) or die "Could not open file file1.txt $!";;

    my $client_socket = $socket->accept();
 
    my $client_address = $client_socket->peerhost();
    my $client_port = $client_socket->peerport();
    print "connection from $client_address:$client_port\n";
 
    my $data = "";
    $client_socket->recv($data, 1024);
    print "received data:\n $data\n";
    print $fh "$data";
    close $fh;

    $data = "ok";
    $client_socket->send($data);
 
    shutdown($client_socket, 1);

$socket->close();