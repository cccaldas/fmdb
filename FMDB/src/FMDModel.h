/*
	FMDBModel.h
	FMDBTest
	
	Created by Cristiano Coutinho Caldas on 4/23/12.
	Copyright (c) 2012 Simbionte Studios. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

#define kColumnTypeText		@"TEXT"
#define kColumnTypeNumeric	@"NUMERIC"
#define kColumnTypeInteger	@"INTEGER"

@interface FMDModel : NSObject {
	
}

@property (nonatomic) uint id;

+(void)createTable;

+(void)save:(FMDModel *)model;
+(void)delete:(FMDModel *)model;
+(id)new;
+(NSArray *)parseResult:(FMResultSet *)result;
+(void)deleteAll;

//+(NSString *)DDL;
+(NSString *)tableName;
+(FMDatabase *)database;

//config
+(NSDictionary *)tableConfig;

//parse
-(void)databaseToModel:(FMResultSet *)result;
-(NSDictionary *)modelToDatabase;

//query
+(id)find:(uint)id;
+(id)first;
+(id)last;
+(NSArray *)where:(NSString *)query;
+(NSArray *)getAll;
+(uint)getLastId;

+(FMResultSet *)select:(NSString *)sql;
+(BOOL)execute:(NSString *)sql;

@end
