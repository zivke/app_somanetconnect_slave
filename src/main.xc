#include <CORE_C22-rev-a.inc>

#define USE_XSCOPE

#include "somanet_connect_server.h"
#include "counter_service.h"

int main(void) {
    chan c_host_data;
    interface somanet_connect_interface sci[3];
    interface task_control_interface tci[3];

    par
    {
        xscope_host_data(c_host_data);

        on tile[COM_TILE]:
        {
            [[combine]]
            par
            {
                somanet_connect_server(c_host_data, sci, 3);
                counter_plugin(sci[1], tci[1]);
                counter_plugin(sci[2], tci[2]);
            }
        }

        on tile[IFM_TILE]:
        {
            par {
                counter_service(tci[1], 1);
                counter_service(tci[2], 2);
            }
        }
    }

    return 0;
}
