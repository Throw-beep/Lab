# star_topology.tcl
set ns [new Simulator]

# Trace & NAM output
set tracefile [open sp.tr w]
set namfile [open sp.nam w]
$ns trace-all $tracefile
$ns namtrace-all $namfile

# Create central hub and five leaf nodes
set hub [$ns node]
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

# Connect each leaf to the hub
$ns duplex-link $hub $n0 1Mb 10ms DropTail
$ns duplex-link $hub $n1 1Mb 10ms DropTail
$ns duplex-link $hub $n2 1Mb 10ms DropTail
$ns duplex-link $hub $n3 1Mb 10ms DropTail
$ns duplex-link $hub $n4 1Mb 10ms DropTail

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

# Flow 3: n3 → n2 via hub
set tcp2 [new Agent/TCP]
set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $tcp2
$ns attach-agent $n2 $sink2
$ns connect $tcp2 $sink2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ns at 1.7 "$ftp2 start"
$ns at 8.7 "$ftp2 stop"

# Flow 4: n4 → n3 via hub
set tcp3 [new Agent/TCP]
set sink3 [new Agent/TCPSink]
$ns attach-agent $n4 $tcp3
$ns attach-agent $n3 $sink3
$ns connect $tcp3 $sink3
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ns at 1.9 "$ftp3 start"
$ns at 8.9 "$ftp3 stop"

# Terminate simulation and open NAM
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam sp.nam &
    exit 0
}

$ns at 10.0 "finish"
$ns run

