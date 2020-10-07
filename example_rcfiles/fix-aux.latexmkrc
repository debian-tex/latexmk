# This shows how to implement the use of different values for $aux_dir and
# $out_dir when the latex (etc) engines don't support the -aux-directory
# option.  (Of the standard distributions, MiKTeX supports -aux-directory,
# but TeXLive does not.)


foreach my $cmd ('latex', 'lualatex', 'pdflatex', 'xelatex' ) {
    ${$cmd} = "internal latex_fix_aux $cmd %O %S";
}
$xelatex  =~ s/%O/-no-pdf %O/;


#---------------------------

sub latex_fix_aux {
  # Fudge to allow use of -aux_directory option with non-MiKTeX system.
  # This subroutine is called to do a compilation by one of latex, pdflatex,
  # etc.  It's arguments are the command name, and the command-line arguments,
  # including possible uses of the options -aux-directory, -output-directory.
  # Functioning:
  # 1. Obtain the values of the aux and output directories from the options
  #    on the command line, with appropriate defaults if one or both options
  #    is not used.
  # 2. Change the command line (a) to avoid the use of the -aux-directory
  #    option, and (b) to use the -output-directory to get all output
  #    sent to the intended aux-directory.  If neither an  -aux-directory
  #    nor an -output-directory option is used, no change is made to the
  #    command line.
  # 3. Run the command.
  # 4. If the aux and output directories are different, move any of the dvi,
  #    fls, pdf, ps and synctex.gz files that are present in the intended aux
  #    directory to the intended output directory.
  # N.B. It might seem more appropriate to keep the fls file in the aux
  #    directory.  But MiKTeX puts it in the output directory, so we must do
  #    the same to copy its behavior.
  #    It might also seem appropriate for an xdv file to go in the output
  #    directory, like a dvi file.  But xelatex under MiKTeX puts it in the
  #    aux directory, so we must copy that behavior.

  my @move_exts = ('dvi', 'fls', 'pdf', 'ps', 'synctex.gz' );

  # Determine aux and output directories from command line:
  my $auxD = '';
  my $outD = '';
  foreach (@_) {
     if ( /^-{1,2}aux-directory=(.*)$/ ) {
        $auxD = $1;
     }
     elsif ( /^-{1,2}output-directory=(.*)$/ ) {
        $outD = $1;
     }
  }
  if ( $outD eq '' ) { $outD = '.'; }
  if ( $auxD eq '' ) { $auxD = $outD; }

# Construct modified command line, with at most one occurrence of -output-directory
  my @args_act = ();
  my $set_outD = 0;
  foreach (@_) {
     if ( /^-{1,2}(aux|output)-directory=.*$/ ) {
        if ( ! $set_outD ) {
	   push @args_act, "-output-directory=$auxD";
	   $set_outD = 1;
	}
     }
     else {
        push @args_act, $_;
     }
  }

# Construct strings for aux and output directories that are suitable
# for prepending to a file name, so that they have any necessary
# directory separators:
  my $outD1 = $outD;
  my $auxD1 = $auxD;
  foreach ( $auxD1, $outD1 ) {
     # Append directory separator '/', but only for a non-empty name
     # that isn't simple an MSWin drive name.
     if ( ($_ ne '')  && ! m([\\/\:]$) ) {
        $_ .= '/';
     }
     # Clean up by removing any sequence of './'. These refer to
     # current directory.
     while ( s[^\.\/][] ) {}
   }

  print "Running: '@args_act'\n";
  my $ret = system @args_act;
  if ($auxD ne $outD) {
     print "Move @move_exts files from '$auxD' to '$outD'\n";
     # Use copy and unlink, not rename, since some viewers appear to keep the
     # viewed file open.  So if rename were used, such viewers would see the
     # old version of the file, rather than the new one.  With copy, the
     # contents of the old file are normally overwritten by the new contents.
     #
     # In addition, copy works across file system boundaries, but rename
     # doesn't.
     foreach my $ext (@move_exts) {
        copy "$auxD1$root_filename.$ext", "$outD1$root_filename.$ext";
        unlink "$auxD1$root_filename.$ext";
     }
  }
  return $ret;
}

#---------------------------
