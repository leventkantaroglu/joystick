import 'package:flutter/material.dart';

enum Directions { up, down, right, left }

enum JoystickModes { all, horizontal, vertical }

class Joystick extends StatefulWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double opacity;
  final double size;
  final bool isDraggable;
  final JoystickModes joystickMode;
  // callbacks
  final VoidCallback onUpPressed;
  final VoidCallback onDownPressed;
  final VoidCallback onRightPressed;
  final VoidCallback onLeftPressed;
  final Function(Directions) onPressed;
  //
  Joystick(
      {this.backgroundColor,
      this.iconColor,
      this.opacity,
      this.isDraggable,
      @required this.size,
      this.joystickMode,
      this.onUpPressed,
      this.onDownPressed,
      this.onLeftPressed,
      this.onRightPressed,
      this.onPressed})
      : assert(size != null),
        assert(isDraggable != null);
  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  double _x = 0;
  double _y = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: _y,
          right: _x,
          child: GestureDetector(
            onLongPress: (widget.isDraggable==false)?null:(){
              setState(() {
                _x=0;
                _y=0;
              });
            },
                      child: Container(
              height: widget.size,
              width: widget.size,
              decoration: BoxDecoration(
                  color:
                      widget.backgroundColor.withOpacity(widget.opacity ?? 1) ??
                          Colors.grey.withOpacity(widget.opacity ?? 1),
                  shape: BoxShape.circle),
              child: Column(children: [
                // up
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        child: (widget.joystickMode == JoystickModes.horizontal)
                            ? SizedBox()
                            : IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: widget.iconColor ?? Colors.black,
                                ),
                                onPressed: () {
                                  if (widget.onUpPressed != null)
                                    widget.onUpPressed();
                                  if (widget.onPressed != null)
                                    widget.onPressed(Directions.up);
                                },
                              ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
                // middle
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: (widget.joystickMode == JoystickModes.vertical)
                            ? SizedBox()
                            : IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: widget.iconColor ?? Colors.black,
                                ),
                                onPressed: () {
                                  if (widget.onLeftPressed != null)
                                    widget.onLeftPressed();
                                  if (widget.onPressed != null)
                                    widget.onPressed(Directions.left);
                                },
                              ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Icon(
                            Icons.drag_handle,
                            color: widget.iconColor ?? Colors.black,
                          ),
                          onPanUpdate: (_values) {
                            if (widget.isDraggable == true) {
                              setState(() {
                                _x -= _values.delta.dx;
                                _y -= _values.delta.dy;
                              });
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: (widget.joystickMode == JoystickModes.vertical)
                            ? SizedBox()
                            : IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: widget.iconColor ?? Colors.black,
                                ),
                                onPressed: () {
                                  if (widget.onRightPressed != null)
                                    widget.onRightPressed();
                                  if (widget.onPressed != null)
                                    widget.onPressed(Directions.right);
                                },
                              ),
                      )
                    ],
                  ),
                ),
                // down
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        child: (widget.joystickMode == JoystickModes.horizontal)
                            ? SizedBox()
                            : IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: widget.iconColor ?? Colors.black,
                                ),
                                onPressed: () {
                                  if (widget.onDownPressed != null)
                                    widget.onDownPressed();
                                  if (widget.onPressed != null)
                                    widget.onPressed(Directions.down);
                                },
                              ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        )
      ],
    );
  }
}
