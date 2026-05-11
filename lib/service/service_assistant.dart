import 'dart:async';
import 'dart:convert';
import 'package:software_studio_project/model/model_message.dart';
import 'package:http/http.dart' as http;

class ChatService {

  static const String _apiKey = '';
  static const String _assistantId = '';
  static const String _threadId = '';
  static const String _baseUrl = 'https://api.openai.com/v1';
  static const String _messagesUrl = '$_baseUrl/threads/$_threadId/messages';
  static const String _runsUrl = '$_baseUrl/threads/$_threadId/runs';

  final _messagesStreamController =
      StreamController<List<ChatMessage>>.broadcast();

  List<ChatMessage> _messages = [];

  Stream<List<ChatMessage>> get messagesStream =>
      _messagesStreamController.stream;

  Future<void> fetchMessages() async {
    var response = await http.get(
      Uri.parse(_messagesUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'OpenAI-Beta': 'assistants=v1',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch messages: ${response.statusCode}');
    }

    var responseData = json.decode(utf8.decode(response.bodyBytes));
    _messages = [
      for (var message in responseData['data'])
        ChatMessage(
          role: message['role'],
          text: message['content'][0]['text']['value'],
        )
    ];
    _messagesStreamController.add(_messages);
  }

  Future<void> fetchPromptResponse(String prompt) async {
    _messages.insert(0, ChatMessage(role: 'user', text: prompt));
    _messages.insert(
      0,
      ChatMessage(role: 'assistant', text: 'Generating response...'),
    );
    _messagesStreamController.add(List.from(_messages));

    var promptResponse = await http.post(
      Uri.parse(_messagesUrl),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $_apiKey',
        'OpenAI-Beta': 'assistants=v1',
      },
      body: jsonEncode({
        'role': 'user',
        'content': prompt,
      }),
    );

    if (promptResponse.statusCode != 200) {
      throw Exception('Failed to add prompt: ${promptResponse.statusCode}');
    }

    var runResponse = await http.post(
      Uri.parse(_runsUrl),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $_apiKey',
        'OpenAI-Beta': 'assistants=v1',
      },
      body: jsonEncode({
        'assistant_id': _assistantId,

      }),
    );

    if (runResponse.statusCode != 200) {
      throw Exception('Failed to create a run: ${runResponse.statusCode}');
    }

    var runData = json.decode(runResponse.body);
    var runId = runData['id'];
    String runStatusUrl = '$_baseUrl/threads/$_threadId/runs/$runId';
    while (true) {

      await Future.delayed(Duration(seconds: 2));

      var runStatusResponse = await http.get(
        Uri.parse(runStatusUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json; charset=utf-8',
          'OpenAI-Beta': 'assistants=v1',
        },
      );
      if (runStatusResponse.statusCode != 200) {
        throw Exception(
            'Failed to query run status: ${runStatusResponse.statusCode}');
      }
      var runStatusData = json.decode(runStatusResponse.body);
      var runStatus = runStatusData['status'];
      if (runStatus == 'cancelled' ||
          runStatus == 'failed' ||
          runStatus == 'expired') {
        throw Exception('Run failed: ${runStatusData['status']}');
      }

      if (runStatus == 'requires_action') {
        _messages[0] =
            ChatMessage(role: 'assistant', text: 'Performing action...');
        _messagesStreamController.add(List.from(_messages));
      }
      if (runStatus == 'completed') {
        break;
      }
    }

    await fetchMessages();
  }

  void dispose() {
    _messagesStreamController.close();
  }
}
