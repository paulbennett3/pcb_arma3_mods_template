
my $default_base_path = "/mnt/c/Documents\ and\ Settings/nazgh/My\ Documents/Arma\ 3/mpmissions/";

if ($#ARGV < 0) {
    die "specify path on command line!\n\n\n";
}

my $path = $ARGV[0];
# is it an absolute path?
if ($path =~ /^\//) {
    print "using path as <$path>\n";
}
else
{
    $path = $default_base_path . $path;
    print "using path with default base as <$path>\n";
}

# make sure path exists
if (! -e $path) {
    die "Failed to access path <$path>\n\n\n";
}

# verify there is a mission.sqm file in $path
if (! -e "$path/mission.sqm") {
    die "No 'mission.sqm' file on path <$path>\n";
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# at this point we should do things differently for SCP vice Stargate ...
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

print "copying .sqf files ...\n";
print `cp *.sqf "$path"`;

print "copying  Description.ext ...\n";
print `cp Description.ext "$path"`;

print "copying functions ...\n";
print `cp -R functions "$path"`;

print "copying missions ...\n";
print `cp -R missions "$path"`;



