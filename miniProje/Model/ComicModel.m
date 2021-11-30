//
//  ComicModel.m
//  miniProje
//
//  Created by Elif Taşkan on 23.11.2021.
//

#import "ComicModel.h"
@implementation Thumbnail
-(instancetype) getThumbnail:(NSDictionary *)thumbnail{
    self.path=[thumbnail valueForKey:@"path"];
    self.extension=[thumbnail valueForKey:@"extension"];
    return self;
}


@end
@implementation Result
-(NSArray*) getResult:(NSArray*)results

{
    NSMutableArray*resultList=[[NSMutableArray alloc] init ];
    for (NSDictionary *result in results) {
        Result*resultModel=[[Result alloc] init ];
        resultModel.title=[result valueForKey:@"title"];
        resultModel.resultId=[result valueForKey:@"id"];
        resultModel.pageCount=[result valueForKey:@"pageCount"];
        resultModel.thumbnail =[[Thumbnail alloc] getThumbnail:[result valueForKey:@"thumbnail"]];
        [resultList addObject:resultModel];
        
    }
    return [NSArray arrayWithArray:resultList];
    
    
    
    
    
}
@end
@implementation Data
-(instancetype) initWithData:(NSDictionary*)data
{

    self.offset=[data valueForKey:@"offset"];
    self.limit=[data valueForKey:@"limit"];
    self.total=[data valueForKey:@"total"];
    self.count=[data valueForKey:@"count"];
    self.results=[[Result alloc] getResult:[data valueForKey:@"results"]];
   
    return self;
    
    
}









@end
@implementation ComicModel
-(instancetype) initWithComic:(NSDictionary*)comic
{
    self.code=[comic valueForKey:@"code"];
    self.status=[comic valueForKey:@"status"];
    self.copyright=[comic valueForKey:@"copyright"];
    self.attributionHTML=[comic valueForKey:@"attributionHTML"];
    self.etag=[comic valueForKey:@"etag"];
    self.attributionText=[comic valueForKey:@"attributionText"];
    self.data =[[ Data alloc ] initWithData:[comic valueForKey:@"data"]];
    
    
    return self;
}

@end
