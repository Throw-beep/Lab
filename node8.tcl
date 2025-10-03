# node.tcl
set ns [new Simulator]

# Trace & NAM output
set tracefile [open star.tr w]
set namfile [open star.nam w]
$ns trace-all $tracefile
$ns namtrace-all $namfile

# Create central hub and three leaf nodes
set hub [$ns node]
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

# Connect each leaf to the hub
$ns duplex-link $hub $n0 1Mb 10ms DropTail
$ns duplex-link $hub $n1 1Mb 10ms DropTail
$ns duplex-link $hub $n2 1Mb 10ms DropTail

# Flow 1: n0 → n1 via hub
set tcp0 [new Agent/TCP]
set sink0 [new Agent/TCPSink]
$ns attach-agent $n0 $tcp0
$ns attach-agent $n1 $sink0
$ns connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 8.0 "$ftp0 stop"

# Flow 2: n2 → n1 via hub
set tcp1 [new Agent/TCP]
set sink1 [new Agent/TCPSink]
$ns attach-agent $n2 $tcp1
$ns attach-agent $n1 $sink1
$ns connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 1.5 "$ftp1 start"
$ns at 8.5 "$ftp1 stop"

# Terminate simulation and open NAM
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam star.nam &
    exit 0
}
$ns at 10.0 "finish"
$ns run

