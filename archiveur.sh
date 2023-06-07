#!/bin/bash
#ce script permet de créer un script qui permet de cree une archive de tous les fichiers et dossiers passés en paramètre
if [ $# -lt 1 ]
then
	echo "Err Veuilez passé au moins un fichier"
	exit 1
fi

cat <<TAG_FIN >file.archive
#!/bin/bash

if [ \$# -gt 0 ]
then
	if [ \$1 != "-d" ]
	then
		echo "Err de fonction: [ -d /rep ]pour dire où le desarchivage doit se faire"
		exit 1
	else
		if [ ! -e \$2 ]
		then
			mkdir \$2
		fi
		cd \$2
	fi
fi

TAG_FIN

while [ $# -ne 0 ] 
do
	elm=$1
	shift
	if [ -d $elm ] # c'est un doissier
	then
		#verifie si ne fini pas par un / car ca cause des probleme
		elm=`echo $elm | sed -E 's/(.*)\/$/\1/'`
		echo "mkdir $elm"
		echo ""
		droit=`ls -ld $elm | cut -d ' ' -f1 | sed -E 's/^.(.+)$/\1/'`
		du=`echo $droit | sed -E 's/^(.{3}).{3}.{3}$/\1/'`
		dg=`echo $droit | sed -E 's/^.{3}(.{3}).{3}$/\1/'`
		da=`echo $droit | sed -E 's/^.{3}.{3}(.{3})$/\1/'`
		du=`echo $du | tr 'rwx-' '4210' | sed -E 's/^([0-4])([0-4])([0-4])/\1 + \2 + \3/'`
		dg=`echo $dg | tr 'rwx-' '4210' | sed -E 's/^([0-4])([0-4])([0-4])/\1 + \2 + \3/'`
		da=`echo $da | tr 'rwx-' '4210' | sed -E 's/^([0-4])([0-4])([0-4])/\1 + \2 + \3/'`
		du=`expr $du`
		dg=`expr $dg`
		da=`expr $da`
		echo "chmod " $du$dg$da $elm
		for newel in `ls $elm | sed -E "s|^|$elm/|"`
		do
			set	-- $* $newel
		done
	fi
	if [ -f $elm ] # si c'est un fichier
	then
		echo "uudecode << TAG_FIN "
		uuencode -m $elm < $elm 
		echo "TAG_FIN"
		droit=`ls -l $elm | cut -d ' ' -f1 | sed -E 's/^.(.+)$/\1/'`
		du=`echo $droit | sed -E 's/^(.{3}).{3}.{3}$/\1/'`
		dg=`echo $droit | sed -E 's/^.{3}(.{3}).{3}$/\1/'`
		da=`echo $droit | sed -E 's/^.{3}.{3}(.{3})$/\1/'`
		du=`echo $du | tr 'rwx-' '4210' | sed -E 's/^([0-4])([0-4])([0-4])/\1 + \2 + \3/'`
		dg=`echo $dg | tr 'rwx-' '4210' | sed -E 's/^([0-4])([0-4])([0-4])/\1 + \2 + \3/'`
		da=`echo $da | tr 'rwx-' '4210' | sed -E 's/^([0-4])([0-4])([0-4])/\1 + \2 + \3/'`
		du=`expr $du`
		dg=`expr $dg`
		da=`expr $da`
		echo "chmod " $du$dg$da $elm
	fi
	
done >> file.archive
chmod a+x file.archive
