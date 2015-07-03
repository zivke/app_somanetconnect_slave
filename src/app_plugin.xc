#include "app_plugin.h"
#include <print.h>

[[combinable]]
void app_plugin(server interface somanet_connect_interface sci) {
    while(1) {
        select {
            case sci.work(): {
                printstr("Work! Work! Work!\n");
                break;
            }

            case sci.sleep(): {
                printstr("Zzzzzzzzzz...\n");
                break;
            }
        }
    }
}

