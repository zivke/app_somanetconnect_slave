#pragma once

interface somanet_connect_interface {
    void work();
    void sleep();
};

[[combinable]]
void app_plugin(server interface somanet_connect_interface sci);
