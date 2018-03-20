echo "====================== Firewall Manager ======================"
echo " 1: Add New Firewall Rule > "
echo " 2: Enable or Disable existing Firewall Rule > "
echo " 3: Delete existing Firewall Rule > "
echo " 4: Search for Firewall Rule > "
echo " 5: Change Profile Policy > "
echo " 6: Shields Up (Set profiles to BLOCK ALL) >  "
echo "=============================================================="
$choice = Read-Host "Select an Option: (0 to exit) > "
switch($choice){
    '1'{
    echo "You chose option 1"
    $fw_displayname = Read-Host "Name: Enter a name for new rule > "
    #echo $fw_displayname
    $fw_direction = Read-Host "Direction: Inbound or Outbound > "
    #echo $fw_direction
    $fw_protocol = Read-Host "Protocol: TCP or UDP > "
    #echo $fw_protocol
    $fw_port = Read-Host "Ports: Enter Local Port(s) > "
    #echo $fw_port
    $fw_group = Read-Host "Group: Enter Group Name > "
    #echo $fw_group
    $fw_action = Read-Host "Action: Block, Drop, or Allow > "
    #echo $fw_action
    New-NetFirewallRule -DisplayName $fw_displayname -Direction $fw_direction -Protocol $fw_protocol -Group $fw_group -LocalPort $fw_port -Action $fw_action
    }
    '2'{
    echo "You chose option 2"
    $fw_displayname = Read-Host "Name: Enter rule to select > "
    $fw_option = Read-Host "Action: Enable or disable $fw_displayname >"
    if($fw_option -eq 'Disable'){
        Disable-NetFirewallRule -DisplayName $fw_displayname
        Get-NetFirewallRule -DisplayName $fw_displayname | Select-Object DisplayName,Enabled  
    }
    elseif($fw_option -eq 'Enable'){
        Enable-NetFirewallRule -DisplayName $fw_displayname
        Get-NetFirewallRule -DisplayName $fw_displayname | Select-Object DisplayName,Enabled
    }
    }
    '3'{
    echo "You chose option 3"
    $fw_displayname = Read-Host "Name: Enter rule to select > "
    $fw_option = Read-Host "Are you sure you want to delete rule $fw_displayname? (Y/N) > "
    if($fw_option -eq 'Y'){
        Remove-NetFirewallRule -DisplayName $fw_displayname
        echo "Removed firewall rule for $fw_displayname"
    }
    elseif($fw_option -eq 'N'){
        echo "Cancelling..."
        return
    }
    }
    '4'{
    echo "You chose option 4"
    $fw_option = Read-Host "Search by display name (1) or display group (2) > "
    if($fw_option -eq 1){
        $fw_displayname = Read-Host "Name: Enter rule to select > "
        Get-NetFirewallRule -DisplayName $fw_displayname
    }
    elseif($fw_option -eq 2){
        $fw_displaygroup  = Read-Host "Name: Enter group to select > "
        Get-NetFirewallRule -DisplayGroup $fw_displaygroup
    }
    }
    '5'{
    echo "You chose option 5"
    $fw_profile = Read-Host "Name: Enter profile to select (Domain, Private, Public) > "
    $fw_enabled = Read-Host "Status: Will the profile $fw_profile be enabled (True, False) > "
    $fw_dinbound = Read-Host "Rule: Select Default Inbound Action (Allow, Block) > "
    $fw_doutbound = Read-Host "Rule: Select Default Outbound Action (Allow, Block) > "
    $fw_logallowed = Read-Host "Rule: Log Allowed Packets (True, False) > "
    $fw_logblocked = Read-Host "Rule: Log Blocked Packets (True, False) > "
    Set-NetFirewallProfile -Name $fw_profile -Enabled $fw_enabled -DefaultInboundAction $fw_dinbound -DefaultOutboundAction $fw_doutbound -LogAllowed $fw_logallowed -LogBlocked $fw_logblocked
    Get-NetFirewallProfile -Name $fw_profile
    }
    '6'{
    echo "Shields up!"
    Set-NetFirewallProfile -Name Domain,Private,Public -Enabled True -DefaultInboundAction Block -DefaultOutboundAction Block -LogAllowed False -LogBlocked True
    Get-NetFirewallProfile -Name Domain,Private,Public | Select-Object Name,Enabled,DefaultInboundAction,DefaultOutboundAction
    }
    '0'{
    echo "Exit command selected, terminating..."
    exit
    }
}
