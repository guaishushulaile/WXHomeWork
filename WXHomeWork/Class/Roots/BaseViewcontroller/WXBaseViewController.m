//
//  WXBaseViewController.m
//  WXHomeWork
//
//  Created by 王新 on 2016/12/20.
//  Copyright © 2016年 王新. All rights reserved.
//

#import "WXBaseViewController.h"

@interface WXBaseViewController ()
{
    AFHTTPSessionManager *manager;
}

@end

@implementation WXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    [self initAFHTTPSessionManager];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//INIT
-(void)initAFHTTPSessionManager
{
    manager = [AFHTTPSessionManager manager];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
}
//END
-(void)endAllAFHTTPRequest
{
    //取消对列中的请求
    [manager invalidateSessionCancelingTasks:YES];
}

//POST
-(NSURLSessionDataTask *)wx_SendPostRequstWithURL:(NSString *)url withPostContent:(NSDictionary *)postContent withSuccess:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success withFailure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    //返回数据为二进制
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求数据为二进制
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

    NSURLSessionDataTask *task  = [manager POST:url parameters:postContent progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if (success) {
            success(task, [responseObject NSDataToNSDictionary]);
        }
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    
    return task;
}

//GET
-(NSURLSessionDataTask *)wx_sendGetRequstWithURL:(NSString *)url withPostContent:(NSDictionary *)postContent withSuccess:(void (^)(NSURLSessionDataTask * task, id responseObject))success withFailure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure
{
    // 请求数据为二进制
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 申明返回的结果是json类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //返回数据为二进制
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];


    NSURLSessionDataTask *task = [manager GET:url parameters:postContent progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject){
        
        if (success) {
            success(task, [responseObject NSDataToNSDictionary]);
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    
    return task;
}

/**
 *  网络错误时候的提示
 */
- (void)netWorkErrorWith:(NSError *)error {
    if (-1009 == error.code) {
        [self.view makeToast:@"似乎已断开与互联网的连接"];
    }
    else if (-1001 == error.code) {
        [self.view makeToast:@"请求超时"];
    }
    else if (-1004 == error.code) {
        [self.view makeToast:@"网络请求失败:无法连接服务器"];
    }
    else {
        [self.view makeToast:@"网络请求失败:未知错误"];
    }
}


-(void)dealloc{
    ///取消对列中的请求
    [self endAllAFHTTPRequest];
}


@end
