
# EVNCustomSearchBar用法

## ViewController.m中

#import "ViewController.h"

```
@interface ViewController <EVNCustomSearchBarDelegate>


@property (strong, nonatomic) EVNCustomSearchBar *searchBar;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.searchBar;
    if (@available(iOS 11.0, *)) {
        [self.searchBar.heightAnchor constraintLessThanOrEqualToConstant:kNavConH].active = YES;
    }
}

- (EVNCustomSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[EVNCustomSearchBar alloc] initWithFrame:CGRectMake(0, kStatusBarH, kScreenW, kNavConH)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.iconImage = [UIImage imageNamed:@"searchContactsBarIcon"];
        _searchBar.iconAlign = EVNCustomSearchBarIconAlignCenter;
        [_searchBar setPlaceholder:@"请输入关键字"];
        _searchBar.delegate = self;
        [_searchBar sizeToFit];
    }
    return _searchBar;
}

#pragma mark - EVNCustomSearchBarDelegate
//其他代理看EVNCustomSearchBarDelegate详情
- (void)searchBar:(EVNCustomSearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)searchBarSearchButtonClicked:(EVNCustomSearchBar *)searchBar {
    
}

- (void)searchBarCancelButtonClicked:(EVNCustomSearchBar *)searchBar {
    
}

@end


```