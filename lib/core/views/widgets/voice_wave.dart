// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class VoiceWave extends StatefulWidget {
//   final int volume; // 0–255
//
//   const VoiceWave({super.key, required this.volume});
//
//   @override
//   State<VoiceWave> createState() => _VoiceWaveState();
// }
//
// class _VoiceWaveState extends State<VoiceWave> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: WavePainter(
//         animationValue: _controller.value,
//         volume: widget.volume,
//       ),
//       size: const Size(80, 20),
//     );
//   }
// }
//
// class WavePainter extends CustomPainter {
//   final double animationValue;
//   final int volume; // 0–255
//
//   WavePainter({required this.animationValue, required this.volume});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = volume > 10 ? Colors.greenAccent : Colors.grey
//       ..strokeWidth = 3
//       ..strokeCap = StrokeCap.round;
//
//     final centerY = size.height / 2;
//     final waveCount = 10;
//     final spacing = size.width / (waveCount + 1);
//
//     final normalizedVolume = (volume / 255).clamp(0.1, 1.0); // scale height
//
//     for (int i = 0; i < waveCount; i++) {
//       final progress = sin(animationValue * 2 * pi + i);
//       final height = centerY * normalizedVolume * (0.5 + progress.abs());
//
//       canvas.drawLine(
//         Offset((i + 1) * spacing, centerY - height / 2),
//         Offset((i + 1) * spacing, centerY + height / 2),
//         paint,
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant WavePainter oldDelegate) =>
//       oldDelegate.animationValue != animationValue || oldDelegate.volume != volume;
// }
