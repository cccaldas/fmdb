/*
	Event.m
	Geleca
	
	Created by Cristiano Coutinho Caldas on 4/6/12.
	Copyright (c) 2012 Cristiano Coutinho Caldas. All rights reserved.
*/

#import "Event.h"

@implementation Event

@synthesize target, type;

-(id)initWithType:(NSString *)_type {
	if((self = [super init])){
		self.type = _type;
	}
	
	return self;
}

+(id)withType:(NSString *)type {
	return [[[Event alloc] initWithType:type] autorelease];
}

+(NSString *)COMPLETE	{ return @"complete"; }
+(NSString *)CHANGE		{ return @"change"; }
+(NSString *)CANCEL		{ return @"cancel"; }
+(NSString *)SELECT		{ return @"select"; }
+(NSString *)ADD		{ return @"add"; }

@end
