0) Setup initial directory:
```
CMSSWVER=CMSSW_8_0_5_patch1 # or whatever version to be used
cmsrel $CMSSWVER
cd $CMSSWVER/src
git clone https://github.com/cms-jet/JetMETAnalysis
cd JetMETAnalysis
cmsenv
scram b -j10
# note: in 102X, there's a buildfile error, so add a line for version 2 with the new checksum and change
# edit the xml node to match the pattern of the others 
# then edit the source or header file to have ClassDef(2) instead of 1.
# scram b vclean ; scram b -j10
cd JetAnalyzers/test
git clone https://github.com/aminnj/jecs
```
And be sure to modify paths in scripts to match reality

1) Run on PUFlat, PU, NoPU samples in the crab/ directory 

2) Merge files (scripts in crab/tomerge/) and move them into this current directory

Note, for all scripts, edit `basedir` to be the full path to this repository's base directory.
Also edit `algos` and `era` appropriately.

3) Make L1 corrections, plot them, and apply them to the PUFlat sample with `commands.sh` in `l1/`

4) Plot L1 corrected PUFlat sample them with `commands.sh` in `l1/afterl1corr/`

5) Derive L2L3 with `commands.sh` in `l2l3`

6) Make validation plots
```bash
cd validation/
mkdir plots
git clone https://github.com/cmstas/CORE
cd CORE
make -j10
cd ..
# update stuff in doAll.C
root -b -q -l doAll.C
```

7) Get appropriate uncertainties from latest FullSim era to use in `makeUncertainties.py`

8) Make slides with `python *py` inside of `validation/slides/`
```bash
git clone https://github.com/aminnj/makers/
cd makers/slideMaker
export PATH=`pwd`:${PATH}
export PYTHONPATH=`pwd`:${PYTHONPATH}
export PATH=/nfs-7/texlive/2015/bin/x86_64-linux:$PATH
```

9) Copy JECs with `. copy_jecs.sh`

10) Present at JetMET meeting
