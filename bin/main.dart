import 'package:dart_cli_chatai/models/gemini_response.dart';
import 'package:dart_cli_chatai/services/spinner_service.dart';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

final env = DotEnv()..load(['../.env']);
const reset = '\x1B[0m';
const blue = '\x1B[34m';
const green = '\x1B[32m';
const gray = '\x1B[90m';
const red = '\x1B[31m';

void main() async {
  print('\n--- Dart CLI Chat with ${env['AI']}---');
  await shootEffect("Starting please wait ", 10);
  showMenu();
}

void showMenu() async {
  while (true) {
    stdout.writeln('${reset} Press Enter to continue Chat or (q) to close: ');
    final choice = stdin.readLineSync();
    if (choice == null || choice.isEmpty) {
      stdout.write('\x1B[2K\r');
      await generateContent();
    } else if (choice.toLowerCase() == 'q') {
      print("${reset}👋 Exiting... Credit by hyvercode.com");
      exit(0);
    } else {
      print("${reset}❌ Invalid input. Press Enter or type 'q'.");
    }
  }
}

Future<void> generateContent() async {
  stdout.write('${blue}👤 Prompt:$green\n   ');
  final prompt = stdin.readLineSync() ?? '';

  if (prompt.trim().isEmpty) {
    print('${red} Prompt cannot be empty ❌');
    print('\n');
    return;
  }

  // Start spinner (does not block)
  final spinnerService = SpinnerService();
  spinnerService.start();
  final spinnerTask = spinner(spinnerService);

  var client = http.Client();
  try {
    var response = await client.post(
        Uri.https(
          '${env['AI_URL']}',
          '/v1beta/models/${env['AI_MODEL']}:streamGenerateContent',
          {
            'key': '${env['AI_API_KEY']}',
          },
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': {
            "role": "user",
            "parts": [
              {"text": prompt}
            ]
          },
          "generationConfig": {
            "thinkingConfig": {
              "thinkingBudget": -1,
            },
            "responseMimeType": "text/plain",
          },
        }));

    List<dynamic> decoded = jsonDecode(response.body);

    List<GeminiResponse> responses = decoded
        .map((e) => GeminiResponse.fromJson(e as Map<String, dynamic>))
        .toList();

    if (response.statusCode == 200) {
      List<String> allTexts = [];
      for (var item in responses) {
        for (var candidate in item.candidates) {
          for (var part in candidate.content.parts) {
            allTexts.add(part.text);
          }
        }
      }
      String combinedResponse = allTexts.join(" ");

      // Stop spinner once request is complete
      spinnerService.stop();
      await spinnerTask;

      print('${red}🤖 AI:$green\n   $combinedResponse"\n');
      print('\n');
      print('${gray}✨ Generating...$reset');
      print("${reset}✅ Done!");
    } else {
      print("${reset} Error Request - ${response.statusCode}");
    }
  } finally {
    client.close();
  }
}

Future<void> shootEffect(String message, int count) async {
  for (int i = 0; i < count; i++) {
    stdout.write("$message${'.' * (i % 4)}\r");
    await Future.delayed(Duration(milliseconds: 150));
  }

  stdout.write('\x1B[2K\r');
  print("${reset} ✅ Sytem is ready!");
}
