#!/bin/bash
#!/bin/bash
#SBATCH -t 12:00:00
#SBATCH --ntasks=408
#SBATCH --job-name="regrid_esmf"
#SBATCH --tasks-per-node=24
#SBATCH -p t2standard
#SBATCH --account=akwaters
#SBATCH --output=regrid.%j
#SBATCH --no-requeue

# I need this to get a working ESMF.
source activate snowdrift
# NB: the mpirun used here is the one coming from recompiling mpi4py with gcc on gaea
# see .gitlab-cici.yml for directions

#time mpirun -np 252 ESMF_RegridWeightGen -s grid_bedmachineAnt.nc -d grid_gebco_30sec_southof62.nc -m neareststod -w nn_weights_bedmachine_gebco30sec.nc --netcdf4 --src_regional

time mpirun -np $SLURM_NTASKS ESMF_RegridWeightGen -s grid_bedmachineGrn.nc -d grid_gebco_15sec_northof58.nc -m neareststod -w nn_weights_bedmachine_gebco15sec.nc --netcdf4 --src_regional --dst_regional

# one could get bilinear weights using:

#time mpirun -np 252 ESMF_RegridWeightGen -s grid_bedmachineAnt.nc -d grid_gebco_30sec_southof62.nc -m bilinear -w bilin_weights_bedmachine_gebco30sec.nc --netcdf4 --src_regional --ignore_degenerate --ignore_unmapped

#time mpirun -np 252 ESMF_RegridWeightGen -s grid_bedmachineGrn.nc -d grid_gebco_15sec_northof39.nc -m bilinear -w bilin_weights_bedmachine_gebco15sec.nc --netcdf4 --src_regional --ignore_degenerate --ignore_unmapped

#tar -cf ESMFlogfiles.tar PET???.RegridWeightGen.Log
#rm PET???.RegridWeightGen.Log
