/*
 DataEvent.h
 Geleca
 
 Created by Cristiano Coutinho Caldas on 4/7/12.
 Copyright (c) 2012 Simbionte Studios. All rights reserved.
 */

#import "Event.h"

@interface DataEvent : Event {
	
}

@property (nonatomic, strong) id data;

-(id)initWithType:(NSString *)type data:(id)_data;
+(id)withType:(NSString *)type data:(id)_data;

@end

