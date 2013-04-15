#import "ScreenController.h"

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

- (void) setWallpaper:(NSURL *)url
{
    [[NSWorkspace sharedWorkspace] setDesktopImageURL:url forScreen:[NSScreen mainScreen] options:nil error:nil];
}

@end
