# extinction-cube

Example scripts in both IDL and Python are provided below to obtain the mean E(B-V) for a specified sightline and distance. In order to run these scripts, you may need to install the HEALPix subroutines from the following webpages:

IDL: see https://healpix.sourceforge.io/doc/html/install.htm
Python: see https://healpy.readthedocs.io/en/latest/install.html



1) Example script in IDL

(1) Compute the E(B-V) for the Pleiades located at Galactic coordinates of (l, b) = (120, 10) degrees and a distance of 135.8 pc, utilizing the default extinction map with R(V)=3.1:

     IDL> get_extinction, 166.4628, -23.6146, 135.8

     E(B-V) = 0.030 +/- 0.010
     Note that useful E(B-V) are found within  110 -  2008 pc.

(2) Repeat the computation outlined above, this time utilizing an alternative extinction map that incorporates a variation in R(V):

     IDL> get_extinction, 166.4628, -23.6146, 135.8, /get_rv

     E(B-V) = 0.026 +/- 0.007
     R(V) = 3.815
     Note that useful E(B-V) are found within  110 -  1956 pc.

2) Example script in Python
