#include "counter_service.h"
#include <timer.h>
#include <print.h>
#include <stdint.h>
#include <stdio.h>
#include <xs1.h>

void counter_service(server interface counter_service_interface csi) {
    timer t;
    uint32_t time, start_time;
    const uint32_t period = 1000 * 250000; // 250000 timer ticks = 1ms (ReferenceFrequency="250MHz")

    int run = 0;

    t :> time;
    t :> start_time;
    while(1) {
        select {
            case csi.start(): {
                run = 1;
                printf("Counter service started successfully\n");
                break;
            }

            case csi.stop(): {
                run = 0;
                printf("Counter service stopped successfully\n");
                break;
            }

            case t when timerafter(time) :> void: {
                if (run) {
                    printf("Counter service: %d\n", (time - start_time)/period);
                }
                time += period;
                break;
            }
        }
    }
}
