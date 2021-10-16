import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Duration animationDuration, backDuration, pauseDuration;

  MarqueeWidget({
    @required this.child,
    this.animationDuration: const Duration(seconds: 10),
    this.backDuration: const Duration(seconds: 1),
    this.pauseDuration: const Duration(milliseconds: 200),
  });

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: Axis.horizontal,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
        await Future.delayed(widget.pauseDuration);
        if(scrollController.hasClients)
          await scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: widget.animationDuration,
              curve: Curves.ease);
        await Future.delayed(widget.pauseDuration);
        if(scrollController.hasClients)
          await scrollController.animateTo(0.0,
              duration: widget.backDuration, curve: Curves.easeOut);
    }
  }
}