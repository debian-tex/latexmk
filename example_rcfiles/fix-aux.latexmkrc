# This shows how to implement the use different values for $aux_dir and
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
  # Just communicate by arguments, and don't use latexmk's variables
  # $aux_dir, etc.
  my $auxD = '';
  my $outD = '';
  foreach (@_) {
     if ( /^-aux-directory=(.*)$/ ) {
        $auxD = $1;
     }
     elsif ( /^-output-directory=(.*)$/ ) {
        $outD = $1;
     }
  }
  if ( $outD eq '' ) { $outD = '.'; }
  if ( $auxD eq '' ) { $auxD = $outD; }
  my @args_act = ();
  my $set_outD = 0;
  foreach (@_) {
     if ( /^-(aux|output)-directory=.*$/ ) {
        if ( ! $set_outD ) {
	   push @args_act, "-output-directory=$auxD";
	   $set_outD = 1;
	}
     }
     else {
        push @args_act, $_;
     }
  }
  my $outD1 = $outD;
  my $auxD1 = $auxD;
  foreach ( $auxD1, $outD1 ) {
     if ( ($_ ne '')  && ! m([\\/\:]$) ) {
        $_ .= '/';
     }
     while ( s[^\.\/][] ) {}
   }

  print "Running: '@args_act'\n";
  my $ret = system @args_act;
  if ($auxD ne $outD) {
     print "Moving dvi, fls, ps, pdf files from '$auxD' to '$outD'\n";
     foreach my $ext ('dvi', 'fls', 'ps', 'pdf' ) {
        rename "$auxD1$root_filename.$ext", "$outD1$root_filename.$ext",;
     }
  }
  return $ret;
}

#---------------------------
