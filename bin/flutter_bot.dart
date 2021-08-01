import 'package:nyxx/nyxx.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

import 'commands/commands.dart';

void main(List<String> arguments) {
  dotenv.load();

  final bot = Nyxx(
    dotenv.env['DISCORD_TOKEN']!,
    GatewayIntents.allUnprivileged,
  );

  bot.onReady.listen((event) {
    print('${bot.self.username} has connected to Discord!');
  });

  bot.onMessageReceived.listen((event) {
    final msg = event.message;

    if (msg.author.id == bot.self.id) return;

    if (msg.content == 'tomou um basta ler') tookARead(msg, bot.self.id);
    if (msg.content.startsWith('basta ler')) justRead(msg);
  });
}
