flatPUL1cor=JRA_PUFlat_jec.root
noPU=JRA_NoPU.root
basepath=/home/users/namin/2019/jec/CMSSW_10_2_9/src/JetMETAnalysis/JetAnalyzers/jecs/
outputpath=${basepath}/l1/afterl1corr/
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
    jet_synchtest_x -algo1 ${algo}l1 -algo2 $algo -samplePU $flatPUL1cor -sampleNoPU $noPU -basepath $basepath -outputPath $outputpath | tee log_${algo}l1.txt
done

##### 2 #####

# make L1 corrections and plot them
mkdir -p images/
mkdir -p parameters/
mkdir -p text/
for algo in $algos; do
    # jet_synchfit_x -algo1 ${algo}l1 -algo2 $algo
    jet_synchplot_x -algo1 ${algo}l1 -algo2 $algo -outputFormat ".pdf" -fixedRange false
    mv Parameter_${algo}.* parameters/
    mv ${era}_L1FastJet_${alias}.txt text/
done
