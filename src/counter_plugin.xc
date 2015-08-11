#include "plugin_interface.h"
#include "counter_plugin.h"
#include <print.h>
#include <xscope.h>
#include <system_config.h>

[[combinable]]
void counter_plugin(server interface plugin_interface pi, client interface counter_service_interface csi[NO_OF_COUNTER_SERVICES]) {
    unsigned char type = COUNTER_PLUGIN_TYPE;

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
                        csi[i].start();
                        break;
                    }
                    case COUNTER_PLUGIN_STOP: {
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

            case csi[int i].event(): {
                switch(csi[i].get_event()) {
                    case E_PROBE_INT_VALUE: {
                        printintln(csi[i].get_int_probe_value());
                        break;
                    }
                    default: {
                        printstrln("Unknown event!");
                        break;
                    }
                }
                break;
            }
        }
    }
}

