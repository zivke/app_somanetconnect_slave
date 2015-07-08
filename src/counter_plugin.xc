#include "plugin_interface.h"
#include "counter_plugin.h"
#include <print.h>

[[combinable]]
void counter_plugin(server interface plugin_interface pi, client interface counter_service_interface csi) {
    unsigned char type = 'c';

    while(1) {
        select {
            case pi.get_type() -> unsigned char t: {
                t = type;
                break;
            }

            case pi.get_instance() -> int instance: {
                instance = csi.get_instance();
                break;
            }

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

