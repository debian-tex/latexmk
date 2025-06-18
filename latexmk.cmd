@echo off
perl "%~dp0\latexmk.pl" %*

Rem The above line runs perl on the script latexmk.pl that is in the same
Rem directory as this .cmd file, with the arguments give to this script.
Rem (%~dp0 means the full name of the directory containing this .cmd file,
Rem and %* means the collection of all command line arguments.)

Rem General notes:
Rem This batch file is only of interest to a small subset of **Windows** users.
Rem 
Rem With modern TeX distributions, MiKTeX and TeXLive, you do **not**
Rem need this batch file.  Both distributions have a latexmk executable
Rem that correctly runs the latexmk perl script itself.  This file
Rem is only useful if you need to bypass that for some reason, e.g.,
Rem if you have not upgraded to a current year's TeXLive, but want to
Rem run the latest version of latexmk.

Rem !!!You are quite likely to need modify your copy of this file for your needs.
Rem !!!Some ideas are suggested below.

Rem The simplest situation is to put latexmk.pl and this file latexmk.cmd
Rem in some directory that is in the environment variable PATH. Then, on
Rem the assumption that the perl executable is found in PATH, running
Rem latexmk runs this .cmd file, with the intended results.  Thus you can
Rem do
Rem
Rem   latexmk -pdf document.tex
Rem
Rem It is often true that a Windows installation of perl will make .pl an
Rem executable extension, in which case you can also use latexmk.pl as the
Rem command name:
Rem
Rem   latexmk.pl -pdf document.tex
Rem 
Rem **HOWEVER**
Rem
Rem Given that TeX distributions have already implemented a latexmk
Rem command as a latexmk.exe that invokes perl on whatever latexmk.pl is in
Rem the distribution, this .cmd file is mostly useful when you want to
Rem give behavior different from the one in the distribution.
Rem
Rem Here are some examples, which can act as templates for your special
Rem needs, e.g. with different names and paths perl and latexmk.pl.
Rem
Rem 1. Use the default Perl, but give the path to latexmk.pl, e.g.,
Rem
Rem     perl C:\texlive\2025\texmf-dist\scripts\latexmk\latexmk.pl
Rem
Rem 2. Give the path both to perl and latexmk.pl.
Rem    E.g., you can use Cygwin's Perl rather than the one in TeX Live, but
Rem    with latexmk.pl from the standard Windows implementation of TeX Live:
Rem
Rem    c:\cygwin64\bin\perl C:\texlive\2025\texmf-dist\scripts\latexmk\latexmk.pl %*
Rem
Rem    This is a very useful when you have filenames with non-ASCII
Rem    characters, such that a native Windows Perl cannot handle them.
Rem
Rem 3. Use a default Perl, with the latexmk.pl that is in the same
Rem    directory as this script: 
Rem
Rem      perl "%~dp0\latexmk.pl" %*
Rem
Rem    This was done at the top of this file.
Rem
Rem 4. An older version was to tell perl to look for latexmk.pl in PATH by
Rem
Rem       perl -S latexmk.pl %*
Rem
Rem    But item 3 is normally better. 
Rem
Rem 4. Suppose you have a modified or test version of latexmk.  (To avoid
Rem    confusion with the version in a distribution, it is often useful to
Rem    give the .pl file a modified name from latexmk.pl.)  distribution. I
Rem    use this method and variations to test my development version of
Rem    latexmk. 
