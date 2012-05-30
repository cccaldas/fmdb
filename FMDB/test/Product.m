/*
	Product.m
	FMDB
	
	Created by Cristiano Coutinho Caldas on 4/29/12.
	Copyright (c) 2012 Cristiano Coutinho Caldas. All rights reserved.
*/

#import "Product.h"
#import "DateUtil.h"
#import "Database.h"

@implementation Product
@synthesize name, price, description, released, valid, available;

+(FMDatabase *)database { return [Database getInstance]; }

+(NSDictionary *)tableConfig {	
	return [[[NSDictionary alloc] 
					initWithObjectsAndKeys:
						kColumnTypeText,		@"name",
						kColumnTypeNumeric,		@"price",
						kColumnTypeText,		@"description",
						kColumnTypeDate,		@"released",
						kColumnTypeDateTime,	@"valid",
						kColumnTypeBoolean,		@"available",
	 
			nil] autorelease];
}

-(void)dealloc {
	self.name			= nil;
	self.description	= nil;
	self.released		= nil;
	
	[super dealloc];
}

@end
