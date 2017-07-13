//
//  UITableView+BDIndexPathHeightCache.h
//  Pods
//
//  Created by DingDing on 17/7/133.
//
//

#import <UIKit/UIKit.h>
#import "UITableView+BDCellHeightCacheDebug.h"

@interface BDIndexPathHeightCache : NSObject

- (BOOL)existsHeightAtIndexPath:(NSIndexPath *)indexPath;
- (void)cacheHeight:(CGFloat)height byIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;

- (void)invalidateHeightAtIndexPath:(NSIndexPath *)indexPath;
- (void)invalidateAllHeightCache;

@end




@interface UITableView (BDIndexPathHeightCache)

@property (nonatomic, strong, readonly) BDIndexPathHeightCache *bd_indexPathHeightCache;

- (void)startHeightCache;

@end
