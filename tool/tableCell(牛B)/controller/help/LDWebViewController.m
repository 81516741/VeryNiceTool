//
//  LDWebViewController.m
//  令达网易
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDWebViewController.h"
#import "LDJsonModel.h"


@interface LDWebViewController()<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView  * webView;

@end

@implementation LDWebViewController

-(void)loadView{
    UIWebView * webView = [[UIWebView alloc]init];
    self.view = webView;
    webView.delegate = self;
    self.webView = webView;
}

-(void)viewDidLoad{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick)];
    self.title = self.json.title;

    NSURL * url = [[NSBundle mainBundle]URLForResource:self.json.html withExtension:nil];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if (!self.json.ID) return;
    NSString * str = [NSString stringWithFormat:@"window.location.href = '#%@'",self.json.ID];
    [webView stringByEvaluatingJavaScriptFromString:str];
    
}

-(void)buttonClick{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
