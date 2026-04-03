///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_apb_tests_3_1_3.sv
// Author:      Pranav
// Date:        2025-06-23
// Description: Test to verify the access types of IRQ and IRQEN registers.
//              
///////////////////////////////////////////////////////////////////////////////


`ifndef CFS_ALGN_APB_TESTS_3_1_3_SV
`define CFS_ALGN_APB_TESTS_3_1_3_SV

class cfs_algn_apb_tests_3_1_3 extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_apb_tests_3_1_3)

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfs_md_sequence_slave_response_forever resp_seq;
    cfs_algn_virtual_sequence_3_1_3 cfg_seq;
    cfs_algn_virtual_sequence_rx_crt rx_seq;
    cfs_algn_vif vif;

    uvm_reg_data_t irq_val;
    uvm_status_e status;
    uvm_reg_field irq_fields[$];

    phase.raise_objection(this, "TEST_START");

    #(100ns);

    // Fork forever slave responder
    fork
      begin
        cfs_md_sequence_tx_ready_block tx_block_seq = cfs_md_sequence_tx_ready_block::type_id::create(
            "tx_block_seq"
        );
        tx_block_seq.start(env.md_tx_agent.sequencer);
      end
    join_none

    cfg_seq = cfs_algn_virtual_sequence_3_1_3::type_id::create("cfg_seq");
    cfg_seq.set_sequencer(env.virtual_sequencer);
    cfg_seq.start(env.virtual_sequencer);

    // Step 2: Wait a bit before sending traffic
    vif = env.env_config.get_vif();
    repeat (50) @(posedge vif.clk);

    // Step 3: Send 10 legal RX packets
    for (int i = 0; i < 10; i++) begin
      rx_seq = cfs_algn_virtual_sequence_rx_crt::type_id::create($sformatf("rx_seq_%0d", i));
      rx_seq.set_sequencer(env.virtual_sequencer);
      void'(rx_seq.randomize());
      rx_seq.start(env.virtual_sequencer);
    end

    #(100ns);


    // Step 4: Read all fields of the IRQ register
    env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
    `uvm_info("IRQ_READ", $sformatf("IRQ register value = 0x%0h", irq_val), UVM_LOW)

    env.model.reg_block.IRQ.TX_FIFO_FULL.write(status, 1, UVM_FRONTDOOR);

    env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
    `uvm_info("IRQ_READ", $sformatf("IRQ register value = 0x%0h", irq_val), UVM_LOW)

    #(500ns);

    phase.drop_objection(this, "TEST_DONE");
  endtask

endclass

`endif



/*
`ifndef CFS_ALGN_APB_TESTS_3_1_3_SV
`define CFS_ALGN_APB_TESTS_3_1_3_SV

class cfs_algn_apb_tests_3_1_3 extends cfs_algn_test_base;

  `uvm_component_utils(cfs_algn_apb_tests_3_1_3)

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction


  virtual task run_phase(uvm_phase phase);

    cfs_algn_virtual_sequence_3_1_3 cfg_seq;
    cfs_algn_virtual_sequence_rx_crt rx_seq;
    cfs_algn_vif vif;

    uvm_reg_data_t irq_val;
    uvm_reg_data_t irqen_val;
    uvm_status_e status;

    phase.raise_objection(this, "TEST_START");

    #(100ns);

    //------------------------------------------------------------
    // Start TX ready blocking sequence (as in your original test)
    //------------------------------------------------------------
    fork
      begin
        cfs_md_sequence_tx_ready_block tx_block_seq;
        tx_block_seq = cfs_md_sequence_tx_ready_block::type_id::create("tx_block_seq");
        tx_block_seq.start(env.md_tx_agent.sequencer);
      end
    join_none


    //------------------------------------------------------------
    // Step 1: Initial configuration
    //------------------------------------------------------------
    cfg_seq = cfs_algn_virtual_sequence_3_1_3::type_id::create("cfg_seq");
    cfg_seq.set_sequencer(env.virtual_sequencer);
    cfg_seq.start(env.virtual_sequencer);

    vif = env.env_config.get_vif();
    repeat (20) @(posedge vif.clk);


    //------------------------------------------------------------
    // Step 2: IRQEN RW check
    //------------------------------------------------------------
    env.model.reg_block.IRQEN.write(status, 'hFF, UVM_FRONTDOOR);
    env.model.reg_block.IRQEN.read(status, irqen_val, UVM_FRONTDOOR);

    if (irqen_val != 'h1F) begin
      `uvm_error("IRQEN_RW_FAIL",
        $sformatf("IRQEN mismatch: expected 0xFF got 0x%0h", irqen_val))
    end else begin
      `uvm_info("IRQEN_RW_PASS", "IRQEN RW check passed", UVM_LOW)
    end


    //------------------------------------------------------------
    // Step 3: Generate RX traffic to trigger interrupt
    //------------------------------------------------------------
    for (int i = 0; i < 10; i++) begin
      rx_seq = cfs_algn_virtual_sequence_rx_crt::type_id::create($sformatf("rx_seq_%0d", i));
      rx_seq.set_sequencer(env.virtual_sequencer);
      void'(rx_seq.randomize());
      rx_seq.start(env.virtual_sequencer);
    end

    #(200ns);


    //------------------------------------------------------------
    // Step 4: Read IRQ and check interrupt is set
    //------------------------------------------------------------
    env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);
    `uvm_info("IRQ_READ",
      $sformatf("IRQ register value after interrupt = 0x%0h", irq_val),
      UVM_LOW)

    if (irq_val == 0) begin
      `uvm_error("IRQ_NOT_SET",
        "Expected at least one IRQ bit set, but got 0")
    end


    //------------------------------------------------------------
    // Step 5: W1C check (write 1 clears)
    //------------------------------------------------------------
    env.model.reg_block.IRQ.write(status, irq_val, UVM_FRONTDOOR);

    env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);

    if (irq_val != 0) begin
      `uvm_error("W1C_FAIL",
        $sformatf("IRQ not cleared after W1C write, value = 0x%0h", irq_val))
    end else begin
      `uvm_info("W1C_PASS", "IRQ cleared correctly with write-1", UVM_LOW)
    end


    //------------------------------------------------------------
    // Step 6: Write 0 should NOT clear (negative check)
    //------------------------------------------------------------
    // Trigger interrupt again
    for (int i = 0; i < 5; i++) begin
      rx_seq = cfs_algn_virtual_sequence_rx_crt::type_id::create($sformatf("rx_seq2_%0d", i));
      rx_seq.set_sequencer(env.virtual_sequencer);
      void'(rx_seq.randomize());
      rx_seq.start(env.virtual_sequencer);
    end

    #(200ns);

    env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);

    if (irq_val == 0) begin
      `uvm_error("IRQ_NOT_SET_AGAIN",
        "Interrupt not set for W0 test")
    end

    // Write 0 → should NOT clear
    env.model.reg_block.IRQ.write(status, 'h0, UVM_FRONTDOOR);

    env.model.reg_block.IRQ.read(status, irq_val, UVM_FRONTDOOR);

    if (irq_val == 0) begin
      `uvm_error("W0_FAIL",
        "IRQ incorrectly cleared by writing 0")
    end else begin
      `uvm_info("W0_PASS", "IRQ not cleared by write-0 (correct)", UVM_LOW)
    end


    #(200ns);

    phase.drop_objection(this, "TEST_DONE");

  endtask

endclass

`endif
*/
