
use strict;
use warnings;
use Data::Dumper;

use JSON;

use GSCApp;
App->init();

use lib '/gscuser/jlolofie/dev/KOM/trunk/lib/';
use IMP::Model::Solexa::Equipment;


my $e = get_equipment_info();

my $j = JSON->new();
my $json= $j->encode($e);
print $json;


exit;


sub get_equipment_info {

    my $e = {};

    my $model = IMP::Model::Solexa::Equipment->new();
    my $rooms = $model->_build_rooms_with_illumina_machines();

    for my $room (@$rooms) {

        next if $room eq 'unknown';
        my $machines = $model->machines_in_room($room);
        my $machine_summaries = {};

        for my $machine (@$machines) {

            my $machine_summary = {};

            my $run        = $machine->get_last_solexa_run();
            my $stats      = $model->get_seq_stats( $run->er_id );

            if ($stats) {
                $machine_summary = {
                    cycles_done          => $stats->{'last_instrument_cycle'},
                    cycles_estimated     => $stats->{'total_cycles'},
                    transferred          => $stats->{'last_transfer_cycle'},
                    estimated_completion => $stats->{'read_complete_time'},
                };
            } else {
                $machine_summary = {
                    cycles_done          => 0,
                    cycles_estimated     => 'unknown',
                    transferred          => 0,
                    estimated_completion => 'unknown',
                };
            }

            $machine_summary->{'flow_cell'} = $run->flow_cell_id();

            my $machine_name = $machine->serial_number();
            $machine_name =~ s/HW(.+)-//;
            $machine_summary->{'machine_name'} = $machine_name;

            my $last_event = $run->get_last_event();
            my $last_ps    = $last_event->get_process_step();

            $machine_summary->{'last_step'} = $last_ps->process_to() || 'unknown';
            $machine_summary->{'ins_software_version'} = $run->instrument_software_version || 'unknown';
            $machine_summary->{'rta_software_version'} = $run->rta_software_version || 'unknown';
            $machine_summary->{'recipe'} = sprintf( "(%s) %s",
                $run->run_type_short || 'unknown',
                $run->recipe_name    || 'unknown' );

            my $dna = $run->get_dna_by_lane();
            my @dna_ary = map { $dna->{$_}->dna_name } sort keys %$dna;
            $machine_summary->{'samples'} = \@dna_ary;

            # add to the record
            $machine_summaries->{$machine_name} = $machine_summary;
        }

        $e->{$room} = $machine_summaries;
    }

    return $e;
}

#model->_build_rooms_with_illumina_machines
#model->machines_in_room
#machine->get_last_solexa_run
#run->flow_cell_id, get_last_event
#model->get_seq_stats(run->er_id)
#last_event->get_process_step
#last_process_step->purpose
#


#                EAS1554 => { flow_cell => '61AEF', imaged1 => 101, imaged2 => 102, tranferred => 101, date => '20 Nov 2009 - 13:19' },
#                EAS1605 => { flow_cell => '434WT', imaged1 => 72, imaged2 => 72, tranferred => 72, date => '20 Nov 2009 - 11:19' },
#            },
#          4150 => {
#                EAS227 => { flow_cell => '4350R', imaged1 => 118, imaged2 => 202, tranferred => 117, date => '20 Nov 2009 - 12:22' },
#                EAS231 => { flow_cell => '61AE2', imaged1 => 65, imaged2 => 152, tranferred => 63, date => '20 Nov 2009 - 12:09' },
#                EAS284 => { flow_cell => '61AC6', imaged1 => 140, imaged2 => 152, tranferred => 76, date => '20 Nov 2009 - 13:11' },
#            },
#        };





