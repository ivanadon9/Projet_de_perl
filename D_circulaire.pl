use strict;
use warnings;
use GD::Graph::pie;




my $data2 = "data2.txt";

open(my $file_handler, "<", $data2) or die "can't open file";


my $Error_1xx = 0;
my $Error_2xx = 0;
my $Error_3xx = 0;
my $Error_4xx = 0;
my $Error_5xx = 0;

my $value;
while(my $content = <$file_handler>){
   my @content_array = split(/\s+/, $content);
    $value = $content_array[2];


    if( ($value >= 100) && ($value <= 199) ){
        $Error_1xx++;
    }elsif(($value >= 200) && ($value <= 299) ){
        $Error_2xx++;
    }elsif(($value >= 300) && ($value <= 399) ){
        $Error_3xx++;
    }elsif(($value>= 400) && ($value <= 499) ){
        $Error_4xx++;
    }elsif(($value>= 500) && ($value <= 599) ){
        $Error_5xx++;
    }
  
    
}

close($file_handler) or die "can't close file";






my @data = (
    ["Information", "Succès", "Redirection", "Erreur du client HTTP","Erreur du serveur "],
    [$Error_1xx, $Error_2xx, $Error_3xx, $Error_4xx, $Error_5xx]
);

# Création du graphique
my $graph = GD::Graph::pie->new(400, 300);

# Configuration du graphique
$graph->set(
    title => "CODES D'ERREUR NOTRE LOG",
    label => \*GD::Font::Large,
    transparent => 5,
  

) or die $graph->error;

# Création de l'image
my $gd = $graph->plot(\@data) or die $graph->error;

# Sauvegarde de l'image
open(my $out, '>', 'Graphs/Diag_circulaire.png') or die "Impossible de créer le fichier : $!";
binmode $out;
print $out $gd->png;
close $out;

print "Diagramme circulaire généré avec succès sous le nom 'pie_chart.png'\n";
