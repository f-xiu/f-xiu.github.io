[学习笔记 (mrjokersince1997.github.io)](https://mrjokersince1997.github.io/My-Notes/#/其它/工具/git)

- 工作流

  工作区------->暂存区（索引）----------->本地库（数据库）

- 提交

​		初次提交，需要将新的文件先保存在暂存区（添加索引)`git add file`

```
 参数
 -A, --all     add changes from all tracked and untracked files
 新的文件（untracked files）
 git add .  添加所有文件到暂存区
```

​		`git commit -a`将所有有索引的文件提交到本地库中。

​		已经有索引的下次可以直接使用 `git commit file`

- 回滚

  从暂存区中回滚，覆盖文件`git checkout --files`

  从本地库回滚到暂存区，`git reset --files`

​	   取出最后一次的修改到暂存区和工作区： `git checkout HEAD --files`

前进与后退

```
基于索引值操作[推荐]
	git reset --hard [局部索引值]
 	git reset --hard a6ace91
 使用^符号： 只能后退
	git reset --hard HEAD^
	注： 一个^表示后退一步， n 个表示后退 n 步
 使用~符号： 只能后退
 	git reset --hard HEAD~n
	注： 表示后退 n 步  
```

```
hard,soft,与mixed

soft:只改变本地库的HEAD
mixed:改变本地库的HEAD，用本地库的head重置暂存区
hard:改变本地库的HEAD，用本地库的head重置暂存区和工作区
```

删除文件

​	删除的记录在暂存区保存，可以直接放弃所有文件修改，`git checkout .`

​	使用历史记录，用本地库重置暂存区和工作区，`git reset --hard HEAD`