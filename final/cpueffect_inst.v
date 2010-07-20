  //Example instantiation for system 'cpueffect'
  cpueffect cpueffect_inst
    (
      .clk_50                    (clk_50),
      .cpu_clk                   (cpu_clk),
      .in_port_to_the_adclrc     (in_port_to_the_adclrc),
      .in_port_to_the_chorus_on  (in_port_to_the_chorus_on),
      .in_port_to_the_clk        (in_port_to_the_clk),
      .in_port_to_the_datain     (in_port_to_the_datain),
      .in_port_to_the_vibrato_on (in_port_to_the_vibrato_on),
      .out_port_from_the_dataout (out_port_from_the_dataout),
      .reset_n                   (reset_n)
    );

