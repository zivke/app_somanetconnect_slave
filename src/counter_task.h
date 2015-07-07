#pragma once

interface task_control_interface {
    void start();
    void stop();
};

void counter_task(server interface task_control_interface tci, int number);
