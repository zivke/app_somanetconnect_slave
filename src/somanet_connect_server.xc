#include "somanet_connect_server.h"
#include "plugin_interface.h"
#include <print.h>
#include <xscope.h>
#include <string.h>

[[combinable]]
void somanet_connect_server(chanend c_host_data, client interface plugin_interface pi[NO_OF_PLUGINS]) {

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

                    for (int i = 0; i < NO_OF_PLUGINS; i++) {
                        if (pi[i].get_type() == type) {
                            unsigned char command[256];
                            memcpy(command, ++ptr, (bytes_read - 1)*sizeof(unsigned char));
                            pi[i].get_command(command, bytes_read - 1);
                        }
                    }
                }
                break;
            }
        }
    }
}
