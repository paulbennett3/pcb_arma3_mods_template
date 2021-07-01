
my $default_base_path = "/mnt/c/Documents\ and\ Settings/nazgh/My\ Documents/Arma\ 3/mpmissions/";
my $default_pbo_path = "/mnt/d/SteamLibrary/steamapps/common/Arma\ 3/MPMissions/";

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
# Do some sanity checks -- like are all functions and missions defined
#   in Description.ext
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
map
{
    chomp;
    my $full = $_;
    my @fields = split /\//, $full;
    my $name = $fields[$#fields];
    $name =~ s/^fn_//;
    $name =~ s/\.sqf$//;
    if (! `grep $name Description.ext`) {
        die "\n\n\n\nERROR! $full not in Description.ext\n";	     
    } 
} `ls functions/fn*.sqf`;
map
{
    chomp;
    my $full = $_;
    my @fields = split /\//, $full;
    my $name = $fields[$#fields];
    $name =~ s/^fn_//;
    $name =~ s/\.sqf$//;
    if (! `grep $name Description.ext`) {
        die "\n\n\n\nERROR! $full not in Description.ext\n";	     
    } 
} `ls missions/fn*.sqf`;



# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# at this point we should do things differently for SCP vice Stargate ...
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if (0) {
print "copying .sqf files ...\n";
print `cp *.sqf "$path"`;

print "copying  Description.ext ...\n";
print `cp Description.ext "$path"`;

print "copying functions ...\n";
print `cp -R functions "$path"`;

print "copying missions ...\n";
print `cp -R missions "$path"`;

};

# #################################################
# make a "sendit.sh" script for uploading .pbo file
# #################################################
my @fields = split /\//, $path;
my $name = $fields[$#fields] . ".pbo";
my $pbo = $default_pbo_path . $name;

if (! -e $pbo) {
    die "Error! pbo file <$pbo> doesn't exist!\n\n";
}

open(FH, '>', "sendit.sh");
print FH "#!\n";
print FH "scp \"$pbo\" root\@94.26.31.102:ds_$name\n";
close(FH);
print `chmod a+x sendit.sh`;

print "Created 'sendit.sh' file\n";

