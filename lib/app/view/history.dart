import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/history_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // calcHistoryCheck & calcHistory is getting data
    // from the HistoryProvider
    bool validityCheck =
        !context.read<HistoryProvider>().questionAnswer.remove('');
    List<String> calcHistory =
        context.watch<HistoryProvider>().questionAnswer.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: (validityCheck && calcHistory.isNotEmpty)
          ? ListView.builder(
              itemCount: (calcHistory.length),
              itemBuilder: (BuildContext context, int index) {
                return MyNeumorphicCard(
                  splitHistory: calcHistory[index],
                );
              },
            )
          : const Center(
              child: Icon(
                Icons.history,
                color: Colors.black26,
                size: 200,
              ),
            ),
    );
  }
}

// Custom Neumorphic card ui
class MyNeumorphicCard extends StatelessWidget {
  final String splitHistory;

  const MyNeumorphicCard({Key? key, required this.splitHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var splitHistory0 = splitHistory.toString().split('=')[0];
    var splitHistory1 = splitHistory.toString().split('=')[1];
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 15.0,
        right: 12.0,
      ),
      child: ClayContainer(
        height: 130,
        emboss: true,
        color: Theme.of(context).primaryColor,
        borderRadius: 20.0,
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: FittedBox(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      '$splitHistory0 =',
                      style: const TextStyle(
                        //fontSize: deviceHeight < 670 ? 24 : 34,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: FittedBox(
                  child: Container(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      splitHistory1,
                      style: const TextStyle(
                        //fontSize: deviceHeight < 670 ? 24 : 50,
                        fontSize: 60,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
