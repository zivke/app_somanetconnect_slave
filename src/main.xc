#include <CORE_C22-rev-a.inc>

#define USE_XSCOPE

#include "somanet_connect_server.h"

int main(void) {
    chan c_host_data;
    interface somanet_connect_interface sci;

    par
    {
        xscope_host_data(c_host_data);

        on tile[COM_TILE]:
        {
            [[combine]]
            par
            {
                somanet_connect_server(c_host_data, sci);
                app_plugin(sci);
            }
        }
    }

    return 0;
}
