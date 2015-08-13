#pragma once

interface counter_service_interface {
    int get_probe_0_int_value();

    int get_probe_1_int_value();

    void start();

    void stop();
};

void counter_service(server interface counter_service_interface csi);
