if status is-interactive
    function paste
        "/mnt/c/Program Files/PowerShell/7/pwsh.exe" "-NoProfile -Command 'Get-Clipboard | Out-String -Stream'" | tr -d "\r"
    end

    bind \cV 'commandline --insert (paste)'
end
