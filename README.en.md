# Allegro Assign Net

[中文说明](README.md)

A Cadence Allegro PCB Editor SKILL script. Select one copper shape or one or more vias, then press **`h` or `Shift+H`** to start the corresponding native net assignment command.

## Installation and usage

1. Download [`lf_assign_native.il`](lf_assign_native.il) and place it in a permanent location, such as `C:/allegro-skill/lf_assign_native.il`.
2. Open Allegro PCB Editor and a design. Enter the following in the Allegro command line, replacing the path with your actual location.

   ```text
   skill load("C:/allegro-skill/lf_assign_native.il")
   ```

3. On the canvas, select one copper shape, click one via, or box-select multiple vias. Press `h` or `Shift+H`.
4. In **Options → Assign net name**, select the target net. Right-click and choose **Done** when finished.

To load the script automatically at startup, append this line to your user `pcbenv/allegro.ilinit` and keep the existing contents.

```lisp
load("C:/allegro-skill/lf_assign_native.il")
```

Save the file and restart Allegro. The script takes over `h` and `Shift+H`. If these keys are already bound in `pcbenv/env`, remove those older bindings. To disable automatic loading, remove the startup line and restart Allegro.

## Behavior and limitations

- Copper shapes use `Shape Assign Net`. Vias use `Via Assign Net`. Both use Allegro's native assignment controls.
- For box selection, enable only **Vias** in the **Find** panel to avoid selecting traces, pins, or other objects. Select one copper shape at a time.
- Via assignment passes the current via selection to the native command. Shape assignment switches to Shape Edit. The script responds to selection events without background polling.
- Single-via, multi-via, and single-shape assignment were verified on PCB copies in Allegro PCB Editor 17.4 S039 for Windows. Other versions have yet to be verified.

## License

[MIT](LICENSE)
