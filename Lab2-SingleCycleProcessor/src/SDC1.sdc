# Create the PLL Output clocks automatically
derive_pll_clocks
# Create a base clock for the PLL input clock
create_clock -name clk -period 10 [get_ports GClock]

