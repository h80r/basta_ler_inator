import 'package:nyxx/nyxx.dart';
import '../utils/date_time_ex.dart';

void tookARead(Message msg, Snowflake botId) async {
  final channel = msg.channel;

  await channel
      .sendMessage(MessageBuilder.content(msg.createdAt.readableTime()));
  final toDelete = await channel
      .downloadMessages(limit: 20, before: msg.id)
      .where((message) => message.author.id == botId)
      .toList();
  toDelete.forEach((message) => message.delete());
}
