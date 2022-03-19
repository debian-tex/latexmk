Rem This batch file is only of interest to a small subset of **Windows** users.

Rem Under modern TeX distributions, MiKTeX and TeXLive, you do **NOT**
Rem need this batch file.  Both distributions have a latexmk executable
Rem that correctly runs the latexmk Perl script itself.  This file
Rem is only useful if you need to bypass that for some reason, e.g.,
Rem if you have not upgraded to a current year's TeXLive, but want to
Rem run the latest version of latexmk.
Rem You may have to modify you copy of this file for your needs.

Rem ==============================

Rem This batch file executes perl so as to run latexmk.pl.  As written it
Rem assumes that latexmk.pl is in a directory in the
Rem environment variable PATH.  Of course this file latexmk.cmd should
Rem itself also have been copied to a directory in PATH.
Rem
Rem In addition, this file assumes that perl.exe is in a directory in PATH.
Rem If not, you should replace 'perl' by the full pathname of the perl
Rem executable, e.g., 'C:\perl\bin\perl.exe' or
Rem 'C:\Strawberry\perl\bin\perl.exe.  (Current distributions of Perl
Rem for Windows do set PATH appropriately when installed in the default way.

perl -S latexmk.pl %*
