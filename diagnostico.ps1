Write-Host "==============================="
Write-Host "DIAGNOSTICO DE RENDIMIENTO PC"
Write-Host "Muestreo de 60 segundos"
Write-Host "==============================="
Write-Host ""

$counters = @(
'\Processor(_Total)\% Processor Time',
'\Memory\Available MBytes',
'\Memory\Pages/sec',
'\Memory\Page Faults/sec',
'\PhysicalDisk(_Total)\% Disk Time',
'\PhysicalDisk(_Total)\Avg. Disk sec/Transfer',
'\PhysicalDisk(_Total)\Disk Read Bytes/sec',
'\PhysicalDisk(_Total)\Disk Write Bytes/sec'
)

Write-Host "Recolectando datos durante 60 segundos..."
$data = Get-Counter -Counter $counters -SampleInterval 1 -MaxSamples 60

Write-Host ""
Write-Host "===== PROMEDIOS ====="

$data.CounterSamples |
Group-Object Path |
ForEach-Object {

    $avg = ($_.Group | Measure-Object CookedValue -Average).Average

    [PSCustomObject]@{
        Counter = $_.Name
        Promedio = [math]::Round($avg,2)
    }

}

Write-Host ""
Write-Host "===== PROCESOS QUE MAS USAN DISCO ====="

Get-Process |
Sort-Object IOReadBytes -Descending |
Select -First 10 Name,IOReadBytes,IOWriteBytes

Write-Host ""
Write-Host "===== INFORMACION DEL DISCO ====="

Get-PhysicalDisk |
Select FriendlyName,MediaType,Size,HealthStatus

Write-Host ""
Write-Host "===== ESTADO TRIM ====="

fsutil behavior query DisableDeleteNotify
