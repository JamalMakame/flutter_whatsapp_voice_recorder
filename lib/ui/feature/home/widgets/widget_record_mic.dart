import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecordingMicWidget extends StatefulWidget {
  const RecordingMicWidget({
    Key? key,
    required this.onVerticalScrollComplete,
    required this.onHorizontalScrollComplete,
    required this.onLongPress,
    required this.onLongPressCancel,
    required this.onSend,
    required this.onTapCancel,
  }) : super(key: key);

  final VoidCallback onHorizontalScrollComplete;
  final VoidCallback onLongPress;
  final VoidCallback onLongPressCancel;
  final VoidCallback onSend;
  final VoidCallback onTapCancel;
  final VoidCallback onVerticalScrollComplete;

  @override
  _RecordingMicWidgetState createState() => _RecordingMicWidgetState();
}

class _RecordingMicWidgetState extends State<RecordingMicWidget> {
  bool isHorizontalActionComplete = false;
  bool isVerticalActionComplete = false;
  bool isVerticalScroll = true;
  double micDx = 0;
  double micDy = 0;
  double micWidth = 50;
  double micheight = 50;
  bool showSwipeOptions = false;

  void longPressUpdate(LongPressMoveUpdateDetails longPressData) {
    //determine the direction of the swipe
    if (longPressData.localPosition.direction > 1) {
      isVerticalScroll = false;
    } else {
      isVerticalScroll = true;
    }

    // handle the swipe data and move the mic in vertical direction
    if (isVerticalScroll) {
      if (longPressData.localPosition.dy < 0) {
        if (longPressData.localPosition.dy > -100) {
          setState(() {
            micDy = -longPressData.localPosition.dy;
          });
        } else {
          // reset only once
          if (showSwipeOptions) {
            isVerticalActionComplete = true;
            widget.onVerticalScrollComplete();
            showSwipeOptions = false;
            resetMicPosition();
          }
        }
      } else {
        resetMicPosition();
      }
    }

    // handle the swipe data and move the mic in horizontal direction
    if (!isVerticalScroll) {
      if (longPressData.localPosition.dx < 0) {
        if (longPressData.localPosition.dx > -150) {
          setState(() {
            micDx = -longPressData.localPosition.dx;
          });
        } else {
          // reset only once
          if (showSwipeOptions) {
            isHorizontalActionComplete = true;
            widget.onHorizontalScrollComplete();
            showSwipeOptions = false;
            resetMicPosition();
          }
        }
      } else {
        resetMicPosition();
      }
    }

    // reset mic size when the swipe reaches the vertical bounds
    if (longPressData.localPosition.dy < -100 && micheight != 50) {
      setState(() {
        micWidth = 50;
        micheight = 50;
      });
    }

    // reset mic size when the swipe reaches the horizontal bounds
    if (longPressData.localPosition.dy < -150 && micWidth != 50) {
      setState(() {
        micWidth = 50;
        micheight = 50;
      });
    }
  }

  void resetMicPosition() {
    setState(() {
      micDx = 0;
      micDy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 50,
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.00),
                  color: Colors.white),
              width: screenSize.width - 78,
              height: 50,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 70,
          child: Visibility(
            visible: showSwipeOptions,
            child: Shimmer.fromColors(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.chevron_left,
                  ),
                  Text(
                    "swipe to cancel",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              direction: ShimmerDirection.rtl,
              baseColor: Colors.grey.shade500,
              highlightColor: Colors.grey.shade300,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 70,
          child: Visibility(
            visible: isVerticalActionComplete,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isVerticalActionComplete = false;
                });
                widget.onTapCancel();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          right: 0,
          child: Visibility(
            visible: showSwipeOptions,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.00),
                color: Colors.white,
              ),
              child: Shimmer.fromColors(
                child: const Icon(
                  Icons.lock_rounded,
                  size: 30,
                ),
                baseColor: Colors.grey.shade500,
                highlightColor: Colors.grey.shade300,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: micDy,
          right: micDx,
          child: GestureDetector(
            // this is used when the recording is locked and you want to save the audio
            onTap: () {
              if (isVerticalActionComplete) {
                setState(() {
                  isVerticalActionComplete = false;
                });
                widget.onSend();
              }
            },

            onLongPress: () {
              widget.onLongPress();
              isVerticalActionComplete = false;
              isHorizontalActionComplete = false;

              setState(() {
                micWidth = 60;
                micheight = 60;
                showSwipeOptions = true;
              });
            },

            onLongPressEnd: (LongPressEndDetails lg) {
              setState(() {
                micWidth = 50;
                micheight = 50;
                micDy = 0;
                micDx = 0;
                showSwipeOptions = false;
              });
              if (!isVerticalActionComplete && !isHorizontalActionComplete) {
                widget.onLongPressCancel();
              }
            },

            onLongPressMoveUpdate: (LongPressMoveUpdateDetails longPressData) {
              longPressUpdate(longPressData);
            },

            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.00),
                  color: Colors.teal),
              width: micWidth,
              height: micheight,
              child: Icon(
                isVerticalActionComplete ? Icons.send : Icons.mic,
                color: Colors.teal[50],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
