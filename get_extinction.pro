;+
; NAME:
;	GET_EXTINCTION
;
; AUTHOR:
;       Deokkeun An, Ewha Womans University, Seoul, Republic of Korea
;       deokkeun.an@gmail.com
;
; PURPOSE:
;	Get E(B-V)
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;	GET_EXTINCTION, glon, glat, dpc
;
; INPUT:
;	glon - Galactic longitude in degree
;	glat - Galactic latitude in degree
;       dpc - distance in parsec
;
; OPTIONAL INPUT KEYWORD:
;       get_rv - Use a mean extinction map 
;
; OUTPUT:
;
; EXAMPLE:
;
;       Compute E(B-V) towards the Pleiades at (l,b)=(120,10) deg and d=135.8 pc, based on the default
;       extinction map at R(V)=3.1:
;
;       get_extinction, 166.4628, -23.6146, 135.8
;
;       Repeat the above computation using the other extinction map that incorporates a variation in R(V):
;
;       get_extinction, 166.4628, -23.6146, 135.8, /get_rv
;
;       The above two maps are equally valid.
;
; HISTORY:
;       created on NOV 27, 2023
;-

pro get_extinction,glon,glat,dpc,GET_RV=GET_RV

   EXTINCTION_MAP='extinction_map'
   if keyword_set(GET_RV) then EXTINCTION_MAP='extinction_map2'

   ebv_avg=mrdfits(EXTINCTION_MAP+'_ebv.fits.gz',0,head0)          ;array of E(B-V)
   ebv_avg_err=mrdfits(EXTINCTION_MAP+'_ebverr.fits.gz',0,head1)   ;array of E(B-V) uncertainties
   dmn_min=mrdfits(EXTINCTION_MAP+'_mindmn.fits.gz',0,head2)       ;minimum valid distance modulus
   dmn_max=mrdfits(EXTINCTION_MAP+'_maxdmn.fits.gz',0,head3)       ;maximum valid distance modulus
   if keyword_set(GET_RV) then $
   rv_avg=mrdfits(EXTINCTION_MAP+'_rv.fits.gz',0,head5)            ;total-to-selective extinction

   ang2pix_nest,2^7,(90.0-glat)/!RADEG,glon/!RADEG,pix

   dmn=5.000*alog10(dpc)-5.000
   darr=findgen(371)*0.020+5.000

   linterp,darr,transpose(ebv_avg[pix,*]),dmn,ebv
   linterp,darr,transpose(ebv_avg_err[pix,*]),dmn,ebverr

   if keyword_set(GET_RV) then rv=rv_avg[pix]

   dpc_min=10^((dmn_min[pix]+5.0)/5.0)
   dpc_max=10^((dmn_max[pix]+5.0)/5.0)

   print,ebv,ebverr,format='("E(B-V) =",F6.3," +/- ",F5.3)'
   if keyword_set(GET_RV) then print,rv,format='("R(V) =",F6.3)'
   print,dpc_min,dpc_max,format='("Note that useful E(B-V) are found within",I5," - ",I5," pc.")'

end

