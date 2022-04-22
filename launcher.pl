#!/usr/bin/perl
#####################################
 # Fecha: Abril de 2022
 # Autora: Ángela Viviana Quintero Hernández
 # Materia: Parallel Computing
 # Tema: Diseño de experimentos, automatización 
 # de ejecusión (promedio y desviación)
#####################################

$PATH = `pwd`;# el signo pesos ($) para las variables
chomp($PATH);#chomp para que no salte de línea
# Una variable que represente la cantidad de repeticiones
$N = 36;

system "make clean"; # clean the previous compilation
system "make all"; # compile the program

$machineFile = "$PATH/machine.txt"; # Archivo de la máquina
open(MACHINE, '<', $machineFile) or die $!; # Se abre para ontener el nombre de la máquina
$machineName="";
while(<MACHINE>){
   $machineName= $_;
}
close($machineFile);

# Crear un vector de ejecutables y se hace con el simbolo @
chomp($machineName);
@Executables=("Algoritmo_1","Algoritmo_2","Algoritmo_3");
@Dimension=("100","200","400","800","1600","3200");
@Threads=("1","2","4","8");
$File="results/results-$machineName.csv";
open(FILE,">>",$File) or die "Could not open file $File";
print FILE "Node,NumThreads,Load,Algorithm,Time\n";
close($File);
foreach $size (@Dimension){
	foreach $exe (@Executables){
		open(FILE,">>",$File) or die "Could not open file $File";
		#print"$File \n";
		foreach $thread (@Threads){
			for($i=0;$i<$N;$i++){
				print FILE "$machineName,$thread,$size,$exe,";
				system "$PATH/$exe $size $thread >> $File";
				print FILE "\n";
			}
		}
			
		close($File);
	}
	
}
