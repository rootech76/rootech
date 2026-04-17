#Sidia

Clear-Host

$lang = (Get-Culture).TwoLetterISOLanguageName

switch ($lang){
	"en"{
		Write-Host ("Los Contadores serán en Ingles")
		Get-Counter "\Processor(_Total)\% Processor Time", "\Memory\Available MBytes"






	}"pt"{
#Validar Dato ************************************

		$input = Read-Host "Quantidade de Amostras ?"

		if ($input -as [int]) {
    		$Qamos = [int]$input
		} else {
    		Write-Host "Valor inválido"
    		return
		}



		Get-Counter @("\Processador(_Total)\% Tempo de Processador", "\Processador(_Total)\% Tempo de DPC", 
		            "\PhysicalDisk(_Total)\% Tempo de Disco","\PhysicalDisk(_Total)\Comprimento médio da fila de disco", "\PhysicalDisk(_Total)\Média de disco s/transferência" , "\PhysicalDisk(_Total)\Leituras de disco/s", "\PhysicalDisk(_Total)\Gravações de disco/s", "\PhysicalDisk(_Total)\Bytes de leitura de disco/s" , "\PhysicalDisk(_Total)\Bytes de gravação de disco/s" ,"\Memória\Bytes disponíveis") -SampleInterval 1 -MaxSamples $Qamos 





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

