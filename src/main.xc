#include <CORE_C22-rev-a.inc>

#define USE_XSCOPE

#include "somanet_connect_server.h"
#include "counter_service.h"

int main(void) {
    chan c_host_data;
    interface somanet_connect_interface sci[2];
    interface task_control_interface tci[2];

    par
    {
        xscope_host_data(c_host_data);

        on tile[COM_TILE]:
        {
            [[combine]]
            par
            {
                somanet_connect_server(c_host_data, sci, 2);
                counter_plugin(sci[0], tci[0]);
                counter_plugin(sci[1], tci[1]);
            }
        }

        on tile[IFM_TILE]:
        {
            par {
                counter_service(tci[0], 0);
                counter_service(tci[1], 1);
            }
        }
    }

    return 0;
}
