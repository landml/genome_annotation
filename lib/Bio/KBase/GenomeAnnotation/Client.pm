package Bio::KBase::GenomeAnnotation::Client;

use JSON::RPC::Client;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

Bio::KBase::GenomeAnnotation::Client

=head1 DESCRIPTION


API Access to the Genome Annotation Service.

Provides support for gene calling, functional annotation, re-annotation. Use to extract annotation in
formation about an existing genome, or to create new annotations.


=cut

sub new
{
    my($class, $url, @args) = @_;
    
    if (!defined($url))
    {
	$url = 'https://kbase.us/services/genome_annotation';
    }

    my $self = {
	client => Bio::KBase::GenomeAnnotation::Client::RpcClient->new,
	url => $url,
    };


    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 genomeTO_to_reconstructionTO

  $return = $obj->genomeTO_to_reconstructionTO($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a reconstructionTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
reconstructionTO is a reference to a hash where the following keys are defined:
	subsystems has a value which is a variant_subsystem_pairs
	bindings has a value which is a fid_role_pairs
	assignments has a value which is a fid_function_pairs
variant_subsystem_pairs is a reference to a list where each element is a variant_of_subsystem
variant_of_subsystem is a reference to a list containing 2 items:
	0: a subsystem
	1: a variant
subsystem is a string
variant is a string
fid_role_pairs is a reference to a list where each element is a fid_role_pair
fid_role_pair is a reference to a list containing 2 items:
	0: a fid
	1: a role
fid is a string
role is a string
fid_function_pairs is a reference to a list where each element is a fid_function_pair
fid_function_pair is a reference to a list containing 2 items:
	0: a fid
	1: a function
function is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a reconstructionTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
reconstructionTO is a reference to a hash where the following keys are defined:
	subsystems has a value which is a variant_subsystem_pairs
	bindings has a value which is a fid_role_pairs
	assignments has a value which is a fid_function_pairs
variant_subsystem_pairs is a reference to a list where each element is a variant_of_subsystem
variant_of_subsystem is a reference to a list containing 2 items:
	0: a subsystem
	1: a variant
subsystem is a string
variant is a string
fid_role_pairs is a reference to a list where each element is a fid_role_pair
fid_role_pair is a reference to a list containing 2 items:
	0: a fid
	1: a role
fid is a string
role is a string
fid_function_pairs is a reference to a list where each element is a fid_function_pair
fid_function_pair is a reference to a list containing 2 items:
	0: a fid
	1: a function
function is a string


=end text

=item Description



=back

=cut

sub genomeTO_to_reconstructionTO
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function genomeTO_to_reconstructionTO (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to genomeTO_to_reconstructionTO:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'genomeTO_to_reconstructionTO');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.genomeTO_to_reconstructionTO",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'genomeTO_to_reconstructionTO',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method genomeTO_to_reconstructionTO",
					    status_line => $self->{client}->status_line,
					    method_name => 'genomeTO_to_reconstructionTO',
				       );
    }
}



=head2 genomeTO_to_feature_data

  $return = $obj->genomeTO_to_feature_data($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a fid_data_tuples
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
fid_data_tuples is a reference to a list where each element is a fid_data_tuple
fid_data_tuple is a reference to a list containing 4 items:
	0: a fid
	1: a md5
	2: a location
	3: a function
fid is a string
md5 is a string
function is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a fid_data_tuples
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
fid_data_tuples is a reference to a list where each element is a fid_data_tuple
fid_data_tuple is a reference to a list containing 4 items:
	0: a fid
	1: a md5
	2: a location
	3: a function
fid is a string
md5 is a string
function is a string


=end text

=item Description



=back

=cut

sub genomeTO_to_feature_data
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function genomeTO_to_feature_data (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to genomeTO_to_feature_data:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'genomeTO_to_feature_data');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.genomeTO_to_feature_data",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'genomeTO_to_feature_data',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method genomeTO_to_feature_data",
					    status_line => $self->{client}->status_line,
					    method_name => 'genomeTO_to_feature_data',
				       );
    }
}



=head2 reconstructionTO_to_roles

  $return = $obj->reconstructionTO_to_roles($reconstructionTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$reconstructionTO is a reconstructionTO
$return is a reference to a list where each element is a role
reconstructionTO is a reference to a hash where the following keys are defined:
	subsystems has a value which is a variant_subsystem_pairs
	bindings has a value which is a fid_role_pairs
	assignments has a value which is a fid_function_pairs
variant_subsystem_pairs is a reference to a list where each element is a variant_of_subsystem
variant_of_subsystem is a reference to a list containing 2 items:
	0: a subsystem
	1: a variant
subsystem is a string
variant is a string
fid_role_pairs is a reference to a list where each element is a fid_role_pair
fid_role_pair is a reference to a list containing 2 items:
	0: a fid
	1: a role
fid is a string
role is a string
fid_function_pairs is a reference to a list where each element is a fid_function_pair
fid_function_pair is a reference to a list containing 2 items:
	0: a fid
	1: a function
function is a string

</pre>

=end html

=begin text

$reconstructionTO is a reconstructionTO
$return is a reference to a list where each element is a role
reconstructionTO is a reference to a hash where the following keys are defined:
	subsystems has a value which is a variant_subsystem_pairs
	bindings has a value which is a fid_role_pairs
	assignments has a value which is a fid_function_pairs
variant_subsystem_pairs is a reference to a list where each element is a variant_of_subsystem
variant_of_subsystem is a reference to a list containing 2 items:
	0: a subsystem
	1: a variant
subsystem is a string
variant is a string
fid_role_pairs is a reference to a list where each element is a fid_role_pair
fid_role_pair is a reference to a list containing 2 items:
	0: a fid
	1: a role
fid is a string
role is a string
fid_function_pairs is a reference to a list where each element is a fid_function_pair
fid_function_pair is a reference to a list containing 2 items:
	0: a fid
	1: a function
function is a string


=end text

=item Description



=back

=cut

sub reconstructionTO_to_roles
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function reconstructionTO_to_roles (received $n, expecting 1)");
    }
    {
	my($reconstructionTO) = @args;

	my @_bad_arguments;
        (ref($reconstructionTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"reconstructionTO\" (value was \"$reconstructionTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to reconstructionTO_to_roles:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'reconstructionTO_to_roles');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.reconstructionTO_to_roles",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'reconstructionTO_to_roles',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method reconstructionTO_to_roles",
					    status_line => $self->{client}->status_line,
					    method_name => 'reconstructionTO_to_roles',
				       );
    }
}



=head2 reconstructionTO_to_subsystems

  $return = $obj->reconstructionTO_to_subsystems($reconstructionTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$reconstructionTO is a reconstructionTO
$return is a variant_subsystem_pairs
reconstructionTO is a reference to a hash where the following keys are defined:
	subsystems has a value which is a variant_subsystem_pairs
	bindings has a value which is a fid_role_pairs
	assignments has a value which is a fid_function_pairs
variant_subsystem_pairs is a reference to a list where each element is a variant_of_subsystem
variant_of_subsystem is a reference to a list containing 2 items:
	0: a subsystem
	1: a variant
subsystem is a string
variant is a string
fid_role_pairs is a reference to a list where each element is a fid_role_pair
fid_role_pair is a reference to a list containing 2 items:
	0: a fid
	1: a role
fid is a string
role is a string
fid_function_pairs is a reference to a list where each element is a fid_function_pair
fid_function_pair is a reference to a list containing 2 items:
	0: a fid
	1: a function
function is a string

</pre>

=end html

=begin text

$reconstructionTO is a reconstructionTO
$return is a variant_subsystem_pairs
reconstructionTO is a reference to a hash where the following keys are defined:
	subsystems has a value which is a variant_subsystem_pairs
	bindings has a value which is a fid_role_pairs
	assignments has a value which is a fid_function_pairs
variant_subsystem_pairs is a reference to a list where each element is a variant_of_subsystem
variant_of_subsystem is a reference to a list containing 2 items:
	0: a subsystem
	1: a variant
subsystem is a string
variant is a string
fid_role_pairs is a reference to a list where each element is a fid_role_pair
fid_role_pair is a reference to a list containing 2 items:
	0: a fid
	1: a role
fid is a string
role is a string
fid_function_pairs is a reference to a list where each element is a fid_function_pair
fid_function_pair is a reference to a list containing 2 items:
	0: a fid
	1: a function
function is a string


=end text

=item Description



=back

=cut

sub reconstructionTO_to_subsystems
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function reconstructionTO_to_subsystems (received $n, expecting 1)");
    }
    {
	my($reconstructionTO) = @args;

	my @_bad_arguments;
        (ref($reconstructionTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"reconstructionTO\" (value was \"$reconstructionTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to reconstructionTO_to_subsystems:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'reconstructionTO_to_subsystems');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.reconstructionTO_to_subsystems",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'reconstructionTO_to_subsystems',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method reconstructionTO_to_subsystems",
					    status_line => $self->{client}->status_line,
					    method_name => 'reconstructionTO_to_subsystems',
				       );
    }
}



=head2 annotate_genome

  $return = $obj->annotate_genome($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description

Given a genome object populated with contig data, perform gene calling
and functional annotation and return the annotated genome.
 NOTE: Many of these "transformations" modify the input hash and
       copy the pointer.  Be warned.

=back

=cut

sub annotate_genome
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function annotate_genome (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to annotate_genome:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'annotate_genome');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.annotate_genome",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'annotate_genome',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method annotate_genome",
					    status_line => $self->{client}->status_line,
					    method_name => 'annotate_genome',
				       );
    }
}



=head2 call_selenoproteins

  $return = $obj->call_selenoproteins($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub call_selenoproteins
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_selenoproteins (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_selenoproteins:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_selenoproteins');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_selenoproteins",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_selenoproteins',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_selenoproteins",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_selenoproteins',
				       );
    }
}



=head2 call_pyrrolysoproteins

  $return = $obj->call_pyrrolysoproteins($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub call_pyrrolysoproteins
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_pyrrolysoproteins (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_pyrrolysoproteins:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_pyrrolysoproteins');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_pyrrolysoproteins",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_pyrrolysoproteins',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_pyrrolysoproteins",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_pyrrolysoproteins',
				       );
    }
}



=head2 call_features_rRNA_SEED

  $genome_out = $obj->call_features_rRNA_SEED($genome_in, $types)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_in is a genomeTO
$types is a reference to a list where each element is a rna_type
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
rna_type is a string

</pre>

=end html

=begin text

$genome_in is a genomeTO
$types is a reference to a list where each element is a rna_type
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
rna_type is a string


=end text

=item Description

Given a genome typed object, find instances of ribosomal RNAs in
the genome.
The types parameter is used to select the types of RNAs to
call. It is a list of strings where each value is one of
   "5S"
   "SSU"
   "LSU"
or "ALL" to choose all available rRNA types.

=back

=cut

sub call_features_rRNA_SEED
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_rRNA_SEED (received $n, expecting 2)");
    }
    {
	my($genome_in, $types) = @args;

	my @_bad_arguments;
        (ref($genome_in) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genome_in\" (value was \"$genome_in\")");
        (ref($types) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"types\" (value was \"$types\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_rRNA_SEED:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_rRNA_SEED');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_rRNA_SEED",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_rRNA_SEED',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_rRNA_SEED",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_rRNA_SEED',
				       );
    }
}



=head2 call_features_tRNA_trnascan

  $genome_out = $obj->call_features_tRNA_trnascan($genome_in)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_in is a genomeTO
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genome_in is a genomeTO
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description

Given a genome typed object, find instances of tRNAs in
the genome.

=back

=cut

sub call_features_tRNA_trnascan
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_tRNA_trnascan (received $n, expecting 1)");
    }
    {
	my($genome_in) = @args;

	my @_bad_arguments;
        (ref($genome_in) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genome_in\" (value was \"$genome_in\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_tRNA_trnascan:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_tRNA_trnascan');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_tRNA_trnascan",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_tRNA_trnascan',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_tRNA_trnascan",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_tRNA_trnascan',
				       );
    }
}



=head2 call_RNAs

  $genome_out = $obj->call_RNAs($genome_in)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_in is a genomeTO
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genome_in is a genomeTO
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description

Given a genome typed object, find instances of all RNAs we currently
have support for detecting.

=back

=cut

sub call_RNAs
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_RNAs (received $n, expecting 1)");
    }
    {
	my($genome_in) = @args;

	my @_bad_arguments;
        (ref($genome_in) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genome_in\" (value was \"$genome_in\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_RNAs:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_RNAs');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_RNAs",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_RNAs',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_RNAs",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_RNAs',
				       );
    }
}



=head2 call_features_CDS_glimmer3

  $return = $obj->call_features_CDS_glimmer3($genomeTO, $params)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$params is a glimmer3_parameters
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
glimmer3_parameters is a reference to a hash where the following keys are defined:
	min_training_len has a value which is an int

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$params is a glimmer3_parameters
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
glimmer3_parameters is a reference to a hash where the following keys are defined:
	min_training_len has a value which is an int


=end text

=item Description



=back

=cut

sub call_features_CDS_glimmer3
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_CDS_glimmer3 (received $n, expecting 2)");
    }
    {
	my($genomeTO, $params) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 2 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_CDS_glimmer3:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_CDS_glimmer3');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_CDS_glimmer3",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_CDS_glimmer3',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_CDS_glimmer3",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_CDS_glimmer3',
				       );
    }
}



=head2 call_features_CDS_prodigal

  $return = $obj->call_features_CDS_prodigal($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub call_features_CDS_prodigal
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_CDS_prodigal (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_CDS_prodigal:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_CDS_prodigal');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_CDS_prodigal",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_CDS_prodigal',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_CDS_prodigal",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_CDS_prodigal',
				       );
    }
}



=head2 call_features_CDS_SEED_projection

  $return = $obj->call_features_CDS_SEED_projection($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub call_features_CDS_SEED_projection
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_CDS_SEED_projection (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_CDS_SEED_projection:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_CDS_SEED_projection');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_CDS_SEED_projection",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_CDS_SEED_projection',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_CDS_SEED_projection",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_CDS_SEED_projection',
				       );
    }
}



=head2 call_features_CDS_FragGeneScan

  $return = $obj->call_features_CDS_FragGeneScan($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub call_features_CDS_FragGeneScan
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_CDS_FragGeneScan (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_CDS_FragGeneScan:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_CDS_FragGeneScan');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_CDS_FragGeneScan",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_CDS_FragGeneScan',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_CDS_FragGeneScan",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_CDS_FragGeneScan',
				       );
    }
}



=head2 call_features_repeat_region_SEED

  $genome_out = $obj->call_features_repeat_region_SEED($genome_in, $params)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_in is a genomeTO
$params is a repeat_region_SEED_parameters
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
repeat_region_SEED_parameters is a reference to a hash where the following keys are defined:
	min_identity has a value which is a float
	min_length has a value which is an int

</pre>

=end html

=begin text

$genome_in is a genomeTO
$params is a repeat_region_SEED_parameters
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
repeat_region_SEED_parameters is a reference to a hash where the following keys are defined:
	min_identity has a value which is a float
	min_length has a value which is an int


=end text

=item Description



=back

=cut

sub call_features_repeat_region_SEED
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_repeat_region_SEED (received $n, expecting 2)");
    }
    {
	my($genome_in, $params) = @args;

	my @_bad_arguments;
        (ref($genome_in) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genome_in\" (value was \"$genome_in\")");
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 2 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_repeat_region_SEED:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_repeat_region_SEED');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_repeat_region_SEED",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_repeat_region_SEED',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_repeat_region_SEED",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_repeat_region_SEED',
				       );
    }
}



=head2 call_features_prophage_phispy

  $genome_out = $obj->call_features_prophage_phispy($genome_in)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_in is a genomeTO
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genome_in is a genomeTO
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub call_features_prophage_phispy
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_prophage_phispy (received $n, expecting 1)");
    }
    {
	my($genome_in) = @args;

	my @_bad_arguments;
        (ref($genome_in) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genome_in\" (value was \"$genome_in\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_prophage_phispy:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_prophage_phispy');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_prophage_phispy",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_prophage_phispy',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_prophage_phispy",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_prophage_phispy',
				       );
    }
}



=head2 call_features_scan_for_matches

  $genome_out = $obj->call_features_scan_for_matches($genome_in, $pattern, $feature_type)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_in is a genomeTO
$pattern is a string
$feature_type is a string
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genome_in is a genomeTO
$pattern is a string
$feature_type is a string
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub call_features_scan_for_matches
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 3)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_scan_for_matches (received $n, expecting 3)");
    }
    {
	my($genome_in, $pattern, $feature_type) = @args;

	my @_bad_arguments;
        (ref($genome_in) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genome_in\" (value was \"$genome_in\")");
        (!ref($pattern)) or push(@_bad_arguments, "Invalid type for argument 2 \"pattern\" (value was \"$pattern\")");
        (!ref($feature_type)) or push(@_bad_arguments, "Invalid type for argument 3 \"feature_type\" (value was \"$feature_type\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_scan_for_matches:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_scan_for_matches');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_scan_for_matches",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_scan_for_matches',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_scan_for_matches",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_scan_for_matches',
				       );
    }
}



=head2 annotate_proteins_kmer_v1

  $return = $obj->annotate_proteins_kmer_v1($genomeTO, $params)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$params is a kmer_v1_parameters
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
kmer_v1_parameters is a reference to a hash where the following keys are defined:
	kmer_size has a value which is an int
	dataset_name has a value which is a string
	return_scores_for_all_proteins has a value which is an int
	score_threshold has a value which is an int
	hit_threshold has a value which is an int
	sequential_hit_threshold has a value which is an int
	detailed has a value which is an int
	min_hits has a value which is an int
	min_size has a value which is an int
	max_gap has a value which is an int

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$params is a kmer_v1_parameters
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
kmer_v1_parameters is a reference to a hash where the following keys are defined:
	kmer_size has a value which is an int
	dataset_name has a value which is a string
	return_scores_for_all_proteins has a value which is an int
	score_threshold has a value which is an int
	hit_threshold has a value which is an int
	sequential_hit_threshold has a value which is an int
	detailed has a value which is an int
	min_hits has a value which is an int
	min_size has a value which is an int
	max_gap has a value which is an int


=end text

=item Description



=back

=cut

sub annotate_proteins_kmer_v1
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function annotate_proteins_kmer_v1 (received $n, expecting 2)");
    }
    {
	my($genomeTO, $params) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 2 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to annotate_proteins_kmer_v1:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'annotate_proteins_kmer_v1');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.annotate_proteins_kmer_v1",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'annotate_proteins_kmer_v1',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method annotate_proteins_kmer_v1",
					    status_line => $self->{client}->status_line,
					    method_name => 'annotate_proteins_kmer_v1',
				       );
    }
}



=head2 annotate_proteins_kmer_v2

  $genome_out = $obj->annotate_proteins_kmer_v2($genome_in, $params)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_in is a genomeTO
$params is a kmer_v2_parameters
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
kmer_v2_parameters is a reference to a hash where the following keys are defined:
	min_hits has a value which is an int
	max_gap has a value which is an int

</pre>

=end html

=begin text

$genome_in is a genomeTO
$params is a kmer_v2_parameters
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
kmer_v2_parameters is a reference to a hash where the following keys are defined:
	min_hits has a value which is an int
	max_gap has a value which is an int


=end text

=item Description



=back

=cut

sub annotate_proteins_kmer_v2
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function annotate_proteins_kmer_v2 (received $n, expecting 2)");
    }
    {
	my($genome_in, $params) = @args;

	my @_bad_arguments;
        (ref($genome_in) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genome_in\" (value was \"$genome_in\")");
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 2 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to annotate_proteins_kmer_v2:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'annotate_proteins_kmer_v2');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.annotate_proteins_kmer_v2",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'annotate_proteins_kmer_v2',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method annotate_proteins_kmer_v2",
					    status_line => $self->{client}->status_line,
					    method_name => 'annotate_proteins_kmer_v2',
				       );
    }
}



=head2 call_features_ProtoCDS_kmer_v1

  $return = $obj->call_features_ProtoCDS_kmer_v1($genomeTO, $params)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$params is a kmer_v1_parameters
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
kmer_v1_parameters is a reference to a hash where the following keys are defined:
	kmer_size has a value which is an int
	dataset_name has a value which is a string
	return_scores_for_all_proteins has a value which is an int
	score_threshold has a value which is an int
	hit_threshold has a value which is an int
	sequential_hit_threshold has a value which is an int
	detailed has a value which is an int
	min_hits has a value which is an int
	min_size has a value which is an int
	max_gap has a value which is an int

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$params is a kmer_v1_parameters
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
kmer_v1_parameters is a reference to a hash where the following keys are defined:
	kmer_size has a value which is an int
	dataset_name has a value which is a string
	return_scores_for_all_proteins has a value which is an int
	score_threshold has a value which is an int
	hit_threshold has a value which is an int
	sequential_hit_threshold has a value which is an int
	detailed has a value which is an int
	min_hits has a value which is an int
	min_size has a value which is an int
	max_gap has a value which is an int


=end text

=item Description



=back

=cut

sub call_features_ProtoCDS_kmer_v1
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_ProtoCDS_kmer_v1 (received $n, expecting 2)");
    }
    {
	my($genomeTO, $params) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 2 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_ProtoCDS_kmer_v1:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_ProtoCDS_kmer_v1');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_ProtoCDS_kmer_v1",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_ProtoCDS_kmer_v1',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_ProtoCDS_kmer_v1",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_ProtoCDS_kmer_v1',
				       );
    }
}



=head2 call_features_ProtoCDS_kmer_v2

  $genome_out = $obj->call_features_ProtoCDS_kmer_v2($genome_in, $params)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_in is a genomeTO
$params is a kmer_v2_parameters
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
kmer_v2_parameters is a reference to a hash where the following keys are defined:
	min_hits has a value which is an int
	max_gap has a value which is an int

</pre>

=end html

=begin text

$genome_in is a genomeTO
$params is a kmer_v2_parameters
$genome_out is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string
kmer_v2_parameters is a reference to a hash where the following keys are defined:
	min_hits has a value which is an int
	max_gap has a value which is an int


=end text

=item Description

RAST-style kmers

=back

=cut

sub call_features_ProtoCDS_kmer_v2
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_ProtoCDS_kmer_v2 (received $n, expecting 2)");
    }
    {
	my($genome_in, $params) = @args;

	my @_bad_arguments;
        (ref($genome_in) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genome_in\" (value was \"$genome_in\")");
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 2 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_ProtoCDS_kmer_v2:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_ProtoCDS_kmer_v2');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_ProtoCDS_kmer_v2",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_ProtoCDS_kmer_v2',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_ProtoCDS_kmer_v2",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_ProtoCDS_kmer_v2',
				       );
    }
}



=head2 annotate_proteins

  $return = $obj->annotate_proteins($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description

Ross's new kmers

=back

=cut

sub annotate_proteins
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function annotate_proteins (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to annotate_proteins:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'annotate_proteins');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.annotate_proteins",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'annotate_proteins',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method annotate_proteins",
					    status_line => $self->{client}->status_line,
					    method_name => 'annotate_proteins',
				       );
    }
}



=head2 estimate_crude_phylogenetic_position_kmer

  $position_estimate = $obj->estimate_crude_phylogenetic_position_kmer($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$position_estimate is a string
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$position_estimate is a string
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description

Determine close genomes.

=back

=cut

sub estimate_crude_phylogenetic_position_kmer
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function estimate_crude_phylogenetic_position_kmer (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to estimate_crude_phylogenetic_position_kmer:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'estimate_crude_phylogenetic_position_kmer');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.estimate_crude_phylogenetic_position_kmer",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'estimate_crude_phylogenetic_position_kmer',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method estimate_crude_phylogenetic_position_kmer",
					    status_line => $self->{client}->status_line,
					    method_name => 'estimate_crude_phylogenetic_position_kmer',
				       );
    }
}



=head2 find_close_neighbors

  $return = $obj->find_close_neighbors($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub find_close_neighbors
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function find_close_neighbors (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to find_close_neighbors:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'find_close_neighbors');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.find_close_neighbors",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'find_close_neighbors',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method find_close_neighbors",
					    status_line => $self->{client}->status_line,
					    method_name => 'find_close_neighbors',
				       );
    }
}



=head2 call_features_strep_suis_repeat

  $return = $obj->call_features_strep_suis_repeat($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description

Interface to Strep repeats and "boxes" tools

=back

=cut

sub call_features_strep_suis_repeat
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_strep_suis_repeat (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_strep_suis_repeat:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_strep_suis_repeat');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_strep_suis_repeat",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_strep_suis_repeat',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_strep_suis_repeat",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_strep_suis_repeat',
				       );
    }
}



=head2 call_features_strep_pneumo_repeat

  $return = $obj->call_features_strep_pneumo_repeat($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub call_features_strep_pneumo_repeat
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_strep_pneumo_repeat (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_strep_pneumo_repeat:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_strep_pneumo_repeat');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_strep_pneumo_repeat",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_strep_pneumo_repeat',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_strep_pneumo_repeat",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_strep_pneumo_repeat',
				       );
    }
}



=head2 call_features_crispr

  $return = $obj->call_features_crispr($genomeTO)

=over 4

=item Parameter and return types

=begin html

<pre>
$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genomeTO is a genomeTO
$return is a genomeTO
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description



=back

=cut

sub call_features_crispr
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function call_features_crispr (received $n, expecting 1)");
    }
    {
	my($genomeTO) = @args;

	my @_bad_arguments;
        (ref($genomeTO) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genomeTO\" (value was \"$genomeTO\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to call_features_crispr:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'call_features_crispr');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.call_features_crispr",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'call_features_crispr',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method call_features_crispr",
					    status_line => $self->{client}->status_line,
					    method_name => 'call_features_crispr',
				       );
    }
}



=head2 export_genome

  $exported_data = $obj->export_genome($genome_in, $format, $feature_types)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_in is a genomeTO
$format is a string
$feature_types is a reference to a list where each element is a string
$exported_data is a string
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string

</pre>

=end html

=begin text

$genome_in is a genomeTO
$format is a string
$feature_types is a reference to a list where each element is a string
$exported_data is a string
genomeTO is a reference to a hash where the following keys are defined:
	id has a value which is a genome_id
	scientific_name has a value which is a string
	domain has a value which is a string
	genetic_code has a value which is an int
	source has a value which is a string
	source_id has a value which is a string
	quality has a value which is a genome_quality_measure
	contigs has a value which is a reference to a list where each element is a contig
	features has a value which is a reference to a list where each element is a feature
	close_genomes has a value which is a reference to a list where each element is a close_genome
	analysis_events has a value which is a reference to a list where each element is an analysis_event
genome_id is a string
genome_quality_measure is a reference to a hash where the following keys are defined:
	frameshift_error_rate has a value which is a float
	sequence_error_rate has a value which is a float
contig is a reference to a hash where the following keys are defined:
	id has a value which is a contig_id
	dna has a value which is a string
	genetic_code has a value which is an int
	cell_compartment has a value which is a string
	replicon_type has a value which is a string
	replicon_geometry has a value which is a string
	complete has a value which is a bool
contig_id is a string
bool is an int
feature is a reference to a hash where the following keys are defined:
	id has a value which is a feature_id
	location has a value which is a location
	type has a value which is a feature_type
	function has a value which is a string
	protein_translation has a value which is a string
	aliases has a value which is a reference to a list where each element is a string
	annotations has a value which is a reference to a list where each element is an annotation
	quality has a value which is a feature_quality_measure
	feature_creation_event has a value which is an analysis_event_id
feature_id is a string
location is a reference to a list where each element is a region_of_dna
region_of_dna is a reference to a list containing 4 items:
	0: a contig_id
	1: (begin) an int
	2: (strand) a string
	3: (length) an int
feature_type is a string
annotation is a reference to a list containing 4 items:
	0: (comment) a string
	1: (annotator) a string
	2: (annotation_time) an int
	3: an analysis_event_id
analysis_event_id is a string
feature_quality_measure is a reference to a hash where the following keys are defined:
	truncated_begin has a value which is a bool
	truncated_end has a value which is a bool
	existence_confidence has a value which is a float
	frameshifted has a value which is a bool
	selenoprotein has a value which is a bool
	pyrrolysylprotein has a value which is a bool
	overlap_allowed has a value which is a bool
	hit_count has a value which is a float
	weighted_hit_count has a value which is a float
close_genome is a reference to a hash where the following keys are defined:
	genome has a value which is a genome_id
	closeness_measure has a value which is a float
analysis_event is a reference to a hash where the following keys are defined:
	id has a value which is an analysis_event_id
	tool_name has a value which is a string
	execution_time has a value which is a float
	parameters has a value which is a reference to a list where each element is a string
	hostname has a value which is a string


=end text

=item Description

Export genome typed object to one of the supported output formats:
genbank, embl, or gff.
If feature_types is a non-empty list, limit the output to the given
feature types.

=back

=cut

sub export_genome
{
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 3)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function export_genome (received $n, expecting 3)");
    }
    {
	my($genome_in, $format, $feature_types) = @args;

	my @_bad_arguments;
        (ref($genome_in) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"genome_in\" (value was \"$genome_in\")");
        (!ref($format)) or push(@_bad_arguments, "Invalid type for argument 2 \"format\" (value was \"$format\")");
        (ref($feature_types) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 3 \"feature_types\" (value was \"$feature_types\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to export_genome:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'export_genome');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "GenomeAnnotation.export_genome",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'export_genome',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method export_genome",
					    status_line => $self->{client}->status_line,
					    method_name => 'export_genome',
				       );
    }
}



sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, {
        method => "GenomeAnnotation.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'export_genome',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method export_genome",
            status_line => $self->{client}->status_line,
            method_name => 'export_genome',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for Bio::KBase::GenomeAnnotation::Client\n";
    }
    if ($sMajor == 0) {
        warn "Bio::KBase::GenomeAnnotation::Client version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 bool

=over 4



=item Definition

=begin html

<pre>
an int
</pre>

=end html

=begin text

an int

=end text

=back



=head2 md5

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 md5s

=over 4



=item Definition

=begin html

<pre>
a reference to a list where each element is a md5
</pre>

=end html

=begin text

a reference to a list where each element is a md5

=end text

=back



=head2 genome_id

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 feature_id

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 contig_id

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 feature_type

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 region_of_dna

=over 4



=item Description

A region of DNA is maintained as a tuple of four components:

                the contig
                the beginning position (from 1)
                the strand
                the length

           We often speak of "a region".  By "location", we mean a sequence
           of regions from the same genome (perhaps from distinct contigs).

           Strand is either '+' or '-'.


=item Definition

=begin html

<pre>
a reference to a list containing 4 items:
0: a contig_id
1: (begin) an int
2: (strand) a string
3: (length) an int

</pre>

=end html

=begin text

a reference to a list containing 4 items:
0: a contig_id
1: (begin) an int
2: (strand) a string
3: (length) an int


=end text

=back



=head2 location

=over 4



=item Description

a "location" refers to a sequence of regions


=item Definition

=begin html

<pre>
a reference to a list where each element is a region_of_dna
</pre>

=end html

=begin text

a reference to a list where each element is a region_of_dna

=end text

=back



=head2 analysis_event_id

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 analysis_event

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
id has a value which is an analysis_event_id
tool_name has a value which is a string
execution_time has a value which is a float
parameters has a value which is a reference to a list where each element is a string
hostname has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
id has a value which is an analysis_event_id
tool_name has a value which is a string
execution_time has a value which is a float
parameters has a value which is a reference to a list where each element is a string
hostname has a value which is a string


=end text

=back



=head2 annotation

=over 4



=item Definition

=begin html

<pre>
a reference to a list containing 4 items:
0: (comment) a string
1: (annotator) a string
2: (annotation_time) an int
3: an analysis_event_id

</pre>

=end html

=begin text

a reference to a list containing 4 items:
0: (comment) a string
1: (annotator) a string
2: (annotation_time) an int
3: an analysis_event_id


=end text

=back



=head2 feature_quality_measure

=over 4



=item Description

Is this a real feature?


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
truncated_begin has a value which is a bool
truncated_end has a value which is a bool
existence_confidence has a value which is a float
frameshifted has a value which is a bool
selenoprotein has a value which is a bool
pyrrolysylprotein has a value which is a bool
overlap_allowed has a value which is a bool
hit_count has a value which is a float
weighted_hit_count has a value which is a float

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
truncated_begin has a value which is a bool
truncated_end has a value which is a bool
existence_confidence has a value which is a float
frameshifted has a value which is a bool
selenoprotein has a value which is a bool
pyrrolysylprotein has a value which is a bool
overlap_allowed has a value which is a bool
hit_count has a value which is a float
weighted_hit_count has a value which is a float


=end text

=back



=head2 feature

=over 4



=item Description

A feature object represents a feature on the genome. It contains 
the location on the contig with a type, the translation if it
represents a protein, associated aliases, etc. It also contains
information gathered during the annotation process that is involved
in stages that perform overlap removal, quality testing, etc.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
id has a value which is a feature_id
location has a value which is a location
type has a value which is a feature_type
function has a value which is a string
protein_translation has a value which is a string
aliases has a value which is a reference to a list where each element is a string
annotations has a value which is a reference to a list where each element is an annotation
quality has a value which is a feature_quality_measure
feature_creation_event has a value which is an analysis_event_id

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
id has a value which is a feature_id
location has a value which is a location
type has a value which is a feature_type
function has a value which is a string
protein_translation has a value which is a string
aliases has a value which is a reference to a list where each element is a string
annotations has a value which is a reference to a list where each element is an annotation
quality has a value which is a feature_quality_measure
feature_creation_event has a value which is an analysis_event_id


=end text

=back



=head2 contig

=over 4



=item Description

circular / linear


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
id has a value which is a contig_id
dna has a value which is a string
genetic_code has a value which is an int
cell_compartment has a value which is a string
replicon_type has a value which is a string
replicon_geometry has a value which is a string
complete has a value which is a bool

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
id has a value which is a contig_id
dna has a value which is a string
genetic_code has a value which is an int
cell_compartment has a value which is a string
replicon_type has a value which is a string
replicon_geometry has a value which is a string
complete has a value which is a bool


=end text

=back



=head2 close_genome

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
genome has a value which is a genome_id
closeness_measure has a value which is a float

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
genome has a value which is a genome_id
closeness_measure has a value which is a float


=end text

=back



=head2 genome_quality_measure

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
frameshift_error_rate has a value which is a float
sequence_error_rate has a value which is a float

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
frameshift_error_rate has a value which is a float
sequence_error_rate has a value which is a float


=end text

=back



=head2 genomeTO

=over 4



=item Description

All of the information about particular genome


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
id has a value which is a genome_id
scientific_name has a value which is a string
domain has a value which is a string
genetic_code has a value which is an int
source has a value which is a string
source_id has a value which is a string
quality has a value which is a genome_quality_measure
contigs has a value which is a reference to a list where each element is a contig
features has a value which is a reference to a list where each element is a feature
close_genomes has a value which is a reference to a list where each element is a close_genome
analysis_events has a value which is a reference to a list where each element is an analysis_event

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
id has a value which is a genome_id
scientific_name has a value which is a string
domain has a value which is a string
genetic_code has a value which is an int
source has a value which is a string
source_id has a value which is a string
quality has a value which is a genome_quality_measure
contigs has a value which is a reference to a list where each element is a contig
features has a value which is a reference to a list where each element is a feature
close_genomes has a value which is a reference to a list where each element is a close_genome
analysis_events has a value which is a reference to a list where each element is an analysis_event


=end text

=back



=head2 subsystem

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 variant

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 variant_of_subsystem

=over 4



=item Definition

=begin html

<pre>
a reference to a list containing 2 items:
0: a subsystem
1: a variant

</pre>

=end html

=begin text

a reference to a list containing 2 items:
0: a subsystem
1: a variant


=end text

=back



=head2 variant_subsystem_pairs

=over 4



=item Definition

=begin html

<pre>
a reference to a list where each element is a variant_of_subsystem
</pre>

=end html

=begin text

a reference to a list where each element is a variant_of_subsystem

=end text

=back



=head2 fid

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 role

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 function

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 fid_role_pair

=over 4



=item Definition

=begin html

<pre>
a reference to a list containing 2 items:
0: a fid
1: a role

</pre>

=end html

=begin text

a reference to a list containing 2 items:
0: a fid
1: a role


=end text

=back



=head2 fid_role_pairs

=over 4



=item Definition

=begin html

<pre>
a reference to a list where each element is a fid_role_pair
</pre>

=end html

=begin text

a reference to a list where each element is a fid_role_pair

=end text

=back



=head2 fid_function_pair

=over 4



=item Definition

=begin html

<pre>
a reference to a list containing 2 items:
0: a fid
1: a function

</pre>

=end html

=begin text

a reference to a list containing 2 items:
0: a fid
1: a function


=end text

=back



=head2 fid_function_pairs

=over 4



=item Definition

=begin html

<pre>
a reference to a list where each element is a fid_function_pair
</pre>

=end html

=begin text

a reference to a list where each element is a fid_function_pair

=end text

=back



=head2 reconstructionTO

=over 4



=item Description

Metabolic reconstruction
represents the set of subsystems that we infer are present in this genome


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
subsystems has a value which is a variant_subsystem_pairs
bindings has a value which is a fid_role_pairs
assignments has a value which is a fid_function_pairs

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
subsystems has a value which is a variant_subsystem_pairs
bindings has a value which is a fid_role_pairs
assignments has a value which is a fid_function_pairs


=end text

=back



=head2 fid_data_tuple

=over 4



=item Definition

=begin html

<pre>
a reference to a list containing 4 items:
0: a fid
1: a md5
2: a location
3: a function

</pre>

=end html

=begin text

a reference to a list containing 4 items:
0: a fid
1: a md5
2: a location
3: a function


=end text

=back



=head2 fid_data_tuples

=over 4



=item Definition

=begin html

<pre>
a reference to a list where each element is a fid_data_tuple
</pre>

=end html

=begin text

a reference to a list where each element is a fid_data_tuple

=end text

=back



=head2 rna_type

=over 4



=item Description

[ validate.enum("5S", "SSU", "LSU", "ALL") ]


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 glimmer3_parameters

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
min_training_len has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
min_training_len has a value which is an int


=end text

=back



=head2 repeat_region_SEED_parameters

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
min_identity has a value which is a float
min_length has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
min_identity has a value which is a float
min_length has a value which is an int


=end text

=back



=head2 kmer_v1_parameters

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
kmer_size has a value which is an int
dataset_name has a value which is a string
return_scores_for_all_proteins has a value which is an int
score_threshold has a value which is an int
hit_threshold has a value which is an int
sequential_hit_threshold has a value which is an int
detailed has a value which is an int
min_hits has a value which is an int
min_size has a value which is an int
max_gap has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
kmer_size has a value which is an int
dataset_name has a value which is a string
return_scores_for_all_proteins has a value which is an int
score_threshold has a value which is an int
hit_threshold has a value which is an int
sequential_hit_threshold has a value which is an int
detailed has a value which is an int
min_hits has a value which is an int
min_size has a value which is an int
max_gap has a value which is an int


=end text

=back



=head2 kmer_v2_parameters

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
min_hits has a value which is an int
max_gap has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
min_hits has a value which is an int
max_gap has a value which is an int


=end text

=back



=cut

package Bio::KBase::GenomeAnnotation::Client::RpcClient;
use base 'JSON::RPC::Client';

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $obj) = @_;
    my $result;

    if ($uri =~ /\?/) {
       $result = $self->_get($uri);
    }
    else {
        Carp::croak "not hashref." unless (ref $obj eq 'HASH');
        $result = $self->_post($uri, $obj);
    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
