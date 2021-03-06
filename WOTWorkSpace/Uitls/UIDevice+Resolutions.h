//
//  UIDevice+Resolutions.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    UIDeviceResolution_Unknown          = 0,
    UIDeviceResolution_iPhoneStandard   = 1,    // iPhone 1,3,3GS Standard Display    (320x480px)
    UIDeviceResolution_iPhoneRetina35   = 2,    // iPhone 4,4S Retina Display 3.5"    (640x960px)
    UIDeviceResolution_iPhoneRetina4    = 3,    // iPhone 5 Retina Display 4"         (640x1136px)
    UIDeviceResolution_iPhoneRetina47    = 4,    // iPhone 6 Retina Display 4.7"      (750x1334px)
    UIDeviceResolution_iPhoneRetina55    = 5,    // iPhone 6 plus Retina Display 5.5" (1242x2208px)
    UIDeviceResolution_iPadStandard     = 6,    // iPad 1,2,mini Standard Display     (1024x768px)
    UIDeviceResolution_iPadRetina       = 7     // iPad 3 Retina Display              (2048x1536px)
};
typedef NSUInteger UIDeviceResolution;

@interface UIDevice (Resolutions)

-(UIDeviceResolution)resolution;

NSString *NSStringFromResolution(UIDeviceResolution resolution);

@end
