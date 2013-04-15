#import <Foundation/Foundation.h>

@protocol FileDownloaderDelegate <NSObject>

- (void) fileDownloaded:(NSURL *)path;

@end

@interface FileDownloader : NSObject<NSURLConnectionDelegate>

- (id) initWithTarget:(id<FileDownloaderDelegate>)delegate;
- (id) initWithTarget:(id<FileDownloaderDelegate>)delegate withUrl:(NSURL *)url;

- (void) download:(NSURL *)url;

@property id<FileDownloaderDelegate> delegate;

@end
