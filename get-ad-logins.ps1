$date = (get-date).adddays(-1);Get-ADDomainController -Filter {(OperatingSystem -ne "") -and (IsReadOnly -ne "True")} | 
    %{$dc = $_.name;get-aduser -filter {lastlogon -gt $date} -Properties lastlogon -Server $_.name} | 
        Select Name,@{label="LastLogon";expression={[datetime]$_.lastlogon}},@{label="DC";expression={$dc}} |
            Group-Object Name | %{$_.group | sort lastlogon | select -last 1}
