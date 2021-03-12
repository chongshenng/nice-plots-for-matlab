# Scripts for making nice plots in Matlab
This is a repository containing scripts for plotting nice MATLAB plots.

### Example 1: 2D plot
* This code plots the log-law using the Matlab script `plot2D.m`.
* There are two plotting options to create publication-quality figures:
  1. Option 1 renders the text in latex font and can be directly inserted into manuscripts. Quite good control.
  2. Option 2 renders placeholders for text and enables `psfrag`. Even more control, but very finicky.
* I will describe option 1 only, since I found this much more user-friendly. 
  1. Run the Matlab code and save the plots `uavg_raw_bg.png` and `uavg_raw.pdf` to figs.
  2. In the folder `/figs-publication`, compile `uavg.tex` using `pdflatex`.
  3. In the same folder, execute `pdfcrop uavg.pdf` in terminal to trim the bounding boxes.

### Tips for capstyles:
* By default, Matlab renders a square linecap style in the eps figure. You can change this to make it more appealing!
* Open the eps file _in a text editor_ (e.g. `vi`). Then, look for the line corresponding to the `setlinecap`, and change the value from 0 to 1.
* For example, in `figs/uavg_raw.eps`, the `setlinecap` is defined as `/J`. You can find this on line 435 as `0 J`. Changing it to `1 J` will produce a rounded linecap.

### Example 2: 3D plot

### Example 3: Generating sequence of images
