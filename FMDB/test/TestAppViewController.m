//
//  TestAppViewController.m
//  FMDB
//
//  Created by Cristiano Coutinho Caldas on 4/28/12.
//  Copyright (c) 2012 Cristiano Coutinho Caldas. All rights reserved.
//

#import "TestAppViewController.h"

@interface TestAppViewController ()

@end

@implementation TestAppViewController

-(void)setup {
	[super setup];
	
	suite_fmdb = [self addTestSuite:[[FMDBSuite alloc]init]];
	[suite_fmdb run];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
