//
//  NSString+Extension.m
//  LYFaultDiagnosis
//
//  Created by YNKJMACMINI2 on 15/11/20.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Size)
-(CGFloat)widthWithFont:(UIFont *)f
{
    NSDictionary *attribute = @{NSFontAttributeName:f};
    
    CGFloat stringWidth = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, f.lineHeight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.width;
    return stringWidth;
    
}
-(CGFloat)heightWithFont:(UIFont *)f maxWidth:(CGFloat)mWidth
{
    NSDictionary *attribute = @{NSFontAttributeName:f};
    CGFloat stringHeight = [self boundingRectWithSize:CGSizeMake(mWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;
    return stringHeight;
}

- (CGSize)labelAutoCalculateRectWith:(NSString *)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}


-(NSArray<NSString *> *)separatedWithString:(NSString *)separatedString
{
    if ([self isEqualToString:@""]||self == nil) {
        return [[NSArray alloc]init];
    } else {
        NSArray<NSString *> *stringArray = [self componentsSeparatedByString:separatedString];
        return stringArray;
    }
   
}
@end

@implementation NSString (Date)
+(NSDate *)dataWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:self];
    return date;
}
-(NSURL *)ToUrl{
    NSString *base = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,self];
    return [NSURL URLWithString:base];
}
@end
