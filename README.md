
Dans le cadre d'un projet SAE de ma licence en Informatique j'ai coder un scrpit permetant d'archiver des fichier binaire et de restaurer
# Utilisation de l'archive
L'archive générée est nommée file.archive. Pour l'utiliser, placez-la dans le dossier du serveur Apache de votre machine et lancez l'exécution, ou
utilisez l'option -d pour spécifier la destination de l'extraction (par exemple ./file.archive -d /chemin_destination).

# Utilisation de l'archiveur
Pour archiver des dossiers et fichiers, passez-les en paramètre lors de l'exécution du script (par exemple ./archiveur.sh dossier1/ dossier5/ fichier45.txt fichierloup.mp4).
Le fichier généré est une archive (un script) nommée file.archive. Cette archive a une option -d qui permet de spécifier la destination de l'extraction, car par défaut elle extrait dans le répertoire courant (par exemple ./file.archive -d /chemin_destination).
L'arborescence et la gestion des droits des fichiers sont également conservées lors de l'extraction.
