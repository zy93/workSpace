//
//  WOTUitls.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTUitls.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WOTUitls



+ (NSString *)md5HexDigestByString:(NSString*)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
   	return [self md5HexDigestByData:data];
}

+ (NSString *)md5HexDigestByData:(NSData*)input
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( input.bytes, (CC_LONG)input.length, result );
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

@end
