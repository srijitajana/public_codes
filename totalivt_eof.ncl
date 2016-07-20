load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin
begTime = get_cpu_time()

  latS   =  25.
  latN   =  50. 
  lonL   = 230.
  lonR   =  270.

  yrStrt = 1979
  yrLast = 2010
  nyrs = 32
  season = "JJAS"    ; choose Jun-Jul-Aug-Sep seasonal mean

  neof   = 3        ; number of EOFs
  optEOF = True       
  optEOF@jopt = 0   ; This is the default; most commonly used; no need to specify.
;;optEOF@jopt = 1   ; **only** if the correlation EOF is desired

  optETS = False


diri = "/Projects/Air_Sea/jscott/CFSR/4xDY/SFC/"
fili    = systemfunc("ls -x1 "+diri+"IVT.CFSR.anl.????.4xdy.psfcadj.nc")  ; all files beginning with 'ACCESS_SRF'
   nfili   = dimsizes(fili)
   print(fili)

   varName = (/"totIVT"/)
   nName   = dimsizes(varName)

   opt     = True
   opt@nval_crit = 10              ; require at least 10 values

   ndim    = 0

f = addfiles(fili, "r")   ; read variables from all files

do nv=0,nName-1
      print("")
      print("-----------------------------------------------")
      print("-----------  "+varName(nv)+"  -----------------")
      print("-----------------------------------------------")
      print("")

      xhr := f[:]->$varName(nv)$           ; (time,lat,lon) 
      printVarSummary(xhr)

      ;xdd := calculate_daily_values (xhr, "avg", ndim, opt)
      ;printVarSummary(xdd)

      xmm := calculate_monthly_values (xhr, "avg", ndim, opt)
      printVarSummary(xmm)
   end do

;;; subset summer months
xmm_jjas = xmm(6::12,:,:) 
temp = runave_Wrap(xmm(lat|:,lon|:,time|:),4,0) 

xmm_jjas = (/ temp(time|6::12,lat|:,lon|:) /) 
delete(temp) 
printVarSummary(xmm_jjas)

xw     = xmm_jjas({lat|latS:latN},{lon|lonL:lonR},time|:)
x      = xmm_jjas(time|:,{lat|latS:latN},{lon|lonL:lonR})

eof      = eofunc_Wrap(xw, neof, optEOF)      
eof_ts   = eofunc_ts_Wrap (xw, eof, optETS)

printVarSummary( eof )                         ; examine EOF variables
printVarSummary( eof_ts )

; =================================================================
; Extract the YYYYMM from the time coordinate 
; associated with eof_ts [same as SLP&time] 
; =================================================================

  yyyymm = cd_calendar(eof_ts&time,-2)/100  
;;yrfrac = yyyymm_to_yyyyfrac(yyyymm, 0.0); not used here

;============================================================
; PLOTS
;============================================================
  wks = gsn_open_wks("pdf","eof_region5")
  plot = new(neof,graphic)                ; create graphic array
                                          ; only needed if paneling
; EOF patterns

  res                      = True         
  res@gsnDraw              = False        ; don't draw yet
  res@gsnFrame             = False        ; don't advance frame yet

  res@gsnAddCyclic         = False        ; plotted dataa are not cyclic
 
  res@mpFillOn             = False        ; turn off map fill
  res@mpMinLatF            = latS         ; zoom in on map
  res@mpMaxLatF            = latN
  res@mpMinLonF            = lonL
  res@mpMaxLonF            = lonR
  res@mpCenterLonF         = (lonL + lonR)/2

  res@mpOutlineBoundarySets             = "GeophysicalAndUSStates"
  res@gsnContourNegLineDashPattern = 2
  res@gsnContourZeroLineThicknessF= 2.

  res@cnFillOn             = True         ; turn on color fill
  res@cnLinesOn            = True        ; True is default
 ;res@cnLineLabelsOn       = False        ; True is default
  res@cnFillPalette        = "posneg_1"   ; choose colormap
  res@lbLabelBarOn         = False        ; turn off individual lb's

                                          ; set symmetric plot min/max
  symMinMaxPlt(eof, 16, False, res)       ; contributed.ncl

 ; panel plot only resources
  resP                     = True         ; modify the panel plot
  resP@gsnMaximize         = True         ; large format
  resP@gsnPanelLabelBar    = True         ; add common colorbar
  resP@lbLabelAutoStride   = True         ; auto stride on labels

  yStrt                    = yyyymm(0)/100
  yLast                    = yyyymm(nyrs-1)/100
  resP@txString            = "IVT: "+season+": "+yStrt+"-"+yLast 

;*******************************************
; first plot
;*******************************************
  do n=0,neof-1
     res@gsnLeftString  = "EOF "+(n+1)
     res@gsnRightString = sprintf("%5.1f", eof@pcvar(n)) +"%"
     plot(n)=gsn_csm_contour_map_ce(wks,eof(n,:,:),res)
  end do
  gsn_panel(wks,plot,(/neof,1/),resP)     ; now draw as one plot 

;*******************************************
; second plot
;*******************************************
; EOF time series  [bar form]

  rts           = True
  rts@gsnDraw   = False       ; don't draw yet
  rts@gsnFrame  = False       ; don't advance frame yet
  rts@gsnScale  = True        ; force text scaling               

; these four rtsources allow the user to stretch the plot size, and
; decide exactly where on the page to draw it.

  rts@vpHeightF = 0.40        ; Changes the aspect ratio
  rts@vpWidthF  = 0.85
  rts@vpXF      = 0.10        ; change start locations
  rts@vpYF      = 0.75        ; the plot


  rts@tiYAxisString = " "                    ; y-axis label    

  rts@gsnYRefLine           = 0.              ; reference line   
  rts@gsnXYBarChart         = True            ; create bar chart 
  rts@gsnAboveYRefLineColor = "red"           ; above ref line fill red
  rts@gsnBelowYRefLineColor = "blue"          ; below ref line fill blue

; panel plot only resources
  rtsP                      = True            ; modify the panel plot
  rtsP@gsnMaximize          = True            ; large format
  rtsP@txString             = "IVT: "+season+": "+yStrt+"-"+yLast

  year = yyyymm/100

; create individual plots
  do n=0,neof-1
     rts@gsnLeftString  = "EOF "+(n+1)
     rts@gsnRightString = sprintf("%5.1f", eof@pcvar(n)) +"%"
     plot(n) = gsn_csm_xy (wks,year,eof_ts(n,:),rts)
  end do
  gsn_panel(wks,plot,(/neof,1/),rtsP)     ; now draw as one plot


print("Total CPU time: " + (get_cpu_time() - begTime))
end
