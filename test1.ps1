New-Item -Path c:\crowdstrike -ItemType directory
$crowdStrikeExe="WindowsSensor_5121_NGAV_INCLUDED.exe"
Invoke-WebRequest -Uri "https://github.com/bhagyagunasekar/Ansible/raw/master/WindowsSensor_5121_NGAV_INCLUDED.exe" -OutFile "C:\temp\$crowdStrikeExe"
cd c:\Temp
$installer=.\$crowdStrikeExe /install /quiet /norestart 
iex $installer
$counter=30 
do {
    start-sleep -s 10 
    $counter-- 
    get-service | findstr /i /r "Running.*CSNest.*CrowdStrike"
 } while ($LASTEXITCODE -gt 0 -and $counter -gt 0)
