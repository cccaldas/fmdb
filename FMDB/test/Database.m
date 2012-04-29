//
//  Database.m
//  FMDB
//
//  Created by Cristiano Coutinho Caldas on 4/29/12.
//  Copyright (c) 2012 Simbionte Studios. All rights reserved.
//

#import "Database.h"
#import "Product.h"

static Database *_instance;

@implementation Database

-(void)setup {
	
}

-(void)create {
	[super create];
	
	self.logsErrors = YES;
	
	[Product createTable];
}

+(Database *)getInstance {
	if(!_instance) {
		
		NSArray *paths					= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory	= [paths objectAtIndex:0];
		NSString *path = [[NSString alloc]initWithString:[documentsDirectory stringByAppendingPathComponent:@"database.db"]];
		
		_instance = [[self databaseWithPath:path] retain];
		[_instance setup];
	}
	
	return _instance;
}

@end
