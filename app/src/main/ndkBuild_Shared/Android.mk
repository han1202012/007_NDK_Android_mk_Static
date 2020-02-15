# I . 保存构建脚本的路径 , 并赋值给 LOCAL_PATH 变量


#   ① 内置函数 : my-dir 是 NDK 内置的函数 , 获取当前的目录路径
#	在该案例中就是 Android.mk 文件所在的目录的绝对路径 , 工程根目录/app/src/main/cpp
#	将该目录赋值给 LOCAL_PATH 变量
#	所有的 Android1.mk 的第一行配置都是该语句

LOCAL_PATH := $(call my-dir)



# II . 预编译第三方动态库


# 1 . 清除变量 ( add 模块配置开始 )
#	① 作用 : 配置新的模块之前都要先清除 LOCAL_XXX 变量
#	② 例外情况 : 但是不会清除 LOCAL_PATH 变量
#	③ 模块开始 : include $(CLEAR_VARS)
#  	④ 模块结尾 : include $(XXX_STATIC_LIBRARY) / include $(XXX_SHARED_LIBRARY)
include $(CLEAR_VARS)

# 2 . 配置动态库名称
#	① 自动生成函数库名称前提 : 没有 LOCAL_MODULE_FILENAME 配置 , 就会自动生成函数库名称
# 	② 动态库命名规则 : 在 LOCAL_MODULE 名称基础上 , 添加 lib 前缀 和 .so 后缀
# 	③ 生成动态库名称 : libadd.so
LOCAL_MODULE := add

# 3 . 预编译的动态库路径
LOCAL_SRC_FILES := libadd.so

# 4 . 设置预编译动态库 ( add 模块配置结束 )
include $(PREBUILT_SHARED_LIBRARY)



# III . 打印变量值


# 打印 LOCAL_PATH 值
# Build 打印内容 : LOCAL_PATH : Y:/002_WorkSpace/001_AS/005_NDK_Compile/app/src/main/cpp
# 编译 APK 时会在 Build 中打印
$(info LOCAL_PATH : $(LOCAL_PATH))



# IV . 配置动态库模块


# 1 . 清除变量 ( native-lib 模块配置开始 )
#	① 作用 : 配置新的模块之前都要先清除 LOCAL_XXX 变量
#	② 例外情况 : 但是不会清除 LOCAL_PATH 变量
include $(CLEAR_VARS)


# 2 . 配置动态库名称
#	① 自动生成函数库名称前提 : 没有 LOCAL_MODULE_FILENAME 配置 , 就会自动生成函数库名称
# 	② 动态库命名规则 : 在 LOCAL_MODULE 名称基础上 , 添加 lib 前缀 和 .so 后缀
# 	③ 生成动态库名称 : libnative-lib.so
LOCAL_MODULE := native-lib


# 3 . 编译的源文件
LOCAL_SRC_FILES := native-lib.c

# 4 . 设置动态依赖库
#	① 依赖库 : 编译 native-lib 模块 , 需要链接 add 静态库
#	② add 动态库 : add 模块是一个预编译库 , 预编译内容是引入的第三方动态库
LOCAL_SHARED_LIBRARIES := add

# 5 . 链接日志库
LOCAL_LDLIBS := -llog

# 6 . 设置预编译动态库 ( native-lib 模块配置结束 )
include $(BUILD_SHARED_LIBRARY)



# V . 配置动态库与静态库区别


#	1 . 预编译时的路径不一致 :
#		① 动态库路径 : libadd.so
#		② 静态库路径 : libadd.a

#	2 . 预编译时结束配置不一致 :
#		① 动态库配置 : include $(PREBUILT_SHARED_LIBRARY)
#		② 静态库配置 : include $(PREBUILT_STATIC_LIBRARY)

#	3 . 链接依赖库时配置不一致 :
#		① 动态库依赖配置 : LOCAL_SHARED_LIBRARIES
#		② 静态库依赖配置 : LOCAL_STATIC_LIBRARIES