使用方法
	1.
		#import "PHAssetCollectionNavigationController.h"
		#import "PHAssetsManager.h"

	2.
		//  使用之前请确保已经获取 相册权限
   		 PHAssetCollectionNavigationController * navi = [[PHAssetCollectionNavigationController alloc] init];
   		 //  设置最大允许选择照片数量  默认是9
   		 [PHAssetsManager sharedInstance].maxCount = 9;
    
    		//  这里获取结果
    	[PHAssetsManager sharedInstance].imageAssets = ^(int error_code, NSMutableArray<UIImage *> *imageAssets){
       		NSLog(@"\n\n--================= error_code %d  为 0 表示已经选择了图片 为1 表示放弃选择 ===========\n\n",error_code);
        
       		if (error_code == 0) {
         		NSLog(@"选择完毕 选择图片集 images = %@",imageAssets);
        	}else{
           		NSLog(@"取消选择");
        	}
        
    	};
    3.
    	[self presentViewController:navi animated:YES completion:nil];
