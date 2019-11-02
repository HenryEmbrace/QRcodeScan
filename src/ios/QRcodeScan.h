//
//  QRcodeScan.h
//  agentApp
//
//  Created by ZlHy on 2019/11/1.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "WCQRCodeVC.h"
NS_ASSUME_NONNULL_BEGIN
@class WCQRCodeVC;
@interface QRcodeScan : CDVPlugin
@property (strong, nonatomic) CDVInvokedUrlCommand* latestCommand;
@property (readwrite, assign) BOOL hasPendingOperation;
@property (strong, nonatomic) WCQRCodeVC *WCVC;
-(void)ScanMethod:(CDVInvokedUrlCommand*)command;
-(void)capturedQRcodeScanWithString:(NSString*)str;
-(void) dismissQRViewController;


@end

NS_ASSUME_NONNULL_END
