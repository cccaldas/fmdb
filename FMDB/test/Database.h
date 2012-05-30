//
//  Database.h
//  FMDB
//
//  Created by Cristiano Coutinho Caldas on 4/29/12.
//  Copyright (c) 2012 Cristiano Coutinho Caldas. All rights reserved.
//

#import "FMDatabase.h"

@interface Database : FMDatabase {
	
}

-(void)setup;

+(Database *)getInstance;

@end
