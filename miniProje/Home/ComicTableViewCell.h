//
//  ComicTableViewCell.h
//  miniProje
//
//  Created by Elif Taşkan on 23.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComicTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *comicImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
