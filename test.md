有这么一个段子...
>老杨一推代码,  所有的开发同事便都看着他笑,  有的叫道, “ 老杨,  你又把代码合丢了！” 他不回答,  对产品说, “ 追加两个需求, 只做性能优化。” 便排出一台MacBook Pro。
>
**用 git 的,  谁没合丢过代码呢？**(反正我是合丢过。。。)

PS: git官网上有看都看不完的长篇大论, 甚至有人专门为理解git的一种workflow出书...这些都说明"**看这篇文章就想把git搞透彻是不可能的**"(因为写文章的人都没有把git搞透彻(再次苦笑)).

# 目录
- [目录](#目录)
- [Git的那些概念](#git的那些概念)
  - [Git的本质是什么?](#git的本质是什么)
  - [Git中存储的对象](#git中存储的对象)
    - [1. blob对象](#1-blob对象)
    - [2. tree对象](#2-tree对象)
    - [3. commit对象](#3-commit对象)
    - [**ref(引用)**](#ref引用)

# Git的那些概念

## Git的本质是什么?

Git的本质其实是~~复读机~~一个**内容寻址（content-addressable)文件系统**<!-- 简单来说就是字典 -->, 它的核心部分是一个简单的**键值对数据库**。我们可以向该数据库**写入值（object)**, 它会**返回一个键(object的引用地址, SHA-1字符串)**, 通过该键可以在任意时刻再次检索值. 我们所操作的版本控制, 其实就是不断地向这个文件系统写入操作日志.

那么这些被写入的操作日志是什么呢?

## Git中存储的对象

###  1. blob对象
对应的值是单个文件内容的快照, 这个快照不包括文件名。

![blob](https://my.csdn.net/uploads/201206/19/1340112751_1500.jpg)

###  2. tree对象
以树的形式记录的目录结构和文件的索引, 每个普通结点(有子级的结点)都是一个子级的`tree`对象的包裹体, 每个叶子结点(无子级的结点)都是一个`blob`对象的包裹体, 这些包裹体会附带文件（夹)的名称等元数据。

![tree](https://my.csdn.net/uploads/201206/19/1340112774_4979.jpg)

###  3. commit对象
对应的值包含一个数据集（通常称为`Comments`, 这个数据集包含父级`commit`的地址(SHA1值, 通常也被称作commitid)、作者以及提交message等信息)以及一个当前`commit`对应的变更的`tree`, `tree`的内容为当次提交的变动快照(没有发生变动的文件不会被加入快照)。

![commit](https://my.csdn.net/uploads/201206/19/1340112824_8482.jpg)

总结一下, 三者关系:

![blob&tree&commit](https://upload-images.jianshu.io/upload_images/3789468-be2115feda33a733.jpg)

所以, 当存在多个提交时,

```bash
#bash
git init
echo "version 1" > test.txt
git add .
git commit -m "frist commit"

echo "version 2" > test.txt
echo "new file" > new.txt
git add .
git commit -m "second commit"

mkdir bak
echo "version 1" > bak/text.txt
git add .
git commit -m "third commit"
```
