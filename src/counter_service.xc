#include "counter_service.h"
#include <timer.h>
#include <print.h>
#include <stdint.h>
#include <stdio.h>
#include <xs1.h>

void counter_service(server interface counter_service_interface csi) {
    timer t;
    uint64_t time, start_time;
    const uint32_t period = 1000 * 250000; // 250000 timer ticks = 1ms (ReferenceFrequency="250MHz")

    int run = 0;

    csi_event_type_t event_type;
    int probe_int_value;

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

            case csi.get_event() -> csi_event_type_t t: {
                t = event_type;
                break;
            }

            case csi.get_int_probe_value() -> int x: {
                x = probe_int_value;
                break;
            }

            case t when timerafter(time) :> void: {
                if (run) {
                    int current_time = (time - start_time)/period;

                    // Event
                    event_type = E_PROBE_INT_VALUE;
                    probe_int_value = current_time;
                    csi.event();
                }
                time += period;

                break;
            }
        }
    }
}
