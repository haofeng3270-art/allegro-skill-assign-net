; Allegro PCB Editor 17.4. Route h and H to the native command for the selected object.
when(boundp('lfAssignNativeHook) && lfAssignNativeHook
  axlTriggerClear('select 'lfAssignNativeSelection)
)
lfAssignNativeTarget = nil

procedure(lfAssignNativeSelection(event)
  let((selected item kind point)
    case(car(event)
      (select
        selected = axlGetSelSet()
        unless(selected selected = cadr(event))
        when(selected
          item = car(selected)
          kind = item->objType
          point = if(kind == "via" then item->xy else axlLastPick(nil))
          lfAssignNativeTarget = when(length(selected) == 1 && point &&
            (kind == "via" ||
              (kind == "shape" && !item->cavity && item->layer &&
                member(car(parseString(item->layer "/")) '("ETCH" "BOUNDARY"))))
            list(axlGetDrawingName() item point)
          )
        ))
      (deselect
        when(member(cadr(lfAssignNativeTarget) cadr(event))
          lfAssignNativeTarget = nil
        ))
    )
  )
)

procedure(lfAssignNative()
  let((target item point)
    target = lfAssignNativeTarget
    item = cadr(target)
    point = caddr(target)
    cond(
      (!item || !equal(car(target) axlGetDrawingName())
        printf("Select one via or copper shape on the board, then press H.\n"))
      (item->objType == "via"
        axlShellPost(sprintf(nil "etchedit; _prepopup %.8f %.8f; _pop dyn_option_select '@:@Assign net to via'"
          car(point) cadr(point))))
      (item->objType == "shape"
        axlShellPost(sprintf(nil "shapeedit; _prepopup %.8f %.8f; _pop dyn_option_select '@:@Assign net'"
          car(point) cadr(point))))
      (t printf("Select the via or copper shape again, then press H.\n"))
    )
    t
  )
)

lfAssignNativeHook = axlTriggerSet('select 'lfAssignNativeSelection)
axlSetFunckey("h" "skill lfAssignNative()")
axlSetFunckey("H" "skill lfAssignNative()")
