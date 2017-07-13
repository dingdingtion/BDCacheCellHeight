//
//  BDNews.m
//  BDCacheCellHeight
//
//  Created by DingDing on 17/7/133.
//  Copyright © 2017年 874714529@qq.com. All rights reserved.
//

#import "BDNews.h"

@implementation BDNews

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    self = [super init];
    
    if (self) {
        
        [self setValuesForKeysWithDictionary:dictionary];
        
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    // 异常数据处理
    
}

@end
