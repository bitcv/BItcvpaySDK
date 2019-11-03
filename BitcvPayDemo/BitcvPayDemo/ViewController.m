//
//  ViewController.m
//  BitcvPayDemo
//
//  Created by 姚 on 2019/6/12.
//  Copyright © 2019 姚. All rights reserved.
//

#import "ViewController.h"
#import <BitcvpaySDK/BitcvPayManager.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)toPayBtnClick:(id)sender {

    
    NSString* payOrder = [NSString stringWithFormat:@"appKey=bcvowqV8RxRONvy6&appName=111&outTradeNo=TEST%ld&productName=mahua&payTokenId=280&payTokenSymbol=BOCAI&payAmount=1&memo=bcvtest1&requestTs=1560326714&expireTs=1660326714",[NSDate date].timeIntervalSince1970];
    [self getSdkSign:payOrder];
}


-(void)getSdkSign:(NSString*)paramText{
    
    //请求地址
    NSURL *url = [NSURL URLWithString:@"https://api.bitcv.com/api/temp/getSdkSign"];
    
    //设置请求地址
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求方式
    request.HTTPMethod = @"POST";
    
    //设置请求参数
    request.HTTPBody = [paramText dataUsingEncoding:NSUTF8StringEncoding];
    //关于parameters是NSDictionary拼接后的NSString.关于拼接看后面拼接方法说明
    
    //设置请求session
    NSURLSession *session = [NSURLSession sharedSession];
    
    //设置网络请求的返回接收器
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {

                
            }
            else
            {

                NSError *error = nil;
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingAllowFragments
                                                                             error:&error];
                //解析成功
                if (error.code == 0) {
                 
                    NSString* sign = [[jsonObject objectForKey:@"data"] objectForKey:@"sign"];
                    
                    NSString* signText = [NSString stringWithFormat:@"%@&sdkSign=%@",paramText,sign];
                    
                    //如果字符串需要在服务器端拼写。
                    [[BitcvPayManager sharedBitcvPayManager] payOrder:signText urlScheme:@"BWbcvowqV8RxRONvy6" callback:^(NSDictionary *resultDic) {
                        
                        NSLog(@"%@",resultDic);
                        
                    }];
                }

                
            }
        });
    }];
    //开始请求
    [dataTask resume];
}

-(NSString *)parametersText:(NSDictionary *)parameters
{
    //创建可变字符串来承载拼接后的参数
    NSMutableString *parameterString = [NSMutableString new];
    //获取parameters中所有的key
    NSArray *parameterArray = parameters.allKeys;
    for (int i = 0;i < parameterArray.count;i++) {
        //根据key取出所有的value
        id value = parameters[parameterArray[i]];
        //把parameters的key 和 value进行拼接
        NSString *keyValue = [NSString stringWithFormat:@"%@=%@",parameterArray[i],value];
        if (i == parameterArray.count || i == 0) {
            //如果当前参数是最后或者第一个参数就直接拼接到字符串后面，因为第一个参数和最后一个参数不需要加 “&”符号来标识拼接的参数
            [parameterString appendString:keyValue];
        }else
        {
            //拼接参数， &表示与前面的参数拼接
            [parameterString appendString:[NSString stringWithFormat:@"&%@",keyValue]];
        }
    }
    return parameterString;
}

@end
