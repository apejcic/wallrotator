#import <Foundation/Foundation.h>

@protocol WallrApiDelegate <NSObject>

- (void)newWallpaperUrl:(NSURL *)url;

@end

@interface ApiController : NSObject<NSURLConnectionDelegate>

- (id)initWithDelegate:(id<WallrApiDelegate>)delegate;
- (void)fetchRandom;

@property id<WallrApiDelegate> delegate;

@end
