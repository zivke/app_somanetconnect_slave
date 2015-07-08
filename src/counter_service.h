#pragma once

interface counter_service_interface {
    void start();
    void stop();
    int get_instance(void);
};

void counter_service(server interface counter_service_interface csi, int number);
