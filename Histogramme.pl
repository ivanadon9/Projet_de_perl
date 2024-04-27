use strict;
use warnings;
use GD::Graph::bars;
use GD;

my $data2 = "data2.txt";

open(my $file_handler, "<", $data2) or die "can't open file";

print("Affichons les informations contenues dans le fichier.\n");

my ($a, $b, $c, $d) = (0, 0, 0, 0);

while (my $content = <$file_handler>) {
    my @content_array = split(/\s+/, $content);
    my $value = $content_array[1];

    if (substr($value, 0, 5) eq "17/05") {
        $a++;
    } elsif (substr($value, 0, 5) eq "18/05") {
        $b++;
    } elsif (substr($value, 0, 5) eq "19/05") {
        $c++;
    } elsif (substr($value, 0, 5) eq "20/05") {
        $d++;
    }
}

close($file_handler) or die "can't close file";

my @ips = ('JOUR 1', 'JOUR 2', 'JOUR 3', 'JOUR 4');
my @count = ($a, $b, $c, $d);

my $graph = GD::Graph::bars->new(800, 600);

$graph->set(
    x_label           => 'Adresses IP',
    y_label           => 'Nombre de fois',
    title             => 'Occurrences des adresses IP',
    x_labels_vertical => 1,
    bar_spacing       => 8,
    shadow_depth      => 4,
    upper_percent     => 70,
    lower_percent     => 35,
    step_const        => 1.8
 
);

my @data = (\@ips, \@count);


my $gd = $graph->plot(\@data) or die $graph->error;


# Enregistrer l'image modifiée
open(my $out, '>', 'Graphs/Histogramme.png') or die "Impossible de créer le fichier : $!";
binmode $out;
print $out $gd->png;
close $out;

print "Graphique des adresses IP généré avec succès sous le nom 'Histogramme.png'\n";
