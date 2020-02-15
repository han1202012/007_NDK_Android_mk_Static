
#include <jni.h>

#include <stdio.h>
#include <stdlib.h>

#include <android/log.h>


//调用 libadd.so 动态库中的方法
extern int add(int a, int b);

JNIEXPORT jstring JNICALL
Java_kim_hsl_mk_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject obj) {

    //调用动态库中的函数
    int sum = add(1, 2);

    // Logcat 打印计算结果
    __android_log_print(ANDROID_LOG_INFO, "JNI_TAG", "Native Caculate : %d + %d = %d", 1, 2, sum);

    //将加法运算转为字符串
    char str[50] = "0";
    //字符串格式化
    sprintf(str, "Native Caculate : Static Library : %d + %d = %d", 1, 2, sum);

    return (*env)->NewStringUTF(env, str);
}

