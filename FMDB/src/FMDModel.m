/*
	FMDBModel.m
	FMDB
	
	Created by Cristiano Coutinho Caldas on 4/23/12.
	Copyright (c) 2012 Cristiano Coutinho Caldas. All rights reserved.
*/

#import "FMDModel.h"
#import "DateUtil.h"

@interface FMDModel()
+(NSString *)formatColumnToDatabase:(NSString *)column value:(NSString *)value;
@end

@implementation FMDModel
@synthesize id;

+(id)new { return [[[self alloc] init] autorelease]; }

+(NSDictionary *)tableConfig { return nil; }

+(void)createTable {
	NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY", [self tableName]];
	NSDictionary *config = [self tableConfig];
	
	for (NSString *key in config) {
		if([key isEqualToString:kColumnTypeDate] || [key isEqualToString:kColumnTypeDateTime] || [key isEqualToString:kColumnTypeBoolean])
			key = kColumnTypeText;
		
		sql = [NSString stringWithFormat:@"%@, %@ %@", sql, key, [config objectForKey:key]];
	}
	
	sql = [NSString stringWithFormat:@"%@);", sql];
	
	[self execute:sql];
	
	//NSLog(@"FMDModel::createTable() sql: %@", sql);
}
			
-(void)databaseToModel:(FMResultSet *)result config:(NSDictionary *)config {	
	for (NSString *key in config) {
		NSString *type = [config objectForKey:key];
		
		if([type isEqualToString:kColumnTypeText])
			[self setValue:[result stringForColumn:key] forKey:key];
		
		else if([type isEqualToString:kColumnTypeNumeric])
			[self setValue:[NSNumber numberWithFloat:[[result stringForColumn:key] floatValue]] forKey:key];
		
		else if([type isEqualToString:kColumnTypeInteger])
			[self setValue:[NSNumber numberWithInt:[[result stringForColumn:key] intValue]] forKey:key];
		
		else if([type isEqualToString:kColumnTypeDate])
			[self setValue:[DateUtil dateWithString:[result stringForColumn:key] format:kDateFormat] forKey:key];
		
		else if([type isEqualToString:kColumnTypeDateTime])
			[self setValue:[DateUtil dateWithString:[result stringForColumn:key] format:kDateTimeFormat] forKey:key];
		
		else if([type isEqualToString:kColumnTypeBoolean])
			[self setValue:[NSNumber numberWithInt:[[result stringForColumn:key] intValue]] forKey:key];
	}
}

-(NSDictionary *)modelToDatabase:(NSDictionary *)config {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	
	for (NSString *key in config) {
		NSString *type = [config objectForKey:key];
		
		if([type isEqualToString:kColumnTypeText])
			[dict setObject:[self valueForKey:key] forKey:key];
		
		else if([type isEqualToString:kColumnTypeNumeric])
			[dict setObject:[NSString stringWithFormat:@"%@", [self valueForKey:key]] forKey:key];
		
		else if([type isEqualToString:kColumnTypeInteger])
			[dict setObject:[NSString stringWithFormat:@"%d", [self valueForKey:key]] forKey:key];
		
		else if([type isEqualToString:kColumnTypeDate])
			[dict setObject:[DateUtil stringWithDate:[self valueForKey:key] format:kDateFormat] forKey:key];
		
		else if([type isEqualToString:kColumnTypeDateTime])
			[dict setObject:[DateUtil stringWithDate:[self valueForKey:key] format:kDateTimeFormat] forKey:key];
		
		else if([type isEqualToString:kColumnTypeBoolean])
			[dict setObject:[NSString stringWithFormat:@"%@", [self valueForKey:key]] forKey:key];
	}
	
	return dict;
}

//+(NSString *)DDL		{ return nil; }
+(NSString *)tableName	{ return NSStringFromClass([self class]); }
+(FMDatabase *)database { return nil; }

+(void)delete:(FMDModel *)model {
	NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = %d;", [self tableName], model.id];
	[self execute:sql];
}

+(NSString *)formatColumnToDatabase:(NSString *)column value:(NSString *)value {
	NSString *type = [[self tableConfig] objectForKey:column];
	
	if([type isEqualToString:kColumnTypeText] || 
	   [type isEqualToString:kColumnTypeDate] || 
	   [type isEqualToString:kColumnTypeDateTime]
	)
		value = [NSString stringWithFormat:@"\"%@\"", value];
	
	return value;
}

+(void)save:(FMDModel *)model {
	//NSLog(@"Evento::save() table: %@", [self TABLE_NAME]);
	
	NSString *sql;
	NSDictionary *data = [model modelToDatabase:[self tableConfig]];
	NSDictionary *config = [self tableConfig];
	
	if(model.id == 0) { //insert
		
		sql = [NSString stringWithFormat:@"INSERT INTO %@ (", [self tableName]];
		
		for (NSString *key in config)
			sql = [NSString stringWithFormat:@"%@ %@,", sql, key];
		
		sql = [sql substringToIndex:[sql length] - 1];
		sql = [NSString stringWithFormat:@"%@) VALUES(", sql];
		
		for (NSString *key in config)
			sql = [NSString stringWithFormat:@"%@ %@,", sql, [self formatColumnToDatabase:key value:[data objectForKey:key]]];
		
		sql = [sql substringToIndex:[sql length] - 1];
		sql = [NSString stringWithFormat:@"%@ );", sql];
		
		//NSLog(@"FMDModel::insert() sql: %@", sql);
		
		[self execute:sql];
		model.id = [self getLastId];
	}
	else { //update
		
		sql = [NSString stringWithFormat:@"UPDATE %@ SET ", [self tableName]];
		
		for (NSString *key in config)
			sql = [NSString stringWithFormat:@"%@ %@ = %@,", sql, key, [self formatColumnToDatabase:key value:[data objectForKey:key]]];
		
		sql = [sql substringToIndex:[sql length] - 1];
		sql = [NSString stringWithFormat:@"%@ WHERE id = %d;", sql, model.id];
		
		//NSLog(@"FMDModel::update() sql: %@", sql);
		[self execute:sql];
		
		/*
		sql = [NSString stringWithFormat:@"UPDATE %@ SET \
			   nome = \"%@\", \
			   responsavel = \"%@\", \
			   local = \"%@\", \
			   saloes = \"%@\", \
			   data = \"%@\", \
			   inicio = \"%@\", \
			   termino = \"%@\", \
			   id_tipo_servico = %d WHERE id = %d;",
			   [self TABLE_NAME],
			   evento.nome,
			   evento.responsavel,
			   evento.local,
			   [[evento.saloes valueForKey:@"description"] componentsJoinedByString:@","],
			   [DateUtil stringWithDate:evento.data format:@"yyyy-MM-dd"],
			   //evento.data,
			   evento.inicio,
			   evento.termino,
			   evento.id_tipo_servico,
			   evento.id];
		[self execute:sql];
		//NSLog(@"Evento::update() sql: %@", sql);
		 */
	}	
}

+(NSArray *)parseResult:(FMResultSet *)result {
	NSMutableArray *items = [NSMutableArray array];
	
	while([result next]) {
		FMDModel *model			= [self new];
		model.id				= [result intForColumn:@"id"];
		[model databaseToModel:result config:[self tableConfig]];
		
		[items addObject:model];
	}
	
	return items;
}

+(id)find:(uint)id {
	NSArray *result = [self where:[NSString stringWithFormat:@"id = %d", id]];
	
	if([result count] != 0)
		return [result objectAtIndex:0];
	
	return nil;
}

+(id)first {
	NSString *sql	= [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY id ASC LIMIT 1;", [self tableName]];
	NSArray *result = [self parseResult:[self select:sql]];
	
	if([result count] != 0)
		return [result objectAtIndex:0];
	
	return nil;
}

+(id)last {
	NSString *sql	= [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY id DESC LIMIT 1;", [self tableName]];
	NSArray *result = [self parseResult:[self select:sql]];
	
	if([result count] != 0)
		return [result objectAtIndex:0];
	
	return nil;
}

+(NSArray *)getAll {
	NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@;", [self tableName]];
	return [self parseResult:[self select:sql]];
}

+(NSArray *)where:(NSString *)query {
	NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@;", [self tableName], query];
	return [self parseResult:[self select:sql]];
}

+(id)whereOne:(NSString *)query {
	NSArray *result = [self where:query];
	
	if([result count] != 0)
		return [result objectAtIndex:0];
	
	return nil;
}

+(void)deleteAll {	
	NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@;", [self tableName]];
	[self execute:sql];
}

+(uint)getLastId {
	NSString *sql		= [NSString stringWithFormat:@"SELECT id FROM %@ ORDER BY id DESC LIMIT 1;", [self tableName]];
	FMResultSet *result = [self select:sql];
	
	if ([result next]) {
		return [result intForColumnIndex:0];
	}
	
	return 0;
}

+(FMResultSet *)select:(NSString *)sql {
	//[[self DATABASE] open];
	FMResultSet *result = [[self database] executeQuery:sql];
	//[[self DATABASE] close];
	
	return result;
}

+(BOOL)execute:(NSString *)sql {
	//NSLog(@"FMDBModel::execute() %@", sql);
	
	//[[self DATABASE] open];
	BOOL result = [[self database] executeUpdate:sql];
	//[[self DATABASE] close];
	
	return result;
}

@end
