import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_finder/pages/home/path_finder_provider.dart';
import 'package:path_finder/utils.dart';
import 'package:path_finder/widget/hint.dart';
import 'package:path_finder/widget/node_field.dart';
import 'package:provider/provider.dart';

class PathFinderPage extends StatelessWidget {
  const PathFinderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PathFinderProvider(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              // Android
              statusBarIconBrightness: Brightness.dark,
              // IOS
              statusBarBrightness: Brightness.light,
            ),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 5,
                  ),
                  child: Text(
                    'Path',
                    style: Utils.bodyStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Utils.primaryColor,
                  ),
                  child: Text(
                    'Finder',
                    style: Utils.bodyStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<PathFinderProvider>()
                              .changeClickState(ClickState.start);
                        },
                        child: const Text("Select Start Point"),
                        style: ElevatedButton.styleFrom(
                          primary: Utils.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<PathFinderProvider>()
                              .changeClickState(ClickState.finish);
                        },
                        child: const Text("Select End Point"),
                        style: ElevatedButton.styleFrom(
                          primary: Utils.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<PathFinderProvider>()
                          .changeClickState(ClickState.wall);
                    },
                    child: const Text("Select Wall"),
                    style: ElevatedButton.styleFrom(
                      primary: Utils.primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        context.read<PathFinderProvider>().startFindingPath,
                    child: const Text("Start Finding Path"),
                    style: ElevatedButton.styleFrom(
                      primary: Utils.primaryColor,
                    ),
                  ),
                ),
                Consumer<PathFinderProvider>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hint : Select ${provider.currentState}",
                            style: Utils.bodyStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Visibility(
                            visible: provider.isVisualized,
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: ElevatedButton.icon(
                              label: const Text("Clear Board"),
                              icon: const Icon(Icons.delete_outline_rounded),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[400],
                              ),
                              onPressed:
                                  context.read<PathFinderProvider>().clearGrid,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Consumer<PathFinderProvider>(
                  builder: (context, provider, _) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: provider.gridNodes.map((row) {
                          return Row(
                            children: row.map((node) {
                              return GestureDetector(
                                onTap: () => provider.onNodeTapped(node),
                                child: NodeField(node: node),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      Hint(
                        text: "Starting Point",
                        color: Utils.startColor,
                      ),
                      Hint(
                        text: "End Point",
                        color: Utils.endColor,
                      ),
                      Hint(
                        text: "Wall / Barrier",
                        color: Utils.wallColor,
                      ),
                      Hint(
                        text: "Unvisited Path",
                        color: Colors.white,
                      ),
                      Hint(
                        text: "Visited",
                        color: Utils.visitedColor,
                      ),
                      Hint(
                        text: "Shortest Path",
                        color: Utils.shortColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
