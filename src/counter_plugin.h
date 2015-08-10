#pragma once

#include "plugin_interface.h"
#include "counter_service.h"
#include <system_config.h>

[[combinable]]
void counter_plugin(server interface plugin_interface pi, client interface counter_service_interface csi[NO_OF_COUNTER_SERVICES]);
