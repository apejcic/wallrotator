#import "AppDelegate.h"

#import "MenuController.h"

@implementation AppDelegate {
    MenuController *menu;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    menu = [[MenuController alloc] init];
}

@end
