#include "counter_service.h"
#include <timer.h>
#include <print.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <xs1.h>

void counter_service(server interface counter_service_interface csi) {
    timer t;
    uint64_t time;
    const uint32_t period = 1000 * 250000; // 250000 timer ticks = 1ms (ReferenceFrequency="250MHz")

    int running = 0;

    int value = 0;
    int max_value = 1000;

    int probe_0_int_value = 0;
    int probe_1_int_value = 0;

    t :> time;
    srand(time);
    while(1) {
        select {
            case csi.start(): {
                running = 1;
                printf("Counter service started successfully\n");
                break;
            }

            case csi.stop(): {
                running = 0;
                printf("Counter service stopped successfully\n");
                break;
            }

            case csi.get_probe_0_int_value() -> int probe_0_value: {
                probe_0_value = probe_0_int_value;
                break;
            }

            case csi.get_probe_1_int_value() -> int probe_1_value: {
                probe_1_value = probe_1_int_value;
                break;
            }

            case t when timerafter(time) :> void: {
                if (running) {
                    probe_0_int_value = value;
                    probe_1_int_value = 1000 - value;

                    value++;

                    if (value == max_value) {
                        value = rand() % 300;
                        max_value = rand() % 300 + 500;
                    }
                }
                time += period;

                break;
            }
        }
    }
}
