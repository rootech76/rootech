#Whau

################## INICIALICACIÓN DE VARIABLES #################### 

# HardWare *********************************************************
$MBoard = Get-CimInstance win32_BaseBoard
$CPU = Get-CimInstance win32_Processor
$BIOS = Get-CimInstance win32_BIOS 
$GPU = Get-CimInstance win32_Videocontroller
$RAM = Get-CimInstance win32_PhysicalMemory

#SoftWare ***********************************************************

$OS = Get-cimInstance win32_OperatingSystem




Clear-Host

Write-Host ("           WHAU")  -ForeGroundColor DarkRed  
Write-Host ("`n******** HARDWARE ************")
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
Write-Host ("{0,-20} {1}" -f "Fabricante: " , $RAM.Manufacturer) 
Write-Host ("{0,-20} {1}" -f "Capacidad (GB): " , ($RAM.Capacity / 1GB)) 
Write-Host ("{0,-20} {1}" -f "Velocidad (MHz): " , $RAM.Speed) 
Write-Host ("{0,-20} {1}" -f "Tipo: " , $RAM.SMBIOSMemoryType) 

Write-Host ("`nDatos del Disco: ") -ForeGroundColor DarkYellow

Write-Host ("`n******** SOFTWARE ************")
Write-Host ("`nDatos del Sistema Operitvo: ") -ForeGroundColor DarkYellow

Write-Host "Precione Enter para Salir: " -NoNewLine -ForeGroundColor Yellow
Read-Host 
Clear-Host


