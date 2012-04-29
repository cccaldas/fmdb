@interface DateUtil : NSObject
{
	
}

+(NSDate *)dateWithString:(NSString *)date format:(NSString *)format locale:(NSLocale *)locale;
+(NSDate *)dateWithString:(NSString *)date format:(NSString *)format;

+(NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
+(NSString *)stringWithDate:(NSDate *)date format:(NSString *)format locale:(NSLocale *)locale;

+(BOOL)isToday:(NSDate *)date;

@end