//
//  TestAppViewController.h
//  FMDB
//
//  Created by Cristiano Coutinho Caldas on 4/28/12.
//  Copyright (c) 2012 Simbionte Studios. All rights reserved.
//

#import "GTestViewController.h"
#import "FMDBSuite.h"

@interface TestAppViewController : GTestViewController {
	FMDBSuite *suite_fmdb;
}

@end
