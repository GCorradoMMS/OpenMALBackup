#!/usr/bin/perl
use Time::Piece;
use warnings;
use YAML::XS 'LoadFile';
use Data::Dumper;

my $system = "$^O";
my $export_dir = 'OpenMALBackup';
my $today = localtime->strftime('%d-%m-%y');
my $config = LoadFile('config.yaml');
my $absolute_path = "/etc/";
my $dir_concater = "/";


if ($system eq "MSWin32") { 
    $absolute_path = "C:\\";
    $dir_concater = "\\";
}

if (!directory_exists()) {
    create_main_directory();
    mkdir( $absolute_path . $export_dir . $dir_concater . 'anime');
    mkdir( $absolute_path . $export_dir . $dir_concater . 'manga');
} 

chdir( $absolute_path . $export_dir . $dir_concater .'anime' ) or die "$!";
system "$config->{MAL_ANIME_EXPORT_CURL_REQUEST} -o $today.zip";

chdir($absolute_path);

chdir( $absolute_path . $export_dir . $dir_concater .'manga' ) or die "$!";
system "$config->{MAL_MANGA_EXPORT_CURL_REQUEST} -o $today.zip";


sub create_main_directory {
    mkdir( $absolute_path . $export_dir );
}

sub today_backup_directory_exists {
    if (-d $absolute_path . $export_dir . $today) {
        return 1;
    }
    elsif (-e $absolute_path . $export_dir . $today) {
        return '';
    }
    else {
        return '';
    }
}

sub directory_exists {
    if (-d $absolute_path . $export_dir) {
        return 1;
    }
    elsif (-e $absolute_path . $export_dir) {
        return '';
    }
    else {
        return '';
    }
}