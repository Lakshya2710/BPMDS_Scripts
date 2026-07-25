#!/bin/bash
#PBS -N BPMDS_Master_Run
#PBS -o pipeline_log.txt
#PBS -e pipeline_error.txt
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=40

# 1. Setup Aqua Scratch Directory
tpdir=`echo $PBS_JOBID | cut -f 1 -d .`
tempdir=$HOME/scratch/job$tpdir
mkdir -p $tempdir
cd $tempdir

# ==============================================================================
# THE BULLETPROOF BASH TRAP
# ==============================================================================
rescue_data() {
    echo -e "\nJOB TERMINATING (Walltime Reached or Natural Finish). Rescuing data..."
    # Copy standalone files
    #cp benchmark_execution_times.csv $PBS_O_WORKDIR/
    #cp benchmark_memory_usage.csv $PBS_O_WORKDIR/
    cp master_console_output.txt $PBS_O_WORKDIR/
    #cp BPMDS1.csv $PBS_O_WORKDIR/    

    # Copy directories recursively, updating existing files natively
    #cp -r Outputs $PBS_O_WORKDIR/
    cp -r Outputs_Rho1 $PBS_O_WORKDIR/
    #cp -r Scaling_Outputs $PBS_O_WORKDIR/
    
    echo "✅ Data safely merged back to home directory."
    exit
}

# Bind the rescue function to cluster termination signals
trap 'rescue_data' SIGTERM SIGINT
# ==============================================================================

# 2. Copy ALL files and directories from the working directory to scratch
# This ensures the Makefile, all source code, inputs, and scripts are present for compilation
cp -r $PBS_O_WORKDIR/* .

# 3. Load Python and grant execution permissions
module load python385
chmod +x ./Bin/* 2>/dev/null || true # Suppress error if Bin is empty before compiling

export OMP_STACKSIZE=256K
#export MALLOC_ARENA_MAX=320
export OMP_NUM_THREADS=40

echo "🚀 Starting Master BP_MDS Pipeline..."

# 4. Execute the Python script locally on the high-speed disk
# Added -u to force real-time console output writing!
python3 -u test_pipeline.py > master_console_output.txt

# 5. Trigger the rescue function to permanently save data when finished
rescue_data

# Cleanup (Commented out so we can inspect the scratch drive if it fails again)
# cd $HOME
# rm -rf $tempdir
