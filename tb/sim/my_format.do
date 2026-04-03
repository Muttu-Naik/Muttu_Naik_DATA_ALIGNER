onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/clk
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/reset_n
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/valid
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/ready
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/data
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/offset
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/size
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/err
add wave -noupdate -group MD_RX_IF /testbench/md_rx_if/has_checks
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/preset_n
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/pclk
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/clr_cnt_dop
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/status_cnt_drop
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/md_rx_clk
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/md_rx_valid
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/md_rx_ready
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/md_rx_data
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/md_rx_offset
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/md_rx_size
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/md_rx_err
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/push_valid
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/push_ready
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/push_data
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/rx_fifo_full
add wave -noupdate -group RX_CNTRL /testbench/dut/core/rx_ctrl/md_rx_clk_status_cnt_drop
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/reset_n
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/push_clk
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/push_valid
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/push_ready
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/push_data
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/push_full
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/push_empty
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/push_fifo_lvl
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/pop_clk
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/pop_valid
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/pop_ready
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/pop_data
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/pop_full
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/pop_empty
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/pop_fifo_lvl
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/rd_ptr_push
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/rd_ptr_pop
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/next_wr_ptr_push
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/next_rd_ptr_pop
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/wr_ptr_push
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/wr_ptr_pop
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/push_fifo_lvl_dly
add wave -noupdate -group RX_FIFO /testbench/dut/core/rx_fifo/pop_fifo_lvl_dly
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/reset_n
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/clk
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/pop_valid
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/pop_ready
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/pop_data
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/push_valid
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/push_ready
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/push_data
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/ctrl_offset
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/ctrl_size
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/unaligned_offset
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/unaligned_size
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/unaligned_data
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/unaligned_bytes_processed
add wave -noupdate -group ALIGNER_CNTRL /testbench/dut/core/ctrl/aligned_bytes_processed
add wave -noupdate -group ALIGNER_IF /testbench/algn_if/clk
add wave -noupdate -group ALIGNER_IF /testbench/algn_if/reset_n
add wave -noupdate -group ALIGNER_IF /testbench/algn_if/irq
add wave -noupdate -group ALIGNER_IF /testbench/algn_if/rx_fifo_push
add wave -noupdate -group ALIGNER_IF /testbench/algn_if/rx_fifo_pop
add wave -noupdate -group ALIGNER_IF /testbench/algn_if/tx_fifo_push
add wave -noupdate -group ALIGNER_IF /testbench/algn_if/tx_fifo_pop
add wave -noupdate -group APB_IF /testbench/apb_if/pclk
add wave -noupdate -group APB_IF /testbench/apb_if/preset_n
add wave -noupdate -group APB_IF /testbench/apb_if/paddr
add wave -noupdate -group APB_IF /testbench/apb_if/pwrite
add wave -noupdate -group APB_IF /testbench/apb_if/psel
add wave -noupdate -group APB_IF /testbench/apb_if/penable
add wave -noupdate -group APB_IF /testbench/apb_if/pwdata
add wave -noupdate -group APB_IF /testbench/apb_if/pready
add wave -noupdate -group APB_IF /testbench/apb_if/prdata
add wave -noupdate -group APB_IF /testbench/apb_if/pslverr
add wave -noupdate -group APB_IF /testbench/apb_if/has_checks
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/reset_n
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/push_clk
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/push_valid
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/push_ready
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/push_data
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/push_full
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/push_empty
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/push_fifo_lvl
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/pop_clk
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/pop_valid
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/pop_ready
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/pop_data
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/pop_full
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/pop_empty
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/pop_fifo_lvl
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/rd_ptr_push
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/rd_ptr_pop
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/next_wr_ptr_push
add wave -noupdate -group TX_FIFO /testbench/dut/core/tx_fifo/next_rd_ptr_pop
add wave -noupdate -group TX_CNTRL /testbench/dut/core/tx_ctrl/pop_valid
add wave -noupdate -group TX_CNTRL /testbench/dut/core/tx_ctrl/pop_data
add wave -noupdate -group TX_CNTRL /testbench/dut/core/tx_ctrl/pop_ready
add wave -noupdate -group TX_CNTRL /testbench/dut/core/tx_ctrl/md_tx_valid
add wave -noupdate -group TX_CNTRL /testbench/dut/core/tx_ctrl/md_tx_ready
add wave -noupdate -group TX_CNTRL /testbench/dut/core/tx_ctrl/md_tx_data
add wave -noupdate -group TX_CNTRL /testbench/dut/core/tx_ctrl/md_tx_offset
add wave -noupdate -group TX_CNTRL /testbench/dut/core/tx_ctrl/md_tx_size
add wave -noupdate -expand -group MD_TX_IF /testbench/md_tx_if/clk
add wave -noupdate -expand -group MD_TX_IF /testbench/md_tx_if/reset_n
add wave -noupdate -expand -group MD_TX_IF /testbench/md_tx_if/valid
add wave -noupdate -expand -group MD_TX_IF /testbench/md_tx_if/ready
add wave -noupdate -expand -group MD_TX_IF /testbench/md_tx_if/data
add wave -noupdate -expand -group MD_TX_IF /testbench/md_tx_if/offset
add wave -noupdate -expand -group MD_TX_IF /testbench/md_tx_if/size
add wave -noupdate -expand -group MD_TX_IF /testbench/md_tx_if/err
add wave -noupdate -expand -group MD_TX_IF /testbench/md_tx_if/has_checks
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20574 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 498
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {2809 ns} {3300 ns}
