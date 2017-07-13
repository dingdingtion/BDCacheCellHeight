//
//  BDViewController.m
//  BDCacheCellHeight
//
//  Created by 874714529@qq.com on 07/13/2017.
//  Copyright (c) 2017 874714529@qq.com. All rights reserved.
//

#import "BDViewController.h"
#import <BDCacheCellHeight/UITableView+BDIndexPathHeightCache.h>
#import "BDNews.h"
#import "BDNewCell.h"

@interface BDViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *datasourceFromJson;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation BDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    
    
    self.tableView.bd_debugLogEnabled = YES;
    [self.tableView startHeightCache];

    
    [self buildTestDataThen:^{
        
        self.datasource = @[].mutableCopy;

        [self.datasource addObjectsFromArray:self.datasourceFromJson.mutableCopy];
        
        [self.tableView reloadData];
        
    }];

}

- (void)buildTestDataThen:(void (^)(void))thenBlock{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        
        NSArray *source = rootDic[@"news"];
        
        
        NSMutableArray *entities = @[].mutableCopy;
        
        [source enumerateObjectsUsingBlock:^(NSDictionary  *_Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            
            BDNews *news = [[BDNews alloc] initWithDictionary:dic];
            
            [entities addObject:news];
            
        }];
        
        
        self.datasourceFromJson = entities;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (thenBlock) {
                thenBlock();
            }
            
        });
        
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BDNewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BDNewCell class]) forIndexPath:indexPath];
    
    cell.news = self.datasource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return UITableViewAutomaticDimension;
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        [_tableView registerNib:[BDNewCell nib] forCellReuseIdentifier:NSStringFromClass([BDNewCell class])];
        
//        _tableView.estimatedRowHeight = 80;
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
    }
    
    return _tableView;
}

@end
