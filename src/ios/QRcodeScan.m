//
//  QRcodeScan.m
//  agentApp
//
//  Created by ZlHy on 2019/11/1.
//

#import "QRcodeScan.h"

@implementation QRcodeScan
-(void)ScanMethod:(CDVInvokedUrlCommand*)command{
    self.latestCommand = command;
    WCQRCodeVC *WCVC = [[WCQRCodeVC alloc] init];
    [self QRCodeScanVC:WCVC];
}


- (void)QRCodeScanVC:(UIViewController *)scanVC {
    
    __weak QRcodeScan* weakSelf = self;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
//                            [self.navigationController pushViewController:scanVC animated:YES];
                            [weakSelf.viewController presentViewController:scanVC animated:YES completion:nil];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
//                [self.navigationController pushViewController:scanVC animated:YES];
                [self.viewController presentViewController:scanVC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [weakSelf.viewController presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [weakSelf.viewController presentViewController:alertC animated:YES completion:nil];
}


-(void)capturedQRcodeScanWithString:(NSString*)str {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:str] callbackId:self.latestCommand.callbackId];
        // Unset the self.hasPendingOperation property
        self.hasPendingOperation = NO;
    
    // Hide the picker view
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}



@end
