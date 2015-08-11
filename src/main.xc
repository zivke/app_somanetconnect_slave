#include <CORE_C22-rev-a.inc>

#include <xscope.h>
#include "somanet_connect_server.h"
#include "counter_service.h"
#include <system_config.h>

void xscope_user_init(void) {
   xscope_register(0);
   xscope_register(1, XSCOPE_CONTINUOUS, "counter", XSCOPE_INT, "n/a");
   xscope_config_io(XSCOPE_IO_BASIC);
}

int main(void) {
    chan c_host_data;
    interface plugin_interface pi[NO_OF_PLUGINS];
    interface counter_service_interface csi[NO_OF_COUNTER_SERVICES];

    par
    {
        xscope_host_data(c_host_data);

        on tile[COM_TILE]:
        {
            [[combine]]
            par
            {
                somanet_connect_server(c_host_data, pi);
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
