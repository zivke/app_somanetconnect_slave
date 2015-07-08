#include "somanet_connect_server.h"
#include "plugin_interface.h"
#include "configuration.h"
#include <print.h>
#include <xscope.h>

struct Plugin {
    unsigned char type;
    int instance;
};

[[combinable]]
void somanet_connect_server(chanend c_host_data, client interface plugin_interface pi[n], unsigned n) {

    struct Plugin plugins[NO_OF_PLUGINS];

    for (int i = 0; i < NO_OF_PLUGINS; i++) {
        struct Plugin tmp;
        tmp.type = pi[i].get_type();
        tmp.instance = pi[i].get_instance();
        plugins[i] = tmp;
    }

    // The maximum read size is 256 bytes
    unsigned int buffer[256 / 4];
    unsigned char *char_ptr = (unsigned char*) buffer;

    xscope_connect_data_from_host(c_host_data);

    int bytes_read;

    while (1) {
        select {
            case xscope_data_from_host(c_host_data, (unsigned char *)buffer, bytes_read): {
                if (bytes_read < 1) {
                    printstrln("ERROR: Received byte array length invalid\n");
                    break;
                }

                unsafe {
                    const unsigned char * unsafe ptr = &char_ptr[0];
                    unsigned char type = *ptr;
                    unsigned int instance = *(++ptr);

                    for (int i = 0; i < n; i++) {
                        if (plugins[i].type == type) {
                            if (plugins[i].instance == instance) {
                                pi[i].get_command(++ptr);
                            }
                        }
                    }
                }
                break;
            }
        }
    }
}
