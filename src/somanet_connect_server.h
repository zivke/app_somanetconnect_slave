#pragma once

#include "counter_plugin.h"
#include <system_config.h>

[[combinable]]
void somanet_connect_server(chanend c_host_data, client interface plugin_interface sci[NO_OF_PLUGINS]);
