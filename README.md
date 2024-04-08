# Galactic-extinction-map

Galactic extinction maps created by An, Beers, Chiti (2024, ApJS, in press):

Title: A Blueprint for the Milky Way’s Stellar Populations. V. Three-Dimensional Local Dust Extinction

Authors: Deokkeun An, Timothy C. Beers, and Anirudh Chiti

Abstract: Using a grid of empirically calibrated synthetic spectra developed in our previous study, we construct an all-sky three-dimensional extinction map from the large collection of low-resolution XP spectra in Gaia DR3. Along each line-of-sight, with an area ranging from 0.2 to 13.4 square degrees, we determine both the reddening and metallicity of main-sequence stars and model the foreground extinction up to approximately 3 kpc from the Sun. Furthermore, we explore variations in the total-to-selective extinction ratio in our parameter search, and identify its mean systematic change across diverse cloud environments in both hemispheres. In regions outside the densest parts of the clouds, our reddening estimates are validated through comparisons with previous reddening maps. However, a notable discrepancy arises in comparison to other independent work based on XP spectra, which can be attributed to systematic offsets in their metallicity estimates. On the other hand, our metallicity scale exhibits reasonable agreement with the high-resolution spectroscopic abundance scale. We also assess the accuracy of the XP spectra by applying our calibrated models, and confirm an increasing trend of flux over-estimation at shorter wavelengths below 400 nm.

Example scripts in both IDL and Python are provided below to obtain the mean E(B-V) for a specified sightline and distance.

There are two alternative extinction maps provided. The first ("extinction_map") is derived using a fixed value for the total-to-selective extinction ratio, R(V), set at the standard value (=3.1). The second map ("extinction_map2") is based on a scenario where R(V) varies during the parameter search. Refer to Sections 4 and 6 in ABC for detailed descriptions of each case.

In order to run these scripts, you may need to install the HEALPix subroutines from the following webpages:

IDL: see https://healpix.sourceforge.io/doc/html/install.htm

Python: see https://healpy.readthedocs.io/en/latest/install.html

1) Example script in IDL

(1) Compute the E(B-V) for the Pleiades located at Galactic coordinates of (l, b) = (120, 10) degrees and a distance of 135.8 pc, utilizing the default extinction map with a total-to-selective extinction ratio of R(V)=3.1:

     IDL> get_extinction, 166.4628, -23.6146, 135.8

     E(B-V) = 0.029 +/- 0.009
     Note that useful E(B-V) are found within   97 -  2483 pc.

(2) Repeat the computation outlined above, this time utilizing an alternative extinction map that incorporates a variation in R(V):

     IDL> get_extinction, 166.4628, -23.6146, 135.8, /get_rv

     E(B-V) = 0.031 +/- 0.008
     R(V) = 3.866
     Note that useful E(B-V) are found within   97 -  2403 pc.

2) Example script in Python

(1) Compute the E(B-V) for the Pleiades located at Galactic coordinates of (l, b) = (120, 10) degrees and a distance of 135.8 pc, utilizing the default extinction map with a total-to-selective extinction ratio of R(V)=3.1:

     >>> from get_extinction import get_extinction
     >>> get_extinction(glon=166.4628, glat=-23.6146, dpc=135.8)

     E(B-V) = 0.029 +/- 0.009
     Note that useful E(B-V) is found within 97 - 2483 pc.

(2) Repeat the computation outlined above, this time utilizing an alternative extinction map that incorporates a variation in R(V):

     >>> from get_extinction import get_extinction
     >>> get_extinction(glon=166.4628, glat=-23.6146, dpc=135.8, get_rv=True)
     
     E(B-V) = 0.031 +/- 0.008
     R(V) = 3.866
     Note that useful E(B-V) is found within 97 - 2403 pc.
