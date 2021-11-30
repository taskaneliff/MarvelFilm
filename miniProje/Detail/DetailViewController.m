//
//  DetailViewController.m
//  miniProje
//
//  Created by Elif Taşkan on 23.11.2021.
//

#import "DetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.pageCount.text=[self.selectedResult.pageCount stringValue];
     self.filmBilgisi.text=self.selectedResult.title,
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"marvel.jpg"]];
    UIGraphicsBeginImageContext(self.view.frame.size);
     [[UIImage imageNamed:@"marvel.jpg"] drawInRect:self.view.bounds];
     UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    NSString *formatImage = [NSString stringWithFormat:@"%@.%@",self.selectedResult.thumbnail.path,self.selectedResult.thumbnail.extension];
    NSURL *imgUrl = [NSURL URLWithString:formatImage];
    [self.imageView setImageWithURL:imgUrl];
    self.title=self.selectedResult.title;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
