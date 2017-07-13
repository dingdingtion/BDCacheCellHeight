//
//  UITableView+BDCellHeightCacheDebug.h
//  Pods
//
//  Created by DingDing on 17/7/133.
//
//

#import <UIKit/UIKit.h>

@interface UITableView (BDCellHeightCacheDebug)

@property (nonatomic, assign) BOOL bd_debugLogEnabled;

- (void)bd_debugLog:(NSString *)message;

@end
