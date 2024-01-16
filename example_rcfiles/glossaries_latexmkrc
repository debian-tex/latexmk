# This shows how to use the glossaries package
# (http://www.ctan.org/pkg/glossaries) and the glossaries-extra package
# (http://www.ctan.org/pkg/glossaries-extra) with latexmk.

# N.B. There is also the OBSOLETE glossary package
# (http://www.ctan.org/pkg/glossary), which has some differences.  See item 3.

# 1. If you use the glossaries or the glossaries-extra package, then you can use:

   add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
   add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
   $clean_ext .= " acr acn alg glo gls glg";

   sub makeglossaries {
        my ($base_name, $path) = fileparse( $_[0] );
        my @args = ( "-q", "-d", $path, $base_name );
        if ($silent) { unshift @args, "-q"; }
        return system "makeglossaries", "-d", $path, $base_name; 
    }

# 2. The above will tend to run makeglossaries more often than needed, since
#    each out of date file will trigger the use of makeglossaries, even
#    though makeglossaries makes all the glossaries.  The following solution
#    solves this, but at the expense of not having the convenience that
#    makeglossaries can change how it makes the glossaries depending on the
#    settings of the glossaries package.
#    A better solution will need more advanced work.
#
#   add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
#   add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
#   $clean_ext .= " acr acn alg glo gls glg";
#
#   sub makeglossaries {
#       my @args = ( "-s", "$_[0].ist", "-t", "$$Psource.ilg",
#                    "-o", $$Pdest, $$Psource );
#       if ($silent) { unshift @args, "-q"; }
#       return system "makeindex", @args;
#   }

# 3. If you use the OBSOLETE glossary package, then you can do the following:
#    (Note that the code lines are commented out to avoid trouble when this
#    file is simply copied into a latexmkrc or this file is arranged to be
#    read by latexmk, and one of the modern packages glossaries and
#    glossaries-extra is used.)

   ## For the main glossary:
   #add_cus_dep( 'glo', 'gls', 0, 'makeglo2gls' );
   #sub makeglo2gls {
   #    system("makeindex -s \"$_[0].ist\" -t \"$_[0].glg\" -o \"$_[0].gls\" \"$_[0].glo\"" );
   #}

   ## For acronyms:
   ## 
   ## ===> WARNING: The code below is ONLY FOR PACKAGE glossary, NOT FOR
   ##      glossaries and glossaries-extra. In the current glossaries and
   ##      glossaries-extra packages the roles of the .acr and .acn files are
   ##      exchanged compared with the old glossary package.  Hence the the
   ##      code below will fail with the more modern packages.
   #add_cus_dep( 'acr', 'acn', 0, 'makeacr2acn' );
   #sub makeacr2acn {
   #    system( "makeindex -s \"$_[0].ist\" -t \"$_[0].alg\" -o \"$_[0].acn\" \"$_[0].acr\"" );
   #}
