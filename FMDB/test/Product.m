/*
	Product.m
	FMDB
	
	Created by Cristiano Coutinho Caldas on 4/29/12.
	Copyright (c) 2012 Simbionte Studios. All rights reserved.
*/

#import "Product.h"
#import "DateUtil.h"
#import "Database.h"

@implementation Product
@synthesize name, price, description, released;

+(FMDatabase *)database { return [Database getInstance]; }

+(NSDictionary *)tableConfig {	
	return [[[NSDictionary alloc] 
					initWithObjectsAndKeys:
						kColumnTypeText,	@"name", 
						kColumnTypeNumeric, @"price", 
						kColumnTypeText,	@"description", 
						kColumnTypeText,	@"released", 
	 
			nil] autorelease];
}

-(NSDictionary *)modelToDatabase {
	return [[[NSDictionary alloc] 
			initWithObjectsAndKeys:
				self.name,														@"name", 
				[NSString stringWithFormat:@"%f", self.price],					@"price", 
				self.description,												@"description", 
				[DateUtil stringWithDate:self.released format:@"yyyy-MM-dd"],	@"released", 
			nil] autorelease];
}

-(void)databaseToModel:(FMResultSet *)result {
	self.name			= [result	stringForColumn:@"name"];
	self.price			= [[result	stringForColumn:@"price"] floatValue];
	self.description	= [result	stringForColumn:@"description"];
	self.released		= [DateUtil dateWithString:[result stringForColumn:@"released"] format:@"yyyy-MM-dd"];
}

-(void)dealloc {
	self.name			= nil;
	self.description	= nil;
	self.released		= nil;
	
	[super dealloc];
}

@end
