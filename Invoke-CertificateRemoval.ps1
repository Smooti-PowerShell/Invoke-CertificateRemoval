<#
    .SYNOPSIS
        Removes all Software certificate installation files.
    .NOTES
        Version:        1.0
        Author:         Robert Owens
        Creation Date:  12/31/2020
        
        V-63393 - Software certificate installation files must be removed from a system.

        Description - Use of software certificates and their accompanying installation files
        for end users to access resources is less secure than the use of hardware-based certificates.
    .PARAMETER Path
        DEFAULT: C:\Users\
        Path you would like to enumerate (This will be recursive).
    .EXAMPLE
        Invoke-CertificateRemoval         
#>

Param(
    [string] $Path = 'C:\Users\'
)

$pfx = @(Get-ChildItem "$($Path)*.pfx" -Recurse).FullName
$p12 = @(Get-ChildItem "$($Path)*.p12" -Recurse).FullName

ForEach ($p in @($pfx + $p12)) {
    Try {
        Remove-Item $p -Force -ErrorAction Stop
    }
    Catch {
        Write-Warning "Unable to remove '$($p)'"
    }
}
