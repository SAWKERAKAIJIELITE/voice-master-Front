import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice/core/app_cubit/base_state.dart';
import 'package:voice/core/utils/general.dart';
import 'dart:async';
import 'dart:io';

import 'package:voice/core/utils/validators.dart';
import 'package:voice/core/views/widgets/main_button.dart';
import 'package:voice/features/home/cubit/upload_cubit.dart';
import 'package:voice/features/home/models/exercise.dart';
import 'package:voice/features/home/views/widgets/audio_player_from_link.dart';
import 'package:voice/features/home/views/widgets/mistake_text_view.dart';

import '../../../../core/di/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final uploadCubit = getIt<UploadCubit>();
  TextEditingController controllerText = TextEditingController();

  bool _isRecorderInitialized = false;
  bool _isRecording = false;
  bool _isPlaying = false;

  String _recordedPath = '';

  @override
  void initState() {
    super.initState();
    _initPaths();
    _initRecorder();
    _initPlayer();
  }

  Future<void> _initPaths() async {
    final tempDir = await getTemporaryDirectory();
    setState(() {
      _recordedPath =
          '${tempDir.path}/${DateTime.now().toIso8601String().replaceAll(':', '-')}.aac';
    });
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Microphone permission not granted');
    }

    await _recorder.openRecorder();
    setState(() {
      _isRecorderInitialized = true;
    });
  }

  Future<void> _initPlayer() async {
    await _player.openPlayer();
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized) return;

    await _recorder.startRecorder(toFile: _recordedPath);
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _playRecording() async {
    if (_isPlaying) {
      await _player.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } else {
      if (!File(_recordedPath).existsSync()) return;

      await _player.startPlayer(
        fromURI: _recordedPath,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );

      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(padding: EdgeInsets.all(16), children: [
          TextFormField(
            controller: controllerText,
            decoration: const InputDecoration(
                hintText: 'ادخل النص', contentPadding: EdgeInsets.all(16)),
            validator: Validators.validateEmpty,
            minLines: 4,
            maxLines: 6,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                label:
                    Text(_isRecording ? 'إيقاف التسجيل' : 'بدأ التسجيل'),
                onPressed: _isRecording ? _stopRecording : _startRecording,
              ),
              ElevatedButton.icon(
                icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                label: Text(_isPlaying ? 'إيقاف التشغيل' : 'بدأ التشغيل'),
                onPressed: !_isRecording ? _playRecording : null,
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<UploadCubit, BaseState<ExerciseModel>>(
            bloc: uploadCubit,
            builder: (context, state) => state.maybeWhen(
                orElse: () => MainButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          final audio = File(_recordedPath);
                          if (!audio.existsSync()) {
                            showToast(message: 'لم تقم بتسجيل ملف صوتي');
                            return;
                          }
                          uploadCubit.upload(
                              audio: audio, text: controllerText.text);
                        } else {
                          HapticFeedback.vibrate();
                        }
                      },
                      title: 'اختبار',
                    ),
                loading: () => MainButton(
                      isLoading: true,
                      title: '',
                      onPressed: () {},
                    ),
                loaded: (data) {
                  data as ExerciseModel;
                  return Column(
                    children: [
                      MainButton(
                        onPressed: () {
                          _initPaths();
                          uploadCubit.backToInit();
                        },
                        title: 'إعادة الأختبار',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'النتيجة:',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MistakeTextView(
                          text: data.exercise?.text?.text ?? '',
                          mistakes: data.exercise?.mistakes ?? []),
                      const SizedBox(
                        height: 16,
                      ),
                      AudioPlayerFromLink(url: data.correctPronounceFile??''),
                    ],
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
