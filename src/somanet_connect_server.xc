#include "somanet_connect_server.h"
#include "plugin_interface.h"
#include <print.h>
#include <string.h>
#include <stdint.h>
#include <xs1.h>

[[combinable]]
void somanet_connect_server(client interface plugin_interface pi[NO_OF_PLUGINS]) {
    timer t;
    uint32_t time;

    t :> time;
    while (1) {
        select {
            case t when timerafter(time) :> void: {
                for (int i = 0; i < NO_OF_PLUGINS; i++) {
                    if (pi[i].get_type() == COUNTER_PLUGIN_TYPE) {
                        unsigned char command[256] = {'\x00', COUNTER_PLUGIN_START};
                        pi[i].get_command(command, 2);
                    }
                }

                delay_milliseconds(5000);

                for (int i = 0; i < NO_OF_PLUGINS; i++) {
                    if (pi[i].get_type() == COUNTER_PLUGIN_TYPE) {
                        unsigned char command[256] = {'\x00', COUNTER_PLUGIN_STOP};
                        pi[i].get_command(command, 2);
                    }
                }

                break;
            }
        }
    }
}
