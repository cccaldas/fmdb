/*
	Event.h
	Geleca
	
	Created by Cristiano Coutinho Caldas on 4/6/12.
	Copyright (c) 2012 Cristiano Coutinho Caldas. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface Event : NSObject {
	
}

@property (nonatomic, strong) id target;
@property (nonatomic, strong) NSString *type;

-(id)initWithType:(NSString *)type;
+(id)withType:(NSString *)type;

//constants
+(NSString *)COMPLETE;
+(NSString *)CHANGE;
+(NSString *)CANCEL;
+(NSString *)SELECT;
+(NSString *)ADD;


@end
