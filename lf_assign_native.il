; Allegro PCB Editor 17.4. Route h and H to the native command for the selection.
when(boundp('lfAssignNativeHook) && lfAssignNativeHook
  axlTriggerClear('select 'lfAssignNativeSelection)
)
lfAssignNativeTarget = nil

procedure(lfAssignNativeSelection(event)
  let((selected removed)
    case(car(event)
      (select
        selected = axlGetSelSet()
        unless(selected selected = cadr(event))
        when(selected
          lfAssignNativeTarget = list(axlGetDrawingName() selected axlLastPick(nil))
        ))
      (deselect
        when(lfAssignNativeTarget
          removed = cadr(event)
          selected = setof(item cadr(lfAssignNativeTarget) !member(item removed))
          lfAssignNativeTarget = when(selected
            list(car(lfAssignNativeTarget) selected caddr(lfAssignNativeTarget))
          )
        ))
    )
  )
)

procedure(lfAssignNative()
  let((target selected item point)
    target = lfAssignNativeTarget
    selected = cadr(target)
    item = car(selected)
    point = caddr(target)
    cond(
      (!item || !equal(car(target) axlGetDrawingName())
        printf("Select one or more vias or one copper shape on the board, then press H.\n"))
      (forall(via selected via->objType == "via")
        axlShellPost("via assign net"))
      (length(selected) == 1 && item->objType == "shape" &&
       !item->cavity && item->layer && point &&
       member(car(parseString(item->layer "/")) '("ETCH" "BOUNDARY"))
        axlShellPost(sprintf(nil "shapeedit; _prepopup %.8f %.8f; _pop dyn_option_select '@:@Assign net'"
          car(point) cadr(point))))
      (t printf("Select only vias or a single copper shape, then press H.\n"))
    )
    t
  )
)

lfAssignNativeHook = axlTriggerSet('select 'lfAssignNativeSelection)
axlSetFunckey("h" "skill lfAssignNative()")
axlSetFunckey("H" "skill lfAssignNative()")
