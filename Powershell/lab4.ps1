function system-hardware {
    gwmi win32_computersystem | select Manufacturer, Model | Format-List
}

function operating-system { 
    gwmi win32_operatingsystem | select Caption, Version | Format-List
}

function processor-info {
    gwmi win32_processor | select Name, NumberofCores, 
            @{n="L1 Cache Size"; e={switch($_.L1CacheSize){$null{$Stat="data unavailable"} 0{$stat="0"}}; $stat}},
            @{n="L2 Cache Size"; e={switch($_.L2CacheSize){$null{$Stat="data unavailable"} 0{$stat="0"}}; $stat}},
            @{n="L3 Cache Size"; e={switch($_.L3CacheSize){$null{$Stat="data unavailable"} 0{$stat="0"}}; $stat}} | Format-List
}

function ram-info {
    gwmi win32_physicalmemory | foreach {
        New-Object -TypeName psobject -Property @{
        Vendor = $_.manufacturer
        Description = $_.description
        "Size in GB" = $_.capacity/1gb
        Bank = $_.banklabel
        Slot =$_.devicelocator
        }
    }
}

function disk-info {
    $diskdrives = Get-CIMInstance CIM_diskdrive
    $diskinfo = foreach ($disk in $diskdrives) { 
        $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition 
        foreach ($partition in $partitions) { 
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk 
            foreach ($logicaldisk in $logicaldisks) { 
                new-object -typename psobject -property @{ Drive=$logicaldisk.deviceid; 
                                                           Vendor=$disk.Manufacturer; 
                                                           Model=$disk.model; 
                                                           “Size(GB)”="{0:N2}" -f ($logicaldisk.size / 1gb); 
                                                           "Free Space(GB)"= "{0:N2}" -f (($logicaldisk.freespace) / 1gb)
                                                           "Space Uasge(%)" = "{0:N2}" -f (($logicaldisk.size-$logicaldisk.freespace) * 100 / $logicaldisk.size)
                                                         } 
            } 
        }
    } 
    $diskinfo
}

function network-adapter {
    Get-CimInstance win32_networkadapterconfiguration -Filter ipenabled=true |select Index,Description,IPAddress,IPsubnet,DNSDomain,DNSServerSearchOrder | Format-Table -AutoSize
}

function video-card {
    gwmi win32_videocontroller | select @{ n ="Manufacturer Name" ; e = {$_.AdapterCompatibility}} , Description, @{ n="Display Resolution"; e = {($_.CurrentHorizontalResolution.toString()) + "x" + ($_.CurrentVerticalResolution.toString())}} | Format-List
}
"`n"
" RUNNING SYSTEM REPORT "
"`n"
"******************* SYSTEM HARDWARE DESCRIPTION ***************"
system-hardware

"******************* OPERATING SYSTEM INFORMATION **************"
operating-system
"******************* PROCESSOR DESCRIPTION **************"
processor-info
"******************* RAM INFORMATION **************"
ram-info
"******************* PHYSICAL DISK DRIVES **************"
disk-info
"******************* NETWORK ADAPTER CONFIGURATION **************"
network-adapter
"******************* VIDEO CARD DESCRIPTION **************"
video-card




