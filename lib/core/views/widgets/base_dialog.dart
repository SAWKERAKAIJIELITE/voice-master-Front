import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final Widget image;
  final Widget child;
  final double height;
  final double imagePadding;

  const BaseDialog({super.key, required this.image, required this.child, this.height=260, this.imagePadding=16});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                titlePadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                title: Container(
                  height: 24,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      )),
                ),
                content: Container(
                  height: height-100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(MediaQuery.of(context).viewInsets.bottom==0)  const SizedBox(
                        height: 32,
                      ),
                      child
                    ],
                  ),
                ),
              ),
            ),
           if(MediaQuery.of(context).viewInsets.bottom==0) Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                          color: Colors.black.withOpacity(0.25))
                    ]),
                child: Padding(
                  padding:  EdgeInsets.all(imagePadding),
                  child: image,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
