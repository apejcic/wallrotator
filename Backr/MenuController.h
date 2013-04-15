#import <Foundation/Foundation.h>

#import "ApiController.h"
#import "FileDownloader.h"

@interface MenuController : NSObject<WallrApiDelegate, FileDownloaderDelegate>

@end
