#include <CORE_C22-rev-a.inc>

#include "somanet_connect_server.h"
#include "counter_service.h"
#include <system_config.h>

int main(void) {
    interface plugin_interface pi[NO_OF_PLUGINS];
    interface counter_service_interface csi[NO_OF_COUNTER_SERVICES];

    par
    {
        on tile[COM_TILE]:
        {
            [[combine]]
            par
            {
                somanet_connect_server(pi);
                counter_plugin(pi[0], csi);
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
