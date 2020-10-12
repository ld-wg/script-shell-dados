#!/bin/bash

tar -xvf evasao2014-18.tar.gz
cd evasao

echo -n -e "\n"
echo -e "[ITEM 3]\n";
for ((i=4;i<=8;i++)) ; do 
cat evasao-201$i.csv >> evasao.txt
done
cat evasao.txt | cut -d , -f1 | sed '/FORMA_EVASAO/d' | sort | uniq -c | sort -n -r > evasao_temp.txt
awk '{print "Tipo: " substr($0,index($0,$2))" | Alunos: " $1}' evasao_temp.txt

echo -n -e "\n" 
echo -e "[ITEM 4]\n";
for ((i=4;i<=8;i++)) ; do 
cat evasao-201$i.csv | cut -d , -f4 | sed '/ANO_INGRESSO/d' > evasao_temp.txt; 
j=$(cat evasao_temp.txt);
for k in ${j[@]} ; do 
s=$((2010 + $i - $k)); 
echo $s >> n_evasao.txt; 
done;
done;
cat n_evasao.txt | sort -n | uniq -c > qnt_anos.txt
rm n_evasao.txt
awk '{print "Alunos: " $1 "| Anos: " $2}' qnt_anos.txt

echo -n -e "\n"
echo -e "[ITEM 5]\n";
for ((i=4;i<=8;i++)) ; do 
cat evasao-201$i.csv | cut -d , -f2 | sed '/PERIODO/d' > evasao_temp.txt
a=$(cat evasao_temp.txt | grep 1| wc -l);
b=$(cat evasao_temp.txt | grep 2| wc -l);
if (( $a < $b )); then
c=$(bc <<< "scale=3;$b/($a + $b)*100")
echo "201$i semestre 2 - $c%"
else
c=$(bc <<< "scale=3;$a/($a + $b)*100")
echo "201$i semestre 1 - $c%"
fi
done

echo -n -e "\n"
echo -e "[ITEM 6]\n";
cat evasao.txt | cut -d , -f5 | sed '/SEXO/d' > evasao_temp.txt;
a=$(cat evasao_temp.txt | grep F | wc -l);
b=$(cat evasao_temp.txt | grep M | wc -l);
c=$(bc <<< "scale=3;$a/($a + $b)*100");
echo -e "SEXO  MÉDIA EVASÕES (5 anos)\nF  $c%";
c=$(bc <<< "scale=3;$b/($a + $b)*100");
echo "M  $c%";

#Item7
for ((i=4;i<=8;i++)) ; do
cat evasao-201$i.csv | cut -d , -f2 | sed '/PERIODO/d' > evasao_temp.txt
a=$(cat evasao_temp.txt | grep 1| wc -l);
b=$(cat evasao_temp.txt | grep 2| wc -l);
x=201$i
echo "$x $a" >> evasoes-ano.dat
echo "$x.5 $b" >> evasoes-ano.dat
done
gnuplot <<- EOF
set terminal png size 1280,720
set output "evasoes-ano.png"
set title "Evasoes por ano"
plot "evasoes-ano.dat" u 1:2 smooth csplines
EOF

#Item8
rm evasao_temp.txt
for ((i=4;i<=8;i++)) ; do
cat evasao-201$i.csv | cut -d , -f3 | sed '/FORMA_INGRESSO/d' | sort | uniq >> evasao_temp.txt
done
v=$(cat evasao_temp.txt | sort | uniq | sed 's/Aluno//g' | sed 's/Curso Superior//g' | sed 's/Convênio//g' | sed 's/Acadêmica//g' | sed 's/Processo//g' | sed 's/Transferência//g')

echo "# $v" | xargs -d"\n" > evasoes-forma.dat

for ((i=4;i<=8;i++)) ; do
echo -n -e "201$i " >> evasoes-forma.dat
for k in $v; do
x=$(cat evasao-201$i.csv | cut -d , -f3 | sed '/FORMA_INGRESSO/d' | grep $k | wc -l)
echo -n -e "$x " >> evasoes-forma.dat
done
echo -n -e "\n" >> evasoes-forma.dat
done
gnuplot <<- EOF
	set terminal png size 1280,720 
	set output "evasoes-forma.png"
	set title "Formas de Ingresso"
	set yrange [0:120]
	set style line 2 lc rgb 'black' lt 1 lw 1
	set style data histogram
	set style histogram cluster gap 1
	set style fill pattern border -1
	set boxwidth 0.9
	set xtics format ""
	set grid ytics
	set ytic 10
	plot "evasoes-forma.dat" using 2:xtic(1) title "Aluno Intercambio",\
	'' using 3 title "Aproveitamento",\
	'' using 4 title "AUGM",\
	'' using 5 title "Pec-G",\
	'' using 6 title "Mobilidade",\
	'' using 7 title "Seletivo/ENEM",\
	'' using 8 title "Reopção",\
	'' using 9 title "Ex-Ofício",\
	'' using 10 title "Provar",\
	'' using 11 title "Vestibular"
EOF

rm qnt_anos.txt
rm evasao.txt
rm evasao_temp.txt
for ((i=4;i<=8;i++)) ; do rm evasao-201$i.csv; done
