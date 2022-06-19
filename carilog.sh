#!/bin/ksh

# Your script goes here. All lines starting with # 
# are treated as comments.
echo "MASUKAN HARI (SUN|MON|TUE|WED|THU|FRI|SAT)"
read DAY

echo "MASUKAN TANGGAL (01-31)"
read TGL

echo "MASUKAN BULAN (01-12)"
read BLN

echo "MASUKAN TAHUN (202?)"
read THN

echo "Enter B1 name : "
read B1

echo "Server adm aktif ?? (adm1jkt | adm2jkt"
read ADM

echo "Searching Log "$B1" on $TGL-$BLN-$THN\n"

DIR1=/home/spsy/carilog/$TGL$BLN$THN/
if [ -d "$DIR1" ] ; then 
	echo "Searching file in path ${DIR1}"
	rm $PWD/HASIL/${B1}_$TGL$BLN$THN.txt
	for file in $DIR1*  
	do
		echo "Processing file ${file}"
		cat  "$file" | grep "\<${B1}\>" >>  $PWD/HASIL/${B1}_$TGL$BLN$THN.txt
	done
	rcp $PWD/HASIL/${B1}_$TGL$BLN$THN.txt $ADM:/home/spsy/Hasil53/
	echo "Saving file to $PWD/HASIL/"$B1"_$TGL$BLN$THN.txt and $ADM:/home/spsy/Hasil53/"$B1"_$TGL$BLN$THN.txt"
	exit 0
else 
	echo "Processing log from $ADM, please wait !!"
	mkdir ${TGL}${BLN}${THN}
	rcp $ADM:/home/Offline/arch/MESSAGES_SQL_${DAY}_${THN}${BLN}${TGL}_* /home/spsy/carilog/$TGL$BLN$THN/
	if [ $? -ne 0 ] ; then
		echo "Log kosong pada $TGL-$BLN-$THN"
		exit 1
	fi
	echo "Searching file in path ${DIR1}"
	rm $PWD/HASIL/$B1_$TGL$BLN$THN.txt
	for file in $DIR1*  
	do
		echo "Processing file ${file}"
		cat  "$file" | grep "\<${B1}\>" >> $PWD/HASIL/${B1}_$TGL$BLN$THN.txt
	done
	rcp $PWD/HASIL/${B1}_$TGL$BLN$THN.txt $ADM:/home/spsy/Hasil53/
	echo "Saving file to $PWD/HASIL/"$B1"_$TGL$BLN$THN.txt and $ADM:/home/spsy/Hasil53/"$B1"_$TGL$BLN$THN.txt"
	exit 0
fi





