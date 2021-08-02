#! /usr/bin/perl
#
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

if (1) {
print "copying .sqf files ...\n";
print `cp *.sqf "$path"`;

print "copying  Description.ext ...\n";
print `cp Description.ext "$path"`;

print "copying functions ...\n";
print `cp -R functions "$path"`;

print "copying scripts ...\n";
print `cp -R scripts "$path"`;
};

# #################################################
# make a "sendit.sh" script for uploading .pbo file
# #################################################
my @fields = split /\//, $path;
my $name = $fields[$#fields] . ".pbo";
my $pbo = $default_pbo_path . $name;

open(FH, '>', "sendit.sh");
print FH "#!\n";
print FH "scp \"$pbo\" root\@94.26.31.102:ds_$name\n";
close(FH);
print `chmod a+x sendit.sh`;

print "Created 'sendit.sh' file\n";

