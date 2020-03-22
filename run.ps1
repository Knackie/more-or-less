cls # nettoyage
$nb_victoire = 0 #initialer, ici car sinon il est reset a chaque DO
Do
	{
	#affichage
	echo "*******************************  jeu des nombres  *******************************"
	echo "Le nombre Mystere est compris entre 0 et 100" 
	echo "1 - chercher entre 0 et 10"
	echo "2 - chercher entre 0 et 100"
	echo "3 - chercher entre 0 et 1000"
	echo "4 - chercher entre 0 et une limite que tu definis"
	echo "5 - chercher entre 0 et 10 avec un amis"
	echo "6 - chercher entre 0 et 100 avec un amis"
	echo "7 - chercher entre 0 et 1000 avec un amis"
	echo "8 - Quitter le jeu"
	echo "nombre de victoire actuelle : $nb_victoire"
	$choix = Read-Host "saisie ton choix" # demande du choix
	$tentative_du_joueur # la tentative actuelle du joueur
	$limite; # le nombre max 
	$amis; # bool, true Si on a un amis, false sinon
	$nombre_cache # le nombre à deviner
	$tentative # le nombre de tentative restante
	$indice # Boolean, true si on a le droit a un indice, false sinon
	
	if ($choix -lt 8 -and $choix -gt 0) # on vérifie que le choix de l'utilisateur soit bien entre 0 & 8
	{
		Switch ($choix)
		{
			1 {$limite = 10;$amis=$false;$tentative=3;$indice=$false} # si 1 : nombre entre 1 & 10, 3 tentatives, pas d'indices, et pas d'ami
			2 {$limite = 100;$amis=$false;$tentative=5;$indice=$true} # si 2 : nombre entre 1 & 100, 5 tentatives, indices, et pas d'ami
			3 {$limite = 1000;$amis=$false;$tentative=10;$indice=$true} # si 3 : nombre entre 1 & 1000, 10 tentatives, indices, et pas d'ami
			4 {$limite = Read-Host "choisis ta limite";$amis=$false;$tentative=3} # si 4 : nombre entre 1 & limite définie, 3 tentatives, pas d'indices, et pas d'ami
			5 {$limite = 10;$amis=$true}# si 5 : nombre entre 1 & 10,  joue avec un ami
			6 {$limite = 100;$amis=$true}# si 6 : nombre entre 1 & 100, joue avec un ami
			7 {$limite = 1000;$amis=$true}# si 7 : nombre entre 1 & 1000, joue avec un ami

			
		}

	if($amis -eq $false) # on vérifie si on joue avec un amis
	{
		$nombre_cache = Get-Random -Minimum -0 -Maximum $limite # si on a pas d'amis, on génére un nombre
	}
	else # si on joue avec un amis
	{
		do # cette amis définie le nombre caché, le nombre de tentative, s'il y a des indices. On repete l'opération tant que nombre caché n'est pas dans l'intervalle
		{
		$nombre_cache = Read-Host "saisis un nombre que ton chakal d'amis doit trouver, entre 0 et $limite"
		}
		until ($nombre_cache -lt $limite)
		$tentative = Read-Host "saisis le nombre de tentative que ce chakal aura"
		$tentative = $tentative -as [int]
		$choix_indice = Read-Host "ton chakal d'amis auras-t-il droit a des indices O pour oui et N pour non?"
		if ($choix_indice -eq 'o' -or $choix_indice -eq 'O') # choix d'indice, conversion de son choix en boolean
			{
			$indice = $true
			}
		else
			{
			$indice = $false
			}				
			
		cls # nettoyage pour pas pouvoir lire les choix de l'ami
		
	}
		do # on execute l'algorithme tant que le nombre n'est pas trouvée et qu'on a encore des tentatives
		{
			$tentative_du_joueur = Read-Host "devine un nombre entre 0 et $limite, tu as $tentative tentative(s)" # le joueur fait une tentative
			$tentative-- # il perds une tentative

			if($tentative_du_joueur -eq $nombre_cache){ # si son nombre est égal a celui cherché, c'est que c'est un chakal
				echo "tu as trouve le nombre chakal ! le nombre etait $nombre_cache"
				$nb_victoire++ # une victoire de plus chakal
			}
			else # si son nombre n'est pas égal, ce n'est pas un chakal. 
			{
				if($indice -eq $true)# s'il y a des indices, bah on en donne wolah
				{
					if ($nombre_cache -gt $tentative_du_joueur)
					{
						echo "c est plus chakal"
					}
					else
					{
						echo "c est moins chakal"
					}
				}
			}
		}
		until($nombre_cache -eq $tentative_du_joueur -or $tentative -eq 0) #condition du do
	
	
	}
	}
until($choix -eq 8) # repete le do de l'affichage tant que le joueur veut jouer.
cls
