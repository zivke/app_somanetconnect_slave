#include "counter_service.h"
#include <timer.h>
#include <print.h>
#include <stdint.h>
#include <stdio.h>
#include <xs1.h>

void counter_service(server interface counter_service_interface csi, int number) {
    timer t;
    uint32_t time, start_time;
    const uint32_t period = 1000 * 100000; // 100000 timer ticks = 1ms

    int run = 0;

    t :> time;
    t :> start_time;
    while(1) {
        select {
            case csi.get_instance() -> int instance: {
                instance = number;
                break;
            }

            case csi.start(): {
                run = 1;
                printf("Task number %d started successfully\n", number);
                break;
            }

            case csi.stop(): {
                run = 0;
                printf("Task number %d stoped successfully\n", number);
                break;
            }

            case t when timerafter(time) :> void: {
                if (run) {
                    printf("Task number %d: %d\n", number, (time - start_time)/period);
                }
                time += period;
                break;
            }
        }
    }
}
