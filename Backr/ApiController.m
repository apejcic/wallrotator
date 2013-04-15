#import "ApiController.h"

@implementation ApiController {
    NSMutableData *receivedData;
    NSURLConnection *con;
}

const NSString *serverUrl = @"http://glacial-inlet-1735.herokuapp.com/wallr/"; // @"http://localhost:3000/wallr/";

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        receivedData = [[NSMutableData alloc] init];
    }
    return self;
}

- (id)initWithDelegate:(id<WallrApiDelegate>)_delegate;
{
    self = [self init];
    if (self) {
        self.delegate = _delegate;
    }
    return self;
}

- (void)fetchRandom
{
    NSString *url = [NSString stringWithFormat:@"%@random?size=1920x1200", serverUrl];
    NSLog(@"Fetching: %@", url);
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    con = [[NSURLConnection alloc] initWithRequest:req delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError* err;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:&err];
    if (jsonData) {
        [self.delegate newWallpaperUrl:[jsonData objectForKey:@"url"]];
    } else {
        [NSException raise:@"JSON parse failed." format:@"Err: %@", [err localizedDescription]];
    }
    
}

@end
