//
//  UITableView+BDCellHeightCacheDebug.m
//  Pods
//
//  Created by DingDing on 17/7/133.
//
//

#import "UITableView+BDCellHeightCacheDebug.h"
#import <objc/runtime.h>

@implementation UITableView (BDCellHeightCacheDebug)

- (BOOL)bd_debugLogEnabled{
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setBd_debugLogEnabled:(BOOL)bd_debugLogEnabled{
    
    objc_setAssociatedObject(self, @selector(bd_debugLog:), @(bd_debugLogEnabled), OBJC_ASSOCIATION_RETAIN);
    
}

- (void)bd_debugLog:(NSString *)message{
    
//    if (self.bd_debugLogEnabled) {
    
        NSLog(@"** BDCellCache ** %@", message);
        
//    }
    
}



@end
