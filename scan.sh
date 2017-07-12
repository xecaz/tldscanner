#!/bin/bash
# Disclaimer! My bash is hacky, at best. Feel free to fork and merge.

for tldz in `curl -s https://data.iana.org/TLD/tlds-alpha-by-domain.txt | grep -v " Last Updated "`
do printf "\n+ TLD: "$tldz"\n"
for hostz in `dig NS $tldz. @k.root-servers.net. | awk '$4 == "A"' |awk '{print $1}' | sed 's/.$//g'`
do echo "|- "$hostz
host $hostz | grep " not found" >> notfound.txt
dom=`echo $hostz| rev | cut -d. -f1,2 | rev`
whois $dom | grep "   Expiration Date:" | sed 's/   /| \  ^\~ /g'
done
done
