
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
        my $machine_summary = {};

        for my $machine (@$machines) {

            my $run        = $machine->get_last_solexa_run();
            my $last_event = $run->get_last_event();

            if ($run->er_id == 2438) {
                $DB::single = 1;
            }

            my $stats      = $model->get_seq_stats( $run->er_id );

            if ($stats) {
                $machine_summary = {
                    flow_cell            => $run->flow_cell_id(),
                    cycles_done          => $stats->{'last_instrument_cycle'},
                    cycles_estimated     => $stats->{'total_cycles'},
                    transferred          => $stats->{'last_transfer_cycle'},
                    estimated_completion => $stats->{'read_complete_time'},
                };
            } else {
                $machine_summary = {
                    flow_cell            => $run->flow_cell_id(),
                    cycles_done          => 0,
                    cycles_estimated     => 'uknown',
                    transferred          => 0,
                    estimated_completion => undef,
                };
            }
        }

        $e->{$room} = $machine_summary;
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





