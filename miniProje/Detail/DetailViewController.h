//
//  DetailViewController.h
//  miniProje
//
//  Created by Elif Taşkan on 23.11.2021.
//

#import <UIKit/UIKit.h>
#import "ComicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Result *selectedResult;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *filmBilgisi;
@property (weak, nonatomic) IBOutlet UILabel *pageCount;






@end

NS_ASSUME_NONNULL_END
