//
//  HomeViewController.m
//  miniProje
//
//  Created by Elif Taşkan on 23.11.2021.
//

#import "HomeViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "DetailViewController.h"
#import "ComicModel.h"
#import "ComicTableViewCell.h"
#import <NSHash/NSString+NSHash.h>
#import <NSHash/NSData+NSHash.h>

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property(nonatomic) ComicModel*comicResponse;
@property(nonatomic) Result*selectedResult;
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    

    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    [self getComics:nil];
}
-(void) getComics:(NSString *)searchText {
    NSTimeInterval ts= [[NSDate date]timeIntervalSince1970];
    NSString *tsObj=[[NSNumber numberWithDouble:ts ] stringValue];
    NSString *publicKey=@"751d10ede3953a52744102fbac5640d5";
    NSString *privateKey=@"96e7f1b986b8372d700a5bf1753ea4f4952f8fd0";
    NSString *path= [NSString stringWithFormat:@"%@%@%@",tsObj,privateKey,publicKey];
    NSString *urlPath=[NSString stringWithFormat:@"https://gateway.marvel.com:443/v1/public/comics"];
    NSDictionary *request;
    if (searchText != nil && ![searchText isEqualToString:@""]) {
          request = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   @"50", @"limit",
                                   @"751d10ede3953a52744102fbac5640d5", @"apikey",
                                   [path MD5], @"hash",
                                   tsObj, @"ts",
                                   searchText, @"title",
                                   nil];
      }
      else {
          request = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   @"50", @"limit",
                                   @"751d10ede3953a52744102fbac5640d5", @"apikey",
                                   [path MD5], @"hash",
                                   tsObj, @"ts",
                                   nil];
      }
    NSLog(@"urlPath :%@",urlPath);
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:urlPath  parameters:request headers:nil progress:nil success:^(NSURLSessionTask *task,id responseObject){
        ComicModel *comic =[[ComicModel alloc ] initWithComic:responseObject];
        self.comicResponse=comic;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData ];
            
        });
    } failure:^(NSURLSessionTask *operation ,NSError*error){
        NSLog(@"error:%@",error);
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
//comiclisteki eleman sayısı kadar hücre oluşturuyoruz
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comicResponse.data.results.count;
}
//Burada her hücre içinde olacak veriyi giriyoruz .Dizinin indisleri ile table view cell indislerini eşleştirerek dizinin ilk elemanındaki veriyi ilk hücreye ,ikinci elemanınkı veriyi ikici hücreye... şeklinde atıyoruz
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    ComicTableViewCell *cell = (ComicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ComicTableViewCell"];
    if(indexPath.row % 2==0){
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    }
    Result *result=self.comicResponse.data.results[indexPath.row];
    NSString *formatImage =[NSString stringWithFormat:@"%@.%@",result.thumbnail.path,result.thumbnail.extension];
    NSURL *imgUrl =[NSURL URLWithString:formatImage];
    [cell.comicImageView setImageWithURL:imgUrl];
//
    //hücrenin indeksini almak için indexPath.row u kullanıyoruz
   // ComicModel *item = [self.comicList objectAtIndex:indexPath.row:];
    //aldığın response u array içine atmışsan burada kullanacaksın.
    
   
    cell.titleLabel.text=result.title;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedResult=[self.comicResponse.data.results objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segue" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segue"])
    {
        DetailViewController*detailsc=segue.destinationViewController;
        detailsc.selectedResult=self.selectedResult;
        
    }
    
}
#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self getComics:searchBar.text];
    
    
    
    
}

#pragma mark - Navigation

@end
