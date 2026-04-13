#===============================================================================
# Mentor QuestaSim UVM Regression Makefile
#===============================================================================

###############################################################################
# FILE LOCATIONS
###############################################################################
RTL_DIR      := ../../rtl
TB_TOP_DIR   := ../top

###############################################################################
# SOURCE FILES
###############################################################################
TOP_SRCS := \
	$(RTL_DIR)/design.sv \
	$(TB_TOP_DIR)/testbench.sv

###############################################################################
# TEST CONFIGURATION
###############################################################################
DEFAULT_TEST := cfs_algn_apb_tests_mapped_unmapped
TESTNAME ?= $(DEFAULT_TEST)

###############################################################################
# DIRECTORIES
###############################################################################
WORKLIB   := work
LOG_DIR   := logs
UCDB_DIR  := ucdb

###############################################################################
# FILES
###############################################################################
COMP_LOG   := $(LOG_DIR)/compile.log
SIM_LOG    := $(LOG_DIR)/$(TESTNAME).sim.log
TRANSCRIPT := $(LOG_DIR)/$(TESTNAME).transcript
UCDB_FILE  := $(UCDB_DIR)/$(TESTNAME).ucdb

###############################################################################
# SIMULATION OPTIONS
###############################################################################
TOGGLE_DO := ../../tb/sim/toggle_exclude.do

UVM_ARGS := \
	+UVM_TESTNAME=$(TESTNAME) \
	+UVM_MAX_QUIT_COUNT=20 \
	+access+rw \
	-f messages.f \
	-sv_seed RANDOM \
	+cover \
	+UVM_COVERAGE=ALL

###############################################################################
# DEFAULT TARGET
###############################################################################
all: clean comp run

###############################################################################
# COMPILE ONLY ONCE
###############################################################################
comp:
	@echo "[Compiling...]"
	@mkdir -p $(LOG_DIR)
	@mkdir -p $(UCDB_DIR)
	@rm -rf $(WORKLIB)
	@vlib $(WORKLIB)
	@vmap $(WORKLIB) $(WORKLIB)
	@vlog -sv -cover bcest -work $(WORKLIB) \
		$(TOP_SRCS) \
		+acc \
		+define+QUESTA \
		+incdir+$(RTL_DIR) \
		+incdir+$(TB_TOP_DIR) \
		2>&1 | tee $(COMP_LOG)

###############################################################################
# NORMAL RUN (Compile + Simulate)
###############################################################################
run: comp run_only

###############################################################################
# RUN ONLY (USED BY REGRESSION SCRIPT)
###############################################################################
run_only:
	@mkdir -p $(LOG_DIR)
	@mkdir -p $(UCDB_DIR)
	@echo "[Running Simulation: $(TESTNAME)]"
	@vsim -coverage -c work.testbench $(UVM_ARGS) \
		-do "do $(TOGGLE_DO); coverage save -onexit $(UCDB_FILE); run -all; quit -f;" \
		-l $(SIM_LOG)

###############################################################################
# GUI RUN
###############################################################################
grun: comp
	@mkdir -p $(LOG_DIR)
	@echo "[Running GUI Simulation: $(TESTNAME)]"
	@vsim -coverage work.testbench $(UVM_ARGS) \
		-do "log -r /*; do wave.do; run -all;" \
		-l $(SIM_LOG)

###############################################################################
# CLEAN
###############################################################################
clean:
	@echo "[Cleaning simulation files...]"
	@rm -rf $(WORKLIB)
	@rm -rf $(LOG_DIR)
	@rm -rf $(UCDB_DIR)
	@rm -rf vsim.wlf transcript
	@rm -f modelsim.ini

###############################################################################
# REGRESSION
###############################################################################
regress:
	@./regressions/run_regression.sh $(RUNS)

###############################################################################
# COVERAGE REPORT
###############################################################################
report:
	@echo "[Merging UCDB Files...]"
	@vcover merge $(UCDB_DIR)/merged.ucdb \
		$$(find $(UCDB_DIR) -name '*.ucdb' ! -name 'merged.ucdb')

	@echo "[Generating HTML Coverage Report...]"
	@vcover report -html \
		-output $(UCDB_DIR)/coverage_report \
		-details -verbose \
		$(UCDB_DIR)/merged.ucdb

	@echo "[Opening Coverage Report...]"
	@firefox $(UCDB_DIR)/coverage_report/index.html >/dev/null 2>&1 || true

###############################################################################
# PHONY TARGETS
###############################################################################
.PHONY: all comp run run_only grun clean regress report
