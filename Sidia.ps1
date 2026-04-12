#Sidia

$lang = (Get-Culture).TwoLetterISOLanguageName


switch ($lang){
	"en"{
		Write-Host ("Los Contadores serán en Ingles")
		Get-Counter "\Processor(_Total)\% Processor Time", "\Memory\Available MBytes"


	}"pt"{
		Write-Host ("Los Contadoresa serán en portugues") 
		Get-Counter "\Processador(_Total)\% Tempo de Processador", "\Processador(_Total)\% tempo ocioso", "\Processador(_Total)\% Tempo de DPC", 
		            "\PhysicalDisk(_Total)\Comprimento da fila de disco atual", "\PhysicalDisk(_Total)\% Tempo de Disco", "\PhysicalDisk(_Total)\Leituras de disco/s", "\PhysicalDisk(_Total)\Gravações de disco/s",		
		"\Memória\Bytes disponíveis" -SampleInterval 1 -MaxSamples 15 
	
	}"es"{
		Write-Host ("Los Contadores serán en Espanhol")

	}default{
		Write-Host ("Los Contadores serán en Ingles, mismo que sea un idioma diferente a los anteriores.")

	}


}
#Ingles
#Portugues
#Espanhol
