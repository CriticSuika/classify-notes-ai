import 'package:flutter/material.dart';

import 'package:software_studio_project/model/model_message.dart';

import 'package:software_studio_project/service/service_assistant.dart';
import 'package:software_studio_project/global.dart';
import 'package:software_studio_project/widget/widget_wave_animation.dart';

class PageAssist extends StatefulWidget {
  const PageAssist({super.key});

  @override
  State<PageAssist> createState() => _PageAssistState();
}

class _PageAssistState extends State<PageAssist> with WidgetsBindingObserver {
  final TextEditingController _textController = TextEditingController();
  final ChatService _chatService = ChatService();
  bool _onInput = false;

  @override
  void initState() {
    super.initState();
    _chatService.fetchMessages();
    WidgetsBinding.instance.addObserver(this);
    _textController.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    setState(() {
      _onInput = _textController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: _onInput ? 0.4 : 1,
          child: StreamBuilder<List<ChatMessage>>(
            stream: _chatService.messagesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                int num = snapshot.data!.length + 2;
                return ListView.builder(
                  reverse: true,
                  itemCount: num,
                  itemBuilder: (context, index) {
                    if (index == 0) {

                      return const SizedBox(height: 16);
                    } else if (index == num - 1) {

                      return Column(
                        children: [
                          const SizedBox(height: 96),
                          WaveAnimation(
                            size:
                                (appWidth < appHeight ? appWidth : appHeight) *
                                    0.2,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                            centerChild: Image.asset('assets/ai.png',
                                      width: 32, height: 32),
                          ),
                          Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.8),
                            thickness: 1.2,
                            indent: 42,
                            endIndent: 42,
                          ),
                        ],
                      );
                    }
                    final message = snapshot.data![index - 1];
                    return message.role == 'user'
                        ? ListTile(
                            title: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      userAvatarUrl,
                                    ),
                                  radius: 16,)
                                )),
                            subtitle: Row(
                              children: [
                                const Expanded(
                                  flex: 3,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.8)),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(0.7)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          message.text,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          )
                        : ListTile(
                            title: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/ai.png',
                                      width: 32, height: 32),
                                )),
                            subtitle: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.4)),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    message.text,
                                  ),
                                )),
                          );
                  },
                );
              } else {
                return const Center(
                    child: Text('Enter a prompt to get a response'));
              }
            },
          ),
        ),
        Opacity(
          opacity: _onInput ? 1 : 0.7,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(48, 16, 48, 8),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),

                color: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,

                      maxLines: null,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  IconButton(
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          _chatService
                              .fetchPromptResponse(_textController.text.trim());
                          _textController.clear();
                        }
                      },
                      icon: Icon(Icons.send,
                          color: Theme.of(context).colorScheme.primary))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
