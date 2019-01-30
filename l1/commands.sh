flatPU=JRA_PUFlat.root
noPU=JRA_NoPU.root
basepath=/home/users/namin/2019/jec/CMSSW_10_2_9/src/JetMETAnalysis/JetAnalyzers/jecs/
outputpath=${basepath}/l1/
era=Autumn18_V1

algos="
ak4pf
ak4pfchs
ak8pf
ak8pfchs
"


##### 1 #####

# get root files for matched jets for L1 correction
for algo in $algos; do
    jet_synchtest_x -algo1 $algo -algo2 $algo -samplePU $flatPU -sampleNoPU $noPU -basepath $basepath -outputPath $outputpath | tee log_${algo}.txt
done

##### 2 #####

# make L1 corrections and plot them
mkdir -p images/
mkdir -p parameters/
mkdir -p text/
for algo in $algos; do
    alias=$(python -c "print '$algo'.replace('ak','AK').replace('pf','PF')")
    jet_synchfit_x -algo1 $algo -algo2 $algo -era ${era}
    jet_synchplot_x -algo1 $algo -algo2 $algo -outputFormat ".pdf" -fixedRange false
    mv Parameter_${algo}.* parameters/
    # mv parameters_${algo}.txt text/${era}_L1FastJet_${alias}.txt
    mv ${era}_L1FastJet_${alias}.txt text/
done

##### 3 #####

# apply L1 correction to flatPU sample
jecpath=$basepath/l1/text/
jet_apply_jec_x -input $basepath/JRA_PUFlat.root -era $era -jecpath $jecpath -L1FastJet true -levels 1
