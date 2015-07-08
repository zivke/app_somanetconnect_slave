#pragma once

interface counter_service_interface {
    void start();
    void stop();
};

void counter_service(server interface counter_service_interface csi, int number);
