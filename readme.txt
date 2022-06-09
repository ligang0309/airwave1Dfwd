AIRWAVE1DFWD: Program for computing the radial electric component of the airwave for three-layer model with the air half-space, seawater and seafloor half-space for a horizontal electric dipole (HED) source.

This code follows the theory given by:
Nordskag, J.I., Amundsen, L., 2007. Asymptotic airwave modeling for marine controlled-source electromagnetic surveying. Geophysics 72, F249–F255.  doi:10.1190/1.2786025. 

----------------------------------CODE STRUCTURE----------------------------------
Source file:
          --airwave1Dfwd.m: the main MATLAB file for computing the airwave fields.
Input files:
          --input_model.txt: the three-layered model. For example,
                3                   ! Number of layers in this model. Currently fixed as 3.
              -100000  1e8   ! The top depths (m) and resistivities (ohm-m).                   
                0           0.3             
                50         1 
          --input_sources.txt: the file for the transmitters. For example,
               1                    ! Number of transmitters.  
               1 0 0 0 30       ! The dipole moment (fixed as unit), and the x,y,z depths (in m) and the azimuth (in degree) of the transmitters.
          --input_frequencies.txt: the file for the transmitting frequencies. For example,
               1                    ! Number of frequencies. 
               0.25                ! The frequency values.  
          --input_receivers.txt: the file for the receivers. For example,
               91                   ! Number of receivers.
               0	1000	50	0	0	0  
               0	1100	50	0	0	0
               0	1200	50	0	0	0
                ... ...
! The x,y,z depths (in m) and orientations. The orientation parameters Alpha, Beta and Gamma of sites described as follows. The receiver is horizontally rotated by an azimuth α around z-axis. It is further tilted by a dip β around x′-axis. Finally, it is rolled by γ around y′′-axis into the rotated receiver coordinates (x′′,y′′, z′′). See Li (2020) for details. Reference used: Y. Li. Finite element modeling of electromagnetic fields in two- and three-dimensional anisotropic conductivity structures (in German). PhD thesis, University of G\¨ottingen, 2000.

Output files:
          --results.txt: the results for the real and imaginary parts of the airwave E-field.

----------------------------------COPYRIGHTS----------------------------------
These programs may be freely redistributed under the condition that the copyright notices are not removed, and no compensation is received.  Private, research, and institutional use is free. You may distribute modified versions of this code UNDER THE CONDITION THAT THIS CODE AND ANY MODIFICATIONS MADE TO IT IN THE SAME FILE REMAIN UNDER COPYRIGHT OF THE ORIGINAL AUTHOR, BOTH SOURCE AND OBJECT CODE ARE MADE FREELY AVAILABLE WITHOUT CHARGE, AND CLEAR NOTICE IS GIVEN OF THE MODIFICATIONS. Distribution of this code as part of a commercial system is permissible ONLY BY DIRECT ARRANGEMENT WITH THE AUTHOR. 
If you use the code, PLEASE cite:

Gang Li. Enhanced detectability using difference fields for marine controlled-source EM data in shallow waters. Exploration geophysics, under review, 2022.
----------------------------------CONTACT INFORMATION----------------------------------
For possible questions, please contact:
 
  Gang Li
   Zhejiang University
   ligang0309@gmail.com
   Original code written in 9 Jul.,2021 
