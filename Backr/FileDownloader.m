#import "FileDownloader.h"

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
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
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
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{    
    NSURL *path = [[self applicationDirectory] URLByAppendingPathComponent:@"background"];
    
    NSError* err = nil;
    [receivedData writeToURL:path options:NSDataWritingAtomic error:&err];
    
    [delegate fileDownloaded:path];
}

- (NSURL*)applicationDirectory
{
    NSString* bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSFileManager* fm = [NSFileManager defaultManager];
    NSURL* dirPath = nil;
    
    NSArray* appSupportDir = [fm URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
    if ([appSupportDir count] > 0)
    {
        dirPath = [[appSupportDir objectAtIndex:0] URLByAppendingPathComponent:bundleID];

        NSError*    theError = nil;
        if (![fm createDirectoryAtURL:dirPath withIntermediateDirectories:YES attributes:nil error:&theError]) {
            // TODO: mkdir
            return nil;
        }
    }
    return dirPath;
}

@end
