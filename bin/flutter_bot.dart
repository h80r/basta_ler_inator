import 'package:nyxx/nyxx.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

import 'utils/flutter_search.dart';
import 'utils/date_time_ex.dart';

void main(List<String> arguments) {
  dotenv.load();

  final bot = Nyxx(
    dotenv.env['DISCORD_TOKEN']!,
    GatewayIntents.allUnprivileged,
  );

  bot.onReady.listen((event) {
    print('${bot.self.username} has connected to Discord!');
  });

  bot.onMessageReceived.listen((event) async {
    final msg = event.message;
    final channel = msg.channel;

    if (msg.author.id == bot.self.id) return;

    if (msg.content == 'tomou um basta ler') {
      await channel
          .sendMessage(MessageBuilder.content(msg.createdAt.readableTime()));
      final toDelete = await channel
          .downloadMessages(limit: 20, before: msg.id)
          .where((message) => message.author.id == bot.self.id)
          .toList();
      toDelete.forEach((message) => message.delete());
    }

    if (msg.content.startsWith('basta ler')) {
      await search(msg.content).then(
        (value) {
          channel.startTypingLoop();
          value?.forEach(
            (element) => channel.sendMessage(
              MessageBuilder.embed(
                EmbedBuilder()
                  ..title = element.title
                  ..description = element.description
                  ..url = element.url,
              ),
            ),
          );
          channel.stopTypingLoop();
        },
      );
    }
  });
}
