#Sidia

Clear-Host

$lang = (Get-Culture).TwoLetterISOLanguageName

switch ($lang){
	"en"{
		Write-Host ("Los Contadores serán en Ingles")
		Get-Counter "\Processor(_Total)\% Processor Time", "\Memory\Available MBytes"






	}"pt"{

	Clear-Host


	#Validar Dato ************************************

	$input = Read-Host "Quantidade de Amostras ?"

	if (-not ($input -match '^\d+$')) {
    		Write-Host ""
    		Write-Host "Valor inválido"
    		return
	}

	$Qamos = [int]$input

	# =========================
	# COUNTERS
	# =========================

	$Counters = @(

    			"\Processador(_Total)\% Tempo de Processador",
    			"\Processador(_Total)\% Tempo de DPC",
    			"\PhysicalDisk(_Total)\% Tempo de Disco",
    			"\PhysicalDisk(_Total)\Comprimento médio da fila de disco",
    			"\PhysicalDisk(_Total)\Média de disco s/transferência",

    			"\PhysicalDisk(_Total)\Leituras de disco/s",
    			"\PhysicalDisk(_Total)\Gravações de disco/s",

    			"\PhysicalDisk(_Total)\Bytes de leitura de disco/s",
    			"\PhysicalDisk(_Total)\Bytes de gravação de disco/s",

    			"\Memória\Bytes disponíveis"
)

	# =========================
	# LOOP
	# =========================

	for ($i = 1; $i -le $Qamos; $i++) {


    		Write-Host ""
    		Write-Host "=================== MUESTRA $i de $Qamos ====================" -ForeGroundColor yellow
    		Write-Host ""


    		# =========================
    		# CONTADORES
    		# =========================



    		Get-Counter $Counters


    		# =========================
    		# PROCESOS
    		# =========================



    		Get-Process |
    		Sort-Object CPU -Descending |
    		Select-Object -First 10 `
        	ProcessName,
        	Id,
        	@{Name="CPU(s)";Expression={[math]::Round($_.CPU,2)}},
        	@{Name="RAM(MB)";Expression={[math]::Round($_.WS / 1MB,2)}} |
    		Format-Table -AutoSize








    		# =========================
    		# ESPERA
    		# =========================

    		Start-Sleep -Seconds 1
	


	}	
	}"es"{
		Write-Host ("Los Contadores serán en Espanhol")

		$input = Read-Host "Cantidad de Muestras ?"

		if ($input -as [int]) {
    		$Qamos = [int]$input
		} else {
    		Write-Host "Valor inválido"
    		return
		}


	}default{
		Write-Host ("Los Contadores serán en Ingles, mismo que sea un idioma diferente a los anteriores.")

	}


}

