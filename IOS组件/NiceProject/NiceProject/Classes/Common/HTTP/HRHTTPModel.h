//
//  HRHTTPModel.h
//  导航控制器
//
//  Created by ld on 16/9/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HRHTTPModel;
typedef enum {
    HRHTTPTypePost = 1,
    HRHTTPTypeGet,
}YHHTTPType;

typedef void(^ _Nonnull Block)( HRHTTPModel * _Nonnull );
@interface HRHTTPModel : NSObject
/**
 * 请求类型
 */
@property(nonatomic ,assign ) YHHTTPType httpType;
/**
 * 请求参数
 */
@property(nonatomic ,strong ,nonnull) id parameters;
/**
 * 用于请求的url
 */
@property(nonatomic ,copy ,nonnull) NSString * url;
/**
 * 响应数据
 */
@property(nonatomic ,strong ,nullable) id data;
/**
 * 响应数据模型的类型
 */
@property(nonatomic ,strong ,nullable) Class dataClass;
/**
 * AFN返回的error
 */
@property(nonatomic ,strong ,nullable) NSError * errorOfAFN;
/**
 * 自己服务器返回的error
 */
@property(nonatomic ,strong ,nullable) NSString * errorOfMy;
/**
 * 用来判断请求状态成功or失败
 */
@property(nonatomic,assign)int32_t status;
/**
 * 用于取消HTTP请求的标记
 */
@property(nonatomic ,copy, nullable) NSString * taskDescription;

@end
