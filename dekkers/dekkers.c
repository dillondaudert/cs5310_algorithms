/* Date: 12/8/2017
 * Class: CS5310
 * Assignment 6
 * Author: Dillon Daudert
 */

#define _DEFAULT_SOURCE

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#define MAX_CHARS 1200

/* global variables */
volatile bool wants_to_enter[2] = {false, false};
volatile int turn = 0;
volatile int count = 0;
char printchar[2] = {'a', 'b'};

void *t_func(void *tid)
{
    long id = (long) tid;
    long other_id = id == 0 ? 1 : 0;

    while (count < MAX_CHARS) {

        /* thread function */
        wants_to_enter[id] = true;
        while(wants_to_enter[other_id]) {
            /* while the other thread wants to enter crit. section */
            if (turn != id) {
                wants_to_enter[id] = false;
                while (turn != id) {
                    /* busy wait */
                }
                wants_to_enter[id] = true;
            }
        }

        /* critical section ~~~~~~~~~~~~~~~ */
        if (count % 30 == 0) {
            fprintf(stdout, "%c", '\n');
        } else {
            fprintf(stdout, "%c", printchar[id]);
            fflush(stdout);
        }
        count++;

        turn = other_id;
        wants_to_enter[id] = false;
        /* end critical section ~~~~~~~~~~~ */
        
        /* usleep to slow down the execution */
//        usleep(10000);
    }
    
    return NULL;
}

int main(int argc, char **argv)
{
    /* create the two threads */
    pthread_t threads[2];
    long id;
    int err;
    void *status;
    for(id = 0; id < 2; id++){
        err = pthread_create(&threads[id], NULL, t_func, (void *)id);
        if (err) {
            printf("pthread_create error! %d\n", err);
            exit(-1);
        }
    }

    /* join the threads */
    for(id = 0; id < 2; id++){
        err = pthread_join(threads[id], &status);
        if (err) {
            printf("pthread_join error! %d\n", err);
            exit(-1);
        }
    }

    pthread_exit(NULL);
}
