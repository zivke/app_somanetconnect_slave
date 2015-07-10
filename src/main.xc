#include <CORE_C22-rev-a.inc>

#define USE_XSCOPE
#define NO_OF_PLUGINS 1
#define NO_OF_SERVICES 2

#include "somanet_connect_server.h"
#include "counter_service.h"

int main(void) {
    chan c_host_data;
    interface plugin_interface pi[NO_OF_PLUGINS];
    interface counter_service_interface csi[NO_OF_SERVICES];

    par
    {
        xscope_host_data(c_host_data);

        on tile[COM_TILE]:
        {
            [[combine]]
            par
            {
                somanet_connect_server(c_host_data, pi, NO_OF_PLUGINS);
                counter_plugin(pi[0], csi, NO_OF_SERVICES);
            }
        }

        on tile[IFM_TILE]:
        {
            par {
                counter_service(csi[0]);
                counter_service(csi[1]);
            }
        }
    }

    return 0;
}
