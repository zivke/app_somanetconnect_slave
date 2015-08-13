#include "plugin_interface.h"
#include "counter_plugin.h"
#include <print.h>
#include <system_config.h>
#include <stdint.h>
#include <xs1.h>

[[combinable]]
void counter_plugin(server interface plugin_interface pi, client interface counter_service_interface csi[NO_OF_COUNTER_SERVICES]) {
    unsigned char type = COUNTER_PLUGIN_TYPE;

    timer t;
    uint64_t time;
    const uint64_t period = 250000; // 250000 timer ticks = 1ms (ReferenceFrequency="250MHz")

    int running = 0;

    t :> time;

    while(1) {
        select {
            case pi.get_type() -> unsigned char t: {
                t = type;
                break;
            }

            case pi.get_command(unsigned char command[n], unsigned n): {
                unsigned int i = command[0];
                switch (command[1]) {
                    case COUNTER_PLUGIN_START: {
                        running = 1;
                        csi[i].start();
                        break;
                    }
                    case COUNTER_PLUGIN_STOP: {
                        running = 0;
                        csi[i].stop();
                        break;
                    }
                    default: {
                        printstrln("Unknown command!");
                        break;
                    }
                }
                break;
            }

            case t when timerafter(time) :> void: {
                if(running) {
                    for (int i = 0; i < NO_OF_COUNTER_SERVICES; i++) {
                        printintln(csi[i].get_probe_0_int_value());
                        printintln(csi[i].get_probe_1_int_value());
                    }
                }
                time += period;
                break;
            }
        }
    }
}

