//
//  FMDBSuite.m
//  FMDB
//
//  Created by Cristiano Coutinho Caldas on 4/28/12.
//  Copyright (c) 2012 Simbionte Studios. All rights reserved.
//

#import "FMDBSuite.h"
#import "CreateDatabaseTestCase.h"
#import "ProductTestCase.h"

@implementation FMDBSuite

-(void)setup {
	[super setup];
	
	[self addTestCase:[[CreateDatabaseTestCase alloc] init]];
	[self addTestCase:[[ProductTestCase alloc] init]];
}

@end
