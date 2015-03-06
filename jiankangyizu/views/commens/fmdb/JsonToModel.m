//
//  JsonToModel.m
//  Json2ModelDemo
//
//  Created by Cailiang on 14-7-24.
//  Copyright (c) 2014年 Home. All rights reserved.
//

#import "JsonToModel.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, JsonToModelDataType)
{
    JsonToModelDataTypeObject    = 0,
    JsonToModelDataTypeBOOL      = 1,
    JsonToModelDataTypeInteger   = 2,
    JsonToModelDataTypeFloat     = 3,
    JsonToModelDataTypeDouble    = 4,
    JsonToModelDataTypeLong      = 5,
};

@implementation JsonToModel

+ (NSDictionary *)dictionaryFromObject:(id)object
{
    if (object == nil) {
        return nil;
    }
    
    NSMutableDictionary *propertyAndValues = [[NSMutableDictionary alloc] init];
    
    @try {
        NSString *className = NSStringFromClass([object class]);
        id classObject = objc_getClass([className UTF8String]);
        
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(classObject, &count);
        
        for (int i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            id propertyValue = nil;
            id valueObject = [object valueForKey:propertyName];
            if ([valueObject isKindOfClass:[NSDictionary class]])
            {
                propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
            } else if ([valueObject isKindOfClass:[NSArray class]])
            {
                propertyValue = [NSArray arrayWithArray:valueObject];
            } else
            {
                propertyValue = [NSString stringWithFormat:@"%@",[object valueForKey:propertyName]];
            }
            
            [propertyAndValues setObject:propertyValue forKey:propertyName];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        return [propertyAndValues copy];
    }
}

+ (NSArray *)propertiesFromObject:(id)object
{
    if (object == nil) {
        return nil;
    }
    
    NSMutableArray *propertiesArray = [[NSMutableArray alloc] init];
    
    @try {
        NSString *className = NSStringFromClass([object class]);
        id classObject = objc_getClass([className UTF8String]);
        
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(classObject, &count);
        
        for (int i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            
            [propertiesArray addObject:propertyName];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        return [propertiesArray copy];
    }
}

+ (id)objectFromDictionary:(NSDictionary *)dictionary className:(NSString *)name
{
    if (dictionary == nil || name == nil || name.length == 0) {
        return nil;
    }
    
    id object = [[NSClassFromString(name) alloc]init];
    
    @try {
        id classObject = objc_getClass([name UTF8String]);
        
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(classObject, &count);
        Ivar * ivars = class_copyIvarList(classObject, nil);
        
        for (int i = 0; i < count; i ++)
        {
            NSString *memberName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            const char *type = ivar_getTypeEncoding(ivars[i]);
            NSString *dataType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
            
//            NSLog(@"Data %@ type: %@",memberName,dataType);
            
            JsonToModelDataType rtype = JsonToModelDataTypeObject;
            if ([dataType hasPrefix:@"c"])
            {
                // BOOL
                rtype = JsonToModelDataTypeBOOL;
            } else if ([dataType hasPrefix:@"i"])
            {
                // int
                rtype = JsonToModelDataTypeInteger;
            } else if ([dataType hasPrefix:@"f"])
            {
                // float
                rtype = JsonToModelDataTypeFloat;
            } else if ([dataType hasPrefix:@"d"])
            {
                // double
                rtype = JsonToModelDataTypeDouble;
            } else if ([dataType hasPrefix:@"l"])
            {
                // long
                rtype = JsonToModelDataTypeLong;
            }
            
            for (int j = 0; j < count; j ++)
            {
                objc_property_t property = properties[j];
                NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                if ([propertyName isEqualToString:@"identity"]) {
                    propertyName = @"id";
                }
                NSRange range = [memberName rangeOfString:propertyName];
                if (range.location == NSNotFound) {
                    continue;
                } else {
                    id propertyValue = [dictionary objectForKey:propertyName];
                    if (propertyValue == [NSNull alloc]) {
                        NSLog(@"NULL YES");
                        switch (rtype) {
                            case JsonToModelDataTypeBOOL:
                            {
//                                BOOL temp = [[NSString stringWithFormat:@"%@",propertyValue] boolValue];
                                propertyValue = [NSNumber numberWithBool:NO];
                            }
                                break;
                            case JsonToModelDataTypeInteger:
                            {
//                                int temp = [[NSString stringWithFormat:@"%@",propertyValue] intValue];
                                propertyValue = [NSNumber numberWithInt:0];
                            }
                                break;
                            case JsonToModelDataTypeFloat:
                            {
//                                float temp = [[NSString stringWithFormat:@"%@",propertyValue] floatValue];
                                propertyValue = [NSNumber numberWithFloat:0.0];
                            }
                                break;
                            case JsonToModelDataTypeDouble:
                            {
//                                double temp = [[NSString stringWithFormat:@"%@",propertyValue] doubleValue];
                                propertyValue = [NSNumber numberWithDouble:0.0];
                            }
                                break;
                            case JsonToModelDataTypeLong:
                            {
//                                long long temp = [[NSString stringWithFormat:@"%@",propertyValue] longLongValue];
                                propertyValue = [NSNumber numberWithLongLong:0];
                            }
                            case JsonToModelDataTypeObject:
                                break;
                                
                            default:
                                break;
                        }
                    }else{
                        switch (rtype) {
                            case JsonToModelDataTypeBOOL:
                            {
                                BOOL temp = [[NSString stringWithFormat:@"%@",propertyValue] boolValue];
                                propertyValue = [NSNumber numberWithBool:temp];
                            }
                                break;
                            case JsonToModelDataTypeInteger:
                            {
                                int temp = [[NSString stringWithFormat:@"%@",propertyValue] intValue];
                                propertyValue = [NSNumber numberWithInt:temp];
                            }
                                break;
                            case JsonToModelDataTypeFloat:
                            {
                                float temp = [[NSString stringWithFormat:@"%@",propertyValue] floatValue];
                                propertyValue = [NSNumber numberWithFloat:temp];
                            }
                                break;
                            case JsonToModelDataTypeDouble:
                            {
                                double temp = [[NSString stringWithFormat:@"%@",propertyValue] doubleValue];
                                propertyValue = [NSNumber numberWithDouble:temp];
                            }
                                break;
                            case JsonToModelDataTypeLong:
                            {
                                long long temp = [[NSString stringWithFormat:@"%@",propertyValue] longLongValue];
                                propertyValue = [NSNumber numberWithLongLong:temp];
                            }
                            case JsonToModelDataTypeObject:
                                break;
                                
                            default:
                                break;
                        }
                        if ([propertyName isEqualToString:@"id"]) {
                            [object setValue:propertyValue forKey:@"identity"];
                        }else{
                            [object setValue:propertyValue forKey:memberName];
                        }
                    }
                   
                    
                    break;
                }
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }@finally {
        return object;
    }
}
+ (NSArray *)objectsFromDictionaryArray:(NSArray *)dictionarys className:(NSString *)name{
    NSMutableArray *objecArrays=[[NSMutableArray alloc]initWithCapacity:0];
    for (int j=0; j<[dictionarys count]; j++) {
        NSDictionary *dictionary = [dictionarys objectAtIndex:j];
       [objecArrays addObject:[self objectFromDictionary:dictionary className:name]];
    }
    return objecArrays;
}
/*
 返回值，获取多例
 */
+ (NSArray *)objectsFromDictionaryData:(NSData *)data className:(NSString *)name{
    if (data !=nil) {
        NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *string=[dir objectForKey:@"resultObject"];
        NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *arry=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        NSArray *objects=[self objectsFromDictionaryArray:arry className:name];
        return objects;

    }else{
        return [[NSArray alloc]init];
    }
 
//    string	__NSCFString *	@"[{"addDate":1411350375947,"addIp":"119.180.98.134","addUser":"yaxing","applicationConditions":"","brandId":62,"brandName":"扬州亚星客车","catId":132,"catName":"新能源客车","content":"<p>此款前置城市客车精心挑选成熟配置，兼顾实用与经济性。外形设计贯穿方中带圆的设计理念，大面方正、拐角圆润，给人以挺拔有力、刚中带柔的视觉效果。采用大曲面全景挡风玻璃，视野开阔，采光充足。该系列产品底盘、车身模块化设计，零部件通用性、互换性强。优选南充天然气发动机，性能可靠，燃油经济，维护方便，满足各个地区及不同用户的选</p>","id":853,"img":"","intro":"","isHot":0,"isNew":1,"isShow":1,"modelName":"JS6901G","pubDate":1411350179000,"sid":10,"summary":"","title":"新能源客车公交（星6）JS6901G","tmpBusLengthId":3,"tmpEngineLocationId":7,"tmpEnginePowerId":11,"tmpMaxSeatNum":41,"tmpMinSeatNum":12,"updateDate":1411437784347,"updateIp":"119.180.98.134","updateUser":"yaxing","uuid":"1b5857b1-ca78-47b9-b2a3-6a722f4e07cd","viewCount":0},{"addDate":1411350171693,"addIp":"119.180.98.134","addUser":"yaxing","applicationConditions":"","brandId":62,"brandName":"扬州亚星客车","catId":132,"catName":"新能源客车","content":"<p>此款前置城市客车精心挑选成熟配置，兼顾实用与经济性。外形设计贯穿方中带圆的设计理念，大面方正、拐角圆润，给人以挺拔有力、刚中带柔的视觉效果。采用大曲面全景挡风玻璃，视野开阔，采光充足。该系列产品底盘、车身模块化设计，零部件通"	0x0c56e670
//    
//    string	__NSCFString *	@"[{"addDate":1411376658383,"addIp":"119.180.98.134","addUser":"yaxing","catId":12,"catName":"行业动态","content":"<p>一、自2014年9月1日至2017年12月31日，对购置的新能源汽车免征车辆购置税。</p><p>\v　二、对免征车辆购置税的新能源汽车，由工业和信息化部、国家税务总局通过发布《免征车辆购置税的新能源汽车车型目录》（以下简称《目录》）实施管理。</p><p>列入《目录》的新能源汽车须同时符合以下条件：</p><p>\v　　1.获得许可在中国境内销售的纯电动汽车、插电式（含增程式）混合动力汽车、燃料电池汽车。</p><p>\v　　2.使用的动力电池不包括铅酸电池。</p><p>\v　　3.纯电动续驶里程须符合要求（详情见右图）。</p><p>\v　　4.插电式混合动力乘用车综合燃料消耗量（不含电能转化的燃料消耗量）与现行的常规燃料消耗量国家标准中对应目标值相比小于60%；插电式混合动力商用车综合燃料消耗量（不含电能转化的燃料消耗量）与现行的常规燃料消耗量国家标准中对应限值相比小于60%。</p><p>\v　　5.通过新能源汽车专项检测，符合新能源汽车标准要求。</p><p><br/></p>","id":45,"img":"","isShow":1,"linkOther":"","pubDate":1411376504000,"replyCount":0,"shareCount":0,"sid":10,"source":"","subTitle":"关于免征新能源汽车车辆购置税的公告","summary":"一、自2014年9月1日至2017年12月31日，对购置的新能源汽车免征车辆购置税。\v　二、对免征车辆购置税的新能源汽车，由工业和信息化部、国家税务总局通过发布《免征车辆购置税的新能源汽车车型目录》（以下简称《目录》）实施管理。","title":"关于免征新能源汽车车辆购置税的公告","updateDate":1411376658383,"updateIp":"119.180.98.134","updateUser":"yaxing","uuid":"86d48f75-42c9-4f4b-9cae-e3583cb25ce1","viewCount":0},{"addDate":14113"	0x0c2a5950
    
}

/*
 返回值，获取单例
 */
+ (id)objectFromDictionaryData:(NSData *)data className:(NSString *)name{
    if (data !=nil) {
        NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *string=[dir objectForKey:@"resultObject"];
        NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        id object=[self objectFromDictionary:dictionary className:name];
        return object;
        
    }else{
        return nil;
    }
    
    //    string	__NSCFString *	@"[{"addDate":1411350375947,"addIp":"119.180.98.134","addUser":"yaxing","applicationConditions":"","brandId":62,"brandName":"扬州亚星客车","catId":132,"catName":"新能源客车","content":"<p>此款前置城市客车精心挑选成熟配置，兼顾实用与经济性。外形设计贯穿方中带圆的设计理念，大面方正、拐角圆润，给人以挺拔有力、刚中带柔的视觉效果。采用大曲面全景挡风玻璃，视野开阔，采光充足。该系列产品底盘、车身模块化设计，零部件通用性、互换性强。优选南充天然气发动机，性能可靠，燃油经济，维护方便，满足各个地区及不同用户的选</p>","id":853,"img":"","intro":"","isHot":0,"isNew":1,"isShow":1,"modelName":"JS6901G","pubDate":1411350179000,"sid":10,"summary":"","title":"新能源客车公交（星6）JS6901G","tmpBusLengthId":3,"tmpEngineLocationId":7,"tmpEnginePowerId":11,"tmpMaxSeatNum":41,"tmpMinSeatNum":12,"updateDate":1411437784347,"updateIp":"119.180.98.134","updateUser":"yaxing","uuid":"1b5857b1-ca78-47b9-b2a3-6a722f4e07cd","viewCount":0},{"addDate":1411350171693,"addIp":"119.180.98.134","addUser":"yaxing","applicationConditions":"","brandId":62,"brandName":"扬州亚星客车","catId":132,"catName":"新能源客车","content":"<p>此款前置城市客车精心挑选成熟配置，兼顾实用与经济性。外形设计贯穿方中带圆的设计理念，大面方正、拐角圆润，给人以挺拔有力、刚中带柔的视觉效果。采用大曲面全景挡风玻璃，视野开阔，采光充足。该系列产品底盘、车身模块化设计，零部件通"	0x0c56e670
    //
    //    string	__NSCFString *	@"[{"addDate":1411376658383,"addIp":"119.180.98.134","addUser":"yaxing","catId":12,"catName":"行业动态","content":"<p>一、自2014年9月1日至2017年12月31日，对购置的新能源汽车免征车辆购置税。</p><p>\v　二、对免征车辆购置税的新能源汽车，由工业和信息化部、国家税务总局通过发布《免征车辆购置税的新能源汽车车型目录》（以下简称《目录》）实施管理。</p><p>列入《目录》的新能源汽车须同时符合以下条件：</p><p>\v　　1.获得许可在中国境内销售的纯电动汽车、插电式（含增程式）混合动力汽车、燃料电池汽车。</p><p>\v　　2.使用的动力电池不包括铅酸电池。</p><p>\v　　3.纯电动续驶里程须符合要求（详情见右图）。</p><p>\v　　4.插电式混合动力乘用车综合燃料消耗量（不含电能转化的燃料消耗量）与现行的常规燃料消耗量国家标准中对应目标值相比小于60%；插电式混合动力商用车综合燃料消耗量（不含电能转化的燃料消耗量）与现行的常规燃料消耗量国家标准中对应限值相比小于60%。</p><p>\v　　5.通过新能源汽车专项检测，符合新能源汽车标准要求。</p><p><br/></p>","id":45,"img":"","isShow":1,"linkOther":"","pubDate":1411376504000,"replyCount":0,"shareCount":0,"sid":10,"source":"","subTitle":"关于免征新能源汽车车辆购置税的公告","summary":"一、自2014年9月1日至2017年12月31日，对购置的新能源汽车免征车辆购置税。\v　二、对免征车辆购置税的新能源汽车，由工业和信息化部、国家税务总局通过发布《免征车辆购置税的新能源汽车车型目录》（以下简称《目录》）实施管理。","title":"关于免征新能源汽车车辆购置税的公告","updateDate":1411376658383,"updateIp":"119.180.98.134","updateUser":"yaxing","uuid":"86d48f75-42c9-4f4b-9cae-e3583cb25ce1","viewCount":0},{"addDate":14113"	0x0c2a5950
    
}
/*
 判断返回值是否成功
 */
+ (BOOL)ifSuccessFromDictionaryData:(NSData *)data{
    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *string=[dir objectForKey:@"resultCode"];
    if ([string isEqualToString:@"0001"]) {
        return YES;
    }else{
        return NO;
    }
}

/*
 获取后台的返回message
 */
+ (NSString *)getMessageFromDictionaryData:(NSData *)data{
    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *string=[dir objectForKey:@"resultMessage"];
    return string;
}
/*
 获取返回的个数
 */
+ (int)getCountFromDictionaryData:(NSData *)data{
    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    int count=[[dir objectForKey:@"totalCount"] intValue];
    return count;
}
/*
 返回Dictionary
 */
+ (NSDictionary *)getDictionaryFromDictionaryData:(NSData *)data{
     NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dir;
}
/*
 获取json格式的Array
 */
+ (NSArray *)jsonObjectsFromDictionaryData:(NSData *)data{
    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *string=[dir objectForKey:@"resultObject"];
    NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arry=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
    return arry;
}



/*
 返回值，获取多例
 */
+ (NSArray *)objectsFromDictionary:(NSDictionary *)dictionary className:(NSString *)name{
    NSString *string=[dictionary objectForKey:@"resultObject"];
    NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arry=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *objects=[self objectsFromDictionaryArray:arry className:name];
    return objects;
}

/*
 判断返回值是否成功
 */
+ (BOOL)ifSuccessFromDictionary:(NSDictionary *)dictionary{
    NSString *string=[dictionary objectForKey:@"resultCode"];
    if ([string isEqualToString:@"0001"]) {
        return YES;
    }else{
        return NO;
    }
}

/*
 获取后台的返回message
 */
+ (NSString *)getMessageFromDictionary:(NSDictionary *)dictionary{
    NSString *string=[dictionary objectForKey:@"resultMessage"];
    return string;
}
/*
 获取返回的个数
 */
+ (int)getCountFromDictionary:(NSDictionary *)dictionary{

    int count=(int)[dictionary objectForKey:@"totalCount"];
    return count;
}

//对象转json
+(NSString *)getJsonStringFromOne:(id)obj{
    NSData *jsonData =   [self getJSON:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
+(NSString *)getJsonStringFromArray:(NSArray *)array{
    NSMutableString *string = [[NSMutableString alloc]init];
    [string appendString:@"["];
    for (int i=0; i<[array count]; i++) {
        [string appendString:[self getJsonStringFromOne:[array objectAtIndex:i]]];
        if (i< [array count]-1) {
            [string appendString:@","];
        }
    }
    [string appendString:@"]"];
    return string;
}

+ (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = @"";
        }
        else
        {
            value = [self getObjectInternal:value];
//            NSString *namelowser = [self replaceLower:propName];
            NSString *namelowser = propName;

            if ([namelowser isEqualToString:@"identity"]) {
                namelowser  = @"id";
            }
            [dic setObject:value forKey:namelowser];
        }
        
    }
    return dic;
}
+(NSString *)replaceLower:(NSString *)str{
    NSMutableString *ms=[[NSMutableString alloc]init];
    char c[50];
    strcpy(c,(char *)[str UTF8String]);
    
    for (int i = 0; c != nil && i < str.length; i++) {
        if (c[i] < 97 && c[i] > 57) {
            [ms appendFormat:[NSString stringWithFormat:@"_%c",c[i]]];
        } else {
            [ms appendFormat:[NSString stringWithFormat:@"%c",c[i]]];
        }
    }
    
    str=[ms lowercaseString];
    
    return str;
}
+ (void)print:(id)obj
{
    NSLog(@"%@", [self getObjectData:obj]);
}


+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

@end
