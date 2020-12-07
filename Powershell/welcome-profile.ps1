	write-output "Welcome to planet $env:computername Overlord $env:username"
	$now = get-date -format 'HH:MM tt on dddd'
	write-output "It is $now."
}
welcome

New-Item -Path alias:np -Value notepad | Out-Null

function get-cpuinfo {
    Get-CimInstance CIM_Processor | Select-Object Manufacturer,Name,Caption,currentclockspeed,maxclockspeed,numberofcores
}
get-cpuinfo

function get-mydisks {
    Get-WmiObject win32_diskdrive | foreach {
        New-Object -TypeName psobject -Property @{Manufacturer=$_.Manufacturer;Model=$_.Model;
        SerialNumber=$_.SerialNumber;Firmware=$FirmwareRevision=$_.FirmwareRevision;Size=($_.size / 1GB).tostring() + "GB"}
    }
}
#get-mydisks