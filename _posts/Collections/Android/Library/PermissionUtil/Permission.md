---
layout: post
title:  null
date:   2018-10-19 16:38:59 +0800
categories: jekyll update
author: Tom
---

-----------------------------
__目录__
- jekyll 的 kmarkdown 负责解析
{:toc}

-----------------------------
<br>

## 0x00、 关于 Android 权限设计
[官方](https://developer.android.com/guide/topics/permissions/overview)

en,写字是件不错的事儿。
如果不是写这几个字我不会想到这几个问题：
- AndroidOS 的维护者们开发权限管理模块是何用意？
- 他们有是如何将权限模块嵌入 AndroidOS 的？
- 要了解权限设计从什么角度入手比较合适(快捷)？

言归正传我们这篇文字的目的是捋顺 `shouldShowRequestPermissionRationale` 的调用逻辑。
- 如果有可能的话根据捋顺的过程实现我们的逻辑需求：
    - 区分 `shouldShowRequestPermissionRationale` `return false` 的时候是什么情况
        - 是用户首次请求权限？
        - 是用户已经勾选了 "Naver ask again" ?

## 0x01、 我真正想说的(关于权限的使用)
按照官方文档的理解我们使用权限的逻辑是：
- ![2018-10-19_Android_Permission_Logic_1.png](/assets/Image/2018-10-19_Android_Permission_Logic_1.png)

我们希望的权限逻辑是：
- ![2018-10-19_Android_Permission_Logic_2.png](/assets/Image/2018-10-19_Android_Permission_Logic_2.png)

在我们希望的权限逻辑中我们有一个困难就是不知道如何判断当前是第几次请求权限。
- 或者说我们无法知道用户是因为没有申请过权限而被告知无需权限解释
- 还是用户已经告诉系统不在显示权限请求二被告知无需权限解释

我们先对请求次数做出定义：
1. **首次请求** 之前从没有请求过该权限，现在做出请求
2. **二次请求** 之前曾经请求过该权限，未被授予，并且用户未勾选 `Never ask again` ，现在做出请求
3. **三次请求** 在二次请求的时候用户勾选了 `Never ask again` ，现在做出的请求都是三次请求


要进行上述区分查看源代码或许有希望得到答案。

## 0x02、 探究过程[源码 · 失败的解决方案]
![2018-10-19_Android_Permission_Logic_AOSP.png](/assets/Image/2018-10-19_Android_Permission_Logic_AOSP.png)
要完成上述探究需要以下储备：
1. Android Activity 启动流程
2. Android 操作系统启动流程中关于 SystemServer
    - ActivityManagerService 启动流程
    - PackageManagerService 启动流程

### 2.1、 小结
至此我们了解到 `shouldShowRequestPermissionRationale` 是在 `com.android.server.pm.PackageManagerService` 也就是下述文件完成的细节操作：

`\AOSP\android-6.0.0_r1\frameworks\base\services\core\java\com\android\server\pm\PackageManagerService.java`
```java
public boolean shouldShowRequestPermissionRationale(String permissionName,
            String packageName, int userId) {
        //这个逻辑判断暂不考虑
        if (UserHandle.getCallingUserId() != userId) {
            mContext.enforceCallingPermission(
                    android.Manifest.permission.INTERACT_ACROSS_USERS_FULL,
                    "canShowRequestPermissionRationale for user " + userId);
        }

        // 如果 uid 不匹配。我们不考虑这段代码
        final int uid = getPackageUid(packageName, userId);
        if (UserHandle.getAppId(getCallingUid()) != UserHandle.getAppId(uid)) {
            return false;
        }

        //如果权限已经被授予。我们暂时不考虑这段代码
        if (checkPermission(permissionName, packageName, userId)
                == PackageManager.PERMISSION_GRANTED) {
            return false;
        }

        //**重点**我们尝试不深入从此以后的后续代码的逻辑仅从其计算结果来尝试看能否完成我们的区分(本文的目标)
        final int flags;

        final long identity = Binder.clearCallingIdentity();
        try {
            flags = getPermissionFlags(permissionName,
                    packageName, userId);
        } finally {
            Binder.restoreCallingIdentity(identity);
        }

        final int fixedFlags = PackageManager.FLAG_PERMISSION_SYSTEM_FIXED
                | PackageManager.FLAG_PERMISSION_POLICY_FIXED
                | PackageManager.FLAG_PERMISSION_USER_FIXED;

        if ((flags & fixedFlags) != 0) {
            return false;
        }

        return (flags & PackageManager.FLAG_PERMISSION_USER_SET) != 0;
    }
```

面对代码中 **重点** 部分我们所设定的目标，我们最直接的想法就是:
- 如果我们能通过反射的方式实现后续逻辑的调用，那么我们就能完成我们的测试。
    - 但是当我们实践想法的时候碰到了问题 
        ```java
        Class.forName("com.android.server.pm.PackageManagerService");
        //Method threw 'java.lang.ClassNotFoundException' exception.
        ```
    - 有关于上述问题我暂时束手无策，设置连原因是什么都不知道(因为我可以反射拿到别的 Obj)
    - 关于这个异常的问题足够新写一篇文字了。

### 2.2、 完犊子了，臣妾没做到
从源码角度完成目的的思路流产了。

## 0x03、 自有逻辑探究 [成功的解决方案]

### 3.1、 通过时间判断
两条线
1. 我们正常操作的线，也就是说本文的第一幅图
2. 在我们操作过程中和过程前后用户随时有可能到设置中打开或者关闭权限
    - 这就是说我们不可能预知这个“正常操作”的开始的状态

通过观察我们能知道在正常的权限申请流程中，如果始终没有用户到设置页面进行操作的情况发生，
当用户第三次请求权限之前一定发生过的事情是：
1. 曾经需要显示解释。
2. 从第三次权限请求发出到第三次权限请求未被授予这个时间段内，Activity 或 Fragment 失去焦点的时间较短。
    - 弹窗需要时间，第三次不需要弹窗，所以时间会短
    - 因此我们可以记录三个时间点：请求发出时间点，失去焦点时间点，得到请求结果时间点。
    - 在这一过程中我们测试得到的数据是手动拒绝，用时最少的时候为 400+ mm[二次权限请求]
    - 自动拒绝用时最多的数据为 300- mm[二次权限请求]

我们根据从失去焦点到收到请求结果的时间差来判断是首次请求还是二次请求。
- 如果从失去焦点到收到请求结果耗时 > 350mm 则为手动拒绝，否则为自动拒绝。

### 3.2、 狐疑
3.1 的解决方案我们不知道时间是否会被其他因素所影响，所以不能保证不出错。
- 通过标记文件或许更可靠。

### 3.3、 通过标记判断
我们也可以在二次请求的时候 `shouldShowRequestPermissionRationale` ，这时候我们将二次请求这件事作为一个标记本地化。

等到三次请求权限的时候我们根据是否做过二次请求就能知道当前是三次请求还是首次请求。

```java

boolean shouldShowRequestPermissionRationale;

//伪代码
if(未被授予权限 A ){
    if(需要解释权限 A 的用途){//这是二次请求权限
        shouldShowRequestPermissionRationale = true;
        1. 解释权限 A 的用头
        2. 根据用户对解释的意向决定是否请求权限
            - 值得注意的是这时候的权限请求框中带有 `Never ask again`
    }else{//有可能是首次请求，也有可能是三次请求
        shouldShowRequestPermissionRationale = false;
        直接请求权限
    }
}

onRequestPermissionsResult(……){
    if(权限被授予了){
        不必多说
    }else{
        if(shouldShowRequestPermissionRationale == false){
            if(界面始终未失去焦点){
                应该提醒用户到设置中可以授予权限
            }else{
                说明用户拒绝了
            }
        }else{//shouldShowRequestPermissionRationale = true
            不必多言
        }
    }
}
```


## 0x04、 如果要写成一个 Library
### 4.1、 权限请求
requestPermission

### 4.2、 请求结果的响应
0. 请求被用户同意
1. 请求被用户拒绝
2. 请求被系统拒绝(用户曾经勾选过 Never ask again)