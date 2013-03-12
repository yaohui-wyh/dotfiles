My VIMRC

<img src="/images/vim.png" alt="vim-editor">

#### 使用

1. 安装 [Vundle](https://github.com/VundleVim/Vundle.vim): `$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
2. 安装插件: `BundleInstall`
3. 更新插件: `BundleUpdate`

#### 搜索相关配置

1. 支持搜索高亮匹配，回车取消高亮
2. 支持增量式搜索（incsearch，即输入搜索字符串时即时定位搜索结果）
3. 当搜索字符串包含大写字母时，区分大小写（smartcase）；仅当全为小写时不进行区分

#### 代码规范相关配置

1. 显示所有的dos换行符：映射为快捷键`\dos`（其中`\`为Leader键位，后不再赘述）
2. 出于规范及Code Review等需求，定制了清除行末空白、展开Tab为空格，以及将Windows的dos EOL的函数，并映射为快捷键`cls`
3. 若希望VIM自动化对所有打开的文件进行步骤2的Fix EOL操作，请将`Clean`函数末如下语句注释打开

        au FileType c,java,javascript,python,xml,html,yml,mkd autocmd VimEnter * call Clean()
4. 一行代码限定长度为120字符（可按需在`AddColorColumn`函数中修改`colorcolumn`变量值），快捷键`clm`可以打开边界提示线

<img src="/images/vim-column.png" alt="vim-column">

5. 集成 Python 代码规范插件 [vim-flake8](https://github.com/nvie/vim-flake8)，通过`F6`执行代码检查（首先通过 `pip install flake8` 安装 flake8）

#### 代码编辑

1. [AutoPair](https://github.com/jiangmiao/auto-pairs) 自动补全括号/引号等
2. [vim-surround](https://github.com/tpope/vim-surround) 自动替换符号（surrounding, 即括号/引号等）

#### 代码检索、替换

1. visual模式下选中一段文本，按`ctrl + r`，底部命令行会自动填写`vimgrep`检索命令。打开一个Quickfix窗口查看结果：可以通过`ctrl + UP`打开一个新的tab，然后键入命名`:copen`（或快捷键`\;`）打开，`:cclose`（或快捷键`\'`关闭Quickfix窗口）
2. visual模式下选中一段文本，按`ctrl + h`，底部命令行会自动填写`git grep`检索命令（如果是在一个Git版本库下）。git grep支持跨分支或针对指定commit进行查找，且检索速度极快。

        " 将查询串保存在寄存器j中
        " 1. 执行git log以输出历史commit的SHA1
        " 2. 对每次commit执行git grep查询
        vmap <C-h> "jy:!for rev in $(git log --pretty="\%h"); do git grep <C-r>j $rev; done<CR>

3. visual模式下选中一段文本，按`ctrl + r`，底部命令行会自动填写文本替换命令，在光标所在处输入替换串，回车后按照提示进行替换操作。

#### 版本管理集成

1. 集成 [vim-fugitive](https://github.com/tpope/vim-fugitive)
2. 支持关闭文件后再次打开保存undo历史（要求VIM版本高于7.3）及光标位置
3. Git Log查看：快捷键`\gg`或`\gl`，效果如下

<img src="/images/vim-log.png" alt="vim-log">

#### 轻量级模板

1. 对于`.sh`或`.py`文件，支持自动插入文件头注释，快捷键为tpl，格式如下：

        #!/bin/bash
        #===========================================================================
        # File: <filename>
        #
        # Ver 1.0, <date: yyyy-mm-dd> Wang Yaohui, Create file.
        #===========================================================================

#### 其他特性（依赖plugins）

1. `F3`打开/关闭目录浏览窗
2. `F4`打开/关闭当前代码中的符号列表
3. `F7`注释掉当前光标所在语句，`F8`对于当前光标所在语句进行注释/打开注释
4. `F12`生成tags文件（ctags）
5. `ctrl + up/down/left/right`对编辑器窗口进行操作
6. 支持Zen-coding，支持以256色显示CSS文件的color值
7. `ctrl + j`格式化压缩后的javascript/json文件
8. 支持代码补全
9. ...

<img src="/images/vim-color.png" alt="vim-color">

#### JavaScript 支持 [2015/11]

##### 1. 安装 **tern_for_vim**:

1. 通过 Vundle 安装 `Plugin 'ternjs/tern_for_vim'`，并 `BundleInstall`
2. 进入 `~/.vim/bundle/tern_for_vim/` 执行 `npm install`
3. 全局安装 **tern**: `npm install tern -g`
4. 安装 **jsctags**（依赖 Tern）: `npm install -g git+https://github.com/ramitos/jsctags.git`

借助 **jsctags**, **Tagbar** 可以显示更详细的 JavaScript 符号信息。**jsctags** 同样可以生成 tags 文件：

```
# on OSX
# brew install gnu-sed findutils
# alias find=gfind
# alias sed=gsed
find . -type f -iregex .*\.js$ -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags
```

不过 JavaScript 函数跳转等使用 `Tern` 相关命令效果更佳

- 整行补全: `<C-X><C-L>`
- 文件名补全: `<C-X><C-F>`

##### 2. 参考资料

- JavaScript 高级补全: <http://efe.baidu.com/blog/vim-javascript-completion/>
- Tern: Intelligent JavaScript tooling: <http://ternjs.net/>
- Tern_for_VIM: <https://github.com/ternjs/tern_for_vim>
