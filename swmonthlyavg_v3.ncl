load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

;--------- range of lat,long for southwest US
begTime = get_cpu_time()
minlat = 20
maxlat = 45
minlong = 230
maxlong = 260

datadir = "/data/sjana/ldeo_amip_data/amip_monthly/"
imgdir = "/home/sjana/amip_images/"
homedir = "/home/sjana/"

;---------------------------------------- Read in observed data from CMAP
print("reading observed precipitation")
climfile = addfile(homedir + "precip.mon.mean.nc", "r")

time = climfile->time
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer = climfile->precip(imm,{minlat:maxlat},{minlong:maxlong})

    swmonthlyavg = dim_avg_n_Wrap(swsummer,0)

    ;printVarSummary(swmonthlyavg1)
    printMinMax(swmonthlyavg,True)

    delete([/swsummer,climfile,time,yyyymm,yyyy,mm,imm/])

;---------------------------------------- Beijing Climate Center
print("reading bcc-csm1-1")
climfile1 = addfile(datadir + "bcc-csm1-1.cdf","r")

;-- finding index of all summer months
    time = climfile1->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer1 = climfile1->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer1 = swsummer1*86400.
    swmonthlyavg1 = dim_avg_n_Wrap(swsummer1,0)

    ;printVarSummary(swmonthlyavg1)
    ;printMinMax(swmonthlyavg1,True)
    ;;coeff1 = pattern_cor(swmonthlyavg, swmonthlyavg1, 1, 0)
    ;print(;coeff1)

    delete([/swsummer1,climfile1,time,yyyymm,yyyy,mm,imm/])

;---------------------------------------- Beijing Climate Center medium resolution
print("reading bcc-csm1-1-m")
climfile2 = addfile(datadir + "bcc-csm1-1-m.cdf","r")

;-- finding index of all summer months
    time = climfile2->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer2 = climfile2->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer2 = swsummer2*86400.
    swmonthlyavg2 = dim_avg_n_Wrap(swsummer2,0)

    ;printVarSummary(swmonthlyavg2)
    ;printMinMax(swmonthlyavg2,True)
    ;;coeff2 = pattern_cor(swmonthlyavg, swmonthlyavg2, 1, 0)

    delete([/swsummer2,climfile2,time,yyyymm,yyyy,mm,imm/])

;---------------------------------------- Beijing Normal University
print("reading BNU-ESM")
climfile3 = addfile(datadir + "BNU-ESM.cdf","r")

;-- finding index of all summer months
    time = climfile3->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer3 = climfile3->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer3 = swsummer3*86400
    swmonthlyavg3 = dim_avg_n_Wrap(swsummer3,0)

    ;printVarSummary(swmonthlyavg3)
    ;printMinMax(swmonthlyavg3,True)
    ;coeff3 = pattern_cor(swmonthlyavg, swmonthlyavg3, 1, 0)

    delete([/swsummer3,climfile3,time,yyyymm,yyyy,mm,imm/])

;---------------------------------------- Canadian Atmospheric Model
print("reading CanAM4")
climfile4 = addfile(datadir + "CanAM4.cdf","r")

;-- finding index of all summer months
    time = climfile4->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer4 = climfile4->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer4 = swsummer4*86400.
    swmonthlyavg4 = dim_avg_n_Wrap(swsummer4,0)

    ;printVarSummary(swmonthlyavg4)
    ;printMinMax(swmonthlyavg4,True)
    ;coeff4 = pattern_cor(swmonthlyavg, swmonthlyavg4, 1, 0)

    delete([/swsummer4,climfile4,time,yyyymm,yyyy,mm,imm/])


;---------------------------------------- NCAR Model
print("reading CCSM4")
climfile5 = addfile(datadir + "CCSM4.cdf","r")

;-- finding index of all summer months
    time = climfile5->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer5 = climfile5->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer5 = swsummer5*86400
    swmonthlyavg5 = dim_avg_n_Wrap(swsummer5,0)

    ;printVarSummary(swmonthlyavg5)
    ;printMinMax(swmonthlyavg5,True)
    ;coeff5 = pattern_cor(swmonthlyavg, swmonthlyavg5, 1, 0)

    delete([/swsummer5,climfile5,time,yyyymm,yyyy,mm,imm/])    


;---------------------------------------- Community Earth System Model
print("reading CESM1-CAM5")
climfile6 = addfile(datadir + "CESM1-CAM5.cdf","r")

;-- finding index of all summer months
    time = climfile6->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer6 = climfile6->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer6 = swsummer6*86400

    swmonthlyavg6 = dim_avg_n_Wrap(swsummer6,0)

    ;printVarSummary(swmonthlyavg6)
    ;printMinMax(swmonthlyavg6,True)
    ;coeff6 = pattern_cor(swmonthlyavg, swmonthlyavg6, 1, 0)

    delete([/swsummer6,climfile6,time,yyyymm,yyyy,mm,imm/]) 


;---------------------------------------- Centro Euro-Mediterraneo per I Cambiamenti Climatici
print("reading CMCC-CM")
climfile7 = addfile(datadir + "CMCC-CM.cdf","r")

;-- finding index of all summer months
    time = climfile7->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer7 = climfile7->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer7 = swsummer7*86400
    swmonthlyavg7 = dim_avg_n_Wrap(swsummer7,0)

    ;printVarSummary(swmonthlyavg7)
    ;printMinMax(swmonthlyavg7,True)
    ;coeff7 = pattern_cor(swmonthlyavg, swmonthlyavg7, 1, 0)

    delete([/swsummer7,climfile7,time,yyyymm,yyyy,mm,imm/]) 


;---------------------------------------- Centre National de Recherches Meteorologiques
print("reading CNRM-CM5")
climfile8 = addfile(datadir + "CNRM-CM5.cdf","r")

;-- finding index of all summer months
    time = climfile8->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer8 = climfile8->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer8 = swsummer8*86400
    swmonthlyavg8 = dim_avg_n_Wrap(swsummer8,0)

    ;printVarSummary(swmonthlyavg8)
    ;printMinMax(swmonthlyavg8,True)
    ;coeff8 = pattern_cor(swmonthlyavg, swmonthlyavg8, 1, 0)

    delete([/swsummer8,climfile8,time,yyyymm,yyyy,mm,imm/]) 


;---------------------------------------- Commonwealth Scientific and Industrial Research Organisation in collaboration with the Queensland Climate Change Centre of Excellence

print("reading CSIRO-Mk3-6-0")
climfile9 = addfile(datadir + "CSIRO-Mk3-6-0.cdf","r")

;-- finding index of all summer months
    time = climfile9->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer9 = climfile9->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer9 = swsummer9*86400
    swmonthlyavg9 = dim_avg_n_Wrap(swsummer9,0)

    ;printVarSummary(swmonthlyavg9)
    ;printMinMax(swmonthlyavg9,True)
    ;coeff9 = pattern_cor(swmonthlyavg, swmonthlyavg9, 1, 0)

    delete([/swsummer9,climfile9,time,yyyymm,yyyy,mm,imm/]) 


;---------------------------------------- LASG
print("reading FGOALS-g2")
climfile10 = addfile(datadir + "FGOALS-g2.cdf","r")

;-- finding index of all summer months
    time = climfile10->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer10 = climfile10->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer10 = swsummer10*86400
    swmonthlyavg10 = dim_avg_n_Wrap(swsummer10,0)

    ;printVarSummary(swmonthlyavg10)
    ;printMinMax(swmonthlyavg10,True)
    ;coeff10 = pattern_cor(swmonthlyavg, swmonthlyavg10, 1, 0)

    delete([/swsummer10,climfile10,time,yyyymm,yyyy,mm,imm/]) 

;---------------------------------------- LASG
print("reading FGOALS-s2")
climfile11 = addfile(datadir + "FGOALS-s2.cdf","r")

;-- finding index of all summer months
    time = climfile11->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer11 = climfile11->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer11 = swsummer11*86400
    swmonthlyavg11 = dim_avg_n_Wrap(swsummer11,0)

    ;printVarSummary(swmonthlyavg11)
    ;printMinMax(swmonthlyavg11,True)
    ;coeff11 = pattern_cor(swmonthlyavg, swmonthlyavg11, 1, 0)

    delete([/swsummer11,climfile11,time,yyyymm,yyyy,mm,imm/]) 


;---------------------------------------- GFDL resolution 1
print("reading GFDL-CM3")
climfile12 = addfile(datadir + "GFDL-CM3.cdf","r")

;-- finding index of all summer months
    time = climfile12->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer12 = climfile12->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer12 = swsummer12*86400
    swmonthlyavg12 = dim_avg_n_Wrap(swsummer12,0)

    ;printVarSummary(swmonthlyavg12)
    printMinMax(swmonthlyavg12,True)

    delete([/swsummer12,climfile12,time,yyyymm,yyyy,mm,imm/])     


;---------------------------------------- GFDL resolution 2
print("reading GFDL-HIRAM-C180")
climfile13 = addfile(datadir + "GFDL-HIRAM-C180.cdf","r")

;-- finding index of all summer months
    time = climfile13->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer13 = climfile13->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer13 = swsummer13*86400
    swmonthlyavg13 = dim_avg_n_Wrap(swsummer13,0)

    ;printVarSummary(swmonthlyavg13)
    ;printMinMax(swmonthlyavg13,True)
    ;coeff13 = pattern_cor(swmonthlyavg, swmonthlyavg13, 1, 0)

    delete([/swsummer13,climfile13,time,yyyymm,yyyy,mm,imm/]) 

 
;---------------------------------------- GFDL resolution 3
print("reading GFDL-HIRAM-C360")
climfile14 = addfile(datadir + "GFDL-HIRAM-C360.cdf","r")

;-- finding index of all summer months
    time = climfile14->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer14 = climfile14->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer14 = swsummer14*86400
    swmonthlyavg14 = dim_avg_n_Wrap(swsummer14,0)

    ;printVarSummary(swmonthlyavg14)
    ;printMinMax(swmonthlyavg14,True)
    ;coeff14 = pattern_cor(swmonthlyavg, swmonthlyavg14, 1, 0)

    delete([/swsummer14,climfile14,time,yyyymm,yyyy,mm,imm/])        

 
;---------------------------------------- GISS Earth Model
print("reading GISS-E2-R")
climfile15 = addfile(datadir + "GISS-E2-R.cdf","r")

;-- finding index of all summer months
    time = climfile15->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer15 = climfile15->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer15 = swsummer15*86400
    swmonthlyavg15 = dim_avg_n_Wrap(swsummer15,0)

    ;printVarSummary(swmonthlyavg15)
    ;printMinMax(swmonthlyavg15,True)
    ;coeff15 = pattern_cor(swmonthlyavg, swmonthlyavg15, 1, 0)

    delete([/swsummer15,climfile15,time,yyyymm,yyyy,mm,imm/])        

;---------------------------------------- Hadley Model
print("reading HadGEM2-A")
climfile16 = addfile(datadir + "HadGEM2-A.cdf","r")

;-- finding index of all summer months
    time = climfile16->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer16 = climfile16->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer16 = swsummer16*86400
    swmonthlyavg16 = dim_avg_n_Wrap(swsummer16,0)

    ;printVarSummary(swmonthlyavg16)
    ;printMinMax(swmonthlyavg16,True)
    ;coeff16 = pattern_cor(swmonthlyavg, swmonthlyavg16, 1, 0)

    delete([/swsummer16,climfile16,time,yyyymm,yyyy,mm,imm/])      

;---------------------------------------- Institute for Numerical Mathematics

print("reading inmcm4")
climfile17 = addfile(datadir + "inmcm4.cdf","r")

;-- finding index of all summer months
    time = climfile17->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer17 = climfile17->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer17 = swsummer17*86400
    swmonthlyavg17 = dim_avg_n_Wrap(swsummer17,0)

    ;printVarSummary(swmonthlyavg17)
    ;(swmonthlyavg17,True)
    ;coeff17 = pattern_cor(swmonthlyavg, swmonthlyavg17, 1, 0)

    delete([/swsummer17,climfile17,time,yyyymm,yyyy,mm,imm/])        

;----------------------------------------  Institut Pierre-Simon Laplace model 1

print("reading IPSL-CM5A-LR")
climfile18 = addfile(datadir + "IPSL-CM5A-LR.cdf","r")

;-- finding index of all summer months
    time = climfile18->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer18 = climfile18->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer18 = swsummer18*86400
    swmonthlyavg18 = dim_avg_n_Wrap(swsummer18,0)

    ;printVarSummary(swmonthlyavg18)
    ;printMinMax(swmonthlyavg18,True)
    ;coeff18 = pattern_cor(swmonthlyavg, swmonthlyavg18, 1, 0)

    delete([/swsummer18,climfile18,time,yyyymm,yyyy,mm,imm/])     

;----------------------------------------  Institut Pierre-Simon Laplace model 2

print("reading IPSL-CM5A-MR")
climfile19 = addfile(datadir + "IPSL-CM5A-MR.cdf","r")

;-- finding index of all summer months
    time = climfile19->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer19 = climfile19->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer19 = swsummer19*86400
    swmonthlyavg19 = dim_avg_n_Wrap(swsummer19,0)

    ;printVarSummary(swmonthlyavg19)
    ;printMinMax(swmonthlyavg19,True)
    ;coeff19 = pattern_cor(swmonthlyavg, swmonthlyavg19, 1, 0)

    delete([/swsummer19,climfile19,time,yyyymm,yyyy,mm,imm/])     

;----------------------------------------  Institut Pierre-Simon Laplace model 3

print("reading IPSL-CM5B-LR")
climfile20 = addfile(datadir + "IPSL-CM5B-LR.cdf","r")

;-- finding index of all summer months
    time = climfile20->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer20 = climfile20->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer20 = swsummer20*86400
    swmonthlyavg20 = dim_avg_n_Wrap(swsummer20,0)

    ;printVarSummary(swmonthlyavg20)
    ;printMinMax(swmonthlyavg20,True)
    ;coeff20 = pattern_cor(swmonthlyavg, swmonthlyavg20, 1, 0)

    delete([/swsummer20,climfile20,time,yyyymm,yyyy,mm,imm/])     


;----------------------------------------  Japanese Model 1

print("reading MIROC5")
climfile21 = addfile(datadir + "MIROC5.cdf","r")

;-- finding index of all summer months
    time = climfile21->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer21 = climfile21->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer21 = swsummer21*86400
    swmonthlyavg21 = dim_avg_n_Wrap(swsummer21,0)

    ;printVarSummary(swmonthlyavg21)
    ;printMinMax(swmonthlyavg21,True)
    ;coeff21 = pattern_cor(swmonthlyavg, swmonthlyavg21, 1, 0)

    delete([/swsummer21,climfile21,time,yyyymm,yyyy,mm,imm/])    


;----------------------------------------  Max Planck Institute for Meteorology Model 1

print("reading MPI-ESM-LR")
climfile22 = addfile(datadir + "MPI-ESM-LR.cdf","r")

;-- finding index of all summer months
    time = climfile22->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer22 = climfile22->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer22 = swsummer22*86400
    swmonthlyavg22 = dim_avg_n_Wrap(swsummer22,0)

    ;printVarSummary(swmonthlyavg22)
    ;printMinMax(swmonthlyavg22,True)
    ;coeff22 = pattern_cor(swmonthlyavg, swmonthlyavg22, 1, 0)

    delete([/swsummer22,climfile22,time,yyyymm,yyyy,mm,imm/])    


;----------------------------------------  Max Planck Institute for Meteorology Model 1

print("reading MPI-ESM-MR")
climfile23 = addfile(datadir + "MPI-ESM-MR.cdf","r")

;-- finding index of all summer months
    time = climfile23->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer23 = climfile23->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer23 = swsummer23*86400
    swmonthlyavg23 = dim_avg_n_Wrap(swsummer23,0)

    ;printVarSummary(swmonthlyavg23)
    ;printMinMax(swmonthlyavg23,True)
    ;coeff23 = pattern_cor(swmonthlyavg, swmonthlyavg23, 1, 0)

    delete([/swsummer23,climfile23,time,yyyymm,yyyy,mm,imm/])    

;----------------------------------------  Meteorological Research Institute Model 1

print("reading MRI-AGCM3-2H")
climfile24 = addfile(datadir + "MRI-AGCM3-2H.cdf","r")

;-- finding index of all summer months
    time = climfile24->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer24 = climfile24->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer24 = swsummer24*86400
    swmonthlyavg24 = dim_avg_n_Wrap(swsummer24,0)

    ;printVarSummary(swmonthlyavg24)
    ;printMinMax(swmonthlyavg24,True)
    ;coeff24 = pattern_cor(swmonthlyavg, swmonthlyavg24, 1, 0)

    delete([/swsummer24,climfile24,time,yyyymm,yyyy,mm,imm/])    

;----------------------------------------  Meteorological Research Institute Model 1

print("reading MRI-AGCM3-2S")
climfile25 = addfile(datadir + "MRI-AGCM3-2S.cdf","r")

;-- finding index of all summer months
    time = climfile25->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer25 = climfile25->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer25 = swsummer25*86400
    swmonthlyavg25 = dim_avg_n_Wrap(swsummer25,0)

    ;printVarSummary(swmonthlyavg25)
    ;printMinMax(swmonthlyavg25,True)
    ;coeff25 = pattern_cor(swmonthlyavg, swmonthlyavg25, 1, 0)

    delete([/swsummer25,climfile25,time,yyyymm,yyyy,mm,imm/])    

;----------------------------------------  Meteorological Research Institute Model 1

print("reading MRI-CGCM3")
climfile26 = addfile(datadir + "MRI-CGCM3.cdf","r")

;-- finding index of all summer months
    time = climfile26->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer26 = climfile26->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer26 = swsummer26*86400
    swmonthlyavg26 = dim_avg_n_Wrap(swsummer26,0)

    ;printVarSummary(swmonthlyavg26)
    ;printMinMax(swmonthlyavg26,True)
    ;coeff26 = pattern_cor(swmonthlyavg, swmonthlyavg26, 1, 0)

    delete([/swsummer26,climfile26,time,yyyymm,yyyy,mm,imm/])    

;----------------------------------------  Norwegian Earth System Model

print("reading NorESM1-M")
climfile27 = addfile(datadir + "NorESM1-M.cdf","r")

;-- finding index of all summer months
    time = climfile27->T
    yyyymm = cd_calendar(time,-1)
    yyyy = yyyymm/100
    mm = yyyymm - (yyyy*100)
    imm = ind(mm.ge.6 .and. mm.le.9 .and. yyyy.ge.1979 .and. yyyy.le.2008)

;-- subset only summer and southwest us
    swsummer27 = climfile27->pr(imm,{minlat:maxlat},{minlong:maxlong})
    swsummer27 = swsummer27*86400
    swmonthlyavg27 = dim_avg_n_Wrap(swsummer27,0)

    ;printVarSummary(swmonthlyavg27)
    ;printMinMax(swmonthlyavg27,True)
    ;coeff27 = pattern_cor(swmonthlyavg, swmonthlyavg27, 1, 0)

    delete([/swsummer27,climfile27,time,yyyymm,yyyy,mm,imm/])    

;------------------------------------ plotting routines
;---------------------------------------------- plotting Resources

wks_type = "pdf"        ; or "pdf"
wks_type@wkPaperWidthF  =  8  ; in inches
wks_type@wkPaperHeightF = 10 ; in inches
wks_type@wkOrientation = "landscape"
wks = gsn_open_wks(wks_type,imgdir + "sw_maverage_v1")

  res = True

  res@gsnDraw          = False                ; do not draw the plot
  res@gsnFrame         = False                ; do not advance the frame
 
  ;res@mpProjection      = "Robinson"       ; choose projection
  ;res@mpGridAndLimbOn   = True              ; turn on lat/lon lines
  res@mpPerimOn         = True             ; turn off box around plot
  ;res@mpGridLatSpacingF = 10.               ; spacing for lat lines
  ;res@mpGridLonSpacingF = 10.               ; spacing for lon lines

  res@mpMinLatF            = minlat      ; range to zoom in on
  res@mpMaxLatF            =  maxlat
  res@mpMinLonF            =  minlong
  res@mpMaxLonF            = maxlong
  res@mpCenterLonF =  (res@mpMaxLonF + res@mpMinLonF)/2.
  res@mpCenterLatF =  (res@mpMaxLatF + res@mpMinLatF)/2.
  
  res@cnFillOn = True
  res@cnLinesOn = True
  res@cnFillPalette = "precip_11lev"
  res@gsnAddCyclic = False
  res@lbLabelBarOn        = False           ; turn off individual cb's

  res@cnLevelSelectionMode =  "ManualLevels"   
  res@cnMinLevelValF       = 0.
  res@cnMaxLevelValF       =  5
  res@cnLevelSpacingF      =  0.5

  res@mpOutlineBoundarySets     = "geophysicalandusstates"; turn on states
  res@gsnLeftString    = ""
  res@gsnRightString    = ""

  plot = new(28,graphic)

res@gsnCenterString    = "Observed"
plot(0) = gsn_csm_contour_map(wks, swmonthlyavg, res)

res@gsnCenterString    = "bcc-csm1-1"
plot(1) = gsn_csm_contour_map(wks, swmonthlyavg1, res)

res@gsnCenterString    = "bcc-csm1-1-m"
plot(2) = gsn_csm_contour_map(wks, swmonthlyavg2, res)

res@gsnCenterString    = "BNU-ESM"
plot(3) = gsn_csm_contour_map(wks, swmonthlyavg3, res)

res@gsnCenterString    = "CanAM4"
plot(4) = gsn_csm_contour_map(wks, swmonthlyavg4, res)

res@gsnCenterString    = "CCSM4"
plot(5) = gsn_csm_contour_map(wks, swmonthlyavg5, res)

res@gsnCenterString    = "CESM1-CAM5"
plot(6) = gsn_csm_contour_map(wks, swmonthlyavg6, res)

res@gsnCenterString    = "CMCC-CM"
plot(7) = gsn_csm_contour_map(wks, swmonthlyavg7, res)

res@gsnCenterString    = "CNRM-CM5"
plot(8) = gsn_csm_contour_map(wks, swmonthlyavg8, res)

res@gsnCenterString    = "CSIRO-Mk3-6-0"
plot(9) = gsn_csm_contour_map(wks, swmonthlyavg9, res)

res@gsnCenterString    = "FGOALS-g2"
plot(10) = gsn_csm_contour_map(wks, swmonthlyavg10, res)

res@gsnCenterString    = "FGOALS-s2"
plot(11) = gsn_csm_contour_map(wks, swmonthlyavg11, res)

res@gsnCenterString    = "GFDL-CM3"
plot(12) = gsn_csm_contour_map(wks, swmonthlyavg12, res)

res@gsnCenterString    = "GFDL-HIRAM-C180"
plot(13) = gsn_csm_contour_map(wks, swmonthlyavg13, res)

res@gsnCenterString    = "GFDL-HIRAM-C360"
plot(14) = gsn_csm_contour_map(wks, swmonthlyavg14, res)

res@gsnCenterString    = "GISS-E2-R"
plot(15) = gsn_csm_contour_map(wks, swmonthlyavg15, res)

res@gsnCenterString    = "HadGEM2-A"
plot(16) = gsn_csm_contour_map(wks, swmonthlyavg16, res)

res@gsnCenterString    = "inmcm4"
plot(17) = gsn_csm_contour_map(wks, swmonthlyavg17, res)

res@gsnCenterString    = "IPSL-CM5A-LR"
plot(18) = gsn_csm_contour_map(wks, swmonthlyavg18, res)

res@gsnCenterString    = "IPSL-CM5A-MR"
plot(19) = gsn_csm_contour_map(wks, swmonthlyavg19, res)

res@gsnCenterString    = "IPSL-CM5B-LR"
plot(20) = gsn_csm_contour_map(wks, swmonthlyavg20, res)

res@gsnCenterString    = "MIROC5"
plot(21) = gsn_csm_contour_map(wks, swmonthlyavg21, res)

res@gsnCenterString    = "MPI-ESM-LR"
plot(22) = gsn_csm_contour_map(wks, swmonthlyavg22, res)

res@gsnCenterString    = "MPI-ESM-MR"
plot(23) = gsn_csm_contour_map(wks, swmonthlyavg23, res)

res@gsnCenterString    = "MRI-AGCM3-2H"
plot(24) = gsn_csm_contour_map(wks, swmonthlyavg24, res)

res@gsnCenterString    = "MRI-AGCM3-2S"
plot(25) = gsn_csm_contour_map(wks, swmonthlyavg25, res)

res@gsnCenterString    = "MRI-CGCM3"
plot(26) = gsn_csm_contour_map(wks, swmonthlyavg26, res)

res@gsnCenterString    = "NorESM1-M"
plot(27) = gsn_csm_contour_map(wks, swmonthlyavg27, res)

panres = True                                ; create a panel resource list
panres@gsnMaximize = True                    ; maximize the size of the paneled plots
panres@gsnPanelLabelBar    = True                ; add common colorbar
panres@gsnPanelYWhiteSpacePercent = 5.0      ; leave space between the 2 plots
panres@gsnPanelXWhiteSpacePercent = 5.0      ; leave space between the 2 plots

panres@gsnPanelBottom = 0.5

panres@lbLabelFontHeightF  = 0.007               ; make labels smaller

panres@gsnPaperOrientation="landscape"
panres@txFontHeightF=0.015

gsn_panel(wks,plot,(/4,7/),panres)


print("Total CPU time: " + (get_cpu_time() - begTime))

end