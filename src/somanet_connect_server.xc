#include "somanet_connect_server.h"
#include <print.h>
#include <xscope.h>

[[combinable]]
void somanet_connect_server(chanend c_host_data, client interface somanet_connect_interface sci) {

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
                    if (*ptr == 'w') {
                        sci.work();
                    } else {
                        sci.sleep();
                    }
                }
                break;
            }
        }
    }
}
