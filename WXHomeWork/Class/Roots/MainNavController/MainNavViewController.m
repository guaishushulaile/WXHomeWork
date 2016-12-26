//
//  MainNavViewController.m
//  WXHomeWork
//
//  Created by 王新 on 2016/12/20.
//  Copyright © 2016年 王新. All rights reserved.
//

#import "MainNavViewController.h"

@interface MainNavViewController ()

@end

@implementation MainNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 自定义导航栏样式
    [self setCustomNavigationBarAttribute];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCustomNavigationBarAttribute
{   // nav背景色
    self.navigationBar.barTintColor = [UIColor orangeColor];
    
    // 字体设置
    NSMutableDictionary *titleAttrs = [NSMutableDictionary dictionary];
    titleAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // titleAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:24];
    self.navigationBar.titleTextAttributes = titleAttrs;
    
    // 系统滑动手势设置
    //    self.interactivePopGestureRecognizer.enabled = YES;
    //    self.interactivePopGestureRecognizer.delegate =(id)self;
    
    // 去掉导航栏蒙版
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 替换下边线
    self.navigationBar.shadowImage = [UIImage imageNamed:@"line"];//设置导航栏下边线为灰色（图）
}

//重写
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 自动隐藏tabbar
//        [viewController setHidesBottomBarWhenPushed:YES];
        // 设置leftBarButton
        viewController.navigationItem.leftBarButtonItem = [self itemWithTarget:self action:@selector(back) image:@"fanhui" highImage:@"fanhui"];
        // 设置rightBarButton
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        }
    
    [super pushViewController:viewController animated:animated];
}

//返回事件
- (void)back
{
    [self popViewControllerAnimated:YES];
}

//leftBarButtonItem样式设置
- (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    /**
     *  设置返回barButton
     */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置尺寸
    btn.frame = CGRectMake(0, 0, 44, 44);
    // 添加事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
//    [btn setBackgroundColor:[UIColor redColor]];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
