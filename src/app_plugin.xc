#include "app_plugin.h"
#include <print.h>

[[combinable]]
void app_plugin(server interface somanet_connect_interface sci) {
    while(1) {
        select {
            case sci.work(): {
                printstrln("Work! Work! Work!");
                break;
            }

            case sci.sleep(): {
                printstrln("Zzzzzzzzzz...");
                break;
            }
        }
    }
}

