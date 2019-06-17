//
//  BitcvPayManager.h
//  BitcvPay
//
//  Created by 姚 on 2019/6/12.
//  Copyright © 2019 姚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(NSDictionary *resultDic);
@class UIApplication;
@interface BitcvPayManager : NSObject
+ (instancetype)sharedBitcvPayManager;
/**
 * 是否安装了币威钱包
 */
-(BOOL)isInstallBitcvWallet;
/**
 *  orderString 订单信息+签名
 *
 *  urlScheme 币威钱包回调的urlScheme，该urlScheme要和币威提供的保持一致。
 */
-(void)payOrder:(NSString*)orderString urlScheme:(NSString*)urlScheme callback:(CompletionBlock)completionBlock;

/**
 *  获得从sso或者web端回调到本app的回调
 *
 *  @param url               第三方sdk的打开本app的回调的url
 *  @param sourceApplication 回调的源程序
 *  @param annotation        annotation
 *
 *  @return 是否处理  YES代表处理成功，NO代表不处理
 *
 *  @note 此函数在6.3版本加入
 */
-(BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/**
 *  获得从sso或者web端回调到本app的回调
 *
 *  @param url     第三方sdk的打开本app的回调的url
 *  @param options 回调的参数
 *
 *  @return 是否处理  YES代表处理成功，NO代表不处理
 *
 *  @note 此函数在6.3版本加入
 */
-(BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary*)options;

/**
 *  获取当前SDK版本号
 */
-(NSString*)currentVersion;
@end
