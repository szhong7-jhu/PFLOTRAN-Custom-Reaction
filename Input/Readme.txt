Input file for baseline simulation.
For long-term spin-up, change line 449 Pyrite_zhong 0.002 to Pyrite_zhong 0.06 as unoxidized zone.
For different permeability cases, change the permeability values in material properties.
2020x1x1000x22.h5 is the domain file for baseline simulation. For other permeability cases, use long-term spin-up and matlab code (VF.m) to generate similar hdf5 files.