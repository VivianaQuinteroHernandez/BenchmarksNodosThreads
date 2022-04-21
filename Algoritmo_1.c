/* 	
* Universidad Sergio Arboleda
* Date: 2022-03-30
* Author: ÁNgela Viviana Quintero Hernández
* Subject: Parallel and Distributed Computing.
* Topic: Posix implemetation (Library)
* Description: Application for matrix multiplication
  with the classical algorithm (rows x columns) using
  global variables. Also, using the following functions:
    1. Creation of double pointer variables for matrices
    2. Memory reserve for double pointer matrices
    3. Init matrix
    4. Function for the matrix's product:
        4.1.1 The matrix A is divide and those portions
        will be sent to an individual thread
        4.1.2 The matrix's size will be sent in the
        execution.
    5. Matrix's size always squared (NxN)
    6.  Print matrix with double pointer.
*
*/

/*Interfaces*/
#include "modulo.h"
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/time.h>
#include <omp.h>

/* Se crea una variable con un valor alto para reservar memoria*/
#define DATA_SZ (1024*1024*64*3)

/* Se reserva el espacio de memoria según el valor */
static double MEM_CHUNK[DATA_SZ];

/* Se implementa paso a paso benchmark Multiplicaión de Matrices
	Algoritmo clásico ( filas x columnas) de matrices
	de igual dimensión*/
int main(int argc, char *argv[])
{
    double *Ma, *Mb, *Mc;
    int N, Nthreads;
    
    if (argc != 3)
    {
        printf("./MMPosix <matrix size> <# of threads>\n");
        return -1;
    }

    /*Inicializar las variable globales*/
    N = atof(argv[1]);        /* Tamaño de la matriz*/
    Nthreads = atof(argv[2]); /* Nùmero de hilos*/
    if (Nthreads > omp_get_max_threads())
    {
        printf("El número de hilos debe ser menor o igual a %d", omp_get_max_threads());
        return -1;
    }

    /* Apuntamos los vectores (creación) al espacio de memoeria reservado, con dimension NxN*/
    Ma = MEM_CHUNK;
	Mb = Ma + N*N;
	Mc = Mb + N*N;
    initMatrix(N,Ma, Mb, Mc);

    printMatrix(N,Ma);
    printMatrix(N,Mb);
    SampleStart();
    MM1cOMP(Nthreads, N, Ma, Mb, Mc);
    SampleEnd();
    /* free(Ma);
    // free(Mb);
    // free(Mc);*/
    printMatrix(N,Mc);
    return EXIT_SUCCESS;
}
