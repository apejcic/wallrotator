#import "FileDownloader.h"

#import "Misc.h"

@implementation FileDownloader {
    NSMutableData *receivedData;
    NSURLConnection *con;
}

@synthesize delegate;

- (id) init
{
    self = [super init];
    if (self) {
        receivedData = [[NSMutableData alloc] init];
    }
    return self;
}

- (id) initWithTarget:(id<FileDownloaderDelegate>)_delegate
{
    self = [self init];
    if (self) {
        self.delegate = _delegate;
    }
    return self;
}

- (id) initWithTarget:(id<FileDownloaderDelegate>)_delegate withUrl:(NSURL *)url
{
    self = [self initWithTarget:_delegate];
    if (self) {
        [self download:url];
    }
    return self;
}

- (void) download:(NSURL *)url
{
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
    NSNumber *timeStampObj = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    NSString *filename = [NSString stringWithFormat:@"Wallrotator-%@", timeStampObj];
    NSURL *path = [Misc pathInApplicationDirectory:filename];
    
    NSError* err = nil;
    if ([receivedData writeToURL:path options:NSDataWritingAtomic error:&err]) {
        NSLog(@"Successfully wrote file to %@", path);
        [delegate fileDownloaded:path];
    } else
        [NSException raise:@"File write failed." format:@"Err: %@", [err localizedDescription]];
}


@end
