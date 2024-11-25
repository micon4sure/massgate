Start-Process -FilePath "C:\mysql\bin\mysqld.exe" -ArgumentList "--console" -NoNewWindow
Start-Sleep -s 10
Start-Process -FilePath "C:\massgate\MMassgateServers.exe" -ArgumentList "live -dbname live -massgateport 3001" -NoNewWindow
Wait-Process -Name mysqld