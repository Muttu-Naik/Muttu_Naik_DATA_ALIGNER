`ifndef CFS_MD_DRIVER_SLAVE_SV
`define CFS_MD_DRIVER_SLAVE_SV

class cfs_md_driver_slave #(
  int unsigned DATA_WIDTH = 32
) extends cfs_md_driver #(
  .DATA_WIDTH(DATA_WIDTH),
  .ITEM_DRV  (cfs_md_item_drv_slave)
);

  // Pointer to the agent configuration component
  cfs_md_agent_config_slave #(DATA_WIDTH) agent_config;

  typedef virtual cfs_md_if #(DATA_WIDTH) cfs_md_vif;

  `uvm_component_param_utils(cfs_md_driver_slave#(DATA_WIDTH))

  // Constructor
  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Elaboration checks
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);

    if (super.agent_config == null) begin
      `uvm_fatal("ALGORITHM_ISSUE",
        $sformatf("agent_config is null in %0s", get_full_name()))
    end

    if (!$cast(agent_config, super.agent_config)) begin
      `uvm_fatal("ALGORITHM_ISSUE",
        $sformatf("Cast failed from %0s to slave config",
        super.agent_config.get_full_name()))
    end
  endfunction

 // Drive one transaction
 protected virtual task drive_transaction(cfs_md_item_drv_slave item);
  cfs_md_vif vif = agent_config.get_vif();

  `uvm_info("ITEM_START", $sformatf("Driving \"%0s\": %0s",item.get_full_name(), item.convert2string()), UVM_LOW)

  // Default value
  vif.err <= 0;

  @(posedge vif.clk);

  while(vif.valid !== 1)
    @(posedge vif.clk);

  `uvm_info("DEBUGG", "VALID IS HIGH" ,UVM_NONE)

  // Assert ready when valid transaction is present
   vif.ready <= item.ready_at_end;
 //vif.ready <= 1;  
    vif.err <= bit'(item.response);
 //   vif.err <= 0;    

  // Drive err during active transfer
/*do begin
  if (vif.valid && vif.ready)
    vif.err <= bit'(item.response);
  else
    vif.err <= 0;

  @(posedge vif.clk);
end while (vif.valid === 1);*/

    
  // Cleanup
  vif.ready <= item.ready_at_end;
    //vif.ready <= 1;    
    vif.err   <= 0;
endtask

  // Reset handling
  virtual function void handle_reset(uvm_phase phase);

    cfs_md_vif vif = agent_config.get_vif();

    super.handle_reset(phase);

    vif.ready <= agent_config.get_ready_at_reset();
    vif.err   <= 0;

  endfunction

endclass

`endif // CFS_MD_DRIVER_SLAVE_SV*/

