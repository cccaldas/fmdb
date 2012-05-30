/*
 DataEvent.m
 Geleca
 
 Created by Cristiano Coutinho Caldas on 4/7/12.
 Copyright (c) 2012 Cristiano Coutinho Caldas. All rights reserved.
 */

#import "DataEvent.h"

@implementation DataEvent

@synthesize data;

-(id)initWithType:(NSString *)_type data:(id)_data {
	if((self = [super init])){
		self.type = _type;
		self.data = _data;
	}

	return self;
}

+(id)withType:(NSString *)type data:(id)_data {
	return [[[DataEvent alloc] initWithType:type data:_data] autorelease];
}

@end
