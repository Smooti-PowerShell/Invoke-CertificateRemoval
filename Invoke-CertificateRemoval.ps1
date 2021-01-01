<#
    .SYNOPSIS
        Removes all Software certificate installation files.
    .NOTES
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

ForEach ($p in $pfx) {
    Try {
        Remove-Item $p -Force
    }
    Catch {
        Write-Warning "Unable to remove '$($p)'"
    }
}

ForEach ($p in $p12) {
    Try {
        Remove-Item $p -Force
    }
    Catch {
        Write-Warning "Unable to remove '$($p)'"
    }
}