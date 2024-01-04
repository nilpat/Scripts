# Ensure source directory exists
if (!(Test-Path $sourceDir)) {
  Write-Error "Source directory does not exist."
  exit 1
}

# Use scp for secure file transfer
$session = New-PSSession -ComputerName $targetHost -Credential $targetUser
Copy-Item -Path $sourceDir -Destination $targetDir -ToSession $session -Recurse -Force

# Check for errors
if ($? -ne 0) {
  Write-Error "File transfer failed."
  exit 1
} else {
  Write-Output "Files transferred successfully."
}

# Close the session
Remove-PSSession $session
