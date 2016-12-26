//
//  WXBaseViewController.h
//  WXHomeWork
//
//  Created by 王新 on 2016/12/20.
//  Copyright © 2016年 王新. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WXBaseViewController : UIViewController


#pragma mark -网络组件
/**
 *  发送一个POST
 *
 *  @param url         HTTP地址
 *  @param postContent 要上传的内容
 *  @param success     成功    responseObject 为JSon结构
 *  @param failure      失败
 */
-(NSURLSessionDataTask *)wx_SendPostRequstWithURL:(NSString *)url withPostContent:(NSDictionary *)postContent withSuccess:(void (^)(NSURLSessionDataTask *  task, id responseObject))success withFailure:(void (^)(NSURLSessionDataTask *  task, NSError *  error))failure;
/**
 *  发送一个GET
 *
 *  @param url         HTTP地址
 *  @param postContent 要上传的内容
 *  @param success     成功    responseObject 为JSon结构
 *  @param failure      失败
 */
-(NSURLSessionDataTask *)wx_sendGetRequstWithURL:(NSString *)url withPostContent:(NSDictionary *)postContent withSuccess:(void (^)(NSURLSessionDataTask * task, id responseObject))success withFailure:(void (^)(NSURLSessionDataTask * task,NSError * error))failure;

/**
 *  网络错误时候的提示
 */
- (void)netWorkErrorWith:(NSError *)error;


@end
