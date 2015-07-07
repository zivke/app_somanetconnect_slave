#include "counter_plugin.h"
#include <print.h>

[[combinable]]
void counter_plugin(server interface somanet_connect_interface sci, client interface task_control_interface tci) {
    while(1) {
        select {
            case sci.get_command(const unsigned char * unsafe p): {
                char ch;
                unsafe {
                    ch = *p;
                }
                switch (ch) {
                    case 's': {
                        tci.start();
                        break;
                    }
                    case 'p': {
                        tci.stop();
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

