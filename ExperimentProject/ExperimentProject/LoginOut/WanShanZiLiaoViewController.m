//
//  WanShanZiLiaoViewController.m
//  ExperimentProject
//
//  Created by YJM on 2016/11/16.
//  Copyright © 2016年 yaolong. All rights reserved.
//

#import "WanShanZiLiaoViewController.h"
#import "DefineTool.h"
#import "ToolFuncation.h"
#import "ViewController.h"
@interface WanShanZiLiaoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    ///是否是男的
    BOOL isMan;
}
@end

@implementation WanShanZiLiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"完善资料", nil);
    ///默认选中男
    self.nanBtn.selected = YES;
    isMan = YES;
    ViewBorderRadius(self.touXiangBtn, 27.5, 1, [UIColor whiteColor]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)touXiangBtnClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择文件来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    [actionSheet showInView:self.view];

    
}

//弹出actionsheet。选择获取头像的方式
//从相册获取图片
-(void)takePictureClick:(UIButton *)sender
{
    
}
#pragma mark -
#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"buttonIndex = [%ld]",buttonIndex);
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //			[self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //			[self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage * chosenImage = [info valueForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:chosenImage afterDelay:0.5];
//    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
//        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
//        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
//    }
    //	[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //	[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    //	NSLog(@"保存头像！");
    	[self.touXiangBtn setImage:image forState:UIControlStateNormal];
//    BOOL success;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSError *error;
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *imageFilePath = [documentsDirectory stringByappendingPathComponent:@"selfPhoto.jpg"];
////    NSLog(@"imageFile->>%@",imageFilePath);
//    success = [fileManager fileExistsAtPath:imageFilePath];
//    if(success) {
//        success = [fileManager removeItemAtPath:imageFilePath error:&error];
//    }
//    //	UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
//    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
//    [UIImageJPEgrepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
//    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    //	[userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
//    self.img.image = selfPhoto;
}

/// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

///保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}



- (IBAction)nanBtnClick:(UIButton *)sender {
    sender.selected = YES;
    self.nvBtn.selected = NO;
    isMan = YES;
}
- (IBAction)nvBtnClick:(UIButton *)sender {
    sender.selected = YES;
    self.nanBtn.selected = NO;
    isMan = NO;
}

- (IBAction)zhiJieJinRuBtnClick:(UIButton *)sender {
#warning 这里模拟
    ViewController *VC;
    for (UIViewController *aVC in self.navigationController.viewControllers) {
        if ([aVC isKindOfClass:[ViewController class]]) {
            VC = (ViewController *)aVC;
        }
    }
    [VC removeMainInterfaceViewController];
    [VC loadMainInterfaceController:APP_INTO_UNIVERSAL];
    return;
    
}

- (IBAction)queDingBtnClick:(UIButton *)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
