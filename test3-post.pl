# This code converts an url to pdf in Perl using SelectPdf REST API through a POST request. 
# The parameters are JSON encoded.
# The content is saved into a file on the disk.

use LWP::UserAgent;
use JSON;

my $api_endpoint = 'http://selectpdf.com/api2/convert/';
my $key = 'your license key here';
my $test_url = 'http://selectpdf.com';
my $local_file = 'test.pdf';
 
# parameters - add here any needed API parameter 
my $parameters = {
	'key' => $key,
	'url' => $test_url
};

print "Calling $api_endpoint\n\n";

$request = HTTP::Request->new(POST => $api_endpoint);
$request->header('Content-Type' => 'application/json');
$request->content(encode_json $parameters);
$ua = LWP::UserAgent->new;
$response = $ua->request($request);

if ($response->is_success) {
	my $file = IO::File->new( $local_file, '>' ) or die "Unable to open output file - $!\n";
	$file->binmode;
	$file->print( $response->decoded_content );
	$file->close;

    print "Test pdf document generated successfully!\n";
}
else {
    print "HTTP Response Code: ", $response->code, "\n";
    print "HTTP Response Message: ", $response->message, "\n";
    #print $response->status_line, "\n";
}

	