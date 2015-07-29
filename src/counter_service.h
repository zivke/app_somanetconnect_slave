#pragma once

typedef enum csi_event_type_t
{
  E_PROBE_INT_VALUE
} csi_event_type_t;

interface counter_service_interface {
    [[notification]] slave void event();

    [[clears_notification]] csi_event_type_t get_event();

    int get_int_probe_value();

    void start();

    void stop();
};

void counter_service(server interface counter_service_interface csi);
