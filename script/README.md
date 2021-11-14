> Personalize github codespaces
> - <https://github.com/settings/codespaces>
> - <https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles>

### Manual bootstrap 

```bash
cd ..
ln -sf `pwd`/.vimrc ~/.vimrc
ln -sf `pwd`/.ideavimrc ~/.ideavimrc
ln -sf `pwd`/.zshrc ~/.zshrc
ln -sf `pwd`/.tmux.conf ~/.tmux.conf
mkdir -p ~/.hammerspoon
ln -sf `pwd`/init.lua ~/.hammerspoon/init.lua
ln -sf `pwd`/.procs.toml ~/.procs.toml
```

### Chrome Extensions

- OneTab
- JSON Formatter
- Postman Interceptor
- React Developer Tools
- Vimium
    - Custom key mappings:

    ```
    map z restoreTab
    map J scrollFullPageDown
    map K scrollFullPageUp
    umap p
    umap P
    ```
    - Scroll step size: 80px
