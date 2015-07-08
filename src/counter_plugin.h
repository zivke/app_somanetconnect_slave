#pragma once
#include "plugin_interface.h"
#include "counter_service.h"

[[combinable]]
void counter_plugin(server interface somanet_connect_interface sci, client interface task_control_interface tci);
