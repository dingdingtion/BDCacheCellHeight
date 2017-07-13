//
//  BDNews.h
//  BDCacheCellHeight
//
//  Created by DingDing on 17/7/133.
//  Copyright © 2017年 874714529@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDNews : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
