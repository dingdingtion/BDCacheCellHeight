//
//  UITableView+BDIndexPathHeightCache.m
//  Pods
//
//  Created by DingDing on 17/7/133.
//
//

#import "UITableView+BDIndexPathHeightCache.h"
#import <objc/runtime.h>

@interface BDIndexPathHeightCache ()

@property (nonatomic, strong) NSMutableDictionary *pathHeightCacheDic;

@end

@implementation BDIndexPathHeightCache

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.pathHeightCacheDic = [[NSMutableDictionary alloc] init];
        
    }
    
    return self;
    
}

- (BOOL)existsHeightAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.pathHeightCacheDic.allKeys containsObject:[self indexPathToString:indexPath]]){
        
        return YES;
    }
    
    return NO;
}

- (void)cacheHeight:(CGFloat)height byIndexPath:(NSIndexPath *)indexPath{
    
    [self.pathHeightCacheDic setValue:[NSNumber numberWithFloat:height] forKey:[self indexPathToString:indexPath]];
}

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *number = [self.pathHeightCacheDic valueForKey:[self indexPathToString:indexPath]];
    
    return number.floatValue;
}

- (void)invalidateHeightAtIndexPath:(NSIndexPath *)indexPath
{
    [self.pathHeightCacheDic removeObjectForKey:[self indexPathToString:indexPath]];
}

- (void)invalidateAllHeightCache{
    [self.pathHeightCacheDic removeAllObjects];
}

- (NSString *)indexPathToString:(NSIndexPath *)indexPath{
    
    return [NSString stringWithFormat:@"%@", indexPath];
}

@end


@implementation UITableView (BDIndexPathHeightCache)
/*
 * Hook delegate Method
 */
- (void)startHeightCache{
    
    NSAssert(self.delegate != nil, @"delegate must be setted, before hook");
    
    if (self.estimatedRowHeight == 0)
    {
        self.estimatedRowHeight = 44;
    }
    
    [self hookDelegate];
}

- (void)hookDelegate{
    
    /// delegate method change
    SEL selectors[] = {
        @selector(tableView:didEndDisplayingCell:forRowAtIndexPath:),
        @selector(tableView:heightForRowAtIndexPath:)
    };
    
    for (NSUInteger index = 0;  index < sizeof(selectors) / sizeof(SEL); index++) {
        
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"bd_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);

        /// [issue:] originalSelector 可能没有，需要自行创建
        if ([self.delegate respondsToSelector:originalSelector] == false) {
            
            NSString *error = [NSString stringWithFormat:@"%@ must be implation", NSStringFromSelector(originalSelector)];
            
            NSAssert(NO, error);
            
            /*
            IMP currentRowHeightImp = method_getImplementation(swizzledMethod);
            const char *type = method_getTypeEncoding(swizzledMethod);
            
            class_addMethod([self.delegate class], originalSelector, currentRowHeightImp, type);
             */
        }
        
        Method originalMethod = class_getInstanceMethod([self.delegate class], originalSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)bd_tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0){
    
    [tableView.bd_indexPathHeightCache cacheHeight:CGRectGetHeight(cell.frame) byIndexPath:indexPath];
    
    [tableView bd_debugLog:[NSString stringWithFormat:@"缓存高度%f  indexPath:%@", CGRectGetHeight(cell.frame), indexPath]];
}

- (CGFloat)bd_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /// [bug fix] 方法交换的仅仅是 IMP recevier 并没有发生改变 所以此处 self 为 delegate ,现将其修改为 tableview
    if ([tableView.bd_indexPathHeightCache existsHeightAtIndexPath:indexPath])
    {
        CGFloat height = [tableView.bd_indexPathHeightCache heightForIndexPath:indexPath];
        
        [tableView bd_debugLog:[NSString stringWithFormat:@"获取缓存高度%f  indexPath:%@", height, indexPath]];

        return height;
    }
    
    [tableView bd_debugLog:@"系统自动计算高度"];

    
    return UITableViewAutomaticDimension;
}

- (BDIndexPathHeightCache *)bd_indexPathHeightCache{
    
    BDIndexPathHeightCache *cache = objc_getAssociatedObject(self, _cmd);
    
    if (!cache) {
        
        cache = [BDIndexPathHeightCache new];
        
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    return cache;
}

@end
