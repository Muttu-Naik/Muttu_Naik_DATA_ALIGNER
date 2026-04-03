`ifndef CFS_MD_SEQUENCE_TX_READY_BLOCK_SV
`define CFS_MD_SEQUENCE_TX_READY_BLOCK_SV

class cfs_md_sequence_tx_ready_block extends cfs_md_sequence_base_slave;

  `uvm_object_utils(cfs_md_sequence_tx_ready_block)

  function new(string name = "");
    super.new(name);
  endfunction

  virtual task body();

    cfs_md_item_mon item_mon;
    cfs_md_sequence_simple_slave seq; 

    forever begin

      p_sequencer.pending_items.get(item_mon);

      `uvm_do_with(seq, {
        item.ready_at_end == 1;
      });

    end

  endtask

endclass

`endif
