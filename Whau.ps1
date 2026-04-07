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
Write-Host ("Datos de la Placa Base: ")


Write-Host ("Datos del BIOS : ")

Write-Host ("Datos del CPU :")

Write-Host ("Datos de la GPU: ")

Write-Host ("Datos de la RAM: ")

Write-Host ("******** SOFTWARE ************")
Write-Host ("Datos del Sistema Operitvo: ")

Write-Host "Precione Enter para Salir: " -NoNewLine
Read-Host 
Clear-Host


