create_clock -period 10.000 -waveform {0.000 5.000} [get_ports clk]
set_property PULLDOWN true [get_ports reset]
set_property PULLUP true [get_ports clk]
