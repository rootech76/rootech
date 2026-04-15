#Whau

################## INICIALICACIÓN DE VARIABLES #################### 

# HardWare *********************************************************
$MBoard = Get-CimInstance win32_BaseBoard
$CPU = Get-CimInstance win32_Processor
$BIOS = Get-CimInstance win32_BIOS 
$GPU = Get-CimInstance win32_Videocontroller
$RAM = Get-CimInstance win32_PhysicalMemory
$Disk = Get-PhysicalDisk
#SoftWare ***********************************************************

$OS = Get-cimInstance win32_OperatingSystem
$OSVersionH = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").DisplayVersion




Clear-Host

Write-Host ("                   WHAU")  -ForeGroundColor DarkRed  
Write-Host ("`n******************* HARDWARE ***************************")
Write-Host ("`nDatos de la Placa Base: " ) -ForeGroundColor DarkYellow
Write-Host ("{0,-20} {1}" -f "Fabricante: " , $MBoard.Manufacturer) 
Write-Host ("{0,-20} {1}" -f "Modelo: " , $MBoard.Product) 

Write-Host ("`nDatos de la BIOS : ") -ForeGroundColor DarkYellow
Write-Host ("{0,-20} {1}" -f "Fabricante: " , $BIOS.Manufacturer) 
Write-Host ("{0,-20} {1}" -f "Firmware: " , $BIOS.SMBIOSBIOSVersion) 

Write-Host ("`nDatos del CPU :") -ForeGroundColor DarkYellow 
Write-Host ("{0,-20} {1}" -f "Fabricante: " , $CPU.Manufacturer) 
Write-Host ("{0,-20} {1}" -f "Descripción: " , $CPU.name) 
Write-Host ("{0,-20} {1}" -f "Nucleos: " , $CPU.NumberOfCores) 
Write-Host ("{0,-20} {1}" -f "Threads: " , $CPU.NumberOfLogicalProcessors) 

Write-Host ("`nDatos de la GPU: ") -ForeGroundColor DarkYellow
Write-Host ("{0,-20} {1}" -f "Descripción: " , $GPU.name) 
Write-Host ("{0,-20} {1}" -f "VRAM (GB): " , ($GPU.AdapterRAM / 1GB))




Write-Host ("`nDatos de la RAM: ") -ForeGroundColor DarkYellow

$cont = 1
foreach($Modulo in $RAM){
    Write-Host "`nModulo $cont :" -ForegroundColor Cyan
    
    Write-Host ("{0,-20} {1}" -f "Fabricante:", $Modulo.Manufacturer)
    Write-Host ("{0,-20} {1}" -f "Capacidad (GB):", [math]::Round($Modulo.Capacity / 1GB,2))
    Write-Host ("{0,-20} {1}" -f "Velocidad (MHz):", $Modulo.Speed)
    Write-Host ("{0,-20} {1}" -f "Tipo:", $Modulo.SMBIOSMemoryType)

    $cont++
}

# Total RAM
$totalRAM = ($RAM | Measure-Object -Property Capacity -Sum).Sum
Write-Host ("`n{0,-20} {1}" -f "RAM Total (GB):", [math]::Round($totalRAM / 1GB,2)) -ForegroundColor Green




Write-Host ("`nDatos del Disco: ") -ForeGroundColor DarkYellow

$cont = 1
foreach($D in $Disk){
    Write-Host "`nDisco $cont :" -ForegroundColor Cyan
    
    Write-Host ("{0,-20} {1}" -f "Nombre:", $D.FriendlyName)
    Write-Host ("{0,-20} {1}" -f "Tipo:", $D.MediaType)
    Write-Host ("{0,-20} {1}" -f "Bus:", $D.BusType)
    Write-Host ("{0,-20} {1}" -f "Capacidad (GB):", [math]::Round($D.Size / 1GB,2))

    $cont++
}



Write-Host ("`n******************* SOFTWARE ***************************")
Write-Host ("`nDatos del Sistema Operitvo: ") -ForeGroundColor DarkYellow
Write-Host ("{0,-20} {1}" -f "Nombre: " , $OS.Caption) 
Write-Host ("{0,-20} {1}" -f "Build: " , $OS.BuildNumber) 
Write-Host ("{0,-20} {1}" -f "Versión: " , $OSVersionH) 

Write-Host "Precione Enter para Salir: " -NoNewLine -ForeGroundColor Yellow
Read-Host 
Clear-Host


