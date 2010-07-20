//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2010 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module adclrc_s1_arbitrator (
                              // inputs:
                               adclrc_s1_readdata,
                               clk,
                               cpu_0_data_master_address_to_slave,
                               cpu_0_data_master_latency_counter,
                               cpu_0_data_master_read,
                               cpu_0_data_master_write,
                               reset_n,

                              // outputs:
                               adclrc_s1_address,
                               adclrc_s1_readdata_from_sa,
                               adclrc_s1_reset_n,
                               cpu_0_data_master_granted_adclrc_s1,
                               cpu_0_data_master_qualified_request_adclrc_s1,
                               cpu_0_data_master_read_data_valid_adclrc_s1,
                               cpu_0_data_master_requests_adclrc_s1,
                               d1_adclrc_s1_end_xfer
                            )
;

  output  [  1: 0] adclrc_s1_address;
  output           adclrc_s1_readdata_from_sa;
  output           adclrc_s1_reset_n;
  output           cpu_0_data_master_granted_adclrc_s1;
  output           cpu_0_data_master_qualified_request_adclrc_s1;
  output           cpu_0_data_master_read_data_valid_adclrc_s1;
  output           cpu_0_data_master_requests_adclrc_s1;
  output           d1_adclrc_s1_end_xfer;
  input            adclrc_s1_readdata;
  input            clk;
  input   [ 16: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;

  wire    [  1: 0] adclrc_s1_address;
  wire             adclrc_s1_allgrants;
  wire             adclrc_s1_allow_new_arb_cycle;
  wire             adclrc_s1_any_bursting_master_saved_grant;
  wire             adclrc_s1_any_continuerequest;
  wire             adclrc_s1_arb_counter_enable;
  reg              adclrc_s1_arb_share_counter;
  wire             adclrc_s1_arb_share_counter_next_value;
  wire             adclrc_s1_arb_share_set_values;
  wire             adclrc_s1_beginbursttransfer_internal;
  wire             adclrc_s1_begins_xfer;
  wire             adclrc_s1_end_xfer;
  wire             adclrc_s1_firsttransfer;
  wire             adclrc_s1_grant_vector;
  wire             adclrc_s1_in_a_read_cycle;
  wire             adclrc_s1_in_a_write_cycle;
  wire             adclrc_s1_master_qreq_vector;
  wire             adclrc_s1_non_bursting_master_requests;
  wire             adclrc_s1_readdata_from_sa;
  reg              adclrc_s1_reg_firsttransfer;
  wire             adclrc_s1_reset_n;
  reg              adclrc_s1_slavearbiterlockenable;
  wire             adclrc_s1_slavearbiterlockenable2;
  wire             adclrc_s1_unreg_firsttransfer;
  wire             adclrc_s1_waits_for_read;
  wire             adclrc_s1_waits_for_write;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_adclrc_s1;
  wire             cpu_0_data_master_qualified_request_adclrc_s1;
  wire             cpu_0_data_master_read_data_valid_adclrc_s1;
  wire             cpu_0_data_master_requests_adclrc_s1;
  wire             cpu_0_data_master_saved_grant_adclrc_s1;
  reg              d1_adclrc_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_adclrc_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 16: 0] shifted_address_to_adclrc_s1_from_cpu_0_data_master;
  wire             wait_for_adclrc_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~adclrc_s1_end_xfer;
    end


  assign adclrc_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_adclrc_s1));
  //assign adclrc_s1_readdata_from_sa = adclrc_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign adclrc_s1_readdata_from_sa = adclrc_s1_readdata;

  assign cpu_0_data_master_requests_adclrc_s1 = (({cpu_0_data_master_address_to_slave[16 : 4] , 4'b0} == 17'h11050) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //adclrc_s1_arb_share_counter set values, which is an e_mux
  assign adclrc_s1_arb_share_set_values = 1;

  //adclrc_s1_non_bursting_master_requests mux, which is an e_mux
  assign adclrc_s1_non_bursting_master_requests = cpu_0_data_master_requests_adclrc_s1;

  //adclrc_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign adclrc_s1_any_bursting_master_saved_grant = 0;

  //adclrc_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign adclrc_s1_arb_share_counter_next_value = adclrc_s1_firsttransfer ? (adclrc_s1_arb_share_set_values - 1) : |adclrc_s1_arb_share_counter ? (adclrc_s1_arb_share_counter - 1) : 0;

  //adclrc_s1_allgrants all slave grants, which is an e_mux
  assign adclrc_s1_allgrants = |adclrc_s1_grant_vector;

  //adclrc_s1_end_xfer assignment, which is an e_assign
  assign adclrc_s1_end_xfer = ~(adclrc_s1_waits_for_read | adclrc_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_adclrc_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_adclrc_s1 = adclrc_s1_end_xfer & (~adclrc_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //adclrc_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign adclrc_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_adclrc_s1 & adclrc_s1_allgrants) | (end_xfer_arb_share_counter_term_adclrc_s1 & ~adclrc_s1_non_bursting_master_requests);

  //adclrc_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          adclrc_s1_arb_share_counter <= 0;
      else if (adclrc_s1_arb_counter_enable)
          adclrc_s1_arb_share_counter <= adclrc_s1_arb_share_counter_next_value;
    end


  //adclrc_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          adclrc_s1_slavearbiterlockenable <= 0;
      else if ((|adclrc_s1_master_qreq_vector & end_xfer_arb_share_counter_term_adclrc_s1) | (end_xfer_arb_share_counter_term_adclrc_s1 & ~adclrc_s1_non_bursting_master_requests))
          adclrc_s1_slavearbiterlockenable <= |adclrc_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master adclrc/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = adclrc_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //adclrc_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign adclrc_s1_slavearbiterlockenable2 = |adclrc_s1_arb_share_counter_next_value;

  //cpu_0/data_master adclrc/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = adclrc_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //adclrc_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign adclrc_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_adclrc_s1 = cpu_0_data_master_requests_adclrc_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_adclrc_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_adclrc_s1 = cpu_0_data_master_granted_adclrc_s1 & cpu_0_data_master_read & ~adclrc_s1_waits_for_read;

  //master is always granted when requested
  assign cpu_0_data_master_granted_adclrc_s1 = cpu_0_data_master_qualified_request_adclrc_s1;

  //cpu_0/data_master saved-grant adclrc/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_adclrc_s1 = cpu_0_data_master_requests_adclrc_s1;

  //allow new arb cycle for adclrc/s1, which is an e_assign
  assign adclrc_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign adclrc_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign adclrc_s1_master_qreq_vector = 1;

  //adclrc_s1_reset_n assignment, which is an e_assign
  assign adclrc_s1_reset_n = reset_n;

  //adclrc_s1_firsttransfer first transaction, which is an e_assign
  assign adclrc_s1_firsttransfer = adclrc_s1_begins_xfer ? adclrc_s1_unreg_firsttransfer : adclrc_s1_reg_firsttransfer;

  //adclrc_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign adclrc_s1_unreg_firsttransfer = ~(adclrc_s1_slavearbiterlockenable & adclrc_s1_any_continuerequest);

  //adclrc_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          adclrc_s1_reg_firsttransfer <= 1'b1;
      else if (adclrc_s1_begins_xfer)
          adclrc_s1_reg_firsttransfer <= adclrc_s1_unreg_firsttransfer;
    end


  //adclrc_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign adclrc_s1_beginbursttransfer_internal = adclrc_s1_begins_xfer;

  assign shifted_address_to_adclrc_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //adclrc_s1_address mux, which is an e_mux
  assign adclrc_s1_address = shifted_address_to_adclrc_s1_from_cpu_0_data_master >> 2;

  //d1_adclrc_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_adclrc_s1_end_xfer <= 1;
      else 
        d1_adclrc_s1_end_xfer <= adclrc_s1_end_xfer;
    end


  //adclrc_s1_waits_for_read in a cycle, which is an e_mux
  assign adclrc_s1_waits_for_read = adclrc_s1_in_a_read_cycle & adclrc_s1_begins_xfer;

  //adclrc_s1_in_a_read_cycle assignment, which is an e_assign
  assign adclrc_s1_in_a_read_cycle = cpu_0_data_master_granted_adclrc_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = adclrc_s1_in_a_read_cycle;

  //adclrc_s1_waits_for_write in a cycle, which is an e_mux
  assign adclrc_s1_waits_for_write = adclrc_s1_in_a_write_cycle & 0;

  //adclrc_s1_in_a_write_cycle assignment, which is an e_assign
  assign adclrc_s1_in_a_write_cycle = cpu_0_data_master_granted_adclrc_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = adclrc_s1_in_a_write_cycle;

  assign wait_for_adclrc_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //adclrc/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module chorus_on_s1_arbitrator (
                                 // inputs:
                                  chorus_on_s1_readdata,
                                  clk,
                                  cpu_0_data_master_address_to_slave,
                                  cpu_0_data_master_latency_counter,
                                  cpu_0_data_master_read,
                                  cpu_0_data_master_write,
                                  reset_n,

                                 // outputs:
                                  chorus_on_s1_address,
                                  chorus_on_s1_readdata_from_sa,
                                  chorus_on_s1_reset_n,
                                  cpu_0_data_master_granted_chorus_on_s1,
                                  cpu_0_data_master_qualified_request_chorus_on_s1,
                                  cpu_0_data_master_read_data_valid_chorus_on_s1,
                                  cpu_0_data_master_requests_chorus_on_s1,
                                  d1_chorus_on_s1_end_xfer
                               )
;

  output  [  1: 0] chorus_on_s1_address;
  output           chorus_on_s1_readdata_from_sa;
  output           chorus_on_s1_reset_n;
  output           cpu_0_data_master_granted_chorus_on_s1;
  output           cpu_0_data_master_qualified_request_chorus_on_s1;
  output           cpu_0_data_master_read_data_valid_chorus_on_s1;
  output           cpu_0_data_master_requests_chorus_on_s1;
  output           d1_chorus_on_s1_end_xfer;
  input            chorus_on_s1_readdata;
  input            clk;
  input   [ 16: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;

  wire    [  1: 0] chorus_on_s1_address;
  wire             chorus_on_s1_allgrants;
  wire             chorus_on_s1_allow_new_arb_cycle;
  wire             chorus_on_s1_any_bursting_master_saved_grant;
  wire             chorus_on_s1_any_continuerequest;
  wire             chorus_on_s1_arb_counter_enable;
  reg              chorus_on_s1_arb_share_counter;
  wire             chorus_on_s1_arb_share_counter_next_value;
  wire             chorus_on_s1_arb_share_set_values;
  wire             chorus_on_s1_beginbursttransfer_internal;
  wire             chorus_on_s1_begins_xfer;
  wire             chorus_on_s1_end_xfer;
  wire             chorus_on_s1_firsttransfer;
  wire             chorus_on_s1_grant_vector;
  wire             chorus_on_s1_in_a_read_cycle;
  wire             chorus_on_s1_in_a_write_cycle;
  wire             chorus_on_s1_master_qreq_vector;
  wire             chorus_on_s1_non_bursting_master_requests;
  wire             chorus_on_s1_readdata_from_sa;
  reg              chorus_on_s1_reg_firsttransfer;
  wire             chorus_on_s1_reset_n;
  reg              chorus_on_s1_slavearbiterlockenable;
  wire             chorus_on_s1_slavearbiterlockenable2;
  wire             chorus_on_s1_unreg_firsttransfer;
  wire             chorus_on_s1_waits_for_read;
  wire             chorus_on_s1_waits_for_write;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_chorus_on_s1;
  wire             cpu_0_data_master_qualified_request_chorus_on_s1;
  wire             cpu_0_data_master_read_data_valid_chorus_on_s1;
  wire             cpu_0_data_master_requests_chorus_on_s1;
  wire             cpu_0_data_master_saved_grant_chorus_on_s1;
  reg              d1_chorus_on_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_chorus_on_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 16: 0] shifted_address_to_chorus_on_s1_from_cpu_0_data_master;
  wire             wait_for_chorus_on_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~chorus_on_s1_end_xfer;
    end


  assign chorus_on_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_chorus_on_s1));
  //assign chorus_on_s1_readdata_from_sa = chorus_on_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign chorus_on_s1_readdata_from_sa = chorus_on_s1_readdata;

  assign cpu_0_data_master_requests_chorus_on_s1 = (({cpu_0_data_master_address_to_slave[16 : 4] , 4'b0} == 17'h11030) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //chorus_on_s1_arb_share_counter set values, which is an e_mux
  assign chorus_on_s1_arb_share_set_values = 1;

  //chorus_on_s1_non_bursting_master_requests mux, which is an e_mux
  assign chorus_on_s1_non_bursting_master_requests = cpu_0_data_master_requests_chorus_on_s1;

  //chorus_on_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign chorus_on_s1_any_bursting_master_saved_grant = 0;

  //chorus_on_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign chorus_on_s1_arb_share_counter_next_value = chorus_on_s1_firsttransfer ? (chorus_on_s1_arb_share_set_values - 1) : |chorus_on_s1_arb_share_counter ? (chorus_on_s1_arb_share_counter - 1) : 0;

  //chorus_on_s1_allgrants all slave grants, which is an e_mux
  assign chorus_on_s1_allgrants = |chorus_on_s1_grant_vector;

  //chorus_on_s1_end_xfer assignment, which is an e_assign
  assign chorus_on_s1_end_xfer = ~(chorus_on_s1_waits_for_read | chorus_on_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_chorus_on_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_chorus_on_s1 = chorus_on_s1_end_xfer & (~chorus_on_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //chorus_on_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign chorus_on_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_chorus_on_s1 & chorus_on_s1_allgrants) | (end_xfer_arb_share_counter_term_chorus_on_s1 & ~chorus_on_s1_non_bursting_master_requests);

  //chorus_on_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          chorus_on_s1_arb_share_counter <= 0;
      else if (chorus_on_s1_arb_counter_enable)
          chorus_on_s1_arb_share_counter <= chorus_on_s1_arb_share_counter_next_value;
    end


  //chorus_on_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          chorus_on_s1_slavearbiterlockenable <= 0;
      else if ((|chorus_on_s1_master_qreq_vector & end_xfer_arb_share_counter_term_chorus_on_s1) | (end_xfer_arb_share_counter_term_chorus_on_s1 & ~chorus_on_s1_non_bursting_master_requests))
          chorus_on_s1_slavearbiterlockenable <= |chorus_on_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master chorus_on/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = chorus_on_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //chorus_on_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign chorus_on_s1_slavearbiterlockenable2 = |chorus_on_s1_arb_share_counter_next_value;

  //cpu_0/data_master chorus_on/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = chorus_on_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //chorus_on_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign chorus_on_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_chorus_on_s1 = cpu_0_data_master_requests_chorus_on_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_chorus_on_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_chorus_on_s1 = cpu_0_data_master_granted_chorus_on_s1 & cpu_0_data_master_read & ~chorus_on_s1_waits_for_read;

  //master is always granted when requested
  assign cpu_0_data_master_granted_chorus_on_s1 = cpu_0_data_master_qualified_request_chorus_on_s1;

  //cpu_0/data_master saved-grant chorus_on/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_chorus_on_s1 = cpu_0_data_master_requests_chorus_on_s1;

  //allow new arb cycle for chorus_on/s1, which is an e_assign
  assign chorus_on_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign chorus_on_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign chorus_on_s1_master_qreq_vector = 1;

  //chorus_on_s1_reset_n assignment, which is an e_assign
  assign chorus_on_s1_reset_n = reset_n;

  //chorus_on_s1_firsttransfer first transaction, which is an e_assign
  assign chorus_on_s1_firsttransfer = chorus_on_s1_begins_xfer ? chorus_on_s1_unreg_firsttransfer : chorus_on_s1_reg_firsttransfer;

  //chorus_on_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign chorus_on_s1_unreg_firsttransfer = ~(chorus_on_s1_slavearbiterlockenable & chorus_on_s1_any_continuerequest);

  //chorus_on_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          chorus_on_s1_reg_firsttransfer <= 1'b1;
      else if (chorus_on_s1_begins_xfer)
          chorus_on_s1_reg_firsttransfer <= chorus_on_s1_unreg_firsttransfer;
    end


  //chorus_on_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign chorus_on_s1_beginbursttransfer_internal = chorus_on_s1_begins_xfer;

  assign shifted_address_to_chorus_on_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //chorus_on_s1_address mux, which is an e_mux
  assign chorus_on_s1_address = shifted_address_to_chorus_on_s1_from_cpu_0_data_master >> 2;

  //d1_chorus_on_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_chorus_on_s1_end_xfer <= 1;
      else 
        d1_chorus_on_s1_end_xfer <= chorus_on_s1_end_xfer;
    end


  //chorus_on_s1_waits_for_read in a cycle, which is an e_mux
  assign chorus_on_s1_waits_for_read = chorus_on_s1_in_a_read_cycle & chorus_on_s1_begins_xfer;

  //chorus_on_s1_in_a_read_cycle assignment, which is an e_assign
  assign chorus_on_s1_in_a_read_cycle = cpu_0_data_master_granted_chorus_on_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = chorus_on_s1_in_a_read_cycle;

  //chorus_on_s1_waits_for_write in a cycle, which is an e_mux
  assign chorus_on_s1_waits_for_write = chorus_on_s1_in_a_write_cycle & 0;

  //chorus_on_s1_in_a_write_cycle assignment, which is an e_assign
  assign chorus_on_s1_in_a_write_cycle = cpu_0_data_master_granted_chorus_on_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = chorus_on_s1_in_a_write_cycle;

  assign wait_for_chorus_on_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //chorus_on/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clk_s1_arbitrator (
                           // inputs:
                            clk,
                            clk_s1_readdata,
                            cpu_0_data_master_address_to_slave,
                            cpu_0_data_master_latency_counter,
                            cpu_0_data_master_read,
                            cpu_0_data_master_write,
                            reset_n,

                           // outputs:
                            clk_s1_address,
                            clk_s1_readdata_from_sa,
                            clk_s1_reset_n,
                            cpu_0_data_master_granted_clk_s1,
                            cpu_0_data_master_qualified_request_clk_s1,
                            cpu_0_data_master_read_data_valid_clk_s1,
                            cpu_0_data_master_requests_clk_s1,
                            d1_clk_s1_end_xfer
                         )
;

  output  [  1: 0] clk_s1_address;
  output           clk_s1_readdata_from_sa;
  output           clk_s1_reset_n;
  output           cpu_0_data_master_granted_clk_s1;
  output           cpu_0_data_master_qualified_request_clk_s1;
  output           cpu_0_data_master_read_data_valid_clk_s1;
  output           cpu_0_data_master_requests_clk_s1;
  output           d1_clk_s1_end_xfer;
  input            clk;
  input            clk_s1_readdata;
  input   [ 16: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;

  wire    [  1: 0] clk_s1_address;
  wire             clk_s1_allgrants;
  wire             clk_s1_allow_new_arb_cycle;
  wire             clk_s1_any_bursting_master_saved_grant;
  wire             clk_s1_any_continuerequest;
  wire             clk_s1_arb_counter_enable;
  reg              clk_s1_arb_share_counter;
  wire             clk_s1_arb_share_counter_next_value;
  wire             clk_s1_arb_share_set_values;
  wire             clk_s1_beginbursttransfer_internal;
  wire             clk_s1_begins_xfer;
  wire             clk_s1_end_xfer;
  wire             clk_s1_firsttransfer;
  wire             clk_s1_grant_vector;
  wire             clk_s1_in_a_read_cycle;
  wire             clk_s1_in_a_write_cycle;
  wire             clk_s1_master_qreq_vector;
  wire             clk_s1_non_bursting_master_requests;
  wire             clk_s1_readdata_from_sa;
  reg              clk_s1_reg_firsttransfer;
  wire             clk_s1_reset_n;
  reg              clk_s1_slavearbiterlockenable;
  wire             clk_s1_slavearbiterlockenable2;
  wire             clk_s1_unreg_firsttransfer;
  wire             clk_s1_waits_for_read;
  wire             clk_s1_waits_for_write;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_clk_s1;
  wire             cpu_0_data_master_qualified_request_clk_s1;
  wire             cpu_0_data_master_read_data_valid_clk_s1;
  wire             cpu_0_data_master_requests_clk_s1;
  wire             cpu_0_data_master_saved_grant_clk_s1;
  reg              d1_clk_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_clk_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 16: 0] shifted_address_to_clk_s1_from_cpu_0_data_master;
  wire             wait_for_clk_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~clk_s1_end_xfer;
    end


  assign clk_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_clk_s1));
  //assign clk_s1_readdata_from_sa = clk_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clk_s1_readdata_from_sa = clk_s1_readdata;

  assign cpu_0_data_master_requests_clk_s1 = (({cpu_0_data_master_address_to_slave[16 : 4] , 4'b0} == 17'h11040) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //clk_s1_arb_share_counter set values, which is an e_mux
  assign clk_s1_arb_share_set_values = 1;

  //clk_s1_non_bursting_master_requests mux, which is an e_mux
  assign clk_s1_non_bursting_master_requests = cpu_0_data_master_requests_clk_s1;

  //clk_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign clk_s1_any_bursting_master_saved_grant = 0;

  //clk_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign clk_s1_arb_share_counter_next_value = clk_s1_firsttransfer ? (clk_s1_arb_share_set_values - 1) : |clk_s1_arb_share_counter ? (clk_s1_arb_share_counter - 1) : 0;

  //clk_s1_allgrants all slave grants, which is an e_mux
  assign clk_s1_allgrants = |clk_s1_grant_vector;

  //clk_s1_end_xfer assignment, which is an e_assign
  assign clk_s1_end_xfer = ~(clk_s1_waits_for_read | clk_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_clk_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_clk_s1 = clk_s1_end_xfer & (~clk_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //clk_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign clk_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_clk_s1 & clk_s1_allgrants) | (end_xfer_arb_share_counter_term_clk_s1 & ~clk_s1_non_bursting_master_requests);

  //clk_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clk_s1_arb_share_counter <= 0;
      else if (clk_s1_arb_counter_enable)
          clk_s1_arb_share_counter <= clk_s1_arb_share_counter_next_value;
    end


  //clk_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clk_s1_slavearbiterlockenable <= 0;
      else if ((|clk_s1_master_qreq_vector & end_xfer_arb_share_counter_term_clk_s1) | (end_xfer_arb_share_counter_term_clk_s1 & ~clk_s1_non_bursting_master_requests))
          clk_s1_slavearbiterlockenable <= |clk_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master clk/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = clk_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //clk_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign clk_s1_slavearbiterlockenable2 = |clk_s1_arb_share_counter_next_value;

  //cpu_0/data_master clk/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = clk_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //clk_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign clk_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_clk_s1 = cpu_0_data_master_requests_clk_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_clk_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_clk_s1 = cpu_0_data_master_granted_clk_s1 & cpu_0_data_master_read & ~clk_s1_waits_for_read;

  //master is always granted when requested
  assign cpu_0_data_master_granted_clk_s1 = cpu_0_data_master_qualified_request_clk_s1;

  //cpu_0/data_master saved-grant clk/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_clk_s1 = cpu_0_data_master_requests_clk_s1;

  //allow new arb cycle for clk/s1, which is an e_assign
  assign clk_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign clk_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign clk_s1_master_qreq_vector = 1;

  //clk_s1_reset_n assignment, which is an e_assign
  assign clk_s1_reset_n = reset_n;

  //clk_s1_firsttransfer first transaction, which is an e_assign
  assign clk_s1_firsttransfer = clk_s1_begins_xfer ? clk_s1_unreg_firsttransfer : clk_s1_reg_firsttransfer;

  //clk_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign clk_s1_unreg_firsttransfer = ~(clk_s1_slavearbiterlockenable & clk_s1_any_continuerequest);

  //clk_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clk_s1_reg_firsttransfer <= 1'b1;
      else if (clk_s1_begins_xfer)
          clk_s1_reg_firsttransfer <= clk_s1_unreg_firsttransfer;
    end


  //clk_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign clk_s1_beginbursttransfer_internal = clk_s1_begins_xfer;

  assign shifted_address_to_clk_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //clk_s1_address mux, which is an e_mux
  assign clk_s1_address = shifted_address_to_clk_s1_from_cpu_0_data_master >> 2;

  //d1_clk_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_clk_s1_end_xfer <= 1;
      else 
        d1_clk_s1_end_xfer <= clk_s1_end_xfer;
    end


  //clk_s1_waits_for_read in a cycle, which is an e_mux
  assign clk_s1_waits_for_read = clk_s1_in_a_read_cycle & clk_s1_begins_xfer;

  //clk_s1_in_a_read_cycle assignment, which is an e_assign
  assign clk_s1_in_a_read_cycle = cpu_0_data_master_granted_clk_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = clk_s1_in_a_read_cycle;

  //clk_s1_waits_for_write in a cycle, which is an e_mux
  assign clk_s1_waits_for_write = clk_s1_in_a_write_cycle & 0;

  //clk_s1_in_a_write_cycle assignment, which is an e_assign
  assign clk_s1_in_a_write_cycle = cpu_0_data_master_granted_clk_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = clk_s1_in_a_write_cycle;

  assign wait_for_clk_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clk/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_jtag_debug_module_arbitrator (
                                            // inputs:
                                             clk,
                                             cpu_0_data_master_address_to_slave,
                                             cpu_0_data_master_byteenable,
                                             cpu_0_data_master_debugaccess,
                                             cpu_0_data_master_latency_counter,
                                             cpu_0_data_master_read,
                                             cpu_0_data_master_write,
                                             cpu_0_data_master_writedata,
                                             cpu_0_instruction_master_address_to_slave,
                                             cpu_0_instruction_master_latency_counter,
                                             cpu_0_instruction_master_read,
                                             cpu_0_jtag_debug_module_readdata,
                                             cpu_0_jtag_debug_module_resetrequest,
                                             reset_n,

                                            // outputs:
                                             cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_jtag_debug_module_address,
                                             cpu_0_jtag_debug_module_begintransfer,
                                             cpu_0_jtag_debug_module_byteenable,
                                             cpu_0_jtag_debug_module_chipselect,
                                             cpu_0_jtag_debug_module_debugaccess,
                                             cpu_0_jtag_debug_module_readdata_from_sa,
                                             cpu_0_jtag_debug_module_reset,
                                             cpu_0_jtag_debug_module_resetrequest_from_sa,
                                             cpu_0_jtag_debug_module_write,
                                             cpu_0_jtag_debug_module_writedata,
                                             d1_cpu_0_jtag_debug_module_end_xfer
                                          )
;

  output           cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  output  [  8: 0] cpu_0_jtag_debug_module_address;
  output           cpu_0_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_0_jtag_debug_module_byteenable;
  output           cpu_0_jtag_debug_module_chipselect;
  output           cpu_0_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  output           cpu_0_jtag_debug_module_reset;
  output           cpu_0_jtag_debug_module_resetrequest_from_sa;
  output           cpu_0_jtag_debug_module_write;
  output  [ 31: 0] cpu_0_jtag_debug_module_writedata;
  output           d1_cpu_0_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 16: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_debugaccess;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 16: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata;
  input            cpu_0_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_allgrants;
  wire             cpu_0_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_0_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_0_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_addend;
  wire             cpu_0_jtag_debug_module_arb_counter_enable;
  reg              cpu_0_jtag_debug_module_arb_share_counter;
  wire             cpu_0_jtag_debug_module_arb_share_counter_next_value;
  wire             cpu_0_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_winner;
  wire             cpu_0_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_0_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_0_jtag_debug_module_begins_xfer;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_0_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_0_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire             cpu_0_jtag_debug_module_end_xfer;
  wire             cpu_0_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_0_jtag_debug_module_grant_vector;
  wire             cpu_0_jtag_debug_module_in_a_read_cycle;
  wire             cpu_0_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_0_jtag_debug_module_master_qreq_vector;
  wire             cpu_0_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  reg              cpu_0_jtag_debug_module_reg_firsttransfer;
  wire             cpu_0_jtag_debug_module_reset;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_0_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_0_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_0_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_0_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_0_jtag_debug_module_waits_for_read;
  wire             cpu_0_jtag_debug_module_waits_for_write;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  reg              d1_cpu_0_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
  wire    [ 16: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master;
  wire    [ 16: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master;
  wire             wait_for_cpu_0_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_0_jtag_debug_module_end_xfer;
    end


  assign cpu_0_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module));
  //assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata;

  assign cpu_0_data_master_requests_cpu_0_jtag_debug_module = ({cpu_0_data_master_address_to_slave[16 : 11] , 11'b0} == 17'h10800) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //cpu_0_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_0_jtag_debug_module_arb_share_set_values = 1;

  //cpu_0_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_0_jtag_debug_module_non_bursting_master_requests = cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module |
    cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_0_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_0_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_share_counter_next_value = cpu_0_jtag_debug_module_firsttransfer ? (cpu_0_jtag_debug_module_arb_share_set_values - 1) : |cpu_0_jtag_debug_module_arb_share_counter ? (cpu_0_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_0_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_0_jtag_debug_module_allgrants = (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector);

  //cpu_0_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_end_xfer = ~(cpu_0_jtag_debug_module_waits_for_read | cpu_0_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_end_xfer & (~cpu_0_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_0_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & cpu_0_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests);

  //cpu_0_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_0_jtag_debug_module_arb_counter_enable)
          cpu_0_jtag_debug_module_arb_share_counter <= cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_0_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests))
          cpu_0_jtag_debug_module_slavearbiterlockenable <= |cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //cpu_0_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_0_jtag_debug_module_slavearbiterlockenable2 = |cpu_0_jtag_debug_module_arb_share_counter_next_value;

  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_0_jtag_debug_module_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_data_master_requests_cpu_0_jtag_debug_module & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))) | cpu_0_instruction_master_arbiterlock);
  //local readdatavalid cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  assign cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read & ~cpu_0_jtag_debug_module_waits_for_read;

  //cpu_0_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_0_jtag_debug_module_writedata = cpu_0_data_master_writedata;

  assign cpu_0_instruction_master_requests_cpu_0_jtag_debug_module = (({cpu_0_instruction_master_address_to_slave[16 : 11] , 11'b0} == 17'h10800) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  assign cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_instruction_master_requests_cpu_0_jtag_debug_module & ~((cpu_0_instruction_master_read & ((cpu_0_instruction_master_latency_counter != 0))) | cpu_0_data_master_arbiterlock);
  //local readdatavalid cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read & ~cpu_0_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/instruction_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[0];

  //cpu_0/instruction_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[0] && cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/data_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[1] = cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/data_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[1];

  //cpu_0/data_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[1] && cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_double_vector = {cpu_0_jtag_debug_module_master_qreq_vector, cpu_0_jtag_debug_module_master_qreq_vector} & ({~cpu_0_jtag_debug_module_master_qreq_vector, ~cpu_0_jtag_debug_module_master_qreq_vector} + cpu_0_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_0_jtag_debug_module_arb_winner = (cpu_0_jtag_debug_module_allow_new_arb_cycle & | cpu_0_jtag_debug_module_grant_vector) ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_0_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_0_jtag_debug_module_allow_new_arb_cycle)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= |cpu_0_jtag_debug_module_grant_vector ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_0_jtag_debug_module_grant_vector = {(cpu_0_jtag_debug_module_chosen_master_double_vector[1] | cpu_0_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_0_jtag_debug_module_chosen_master_double_vector[0] | cpu_0_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu_0/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_rot_left = (cpu_0_jtag_debug_module_arb_winner << 1) ? (cpu_0_jtag_debug_module_arb_winner << 1) : 1;

  //cpu_0/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_0_jtag_debug_module_grant_vector)
          cpu_0_jtag_debug_module_arb_addend <= cpu_0_jtag_debug_module_end_xfer? cpu_0_jtag_debug_module_chosen_master_rot_left : cpu_0_jtag_debug_module_grant_vector;
    end


  assign cpu_0_jtag_debug_module_begintransfer = cpu_0_jtag_debug_module_begins_xfer;
  //~cpu_0_jtag_debug_module_reset assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_reset = ~reset_n;

  //assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest;

  assign cpu_0_jtag_debug_module_chipselect = cpu_0_data_master_granted_cpu_0_jtag_debug_module | cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  //cpu_0_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_firsttransfer = cpu_0_jtag_debug_module_begins_xfer ? cpu_0_jtag_debug_module_unreg_firsttransfer : cpu_0_jtag_debug_module_reg_firsttransfer;

  //cpu_0_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_unreg_firsttransfer = ~(cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_jtag_debug_module_any_continuerequest);

  //cpu_0_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_0_jtag_debug_module_begins_xfer)
          cpu_0_jtag_debug_module_reg_firsttransfer <= cpu_0_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_0_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_0_jtag_debug_module_beginbursttransfer_internal = cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_0_jtag_debug_module_arbitration_holdoff_internal = cpu_0_jtag_debug_module_begins_xfer & cpu_0_jtag_debug_module_firsttransfer;

  //cpu_0_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_0_jtag_debug_module_write = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //cpu_0_jtag_debug_module_address mux, which is an e_mux
  assign cpu_0_jtag_debug_module_address = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master >> 2) :
    (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_cpu_0_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_0_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_0_jtag_debug_module_end_xfer <= cpu_0_jtag_debug_module_end_xfer;
    end


  //cpu_0_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_read = cpu_0_jtag_debug_module_in_a_read_cycle & cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_read_cycle = (cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_0_jtag_debug_module_in_a_read_cycle;

  //cpu_0_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_write = cpu_0_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_0_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_write_cycle = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_0_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_0_jtag_debug_module_counter = 0;
  //cpu_0_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_0_jtag_debug_module_byteenable = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_0_jtag_debug_module_debugaccess = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_cpu_0_jtag_debug_module + cpu_0_instruction_master_granted_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module + cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_custom_instruction_master_arbitrator (
                                                    // inputs:
                                                     clk,
                                                     cpu_0_custom_instruction_master_multi_start,
                                                     cpu_0_fpoint_s1_done_from_sa,
                                                     cpu_0_fpoint_s1_result_from_sa,
                                                     reset_n,

                                                    // outputs:
                                                     cpu_0_custom_instruction_master_multi_done,
                                                     cpu_0_custom_instruction_master_multi_result,
                                                     cpu_0_custom_instruction_master_reset_n,
                                                     cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1,
                                                     cpu_0_fpoint_s1_select
                                                  )
;

  output           cpu_0_custom_instruction_master_multi_done;
  output  [ 31: 0] cpu_0_custom_instruction_master_multi_result;
  output           cpu_0_custom_instruction_master_reset_n;
  output           cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1;
  output           cpu_0_fpoint_s1_select;
  input            clk;
  input            cpu_0_custom_instruction_master_multi_start;
  input            cpu_0_fpoint_s1_done_from_sa;
  input   [ 31: 0] cpu_0_fpoint_s1_result_from_sa;
  input            reset_n;

  wire             cpu_0_custom_instruction_master_multi_done;
  wire    [ 31: 0] cpu_0_custom_instruction_master_multi_result;
  wire             cpu_0_custom_instruction_master_reset_n;
  wire             cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1;
  wire             cpu_0_fpoint_s1_select;
  assign cpu_0_fpoint_s1_select = 1'b1;
  assign cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1 = cpu_0_fpoint_s1_select & cpu_0_custom_instruction_master_multi_start;
  //cpu_0_custom_instruction_master_multi_result mux, which is an e_mux
  assign cpu_0_custom_instruction_master_multi_result = {32 {cpu_0_fpoint_s1_select}} & cpu_0_fpoint_s1_result_from_sa;

  //multi_done mux, which is an e_mux
  assign cpu_0_custom_instruction_master_multi_done = {1 {cpu_0_fpoint_s1_select}} & cpu_0_fpoint_s1_done_from_sa;

  //cpu_0_custom_instruction_master_reset_n local reset_n, which is an e_assign
  assign cpu_0_custom_instruction_master_reset_n = reset_n;


endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_data_master_arbitrator (
                                      // inputs:
                                       adclrc_s1_readdata_from_sa,
                                       chorus_on_s1_readdata_from_sa,
                                       clk,
                                       clk_s1_readdata_from_sa,
                                       cpu_0_data_master_address,
                                       cpu_0_data_master_byteenable,
                                       cpu_0_data_master_granted_adclrc_s1,
                                       cpu_0_data_master_granted_chorus_on_s1,
                                       cpu_0_data_master_granted_clk_s1,
                                       cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_granted_cpueffect_clock_0_in,
                                       cpu_0_data_master_granted_datain_s1,
                                       cpu_0_data_master_granted_dataout_s1,
                                       cpu_0_data_master_granted_onchip_memory2_0_s1,
                                       cpu_0_data_master_granted_vibrato_on_s1,
                                       cpu_0_data_master_qualified_request_adclrc_s1,
                                       cpu_0_data_master_qualified_request_chorus_on_s1,
                                       cpu_0_data_master_qualified_request_clk_s1,
                                       cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_qualified_request_cpueffect_clock_0_in,
                                       cpu_0_data_master_qualified_request_datain_s1,
                                       cpu_0_data_master_qualified_request_dataout_s1,
                                       cpu_0_data_master_qualified_request_onchip_memory2_0_s1,
                                       cpu_0_data_master_qualified_request_vibrato_on_s1,
                                       cpu_0_data_master_read,
                                       cpu_0_data_master_read_data_valid_adclrc_s1,
                                       cpu_0_data_master_read_data_valid_chorus_on_s1,
                                       cpu_0_data_master_read_data_valid_clk_s1,
                                       cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_read_data_valid_cpueffect_clock_0_in,
                                       cpu_0_data_master_read_data_valid_datain_s1,
                                       cpu_0_data_master_read_data_valid_dataout_s1,
                                       cpu_0_data_master_read_data_valid_onchip_memory2_0_s1,
                                       cpu_0_data_master_read_data_valid_vibrato_on_s1,
                                       cpu_0_data_master_requests_adclrc_s1,
                                       cpu_0_data_master_requests_chorus_on_s1,
                                       cpu_0_data_master_requests_clk_s1,
                                       cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_requests_cpueffect_clock_0_in,
                                       cpu_0_data_master_requests_datain_s1,
                                       cpu_0_data_master_requests_dataout_s1,
                                       cpu_0_data_master_requests_onchip_memory2_0_s1,
                                       cpu_0_data_master_requests_vibrato_on_s1,
                                       cpu_0_data_master_write,
                                       cpu_0_data_master_writedata,
                                       cpu_0_jtag_debug_module_readdata_from_sa,
                                       cpueffect_clock_0_in_readdata_from_sa,
                                       cpueffect_clock_0_in_waitrequest_from_sa,
                                       d1_adclrc_s1_end_xfer,
                                       d1_chorus_on_s1_end_xfer,
                                       d1_clk_s1_end_xfer,
                                       d1_cpu_0_jtag_debug_module_end_xfer,
                                       d1_cpueffect_clock_0_in_end_xfer,
                                       d1_datain_s1_end_xfer,
                                       d1_dataout_s1_end_xfer,
                                       d1_onchip_memory2_0_s1_end_xfer,
                                       d1_vibrato_on_s1_end_xfer,
                                       datain_s1_readdata_from_sa,
                                       dataout_s1_readdata_from_sa,
                                       onchip_memory2_0_s1_readdata_from_sa,
                                       reset_n,
                                       vibrato_on_s1_readdata_from_sa,

                                      // outputs:
                                       cpu_0_data_master_address_to_slave,
                                       cpu_0_data_master_latency_counter,
                                       cpu_0_data_master_readdata,
                                       cpu_0_data_master_readdatavalid,
                                       cpu_0_data_master_waitrequest
                                    )
;

  output  [ 16: 0] cpu_0_data_master_address_to_slave;
  output           cpu_0_data_master_latency_counter;
  output  [ 31: 0] cpu_0_data_master_readdata;
  output           cpu_0_data_master_readdatavalid;
  output           cpu_0_data_master_waitrequest;
  input            adclrc_s1_readdata_from_sa;
  input            chorus_on_s1_readdata_from_sa;
  input            clk;
  input            clk_s1_readdata_from_sa;
  input   [ 16: 0] cpu_0_data_master_address;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_granted_adclrc_s1;
  input            cpu_0_data_master_granted_chorus_on_s1;
  input            cpu_0_data_master_granted_clk_s1;
  input            cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_granted_cpueffect_clock_0_in;
  input            cpu_0_data_master_granted_datain_s1;
  input            cpu_0_data_master_granted_dataout_s1;
  input            cpu_0_data_master_granted_onchip_memory2_0_s1;
  input            cpu_0_data_master_granted_vibrato_on_s1;
  input            cpu_0_data_master_qualified_request_adclrc_s1;
  input            cpu_0_data_master_qualified_request_chorus_on_s1;
  input            cpu_0_data_master_qualified_request_clk_s1;
  input            cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_qualified_request_cpueffect_clock_0_in;
  input            cpu_0_data_master_qualified_request_datain_s1;
  input            cpu_0_data_master_qualified_request_dataout_s1;
  input            cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  input            cpu_0_data_master_qualified_request_vibrato_on_s1;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_read_data_valid_adclrc_s1;
  input            cpu_0_data_master_read_data_valid_chorus_on_s1;
  input            cpu_0_data_master_read_data_valid_clk_s1;
  input            cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_read_data_valid_cpueffect_clock_0_in;
  input            cpu_0_data_master_read_data_valid_datain_s1;
  input            cpu_0_data_master_read_data_valid_dataout_s1;
  input            cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  input            cpu_0_data_master_read_data_valid_vibrato_on_s1;
  input            cpu_0_data_master_requests_adclrc_s1;
  input            cpu_0_data_master_requests_chorus_on_s1;
  input            cpu_0_data_master_requests_clk_s1;
  input            cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_requests_cpueffect_clock_0_in;
  input            cpu_0_data_master_requests_datain_s1;
  input            cpu_0_data_master_requests_dataout_s1;
  input            cpu_0_data_master_requests_onchip_memory2_0_s1;
  input            cpu_0_data_master_requests_vibrato_on_s1;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input   [ 15: 0] cpueffect_clock_0_in_readdata_from_sa;
  input            cpueffect_clock_0_in_waitrequest_from_sa;
  input            d1_adclrc_s1_end_xfer;
  input            d1_chorus_on_s1_end_xfer;
  input            d1_clk_s1_end_xfer;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_cpueffect_clock_0_in_end_xfer;
  input            d1_datain_s1_end_xfer;
  input            d1_dataout_s1_end_xfer;
  input            d1_onchip_memory2_0_s1_end_xfer;
  input            d1_vibrato_on_s1_end_xfer;
  input   [ 15: 0] datain_s1_readdata_from_sa;
  input   [ 15: 0] dataout_s1_readdata_from_sa;
  input   [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  input            reset_n;
  input            vibrato_on_s1_readdata_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 16: 0] cpu_0_data_master_address_last_time;
  wire    [ 16: 0] cpu_0_data_master_address_to_slave;
  reg     [  3: 0] cpu_0_data_master_byteenable_last_time;
  wire             cpu_0_data_master_is_granted_some_slave;
  reg              cpu_0_data_master_latency_counter;
  reg              cpu_0_data_master_read_but_no_slave_selected;
  reg              cpu_0_data_master_read_last_time;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_readdatavalid;
  wire             cpu_0_data_master_run;
  wire             cpu_0_data_master_waitrequest;
  reg              cpu_0_data_master_write_last_time;
  reg     [ 31: 0] cpu_0_data_master_writedata_last_time;
  wire             latency_load_value;
  wire             p1_cpu_0_data_master_latency_counter;
  wire             pre_flush_cpu_0_data_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_data_master_qualified_request_adclrc_s1 | ~cpu_0_data_master_requests_adclrc_s1) & ((~cpu_0_data_master_qualified_request_adclrc_s1 | ~cpu_0_data_master_read | (1 & ~d1_adclrc_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_adclrc_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_chorus_on_s1 | ~cpu_0_data_master_requests_chorus_on_s1) & ((~cpu_0_data_master_qualified_request_chorus_on_s1 | ~cpu_0_data_master_read | (1 & ~d1_chorus_on_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_chorus_on_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_clk_s1 | ~cpu_0_data_master_requests_clk_s1) & ((~cpu_0_data_master_qualified_request_clk_s1 | ~cpu_0_data_master_read | (1 & ~d1_clk_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_clk_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) & (cpu_0_data_master_granted_cpu_0_jtag_debug_module | ~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_cpueffect_clock_0_in | ~cpu_0_data_master_requests_cpueffect_clock_0_in) & ((~cpu_0_data_master_qualified_request_cpueffect_clock_0_in | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~cpueffect_clock_0_in_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write))));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_data_master_run = r_0 & r_1;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = ((~cpu_0_data_master_qualified_request_cpueffect_clock_0_in | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~cpueffect_clock_0_in_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & (cpu_0_data_master_qualified_request_datain_s1 | ~cpu_0_data_master_requests_datain_s1) & ((~cpu_0_data_master_qualified_request_datain_s1 | ~cpu_0_data_master_read | (1 & ~d1_datain_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_datain_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_dataout_s1 | ~cpu_0_data_master_requests_dataout_s1) & ((~cpu_0_data_master_qualified_request_dataout_s1 | ~cpu_0_data_master_read | (1 & ~d1_dataout_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_dataout_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | ~cpu_0_data_master_requests_onchip_memory2_0_s1) & (cpu_0_data_master_granted_onchip_memory2_0_s1 | ~cpu_0_data_master_qualified_request_onchip_memory2_0_s1) & ((~cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & (cpu_0_data_master_qualified_request_vibrato_on_s1 | ~cpu_0_data_master_requests_vibrato_on_s1) & ((~cpu_0_data_master_qualified_request_vibrato_on_s1 | ~cpu_0_data_master_read | (1 & ~d1_vibrato_on_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_vibrato_on_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_data_master_address_to_slave = cpu_0_data_master_address[16 : 0];

  //cpu_0_data_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_but_no_slave_selected <= 0;
      else 
        cpu_0_data_master_read_but_no_slave_selected <= cpu_0_data_master_read & cpu_0_data_master_run & ~cpu_0_data_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_0_data_master_is_granted_some_slave = cpu_0_data_master_granted_adclrc_s1 |
    cpu_0_data_master_granted_chorus_on_s1 |
    cpu_0_data_master_granted_clk_s1 |
    cpu_0_data_master_granted_cpu_0_jtag_debug_module |
    cpu_0_data_master_granted_cpueffect_clock_0_in |
    cpu_0_data_master_granted_datain_s1 |
    cpu_0_data_master_granted_dataout_s1 |
    cpu_0_data_master_granted_onchip_memory2_0_s1 |
    cpu_0_data_master_granted_vibrato_on_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_0_data_master_readdatavalid = cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_0_data_master_readdatavalid = cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_adclrc_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_chorus_on_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_clk_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_cpueffect_clock_0_in |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_datain_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_dataout_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_vibrato_on_s1;

  //cpu_0/data_master readdata mux, which is an e_mux
  assign cpu_0_data_master_readdata = ({32 {~(cpu_0_data_master_qualified_request_adclrc_s1 & cpu_0_data_master_read)}} | adclrc_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_chorus_on_s1 & cpu_0_data_master_read)}} | chorus_on_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_clk_s1 & cpu_0_data_master_read)}} | clk_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module & cpu_0_data_master_read)}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_cpueffect_clock_0_in & cpu_0_data_master_read)}} | cpueffect_clock_0_in_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_datain_s1 & cpu_0_data_master_read)}} | datain_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_dataout_s1 & cpu_0_data_master_read)}} | dataout_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_read_data_valid_onchip_memory2_0_s1}} | onchip_memory2_0_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_vibrato_on_s1 & cpu_0_data_master_read)}} | vibrato_on_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_assign
  assign cpu_0_data_master_waitrequest = ~cpu_0_data_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_latency_counter <= 0;
      else 
        cpu_0_data_master_latency_counter <= p1_cpu_0_data_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_0_data_master_latency_counter = ((cpu_0_data_master_run & cpu_0_data_master_read))? latency_load_value :
    (cpu_0_data_master_latency_counter)? cpu_0_data_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = {1 {cpu_0_data_master_requests_onchip_memory2_0_s1}} & 1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_data_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_address_last_time <= 0;
      else 
        cpu_0_data_master_address_last_time <= cpu_0_data_master_address;
    end


  //cpu_0/data_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_data_master_waitrequest & (cpu_0_data_master_read | cpu_0_data_master_write);
    end


  //cpu_0_data_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_address != cpu_0_data_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_byteenable_last_time <= 0;
      else 
        cpu_0_data_master_byteenable_last_time <= cpu_0_data_master_byteenable;
    end


  //cpu_0_data_master_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_byteenable != cpu_0_data_master_byteenable_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_last_time <= 0;
      else 
        cpu_0_data_master_read_last_time <= cpu_0_data_master_read;
    end


  //cpu_0_data_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_read != cpu_0_data_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_write_last_time <= 0;
      else 
        cpu_0_data_master_write_last_time <= cpu_0_data_master_write;
    end


  //cpu_0_data_master_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_write != cpu_0_data_master_write_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_writedata_last_time <= 0;
      else 
        cpu_0_data_master_writedata_last_time <= cpu_0_data_master_writedata;
    end


  //cpu_0_data_master_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_writedata != cpu_0_data_master_writedata_last_time) & cpu_0_data_master_write)
        begin
          $write("%0d ns: cpu_0_data_master_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_instruction_master_arbitrator (
                                             // inputs:
                                              clk,
                                              cpu_0_instruction_master_address,
                                              cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_granted_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_read,
                                              cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_requests_onchip_memory2_0_s1,
                                              cpu_0_jtag_debug_module_readdata_from_sa,
                                              d1_cpu_0_jtag_debug_module_end_xfer,
                                              d1_onchip_memory2_0_s1_end_xfer,
                                              onchip_memory2_0_s1_readdata_from_sa,
                                              reset_n,

                                             // outputs:
                                              cpu_0_instruction_master_address_to_slave,
                                              cpu_0_instruction_master_latency_counter,
                                              cpu_0_instruction_master_readdata,
                                              cpu_0_instruction_master_readdatavalid,
                                              cpu_0_instruction_master_waitrequest
                                           )
;

  output  [ 16: 0] cpu_0_instruction_master_address_to_slave;
  output           cpu_0_instruction_master_latency_counter;
  output  [ 31: 0] cpu_0_instruction_master_readdata;
  output           cpu_0_instruction_master_readdatavalid;
  output           cpu_0_instruction_master_waitrequest;
  input            clk;
  input   [ 16: 0] cpu_0_instruction_master_address;
  input            cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_onchip_memory2_0_s1_end_xfer;
  input   [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  input            reset_n;

  reg              active_and_waiting_last_time;
  reg     [ 16: 0] cpu_0_instruction_master_address_last_time;
  wire    [ 16: 0] cpu_0_instruction_master_address_to_slave;
  wire             cpu_0_instruction_master_is_granted_some_slave;
  reg              cpu_0_instruction_master_latency_counter;
  reg              cpu_0_instruction_master_read_but_no_slave_selected;
  reg              cpu_0_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_run;
  wire             cpu_0_instruction_master_waitrequest;
  wire             latency_load_value;
  wire             p1_cpu_0_instruction_master_latency_counter;
  wire             pre_flush_cpu_0_instruction_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) & (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_instruction_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_instruction_master_run = r_0 & r_1;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 | ~cpu_0_instruction_master_requests_onchip_memory2_0_s1) & (cpu_0_instruction_master_granted_onchip_memory2_0_s1 | ~cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1) & ((~cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 | ~(cpu_0_instruction_master_read) | (1 & (cpu_0_instruction_master_read))));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_instruction_master_address_to_slave = cpu_0_instruction_master_address[16 : 0];

  //cpu_0_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_but_no_slave_selected <= 0;
      else 
        cpu_0_instruction_master_read_but_no_slave_selected <= cpu_0_instruction_master_read & cpu_0_instruction_master_run & ~cpu_0_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_0_instruction_master_is_granted_some_slave = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_granted_onchip_memory2_0_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_0_instruction_master_readdatavalid = cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_0_instruction_master_readdatavalid = cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid |
    cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid;

  //cpu_0/instruction_master readdata mux, which is an e_mux
  assign cpu_0_instruction_master_readdata = ({32 {~(cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module & cpu_0_instruction_master_read)}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1}} | onchip_memory2_0_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_assign
  assign cpu_0_instruction_master_waitrequest = ~cpu_0_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_latency_counter <= 0;
      else 
        cpu_0_instruction_master_latency_counter <= p1_cpu_0_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_0_instruction_master_latency_counter = ((cpu_0_instruction_master_run & cpu_0_instruction_master_read))? latency_load_value :
    (cpu_0_instruction_master_latency_counter)? cpu_0_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = {1 {cpu_0_instruction_master_requests_onchip_memory2_0_s1}} & 1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_address_last_time <= 0;
      else 
        cpu_0_instruction_master_address_last_time <= cpu_0_instruction_master_address;
    end


  //cpu_0/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_instruction_master_waitrequest & (cpu_0_instruction_master_read);
    end


  //cpu_0_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_address != cpu_0_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_last_time <= 0;
      else 
        cpu_0_instruction_master_read_last_time <= cpu_0_instruction_master_read;
    end


  //cpu_0_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_read != cpu_0_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_fpoint_s1_arbitrator (
                                    // inputs:
                                     clk,
                                     cpu_0_custom_instruction_master_multi_clk_en,
                                     cpu_0_custom_instruction_master_multi_dataa,
                                     cpu_0_custom_instruction_master_multi_datab,
                                     cpu_0_custom_instruction_master_multi_n,
                                     cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1,
                                     cpu_0_fpoint_s1_done,
                                     cpu_0_fpoint_s1_result,
                                     cpu_0_fpoint_s1_select,
                                     reset_n,

                                    // outputs:
                                     cpu_0_fpoint_s1_clk_en,
                                     cpu_0_fpoint_s1_dataa,
                                     cpu_0_fpoint_s1_datab,
                                     cpu_0_fpoint_s1_done_from_sa,
                                     cpu_0_fpoint_s1_n,
                                     cpu_0_fpoint_s1_reset,
                                     cpu_0_fpoint_s1_result_from_sa,
                                     cpu_0_fpoint_s1_start
                                  )
;

  output           cpu_0_fpoint_s1_clk_en;
  output  [ 31: 0] cpu_0_fpoint_s1_dataa;
  output  [ 31: 0] cpu_0_fpoint_s1_datab;
  output           cpu_0_fpoint_s1_done_from_sa;
  output  [  1: 0] cpu_0_fpoint_s1_n;
  output           cpu_0_fpoint_s1_reset;
  output  [ 31: 0] cpu_0_fpoint_s1_result_from_sa;
  output           cpu_0_fpoint_s1_start;
  input            clk;
  input            cpu_0_custom_instruction_master_multi_clk_en;
  input   [ 31: 0] cpu_0_custom_instruction_master_multi_dataa;
  input   [ 31: 0] cpu_0_custom_instruction_master_multi_datab;
  input   [  7: 0] cpu_0_custom_instruction_master_multi_n;
  input            cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1;
  input            cpu_0_fpoint_s1_done;
  input   [ 31: 0] cpu_0_fpoint_s1_result;
  input            cpu_0_fpoint_s1_select;
  input            reset_n;

  wire             cpu_0_fpoint_s1_clk_en;
  wire    [ 31: 0] cpu_0_fpoint_s1_dataa;
  wire    [ 31: 0] cpu_0_fpoint_s1_datab;
  wire             cpu_0_fpoint_s1_done_from_sa;
  wire    [  1: 0] cpu_0_fpoint_s1_n;
  wire             cpu_0_fpoint_s1_reset;
  wire    [ 31: 0] cpu_0_fpoint_s1_result_from_sa;
  wire             cpu_0_fpoint_s1_start;
  assign cpu_0_fpoint_s1_clk_en = cpu_0_custom_instruction_master_multi_clk_en;
  assign cpu_0_fpoint_s1_dataa = cpu_0_custom_instruction_master_multi_dataa;
  assign cpu_0_fpoint_s1_datab = cpu_0_custom_instruction_master_multi_datab;
  assign cpu_0_fpoint_s1_n = cpu_0_custom_instruction_master_multi_n;
  assign cpu_0_fpoint_s1_start = cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1;
  //assign cpu_0_fpoint_s1_result_from_sa = cpu_0_fpoint_s1_result so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_fpoint_s1_result_from_sa = cpu_0_fpoint_s1_result;

  //assign cpu_0_fpoint_s1_done_from_sa = cpu_0_fpoint_s1_done so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_fpoint_s1_done_from_sa = cpu_0_fpoint_s1_done;

  //cpu_0_fpoint/s1 local reset_n, which is an e_assign
  assign cpu_0_fpoint_s1_reset = ~reset_n;


endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpueffect_clock_0_in_arbitrator (
                                         // inputs:
                                          clk,
                                          cpu_0_data_master_address_to_slave,
                                          cpu_0_data_master_byteenable,
                                          cpu_0_data_master_latency_counter,
                                          cpu_0_data_master_read,
                                          cpu_0_data_master_write,
                                          cpu_0_data_master_writedata,
                                          cpueffect_clock_0_in_endofpacket,
                                          cpueffect_clock_0_in_readdata,
                                          cpueffect_clock_0_in_waitrequest,
                                          reset_n,

                                         // outputs:
                                          cpu_0_data_master_granted_cpueffect_clock_0_in,
                                          cpu_0_data_master_qualified_request_cpueffect_clock_0_in,
                                          cpu_0_data_master_read_data_valid_cpueffect_clock_0_in,
                                          cpu_0_data_master_requests_cpueffect_clock_0_in,
                                          cpueffect_clock_0_in_address,
                                          cpueffect_clock_0_in_byteenable,
                                          cpueffect_clock_0_in_endofpacket_from_sa,
                                          cpueffect_clock_0_in_nativeaddress,
                                          cpueffect_clock_0_in_read,
                                          cpueffect_clock_0_in_readdata_from_sa,
                                          cpueffect_clock_0_in_reset_n,
                                          cpueffect_clock_0_in_waitrequest_from_sa,
                                          cpueffect_clock_0_in_write,
                                          cpueffect_clock_0_in_writedata,
                                          d1_cpueffect_clock_0_in_end_xfer
                                       )
;

  output           cpu_0_data_master_granted_cpueffect_clock_0_in;
  output           cpu_0_data_master_qualified_request_cpueffect_clock_0_in;
  output           cpu_0_data_master_read_data_valid_cpueffect_clock_0_in;
  output           cpu_0_data_master_requests_cpueffect_clock_0_in;
  output  [  3: 0] cpueffect_clock_0_in_address;
  output  [  1: 0] cpueffect_clock_0_in_byteenable;
  output           cpueffect_clock_0_in_endofpacket_from_sa;
  output  [  2: 0] cpueffect_clock_0_in_nativeaddress;
  output           cpueffect_clock_0_in_read;
  output  [ 15: 0] cpueffect_clock_0_in_readdata_from_sa;
  output           cpueffect_clock_0_in_reset_n;
  output           cpueffect_clock_0_in_waitrequest_from_sa;
  output           cpueffect_clock_0_in_write;
  output  [ 15: 0] cpueffect_clock_0_in_writedata;
  output           d1_cpueffect_clock_0_in_end_xfer;
  input            clk;
  input   [ 16: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            cpueffect_clock_0_in_endofpacket;
  input   [ 15: 0] cpueffect_clock_0_in_readdata;
  input            cpueffect_clock_0_in_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_cpueffect_clock_0_in;
  wire             cpu_0_data_master_qualified_request_cpueffect_clock_0_in;
  wire             cpu_0_data_master_read_data_valid_cpueffect_clock_0_in;
  wire             cpu_0_data_master_requests_cpueffect_clock_0_in;
  wire             cpu_0_data_master_saved_grant_cpueffect_clock_0_in;
  wire    [  3: 0] cpueffect_clock_0_in_address;
  wire             cpueffect_clock_0_in_allgrants;
  wire             cpueffect_clock_0_in_allow_new_arb_cycle;
  wire             cpueffect_clock_0_in_any_bursting_master_saved_grant;
  wire             cpueffect_clock_0_in_any_continuerequest;
  wire             cpueffect_clock_0_in_arb_counter_enable;
  reg              cpueffect_clock_0_in_arb_share_counter;
  wire             cpueffect_clock_0_in_arb_share_counter_next_value;
  wire             cpueffect_clock_0_in_arb_share_set_values;
  wire             cpueffect_clock_0_in_beginbursttransfer_internal;
  wire             cpueffect_clock_0_in_begins_xfer;
  wire    [  1: 0] cpueffect_clock_0_in_byteenable;
  wire             cpueffect_clock_0_in_end_xfer;
  wire             cpueffect_clock_0_in_endofpacket_from_sa;
  wire             cpueffect_clock_0_in_firsttransfer;
  wire             cpueffect_clock_0_in_grant_vector;
  wire             cpueffect_clock_0_in_in_a_read_cycle;
  wire             cpueffect_clock_0_in_in_a_write_cycle;
  wire             cpueffect_clock_0_in_master_qreq_vector;
  wire    [  2: 0] cpueffect_clock_0_in_nativeaddress;
  wire             cpueffect_clock_0_in_non_bursting_master_requests;
  wire             cpueffect_clock_0_in_read;
  wire    [ 15: 0] cpueffect_clock_0_in_readdata_from_sa;
  reg              cpueffect_clock_0_in_reg_firsttransfer;
  wire             cpueffect_clock_0_in_reset_n;
  reg              cpueffect_clock_0_in_slavearbiterlockenable;
  wire             cpueffect_clock_0_in_slavearbiterlockenable2;
  wire             cpueffect_clock_0_in_unreg_firsttransfer;
  wire             cpueffect_clock_0_in_waitrequest_from_sa;
  wire             cpueffect_clock_0_in_waits_for_read;
  wire             cpueffect_clock_0_in_waits_for_write;
  wire             cpueffect_clock_0_in_write;
  wire    [ 15: 0] cpueffect_clock_0_in_writedata;
  reg              d1_cpueffect_clock_0_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpueffect_clock_0_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 16: 0] shifted_address_to_cpueffect_clock_0_in_from_cpu_0_data_master;
  wire             wait_for_cpueffect_clock_0_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpueffect_clock_0_in_end_xfer;
    end


  assign cpueffect_clock_0_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_cpueffect_clock_0_in));
  //assign cpueffect_clock_0_in_readdata_from_sa = cpueffect_clock_0_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpueffect_clock_0_in_readdata_from_sa = cpueffect_clock_0_in_readdata;

  assign cpu_0_data_master_requests_cpueffect_clock_0_in = ({cpu_0_data_master_address_to_slave[16 : 5] , 5'b0} == 17'h11000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign cpueffect_clock_0_in_waitrequest_from_sa = cpueffect_clock_0_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpueffect_clock_0_in_waitrequest_from_sa = cpueffect_clock_0_in_waitrequest;

  //cpueffect_clock_0_in_arb_share_counter set values, which is an e_mux
  assign cpueffect_clock_0_in_arb_share_set_values = 1;

  //cpueffect_clock_0_in_non_bursting_master_requests mux, which is an e_mux
  assign cpueffect_clock_0_in_non_bursting_master_requests = cpu_0_data_master_requests_cpueffect_clock_0_in;

  //cpueffect_clock_0_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpueffect_clock_0_in_any_bursting_master_saved_grant = 0;

  //cpueffect_clock_0_in_arb_share_counter_next_value assignment, which is an e_assign
  assign cpueffect_clock_0_in_arb_share_counter_next_value = cpueffect_clock_0_in_firsttransfer ? (cpueffect_clock_0_in_arb_share_set_values - 1) : |cpueffect_clock_0_in_arb_share_counter ? (cpueffect_clock_0_in_arb_share_counter - 1) : 0;

  //cpueffect_clock_0_in_allgrants all slave grants, which is an e_mux
  assign cpueffect_clock_0_in_allgrants = |cpueffect_clock_0_in_grant_vector;

  //cpueffect_clock_0_in_end_xfer assignment, which is an e_assign
  assign cpueffect_clock_0_in_end_xfer = ~(cpueffect_clock_0_in_waits_for_read | cpueffect_clock_0_in_waits_for_write);

  //end_xfer_arb_share_counter_term_cpueffect_clock_0_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpueffect_clock_0_in = cpueffect_clock_0_in_end_xfer & (~cpueffect_clock_0_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpueffect_clock_0_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpueffect_clock_0_in_arb_counter_enable = (end_xfer_arb_share_counter_term_cpueffect_clock_0_in & cpueffect_clock_0_in_allgrants) | (end_xfer_arb_share_counter_term_cpueffect_clock_0_in & ~cpueffect_clock_0_in_non_bursting_master_requests);

  //cpueffect_clock_0_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpueffect_clock_0_in_arb_share_counter <= 0;
      else if (cpueffect_clock_0_in_arb_counter_enable)
          cpueffect_clock_0_in_arb_share_counter <= cpueffect_clock_0_in_arb_share_counter_next_value;
    end


  //cpueffect_clock_0_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpueffect_clock_0_in_slavearbiterlockenable <= 0;
      else if ((|cpueffect_clock_0_in_master_qreq_vector & end_xfer_arb_share_counter_term_cpueffect_clock_0_in) | (end_xfer_arb_share_counter_term_cpueffect_clock_0_in & ~cpueffect_clock_0_in_non_bursting_master_requests))
          cpueffect_clock_0_in_slavearbiterlockenable <= |cpueffect_clock_0_in_arb_share_counter_next_value;
    end


  //cpu_0/data_master cpueffect_clock_0/in arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = cpueffect_clock_0_in_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //cpueffect_clock_0_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpueffect_clock_0_in_slavearbiterlockenable2 = |cpueffect_clock_0_in_arb_share_counter_next_value;

  //cpu_0/data_master cpueffect_clock_0/in arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = cpueffect_clock_0_in_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpueffect_clock_0_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign cpueffect_clock_0_in_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_cpueffect_clock_0_in = cpu_0_data_master_requests_cpueffect_clock_0_in & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_cpueffect_clock_0_in, which is an e_mux
  assign cpu_0_data_master_read_data_valid_cpueffect_clock_0_in = cpu_0_data_master_granted_cpueffect_clock_0_in & cpu_0_data_master_read & ~cpueffect_clock_0_in_waits_for_read;

  //cpueffect_clock_0_in_writedata mux, which is an e_mux
  assign cpueffect_clock_0_in_writedata = cpu_0_data_master_writedata;

  //assign cpueffect_clock_0_in_endofpacket_from_sa = cpueffect_clock_0_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpueffect_clock_0_in_endofpacket_from_sa = cpueffect_clock_0_in_endofpacket;

  //master is always granted when requested
  assign cpu_0_data_master_granted_cpueffect_clock_0_in = cpu_0_data_master_qualified_request_cpueffect_clock_0_in;

  //cpu_0/data_master saved-grant cpueffect_clock_0/in, which is an e_assign
  assign cpu_0_data_master_saved_grant_cpueffect_clock_0_in = cpu_0_data_master_requests_cpueffect_clock_0_in;

  //allow new arb cycle for cpueffect_clock_0/in, which is an e_assign
  assign cpueffect_clock_0_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign cpueffect_clock_0_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign cpueffect_clock_0_in_master_qreq_vector = 1;

  //cpueffect_clock_0_in_reset_n assignment, which is an e_assign
  assign cpueffect_clock_0_in_reset_n = reset_n;

  //cpueffect_clock_0_in_firsttransfer first transaction, which is an e_assign
  assign cpueffect_clock_0_in_firsttransfer = cpueffect_clock_0_in_begins_xfer ? cpueffect_clock_0_in_unreg_firsttransfer : cpueffect_clock_0_in_reg_firsttransfer;

  //cpueffect_clock_0_in_unreg_firsttransfer first transaction, which is an e_assign
  assign cpueffect_clock_0_in_unreg_firsttransfer = ~(cpueffect_clock_0_in_slavearbiterlockenable & cpueffect_clock_0_in_any_continuerequest);

  //cpueffect_clock_0_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpueffect_clock_0_in_reg_firsttransfer <= 1'b1;
      else if (cpueffect_clock_0_in_begins_xfer)
          cpueffect_clock_0_in_reg_firsttransfer <= cpueffect_clock_0_in_unreg_firsttransfer;
    end


  //cpueffect_clock_0_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpueffect_clock_0_in_beginbursttransfer_internal = cpueffect_clock_0_in_begins_xfer;

  //cpueffect_clock_0_in_read assignment, which is an e_mux
  assign cpueffect_clock_0_in_read = cpu_0_data_master_granted_cpueffect_clock_0_in & cpu_0_data_master_read;

  //cpueffect_clock_0_in_write assignment, which is an e_mux
  assign cpueffect_clock_0_in_write = cpu_0_data_master_granted_cpueffect_clock_0_in & cpu_0_data_master_write;

  assign shifted_address_to_cpueffect_clock_0_in_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //cpueffect_clock_0_in_address mux, which is an e_mux
  assign cpueffect_clock_0_in_address = shifted_address_to_cpueffect_clock_0_in_from_cpu_0_data_master >> 2;

  //slaveid cpueffect_clock_0_in_nativeaddress nativeaddress mux, which is an e_mux
  assign cpueffect_clock_0_in_nativeaddress = cpu_0_data_master_address_to_slave >> 2;

  //d1_cpueffect_clock_0_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpueffect_clock_0_in_end_xfer <= 1;
      else 
        d1_cpueffect_clock_0_in_end_xfer <= cpueffect_clock_0_in_end_xfer;
    end


  //cpueffect_clock_0_in_waits_for_read in a cycle, which is an e_mux
  assign cpueffect_clock_0_in_waits_for_read = cpueffect_clock_0_in_in_a_read_cycle & cpueffect_clock_0_in_waitrequest_from_sa;

  //cpueffect_clock_0_in_in_a_read_cycle assignment, which is an e_assign
  assign cpueffect_clock_0_in_in_a_read_cycle = cpu_0_data_master_granted_cpueffect_clock_0_in & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpueffect_clock_0_in_in_a_read_cycle;

  //cpueffect_clock_0_in_waits_for_write in a cycle, which is an e_mux
  assign cpueffect_clock_0_in_waits_for_write = cpueffect_clock_0_in_in_a_write_cycle & cpueffect_clock_0_in_waitrequest_from_sa;

  //cpueffect_clock_0_in_in_a_write_cycle assignment, which is an e_assign
  assign cpueffect_clock_0_in_in_a_write_cycle = cpu_0_data_master_granted_cpueffect_clock_0_in & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpueffect_clock_0_in_in_a_write_cycle;

  assign wait_for_cpueffect_clock_0_in_counter = 0;
  //cpueffect_clock_0_in_byteenable byte enable port mux, which is an e_mux
  assign cpueffect_clock_0_in_byteenable = (cpu_0_data_master_granted_cpueffect_clock_0_in)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpueffect_clock_0/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpueffect_clock_0_out_arbitrator (
                                          // inputs:
                                           clk,
                                           cpueffect_clock_0_out_address,
                                           cpueffect_clock_0_out_byteenable,
                                           cpueffect_clock_0_out_granted_pll_0_s1,
                                           cpueffect_clock_0_out_qualified_request_pll_0_s1,
                                           cpueffect_clock_0_out_read,
                                           cpueffect_clock_0_out_read_data_valid_pll_0_s1,
                                           cpueffect_clock_0_out_requests_pll_0_s1,
                                           cpueffect_clock_0_out_write,
                                           cpueffect_clock_0_out_writedata,
                                           d1_pll_0_s1_end_xfer,
                                           pll_0_s1_readdata_from_sa,
                                           reset_n,

                                          // outputs:
                                           cpueffect_clock_0_out_address_to_slave,
                                           cpueffect_clock_0_out_readdata,
                                           cpueffect_clock_0_out_reset_n,
                                           cpueffect_clock_0_out_waitrequest
                                        )
;

  output  [  3: 0] cpueffect_clock_0_out_address_to_slave;
  output  [ 15: 0] cpueffect_clock_0_out_readdata;
  output           cpueffect_clock_0_out_reset_n;
  output           cpueffect_clock_0_out_waitrequest;
  input            clk;
  input   [  3: 0] cpueffect_clock_0_out_address;
  input   [  1: 0] cpueffect_clock_0_out_byteenable;
  input            cpueffect_clock_0_out_granted_pll_0_s1;
  input            cpueffect_clock_0_out_qualified_request_pll_0_s1;
  input            cpueffect_clock_0_out_read;
  input            cpueffect_clock_0_out_read_data_valid_pll_0_s1;
  input            cpueffect_clock_0_out_requests_pll_0_s1;
  input            cpueffect_clock_0_out_write;
  input   [ 15: 0] cpueffect_clock_0_out_writedata;
  input            d1_pll_0_s1_end_xfer;
  input   [ 15: 0] pll_0_s1_readdata_from_sa;
  input            reset_n;

  reg              active_and_waiting_last_time;
  reg     [  3: 0] cpueffect_clock_0_out_address_last_time;
  wire    [  3: 0] cpueffect_clock_0_out_address_to_slave;
  reg     [  1: 0] cpueffect_clock_0_out_byteenable_last_time;
  reg              cpueffect_clock_0_out_read_last_time;
  wire    [ 15: 0] cpueffect_clock_0_out_readdata;
  wire             cpueffect_clock_0_out_reset_n;
  wire             cpueffect_clock_0_out_run;
  wire             cpueffect_clock_0_out_waitrequest;
  reg              cpueffect_clock_0_out_write_last_time;
  reg     [ 15: 0] cpueffect_clock_0_out_writedata_last_time;
  wire             r_1;
  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & ((~cpueffect_clock_0_out_qualified_request_pll_0_s1 | ~cpueffect_clock_0_out_read | (1 & ~d1_pll_0_s1_end_xfer & cpueffect_clock_0_out_read))) & ((~cpueffect_clock_0_out_qualified_request_pll_0_s1 | ~cpueffect_clock_0_out_write | (1 & cpueffect_clock_0_out_write)));

  //cascaded wait assignment, which is an e_assign
  assign cpueffect_clock_0_out_run = r_1;

  //optimize select-logic by passing only those address bits which matter.
  assign cpueffect_clock_0_out_address_to_slave = cpueffect_clock_0_out_address;

  //cpueffect_clock_0/out readdata mux, which is an e_mux
  assign cpueffect_clock_0_out_readdata = pll_0_s1_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign cpueffect_clock_0_out_waitrequest = ~cpueffect_clock_0_out_run;

  //cpueffect_clock_0_out_reset_n assignment, which is an e_assign
  assign cpueffect_clock_0_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpueffect_clock_0_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpueffect_clock_0_out_address_last_time <= 0;
      else 
        cpueffect_clock_0_out_address_last_time <= cpueffect_clock_0_out_address;
    end


  //cpueffect_clock_0/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpueffect_clock_0_out_waitrequest & (cpueffect_clock_0_out_read | cpueffect_clock_0_out_write);
    end


  //cpueffect_clock_0_out_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpueffect_clock_0_out_address != cpueffect_clock_0_out_address_last_time))
        begin
          $write("%0d ns: cpueffect_clock_0_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpueffect_clock_0_out_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpueffect_clock_0_out_byteenable_last_time <= 0;
      else 
        cpueffect_clock_0_out_byteenable_last_time <= cpueffect_clock_0_out_byteenable;
    end


  //cpueffect_clock_0_out_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpueffect_clock_0_out_byteenable != cpueffect_clock_0_out_byteenable_last_time))
        begin
          $write("%0d ns: cpueffect_clock_0_out_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpueffect_clock_0_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpueffect_clock_0_out_read_last_time <= 0;
      else 
        cpueffect_clock_0_out_read_last_time <= cpueffect_clock_0_out_read;
    end


  //cpueffect_clock_0_out_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpueffect_clock_0_out_read != cpueffect_clock_0_out_read_last_time))
        begin
          $write("%0d ns: cpueffect_clock_0_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpueffect_clock_0_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpueffect_clock_0_out_write_last_time <= 0;
      else 
        cpueffect_clock_0_out_write_last_time <= cpueffect_clock_0_out_write;
    end


  //cpueffect_clock_0_out_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpueffect_clock_0_out_write != cpueffect_clock_0_out_write_last_time))
        begin
          $write("%0d ns: cpueffect_clock_0_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpueffect_clock_0_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpueffect_clock_0_out_writedata_last_time <= 0;
      else 
        cpueffect_clock_0_out_writedata_last_time <= cpueffect_clock_0_out_writedata;
    end


  //cpueffect_clock_0_out_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpueffect_clock_0_out_writedata != cpueffect_clock_0_out_writedata_last_time) & cpueffect_clock_0_out_write)
        begin
          $write("%0d ns: cpueffect_clock_0_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module datain_s1_arbitrator (
                              // inputs:
                               clk,
                               cpu_0_data_master_address_to_slave,
                               cpu_0_data_master_latency_counter,
                               cpu_0_data_master_read,
                               cpu_0_data_master_write,
                               datain_s1_readdata,
                               reset_n,

                              // outputs:
                               cpu_0_data_master_granted_datain_s1,
                               cpu_0_data_master_qualified_request_datain_s1,
                               cpu_0_data_master_read_data_valid_datain_s1,
                               cpu_0_data_master_requests_datain_s1,
                               d1_datain_s1_end_xfer,
                               datain_s1_address,
                               datain_s1_readdata_from_sa,
                               datain_s1_reset_n
                            )
;

  output           cpu_0_data_master_granted_datain_s1;
  output           cpu_0_data_master_qualified_request_datain_s1;
  output           cpu_0_data_master_read_data_valid_datain_s1;
  output           cpu_0_data_master_requests_datain_s1;
  output           d1_datain_s1_end_xfer;
  output  [  1: 0] datain_s1_address;
  output  [ 15: 0] datain_s1_readdata_from_sa;
  output           datain_s1_reset_n;
  input            clk;
  input   [ 16: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 15: 0] datain_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_datain_s1;
  wire             cpu_0_data_master_qualified_request_datain_s1;
  wire             cpu_0_data_master_read_data_valid_datain_s1;
  wire             cpu_0_data_master_requests_datain_s1;
  wire             cpu_0_data_master_saved_grant_datain_s1;
  reg              d1_datain_s1_end_xfer;
  reg              d1_reasons_to_wait;
  wire    [  1: 0] datain_s1_address;
  wire             datain_s1_allgrants;
  wire             datain_s1_allow_new_arb_cycle;
  wire             datain_s1_any_bursting_master_saved_grant;
  wire             datain_s1_any_continuerequest;
  wire             datain_s1_arb_counter_enable;
  reg              datain_s1_arb_share_counter;
  wire             datain_s1_arb_share_counter_next_value;
  wire             datain_s1_arb_share_set_values;
  wire             datain_s1_beginbursttransfer_internal;
  wire             datain_s1_begins_xfer;
  wire             datain_s1_end_xfer;
  wire             datain_s1_firsttransfer;
  wire             datain_s1_grant_vector;
  wire             datain_s1_in_a_read_cycle;
  wire             datain_s1_in_a_write_cycle;
  wire             datain_s1_master_qreq_vector;
  wire             datain_s1_non_bursting_master_requests;
  wire    [ 15: 0] datain_s1_readdata_from_sa;
  reg              datain_s1_reg_firsttransfer;
  wire             datain_s1_reset_n;
  reg              datain_s1_slavearbiterlockenable;
  wire             datain_s1_slavearbiterlockenable2;
  wire             datain_s1_unreg_firsttransfer;
  wire             datain_s1_waits_for_read;
  wire             datain_s1_waits_for_write;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_datain_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 16: 0] shifted_address_to_datain_s1_from_cpu_0_data_master;
  wire             wait_for_datain_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~datain_s1_end_xfer;
    end


  assign datain_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_datain_s1));
  //assign datain_s1_readdata_from_sa = datain_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign datain_s1_readdata_from_sa = datain_s1_readdata;

  assign cpu_0_data_master_requests_datain_s1 = (({cpu_0_data_master_address_to_slave[16 : 4] , 4'b0} == 17'h11060) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //datain_s1_arb_share_counter set values, which is an e_mux
  assign datain_s1_arb_share_set_values = 1;

  //datain_s1_non_bursting_master_requests mux, which is an e_mux
  assign datain_s1_non_bursting_master_requests = cpu_0_data_master_requests_datain_s1;

  //datain_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign datain_s1_any_bursting_master_saved_grant = 0;

  //datain_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign datain_s1_arb_share_counter_next_value = datain_s1_firsttransfer ? (datain_s1_arb_share_set_values - 1) : |datain_s1_arb_share_counter ? (datain_s1_arb_share_counter - 1) : 0;

  //datain_s1_allgrants all slave grants, which is an e_mux
  assign datain_s1_allgrants = |datain_s1_grant_vector;

  //datain_s1_end_xfer assignment, which is an e_assign
  assign datain_s1_end_xfer = ~(datain_s1_waits_for_read | datain_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_datain_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_datain_s1 = datain_s1_end_xfer & (~datain_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //datain_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign datain_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_datain_s1 & datain_s1_allgrants) | (end_xfer_arb_share_counter_term_datain_s1 & ~datain_s1_non_bursting_master_requests);

  //datain_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          datain_s1_arb_share_counter <= 0;
      else if (datain_s1_arb_counter_enable)
          datain_s1_arb_share_counter <= datain_s1_arb_share_counter_next_value;
    end


  //datain_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          datain_s1_slavearbiterlockenable <= 0;
      else if ((|datain_s1_master_qreq_vector & end_xfer_arb_share_counter_term_datain_s1) | (end_xfer_arb_share_counter_term_datain_s1 & ~datain_s1_non_bursting_master_requests))
          datain_s1_slavearbiterlockenable <= |datain_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master datain/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = datain_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //datain_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign datain_s1_slavearbiterlockenable2 = |datain_s1_arb_share_counter_next_value;

  //cpu_0/data_master datain/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = datain_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //datain_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign datain_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_datain_s1 = cpu_0_data_master_requests_datain_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_datain_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_datain_s1 = cpu_0_data_master_granted_datain_s1 & cpu_0_data_master_read & ~datain_s1_waits_for_read;

  //master is always granted when requested
  assign cpu_0_data_master_granted_datain_s1 = cpu_0_data_master_qualified_request_datain_s1;

  //cpu_0/data_master saved-grant datain/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_datain_s1 = cpu_0_data_master_requests_datain_s1;

  //allow new arb cycle for datain/s1, which is an e_assign
  assign datain_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign datain_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign datain_s1_master_qreq_vector = 1;

  //datain_s1_reset_n assignment, which is an e_assign
  assign datain_s1_reset_n = reset_n;

  //datain_s1_firsttransfer first transaction, which is an e_assign
  assign datain_s1_firsttransfer = datain_s1_begins_xfer ? datain_s1_unreg_firsttransfer : datain_s1_reg_firsttransfer;

  //datain_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign datain_s1_unreg_firsttransfer = ~(datain_s1_slavearbiterlockenable & datain_s1_any_continuerequest);

  //datain_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          datain_s1_reg_firsttransfer <= 1'b1;
      else if (datain_s1_begins_xfer)
          datain_s1_reg_firsttransfer <= datain_s1_unreg_firsttransfer;
    end


  //datain_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign datain_s1_beginbursttransfer_internal = datain_s1_begins_xfer;

  assign shifted_address_to_datain_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //datain_s1_address mux, which is an e_mux
  assign datain_s1_address = shifted_address_to_datain_s1_from_cpu_0_data_master >> 2;

  //d1_datain_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_datain_s1_end_xfer <= 1;
      else 
        d1_datain_s1_end_xfer <= datain_s1_end_xfer;
    end


  //datain_s1_waits_for_read in a cycle, which is an e_mux
  assign datain_s1_waits_for_read = datain_s1_in_a_read_cycle & datain_s1_begins_xfer;

  //datain_s1_in_a_read_cycle assignment, which is an e_assign
  assign datain_s1_in_a_read_cycle = cpu_0_data_master_granted_datain_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = datain_s1_in_a_read_cycle;

  //datain_s1_waits_for_write in a cycle, which is an e_mux
  assign datain_s1_waits_for_write = datain_s1_in_a_write_cycle & 0;

  //datain_s1_in_a_write_cycle assignment, which is an e_assign
  assign datain_s1_in_a_write_cycle = cpu_0_data_master_granted_datain_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = datain_s1_in_a_write_cycle;

  assign wait_for_datain_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //datain/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module dataout_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_latency_counter,
                                cpu_0_data_master_read,
                                cpu_0_data_master_write,
                                cpu_0_data_master_writedata,
                                dataout_s1_readdata,
                                reset_n,

                               // outputs:
                                cpu_0_data_master_granted_dataout_s1,
                                cpu_0_data_master_qualified_request_dataout_s1,
                                cpu_0_data_master_read_data_valid_dataout_s1,
                                cpu_0_data_master_requests_dataout_s1,
                                d1_dataout_s1_end_xfer,
                                dataout_s1_address,
                                dataout_s1_chipselect,
                                dataout_s1_readdata_from_sa,
                                dataout_s1_reset_n,
                                dataout_s1_write_n,
                                dataout_s1_writedata
                             )
;

  output           cpu_0_data_master_granted_dataout_s1;
  output           cpu_0_data_master_qualified_request_dataout_s1;
  output           cpu_0_data_master_read_data_valid_dataout_s1;
  output           cpu_0_data_master_requests_dataout_s1;
  output           d1_dataout_s1_end_xfer;
  output  [  1: 0] dataout_s1_address;
  output           dataout_s1_chipselect;
  output  [ 15: 0] dataout_s1_readdata_from_sa;
  output           dataout_s1_reset_n;
  output           dataout_s1_write_n;
  output  [ 15: 0] dataout_s1_writedata;
  input            clk;
  input   [ 16: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 15: 0] dataout_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_dataout_s1;
  wire             cpu_0_data_master_qualified_request_dataout_s1;
  wire             cpu_0_data_master_read_data_valid_dataout_s1;
  wire             cpu_0_data_master_requests_dataout_s1;
  wire             cpu_0_data_master_saved_grant_dataout_s1;
  reg              d1_dataout_s1_end_xfer;
  reg              d1_reasons_to_wait;
  wire    [  1: 0] dataout_s1_address;
  wire             dataout_s1_allgrants;
  wire             dataout_s1_allow_new_arb_cycle;
  wire             dataout_s1_any_bursting_master_saved_grant;
  wire             dataout_s1_any_continuerequest;
  wire             dataout_s1_arb_counter_enable;
  reg              dataout_s1_arb_share_counter;
  wire             dataout_s1_arb_share_counter_next_value;
  wire             dataout_s1_arb_share_set_values;
  wire             dataout_s1_beginbursttransfer_internal;
  wire             dataout_s1_begins_xfer;
  wire             dataout_s1_chipselect;
  wire             dataout_s1_end_xfer;
  wire             dataout_s1_firsttransfer;
  wire             dataout_s1_grant_vector;
  wire             dataout_s1_in_a_read_cycle;
  wire             dataout_s1_in_a_write_cycle;
  wire             dataout_s1_master_qreq_vector;
  wire             dataout_s1_non_bursting_master_requests;
  wire    [ 15: 0] dataout_s1_readdata_from_sa;
  reg              dataout_s1_reg_firsttransfer;
  wire             dataout_s1_reset_n;
  reg              dataout_s1_slavearbiterlockenable;
  wire             dataout_s1_slavearbiterlockenable2;
  wire             dataout_s1_unreg_firsttransfer;
  wire             dataout_s1_waits_for_read;
  wire             dataout_s1_waits_for_write;
  wire             dataout_s1_write_n;
  wire    [ 15: 0] dataout_s1_writedata;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_dataout_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 16: 0] shifted_address_to_dataout_s1_from_cpu_0_data_master;
  wire             wait_for_dataout_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~dataout_s1_end_xfer;
    end


  assign dataout_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_dataout_s1));
  //assign dataout_s1_readdata_from_sa = dataout_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign dataout_s1_readdata_from_sa = dataout_s1_readdata;

  assign cpu_0_data_master_requests_dataout_s1 = ({cpu_0_data_master_address_to_slave[16 : 4] , 4'b0} == 17'h11070) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //dataout_s1_arb_share_counter set values, which is an e_mux
  assign dataout_s1_arb_share_set_values = 1;

  //dataout_s1_non_bursting_master_requests mux, which is an e_mux
  assign dataout_s1_non_bursting_master_requests = cpu_0_data_master_requests_dataout_s1;

  //dataout_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign dataout_s1_any_bursting_master_saved_grant = 0;

  //dataout_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign dataout_s1_arb_share_counter_next_value = dataout_s1_firsttransfer ? (dataout_s1_arb_share_set_values - 1) : |dataout_s1_arb_share_counter ? (dataout_s1_arb_share_counter - 1) : 0;

  //dataout_s1_allgrants all slave grants, which is an e_mux
  assign dataout_s1_allgrants = |dataout_s1_grant_vector;

  //dataout_s1_end_xfer assignment, which is an e_assign
  assign dataout_s1_end_xfer = ~(dataout_s1_waits_for_read | dataout_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_dataout_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_dataout_s1 = dataout_s1_end_xfer & (~dataout_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //dataout_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign dataout_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_dataout_s1 & dataout_s1_allgrants) | (end_xfer_arb_share_counter_term_dataout_s1 & ~dataout_s1_non_bursting_master_requests);

  //dataout_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dataout_s1_arb_share_counter <= 0;
      else if (dataout_s1_arb_counter_enable)
          dataout_s1_arb_share_counter <= dataout_s1_arb_share_counter_next_value;
    end


  //dataout_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dataout_s1_slavearbiterlockenable <= 0;
      else if ((|dataout_s1_master_qreq_vector & end_xfer_arb_share_counter_term_dataout_s1) | (end_xfer_arb_share_counter_term_dataout_s1 & ~dataout_s1_non_bursting_master_requests))
          dataout_s1_slavearbiterlockenable <= |dataout_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master dataout/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = dataout_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //dataout_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign dataout_s1_slavearbiterlockenable2 = |dataout_s1_arb_share_counter_next_value;

  //cpu_0/data_master dataout/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = dataout_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //dataout_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign dataout_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_dataout_s1 = cpu_0_data_master_requests_dataout_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_dataout_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_dataout_s1 = cpu_0_data_master_granted_dataout_s1 & cpu_0_data_master_read & ~dataout_s1_waits_for_read;

  //dataout_s1_writedata mux, which is an e_mux
  assign dataout_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_dataout_s1 = cpu_0_data_master_qualified_request_dataout_s1;

  //cpu_0/data_master saved-grant dataout/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_dataout_s1 = cpu_0_data_master_requests_dataout_s1;

  //allow new arb cycle for dataout/s1, which is an e_assign
  assign dataout_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign dataout_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign dataout_s1_master_qreq_vector = 1;

  //dataout_s1_reset_n assignment, which is an e_assign
  assign dataout_s1_reset_n = reset_n;

  assign dataout_s1_chipselect = cpu_0_data_master_granted_dataout_s1;
  //dataout_s1_firsttransfer first transaction, which is an e_assign
  assign dataout_s1_firsttransfer = dataout_s1_begins_xfer ? dataout_s1_unreg_firsttransfer : dataout_s1_reg_firsttransfer;

  //dataout_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign dataout_s1_unreg_firsttransfer = ~(dataout_s1_slavearbiterlockenable & dataout_s1_any_continuerequest);

  //dataout_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dataout_s1_reg_firsttransfer <= 1'b1;
      else if (dataout_s1_begins_xfer)
          dataout_s1_reg_firsttransfer <= dataout_s1_unreg_firsttransfer;
    end


  //dataout_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign dataout_s1_beginbursttransfer_internal = dataout_s1_begins_xfer;

  //~dataout_s1_write_n assignment, which is an e_mux
  assign dataout_s1_write_n = ~(cpu_0_data_master_granted_dataout_s1 & cpu_0_data_master_write);

  assign shifted_address_to_dataout_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //dataout_s1_address mux, which is an e_mux
  assign dataout_s1_address = shifted_address_to_dataout_s1_from_cpu_0_data_master >> 2;

  //d1_dataout_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_dataout_s1_end_xfer <= 1;
      else 
        d1_dataout_s1_end_xfer <= dataout_s1_end_xfer;
    end


  //dataout_s1_waits_for_read in a cycle, which is an e_mux
  assign dataout_s1_waits_for_read = dataout_s1_in_a_read_cycle & dataout_s1_begins_xfer;

  //dataout_s1_in_a_read_cycle assignment, which is an e_assign
  assign dataout_s1_in_a_read_cycle = cpu_0_data_master_granted_dataout_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = dataout_s1_in_a_read_cycle;

  //dataout_s1_waits_for_write in a cycle, which is an e_mux
  assign dataout_s1_waits_for_write = dataout_s1_in_a_write_cycle & 0;

  //dataout_s1_in_a_write_cycle assignment, which is an e_assign
  assign dataout_s1_in_a_write_cycle = cpu_0_data_master_granted_dataout_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = dataout_s1_in_a_write_cycle;

  assign wait_for_dataout_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //dataout/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module onchip_memory2_0_s1_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_byteenable,
                                         cpu_0_data_master_latency_counter,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_write,
                                         cpu_0_data_master_writedata,
                                         cpu_0_instruction_master_address_to_slave,
                                         cpu_0_instruction_master_latency_counter,
                                         cpu_0_instruction_master_read,
                                         onchip_memory2_0_s1_readdata,
                                         reset_n,

                                        // outputs:
                                         cpu_0_data_master_granted_onchip_memory2_0_s1,
                                         cpu_0_data_master_qualified_request_onchip_memory2_0_s1,
                                         cpu_0_data_master_read_data_valid_onchip_memory2_0_s1,
                                         cpu_0_data_master_requests_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_granted_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_requests_onchip_memory2_0_s1,
                                         d1_onchip_memory2_0_s1_end_xfer,
                                         onchip_memory2_0_s1_address,
                                         onchip_memory2_0_s1_byteenable,
                                         onchip_memory2_0_s1_chipselect,
                                         onchip_memory2_0_s1_clken,
                                         onchip_memory2_0_s1_readdata_from_sa,
                                         onchip_memory2_0_s1_write,
                                         onchip_memory2_0_s1_writedata
                                      )
;

  output           cpu_0_data_master_granted_onchip_memory2_0_s1;
  output           cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  output           cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  output           cpu_0_data_master_requests_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  output           d1_onchip_memory2_0_s1_end_xfer;
  output  [ 12: 0] onchip_memory2_0_s1_address;
  output  [  3: 0] onchip_memory2_0_s1_byteenable;
  output           onchip_memory2_0_s1_chipselect;
  output           onchip_memory2_0_s1_clken;
  output  [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  output           onchip_memory2_0_s1_write;
  output  [ 31: 0] onchip_memory2_0_s1_writedata;
  input            clk;
  input   [ 16: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 16: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input   [ 31: 0] onchip_memory2_0_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  reg              cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in;
  wire             cpu_0_data_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_data_master_saved_grant_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  reg              cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in;
  wire             cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1;
  reg              d1_onchip_memory2_0_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_onchip_memory2_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1;
  wire    [ 12: 0] onchip_memory2_0_s1_address;
  wire             onchip_memory2_0_s1_allgrants;
  wire             onchip_memory2_0_s1_allow_new_arb_cycle;
  wire             onchip_memory2_0_s1_any_bursting_master_saved_grant;
  wire             onchip_memory2_0_s1_any_continuerequest;
  reg     [  1: 0] onchip_memory2_0_s1_arb_addend;
  wire             onchip_memory2_0_s1_arb_counter_enable;
  reg              onchip_memory2_0_s1_arb_share_counter;
  wire             onchip_memory2_0_s1_arb_share_counter_next_value;
  wire             onchip_memory2_0_s1_arb_share_set_values;
  wire    [  1: 0] onchip_memory2_0_s1_arb_winner;
  wire             onchip_memory2_0_s1_arbitration_holdoff_internal;
  wire             onchip_memory2_0_s1_beginbursttransfer_internal;
  wire             onchip_memory2_0_s1_begins_xfer;
  wire    [  3: 0] onchip_memory2_0_s1_byteenable;
  wire             onchip_memory2_0_s1_chipselect;
  wire    [  3: 0] onchip_memory2_0_s1_chosen_master_double_vector;
  wire    [  1: 0] onchip_memory2_0_s1_chosen_master_rot_left;
  wire             onchip_memory2_0_s1_clken;
  wire             onchip_memory2_0_s1_end_xfer;
  wire             onchip_memory2_0_s1_firsttransfer;
  wire    [  1: 0] onchip_memory2_0_s1_grant_vector;
  wire             onchip_memory2_0_s1_in_a_read_cycle;
  wire             onchip_memory2_0_s1_in_a_write_cycle;
  wire    [  1: 0] onchip_memory2_0_s1_master_qreq_vector;
  wire             onchip_memory2_0_s1_non_bursting_master_requests;
  wire    [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  reg              onchip_memory2_0_s1_reg_firsttransfer;
  reg     [  1: 0] onchip_memory2_0_s1_saved_chosen_master_vector;
  reg              onchip_memory2_0_s1_slavearbiterlockenable;
  wire             onchip_memory2_0_s1_slavearbiterlockenable2;
  wire             onchip_memory2_0_s1_unreg_firsttransfer;
  wire             onchip_memory2_0_s1_waits_for_read;
  wire             onchip_memory2_0_s1_waits_for_write;
  wire             onchip_memory2_0_s1_write;
  wire    [ 31: 0] onchip_memory2_0_s1_writedata;
  wire             p1_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             p1_cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire    [ 16: 0] shifted_address_to_onchip_memory2_0_s1_from_cpu_0_data_master;
  wire    [ 16: 0] shifted_address_to_onchip_memory2_0_s1_from_cpu_0_instruction_master;
  wire             wait_for_onchip_memory2_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~onchip_memory2_0_s1_end_xfer;
    end


  assign onchip_memory2_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1));
  //assign onchip_memory2_0_s1_readdata_from_sa = onchip_memory2_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign onchip_memory2_0_s1_readdata_from_sa = onchip_memory2_0_s1_readdata;

  assign cpu_0_data_master_requests_onchip_memory2_0_s1 = ({cpu_0_data_master_address_to_slave[16 : 15] , 15'b0} == 17'h8000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //onchip_memory2_0_s1_arb_share_counter set values, which is an e_mux
  assign onchip_memory2_0_s1_arb_share_set_values = 1;

  //onchip_memory2_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign onchip_memory2_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_onchip_memory2_0_s1 |
    cpu_0_instruction_master_requests_onchip_memory2_0_s1 |
    cpu_0_data_master_requests_onchip_memory2_0_s1 |
    cpu_0_instruction_master_requests_onchip_memory2_0_s1;

  //onchip_memory2_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign onchip_memory2_0_s1_any_bursting_master_saved_grant = 0;

  //onchip_memory2_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign onchip_memory2_0_s1_arb_share_counter_next_value = onchip_memory2_0_s1_firsttransfer ? (onchip_memory2_0_s1_arb_share_set_values - 1) : |onchip_memory2_0_s1_arb_share_counter ? (onchip_memory2_0_s1_arb_share_counter - 1) : 0;

  //onchip_memory2_0_s1_allgrants all slave grants, which is an e_mux
  assign onchip_memory2_0_s1_allgrants = (|onchip_memory2_0_s1_grant_vector) |
    (|onchip_memory2_0_s1_grant_vector) |
    (|onchip_memory2_0_s1_grant_vector) |
    (|onchip_memory2_0_s1_grant_vector);

  //onchip_memory2_0_s1_end_xfer assignment, which is an e_assign
  assign onchip_memory2_0_s1_end_xfer = ~(onchip_memory2_0_s1_waits_for_read | onchip_memory2_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_onchip_memory2_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_onchip_memory2_0_s1 = onchip_memory2_0_s1_end_xfer & (~onchip_memory2_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //onchip_memory2_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign onchip_memory2_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_onchip_memory2_0_s1 & onchip_memory2_0_s1_allgrants) | (end_xfer_arb_share_counter_term_onchip_memory2_0_s1 & ~onchip_memory2_0_s1_non_bursting_master_requests);

  //onchip_memory2_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_arb_share_counter <= 0;
      else if (onchip_memory2_0_s1_arb_counter_enable)
          onchip_memory2_0_s1_arb_share_counter <= onchip_memory2_0_s1_arb_share_counter_next_value;
    end


  //onchip_memory2_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_slavearbiterlockenable <= 0;
      else if ((|onchip_memory2_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_onchip_memory2_0_s1) | (end_xfer_arb_share_counter_term_onchip_memory2_0_s1 & ~onchip_memory2_0_s1_non_bursting_master_requests))
          onchip_memory2_0_s1_slavearbiterlockenable <= |onchip_memory2_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master onchip_memory2_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = onchip_memory2_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //onchip_memory2_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign onchip_memory2_0_s1_slavearbiterlockenable2 = |onchip_memory2_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master onchip_memory2_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = onchip_memory2_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master onchip_memory2_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = onchip_memory2_0_s1_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master onchip_memory2_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = onchip_memory2_0_s1_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted onchip_memory2_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1 <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1 <= cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1 ? 1 : (onchip_memory2_0_s1_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_onchip_memory2_0_s1) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1 & cpu_0_instruction_master_requests_onchip_memory2_0_s1;

  //onchip_memory2_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign onchip_memory2_0_s1_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_onchip_memory2_0_s1 = cpu_0_data_master_requests_onchip_memory2_0_s1 & ~((cpu_0_data_master_read & ((1 < cpu_0_data_master_latency_counter))) | cpu_0_instruction_master_arbiterlock);
  //cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in = cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_read & ~onchip_memory2_0_s1_waits_for_read;

  //shift register p1 cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register = {cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register, cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in};

  //cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register <= 0;
      else 
        cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register <= p1_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;
    end


  //local readdatavalid cpu_0_data_master_read_data_valid_onchip_memory2_0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 = cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;

  //onchip_memory2_0_s1_writedata mux, which is an e_mux
  assign onchip_memory2_0_s1_writedata = cpu_0_data_master_writedata;

  //mux onchip_memory2_0_s1_clken, which is an e_mux
  assign onchip_memory2_0_s1_clken = 1'b1;

  assign cpu_0_instruction_master_requests_onchip_memory2_0_s1 = (({cpu_0_instruction_master_address_to_slave[16 : 15] , 15'b0} == 17'h8000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted onchip_memory2_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1 <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1 <= cpu_0_data_master_saved_grant_onchip_memory2_0_s1 ? 1 : (onchip_memory2_0_s1_arbitration_holdoff_internal | ~cpu_0_data_master_requests_onchip_memory2_0_s1) ? 0 : last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1 & cpu_0_data_master_requests_onchip_memory2_0_s1;

  assign cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 = cpu_0_instruction_master_requests_onchip_memory2_0_s1 & ~((cpu_0_instruction_master_read & ((1 < cpu_0_instruction_master_latency_counter))) | cpu_0_data_master_arbiterlock);
  //cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in = cpu_0_instruction_master_granted_onchip_memory2_0_s1 & cpu_0_instruction_master_read & ~onchip_memory2_0_s1_waits_for_read;

  //shift register p1 cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register = {cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register, cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in};

  //cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register <= 0;
      else 
        cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register <= p1_cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;
    end


  //local readdatavalid cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1 = cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;

  //allow new arb cycle for onchip_memory2_0/s1, which is an e_assign
  assign onchip_memory2_0_s1_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for onchip_memory2_0/s1, which is an e_assign
  assign onchip_memory2_0_s1_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;

  //cpu_0/instruction_master grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_instruction_master_granted_onchip_memory2_0_s1 = onchip_memory2_0_s1_grant_vector[0];

  //cpu_0/instruction_master saved-grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1 = onchip_memory2_0_s1_arb_winner[0] && cpu_0_instruction_master_requests_onchip_memory2_0_s1;

  //cpu_0/data_master assignment into master qualified-requests vector for onchip_memory2_0/s1, which is an e_assign
  assign onchip_memory2_0_s1_master_qreq_vector[1] = cpu_0_data_master_qualified_request_onchip_memory2_0_s1;

  //cpu_0/data_master grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_data_master_granted_onchip_memory2_0_s1 = onchip_memory2_0_s1_grant_vector[1];

  //cpu_0/data_master saved-grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_onchip_memory2_0_s1 = onchip_memory2_0_s1_arb_winner[1] && cpu_0_data_master_requests_onchip_memory2_0_s1;

  //onchip_memory2_0/s1 chosen-master double-vector, which is an e_assign
  assign onchip_memory2_0_s1_chosen_master_double_vector = {onchip_memory2_0_s1_master_qreq_vector, onchip_memory2_0_s1_master_qreq_vector} & ({~onchip_memory2_0_s1_master_qreq_vector, ~onchip_memory2_0_s1_master_qreq_vector} + onchip_memory2_0_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign onchip_memory2_0_s1_arb_winner = (onchip_memory2_0_s1_allow_new_arb_cycle & | onchip_memory2_0_s1_grant_vector) ? onchip_memory2_0_s1_grant_vector : onchip_memory2_0_s1_saved_chosen_master_vector;

  //saved onchip_memory2_0_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_saved_chosen_master_vector <= 0;
      else if (onchip_memory2_0_s1_allow_new_arb_cycle)
          onchip_memory2_0_s1_saved_chosen_master_vector <= |onchip_memory2_0_s1_grant_vector ? onchip_memory2_0_s1_grant_vector : onchip_memory2_0_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign onchip_memory2_0_s1_grant_vector = {(onchip_memory2_0_s1_chosen_master_double_vector[1] | onchip_memory2_0_s1_chosen_master_double_vector[3]),
    (onchip_memory2_0_s1_chosen_master_double_vector[0] | onchip_memory2_0_s1_chosen_master_double_vector[2])};

  //onchip_memory2_0/s1 chosen master rotated left, which is an e_assign
  assign onchip_memory2_0_s1_chosen_master_rot_left = (onchip_memory2_0_s1_arb_winner << 1) ? (onchip_memory2_0_s1_arb_winner << 1) : 1;

  //onchip_memory2_0/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_arb_addend <= 1;
      else if (|onchip_memory2_0_s1_grant_vector)
          onchip_memory2_0_s1_arb_addend <= onchip_memory2_0_s1_end_xfer? onchip_memory2_0_s1_chosen_master_rot_left : onchip_memory2_0_s1_grant_vector;
    end


  assign onchip_memory2_0_s1_chipselect = cpu_0_data_master_granted_onchip_memory2_0_s1 | cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  //onchip_memory2_0_s1_firsttransfer first transaction, which is an e_assign
  assign onchip_memory2_0_s1_firsttransfer = onchip_memory2_0_s1_begins_xfer ? onchip_memory2_0_s1_unreg_firsttransfer : onchip_memory2_0_s1_reg_firsttransfer;

  //onchip_memory2_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign onchip_memory2_0_s1_unreg_firsttransfer = ~(onchip_memory2_0_s1_slavearbiterlockenable & onchip_memory2_0_s1_any_continuerequest);

  //onchip_memory2_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_reg_firsttransfer <= 1'b1;
      else if (onchip_memory2_0_s1_begins_xfer)
          onchip_memory2_0_s1_reg_firsttransfer <= onchip_memory2_0_s1_unreg_firsttransfer;
    end


  //onchip_memory2_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign onchip_memory2_0_s1_beginbursttransfer_internal = onchip_memory2_0_s1_begins_xfer;

  //onchip_memory2_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign onchip_memory2_0_s1_arbitration_holdoff_internal = onchip_memory2_0_s1_begins_xfer & onchip_memory2_0_s1_firsttransfer;

  //onchip_memory2_0_s1_write assignment, which is an e_mux
  assign onchip_memory2_0_s1_write = cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_write;

  assign shifted_address_to_onchip_memory2_0_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //onchip_memory2_0_s1_address mux, which is an e_mux
  assign onchip_memory2_0_s1_address = (cpu_0_data_master_granted_onchip_memory2_0_s1)? (shifted_address_to_onchip_memory2_0_s1_from_cpu_0_data_master >> 2) :
    (shifted_address_to_onchip_memory2_0_s1_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_onchip_memory2_0_s1_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_onchip_memory2_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_onchip_memory2_0_s1_end_xfer <= 1;
      else 
        d1_onchip_memory2_0_s1_end_xfer <= onchip_memory2_0_s1_end_xfer;
    end


  //onchip_memory2_0_s1_waits_for_read in a cycle, which is an e_mux
  assign onchip_memory2_0_s1_waits_for_read = onchip_memory2_0_s1_in_a_read_cycle & 0;

  //onchip_memory2_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign onchip_memory2_0_s1_in_a_read_cycle = (cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_onchip_memory2_0_s1 & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = onchip_memory2_0_s1_in_a_read_cycle;

  //onchip_memory2_0_s1_waits_for_write in a cycle, which is an e_mux
  assign onchip_memory2_0_s1_waits_for_write = onchip_memory2_0_s1_in_a_write_cycle & 0;

  //onchip_memory2_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign onchip_memory2_0_s1_in_a_write_cycle = cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = onchip_memory2_0_s1_in_a_write_cycle;

  assign wait_for_onchip_memory2_0_s1_counter = 0;
  //onchip_memory2_0_s1_byteenable byte enable port mux, which is an e_mux
  assign onchip_memory2_0_s1_byteenable = (cpu_0_data_master_granted_onchip_memory2_0_s1)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //onchip_memory2_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_onchip_memory2_0_s1 + cpu_0_instruction_master_granted_onchip_memory2_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_onchip_memory2_0_s1 + cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pll_0_s1_arbitrator (
                             // inputs:
                              clk,
                              cpueffect_clock_0_out_address_to_slave,
                              cpueffect_clock_0_out_nativeaddress,
                              cpueffect_clock_0_out_read,
                              cpueffect_clock_0_out_write,
                              cpueffect_clock_0_out_writedata,
                              pll_0_s1_readdata,
                              pll_0_s1_resetrequest,
                              reset_n,

                             // outputs:
                              cpueffect_clock_0_out_granted_pll_0_s1,
                              cpueffect_clock_0_out_qualified_request_pll_0_s1,
                              cpueffect_clock_0_out_read_data_valid_pll_0_s1,
                              cpueffect_clock_0_out_requests_pll_0_s1,
                              d1_pll_0_s1_end_xfer,
                              pll_0_s1_address,
                              pll_0_s1_chipselect,
                              pll_0_s1_read,
                              pll_0_s1_readdata_from_sa,
                              pll_0_s1_reset_n,
                              pll_0_s1_resetrequest_from_sa,
                              pll_0_s1_write,
                              pll_0_s1_writedata
                           )
;

  output           cpueffect_clock_0_out_granted_pll_0_s1;
  output           cpueffect_clock_0_out_qualified_request_pll_0_s1;
  output           cpueffect_clock_0_out_read_data_valid_pll_0_s1;
  output           cpueffect_clock_0_out_requests_pll_0_s1;
  output           d1_pll_0_s1_end_xfer;
  output  [  2: 0] pll_0_s1_address;
  output           pll_0_s1_chipselect;
  output           pll_0_s1_read;
  output  [ 15: 0] pll_0_s1_readdata_from_sa;
  output           pll_0_s1_reset_n;
  output           pll_0_s1_resetrequest_from_sa;
  output           pll_0_s1_write;
  output  [ 15: 0] pll_0_s1_writedata;
  input            clk;
  input   [  3: 0] cpueffect_clock_0_out_address_to_slave;
  input   [  2: 0] cpueffect_clock_0_out_nativeaddress;
  input            cpueffect_clock_0_out_read;
  input            cpueffect_clock_0_out_write;
  input   [ 15: 0] cpueffect_clock_0_out_writedata;
  input   [ 15: 0] pll_0_s1_readdata;
  input            pll_0_s1_resetrequest;
  input            reset_n;

  wire             cpueffect_clock_0_out_arbiterlock;
  wire             cpueffect_clock_0_out_arbiterlock2;
  wire             cpueffect_clock_0_out_continuerequest;
  wire             cpueffect_clock_0_out_granted_pll_0_s1;
  wire             cpueffect_clock_0_out_qualified_request_pll_0_s1;
  wire             cpueffect_clock_0_out_read_data_valid_pll_0_s1;
  wire             cpueffect_clock_0_out_requests_pll_0_s1;
  wire             cpueffect_clock_0_out_saved_grant_pll_0_s1;
  reg              d1_pll_0_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pll_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  2: 0] pll_0_s1_address;
  wire             pll_0_s1_allgrants;
  wire             pll_0_s1_allow_new_arb_cycle;
  wire             pll_0_s1_any_bursting_master_saved_grant;
  wire             pll_0_s1_any_continuerequest;
  wire             pll_0_s1_arb_counter_enable;
  reg              pll_0_s1_arb_share_counter;
  wire             pll_0_s1_arb_share_counter_next_value;
  wire             pll_0_s1_arb_share_set_values;
  wire             pll_0_s1_beginbursttransfer_internal;
  wire             pll_0_s1_begins_xfer;
  wire             pll_0_s1_chipselect;
  wire             pll_0_s1_end_xfer;
  wire             pll_0_s1_firsttransfer;
  wire             pll_0_s1_grant_vector;
  wire             pll_0_s1_in_a_read_cycle;
  wire             pll_0_s1_in_a_write_cycle;
  wire             pll_0_s1_master_qreq_vector;
  wire             pll_0_s1_non_bursting_master_requests;
  wire             pll_0_s1_read;
  wire    [ 15: 0] pll_0_s1_readdata_from_sa;
  reg              pll_0_s1_reg_firsttransfer;
  wire             pll_0_s1_reset_n;
  wire             pll_0_s1_resetrequest_from_sa;
  reg              pll_0_s1_slavearbiterlockenable;
  wire             pll_0_s1_slavearbiterlockenable2;
  wire             pll_0_s1_unreg_firsttransfer;
  wire             pll_0_s1_waits_for_read;
  wire             pll_0_s1_waits_for_write;
  wire             pll_0_s1_write;
  wire    [ 15: 0] pll_0_s1_writedata;
  wire             wait_for_pll_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pll_0_s1_end_xfer;
    end


  assign pll_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpueffect_clock_0_out_qualified_request_pll_0_s1));
  //assign pll_0_s1_readdata_from_sa = pll_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pll_0_s1_readdata_from_sa = pll_0_s1_readdata;

  assign cpueffect_clock_0_out_requests_pll_0_s1 = (1) & (cpueffect_clock_0_out_read | cpueffect_clock_0_out_write);
  //pll_0_s1_arb_share_counter set values, which is an e_mux
  assign pll_0_s1_arb_share_set_values = 1;

  //pll_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign pll_0_s1_non_bursting_master_requests = cpueffect_clock_0_out_requests_pll_0_s1;

  //pll_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pll_0_s1_any_bursting_master_saved_grant = 0;

  //pll_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pll_0_s1_arb_share_counter_next_value = pll_0_s1_firsttransfer ? (pll_0_s1_arb_share_set_values - 1) : |pll_0_s1_arb_share_counter ? (pll_0_s1_arb_share_counter - 1) : 0;

  //pll_0_s1_allgrants all slave grants, which is an e_mux
  assign pll_0_s1_allgrants = |pll_0_s1_grant_vector;

  //pll_0_s1_end_xfer assignment, which is an e_assign
  assign pll_0_s1_end_xfer = ~(pll_0_s1_waits_for_read | pll_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pll_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pll_0_s1 = pll_0_s1_end_xfer & (~pll_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pll_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pll_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pll_0_s1 & pll_0_s1_allgrants) | (end_xfer_arb_share_counter_term_pll_0_s1 & ~pll_0_s1_non_bursting_master_requests);

  //pll_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pll_0_s1_arb_share_counter <= 0;
      else if (pll_0_s1_arb_counter_enable)
          pll_0_s1_arb_share_counter <= pll_0_s1_arb_share_counter_next_value;
    end


  //pll_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pll_0_s1_slavearbiterlockenable <= 0;
      else if ((|pll_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pll_0_s1) | (end_xfer_arb_share_counter_term_pll_0_s1 & ~pll_0_s1_non_bursting_master_requests))
          pll_0_s1_slavearbiterlockenable <= |pll_0_s1_arb_share_counter_next_value;
    end


  //cpueffect_clock_0/out pll_0/s1 arbiterlock, which is an e_assign
  assign cpueffect_clock_0_out_arbiterlock = pll_0_s1_slavearbiterlockenable & cpueffect_clock_0_out_continuerequest;

  //pll_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pll_0_s1_slavearbiterlockenable2 = |pll_0_s1_arb_share_counter_next_value;

  //cpueffect_clock_0/out pll_0/s1 arbiterlock2, which is an e_assign
  assign cpueffect_clock_0_out_arbiterlock2 = pll_0_s1_slavearbiterlockenable2 & cpueffect_clock_0_out_continuerequest;

  //pll_0_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pll_0_s1_any_continuerequest = 1;

  //cpueffect_clock_0_out_continuerequest continued request, which is an e_assign
  assign cpueffect_clock_0_out_continuerequest = 1;

  assign cpueffect_clock_0_out_qualified_request_pll_0_s1 = cpueffect_clock_0_out_requests_pll_0_s1;
  //pll_0_s1_writedata mux, which is an e_mux
  assign pll_0_s1_writedata = cpueffect_clock_0_out_writedata;

  //master is always granted when requested
  assign cpueffect_clock_0_out_granted_pll_0_s1 = cpueffect_clock_0_out_qualified_request_pll_0_s1;

  //cpueffect_clock_0/out saved-grant pll_0/s1, which is an e_assign
  assign cpueffect_clock_0_out_saved_grant_pll_0_s1 = cpueffect_clock_0_out_requests_pll_0_s1;

  //allow new arb cycle for pll_0/s1, which is an e_assign
  assign pll_0_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pll_0_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pll_0_s1_master_qreq_vector = 1;

  //pll_0_s1_reset_n assignment, which is an e_assign
  assign pll_0_s1_reset_n = reset_n;

  //assign pll_0_s1_resetrequest_from_sa = pll_0_s1_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pll_0_s1_resetrequest_from_sa = pll_0_s1_resetrequest;

  assign pll_0_s1_chipselect = cpueffect_clock_0_out_granted_pll_0_s1;
  //pll_0_s1_firsttransfer first transaction, which is an e_assign
  assign pll_0_s1_firsttransfer = pll_0_s1_begins_xfer ? pll_0_s1_unreg_firsttransfer : pll_0_s1_reg_firsttransfer;

  //pll_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pll_0_s1_unreg_firsttransfer = ~(pll_0_s1_slavearbiterlockenable & pll_0_s1_any_continuerequest);

  //pll_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pll_0_s1_reg_firsttransfer <= 1'b1;
      else if (pll_0_s1_begins_xfer)
          pll_0_s1_reg_firsttransfer <= pll_0_s1_unreg_firsttransfer;
    end


  //pll_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pll_0_s1_beginbursttransfer_internal = pll_0_s1_begins_xfer;

  //pll_0_s1_read assignment, which is an e_mux
  assign pll_0_s1_read = cpueffect_clock_0_out_granted_pll_0_s1 & cpueffect_clock_0_out_read;

  //pll_0_s1_write assignment, which is an e_mux
  assign pll_0_s1_write = cpueffect_clock_0_out_granted_pll_0_s1 & cpueffect_clock_0_out_write;

  //pll_0_s1_address mux, which is an e_mux
  assign pll_0_s1_address = cpueffect_clock_0_out_nativeaddress;

  //d1_pll_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pll_0_s1_end_xfer <= 1;
      else 
        d1_pll_0_s1_end_xfer <= pll_0_s1_end_xfer;
    end


  //pll_0_s1_waits_for_read in a cycle, which is an e_mux
  assign pll_0_s1_waits_for_read = pll_0_s1_in_a_read_cycle & pll_0_s1_begins_xfer;

  //pll_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign pll_0_s1_in_a_read_cycle = cpueffect_clock_0_out_granted_pll_0_s1 & cpueffect_clock_0_out_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pll_0_s1_in_a_read_cycle;

  //pll_0_s1_waits_for_write in a cycle, which is an e_mux
  assign pll_0_s1_waits_for_write = pll_0_s1_in_a_write_cycle & 0;

  //pll_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign pll_0_s1_in_a_write_cycle = cpueffect_clock_0_out_granted_pll_0_s1 & cpueffect_clock_0_out_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pll_0_s1_in_a_write_cycle;

  assign wait_for_pll_0_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pll_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module vibrato_on_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_0_data_master_address_to_slave,
                                   cpu_0_data_master_latency_counter,
                                   cpu_0_data_master_read,
                                   cpu_0_data_master_write,
                                   reset_n,
                                   vibrato_on_s1_readdata,

                                  // outputs:
                                   cpu_0_data_master_granted_vibrato_on_s1,
                                   cpu_0_data_master_qualified_request_vibrato_on_s1,
                                   cpu_0_data_master_read_data_valid_vibrato_on_s1,
                                   cpu_0_data_master_requests_vibrato_on_s1,
                                   d1_vibrato_on_s1_end_xfer,
                                   vibrato_on_s1_address,
                                   vibrato_on_s1_readdata_from_sa,
                                   vibrato_on_s1_reset_n
                                )
;

  output           cpu_0_data_master_granted_vibrato_on_s1;
  output           cpu_0_data_master_qualified_request_vibrato_on_s1;
  output           cpu_0_data_master_read_data_valid_vibrato_on_s1;
  output           cpu_0_data_master_requests_vibrato_on_s1;
  output           d1_vibrato_on_s1_end_xfer;
  output  [  1: 0] vibrato_on_s1_address;
  output           vibrato_on_s1_readdata_from_sa;
  output           vibrato_on_s1_reset_n;
  input            clk;
  input   [ 16: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;
  input            vibrato_on_s1_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_vibrato_on_s1;
  wire             cpu_0_data_master_qualified_request_vibrato_on_s1;
  wire             cpu_0_data_master_read_data_valid_vibrato_on_s1;
  wire             cpu_0_data_master_requests_vibrato_on_s1;
  wire             cpu_0_data_master_saved_grant_vibrato_on_s1;
  reg              d1_reasons_to_wait;
  reg              d1_vibrato_on_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_vibrato_on_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 16: 0] shifted_address_to_vibrato_on_s1_from_cpu_0_data_master;
  wire    [  1: 0] vibrato_on_s1_address;
  wire             vibrato_on_s1_allgrants;
  wire             vibrato_on_s1_allow_new_arb_cycle;
  wire             vibrato_on_s1_any_bursting_master_saved_grant;
  wire             vibrato_on_s1_any_continuerequest;
  wire             vibrato_on_s1_arb_counter_enable;
  reg              vibrato_on_s1_arb_share_counter;
  wire             vibrato_on_s1_arb_share_counter_next_value;
  wire             vibrato_on_s1_arb_share_set_values;
  wire             vibrato_on_s1_beginbursttransfer_internal;
  wire             vibrato_on_s1_begins_xfer;
  wire             vibrato_on_s1_end_xfer;
  wire             vibrato_on_s1_firsttransfer;
  wire             vibrato_on_s1_grant_vector;
  wire             vibrato_on_s1_in_a_read_cycle;
  wire             vibrato_on_s1_in_a_write_cycle;
  wire             vibrato_on_s1_master_qreq_vector;
  wire             vibrato_on_s1_non_bursting_master_requests;
  wire             vibrato_on_s1_readdata_from_sa;
  reg              vibrato_on_s1_reg_firsttransfer;
  wire             vibrato_on_s1_reset_n;
  reg              vibrato_on_s1_slavearbiterlockenable;
  wire             vibrato_on_s1_slavearbiterlockenable2;
  wire             vibrato_on_s1_unreg_firsttransfer;
  wire             vibrato_on_s1_waits_for_read;
  wire             vibrato_on_s1_waits_for_write;
  wire             wait_for_vibrato_on_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~vibrato_on_s1_end_xfer;
    end


  assign vibrato_on_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_vibrato_on_s1));
  //assign vibrato_on_s1_readdata_from_sa = vibrato_on_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign vibrato_on_s1_readdata_from_sa = vibrato_on_s1_readdata;

  assign cpu_0_data_master_requests_vibrato_on_s1 = (({cpu_0_data_master_address_to_slave[16 : 4] , 4'b0} == 17'h11020) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //vibrato_on_s1_arb_share_counter set values, which is an e_mux
  assign vibrato_on_s1_arb_share_set_values = 1;

  //vibrato_on_s1_non_bursting_master_requests mux, which is an e_mux
  assign vibrato_on_s1_non_bursting_master_requests = cpu_0_data_master_requests_vibrato_on_s1;

  //vibrato_on_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign vibrato_on_s1_any_bursting_master_saved_grant = 0;

  //vibrato_on_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign vibrato_on_s1_arb_share_counter_next_value = vibrato_on_s1_firsttransfer ? (vibrato_on_s1_arb_share_set_values - 1) : |vibrato_on_s1_arb_share_counter ? (vibrato_on_s1_arb_share_counter - 1) : 0;

  //vibrato_on_s1_allgrants all slave grants, which is an e_mux
  assign vibrato_on_s1_allgrants = |vibrato_on_s1_grant_vector;

  //vibrato_on_s1_end_xfer assignment, which is an e_assign
  assign vibrato_on_s1_end_xfer = ~(vibrato_on_s1_waits_for_read | vibrato_on_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_vibrato_on_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_vibrato_on_s1 = vibrato_on_s1_end_xfer & (~vibrato_on_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //vibrato_on_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign vibrato_on_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_vibrato_on_s1 & vibrato_on_s1_allgrants) | (end_xfer_arb_share_counter_term_vibrato_on_s1 & ~vibrato_on_s1_non_bursting_master_requests);

  //vibrato_on_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          vibrato_on_s1_arb_share_counter <= 0;
      else if (vibrato_on_s1_arb_counter_enable)
          vibrato_on_s1_arb_share_counter <= vibrato_on_s1_arb_share_counter_next_value;
    end


  //vibrato_on_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          vibrato_on_s1_slavearbiterlockenable <= 0;
      else if ((|vibrato_on_s1_master_qreq_vector & end_xfer_arb_share_counter_term_vibrato_on_s1) | (end_xfer_arb_share_counter_term_vibrato_on_s1 & ~vibrato_on_s1_non_bursting_master_requests))
          vibrato_on_s1_slavearbiterlockenable <= |vibrato_on_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master vibrato_on/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = vibrato_on_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //vibrato_on_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign vibrato_on_s1_slavearbiterlockenable2 = |vibrato_on_s1_arb_share_counter_next_value;

  //cpu_0/data_master vibrato_on/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = vibrato_on_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //vibrato_on_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign vibrato_on_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_vibrato_on_s1 = cpu_0_data_master_requests_vibrato_on_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_vibrato_on_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_vibrato_on_s1 = cpu_0_data_master_granted_vibrato_on_s1 & cpu_0_data_master_read & ~vibrato_on_s1_waits_for_read;

  //master is always granted when requested
  assign cpu_0_data_master_granted_vibrato_on_s1 = cpu_0_data_master_qualified_request_vibrato_on_s1;

  //cpu_0/data_master saved-grant vibrato_on/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_vibrato_on_s1 = cpu_0_data_master_requests_vibrato_on_s1;

  //allow new arb cycle for vibrato_on/s1, which is an e_assign
  assign vibrato_on_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign vibrato_on_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign vibrato_on_s1_master_qreq_vector = 1;

  //vibrato_on_s1_reset_n assignment, which is an e_assign
  assign vibrato_on_s1_reset_n = reset_n;

  //vibrato_on_s1_firsttransfer first transaction, which is an e_assign
  assign vibrato_on_s1_firsttransfer = vibrato_on_s1_begins_xfer ? vibrato_on_s1_unreg_firsttransfer : vibrato_on_s1_reg_firsttransfer;

  //vibrato_on_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign vibrato_on_s1_unreg_firsttransfer = ~(vibrato_on_s1_slavearbiterlockenable & vibrato_on_s1_any_continuerequest);

  //vibrato_on_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          vibrato_on_s1_reg_firsttransfer <= 1'b1;
      else if (vibrato_on_s1_begins_xfer)
          vibrato_on_s1_reg_firsttransfer <= vibrato_on_s1_unreg_firsttransfer;
    end


  //vibrato_on_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign vibrato_on_s1_beginbursttransfer_internal = vibrato_on_s1_begins_xfer;

  assign shifted_address_to_vibrato_on_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //vibrato_on_s1_address mux, which is an e_mux
  assign vibrato_on_s1_address = shifted_address_to_vibrato_on_s1_from_cpu_0_data_master >> 2;

  //d1_vibrato_on_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_vibrato_on_s1_end_xfer <= 1;
      else 
        d1_vibrato_on_s1_end_xfer <= vibrato_on_s1_end_xfer;
    end


  //vibrato_on_s1_waits_for_read in a cycle, which is an e_mux
  assign vibrato_on_s1_waits_for_read = vibrato_on_s1_in_a_read_cycle & vibrato_on_s1_begins_xfer;

  //vibrato_on_s1_in_a_read_cycle assignment, which is an e_assign
  assign vibrato_on_s1_in_a_read_cycle = cpu_0_data_master_granted_vibrato_on_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = vibrato_on_s1_in_a_read_cycle;

  //vibrato_on_s1_waits_for_write in a cycle, which is an e_mux
  assign vibrato_on_s1_waits_for_write = vibrato_on_s1_in_a_write_cycle & 0;

  //vibrato_on_s1_in_a_write_cycle assignment, which is an e_assign
  assign vibrato_on_s1_in_a_write_cycle = cpu_0_data_master_granted_vibrato_on_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = vibrato_on_s1_in_a_write_cycle;

  assign wait_for_vibrato_on_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //vibrato_on/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpueffect_reset_cpu_clk_domain_synch_module (
                                                     // inputs:
                                                      clk,
                                                      data_in,
                                                      reset_n,

                                                     // outputs:
                                                      data_out
                                                   )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpueffect_reset_clk_50_domain_synch_module (
                                                    // inputs:
                                                     clk,
                                                     data_in,
                                                     reset_n,

                                                    // outputs:
                                                     data_out
                                                  )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpueffect (
                   // 1) global signals:
                    clk_50,
                    cpu_clk,
                    reset_n,

                   // the_adclrc
                    in_port_to_the_adclrc,

                   // the_chorus_on
                    in_port_to_the_chorus_on,

                   // the_clk
                    in_port_to_the_clk,

                   // the_datain
                    in_port_to_the_datain,

                   // the_dataout
                    out_port_from_the_dataout,

                   // the_vibrato_on
                    in_port_to_the_vibrato_on
                 )
;

  output           cpu_clk;
  output  [ 15: 0] out_port_from_the_dataout;
  input            clk_50;
  input            in_port_to_the_adclrc;
  input            in_port_to_the_chorus_on;
  input            in_port_to_the_clk;
  input   [ 15: 0] in_port_to_the_datain;
  input            in_port_to_the_vibrato_on;
  input            reset_n;

  wire    [  1: 0] adclrc_s1_address;
  wire             adclrc_s1_readdata;
  wire             adclrc_s1_readdata_from_sa;
  wire             adclrc_s1_reset_n;
  wire    [  1: 0] chorus_on_s1_address;
  wire             chorus_on_s1_readdata;
  wire             chorus_on_s1_readdata_from_sa;
  wire             chorus_on_s1_reset_n;
  wire             clk_50_reset_n;
  wire    [  1: 0] clk_s1_address;
  wire             clk_s1_readdata;
  wire             clk_s1_readdata_from_sa;
  wire             clk_s1_reset_n;
  wire    [  4: 0] cpu_0_custom_instruction_master_multi_a;
  wire    [  4: 0] cpu_0_custom_instruction_master_multi_b;
  wire    [  4: 0] cpu_0_custom_instruction_master_multi_c;
  wire             cpu_0_custom_instruction_master_multi_clk_en;
  wire    [ 31: 0] cpu_0_custom_instruction_master_multi_dataa;
  wire    [ 31: 0] cpu_0_custom_instruction_master_multi_datab;
  wire             cpu_0_custom_instruction_master_multi_done;
  wire             cpu_0_custom_instruction_master_multi_estatus;
  wire    [ 31: 0] cpu_0_custom_instruction_master_multi_ipending;
  wire    [  7: 0] cpu_0_custom_instruction_master_multi_n;
  wire             cpu_0_custom_instruction_master_multi_readra;
  wire             cpu_0_custom_instruction_master_multi_readrb;
  wire    [ 31: 0] cpu_0_custom_instruction_master_multi_result;
  wire             cpu_0_custom_instruction_master_multi_start;
  wire             cpu_0_custom_instruction_master_multi_status;
  wire             cpu_0_custom_instruction_master_multi_writerc;
  wire             cpu_0_custom_instruction_master_reset_n;
  wire             cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1;
  wire    [ 16: 0] cpu_0_data_master_address;
  wire    [ 16: 0] cpu_0_data_master_address_to_slave;
  wire    [  3: 0] cpu_0_data_master_byteenable;
  wire             cpu_0_data_master_debugaccess;
  wire             cpu_0_data_master_granted_adclrc_s1;
  wire             cpu_0_data_master_granted_chorus_on_s1;
  wire             cpu_0_data_master_granted_clk_s1;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_granted_cpueffect_clock_0_in;
  wire             cpu_0_data_master_granted_datain_s1;
  wire             cpu_0_data_master_granted_dataout_s1;
  wire             cpu_0_data_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_data_master_granted_vibrato_on_s1;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire             cpu_0_data_master_latency_counter;
  wire             cpu_0_data_master_qualified_request_adclrc_s1;
  wire             cpu_0_data_master_qualified_request_chorus_on_s1;
  wire             cpu_0_data_master_qualified_request_clk_s1;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_cpueffect_clock_0_in;
  wire             cpu_0_data_master_qualified_request_datain_s1;
  wire             cpu_0_data_master_qualified_request_dataout_s1;
  wire             cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_data_master_qualified_request_vibrato_on_s1;
  wire             cpu_0_data_master_read;
  wire             cpu_0_data_master_read_data_valid_adclrc_s1;
  wire             cpu_0_data_master_read_data_valid_chorus_on_s1;
  wire             cpu_0_data_master_read_data_valid_clk_s1;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_cpueffect_clock_0_in;
  wire             cpu_0_data_master_read_data_valid_datain_s1;
  wire             cpu_0_data_master_read_data_valid_dataout_s1;
  wire             cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  wire             cpu_0_data_master_read_data_valid_vibrato_on_s1;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_readdatavalid;
  wire             cpu_0_data_master_requests_adclrc_s1;
  wire             cpu_0_data_master_requests_chorus_on_s1;
  wire             cpu_0_data_master_requests_clk_s1;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_cpueffect_clock_0_in;
  wire             cpu_0_data_master_requests_datain_s1;
  wire             cpu_0_data_master_requests_dataout_s1;
  wire             cpu_0_data_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_data_master_requests_vibrato_on_s1;
  wire             cpu_0_data_master_waitrequest;
  wire             cpu_0_data_master_write;
  wire    [ 31: 0] cpu_0_data_master_writedata;
  wire             cpu_0_fpoint_s1_clk_en;
  wire    [ 31: 0] cpu_0_fpoint_s1_dataa;
  wire    [ 31: 0] cpu_0_fpoint_s1_datab;
  wire             cpu_0_fpoint_s1_done;
  wire             cpu_0_fpoint_s1_done_from_sa;
  wire    [  1: 0] cpu_0_fpoint_s1_n;
  wire             cpu_0_fpoint_s1_reset;
  wire    [ 31: 0] cpu_0_fpoint_s1_result;
  wire    [ 31: 0] cpu_0_fpoint_s1_result_from_sa;
  wire             cpu_0_fpoint_s1_select;
  wire             cpu_0_fpoint_s1_start;
  wire    [ 16: 0] cpu_0_instruction_master_address;
  wire    [ 16: 0] cpu_0_instruction_master_address_to_slave;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_latency_counter;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_read;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_waitrequest;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  wire             cpu_0_jtag_debug_module_reset;
  wire             cpu_0_jtag_debug_module_resetrequest;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  wire             cpu_clk;
  wire             cpu_clk_reset_n;
  wire    [  3: 0] cpueffect_clock_0_in_address;
  wire    [  1: 0] cpueffect_clock_0_in_byteenable;
  wire             cpueffect_clock_0_in_endofpacket;
  wire             cpueffect_clock_0_in_endofpacket_from_sa;
  wire    [  2: 0] cpueffect_clock_0_in_nativeaddress;
  wire             cpueffect_clock_0_in_read;
  wire    [ 15: 0] cpueffect_clock_0_in_readdata;
  wire    [ 15: 0] cpueffect_clock_0_in_readdata_from_sa;
  wire             cpueffect_clock_0_in_reset_n;
  wire             cpueffect_clock_0_in_waitrequest;
  wire             cpueffect_clock_0_in_waitrequest_from_sa;
  wire             cpueffect_clock_0_in_write;
  wire    [ 15: 0] cpueffect_clock_0_in_writedata;
  wire    [  3: 0] cpueffect_clock_0_out_address;
  wire    [  3: 0] cpueffect_clock_0_out_address_to_slave;
  wire    [  1: 0] cpueffect_clock_0_out_byteenable;
  wire             cpueffect_clock_0_out_endofpacket;
  wire             cpueffect_clock_0_out_granted_pll_0_s1;
  wire    [  2: 0] cpueffect_clock_0_out_nativeaddress;
  wire             cpueffect_clock_0_out_qualified_request_pll_0_s1;
  wire             cpueffect_clock_0_out_read;
  wire             cpueffect_clock_0_out_read_data_valid_pll_0_s1;
  wire    [ 15: 0] cpueffect_clock_0_out_readdata;
  wire             cpueffect_clock_0_out_requests_pll_0_s1;
  wire             cpueffect_clock_0_out_reset_n;
  wire             cpueffect_clock_0_out_waitrequest;
  wire             cpueffect_clock_0_out_write;
  wire    [ 15: 0] cpueffect_clock_0_out_writedata;
  wire             d1_adclrc_s1_end_xfer;
  wire             d1_chorus_on_s1_end_xfer;
  wire             d1_clk_s1_end_xfer;
  wire             d1_cpu_0_jtag_debug_module_end_xfer;
  wire             d1_cpueffect_clock_0_in_end_xfer;
  wire             d1_datain_s1_end_xfer;
  wire             d1_dataout_s1_end_xfer;
  wire             d1_onchip_memory2_0_s1_end_xfer;
  wire             d1_pll_0_s1_end_xfer;
  wire             d1_vibrato_on_s1_end_xfer;
  wire    [  1: 0] datain_s1_address;
  wire    [ 15: 0] datain_s1_readdata;
  wire    [ 15: 0] datain_s1_readdata_from_sa;
  wire             datain_s1_reset_n;
  wire    [  1: 0] dataout_s1_address;
  wire             dataout_s1_chipselect;
  wire    [ 15: 0] dataout_s1_readdata;
  wire    [ 15: 0] dataout_s1_readdata_from_sa;
  wire             dataout_s1_reset_n;
  wire             dataout_s1_write_n;
  wire    [ 15: 0] dataout_s1_writedata;
  wire    [ 12: 0] onchip_memory2_0_s1_address;
  wire    [  3: 0] onchip_memory2_0_s1_byteenable;
  wire             onchip_memory2_0_s1_chipselect;
  wire             onchip_memory2_0_s1_clken;
  wire    [ 31: 0] onchip_memory2_0_s1_readdata;
  wire    [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  wire             onchip_memory2_0_s1_write;
  wire    [ 31: 0] onchip_memory2_0_s1_writedata;
  wire             out_clk_pll_0_c0;
  wire    [ 15: 0] out_port_from_the_dataout;
  wire    [  2: 0] pll_0_s1_address;
  wire             pll_0_s1_chipselect;
  wire             pll_0_s1_read;
  wire    [ 15: 0] pll_0_s1_readdata;
  wire    [ 15: 0] pll_0_s1_readdata_from_sa;
  wire             pll_0_s1_reset_n;
  wire             pll_0_s1_resetrequest;
  wire             pll_0_s1_resetrequest_from_sa;
  wire             pll_0_s1_write;
  wire    [ 15: 0] pll_0_s1_writedata;
  wire             reset_n_sources;
  wire    [  1: 0] vibrato_on_s1_address;
  wire             vibrato_on_s1_readdata;
  wire             vibrato_on_s1_readdata_from_sa;
  wire             vibrato_on_s1_reset_n;
  adclrc_s1_arbitrator the_adclrc_s1
    (
      .adclrc_s1_address                             (adclrc_s1_address),
      .adclrc_s1_readdata                            (adclrc_s1_readdata),
      .adclrc_s1_readdata_from_sa                    (adclrc_s1_readdata_from_sa),
      .adclrc_s1_reset_n                             (adclrc_s1_reset_n),
      .clk                                           (cpu_clk),
      .cpu_0_data_master_address_to_slave            (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_adclrc_s1           (cpu_0_data_master_granted_adclrc_s1),
      .cpu_0_data_master_latency_counter             (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_adclrc_s1 (cpu_0_data_master_qualified_request_adclrc_s1),
      .cpu_0_data_master_read                        (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_adclrc_s1   (cpu_0_data_master_read_data_valid_adclrc_s1),
      .cpu_0_data_master_requests_adclrc_s1          (cpu_0_data_master_requests_adclrc_s1),
      .cpu_0_data_master_write                       (cpu_0_data_master_write),
      .d1_adclrc_s1_end_xfer                         (d1_adclrc_s1_end_xfer),
      .reset_n                                       (cpu_clk_reset_n)
    );

  adclrc the_adclrc
    (
      .address  (adclrc_s1_address),
      .clk      (cpu_clk),
      .in_port  (in_port_to_the_adclrc),
      .readdata (adclrc_s1_readdata),
      .reset_n  (adclrc_s1_reset_n)
    );

  chorus_on_s1_arbitrator the_chorus_on_s1
    (
      .chorus_on_s1_address                             (chorus_on_s1_address),
      .chorus_on_s1_readdata                            (chorus_on_s1_readdata),
      .chorus_on_s1_readdata_from_sa                    (chorus_on_s1_readdata_from_sa),
      .chorus_on_s1_reset_n                             (chorus_on_s1_reset_n),
      .clk                                              (cpu_clk),
      .cpu_0_data_master_address_to_slave               (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_chorus_on_s1           (cpu_0_data_master_granted_chorus_on_s1),
      .cpu_0_data_master_latency_counter                (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_chorus_on_s1 (cpu_0_data_master_qualified_request_chorus_on_s1),
      .cpu_0_data_master_read                           (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_chorus_on_s1   (cpu_0_data_master_read_data_valid_chorus_on_s1),
      .cpu_0_data_master_requests_chorus_on_s1          (cpu_0_data_master_requests_chorus_on_s1),
      .cpu_0_data_master_write                          (cpu_0_data_master_write),
      .d1_chorus_on_s1_end_xfer                         (d1_chorus_on_s1_end_xfer),
      .reset_n                                          (cpu_clk_reset_n)
    );

  chorus_on the_chorus_on
    (
      .address  (chorus_on_s1_address),
      .clk      (cpu_clk),
      .in_port  (in_port_to_the_chorus_on),
      .readdata (chorus_on_s1_readdata),
      .reset_n  (chorus_on_s1_reset_n)
    );

  clk_s1_arbitrator the_clk_s1
    (
      .clk                                        (cpu_clk),
      .clk_s1_address                             (clk_s1_address),
      .clk_s1_readdata                            (clk_s1_readdata),
      .clk_s1_readdata_from_sa                    (clk_s1_readdata_from_sa),
      .clk_s1_reset_n                             (clk_s1_reset_n),
      .cpu_0_data_master_address_to_slave         (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_clk_s1           (cpu_0_data_master_granted_clk_s1),
      .cpu_0_data_master_latency_counter          (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_clk_s1 (cpu_0_data_master_qualified_request_clk_s1),
      .cpu_0_data_master_read                     (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_clk_s1   (cpu_0_data_master_read_data_valid_clk_s1),
      .cpu_0_data_master_requests_clk_s1          (cpu_0_data_master_requests_clk_s1),
      .cpu_0_data_master_write                    (cpu_0_data_master_write),
      .d1_clk_s1_end_xfer                         (d1_clk_s1_end_xfer),
      .reset_n                                    (cpu_clk_reset_n)
    );

  clk the_clk
    (
      .address  (clk_s1_address),
      .clk      (cpu_clk),
      .in_port  (in_port_to_the_clk),
      .readdata (clk_s1_readdata),
      .reset_n  (clk_s1_reset_n)
    );

  cpu_0_jtag_debug_module_arbitrator the_cpu_0_jtag_debug_module
    (
      .clk                                                                (cpu_clk),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_debugaccess                                      (cpu_0_data_master_debugaccess),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                  (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_latency_counter                                  (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module        (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module          (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                 (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                        (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_jtag_debug_module_address                                    (cpu_0_jtag_debug_module_address),
      .cpu_0_jtag_debug_module_begintransfer                              (cpu_0_jtag_debug_module_begintransfer),
      .cpu_0_jtag_debug_module_byteenable                                 (cpu_0_jtag_debug_module_byteenable),
      .cpu_0_jtag_debug_module_chipselect                                 (cpu_0_jtag_debug_module_chipselect),
      .cpu_0_jtag_debug_module_debugaccess                                (cpu_0_jtag_debug_module_debugaccess),
      .cpu_0_jtag_debug_module_readdata                                   (cpu_0_jtag_debug_module_readdata),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .cpu_0_jtag_debug_module_reset                                      (cpu_0_jtag_debug_module_reset),
      .cpu_0_jtag_debug_module_resetrequest                               (cpu_0_jtag_debug_module_resetrequest),
      .cpu_0_jtag_debug_module_resetrequest_from_sa                       (cpu_0_jtag_debug_module_resetrequest_from_sa),
      .cpu_0_jtag_debug_module_write                                      (cpu_0_jtag_debug_module_write),
      .cpu_0_jtag_debug_module_writedata                                  (cpu_0_jtag_debug_module_writedata),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .reset_n                                                            (cpu_clk_reset_n)
    );

  cpu_0_custom_instruction_master_arbitrator the_cpu_0_custom_instruction_master
    (
      .clk                                                   (cpu_clk),
      .cpu_0_custom_instruction_master_multi_done            (cpu_0_custom_instruction_master_multi_done),
      .cpu_0_custom_instruction_master_multi_result          (cpu_0_custom_instruction_master_multi_result),
      .cpu_0_custom_instruction_master_multi_start           (cpu_0_custom_instruction_master_multi_start),
      .cpu_0_custom_instruction_master_reset_n               (cpu_0_custom_instruction_master_reset_n),
      .cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1 (cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1),
      .cpu_0_fpoint_s1_done_from_sa                          (cpu_0_fpoint_s1_done_from_sa),
      .cpu_0_fpoint_s1_result_from_sa                        (cpu_0_fpoint_s1_result_from_sa),
      .cpu_0_fpoint_s1_select                                (cpu_0_fpoint_s1_select),
      .reset_n                                               (cpu_clk_reset_n)
    );

  cpu_0_data_master_arbitrator the_cpu_0_data_master
    (
      .adclrc_s1_readdata_from_sa                                  (adclrc_s1_readdata_from_sa),
      .chorus_on_s1_readdata_from_sa                               (chorus_on_s1_readdata_from_sa),
      .clk                                                         (cpu_clk),
      .clk_s1_readdata_from_sa                                     (clk_s1_readdata_from_sa),
      .cpu_0_data_master_address                                   (cpu_0_data_master_address),
      .cpu_0_data_master_address_to_slave                          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_adclrc_s1                         (cpu_0_data_master_granted_adclrc_s1),
      .cpu_0_data_master_granted_chorus_on_s1                      (cpu_0_data_master_granted_chorus_on_s1),
      .cpu_0_data_master_granted_clk_s1                            (cpu_0_data_master_granted_clk_s1),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module           (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_granted_cpueffect_clock_0_in              (cpu_0_data_master_granted_cpueffect_clock_0_in),
      .cpu_0_data_master_granted_datain_s1                         (cpu_0_data_master_granted_datain_s1),
      .cpu_0_data_master_granted_dataout_s1                        (cpu_0_data_master_granted_dataout_s1),
      .cpu_0_data_master_granted_onchip_memory2_0_s1               (cpu_0_data_master_granted_onchip_memory2_0_s1),
      .cpu_0_data_master_granted_vibrato_on_s1                     (cpu_0_data_master_granted_vibrato_on_s1),
      .cpu_0_data_master_latency_counter                           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_adclrc_s1               (cpu_0_data_master_qualified_request_adclrc_s1),
      .cpu_0_data_master_qualified_request_chorus_on_s1            (cpu_0_data_master_qualified_request_chorus_on_s1),
      .cpu_0_data_master_qualified_request_clk_s1                  (cpu_0_data_master_qualified_request_clk_s1),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_cpueffect_clock_0_in    (cpu_0_data_master_qualified_request_cpueffect_clock_0_in),
      .cpu_0_data_master_qualified_request_datain_s1               (cpu_0_data_master_qualified_request_datain_s1),
      .cpu_0_data_master_qualified_request_dataout_s1              (cpu_0_data_master_qualified_request_dataout_s1),
      .cpu_0_data_master_qualified_request_onchip_memory2_0_s1     (cpu_0_data_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_data_master_qualified_request_vibrato_on_s1           (cpu_0_data_master_qualified_request_vibrato_on_s1),
      .cpu_0_data_master_read                                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_adclrc_s1                 (cpu_0_data_master_read_data_valid_adclrc_s1),
      .cpu_0_data_master_read_data_valid_chorus_on_s1              (cpu_0_data_master_read_data_valid_chorus_on_s1),
      .cpu_0_data_master_read_data_valid_clk_s1                    (cpu_0_data_master_read_data_valid_clk_s1),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read_data_valid_cpueffect_clock_0_in      (cpu_0_data_master_read_data_valid_cpueffect_clock_0_in),
      .cpu_0_data_master_read_data_valid_datain_s1                 (cpu_0_data_master_read_data_valid_datain_s1),
      .cpu_0_data_master_read_data_valid_dataout_s1                (cpu_0_data_master_read_data_valid_dataout_s1),
      .cpu_0_data_master_read_data_valid_onchip_memory2_0_s1       (cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_data_master_read_data_valid_vibrato_on_s1             (cpu_0_data_master_read_data_valid_vibrato_on_s1),
      .cpu_0_data_master_readdata                                  (cpu_0_data_master_readdata),
      .cpu_0_data_master_readdatavalid                             (cpu_0_data_master_readdatavalid),
      .cpu_0_data_master_requests_adclrc_s1                        (cpu_0_data_master_requests_adclrc_s1),
      .cpu_0_data_master_requests_chorus_on_s1                     (cpu_0_data_master_requests_chorus_on_s1),
      .cpu_0_data_master_requests_clk_s1                           (cpu_0_data_master_requests_clk_s1),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module          (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_cpueffect_clock_0_in             (cpu_0_data_master_requests_cpueffect_clock_0_in),
      .cpu_0_data_master_requests_datain_s1                        (cpu_0_data_master_requests_datain_s1),
      .cpu_0_data_master_requests_dataout_s1                       (cpu_0_data_master_requests_dataout_s1),
      .cpu_0_data_master_requests_onchip_memory2_0_s1              (cpu_0_data_master_requests_onchip_memory2_0_s1),
      .cpu_0_data_master_requests_vibrato_on_s1                    (cpu_0_data_master_requests_vibrato_on_s1),
      .cpu_0_data_master_waitrequest                               (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                 (cpu_0_data_master_writedata),
      .cpu_0_jtag_debug_module_readdata_from_sa                    (cpu_0_jtag_debug_module_readdata_from_sa),
      .cpueffect_clock_0_in_readdata_from_sa                       (cpueffect_clock_0_in_readdata_from_sa),
      .cpueffect_clock_0_in_waitrequest_from_sa                    (cpueffect_clock_0_in_waitrequest_from_sa),
      .d1_adclrc_s1_end_xfer                                       (d1_adclrc_s1_end_xfer),
      .d1_chorus_on_s1_end_xfer                                    (d1_chorus_on_s1_end_xfer),
      .d1_clk_s1_end_xfer                                          (d1_clk_s1_end_xfer),
      .d1_cpu_0_jtag_debug_module_end_xfer                         (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_cpueffect_clock_0_in_end_xfer                            (d1_cpueffect_clock_0_in_end_xfer),
      .d1_datain_s1_end_xfer                                       (d1_datain_s1_end_xfer),
      .d1_dataout_s1_end_xfer                                      (d1_dataout_s1_end_xfer),
      .d1_onchip_memory2_0_s1_end_xfer                             (d1_onchip_memory2_0_s1_end_xfer),
      .d1_vibrato_on_s1_end_xfer                                   (d1_vibrato_on_s1_end_xfer),
      .datain_s1_readdata_from_sa                                  (datain_s1_readdata_from_sa),
      .dataout_s1_readdata_from_sa                                 (dataout_s1_readdata_from_sa),
      .onchip_memory2_0_s1_readdata_from_sa                        (onchip_memory2_0_s1_readdata_from_sa),
      .reset_n                                                     (cpu_clk_reset_n),
      .vibrato_on_s1_readdata_from_sa                              (vibrato_on_s1_readdata_from_sa)
    );

  cpu_0_instruction_master_arbitrator the_cpu_0_instruction_master
    (
      .clk                                                                (cpu_clk),
      .cpu_0_instruction_master_address                                   (cpu_0_instruction_master_address),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_granted_onchip_memory2_0_s1               (cpu_0_instruction_master_granted_onchip_memory2_0_s1),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1     (cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1       (cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_instruction_master_readdata                                  (cpu_0_instruction_master_readdata),
      .cpu_0_instruction_master_readdatavalid                             (cpu_0_instruction_master_readdatavalid),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_onchip_memory2_0_s1              (cpu_0_instruction_master_requests_onchip_memory2_0_s1),
      .cpu_0_instruction_master_waitrequest                               (cpu_0_instruction_master_waitrequest),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_onchip_memory2_0_s1_end_xfer                                    (d1_onchip_memory2_0_s1_end_xfer),
      .onchip_memory2_0_s1_readdata_from_sa                               (onchip_memory2_0_s1_readdata_from_sa),
      .reset_n                                                            (cpu_clk_reset_n)
    );

  cpu_0 the_cpu_0
    (
      .A_ci_multi_a                          (cpu_0_custom_instruction_master_multi_a),
      .A_ci_multi_b                          (cpu_0_custom_instruction_master_multi_b),
      .A_ci_multi_c                          (cpu_0_custom_instruction_master_multi_c),
      .A_ci_multi_clk_en                     (cpu_0_custom_instruction_master_multi_clk_en),
      .A_ci_multi_dataa                      (cpu_0_custom_instruction_master_multi_dataa),
      .A_ci_multi_datab                      (cpu_0_custom_instruction_master_multi_datab),
      .A_ci_multi_done                       (cpu_0_custom_instruction_master_multi_done),
      .A_ci_multi_estatus                    (cpu_0_custom_instruction_master_multi_estatus),
      .A_ci_multi_ipending                   (cpu_0_custom_instruction_master_multi_ipending),
      .A_ci_multi_n                          (cpu_0_custom_instruction_master_multi_n),
      .A_ci_multi_readra                     (cpu_0_custom_instruction_master_multi_readra),
      .A_ci_multi_readrb                     (cpu_0_custom_instruction_master_multi_readrb),
      .A_ci_multi_result                     (cpu_0_custom_instruction_master_multi_result),
      .A_ci_multi_start                      (cpu_0_custom_instruction_master_multi_start),
      .A_ci_multi_status                     (cpu_0_custom_instruction_master_multi_status),
      .A_ci_multi_writerc                    (cpu_0_custom_instruction_master_multi_writerc),
      .clk                                   (cpu_clk),
      .d_address                             (cpu_0_data_master_address),
      .d_byteenable                          (cpu_0_data_master_byteenable),
      .d_irq                                 (cpu_0_data_master_irq),
      .d_read                                (cpu_0_data_master_read),
      .d_readdata                            (cpu_0_data_master_readdata),
      .d_readdatavalid                       (cpu_0_data_master_readdatavalid),
      .d_waitrequest                         (cpu_0_data_master_waitrequest),
      .d_write                               (cpu_0_data_master_write),
      .d_writedata                           (cpu_0_data_master_writedata),
      .i_address                             (cpu_0_instruction_master_address),
      .i_read                                (cpu_0_instruction_master_read),
      .i_readdata                            (cpu_0_instruction_master_readdata),
      .i_readdatavalid                       (cpu_0_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_0_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_0_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_0_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_0_jtag_debug_module_byteenable),
      .jtag_debug_module_clk                 (cpu_clk),
      .jtag_debug_module_debugaccess         (cpu_0_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_0_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_0_jtag_debug_module_readdata),
      .jtag_debug_module_reset               (cpu_0_jtag_debug_module_reset),
      .jtag_debug_module_resetrequest        (cpu_0_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_0_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_0_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_0_jtag_debug_module_writedata),
      .reset_n                               (cpu_0_custom_instruction_master_reset_n)
    );

  cpu_0_fpoint_s1_arbitrator the_cpu_0_fpoint_s1
    (
      .clk                                                   (cpu_clk),
      .cpu_0_custom_instruction_master_multi_clk_en          (cpu_0_custom_instruction_master_multi_clk_en),
      .cpu_0_custom_instruction_master_multi_dataa           (cpu_0_custom_instruction_master_multi_dataa),
      .cpu_0_custom_instruction_master_multi_datab           (cpu_0_custom_instruction_master_multi_datab),
      .cpu_0_custom_instruction_master_multi_n               (cpu_0_custom_instruction_master_multi_n),
      .cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1 (cpu_0_custom_instruction_master_start_cpu_0_fpoint_s1),
      .cpu_0_fpoint_s1_clk_en                                (cpu_0_fpoint_s1_clk_en),
      .cpu_0_fpoint_s1_dataa                                 (cpu_0_fpoint_s1_dataa),
      .cpu_0_fpoint_s1_datab                                 (cpu_0_fpoint_s1_datab),
      .cpu_0_fpoint_s1_done                                  (cpu_0_fpoint_s1_done),
      .cpu_0_fpoint_s1_done_from_sa                          (cpu_0_fpoint_s1_done_from_sa),
      .cpu_0_fpoint_s1_n                                     (cpu_0_fpoint_s1_n),
      .cpu_0_fpoint_s1_reset                                 (cpu_0_fpoint_s1_reset),
      .cpu_0_fpoint_s1_result                                (cpu_0_fpoint_s1_result),
      .cpu_0_fpoint_s1_result_from_sa                        (cpu_0_fpoint_s1_result_from_sa),
      .cpu_0_fpoint_s1_select                                (cpu_0_fpoint_s1_select),
      .cpu_0_fpoint_s1_start                                 (cpu_0_fpoint_s1_start),
      .reset_n                                               (cpu_clk_reset_n)
    );

  cpu_0_fpoint the_cpu_0_fpoint
    (
      .clk    (cpu_clk),
      .clk_en (cpu_0_fpoint_s1_clk_en),
      .dataa  (cpu_0_fpoint_s1_dataa),
      .datab  (cpu_0_fpoint_s1_datab),
      .done   (cpu_0_fpoint_s1_done),
      .n      (cpu_0_fpoint_s1_n),
      .reset  (cpu_0_fpoint_s1_reset),
      .result (cpu_0_fpoint_s1_result),
      .start  (cpu_0_fpoint_s1_start)
    );

  cpueffect_clock_0_in_arbitrator the_cpueffect_clock_0_in
    (
      .clk                                                      (cpu_clk),
      .cpu_0_data_master_address_to_slave                       (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                             (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_cpueffect_clock_0_in           (cpu_0_data_master_granted_cpueffect_clock_0_in),
      .cpu_0_data_master_latency_counter                        (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_cpueffect_clock_0_in (cpu_0_data_master_qualified_request_cpueffect_clock_0_in),
      .cpu_0_data_master_read                                   (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_cpueffect_clock_0_in   (cpu_0_data_master_read_data_valid_cpueffect_clock_0_in),
      .cpu_0_data_master_requests_cpueffect_clock_0_in          (cpu_0_data_master_requests_cpueffect_clock_0_in),
      .cpu_0_data_master_write                                  (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                              (cpu_0_data_master_writedata),
      .cpueffect_clock_0_in_address                             (cpueffect_clock_0_in_address),
      .cpueffect_clock_0_in_byteenable                          (cpueffect_clock_0_in_byteenable),
      .cpueffect_clock_0_in_endofpacket                         (cpueffect_clock_0_in_endofpacket),
      .cpueffect_clock_0_in_endofpacket_from_sa                 (cpueffect_clock_0_in_endofpacket_from_sa),
      .cpueffect_clock_0_in_nativeaddress                       (cpueffect_clock_0_in_nativeaddress),
      .cpueffect_clock_0_in_read                                (cpueffect_clock_0_in_read),
      .cpueffect_clock_0_in_readdata                            (cpueffect_clock_0_in_readdata),
      .cpueffect_clock_0_in_readdata_from_sa                    (cpueffect_clock_0_in_readdata_from_sa),
      .cpueffect_clock_0_in_reset_n                             (cpueffect_clock_0_in_reset_n),
      .cpueffect_clock_0_in_waitrequest                         (cpueffect_clock_0_in_waitrequest),
      .cpueffect_clock_0_in_waitrequest_from_sa                 (cpueffect_clock_0_in_waitrequest_from_sa),
      .cpueffect_clock_0_in_write                               (cpueffect_clock_0_in_write),
      .cpueffect_clock_0_in_writedata                           (cpueffect_clock_0_in_writedata),
      .d1_cpueffect_clock_0_in_end_xfer                         (d1_cpueffect_clock_0_in_end_xfer),
      .reset_n                                                  (cpu_clk_reset_n)
    );

  cpueffect_clock_0_out_arbitrator the_cpueffect_clock_0_out
    (
      .clk                                              (clk_50),
      .cpueffect_clock_0_out_address                    (cpueffect_clock_0_out_address),
      .cpueffect_clock_0_out_address_to_slave           (cpueffect_clock_0_out_address_to_slave),
      .cpueffect_clock_0_out_byteenable                 (cpueffect_clock_0_out_byteenable),
      .cpueffect_clock_0_out_granted_pll_0_s1           (cpueffect_clock_0_out_granted_pll_0_s1),
      .cpueffect_clock_0_out_qualified_request_pll_0_s1 (cpueffect_clock_0_out_qualified_request_pll_0_s1),
      .cpueffect_clock_0_out_read                       (cpueffect_clock_0_out_read),
      .cpueffect_clock_0_out_read_data_valid_pll_0_s1   (cpueffect_clock_0_out_read_data_valid_pll_0_s1),
      .cpueffect_clock_0_out_readdata                   (cpueffect_clock_0_out_readdata),
      .cpueffect_clock_0_out_requests_pll_0_s1          (cpueffect_clock_0_out_requests_pll_0_s1),
      .cpueffect_clock_0_out_reset_n                    (cpueffect_clock_0_out_reset_n),
      .cpueffect_clock_0_out_waitrequest                (cpueffect_clock_0_out_waitrequest),
      .cpueffect_clock_0_out_write                      (cpueffect_clock_0_out_write),
      .cpueffect_clock_0_out_writedata                  (cpueffect_clock_0_out_writedata),
      .d1_pll_0_s1_end_xfer                             (d1_pll_0_s1_end_xfer),
      .pll_0_s1_readdata_from_sa                        (pll_0_s1_readdata_from_sa),
      .reset_n                                          (clk_50_reset_n)
    );

  cpueffect_clock_0 the_cpueffect_clock_0
    (
      .master_address       (cpueffect_clock_0_out_address),
      .master_byteenable    (cpueffect_clock_0_out_byteenable),
      .master_clk           (clk_50),
      .master_endofpacket   (cpueffect_clock_0_out_endofpacket),
      .master_nativeaddress (cpueffect_clock_0_out_nativeaddress),
      .master_read          (cpueffect_clock_0_out_read),
      .master_readdata      (cpueffect_clock_0_out_readdata),
      .master_reset_n       (cpueffect_clock_0_out_reset_n),
      .master_waitrequest   (cpueffect_clock_0_out_waitrequest),
      .master_write         (cpueffect_clock_0_out_write),
      .master_writedata     (cpueffect_clock_0_out_writedata),
      .slave_address        (cpueffect_clock_0_in_address),
      .slave_byteenable     (cpueffect_clock_0_in_byteenable),
      .slave_clk            (cpu_clk),
      .slave_endofpacket    (cpueffect_clock_0_in_endofpacket),
      .slave_nativeaddress  (cpueffect_clock_0_in_nativeaddress),
      .slave_read           (cpueffect_clock_0_in_read),
      .slave_readdata       (cpueffect_clock_0_in_readdata),
      .slave_reset_n        (cpueffect_clock_0_in_reset_n),
      .slave_waitrequest    (cpueffect_clock_0_in_waitrequest),
      .slave_write          (cpueffect_clock_0_in_write),
      .slave_writedata      (cpueffect_clock_0_in_writedata)
    );

  datain_s1_arbitrator the_datain_s1
    (
      .clk                                           (cpu_clk),
      .cpu_0_data_master_address_to_slave            (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_datain_s1           (cpu_0_data_master_granted_datain_s1),
      .cpu_0_data_master_latency_counter             (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_datain_s1 (cpu_0_data_master_qualified_request_datain_s1),
      .cpu_0_data_master_read                        (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_datain_s1   (cpu_0_data_master_read_data_valid_datain_s1),
      .cpu_0_data_master_requests_datain_s1          (cpu_0_data_master_requests_datain_s1),
      .cpu_0_data_master_write                       (cpu_0_data_master_write),
      .d1_datain_s1_end_xfer                         (d1_datain_s1_end_xfer),
      .datain_s1_address                             (datain_s1_address),
      .datain_s1_readdata                            (datain_s1_readdata),
      .datain_s1_readdata_from_sa                    (datain_s1_readdata_from_sa),
      .datain_s1_reset_n                             (datain_s1_reset_n),
      .reset_n                                       (cpu_clk_reset_n)
    );

  datain the_datain
    (
      .address  (datain_s1_address),
      .clk      (cpu_clk),
      .in_port  (in_port_to_the_datain),
      .readdata (datain_s1_readdata),
      .reset_n  (datain_s1_reset_n)
    );

  dataout_s1_arbitrator the_dataout_s1
    (
      .clk                                            (cpu_clk),
      .cpu_0_data_master_address_to_slave             (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_dataout_s1           (cpu_0_data_master_granted_dataout_s1),
      .cpu_0_data_master_latency_counter              (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_dataout_s1 (cpu_0_data_master_qualified_request_dataout_s1),
      .cpu_0_data_master_read                         (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_dataout_s1   (cpu_0_data_master_read_data_valid_dataout_s1),
      .cpu_0_data_master_requests_dataout_s1          (cpu_0_data_master_requests_dataout_s1),
      .cpu_0_data_master_write                        (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                    (cpu_0_data_master_writedata),
      .d1_dataout_s1_end_xfer                         (d1_dataout_s1_end_xfer),
      .dataout_s1_address                             (dataout_s1_address),
      .dataout_s1_chipselect                          (dataout_s1_chipselect),
      .dataout_s1_readdata                            (dataout_s1_readdata),
      .dataout_s1_readdata_from_sa                    (dataout_s1_readdata_from_sa),
      .dataout_s1_reset_n                             (dataout_s1_reset_n),
      .dataout_s1_write_n                             (dataout_s1_write_n),
      .dataout_s1_writedata                           (dataout_s1_writedata),
      .reset_n                                        (cpu_clk_reset_n)
    );

  dataout the_dataout
    (
      .address    (dataout_s1_address),
      .chipselect (dataout_s1_chipselect),
      .clk        (cpu_clk),
      .out_port   (out_port_from_the_dataout),
      .readdata   (dataout_s1_readdata),
      .reset_n    (dataout_s1_reset_n),
      .write_n    (dataout_s1_write_n),
      .writedata  (dataout_s1_writedata)
    );

  onchip_memory2_0_s1_arbitrator the_onchip_memory2_0_s1
    (
      .clk                                                            (cpu_clk),
      .cpu_0_data_master_address_to_slave                             (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                   (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_onchip_memory2_0_s1                  (cpu_0_data_master_granted_onchip_memory2_0_s1),
      .cpu_0_data_master_latency_counter                              (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_onchip_memory2_0_s1        (cpu_0_data_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_data_master_read                                         (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_onchip_memory2_0_s1          (cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_data_master_requests_onchip_memory2_0_s1                 (cpu_0_data_master_requests_onchip_memory2_0_s1),
      .cpu_0_data_master_write                                        (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                    (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                      (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_onchip_memory2_0_s1           (cpu_0_instruction_master_granted_onchip_memory2_0_s1),
      .cpu_0_instruction_master_latency_counter                       (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 (cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_instruction_master_read                                  (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1   (cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_instruction_master_requests_onchip_memory2_0_s1          (cpu_0_instruction_master_requests_onchip_memory2_0_s1),
      .d1_onchip_memory2_0_s1_end_xfer                                (d1_onchip_memory2_0_s1_end_xfer),
      .onchip_memory2_0_s1_address                                    (onchip_memory2_0_s1_address),
      .onchip_memory2_0_s1_byteenable                                 (onchip_memory2_0_s1_byteenable),
      .onchip_memory2_0_s1_chipselect                                 (onchip_memory2_0_s1_chipselect),
      .onchip_memory2_0_s1_clken                                      (onchip_memory2_0_s1_clken),
      .onchip_memory2_0_s1_readdata                                   (onchip_memory2_0_s1_readdata),
      .onchip_memory2_0_s1_readdata_from_sa                           (onchip_memory2_0_s1_readdata_from_sa),
      .onchip_memory2_0_s1_write                                      (onchip_memory2_0_s1_write),
      .onchip_memory2_0_s1_writedata                                  (onchip_memory2_0_s1_writedata),
      .reset_n                                                        (cpu_clk_reset_n)
    );

  onchip_memory2_0 the_onchip_memory2_0
    (
      .address    (onchip_memory2_0_s1_address),
      .byteenable (onchip_memory2_0_s1_byteenable),
      .chipselect (onchip_memory2_0_s1_chipselect),
      .clk        (cpu_clk),
      .clken      (onchip_memory2_0_s1_clken),
      .readdata   (onchip_memory2_0_s1_readdata),
      .write      (onchip_memory2_0_s1_write),
      .writedata  (onchip_memory2_0_s1_writedata)
    );

  pll_0_s1_arbitrator the_pll_0_s1
    (
      .clk                                              (clk_50),
      .cpueffect_clock_0_out_address_to_slave           (cpueffect_clock_0_out_address_to_slave),
      .cpueffect_clock_0_out_granted_pll_0_s1           (cpueffect_clock_0_out_granted_pll_0_s1),
      .cpueffect_clock_0_out_nativeaddress              (cpueffect_clock_0_out_nativeaddress),
      .cpueffect_clock_0_out_qualified_request_pll_0_s1 (cpueffect_clock_0_out_qualified_request_pll_0_s1),
      .cpueffect_clock_0_out_read                       (cpueffect_clock_0_out_read),
      .cpueffect_clock_0_out_read_data_valid_pll_0_s1   (cpueffect_clock_0_out_read_data_valid_pll_0_s1),
      .cpueffect_clock_0_out_requests_pll_0_s1          (cpueffect_clock_0_out_requests_pll_0_s1),
      .cpueffect_clock_0_out_write                      (cpueffect_clock_0_out_write),
      .cpueffect_clock_0_out_writedata                  (cpueffect_clock_0_out_writedata),
      .d1_pll_0_s1_end_xfer                             (d1_pll_0_s1_end_xfer),
      .pll_0_s1_address                                 (pll_0_s1_address),
      .pll_0_s1_chipselect                              (pll_0_s1_chipselect),
      .pll_0_s1_read                                    (pll_0_s1_read),
      .pll_0_s1_readdata                                (pll_0_s1_readdata),
      .pll_0_s1_readdata_from_sa                        (pll_0_s1_readdata_from_sa),
      .pll_0_s1_reset_n                                 (pll_0_s1_reset_n),
      .pll_0_s1_resetrequest                            (pll_0_s1_resetrequest),
      .pll_0_s1_resetrequest_from_sa                    (pll_0_s1_resetrequest_from_sa),
      .pll_0_s1_write                                   (pll_0_s1_write),
      .pll_0_s1_writedata                               (pll_0_s1_writedata),
      .reset_n                                          (clk_50_reset_n)
    );

  //cpu_clk out_clk assignment, which is an e_assign
  assign cpu_clk = out_clk_pll_0_c0;

  pll_0 the_pll_0
    (
      .address      (pll_0_s1_address),
      .c0           (out_clk_pll_0_c0),
      .chipselect   (pll_0_s1_chipselect),
      .clk          (clk_50),
      .read         (pll_0_s1_read),
      .readdata     (pll_0_s1_readdata),
      .reset_n      (pll_0_s1_reset_n),
      .resetrequest (pll_0_s1_resetrequest),
      .write        (pll_0_s1_write),
      .writedata    (pll_0_s1_writedata)
    );

  vibrato_on_s1_arbitrator the_vibrato_on_s1
    (
      .clk                                               (cpu_clk),
      .cpu_0_data_master_address_to_slave                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_vibrato_on_s1           (cpu_0_data_master_granted_vibrato_on_s1),
      .cpu_0_data_master_latency_counter                 (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_vibrato_on_s1 (cpu_0_data_master_qualified_request_vibrato_on_s1),
      .cpu_0_data_master_read                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_vibrato_on_s1   (cpu_0_data_master_read_data_valid_vibrato_on_s1),
      .cpu_0_data_master_requests_vibrato_on_s1          (cpu_0_data_master_requests_vibrato_on_s1),
      .cpu_0_data_master_write                           (cpu_0_data_master_write),
      .d1_vibrato_on_s1_end_xfer                         (d1_vibrato_on_s1_end_xfer),
      .reset_n                                           (cpu_clk_reset_n),
      .vibrato_on_s1_address                             (vibrato_on_s1_address),
      .vibrato_on_s1_readdata                            (vibrato_on_s1_readdata),
      .vibrato_on_s1_readdata_from_sa                    (vibrato_on_s1_readdata_from_sa),
      .vibrato_on_s1_reset_n                             (vibrato_on_s1_reset_n)
    );

  vibrato_on the_vibrato_on
    (
      .address  (vibrato_on_s1_address),
      .clk      (cpu_clk),
      .in_port  (in_port_to_the_vibrato_on),
      .readdata (vibrato_on_s1_readdata),
      .reset_n  (vibrato_on_s1_reset_n)
    );

  //reset is asserted asynchronously and deasserted synchronously
  cpueffect_reset_cpu_clk_domain_synch_module cpueffect_reset_cpu_clk_domain_synch
    (
      .clk      (cpu_clk),
      .data_in  (1'b1),
      .data_out (cpu_clk_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    0 |
    pll_0_s1_resetrequest_from_sa |
    pll_0_s1_resetrequest_from_sa);

  //reset is asserted asynchronously and deasserted synchronously
  cpueffect_reset_clk_50_domain_synch_module cpueffect_reset_clk_50_domain_synch
    (
      .clk      (clk_50),
      .data_in  (1'b1),
      .data_out (clk_50_reset_n),
      .reset_n  (reset_n_sources)
    );

  //cpu_0_data_master_irq of type irq does not connect to anything so wire it to default (0)
  assign cpu_0_data_master_irq = 0;

  //cpueffect_clock_0_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign cpueffect_clock_0_out_endofpacket = 0;


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "/home/lucaspeng/altera9.0/quartus/eda/sim_lib/altera_mf.v"
`include "/home/lucaspeng/altera9.0/quartus/eda/sim_lib/220model.v"
`include "/home/lucaspeng/altera9.0/quartus/eda/sim_lib/sgate.v"
`include "datain.v"
`include "chorus_on.v"
`include "cpu_0_fpoint.v"
`include "cpu_0_test_bench.v"
`include "cpu_0_mult_cell.v"
`include "cpu_0_oci_test_bench.v"
`include "cpu_0_jtag_debug_module_tck.v"
`include "cpu_0_jtag_debug_module_sysclk.v"
`include "cpu_0_jtag_debug_module_wrapper.v"
`include "cpu_0.v"
`include "vibrato_on.v"
`include "clk.v"
`include "onchip_memory2_0.v"
`include "cpueffect_clock_0.v"
`include "adclrc.v"
`include "dataout.v"
`include "pll_0.v"
`include "altpllpll_0.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             clk;
  reg              clk_50;
  wire    [  4: 0] cpu_0_custom_instruction_master_multi_a;
  wire    [  4: 0] cpu_0_custom_instruction_master_multi_b;
  wire    [  4: 0] cpu_0_custom_instruction_master_multi_c;
  wire             cpu_0_custom_instruction_master_multi_estatus;
  wire    [ 31: 0] cpu_0_custom_instruction_master_multi_ipending;
  wire             cpu_0_custom_instruction_master_multi_readra;
  wire             cpu_0_custom_instruction_master_multi_readrb;
  wire             cpu_0_custom_instruction_master_multi_status;
  wire             cpu_0_custom_instruction_master_multi_writerc;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire             cpu_clk;
  wire             cpueffect_clock_0_in_endofpacket_from_sa;
  wire             cpueffect_clock_0_out_endofpacket;
  wire             in_port_to_the_adclrc;
  wire             in_port_to_the_chorus_on;
  wire             in_port_to_the_clk;
  wire    [ 15: 0] in_port_to_the_datain;
  wire             in_port_to_the_vibrato_on;
  wire    [ 15: 0] out_port_from_the_dataout;
  reg              reset_n;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  cpueffect DUT
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

  initial
    clk_50 = 1'b0;
  always
    #10 clk_50 <= ~clk_50;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on