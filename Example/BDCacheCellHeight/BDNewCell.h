//
//  BDNewCell.h
//  BDCacheCellHeight
//
//  Created by DingDing on 17/7/133.
//  Copyright © 2017年 874714529@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDNews.h"

@interface BDNewCell : UITableViewCell

@property (nonatomic, strong) BDNews *news;

+ (UINib *)nib;

@end
