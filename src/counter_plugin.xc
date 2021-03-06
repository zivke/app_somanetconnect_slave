#include "plugin_interface.h"
#include "counter_plugin.h"
#include <print.h>

[[combinable]]
void counter_plugin(server interface plugin_interface pi, client interface counter_service_interface csi[n], unsigned n) {
    unsigned char type = 'c';

    while(1) {
        select {
            case pi.get_type() -> unsigned char t: {
                t = type;
                break;
            }

            case pi.get_command(unsigned char command[n], unsigned n): {
                unsigned int i = command[0];
                switch (command[1]) {
                    case 's': {
                        csi[i].start();
                        break;
                    }
                    case 'p': {
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
        }
    }
}

