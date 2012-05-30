/*
	Product.h
	FMDB
	
	Created by Cristiano Coutinho Caldas on 4/29/12.
	Copyright (c) 2012 Simbionte Studios. All rights reserved.
*/

#import "FMDModel.h"

@interface Product : FMDModel

@property (nonatomic, retain)	NSString	*name;
@property (nonatomic, assign)	float		price;
@property (nonatomic, retain)	NSString	*description;
@property (nonatomic, retain)	NSDate		*released; 
@property (nonatomic, retain)	NSDate		*valid; 
@property (nonatomic)			BOOL		available;

@end
