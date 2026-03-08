Clear-Host

Write-Host "===================================="
Write-Host "DIAGNOSTICO COMPLETO DEL SISTEMA"
Write-Host "===================================="
Write-Host ""

# Detectar disco
$disk = Get-PhysicalDisk | Select-Object -First 1

Write-Host "DISCO DETECTADO:"
Write-Host $disk.FriendlyName "-" $disk.MediaType
Write-Host ""

if ($disk.MediaType -eq "SSD") {

    Write-Host "Verificando TRIM..."
    $trim = fsutil behavior query DisableDeleteNotify

    if ($trim -match "0") {
        Write-Host "TRIM ACTIVADO" -ForegroundColor Green
    }
    else {
        Write-Host "TRIM DESACTIVADO" -ForegroundColor Red
    }

}
else {

    Write-Host "Disco HDD detectado (TRIM no aplica)"
}

Write-Host ""
Write-Host "===================================="
Write-Host "INFORMACION DE RED"
Write-Host "===================================="

Get-NetAdapter | Where-Object {$_.Status -eq "Up"} |
Select Name, InterfaceDescription, LinkSpeed |
Format-Table

Write-Host ""
Write-Host "===================================="
Write-Host "RECOLECTANDO CONTADORES (60 SEG)"
Write-Host "===================================="

$counters = @(
'\Processo(_Total)\% Tempo de Processador',
'\Memória\MBytes disponíveis',
'\Memória\Páginas/s',
'\Memória\Falhas de páginas/s',
'\PhysicalDisk(_Total)\% Tempo de Disco',
'\PhysicalDisk(_Total)\Média de bytes de disco/transferência',
'\PhysicalDisk(_Total)\Bytes de leitura de disco/s',
'\PhysicalDisk(_Total)\Bytes de gravação de disco/s',
'\Network Interface(*)\Total de bytes/s'
)

# Verificar contadores disponibles
$validCounters = @()

foreach ($c in $counters) {
    try {
        Get-Counter -Counter $c -ErrorAction Stop | Out-Null
        $validCounters += $c
    }
    catch {
        Write-Host "Contador no disponible:" $c -ForegroundColor Yellow
    }
}

$data = Get-Counter -Counter $validCounters -SampleInterval 1 -MaxSamples 60

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

if ($pages -gt 500) { Write-Host "PAGINACION ALTA" -ForegroundColor Yellow }
else { Write-Host "PAGINACION NORMAL" -ForegroundColor Green }

if ($diskLatency -gt 0.05) { Write-Host "LATENCIA DE DISCO ALTA" -ForegroundColor Red }
else { Write-Host "LATENCIA DE DISCO NORMAL" -ForegroundColor Green }

if ($diskUse -gt 80) { Write-Host "USO DE DISCO ALTO" -ForegroundColor Yellow }
else { Write-Host "USO DE DISCO NORMAL" -ForegroundColor Green }

Write-Host ""
Write-Host "===================================="
Write-Host "PROCESOS QUE MAS USAN DISCO"
Write-Host "===================================="

Get-Process |
Sort-Object IOReadBytes -Descending |
Select -First 10 Name,IOReadBytes,IOWriteBytes |
Format-Table

Write-Host ""
Write-Host "===================================="
Write-Host "CONEXIONES DE RED ACTIVAS"
Write-Host "===================================="

Get-NetTCPConnection |
Select LocalAddress,LocalPort,RemoteAddress,RemotePort,State |
Sort-Object State |
Format-Table

Write-Host ""
Write-Host "===================================="
Write-Host "PROCESOS CON MAS CONEXIONES"
Write-Host "===================================="

Get-NetTCPConnection |
Group-Object OwningProcess |
Sort-Object Count -Descending |
Select -First 10 |
ForEach-Object {

$proc = Get-Process -Id $_.Name -ErrorAction SilentlyContinue

[PSCustomObject]@{
Proceso = $proc.ProcessName
PID = $_.Name
Conexiones = $_.Count
}

} | Format-Table

Write-Host ""
Write-Host "===================================="
Write-Host "FIN DEL DIAGNOSTICO"
Write-Host "===================================="
