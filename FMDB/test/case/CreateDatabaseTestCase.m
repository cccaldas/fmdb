//
//  CreateDatabaseTestCase.m
//  FMDB
//
//  Created by Cristiano Coutinho Caldas on 4/28/12.
//  Copyright (c) 2012 Cristiano Coutinho Caldas. All rights reserved.
//

#import "CreateDatabaseTestCase.h"
#import "Database.h"

@implementation CreateDatabaseTestCase

-(void)setup {
	[super setup];
	
	Database *_database = [Database getInstance];
	
	if([_database exists])
		[_database delete];
	
	[self assert:![_database exists] description:@"Database ainda existe!"];
	[_database create];
	[self assert:[_database exists] description:@"Database não existe!"];
	
	//NSLog(@"path: %@", _database.databasePath);
	
	
	
	[self testComplete];
}

@end
