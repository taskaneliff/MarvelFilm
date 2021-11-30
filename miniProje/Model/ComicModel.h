//
//  ComicModel.h
//  miniProje
//
//  Created by Elif Taşkan on 23.11.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface Thumbnail : NSObject
@property(nonatomic) NSString *path;
@property(nonatomic) NSString *extension;
-(instancetype) getThumbnail:(NSDictionary*) thumbnail;


@end
@interface Result: NSObject
@property (nonatomic) NSNumber *resultId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSNumber *pageCount;
@property (nonatomic) Thumbnail *thumbnail;

-(NSArray*) getResult:(NSArray*)results;



@end
@interface Data : NSObject


@property(nonatomic) NSNumber* offset;
@property(nonatomic) NSNumber* limit;
@property(nonatomic) NSNumber*  total;
@property(nonatomic) NSNumber* count;
@property(nonatomic) NSArray <Result*>*results;
-(instancetype) initWithData:(NSDictionary*)data;



@end
@interface ComicModel : NSObject


@property(nonatomic) NSNumber *code;
@property(nonatomic) NSString *status;
@property(nonatomic) NSString *copyright;
@property(nonatomic) NSString *attributionText;
@property(nonatomic) NSString *attributionHTML;
@property(nonatomic) NSString *etag;
@property(nonatomic) Data*data;
-(instancetype) initWithComic:(NSDictionary*)comic;




@end

NS_ASSUME_NONNULL_END
