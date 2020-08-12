//
//  UserViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "UserViewController.h"

#import "../Model/LoginModel.h"

#import "Base/GlobalVariable.h"
#import "Base/NetRequest.h"
#import "Base/ThemeManager.h"


#import "Base/Extensions/MYTextField.h"
#import "Masonry.h"



@interface UserViewController()

@property (nonatomic) Boolean isLogin;

@property (nonatomic, strong) UIView * infoPageView;
@property (nonatomic, strong) UIView * signInPageView;
@property (nonatomic, strong) UIView * signUpPageView;

@end


@implementation UserViewController

static UserViewController * instance;

+ (id)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[UserViewController alloc] init];
        }
    });
    return instance;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 背景图
    self.view.layer.contents = (id)[self imageByApplyingAlpha:0.2f image:[UIImage imageNamed:@"bg"]].CGImage;

    
    if (self.isLogin == YES){
        [self infoPageView];
    } else {
        [self signInPageView];
    }
}

- (UIView *)infoPageView{
    if (_infoPageView == nil){
        _infoPageView = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_infoPageView];
        
        UIImageView * avatar = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"avatar" ] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        avatar.layer.cornerRadius = 50;
        avatar.tintColor = UIColor.systemPinkColor;
        [_infoPageView addSubview:avatar];
        
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view).multipliedBy(0.5);
            make.width.height.mas_equalTo(100);
        }];
        
        UIButton * signout = [[UIButton alloc] init];
        
        [signout addTarget:self action:@selector(signOut:) forControlEvents:UIControlEventTouchUpInside];
        
        [signout setTitle:@"退出" forState:UIControlStateNormal];
        
        signout.titleLabel.font = [UIFont systemFontOfSize:24];
        
        signout.backgroundColor = UIColor.systemPinkColor;
        signout.layer.cornerRadius = 30;
        signout.layer.shadowColor = (__bridge CGColorRef _Nullable)([[ThemeManager shareInstance] shadowColor]);
        signout.layer.shadowRadius = 10;
        [_infoPageView addSubview:signout];
        
        [signout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view).multipliedBy(1.5);
            make.width.mas_equalTo(self.view).multipliedBy(0.6);
            make.height.mas_equalTo(60);
        }];
    }
    return _infoPageView;
}

- (UIView *)signInPageView{
    if (_signInPageView == nil){
        _signInPageView = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_signInPageView];
        
        UITextField * username = [[MYTextField alloc] init];
        UITextField * password = [[MYTextField alloc] init];
        username.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.textContentType = UITextContentTypeNewPassword;
        password.secureTextEntry = YES;
        
        UIImageView * usernameIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"user"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        UIImageView * passwordIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        UIImageView * eyeIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"eye-close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        username.placeholder = @"用户名";
        password.placeholder = @"密码";
        username.leftView = usernameIcon;
        username.leftViewMode = UITextFieldViewModeAlways;
        password.leftView = passwordIcon;
        password.leftViewMode = UITextFieldViewModeAlways;
        password.rightView = eyeIcon;
        password.rightViewMode = UITextFieldViewModeAlways;
        password.rightView.userInteractionEnabled = YES;
        username.tintColor = UIColor.systemPinkColor;
        username.textColor = UIColor.systemPinkColor;
        password.tintColor = UIColor.systemPinkColor;
        password.textColor = UIColor.systemPinkColor;
        
        username.font = [UIFont systemFontOfSize:20];
        password.font = [UIFont systemFontOfSize:20];
        
        UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blinkEye:)];
        
        objc_setAssociatedObject(tap, @"password", password, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(tap, @"eye", eyeIcon, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [eyeIcon addGestureRecognizer:tap];
        	
        [_signInPageView addSubview:username];
        [_signInPageView addSubview:password];
        
        UIButton * signin = [[UIButton alloc] init];
        UIButton * signup = [[UIButton alloc] init];
        
        objc_setAssociatedObject(signin, @"username", username, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(signin, @"password", password, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [signin addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
        [signup addTarget:self action:@selector(goToSignUpPageView:) forControlEvents:UIControlEventTouchUpInside];
        
        [signin setTitle:@"登陆" forState:UIControlStateNormal];
        [signup setTitle:@"还没有账号，注册一下" forState:UIControlStateNormal];
        
        signin.titleLabel.font = [UIFont systemFontOfSize:24];
        signup.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [signup setTitleColor:UIColor.systemPinkColor forState:UIControlStateNormal];
        signin.backgroundColor = UIColor.systemPinkColor;
        signin.layer.cornerRadius = 30;
        signin.layer.shadowColor = (__bridge CGColorRef _Nullable)([[ThemeManager shareInstance] shadowColor]);
        signin.layer.shadowRadius = 10;
        
        [_signInPageView addSubview:signin];
        [_signInPageView addSubview:signup];
        
        [@[username, password] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(self.view).multipliedBy(0.8);
            make.height.mas_equalTo(80);
        }];
        
        [username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view).mas_offset(-100);
        }];
        [password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(username).offset(70);
        }];
        
        [@[usernameIcon, passwordIcon] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
        }];
        
        [signup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(password);
            make.top.mas_equalTo(password.mas_bottom);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(30);
        }];
        
        [signin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view).multipliedBy(1.5);
            make.width.mas_equalTo(self.view).multipliedBy(0.6);
            make.height.mas_equalTo(60);
        }];
    }
    return _signInPageView;
}

- (UIView *)signUpPageView{
    if (_signUpPageView == nil){
        _signUpPageView = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_signUpPageView];
        
        UITextField * username = [[MYTextField alloc] init];
        UITextField * password = [[MYTextField alloc] init];
        UITextField * rePassword = [[MYTextField alloc] init];
        username.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.autocapitalizationType = UITextAutocapitalizationTypeNone;
        rePassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.textContentType = UITextContentTypeNewPassword;
        password.secureTextEntry = YES;
        rePassword.textContentType = UITextContentTypeNewPassword;
        rePassword.secureTextEntry = YES;
        
        UIImageView * usernameIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"user"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        UIImageView * passwordIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        UIImageView * rePasswordIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"key"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        username.placeholder = @"用户名";
        password.placeholder = @"密码";
        rePassword.placeholder = @"再次输入密码";
        username.leftView = usernameIcon;
        username.leftViewMode = UITextFieldViewModeAlways;
        password.leftView = passwordIcon;
        password.leftViewMode = UITextFieldViewModeAlways;
        rePassword.leftView = rePasswordIcon;
        rePassword.leftViewMode = UITextFieldViewModeAlways;
        username.tintColor = UIColor.systemPinkColor;
        username.textColor = UIColor.systemPinkColor;
        password.tintColor = UIColor.systemPinkColor;
        password.textColor = UIColor.systemPinkColor;
        rePassword.tintColor = UIColor.systemPinkColor;
        rePassword.textColor = UIColor.systemPinkColor;
        
        username.font = [UIFont systemFontOfSize:20];
        password.font = [UIFont systemFontOfSize:20];
        rePassword.font = [UIFont systemFontOfSize:20];
        
        [_signUpPageView addSubview:username];
        [_signUpPageView addSubview:password];
        [_signUpPageView addSubview:rePassword];
        
        UIButton * signin = [[UIButton alloc] init];
        UIButton * signup = [[UIButton alloc] init];
        
        objc_setAssociatedObject(signup, @"username", username, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(signup, @"password", password, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(signup, @"rePassword", rePassword, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [signin addTarget:self action:@selector(goToSignInPageView:) forControlEvents:UIControlEventTouchUpInside];
        [signup addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
        
        [signin setTitle:@"已有账号，登陆一下" forState:UIControlStateNormal];
        [signup setTitle:@"注册" forState:UIControlStateNormal];
        
        signup.titleLabel.font = [UIFont systemFontOfSize:24];
        signin.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [signin setTitleColor:UIColor.systemPinkColor forState:UIControlStateNormal];
        signup.backgroundColor = UIColor.systemPinkColor;
        signup.layer.cornerRadius = 30;
        signin.layer.shadowColor = (__bridge CGColorRef _Nullable)([[ThemeManager shareInstance] shadowColor]);
        signin.layer.shadowRadius = 10;
        
        [_signUpPageView addSubview:signin];
        [_signUpPageView addSubview:signup];
        
        [@[username, password, rePassword] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(self.view).multipliedBy(0.8);
            make.height.mas_equalTo(70);
        }];
        
        [username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view).mas_offset(-100);
        }];
        [password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(username).offset(70);
        }];
        [rePassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(password).offset(70);
        }];
        [@[usernameIcon, passwordIcon, rePasswordIcon] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
        }];
        
        [signin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rePassword);
            make.top.mas_equalTo(rePassword.mas_bottom);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(30);
        }];
        
        [signup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view).multipliedBy(1.5);
            make.width.mas_equalTo(self.view).multipliedBy(0.6);
            make.height.mas_equalTo(60);
        }];
    }
    return _signUpPageView;
}

- (void)goToSignInPageView:(UIButton *)button{
    [self.signUpPageView removeFromSuperview];
    self.signUpPageView = nil;
    [self signInPageView];
}

- (void)goToSignUpPageView:(UIButton *)button{
    [self.signInPageView removeFromSuperview];
    self.signInPageView = nil;
    [self signUpPageView];
}

- (void)signOut:(UIButton *)button{
    [self.infoPageView removeFromSuperview];
    self.infoPageView = nil;
    [self signInPageView];
    self.token = nil;
    self.isLogin = NO;
}

- (void)signIn:(UIButton *)button{
    NSString * url = [BaseIP stringByAppendingString:@":8000/api/v1/login"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    UITextField * username = objc_getAssociatedObject(button, @"username");
    UITextField * password = objc_getAssociatedObject(button, @"password");
    [params setValue:username.text forKey:@"username"];
    [params setValue:password.text forKey:@"password"];
    
    [[NetRequest shareInstance] POST:url params:params progress:^(id downloadProgress) {
    } success:^(id responseObject) {
        LoginModel * model = [[LoginModel alloc] initWithDict:responseObject];
        self.token = model.token;
        self.isLogin = YES;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.signInPageView removeFromSuperview];
            self.signInPageView = nil;
            [self infoPageView];
            
        });
    } failues:^(id error) {
        NSData * errData = [[error userInfo] valueForKey:@"com.alamofire.serialization.response.error.data"];
        NSString * errString = [[NSString alloc] initWithData:errData encoding:NSUTF8StringEncoding];
        NSData * data = [errString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * errDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

        dispatch_sync(dispatch_get_main_queue(), ^{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"tips" message:errDict[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

- (void)signUp:(UIButton *)button{
    NSString * url = [BaseIP stringByAppendingString:@":8000/api/v1/users"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    UITextField * username = objc_getAssociatedObject(button, @"username");
    UITextField * password = objc_getAssociatedObject(button, @"password");
    UITextField * rePassword = objc_getAssociatedObject(button, @"rePassword");
    
    if ([password.text isEqual:rePassword.text] == NO){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"tips" message:@"密码不一致" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [params setValue:username.text forKey:@"username"];
    [params setValue:password.text forKey:@"password"];
    
    [[NetRequest shareInstance] POST:url params:params progress:^(id downloadProgress) {
    } success:^(id responseObject) {
        LoginModel * model = [[LoginModel alloc] initWithDict:responseObject];
        self.token = model.token;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.signUpPageView removeFromSuperview];
            self.signUpPageView = nil;
            [self infoPageView];
        });
        NSLog(@"Signup failed, err: %@",responseObject);
    } failues:^(id error) {
        NSData * errData = [[error userInfo] valueForKey:@"com.alamofire.serialization.response.error.data"];
        NSString * errString = [[NSString alloc] initWithData:errData encoding:NSUTF8StringEncoding];
        NSData * data = [errString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * errDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

        dispatch_sync(dispatch_get_main_queue(), ^{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"tips" message:errDict[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)blinkEye:(UIGestureRecognizer *)tap{
    UITextField * password = objc_getAssociatedObject(tap, @"password");
    UIImageView * imageView = objc_getAssociatedObject(tap, @"eye");
    if (password.isSecureTextEntry){
        password.secureTextEntry = NO;
        imageView.image = [[UIImage imageNamed:@"eye"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    } else {
        password.secureTextEntry = YES;
        imageView.image = [[UIImage imageNamed:@"eye-close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
}

-(UIImage *)imageByApplyingAlpha:(CGFloat )alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
     
    CGContextRef ctx = UIGraphicsGetCurrentContext();
     
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
     
    CGContextScaleCTM(ctx, 1, -1);
     
    CGContextTranslateCTM(ctx, 0, -area.size.height);
     
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
     
     
    CGContextSetAlpha(ctx, alpha);
     
    CGContextDrawImage(ctx, area, image.CGImage);
     
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
     
    UIGraphicsEndImageContext();
     
    return newImage;
}

@end
