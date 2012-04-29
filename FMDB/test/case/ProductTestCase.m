/*
	ProductTestCase.m
	FMDB
	
	Created by Cristiano Coutinho Caldas on 4/29/12.
	Copyright (c) 2012 Simbionte Studios. All rights reserved.
*/

#import "ProductTestCase.h"
#import "Product.h"

@implementation ProductTestCase

-(void)setup {
	[super setup];
	
	for (int i = 0; i < 10; i++) {
		Product *product	= [Product new];
		product.name		= [NSString stringWithFormat:@"Chocolate %d", i];
		product.price		= 10.43f * i;
		product.description = @"Chocolate é muito bom! 'não é ?'";
		product.released	= [NSDate date];
		
		[Product save:product];
	}
	
	[self assert:([[Product getAll] count] == 10)  description:@"Nao há 10 produtos"];
	
	[Product delete:[Product first]];
	
	Product *product = [Product last];
	product.name = @"Product name 2";
	product.price = 112.54f;
	[Product save:product];
	
	product = [Product find:product.id];
	
	[self assert:[product.name isEqualToString:@"Product name 2"]	description:@"Produto não foi atualizado"];
	[self assert:(product.price == 112.54f)							description:@"Produto não foi atualizado"];
		
	[self assert:([[Product getAll] count] == 9)  description:@"Não há 9 produtos"];
	
	[Product deleteAll];
	
	[self assert:([[Product getAll] count] == 0)  description:@"Produtos não foram deletados."];
}

@end
