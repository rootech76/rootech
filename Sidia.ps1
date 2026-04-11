#Sidia

$lang = (Get-Culture).TwoLetterISOLanguageName


switch ($lang){
	"en"{
		Write-Host ("Los Contadores serán en Ingles")
		Get-Counter "\Processor(_Total)\% Processor Time", "\Memory\Available MBytes"


	}"pt"{
		Write-Host ("Los Contadoresa serán en portugues") 
		Get-Counter "\Processador(_Total)\% Tempo de Processador", "\Memória\Bytes disponíveis" -SampleInterval 1 -MaxSamples 5
	
	}"es"{
		Write-Host ("Los Contadores serán en Espanhol")

	}default{
		Write-Host ("Los Contadores serán en Ingles, mismo que sea un idioma diferente a los anteriores.")

	}


}
#Ingles
#Portugues
#Espanhol
