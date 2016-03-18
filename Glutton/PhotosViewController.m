


#import "PhotosViewController.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//  UIWebView *webView = [[UIWebView alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://www.yelp.com/biz_photos/%@", self.restaurant.id];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    self.title = self.restaurant.name;
    [self.webview loadRequest:urlRequest];
//        [self.view addSubview:self.webview];
    
//    NSString   *urlString=@"http://www.yelp.com/biz/urban-curry-san-francisco";
//    NSURL *url=[NSURL URLWithString:urlString];
//    NSURLRequest *obj=[NSURLRequest requestWithURL:url];
//    [self.web loadRequest:obj]; // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
