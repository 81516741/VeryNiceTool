//
//  NSDate+Extension.m
//  1.新浪微博
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**把这个格式的字符串 Tue Oct 20 10:03:03 +0800 2015 转成中国的字符串*/

+(NSString *)localDateStingFromSina:(NSString * )string{
    
    NSDateFormatter * fm = [[NSDateFormatter alloc]init];
    fm.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    fm.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate * tempDate = [fm dateFromString:string];
    fm.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    NSString * dateSrting = [fm stringFromDate:tempDate];
    return  dateSrting;
    
}

/**返回这个 Tue Oct 20 10:03:03 +0800 2015 格式的字符串*/

+(NSString *)stringWithDate:(NSDate *)date
{
    NSDateFormatter * fm = [[NSDateFormatter alloc]init];
    fm.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    fm.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    return [fm stringFromDate:date];
}

/**把这个格式的字符串 Tue Oct 20 10:03:03 +0800 2015 转成date*/


+(NSDate *)localDateFromSina:(NSString *)string{
    
    NSDateFormatter * fm = [[NSDateFormatter alloc]init];
    fm.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    fm.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate * tempDate = [fm dateFromString:string];
    fm.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    NSString * dateSrting = [fm stringFromDate:tempDate];
    NSDate * date = [fm dateFromString:dateSrting];
    
    return  date;
}


/**获得 (这个格式2015.10.20 10:26:22) 当前date的字符串*/


+(NSString *)localDateString{
    
    NSDateFormatter * fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    NSDate * date = [NSDate date];
    NSString * nowDateString = [fm stringFromDate:date];
    return nowDateString;
}




/**返回一个字符串，它表示里创建时间的时间差*/

+(NSString *)timeIntervalFrom:(NSString *)creatDay{

    NSDate * nowDate = [NSDate date];
    NSDate * creatDate = [NSDate localDateFromSina:creatDay];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit  unit = NSCalendarUnitYear|NSCalendarUnitMonth;
    
    NSDateComponents * now =[calendar components:unit fromDate:nowDate];
    NSDateComponents * creat = [calendar components:unit fromDate:creatDate];
    NSCalendarUnit  unitInterval = NSCalendarUnitDay;
    
    NSDateComponents * timeInterval = [calendar components:unitInterval fromDate:creatDate toDate:nowDate options:0];
    
    
    if (now.year != creat.year) {
        
       return  [self timeIntervalForm:creatDay doSomethinng:^NSString *{
           
           return  @"yyyy年MM月dd日";

        }];
     
        
        
    }else if(now.month != creat.month){
        
      return   [self timeIntervalForm:creatDay doSomethinng:^NSString *{
          
                return  @"MM月dd日";
        
        }];

   
        
    }else{

                
        return  [self timeIntervalForm:creatDay doSomethinng:^NSString *{
                    
                     return [NSString stringWithFormat:@"%d天前",(int)timeInterval.day];
                }];
 
                
            }
    

}
//这个block接收使用者返回的参数，然后再将这个参数返回给使用者，我自己都佩服自己啦。因为现在看不懂啦，太牛B啦，我抽个这个出来就是不想看到重复代码
+(NSString *)timeIntervalForm:(NSString * )creatDay doSomethinng:(NSString *(^)()) doSomethinng{

    NSDate * nowDate = [NSDate date];
    NSDate * creatDate = [NSDate localDateFromSina:creatDay];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];

    NSCalendarUnit  unitInterval = NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    NSDateComponents * timeInterval = [calendar components:unitInterval fromDate:creatDate toDate:nowDate options:0];
    
    if (timeInterval.day >= 1) {
        
        NSDateFormatter * fm = [[NSDateFormatter alloc]init];
        //用着中方法传参数，第一次使用，不过感觉还是用的有意思
        fm.dateFormat = doSomethinng();

        NSString * dateString = [fm stringFromDate:[NSDate localDateFromSina:creatDay]];

        if (dateString.length) {
            return dateString;
        }else {
            return doSomethinng();
        }
        

        
    }else{
        
        if (timeInterval.hour) {
            
            return [NSString stringWithFormat:@"%d小时前",(int)timeInterval.hour];
            
        }else {
            
            if (timeInterval.minute > 10) {
                
                return [NSString stringWithFormat:@"%d分钟前",(int)timeInterval.minute];
            }else {
                return @"刚刚";
            }
            
        }
        
    }
    
    
}

+(NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter * fm = [[NSDateFormatter alloc]init];
    fm.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    fm.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    return [fm stringFromDate:date];
}


@end
