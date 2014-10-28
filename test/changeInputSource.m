//
//  main.m
//  changeInputSource
//
//  Created by 丁明信 on 14/10/28.
//  Copyright (c) 2014年 丁明信. All rights reserved.
//  work on osx 10.10
//  usage : 
//  binfile 'com.apple.keylayout.US' -- this chnage to en input method
//  binfile 'com.sogou.inputmethod.sogou.pinyin' -- this chnage to sougou.pinyin input method
//  binfile 'com.sogou.inputmethod.sogou' -- this chnage to sougou en input method
//
//	how to compile:
//	gcc "changeInputSource.m" -o "changeInputSource" -l objc -framework foundation -framework carbon
//
//	or you can create a xcode project of command line, to build it
//
#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

int main (int argc, const char *argv[]) {
    @autoreleasepool {
        BOOL b = NO;
        NSString *inputID;
        NSMutableString *thisID;
        TISInputSourceRef inputSource = NULL;
        if (argc < 2) b = YES; else inputID = [NSString stringWithUTF8String:argv[1]];
        CFArrayRef availableInputs = TISCreateInputSourceList(NULL, false);
        NSUInteger count = CFArrayGetCount(availableInputs);
        for (int i = 0; i < count; i++) {
            inputSource = (TISInputSourceRef)CFArrayGetValueAtIndex(availableInputs, i);
            CFStringRef type = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceCategory);
            if (!CFStringCompare(type, kTISCategoryKeyboardInputSource, 0)) {
                thisID = (__bridge NSMutableString *)(TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID));
                if (b) {
                    printf("%s\n", [thisID UTF8String]);
                } else if ([thisID isEqualToString:inputID]) {
                    b = YES;
                    OSStatus err = TISSelectInputSource(inputSource);
                    if (err) printf("Error %i\n", (int)err);
                    break;
                }
            }
        }
        CFRelease(availableInputs);
        if (!b) printf("%s not available\n", thisID);
    }
    return 0;
}
