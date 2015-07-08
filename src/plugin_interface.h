#pragma once

interface plugin_interface {
    unsigned char get_type();
    int get_instance();
    void get_command(const unsigned char * unsafe p);
};
