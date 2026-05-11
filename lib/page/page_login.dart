import 'package:flutter/material.dart';

import 'package:software_studio_project/widget/widget_wave_animation.dart';
import 'package:software_studio_project/widget/widget_wavy_border.dart';
import 'package:software_studio_project/global.dart';
import 'package:software_studio_project/service/service_authentication.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool _logining = false;

  @override
  void initState() {
    super.initState();
    _logining = false;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 24, 32),
        child: CustomPaint(
          painter: WavyBorderPainter(Theme.of(context).colorScheme.tertiary),
          child: _logining
              ? Center(
                  child: WaveAnimation(
                      size: (appWidth < appHeight ? appWidth : appHeight) * 0.3,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      centerChild: Icon(Icons.note_alt,
                          size: (appWidth < appHeight ? appWidth : appHeight) *
                              0.1,
                          color: Theme.of(context).colorScheme.primary)),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ClassifyNotesAI',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: appHeight * 0.05),
                    WaveAnimation(
                        size:
                            (appWidth < appHeight ? appWidth : appHeight) * 0.3,
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        centerChild: Icon(Icons.note_alt,
                            size:
                                (appWidth < appHeight ? appWidth : appHeight) *
                                    0.1,
                            color: Theme.of(context).colorScheme.primary)),
                    SizedBox(height: appHeight * 0.1),
                    FilledButton.icon(
                      onPressed: _logInWithGoogle,
                      icon: Image.asset('assets/google.png',
                          width: 16, height: 16),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        foregroundColor: Colors.white,
                      ),
                      label: const Text('Log in with Google'),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                      thickness: 1.2,
                      indent: 96,
                      endIndent: 96,
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                      thickness: 1.2,
                      indent: 136,
                      endIndent: 136,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void _logInWithGoogle() async {
    final authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    try {
      String? tmp;

      setState(() {
        _logining = true;
      });
      tmp = await authenticationService.logInWithGoogle(context);

      if (tmp == null) {
        setState(() {
          _logining = false;
          isLogin.value = false;
        });
      } else {
        setState(() {
          isLogin.value = true;
        });
      }
    } catch (error) {
      debugPrint('Google Sign-in failed with error: $error');
      if (mounted) {
        setState(() {
          isLogin.value = false;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Sign-in failed with error: $error'),
          ),
        );
      }
    }
  }
}
