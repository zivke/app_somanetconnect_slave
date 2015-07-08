#pragma once

interface task_control_interface {
    void start();
    void stop();
};

void counter_service(server interface task_control_interface tci, int number);
