//
//  HKEncodeTools.h
//  define
//
//  Created by hooyking on 16/7/27.
//  Copyright © 2016年 hooyking. All rights reserved.
//

#import <Foundation/Foundation.h>

///*********************************************************************************************
///由于GTMBase64为MRC编写，所以需要在Build Phases中Compile Sources中在GTMBase64.m后加上-fno-objc-arc
///*********************************************************************************************

typedef NS_ENUM (NSInteger, HKMD5BitType) {
    HKMD5BitTypeBy16 = 0,
    HKMD5BitTypeBy32
};

//AES（CBC模式，128位，pkcs7填充）编码的key与iv都是16位的
#define AESKEY   @"A1B2C3D4E5F6G7H8"
#define AESIV    @"H8G7F6E5D4C3B2A1"

//DES（CBC模式，pkcs7填充）编码的key与iv都是8位的
#define DESKEY   @"76543210"
#define DESIV    @"01234567"

//3DES（CBC模式，pkcs7填充）编码的key与iv都是24位的
#define DESBY3KEY   @"012345678901234567890123"
#define DESBY3IV    @"012345678901234567890124"

@interface HKEncodeTools : NSObject

#pragma mark - BASE64编解码

/**
 base64编码，传入string
 
 @param string 待base64编码字符串
 
 @return base64编码后的字符串
 */
+ (NSString *)base64EncodeWithString:(NSString *)string;

/**
 base64解码，传入string
 
 @param string 待base64解码字符串
 
 @return base64解码后的字符串
 */
+ (NSString *)base64DecodeWithString:(NSString *)string;

/**
 base64编码，传入NSData
 
 @param data 待base64编码data
 
 @return base64编码后的字符串
 */
+ (NSString *)base64EncodeWithData:(NSData *)data;

/**
 base64解码，传入NSData
 
 @param data 待base64解码data
 
 @return base64解码后的字符串
 */
+ (NSString *)base64DecodeWithData:(NSData *)data;

#pragma mark - MD5编码

/**
 md5编码，区分了大小写，16、32位。
 理论上不可逆，这儿建议采用md5加盐，即md5之后的字符串拼接一个自定义的字符串再md5
 
 @param string 待md5编码字符串
 @param bitType HKMD5BitTypeBy16 为16位，HKMD5BitTypeBy32 为32位
 @param isUppercase YES 大写，NO 小写
 
 @return md5加密后的字符串
 */
+ (NSString *)md5EncodeWithString:(NSString *)string
                          bitType:(HKMD5BitType)bitType
                      isUppercase:(BOOL)isUppercase;

/**
 计算文件的md5值
 
 @discussion 一般我们在文件上传、下载的时候，会在开始前上传一个文件的md5值，在完成之后再上传此文件的md5值比较是否一样。
 校验MD5值是为了防止在传输的过程当中丢包或者数据包被篡改（断点续传的时候用的多）。
 
 @param path 文件路径
 
 @return 文件的md5值
 */
+ (NSString *)getFileMD5ValueForPath:(NSString *)path;

#pragma mark - SHA1、SHA256、SHA384、SHA512编码

/**
 sha1编码，哈希算法中的一种且不可逆
 
 @param string 待sha1编码字符串
 @param isUppercase YES 大写，NO 小写
 
 @return sha1编码后的字符串
 */
+ (NSString *)sha1WithString:(NSString *)string isUppercase:(BOOL)isUppercase;

/**
 sha256编码，哈希算法中的一种且不可逆

 @param string 待sha256编码字符串
 @param isUppercase YES 大写，NO 小写

 @return sha256编码后的字符串
*/
+ (NSString *)sha256WithString:(NSString *)string isUppercase:(BOOL)isUppercase;

/**
 sha384编码，哈希算法中的一种且不可逆

 @param string 待sha384编码字符串
 @param isUppercase YES 大写，NO 小写

 @return sha384编码后的字符串
*/
+ (NSString *)sha384WithString:(NSString *)string isUppercase:(BOOL)isUppercase;

/**
 sha512编码，哈希算法中的一种且不可逆

 @param string 待sha512编码字符串
 @param isUppercase YES 大写，NO 小写

 @return sha512编码后的字符串
*/
+ (NSString *)sha512WithString:(NSString*)string isUppercase:(BOOL)isUppercase;

#pragma mark - AES编解码

/**
 aes编码（模式CBC，128位，填充pkcs7，key16位，苹果推荐），与java和php互通
 
 @param string 待aes编码字符串
 @param key 密钥
 @param iv 偏移量，也称为初始化向量
 
 @return aes编码后的字符串，其结果最后是base64编码了的
 */
+ (NSString *)aesCBC128BitPkcs7EncodeString:(NSString *)string
                                        key:(NSString *)key
                                         iv:(NSString*)iv;

/**
 aes解码（模式CBC，128位，填充pkcs7，key16位，苹果推荐），与java和php互通
 
 @param string 待aes解码字符串
 @param key 密钥
 @param iv 偏移量，也称为初始化向量
 
 @return aes解码后的字符串
 */
+ (NSString *)aesCBC128BitPkcs7DecodeString:(NSString *)string
                                        key:(NSString *)key
                                         iv:(NSString*)iv;
#pragma mark - DES编解码

/**
 des编码（模式CBC，填充pkcs7，key8位）

 @param string 待des编码字符串
 @param key 密钥
 @param iv 偏移量，也称为初始化向量

 @return des编码后的字符串
 */
+ (NSString *)desCBCPkcs7EncodeString:(NSString *)string
                                  key:(NSString *)key
                                   iv:(NSString*)iv;

/**
 des解码（模式CBC，填充pkcs7，key8位）

 @param string 待des解码字符串
 @param key 密钥
 @param iv 偏移量，也称为初始化向量

 @return des解码后的字符串
 */
+ (NSString *)desCBCPkcs7DecodeString:(NSString *)string
                                  key:(NSString *)key
                                   iv:(NSString*)iv;

/**
 3des编码（模式CBC，填充pkcs7，key24位）

 @param string 待3des编码字符串
 @param key 密钥
 @param iv 偏移量，也称为初始化向量

 @return 3des编码后的字符串
 */
+ (NSString *)desBy3CBCPkcs7EncodeString:(NSString *)string
                                     key:(NSString *)key
                                      iv:(NSString*)iv;

/**
 3des解码（模式CBC，填充pkcs7，key24位）

 @param string 待3des解码字符串
 @param key 密钥
 @param iv 偏移量，也称为初始化向量

 @return 3des解码后的字符串
*/
+ (NSString *)desBy3CBCPkcs7DecodeString:(NSString *)string
                                     key:(NSString *)key
                                      iv:(NSString*)iv;

#pragma mark - RSA编码

///**************************************************************************************************************************************
///Mac可使用openssl生成所需秘钥文件
///使用openssl进行生成，首先打开终端，查看openssl是否安装（终端输入openssl version），Mac本身安装了的，接下来按下面这些步骤依次来做：
///1.生成模长为1024bit的私钥文件private_key.pem
///$ openssl genrsa -out private_key.pem 1024
///2.生成证书请求文件rsaCertReq.csr，这一步会提示输入国家、省份、地区、组织名称、组织单位名称、通用名称、邮箱地址等，
///这儿除了通用名称(Common Name需要填，其他都可不填直接回车)
///$ openssl req -new -key private_key.pem -out rsaCerReq.csr
///3.生成证书rsaCert.crt，并设置有效时间为1年
///$ openssl x509 -req -days 365 -in rsaCerReq.csr -signkey private_key.pem -out rsaCert.crt
///4.生成供iOS使用的公钥文件public_key.der
///$ openssl x509 -outform der -in rsaCert.crt -out public_key.der
///5.生成供iOS使用的私钥文件private_key.p12，这儿会让你为这个私钥文件设置密码，在解密时private_key.p12文件需要和这里设置的密码配合使用
///$ openssl pkcs12 -export -out private_key.p12 -inkey private_key.pem -in rsaCert.crt
///6.生成供Java使用的公钥rsa_public_key.pem
///$ openssl rsa -in private_key.pem -out rsa_public_key.pem -pubout writing RSA key
///7.生成供Java使用的私钥pkcs8_private_key.pem
///$ openssl pkcs8 -topk8 -in private_key.pem -out pkcs8_private_key.pem -nocrypt
///8.生成JAVA支持的PKCS8二进制类型的私钥：(ps:用于java解密)
///$ openssl pkcs8 -topk8 -inform PEM -in private_key.pem -outform DER -nocrypt -out pkcs8_private_key.der
///全部执行成功后，会生成如下文件，其中public_key.der和private_key.p12就是iOS需要用到的文件（PS：在所在的目录下生成了6个文件，其中pem的文件都是文本类型的，
///都可以使用文本编辑器或者cat命令查看，der的都是二进制的文件了，不能看），pkcs8_private_key.der就是java用的
///***************************************************************************************************************************************

/**
 RSA编码配置公钥，公钥负责加密
 
 @param publicKeyPath 公钥文件路径（公钥文件格式.der）
 */

+ (void)configPublicKeyPath:(NSString *)publicKeyPath;

/**
 RSA解码配置私钥，私钥负责解密
 
 @param privateKeyPath 私钥文件路径（私钥文件后缀.p12或.pfx）
 @param password 私钥文件密码
 */
+ (void)configPrivateKeyPath:(NSString *)privateKeyPath password:(NSString *)password;

/**
 rsa编码，调用前需要先调用configPublicKeyPath:
 
 @param string 待rsa编码字符串
 */
+ (NSString *)rsaEncodeWithString:(NSString *)string;

/**
 rsa解码，调用前需要先调用configPrivateKeyPath: password:

 @param string 待rsa解码字符串
 */
+ (NSString *)rsaDecodeWithString:(NSString *)string;

@end



@interface RSAEncodeTools : NSObject

+ (id)sharedInstance;
- (void)loadPublicKeyWithPath:(NSString *)publicKeyPath;
- (void)loadPrivateKeyWithPath:(NSString *)privateKeyPath password:(NSString *)password;
- (NSString *)rsaEncodeWithString:(NSString *)string;
- (NSString *)rsaDecodeWithString:(NSString *)string;

@end
