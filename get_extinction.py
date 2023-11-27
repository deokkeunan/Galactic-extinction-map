#   >>> from get_extinction import get_extinction
#   >>> get_extinction(glon=166.4628, glat=-23.6146, dpc=135.8, get_rv=False)

import healpy as hp
import numpy as np
from astropy.io import fits
from astropy.coordinates import SkyCoord
import astropy.units as u
from scipy.interpolate import interp1d

def get_extinction(glon, glat, dpc, get_rv=False):
    extinction_map = 'extinction_map.fits'
    if get_rv:
        extinction_map = 'extinction_map_rv.fits'

    hdulist = fits.open(extinction_map)
    ebv_avg = hdulist[0].data
    ebv_avg_err = hdulist[1].data
    dmn_min = hdulist[2].data
    dmn_max = hdulist[3].data

    if get_rv:
        rv_avg = hdulist[5].data

    coords = SkyCoord(l=glon, b=glat, frame='galactic', unit=(u.deg, u.deg))

    pix = hp.ang2pix(2**7, coords.l.deg, coords.b.deg, nest=True, lonlat=True)

    dmn = 5.0 * np.log10(dpc) - 5.0
    darr = np.arange(5.0, 12.42, 0.02)

    ebv = interp1d(darr, ebv_avg[:, pix], kind='linear')(dmn)
    ebverr = interp1d(darr, ebv_avg_err[:, pix], kind='linear')(dmn)

    if get_rv:
        rv = rv_avg[pix]

    dpc_min = 10**((dmn_min[pix] + 5.0) / 5.0)
    dpc_max = 10**((dmn_max[pix] + 5.0) / 5.0)

    print(f'E(B-V) = {ebv:.3f} +/- {ebverr:.3f}')
    if get_rv:
        print(f'R(V) = {rv:.3f}')
    print(f'Note that useful E(B-V) is found within {int(dpc_min)} - {int(dpc_max)} pc.')


