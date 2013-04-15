#import <Foundation/Foundation.h>

@interface ScreenController : NSObject

- (void) setWallpaper:(NSURL *)url;
- (void) setWallpaper:(NSURL *)url forScreen:(NSScreen *)screen;
- (void) setWallpaperForAllScreens:(NSURL *)url;

- (NSURL *) getLast;

@end
