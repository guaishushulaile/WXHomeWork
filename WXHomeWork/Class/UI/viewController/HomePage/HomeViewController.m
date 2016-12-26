//
//  HomeViewController.m
//  WXHomeWork
//
//  Created by 王新 on 2016/12/20.
//  Copyright © 2016年 王新. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h" // cell
#import "HomePageResponseModle.h"// 返回模型

@interface HomeViewController ()
{
    NSMutableArray *arrData;
}
// 主tableView
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //清除缓存图片
//    [[SDImageCache sharedImageCache] cleanDisk];
    
    //不显示多余分割线
    _mainTableView.tableFooterView = [[UITableView alloc] init];
    // 初始化数据数组
    arrData = [NSMutableArray arrayWithCapacity:10];
    //预设cell的高度；
    _mainTableView.estimatedRowHeight = 140;
    // 刷新界面
    [self setReflsh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //复用
    static NSString *homeCellIdentifier = @"HomeTableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellIdentifier];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:nil options:nil] lastObject];
    }
    //数据显示到界面
    if (arrData.count > 0) {
        HomeListModel *model = arrData[indexPath.row];
        cell.TitleLab.text = model.title;
        cell.contentLab .text = model.homeDescription;
        if ([[NSString stringWithFormat:@"%@",model.imageHref] isBlankString]) {// 图片地址为空
            // 图片不显示
            cell.matchImage.hidden = YES;
            // contentLab的TrailConstrant尺寸设为8
            cell.contentTrailConstrant.constant = 8;
            
            //contentLab的尺寸 >= 0
            NSLayoutConstraint *heightConstraint1 = [NSLayoutConstraint constraintWithItem:cell.contentLab attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f];
            heightConstraint1.active = YES;
        }else{// 图片地址不为空
            //contentLab的尺寸 >= 77
            NSLayoutConstraint *heightConstraint2 = [NSLayoutConstraint constraintWithItem:cell.contentLab attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:77.0f];
            heightConstraint2.active = YES;
            
            //用SDWebImage加载图片
            [cell.matchImage sd_setImageWithURL:[NSURL URLWithString:model.imageHref] placeholderImage:[UIImage imageNamed:@"error.jpg"]];
        }
        
    }
    
    return cell;
}

//刷新
- (void)setReflsh {
    //头部刷新
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        {
            [self wx_sendGetRequstWithURL:HTTP withPostContent:nil withSuccess:^(NSURLSessionDataTask *task, id responseObject) {
//                    NSLog(@"response === %@",responseObject);
                //返回数据处理
                HomePageResponseModle *responseModel = [HomePageResponseModle mj_objectWithKeyValues:responseObject];
                //清除原有数据
                [arrData removeAllObjects];
                //重新添加数据
                [arrData addObjectsFromArray:responseModel.rows];
                // 设置标题
                self.title = responseModel.homeTitle;
                //刷新列表数据
                [_mainTableView reloadData];
                [_mainTableView.mj_header endRefreshing];
            } withFailure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
                [self netWorkErrorWith:error];
                [_mainTableView.mj_header endRefreshing];
            }];
        }
    }];
    //脚部刷新
    _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        {
            [self wx_sendGetRequstWithURL:HTTP withPostContent:nil withSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"response === %@",responseObject);
                //返回数据处理
                HomePageResponseModle *responseModel = [HomePageResponseModle mj_objectWithKeyValues:responseObject];
                //重新赋值
                NSArray *arrDataFooter = [NSArray arrayWithArray:responseModel.rows];
                if (arrDataFooter.count>arrData.count) {
                    [arrData removeAllObjects];
                    [arrData addObjectsFromArray:arrDataFooter];
                }else{
                    //上拉加载无数据／NoMoreData
                    [_mainTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [_mainTableView reloadData];
                [_mainTableView.mj_header endRefreshing];
                
            } withFailure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
                [self netWorkErrorWith:error];
                [_mainTableView.mj_header endRefreshing];
            }];
            
        }
    }];
    [_mainTableView.mj_header beginRefreshing];
}

@end
