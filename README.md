> Some of the document could be outdated

[**Update 2021**] [others/README](./others/README.md) 包含了一些杂七杂八的配置，主要的场景：

- 看代码（检索及理解代码）越来越多 (`rg`, `bat`, `diff-so-fancy`)
    - VIM 的 PL Integration 类插件开始逐步减少（重度 Coding 场景下，JetBrains' IDE yyds），但 `fzf`, `tagbar` 等插件越来越香
- 文件检索越来越高频 (`fzf`，包括 fzf-vim 提供的很多模糊搜索的集成能力、如 `Rg` / `GFiles?` 命令)
- 依赖 Window Manager + Alfred 更好快速做焦点的切换和全键盘操作 (`Hammerspoon`)

----

### VIM 配置 [2014]

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

#### 代码检索、替换

1. visual模式下选中一段文本，按`ctrl + r`，底部命令行会自动填写`vimgrep`检索命令。打开一个Quickfix窗口查看结果：可以通过`ctrl + UP`打开一个新的tab，然后键入命名`:copen`（或快捷键`\;`）打开，`:cclose`（或快捷键`\'`关闭Quickfix窗口）
2. visual模式下选中一段文本，按`ctrl + r`，底部命令行会自动填写文本替换命令，在光标所在处输入替换串，回车后按照提示进行替换操作。

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
        # Ver 1.0, <date: yyyy-mm-dd> {whomai}, Create file.
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
