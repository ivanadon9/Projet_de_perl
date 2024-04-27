use strict;
use warnings;


# open file 
my $data = "data.txt";
my $data2 = "data2.txt";


open(my $file_handler, "<", $data) or die "can't open file";
open (my $file_handler2 , "+>", $data2) or die "can't open file .";


print("Enregistrement des donnees .\n");

while(my $content = <$file_handler>){

    if ($content =~ m/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) - - \[(\d{2}\/\w{3}\/\d{4}):(\d{2}:\d{2}:\d{2}) \+\d{4}\] ".*?" (\d{3})/
    ) {
        my $adresse_ip = $1;
        my $horodatage = $2;
        my $code_erreur = $4;

        $horodatage =~ s/May/05/;
        # start writting in ours file.
        print($file_handler2 "$adresse_ip\t$horodatage\t$code_erreur\n");
        print "$adresse_ip\t$horodatage\t$code_erreur\n";
    }

}


print('Le fichier fini se trouve dans data2.txt');
# CLOSE FILES 
close($file_handler) or die "can't close file";

close($file_handler2) or die "can't close file .";