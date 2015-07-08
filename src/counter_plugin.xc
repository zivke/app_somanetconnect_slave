#include "plugin_interface.h"
#include "counter_plugin.h"
#include <print.h>

[[combinable]]
void counter_plugin(server interface plugin_interface pi, client interface counter_service_interface csi) {
    while(1) {
        select {
            case pi.get_command(const unsigned char * unsafe p): {
                char ch;
                unsafe {
                    ch = *p;
                }
                switch (ch) {
                    case 's': {
                        csi.start();
                        break;
                    }
                    case 'p': {
                        csi.stop();
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

