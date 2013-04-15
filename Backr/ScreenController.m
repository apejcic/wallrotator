#import "ScreenController.h"

#import "Misc.h"

@implementation ScreenController


- (NSString*) screenResolution
{
    
    NSRect screenRect;
    NSArray *screenArray = [NSScreen screens];
    NSUInteger screenCount = [screenArray count];
    
    for (NSUInteger index = 0; index < screenCount; index++)
    {
        NSScreen *screen = [screenArray objectAtIndex: index];
        screenRect = [screen visibleFrame];
    }
    
    return [NSString stringWithFormat:@"%.1fx%.1f",screenRect.size.width, screenRect.size.height];
}

- (void) setWallpaper:(NSURL *)url forScreen:(NSScreen *)screen
{
    NSWorkspace *sws = [NSWorkspace sharedWorkspace];
//    NSDictionary *opt = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:NSImageScaleAxesIndependently], NSWorkspaceDesktopImageScalingKey, nil];
    
    NSError *err = nil;
    if ([sws setDesktopImageURL:url forScreen:screen options:nil error:&err] == NO)
        [NSException raise:@"Wallpaper set failed." format:@"Err: %@", [err localizedDescription]];
    
    NSURL *last = [Misc pathInApplicationDirectory:@"last"];
    if (![[url path] writeToFile:[last path] atomically:YES encoding:NSStringEncodingConversionAllowLossy error:&err])
        NSLog(@"Err %@", [err localizedDescription]);
}

- (void) setWallpaper:(NSURL *)url
{
    [self setWallpaper:url forScreen:[NSScreen mainScreen]];
}

- (void) setWallpaperForAllScreens:(NSURL *)url
{
    for (NSScreen *screen in [NSScreen screens]) {
        [self setWallpaper:url forScreen:screen];
    }
}

- (NSURL *) getLast
{
    NSURL *last = [Misc pathInApplicationDirectory:@"last"];
    NSString *path = [[NSString alloc] initWithContentsOfFile:[last path] usedEncoding:nil error:nil];
    NSURL *url;
    if (path)
        url = [NSURL fileURLWithPath:path];
    return url;
}

@end
