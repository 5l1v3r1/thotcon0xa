#!/bin/bash
hupath="/opt/utils/hashcat-utils/src"
hcpath="/opt/cracken2/hashcat"
workpath="/opt/evilmog/tmp"

echo "[+] Sorting Potfile"
cut -d: -f2- < $hcpath/hashcat.potfile | sort -u > $workpath/cand.lst
for i in {1..8}; do
  for s in $( eval echo {0..$i} ); do
    echo "[+] s: $s i:$i"
    $hupath/cutb.bin $s $i < $workpath/cand.lst | sort -u > $workpath/$i-first-seq.txt
  done
done
for i in {1..8}; do
  echo "[+] rev: $i"
  $hupath/cutb.bin -$i < $workpath/cand.lst | sort -u > $workpath/$i-last-seq.txt
done

echo "[+] final cat"
cat $workpath/*-first-seq.txt $workpath/*-last-seq.txt | sort -u > $workpath/cand.seq.cutb
echo "[+] final sort"
$hupath/expander.bin < $workpath/cand.seq.cutb | sort -u > $workpath/cand.seq.cutb.exp
