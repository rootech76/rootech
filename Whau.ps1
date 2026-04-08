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

Write-Host ("WHAU") 
Write-Host ("******** HARDWARE ************")
Write-Host ("`nDatos de la Placa Base: " ) -ForeGroundColor Yellow
Write-Host ("{0,-20} {1}" -f "Fabricante: " , $MBoard.Manufacturer) 
Write-Host ("{0,-20} {1}" -f "Modelo: " , $MBoard.Product) 

Write-Host ("`nDatos del BIOS : ")

Write-Host ("`nDatos del CPU :")

Write-Host ("`nDatos de la GPU: ")

Write-Host ("`nDatos de la RAM: ")

Write-Host ("******** SOFTWARE ************")
Write-Host ("Datos del Sistema Operitvo: ")

Write-Host "Precione Enter para Salir: " -NoNewLine
Read-Host 
Clear-Host


