#include "utilsios.h"
#include <UIKit/UIKit.h>

#include <QImage>


UtilsIOS::UtilsIOS(QObject *parent) : QObject(parent)
{

}
/*
UIImage* GetUIImg(IplImage* iplImage) {
// NOTE Do not try to include this function in your header, because it will
// need UIImage and if you add the UIKit Objective C Lib in your header
// to make the Type visible the Qt Preprocessor will try to Process the
// UIKit Lib as C++ and will fail
cv::Mat cvMat = cv::cvarrToMat(iplImage);

NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize() * cvMat.total()];

CGColorSpaceRef colorSpace;

if (cvMat.elemSize() == 1)
{
    colorSpace = CGColorSpaceCreateDeviceGray();
}
else
{
    colorSpace = CGColorSpaceCreateDeviceRGB();
}

CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);

CGImageRef imageRef = CGImageCreate(cvMat.cols,                                     // Width
                                    cvMat.rows,                                     // Height
                                    8,                                              // Bits per component
                                    8 * cvMat.elemSize(),                           // Bits per pixel
                                    cvMat.step[0],                                  // Bytes per row
                                    colorSpace,                                     // Colorspace
                                    kCGImageAlphaNone | kCGBitmapByteOrderDefault,  // Bitmap info flags
                                    provider,                                       // CGDataProviderRef
                                    NULL,                                           // Decode
                                    false,                                          // Should interpolate
                                    kCGRenderingIntentDefault);                     // Intent

UIImage* imgResult = [[UIImage alloc] initWithCGImage:imageRef];

CGImageRelease(imageRef);
CGDataProviderRelease(provider);
CGColorSpaceRelease(colorSpace);

cvMat.release();

return imgResult;

}
*/

uint getFlagsFromImageFormat(QImage::Format frm)
{
    uint cgFlags = kCGImageAlphaNone;
    switch (frm) {
    case QImage::Format_ARGB32:
        cgFlags = kCGImageAlphaFirst | kCGBitmapByteOrder32Host;
        break;
    case QImage::Format_RGB32:
        cgFlags = kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Host;
        break;
    case QImage::Format_RGB888:
        cgFlags = kCGImageAlphaNone | kCGBitmapByteOrder32Big;
        break;
    case QImage::Format_RGBA8888_Premultiplied:
        cgFlags = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
        break;
    case QImage::Format_RGBA8888:
        cgFlags = kCGImageAlphaLast | kCGBitmapByteOrder32Big;
        break;
    case QImage::Format_RGBX8888:
        cgFlags = kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Big;
        break;
    case QImage::Format_ARGB32_Premultiplied:
        cgFlags = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host;
        break;
    default:
        cgFlags = kCGImageAlphaNone;
    }
    return cgFlags;
}

UIImage* QImage2UIImmage(const QImage& img)
{
    if (img.isNull()) return nullptr;
    
    NSData *data = [NSData dataWithBytes:img.bits() length:img.byteCount()];
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);

    //CGDataProviderRef provider = CGDataProviderCreateWithData(nullptr, img.bits(), img.byteCount(), nullptr);
    CGColorSpaceRef colorSpace = img.isGrayscale() ? CGColorSpaceCreateDeviceGray() : CGColorSpaceCreateDeviceRGB();
    
    CGImageRef imageRef = CGImageCreate(img.width(),                                   // Width
                                        img.height(),                                  // Height
                                        8,                                              // Bits per component
                                        img.depth(),                           // Bits per pixel
                                        img.bytesPerLine(),                            // Bytes per row
                                        colorSpace,                                     // Colorspace
                                        getFlagsFromImageFormat(img.format()),  // Bitmap info flags
                                        provider,                                       // CGDataProviderRef
                                        NULL,                                           // Decode
                                        false,                                          // Should interpolate
                                        kCGRenderingIntentDefault);                     // Intent

    UIImage* imgResult = [[UIImage alloc] initWithCGImage:imageRef];

    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);


    return imgResult;


}

/*

static QImage fromUIImage(UIImage* image) {
    QImage::Format format = QImage::Format_RGB32;

    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;

    int orientation = [image imageOrientation];
    int degree = 0;

    switch (orientation) {
    case UIImageOrientationLeft:
        degree = -90;
        break;
    case UIImageOrientationDown: // Down
        degree = 180;
        break;
    case UIImageOrientationRight:
        degree = 90;
        break;
    }

    if (degree == 90 || degree == -90)  {
        CGFloat tmp = width;
        width = height;
        height = tmp;
    }

    QSize size(width,height);

    QImage result = QImage(size,format);

    CGContextRef contextRef = CGBitmapContextCreate(result.bits(),                 // Pointer to  data
                                                   width,                       // Width of bitmap
                                                   height,                       // Height of bitmap
                                                   8,                          // Bits per component
                                                   result.bytesPerLine(),              // Bytes per row
                                                   colorSpace,                 // Colorspace
                                                   kCGImageAlphaNoneSkipFirst |
                                                   kCGBitmapByteOrder32Little); // Bitmap info flags

    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), image.CGImage);
    CGContextRelease(contextRef);

    if (degree != 0) {
        QTransform myTransform;
        myTransform.rotate(degree);
        result = result.transformed(myTransform,Qt::SmoothTransformation);
    }

    return result;
}*/

bool UtilsIOS::saveImgToGallery(const QImage& qimg4Album) {
    //QImage* qImage = &qimg4Album;

    UIImage* uiimg4Album = QImage2UIImmage(qimg4Album);
    if ( uiimg4Album){
        UIImageWriteToSavedPhotosAlbum( uiimg4Album, Nil, Nil, Nil);
        return true;
    }
    return false;
}

/*
#import <Photos/Photos.h>

UIImage *snapshot = self.myImageView.image;

[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
{
    PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:snapshot];
    changeRequest.creationDate          = [NSDate date];
}
completionHandler:^(BOOL success, NSError *error)
{
    if (success)
    {
        NSLog(@"successfully saved");
    }
    else
    {
        NSLog(@"error saving to photos: %@", error);
    }
}];}
*/
