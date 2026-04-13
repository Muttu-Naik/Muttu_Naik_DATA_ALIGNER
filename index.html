#!/bin/bash
###############################################################################
# Stable Parallel Regression Dashboard for QuestaSim
###############################################################################

set +e

MAX_JOBS=4
BASE_LOG_DIR="logs"
TEST_DIR="../test"

STATUS_DB="$BASE_LOG_DIR/status.db"
HTML_REPORT="$BASE_LOG_DIR/regression_dashboard.html"
COMPILE_LOG="$BASE_LOG_DIR/compile.log"
LOCK_FILE="$BASE_LOG_DIR/status.lock"

###############################################################################
# EMAIL CONFIG
###############################################################################
EMAIL_SUBJECT="DATA_ALIGNER PROJECT Regression Report"
EMAIL_TO="muttu.naik@vaaluka.com"
EMAIL_CC="paranthapa.yella@vaaluka.com"

###############################################################################
# INIT
###############################################################################
rm -rf "$BASE_LOG_DIR"
mkdir -p "$BASE_LOG_DIR"

touch "$STATUS_DB"
touch "$LOCK_FILE"

REG_START=$(date +%s)
TOTAL_ELAPSED=""
REGRESSION_DONE=0

###############################################################################
# HELPERS
###############################################################################
extract_count() {
    local patt=$1
    local file=$2
    local val

    val=$(grep "$patt" "$file" 2>/dev/null | grep -o '[0-9]\+' | tail -1)
    [[ "$val" =~ ^[0-9]+$ ]] || val=0
    echo "$val"
}

get_root_cause() {
    local log=$1

    if grep -qi "mirrored value" "$log"; then
        echo "Register mismatch"
    elif grep -qi "timeout" "$log"; then
        echo "Timeout / Handshake Stall"
    elif grep -qi "null pointer" "$log"; then
        echo "Null Pointer"
    elif grep -qi "overflow" "$log"; then
        echo "FIFO Overflow"
    else
        echo "Check Log"
    fi
}

###############################################################################
# THREAD SAFE STATUS UPDATE
###############################################################################
update_status() {
    local TEST=$1
    local STATUS=$2
    local FATAL=$3
    local ERROR=$4
    local WARN=$5
    local LOG=$6
    local ROOT=$7
    local RUNTIME=$8

    (
        flock -x 200

        awk -F'|' \
        -v t="$TEST" \
        -v s="$STATUS" \
        -v f="$FATAL" \
        -v e="$ERROR" \
        -v w="$WARN" \
        -v l="$LOG" \
        -v r="$ROOT" \
        -v rt="$RUNTIME" '
        BEGIN { OFS="|" }
        {
            if ($1 == t)
                print t,s,f,e,w,l,r,rt
            else
                print
        }' "$STATUS_DB" > "$STATUS_DB.tmp"

        mv "$STATUS_DB.tmp" "$STATUS_DB"

    ) 200>"$LOCK_FILE"
}

###############################################################################
# HTML DASHBOARD GENERATION
###############################################################################
generate_html() {

    TOTAL=$(wc -l < "$STATUS_DB")
    PASS=$(grep -c "|PASS|" "$STATUS_DB" 2>/dev/null)
    FAIL=$(grep -c "|FAIL|" "$STATUS_DB" 2>/dev/null)
    RUNNING=$(grep -c "|RUNNING|" "$STATUS_DB" 2>/dev/null)
    PENDING=$(grep -c "|PENDING|" "$STATUS_DB" 2>/dev/null)

    if [[ $TOTAL -eq 0 ]]; then
        PASS_PCT=0
    else
        PASS_PCT=$(awk "BEGIN {printf \"%.2f\", ($PASS/$TOTAL)*100}")
    fi

    if [[ -n "$TOTAL_ELAPSED" ]]; then
        ELAPSED=$TOTAL_ELAPSED
    else
        REG_NOW=$(date +%s)
        ELAPSED=$((REG_NOW - REG_START))
    fi

    REFRESH_TAG=""
    if [[ $REGRESSION_DONE -eq 0 ]]; then
        REFRESH_TAG='<meta http-equiv="refresh" content="5">'
    fi

cat > "$HTML_REPORT" << EOF
<html>
<head>
<title>Regression Dashboard</title>
$REFRESH_TAG
<style>
body { font-family: Arial; background:#0f172a; color:white; padding:20px; }

.card {
    display:inline-block;
    padding:12px 18px;
    margin:6px;
    border-radius:8px;
    font-weight:bold;
}

.total{background:#334155;}
.pass{background:#15803d;}
.fail{background:#b91c1c;}
.run{background:#d97706;}
.pending{background:#475569;}
.info{background:#2563eb;}

table {
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}

th,td {
    border:1px solid #334155;
    padding:10px;
    vertical-align:top;
}

th { background:#1e293b; }

.passText{color:#22c55e;font-weight:bold;}
.failText{color:#ef4444;font-weight:bold;}
.runText{color:#f59e0b;font-weight:bold;}
.pendingText{color:#94a3b8;font-weight:bold;}

details summary {
    cursor:pointer;
    color:#60a5fa;
}

pre {
    background:#111827;
    padding:8px;
    border-radius:6px;
    white-space:pre-wrap;
    font-size:12px;
}
</style>
</head>
<body>

<h1>DATA_ALIGNER Project Parallel Regression Dashboard</h1>

<div class="card total">TOTAL: $TOTAL</div>
<div class="card pass">PASS: $PASS</div>
<div class="card fail">FAIL: $FAIL</div>
<div class="card run">RUNNING: $RUNNING</div>
<div class="card pending">PENDING: $PENDING</div>
<div class="card info">PASS %: $PASS_PCT%</div>
<div class="card info">TOTAL TIME: ${ELAPSED}s</div>

<table>
<tr>
<th>Test</th>
<th>Status</th>
<th>Fatal</th>
<th>Error</th>
<th>Warn</th>
<th>Runtime</th>
<th>Details</th>
</tr>
EOF

while IFS='|' read -r TEST STATUS FATAL ERROR WARN LOG ROOT RUNTIME; do

    CLASS="pendingText"
    [[ "$STATUS" == "RUNNING" ]] && CLASS="runText"
    [[ "$STATUS" == "PASS" ]] && CLASS="passText"
    [[ "$STATUS" == "FAIL" ]] && CLASS="failText"

    DETAIL="-"

    WARN_LINES=$(grep "UVM_WARNING" "$LOG" 2>/dev/null | tail -5)
    ERR_LINES=$(grep -E "UVM_ERROR|UVM_FATAL" "$LOG" 2>/dev/null | tail -5)

    if [[ -n "$WARN_LINES" || -n "$ERR_LINES" ]]; then
DETAIL="<details>
<summary>View</summary>
<b>Root Cause:</b> ${ROOT:-Warnings Present}<br><br>
<pre>$WARN_LINES

$ERR_LINES</pre>
</details>"
    fi

cat >> "$HTML_REPORT" << EOF
<tr>
<td>$TEST</td>
<td class="$CLASS">$STATUS</td>
<td>$FATAL</td>
<td>$ERROR</td>
<td>$WARN</td>
<td>${RUNTIME}s</td>
<td>$DETAIL</td>
</tr>
EOF

done < "$STATUS_DB"

echo "</table></body></html>" >> "$HTML_REPORT"
}

###############################################################################
# OPEN DASHBOARD
###############################################################################
generate_html
firefox "file://$(realpath "$HTML_REPORT")" >/dev/null 2>&1 &

###############################################################################
# COMPILE
###############################################################################
echo "[INFO] Compiling..."
make clean >/dev/null 2>&1
mkdir -p "$BASE_LOG_DIR"
make comp > "$COMPILE_LOG" 2>&1 || exit 1

###############################################################################
# DISCOVER TESTS
###############################################################################
TEST_LIST=$(find "$TEST_DIR" -name "*.sv" \
           -exec grep -h "extends cfs_algn_test_base" {} + \
           | awk '{print $2}' \
           | sort -u)

echo "[INFO] Tests found: $(echo "$TEST_LIST" | wc -l)"

###############################################################################
# INIT STATUS DB
###############################################################################
> "$STATUS_DB"

for TEST in $TEST_LIST; do
    echo "$TEST|PENDING|0|0|0|||0" >> "$STATUS_DB"
done

###############################################################################
# DASHBOARD REFRESHER
###############################################################################
(
while [[ $REGRESSION_DONE -eq 0 ]]; do
    generate_html
    sleep 2
done
) &
REFRESH_PID=$!

###############################################################################
# RUN TEST
###############################################################################
run_test() {
    local TEST=$1
    local LOGFILE="$BASE_LOG_DIR/${TEST}.log"

    local START=$(date +%s)

    update_status "$TEST" "RUNNING" 0 0 0 "$LOGFILE" "" 0

    make run_only TESTNAME="$TEST" > "$LOGFILE" 2>&1 || true

    local END=$(date +%s)
    local RUNTIME=$((END - START))

    local FATAL ERROR WARN STATUS ROOT

    FATAL=$(extract_count "UVM_FATAL" "$LOGFILE")
    ERROR=$(extract_count "UVM_ERROR" "$LOGFILE")
    WARN=$(extract_count "UVM_WARNING" "$LOGFILE")

    if [[ $FATAL -eq 0 && $ERROR -eq 0 ]]; then
        STATUS="PASS"
        ROOT=""
    else
        STATUS="FAIL"
        ROOT=$(get_root_cause "$LOGFILE")
    fi

    update_status "$TEST" "$STATUS" "$FATAL" "$ERROR" "$WARN" "$LOGFILE" "$ROOT" "$RUNTIME"
}

export -f run_test extract_count get_root_cause update_status
export STATUS_DB LOCK_FILE BASE_LOG_DIR

###############################################################################
# PARALLEL EXECUTION
###############################################################################
PIDS=()

for TEST in $TEST_LIST; do
    run_test "$TEST" &
    PIDS+=($!)

    while [[ ${#PIDS[@]} -ge $MAX_JOBS ]]; do
        wait -n

        NEW_PIDS=()
        for pid in "${PIDS[@]}"; do
            if kill -0 "$pid" 2>/dev/null; then
                NEW_PIDS+=("$pid")
            fi
        done
        PIDS=("${NEW_PIDS[@]}")
    done
done

for pid in "${PIDS[@]}"; do
    wait "$pid"
done

###############################################################################
# FINALIZE
###############################################################################
REG_END=$(date +%s)
TOTAL_ELAPSED=$((REG_END - REG_START))

REGRESSION_DONE=1
kill $REFRESH_PID 2>/dev/null

generate_html

###############################################################################
# EMAIL REPORT
###############################################################################

echo "[INFO] Preparing email report..."

# Basic safety checks
if [[ ! -f "$STATUS_DB" ]]; then
    echo "[ERROR] STATUS_DB not found: $STATUS_DB"
    exit 1
fi

if [[ ! -f "$HTML_REPORT" ]]; then
    echo "[ERROR] HTML report not found: $HTML_REPORT"
    exit 1
fi

TOTAL=$(wc -l < "$STATUS_DB")
PASS=$(grep -c "|PASS|" "$STATUS_DB" 2>/dev/null || echo 0)
FAIL=$(grep -c "|FAIL|" "$STATUS_DB" 2>/dev/null || echo 0)

if [[ "$TOTAL" -gt 0 ]]; then
    PASS_PCT=$(awk "BEGIN {printf \"%.2f\", ($PASS/$TOTAL)*100}")
else
    PASS_PCT="0.00"
fi

EMAIL_BODY="$BASE_LOG_DIR/email_summary.txt"

cat > "$EMAIL_BODY" << EOF
Regression Completed Successfully

Summary:
--------------------------------
Total Tests   : $TOTAL
Passed        : $PASS
Failed        : $FAIL
Pass %        : $PASS_PCT%
Total Runtime : ${TOTAL_ELAPSED}s

Detailed HTML dashboard is attached.
Open it in any browser for full regression details.
EOF

echo "[INFO] Sending email..."

mutt -s "$EMAIL_SUBJECT" \
-c "$EMAIL_CC" \
-a "$HTML_REPORT" \
-- "$EMAIL_TO" < "$EMAIL_BODY"

EMAIL_STATUS=$?

if [[ $EMAIL_STATUS -ne 0 ]]; then
    echo "[ERROR] Email sending failed with exit code: $EMAIL_STATUS"
else
    echo "[INFO] Email sent successfully"
fi

###############################################################################
# SUCCESS BANNER
###############################################################################
echo ""
echo "=============================================================="
echo "     SUCCESS : REGRESSION COMPLETED AND EMAIL SENT"
echo "=============================================================="
echo " Dashboard : $HTML_REPORT"
echo " Runtime   : ${TOTAL_ELAPSED}s"
echo "=============================================================="
