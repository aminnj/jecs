from WMCore.Configuration import Configuration
config = Configuration()

config.section_("General")
config.General.requestName = 'forJECs-Autumn18-NoPU-v1'
config.General.transferOutputs = True
config.General.transferLogs = True

config.section_("JobType")
config.JobType.pluginName = 'Analysis'
config.JobType.psetName = '../run_JRA_cfg.py'

config.section_("Data")
config.Data.inputDataset = '/QCD_Pt-15to7000_TuneCP5_Flat2018_13TeV_pythia8/RunIIAutumn18DR-NoPU_102X_upgrade2018_realistic_v15-v1/AODSIM'
config.Data.inputDBS = 'global'
config.Data.splitting = 'FileBased'
config.Data.unitsPerJob = 2

config.section_("Site")
config.Site.storageSite = 'T2_US_UCSD'
