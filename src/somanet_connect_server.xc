#include "somanet_connect_server.h"
#include "plugin_interface.h"
#include <print.h>
#include <string.h>
#include <stdint.h>
#include <xs1.h>

[[combinable]]
void somanet_connect_server(chanend c_host_data, client interface plugin_interface pi[NO_OF_PLUGINS]) {
    const uint32_t period = 1000 * 250000;

    timer t1, t2;
    uint32_t time1, time2;

    t1 :> time1;
    t2 :> time2;
    while (1) {
        select {
            case t1 when timerafter(time1 + 5 * period) :> void: {
                for (int i = 0; i < NO_OF_PLUGINS; i++) {
                    if (pi[i].get_type() == 'c') {
                        unsigned char command[256] = {'s'};
                        pi[i].get_command(command, 1);
                    }
                }
                break;
            }
            case t2 when timerafter(time2 + 10 * period) :> void: {
                for (int i = 0; i < NO_OF_PLUGINS; i++) {
                    if (pi[i].get_type() == 'c') {
                        unsigned char command[256] = {'p'};
                        pi[i].get_command(command, 1);
                    }
                }
                break;
            }
        }
    }
}
