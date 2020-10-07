Rem This batch file is only of interest to a small subset of Windows users.

Rem Under modern TeX distributions, MiKTeX and TeXLive, you do **NOT**
Rem need this batch file.  Both distributions have a latexmk executable
Rem that correctly run the latexmk Perl script itself.  This file
Rem is only useful if you need to bypass that for some reason, and you
Rem will probably have to modify it for your needs.

Rem Moreover if your system is suitably configured, the file latexmk.pl
Rem is itself executable, without the need for going through this batch file.

Rem ==============================

Rem This batch file executes perl so as to run latexmk.pl.  As written it
Rem assumes that both latexmk.pl and perlexe are in the environment variable
Rem PATH.
Rem If perl.exe is not in PATH, you should replace 'perl' by 
Rem the full pathname of the perl executable, e.g., 'C:\perl\bin\perl.exe'
Rem or 'C:\Strawberry\perl\bin\perl.exe.
Rem Similarly for latexmk.pl.

perl -S latexmk.pl %1 %2 %3 %4 %5 %6 %7 %8 %9
