Clear-Host

Write-Host "===================================="
Write-Host "DIAGNOSTICO DE RENDIMIENTO DEL PC"
Write-Host "===================================="
Write-Host ""

# Detectar disco
$disk = Get-PhysicalDisk | Select-Object -First 1

Write-Host "TIPO DE DISCO DETECTADO:"
Write-Host $disk.FriendlyName "-" $disk.MediaType
Write-Host ""

if ($disk.MediaType -eq "SSD") {

    Write-Host "Verificando estado TRIM..."
    $trim = fsutil behavior query DisableDeleteNotify

    if ($trim -match "0") {
        Write-Host "TRIM ACTIVADO" -ForegroundColor Green
    }
    else {
        Write-Host "TRIM DESACTIVADO" -ForegroundColor Red
    }

}
else {

    Write-Host "Disco HDD detectado - TRIM no aplica"
}

Write-Host ""
Write-Host "===================================="
Write-Host "RECOLECTANDO DATOS DE RENDIMIENTO"
Write-Host "60 SEGUNDOS DE MUESTRA"
Write-Host "Espere, por favor ...!!!"
Write-Host "===================================="
Write-Host ""

$counters = @(
'\Processador(_Total)\% tempo de processador',
'\memória\Bytes disponíveis',
'\memória\Páginas/s',
'\memória\Falhas de páginas/s',
'\PhysicalDisk(_Total)\% tempo de disco',
'\PhysicalDisk(_Total)\Média de bytes de disco/transferência',
'\PhysicalDisk(_Total)\Média de bytes de disco/leitura',
'\PhysicalDisk(_Total)\Média de bytes de disco/gravação'
)

$data = Get-Counter -Counter $counters -SampleInterval 1 -MaxSamples 60

Write-Host ""
Write-Host "===================================="
Write-Host "ESTADISTICAS"
Write-Host "===================================="

$results = $data.CounterSamples |
Group-Object Path |
ForEach-Object {

$avg = ($_.Group | Measure-Object CookedValue -Average).Average
$max = ($_.Group | Measure-Object CookedValue -Maximum).Maximum
$min = ($_.Group | Measure-Object CookedValue -Minimum).Minimum

[PSCustomObject]@{
Contador = $_.Name
Promedio = [math]::Round($avg,2)
Maximo = [math]::Round($max,2)
Minimo = [math]::Round($min,2)
}

}

$results | Format-Table -AutoSize


Write-Host ""
Write-Host "===================================="
Write-Host "ANALISIS AUTOMATICO"
Write-Host "===================================="

$cpu = ($results | Where-Object {$_.Contador -like "*Processor Time*"}).Promedio
$ram = ($results | Where-Object {$_.Contador -like "*Available MBytes*"}).Promedio
$pages = ($results | Where-Object {$_.Contador -like "*Pages/sec*"}).Promedio
$diskLatency = ($results | Where-Object {$_.Contador -like "*Disk sec*"}).Promedio
$diskUse = ($results | Where-Object {$_.Contador -like "*Disk Time*"}).Promedio


if ($cpu -gt 80) { Write-Host "CPU MUY ALTA" -ForegroundColor Red }
else { Write-Host "CPU NORMAL" -ForegroundColor Green }

if ($ram -lt 1000) { Write-Host "POCA MEMORIA DISPONIBLE" -ForegroundColor Red }
else { Write-Host "MEMORIA NORMAL" -ForegroundColor Green }

if ($pages -gt 500) { Write-Host "PAGINACION ALTA (FALTA RAM)" -ForegroundColor Yellow }
else { Write-Host "PAGINACION NORMAL" -ForegroundColor Green }

if ($diskLatency -gt 0.05) { Write-Host "LATENCIA DE DISCO ALTA" -ForegroundColor Red }
else { Write-Host "LATENCIA DE DISCO NORMAL" -ForegroundColor Green }

if ($diskUse -gt 80) { Write-Host "USO DE DISCO MUY ALTO" -ForegroundColor Yellow }
else { Write-Host "USO DE DISCO NORMAL" -ForegroundColor Green }


Write-Host ""
Write-Host "===================================="
Write-Host "PROCESOS QUE MAS USAN DISCO"
Write-Host "===================================="

Get-Process |
Sort-Object IOReadBytes -Descending |
Select-Object -First 10 Name,IOReadBytes,IOWriteBytes |
Format-Table


Write-Host ""
Write-Host "===================================="
Write-Host "INFORMACION DEL DISCO"
Write-Host "===================================="

Get-PhysicalDisk |
Select FriendlyName,MediaType,Size,HealthStatus |
Format-Table


Write-Host ""
Write-Host "===================================="
Write-Host "FIN DEL DIAGNOSTICO"
Write-Host "===================================="
