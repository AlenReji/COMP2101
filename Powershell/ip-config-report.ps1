Get-CimInstance win32_networkadapterconfiguration -Filter ipenabled=true | select Description,Index,IPAddress,IPsubnet,DNSDomain,DNSServerSearchOrder