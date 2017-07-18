New-Item -Path c:\test -ItemType directory
Invoke-WebRequest -Uri "https://github.com/bhagyagunasekar/Ansible/raw/master/WindowsSensor_5121_NGAV_INCLUDED.exe" -OutFile "C:\temp\$crowdStrikeExe"
cd c:\Temp
$installer=.\WindowsSensor_5121_NGAV_INCLUDED.exe /install /quiet /norestart CID="35C43E7262224DFB9AA9F142596987E5-E7"
iex $installer
$counter=30 
do {
    $counter-- 
    get-service | findstr /i /r "Running.*CSNest.*CrowdStrike"
 } while ($LASTEXITCODE -gt 0 -and $counter -gt 0)

write-host "Installing and Enabling SSM agent"
Invoke-WebRequest -Uri "https://s3.amazonaws.com/ec2-downloads-windows/EC2Config/EC2Install.zip" -OutFile "C:\Temp\EC2Install.zip"
$BackUpPath = "C:\Temp\EC2Install.zip"
$Destination = "C:\Temp"
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($BackUpPath, $destination)
cd c:\Temp\EC2Install
$ssminstall=.\Ec2Install.exe /quiet /norestart
