#pragma once
#include "counter_task.h"

interface somanet_connect_interface {
    void get_command(const unsigned char * unsafe p);
};

[[combinable]]
void counter_plugin(server interface somanet_connect_interface sci, client interface task_control_interface tci);
