#!/bin/sh

#In file name replace space with underscore.
for i in *' '*; do   mv "$i" `echo $i | sed -e 's/ /_/g'`; done

#Merge .ts video file with equivalent .aac audio file and generate mp4 file.
for vfile in *.ts ;
do
	echo "[*] For ### $vfile"
	fname=$( echo "$vfile" | cut -d '.' -f 1)
	echo "[+] Extracted filename: $fname"
	afile="${fname}_audio.aac"
	echo "[+] Checking for Audio File: $afile"
	if [ -e "$afile" ];
	then
		#Convert files
		echo "[+] Converting $fname..."
		outputfile=${fname}.mp4
		echo "[+] Output file will be: $outputfile"
		ffmpeg -i $afile -i $vfile -c copy ${outputfile} > /dev/null 2>&1
		echo "[#] SUCCESS"
	else
		echo "[!] File not found: ${afile}"
		echo "[#] FAILED"
	fi
done

