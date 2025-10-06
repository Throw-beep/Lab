set ns [new Simulator]

set tracefile [open star.tr w]
set namfile [open star.nam w]
$ns trace-all $tracefile
$ns namtrace-all $namfile

set hub [$ns node]
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$hub color red
$n0 color blue
$n1 color yellow
$n2 color green


$ns duplex-link $hub $n0 1Mb 10ms DropTail
$ns duplex-link $hub $n1 1Mb 10ms DropTail
$ns duplex-link $hub $n2 1Mb 10ms DropTail


set tcp0 [new Agent/TCP]
set sink0 [new Agent/TCPSink]
$ns attach-agent $n0 $tcp0
$ns attach-agent $n1 $sink0
$ns connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 5.0 "$ftp0 stop"


set tcp1 [new Agent/TCP]
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $tcp1
$ns attach-agent $n2 $sink1
$ns connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 1.5 "$ftp1 start"
$ns at 5.5 "$ftp1 stop"


set tcp2 [new Agent/TCP]
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $tcp2
$ns attach-agent $n0 $sink2
$ns connect $tcp2 $sink2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ns at 2.0 "$ftp2 start"
$ns at 6.0 "$ftp2 stop"


proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam star.nam &
    exit 0
}


$ns at 6.5 "finish"

# Run simulation
$ns run
