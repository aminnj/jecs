#!/bin/bash

path="/hadoop/cms/store/user/namin/QCD_Pt-15to7000_TuneCP5_Flat2018_13TeV_pythia8/crab_forJECs-Autumn18-PU-v1/190129_212050/0000/"

samples = [

["JRA_PU","JRA_*.root"],

 ]

import os,glob

def getChunks(v,n=50): return [ v[i:i+n] for i in range(0, len(v), n) ]

path = path.replace("${USER}",os.getenv("USER"))

for final,loc in samples:

    files = glob.glob("%s/%s" % (path,loc))

    if(len(files) < 1): continue

    if os.path.isfile(final+".root"):
        print "%s.root already in here, skipping" % final
        continue

    print "[%s] %s" % (final,path+"/"+loc)

    chunks = getChunks(files, 50)

    if len(chunks) > 1:
        mergedChunks = []
        for ichunk,chunk in enumerate(chunks):
            args = " ".join(chunk)
            outfile = "%s_chunk%i.root" % (final, ichunk)
            mergedChunks.append(outfile)
            print "[%s] Making chunk %i of %i: %s" % (final, ichunk, len(chunks)-1, outfile)
            os.system("hadd -k %s %s > haddlog.txt" % (outfile, args))
        print "[%s] Making final file: %s.root" % (final,final)
        os.system("hadd -k %s.root %s >> haddlog.txt" % (final, " ".join(mergedChunks)))
        os.system("rm %s_chunk*.root" % (final))
    else:
        print "[%s] Making final file: %s.root" % (final,final)
        os.system("hadd -k %s.root %s >> haddlog.txt" % (final, " ".join(chunks[0])))

