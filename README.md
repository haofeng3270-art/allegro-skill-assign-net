# Allegro Assign Net

[English](README.en.md)

Cadence Allegro PCB Editor 的 SKILL 脚本。先点选一块铜皮（Shape），或选中一个或多个过孔（Via），再按 **`h` 或 `Shift+H`**，即可启动对应的原生赋网命令。

## 安装和使用

1. 下载 [`lf_assign_native.il`](lf_assign_native.il)，放到固定位置，例如 `C:/allegro-skill/lf_assign_native.il`。
2. 打开 Allegro PCB Editor 和一个设计，在 Allegro 命令行输入以下命令，路径按实际位置修改。

   ```text
   skill load("C:/allegro-skill/lf_assign_native.il")
   ```

3. 在画布上点选一块铜皮、点选一个过孔，或框选多个过孔，按 `h` 或 `Shift+H`。
4. 在右侧 **Options → Assign net name** 选择目标网络，完成后右键选择 **Done**。

如需启动时自动加载，在用户 `pcbenv/allegro.ilinit` 中追加以下一行，保留原有内容。

```lisp
load("C:/allegro-skill/lf_assign_native.il")
```

保存后重启 Allegro。脚本会接管 `h` 和 `Shift+H`。如果 `pcbenv/env` 中已有这两个键的自定义绑定，请移除相应旧绑定。需要停用时，删除自动加载行后重启 Allegro。

## 行为和限制

- 铜皮调用 `Shape Assign Net`，过孔调用 `Via Assign Net`。两种操作都在 Allegro 的原生赋网界面里完成。
- 框选过孔时，可在 **Find** 面板只勾选 **Vias**，避免同时选中走线、焊盘等其他对象。铜皮每次只选一块。
- 给过孔赋网时，脚本将当前选中的过孔直接交给 Allegro 原生命令。给铜皮赋网时，脚本会切到铜皮编辑模式。脚本响应选择事件，没有后台轮询。
- 已在 Windows 版 Allegro PCB Editor 17.4 S039 的 PCB 副本上验证单个过孔、框选多个过孔和单块铜皮赋网。其他版本尚未验证。

## License

[MIT](LICENSE)
