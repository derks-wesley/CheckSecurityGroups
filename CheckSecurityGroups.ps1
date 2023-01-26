<#
.SYNOPSIS
    This script allows you to check all security groups on Windows and export the users within these groups to a .CSV file. 

.DESCRIPTION
    This simple script checks which users are added to which security groups on Windows. After checking it will generate a .CSV file for easy reading.
    If requested i will add the function to exclude certain groups, or you can add it youself. Did not add it because there was no need for it in my situation.
    If you edit it yourself, kindly share what you did so we can help each other.

.EXAMPLE
    Example syntax for running the script or function.
    PS C:\> CheckSecurityGroups.ps1 (make sure the file is located on the location you run it from)

.NOTES
    Filename: CheckSecurityGroups.ps1
    Author: Wesley Derks
    Modified date: 2023/01/25
    Version 1.0 - First release.
#>

$groups = Get-ADGroup -Filter *
$results = @()
foreach ($group in $groups) {
    $members = Get-ADGroupMember -Identity $group.DistinguishedName
    $obj = New-Object PSObject
    $obj | Add-Member -Type NoteProperty -Name "Group Name" -Value $group.Name
    $obj | Add-Member -Type NoteProperty -Name "Group Description" -Value $group.Description
    $obj | Add-Member -Type NoteProperty -Name "Group Members" -Value ($members.Name -join ",")
    $results += $obj
}
$results | Export-Csv -Path "C:\groups.csv" -NoTypeInformation
