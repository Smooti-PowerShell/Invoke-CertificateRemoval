$Path = "C:\Users\"

$List = (Get-ChildItem "$($Path)").FullName
ForEach ($L in $List) {
    Try {
        $pfx = @(Get-ChildItem "$($Path)*.pfx" -Recurse).FullName
        $p12 = @(Get-ChildItem "$($Path)*.p12" -Recurse).FullName
    }
    Catch {
        Write-Warning "Access to $($L) denied."
    }

    ForEach ($p in $pfx) {
        Try {
            Remove-Item $p -Force
        }
        Catch {
            Write-Warning "Unable to remove $($p)"
        }
        
        ForEach ($p in $p12) {
            Try {
                Remove-Item $p -Force
            }
            Catch {
                Write-Warning "Unable to remove $($p)"
            }
        }
    }
}