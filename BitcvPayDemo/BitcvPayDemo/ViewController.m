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

    //如果字符串需要在服务器端拼写。
    NSString* payOrder = [NSString stringWithFormat:@"appKey=&appName=111&outTradeNo=TEST%ld&productName=mahua&payTokenId=280&payTokenSymbol=BOCAI&payAmount=1&memo=bcvtest1&requestTs=1560326714&expireTs=1660326714&sdkSign=64ffe46d4d7dcfc720440bd58a3a940e",[NSDate date].timeIntervalSince1970];
    
    [[BitcvPayManager sharedBitcvPayManager] payOrder:payOrder urlScheme:@"BitcvPayDemo" callback:^(NSDictionary *resultDic) {
       
        NSLog(@"%@",resultDic);
        
    }];
}


@end
