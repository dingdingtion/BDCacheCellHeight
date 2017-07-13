//
//  BDNewCell.m
//  BDCacheCellHeight
//
//  Created by DingDing on 17/7/133.
//  Copyright © 2017年 874714529@qq.com. All rights reserved.
//

#import "BDNewCell.h"

@interface BDNewCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *contenLabel;


@end

@implementation BDNewCell

+ (UINib *)nib{
    
    return [UINib nibWithNibName:@"BDNewCell" bundle:nil];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNews:(BDNews *)news{
    
    _news = news;
    
    self.titleLabel.text  = _news.title;
    self.contenLabel.text = _news.content;
        
}

@end
