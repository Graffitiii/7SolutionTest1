// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '7Solution',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '7Solution'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = ScrollController();
  ScrollController _circleController = ScrollController();
  ScrollController _squareController = ScrollController();
  ScrollController _crossController = ScrollController();
  List<Map<String, int>> fibonacciList = [];
  List<Map<String, int>> circleType = [];
  List<Map<String, int>> crossType = [];
  List<Map<String, int>> squareType = [];
  int highlightIndex = -1;
  int highlightCircle = -1;
  int highlightSquare = -1;
  int highlightCross = -1;

  int start = 0;

  @override
  void initState() {
    createFibonacci();
  }

  void createFibonacci() {
    for (var i = 0; i < 40; i++) {
      if (i == 0 || i == 1) {
        fibonacciList.add({'Index': i, 'Number': start});
        setState(() {
          start++;
        });
      } else {
        fibonacciList.add({
          'Index': i,
          'Number':
              fibonacciList[i - 2]['Number']! + fibonacciList[i - 1]['Number']!
        });
      }
    }
    print(fibonacciList);
  }

  Widget returnSymbol(fibonacciNumber) {
    if (fibonacciNumber % 3 == 0) {
      return Icon(Icons.circle);
    } else if (fibonacciNumber % 3 == 1) {
      return Icon(Icons.square);
    } else if (fibonacciNumber % 3 == 2) {
      return Icon(Icons.close);
    } else {
      return SizedBox();
    }
  }

  Future<void> addToGroup(index, fibonacciNumber) async {
    setState(() {
      fibonacciList.removeWhere((item) => item['Number'] == fibonacciNumber);
    });

    if (fibonacciNumber % 3 == 0) {
      setState(() {
        circleType.add({'Index': index, 'Number': fibonacciNumber});

        if (circleType.length >= 2) {
          circleType.sort((a, b) => a['Number']!.compareTo(b['Number']!));
        }
      });

      for (int i = 0; i < circleType.length; i++) {
        if (circleType[i]['Number'] == fibonacciNumber) {
          highlightCircle = i;
          break;
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _circleController.animateTo(
          highlightCircle * 50,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ListView.builder(
              controller: _circleController,
              itemCount: circleType.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: circleType[index]['Number'] == fibonacciNumber
                      ? Colors.green
                      : null,
                  title: Text('Number: ${circleType[index]['Number']}'),
                  subtitle: Text('Index: ${circleType[index]['Index']}'),
                  trailing: returnSymbol(circleType[index]['Number']),
                  onTap: () async {
                    await removeFromGroup(circleType[index]['Index'],
                        circleType[index]['Number'], 'circle');
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          });
    } else if (fibonacciNumber % 3 == 1) {
      setState(() {
        squareType.add({'Index': index, 'Number': fibonacciNumber});

        if (squareType.length >= 2) {
          squareType.sort((a, b) => a['Number']!.compareTo(b['Number']!));
        }
      });

      for (int i = 0; i < squareType.length; i++) {
        if (squareType[i]['Number'] == fibonacciNumber) {
          highlightSquare = i;
          break;
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _squareController.animateTo(
          highlightSquare * 50,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ListView.builder(
              controller: _squareController,
              itemCount: squareType.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: squareType[index]['Number'] == fibonacciNumber
                      ? Colors.green
                      : null,
                  title: Text('Number: ${squareType[index]['Number']}'),
                  subtitle: Text('Index: ${squareType[index]['Index']}'),
                  trailing: returnSymbol(squareType[index]['Number']),
                  onTap: () async {
                    await removeFromGroup(squareType[index]['Index'],
                        squareType[index]['Number'], 'square');
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          });
    } else if (fibonacciNumber % 3 == 2) {
      setState(() {
        crossType.add({'Index': index, 'Number': fibonacciNumber});
        if (crossType.length >= 2) {
          crossType.sort((a, b) => a['Number']!.compareTo(b['Number']!));
        }
      });
      for (int i = 0; i < crossType.length; i++) {
        if (crossType[i]['Number'] == fibonacciNumber) {
          highlightCross = i;
          break;
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _crossController.animateTo(
          highlightCross * 50,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ListView.builder(
              controller: _crossController,
              itemCount: crossType.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: crossType[index]['Number'] == fibonacciNumber
                      ? Colors.green
                      : null,
                  title: Text('Number: ${crossType[index]['Number']}'),
                  subtitle: Text('Index: ${crossType[index]['Index']}'),
                  trailing: returnSymbol(crossType[index]['Number']),
                  onTap: () async {
                    await removeFromGroup(crossType[index]['Index'],
                        crossType[index]['Number'], 'cross');
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          });
    }
    // print(fibonacciList);
  }

  Future<void> removeFromGroup(index, fibonacciNumber, type) async {
    if (type == 'circle') {
      setState(() {
        circleType.removeWhere((item) => item['Number'] == fibonacciNumber);
      });
    } else if (type == 'square') {
      setState(() {
        squareType.removeWhere((item) => item['Number'] == fibonacciNumber);
      });
    } else if (type == 'cross') {
      setState(() {
        crossType.removeWhere((item) => item['Number'] == fibonacciNumber);
      });
    }

    setState(() {
      fibonacciList.add({'Index': index, 'Number': fibonacciNumber});
      if (fibonacciList.length >= 2) {
        fibonacciList.sort((a, b) => a['Number']!.compareTo(b['Number']!));
      }
    });

    for (int i = 0; i < fibonacciList.length; i++) {
      if (fibonacciList[i]['Number'] == fibonacciNumber) {
        highlightIndex = i;
        break;
      }
    }

    print(highlightIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        highlightIndex * 50,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      print(_scrollController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: fibonacciList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: ListTile(
                tileColor: highlightIndex == index ? Colors.red : null,
                title: Text(
                    'Index: ${fibonacciList[index]['Index']}, Number: ${fibonacciList[index]['Number']}'),
                trailing: returnSymbol(fibonacciList[index]['Number']),
                onTap: () {
                  addToGroup(fibonacciList[index]['Index'],
                      fibonacciList[index]['Number']);
                },
              ),
            );
          },
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
