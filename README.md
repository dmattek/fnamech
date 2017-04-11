 Script  name      : fnamech.sh

 Author            : Maciej Dobrzynski

 Date created      : 20170411

 Purpose           : Process files recursively in the directory and change part of filename

 Example usage
  assume we have a directory ~/tmp with files: 
  ch1_t1.tif, 
  ch1_t2.tif, etc.
  and we want to rename extensions from "tif" to "TIFF"

  ./fnamech.sh -f .tif -t .TIFF ~/tmp
  
  Note, there's no trailing slash in directory name

 If the selected pattern appears more than once,
 the substitution will occur only for the last instance.
 
 WARNING: uses GNU getopt
 Standard OSX installation of getopt doesn't support long params
 Install through macports
 sudo port install getopt

 Tested on:
 OSX 10.11.6 (Darwin Kernel Version 15.6.0)
 Ubuntu 16.04.2 LTS
