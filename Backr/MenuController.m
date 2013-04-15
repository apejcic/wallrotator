#import "MenuController.h"

#import "ScreenController.h"

@implementation MenuController {
    NSStatusItem *statusItem;
    ApiController *api;
    FileDownloader *downloader;
    ScreenController *screen;
}

- (id) init
{
    self = [super init];
    if (self) {
        api = [[ApiController alloc] initWithDelegate:self];
        downloader = [[FileDownloader alloc] initWithTarget:self];
        screen = [[ScreenController alloc] init];

        NSMenu *menu = [[NSMenu allocWithZone:[NSMenu menuZone]] init];

        [[menu addItemWithTitle:@"Random" action:@selector(random:) keyEquivalent:@""] setTarget:self];
        [menu addItem:[NSMenuItem separatorItem]];
        [[menu addItemWithTitle:@"Quit" action:@selector(quit:) keyEquivalent:@""] setTarget:self];

        statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
        [statusItem setMenu:menu];
        [statusItem setImage:[NSImage imageNamed:@"status_16x16"]];
        [statusItem setHighlightMode:true];

    }
    return self;
}

- (void) random:(id)sender
{
    [api fetchRandom];
}

- (void) quit:(id)sender
{
    [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0.0];
}


- (void) newWallpaperUrl:(NSString *)url
{
    NSLog(@"Got new url %@", url);
    [downloader download:[[NSURL alloc] initWithString:url]];
    
}

- (void) fileDownloaded:(NSURL *)url
{
    NSLog(@"Setting new wallpaper %@", url);
    [screen setWallpaper:url];
}

@end
