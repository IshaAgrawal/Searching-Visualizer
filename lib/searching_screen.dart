import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SearchingScreen extends StatefulWidget {
  @override
  _SearchingScreenState createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  var theList = <int>[];
  String theNum = "";
  var currentIndex = <int>[];
  var checkedIndex = <int>[];
  double sliderValue = 10.0;
  String labelText = 'Start Sorting';
  int setSpeed = 300;
  bool isSearchingON = false;
  static const itemMenu = <String>[
    'Linear Searching',
    'Binary Searching',
  ];
  String selectedAlgorithm = itemMenu[0];
  int arrowIndex = 0;

  @override
  void initState() {
    shuffle();
    super.initState();
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Input Error!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Please Enter a Number!"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15.0),
            primary: Theme.of(context).primaryColor,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Search It!'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: Icon(
                Icons.wifi_protected_setup_outlined,
                size: 25.0,
                color: isSearchingON ? Colors.blueGrey : Colors.white,
              ),
              onPressed: isSearchingON
                  ? null
                  : () {
                shuffle(value: sliderValue);
              }),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              //the settings icon padding
              child: GestureDetector(
                onTap: isSearchingON
                    ? null
                    : () => showModalBottomSheet(
                    context: context,
                    builder: (context) => buildBottomSheet(context)),
                child: Icon(
                  Icons.add,
                  size: 30.0,
                  color: isSearchingON ? Colors.blueGrey : Colors.white,
                ),
              ))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.black,
            ),
            margin: EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: BarChart(
                  barData(),
                  swapAnimationDuration: Duration(milliseconds: 200),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.black,
            ),
            height: 45.0, //the working box
            margin: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                labelText, //Just Shuffled
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: arrowIndex == 0
                    ? null
                    : () {
                  setState(() {
                    arrowIndex--;
                    selectedAlgorithm = itemMenu[arrowIndex];
                  });
                },
                child: Icon(
                  Icons.chevron_left,
                  color: arrowIndex == 0 ? Colors.blueGrey : Colors.blue,
                  size: 30.0,
                ),
              ),
              Container(
                //the algo selector box
                width: 200,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Center(
                  child: Text(
                    selectedAlgorithm,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: arrowIndex == itemMenu.length - 1
                    ? null
                    : () {
                  setState(() {
                    arrowIndex++;
                    selectedAlgorithm = itemMenu[arrowIndex];
                  });
                },
                child: Icon(
                  Icons.chevron_right,
                  color: arrowIndex == itemMenu.length - 1
                      ? Colors.blueGrey
                      : Colors.blue,
                  size: 30.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 130,
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  onChanged: (text) {
                    theNum = text;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Enter Value',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: isSearchingON
                          ? null
                          : () {
                        setState(() {
                          isSearchingON = true;
                        });
                        if (theNum.isEmpty ||
                            !theNum.contains(RegExp("[0-9]"))) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                          setState(() {
                            isSearchingON = false;
                          });
                        }
                        startSearching();
                      },
                      icon: Icon(
                        Icons.sort,
                        // size: 23.0,
                        color: isSearchingON ? Colors.blueGrey : Colors.white,
                      ),
                      label: Text('Search',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: isSearchingON
                                  ? Colors.blueGrey
                                  : Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  BarChartData barData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
          margin: 10,
          getTitles: (double value) {
            return theList[value.toInt()].toString();
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(sliderValue.toInt(), (i) {
        return makeGroupData(i, theList[i].toDouble() + 6,
            barColor: getBarColor(i));
      }),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        Color barColor = Colors.white,
        double width = 13,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            colors: [Colors.white12],
            y: 25,
          ),
        )
      ],
    );
  }

  Container buildBottomSheet(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.black,
      child: Container(
        padding: EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(12.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Settings',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'Array Length',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Slider(
                  value: sliderValue,
                  onChanged: (double value) {
                    setState(() {
                      shuffle(value: value);
                    });
                  },
                  label: sliderValue.toString(),
                  min: 8,
                  max: 17,
                  divisions: 7,
                );
              },
            ),
            Text(
              'Speed',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Slider(
                  value: setSpeed.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      updateSpeed(value.toInt());
                    });
                  },
                  label: setSpeed.toString(),
                  min: 200,
                  max: 1000,
                  divisions: 8,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void linearSearch() async {
    int i;
    //var rng = new Random();
    var myInt = int.parse(theNum);
    assert(myInt is int);
    int n = theList.length;
    int target = myInt;
    updateLabelText("Let's search for $target");
    await Future.delayed(Duration(milliseconds: 1500));
    for (i = 0; i < n; i++) {
      if (!isSearchingON) {
        break;
      }
      setCurrentIndex([i]);
      updateLabelText("Is ${theList[i]} Equal to $target ");
      await Future.delayed(Duration(milliseconds: setSpeed));
      if (theList[i] == target) {
        endSearching();
        break;
      } else {
        setCheckedIndex(i);
        updateLabelText("No, so let's move ahead");
      }
      await Future.delayed(Duration(milliseconds: setSpeed));
    }
    if (!isSearchingON) {
      updateLabelText('Element found at index $i');
    } else {
      updateLabelText('Element Not Found!');
    }
    endSearching();
  }

  void binarySearch() async {
    int mid = 0, high, low, i;
    theList.sort();
    var myInt = int.parse(theNum);
    assert(myInt is int);
    high = theList.length - 1;
    low = 0;
    int target = myInt;
    updateLabelText("Let's search for $target");
    await Future.delayed(Duration(milliseconds: 1500));
    while (high >= low) {
      if (!isSearchingON) {
        break;
      }
      mid = ((high + low) ~/ 2);
      updateLabelText("is ${theList[mid]} equal to $target ?");
      await Future.delayed(Duration(milliseconds: setSpeed));
      setCurrentIndex([mid]);

      if (theList[mid] == target) {
        await Future.delayed(Duration(milliseconds: 2000));
        endSearching();
        break;
      }
      updateLabelText("No, is ${theList[mid]} < $target ?");
      await Future.delayed(Duration(milliseconds: setSpeed));
      if (theList[mid] < target) {
        for (i = low; i <= mid; i++) {
          setCheckedIndex(i);
        }
        low = mid + 1;
        updateLabelText("yes, so new low is $low");
        await Future.delayed(Duration(milliseconds: setSpeed));
      } else {
        for (i = mid + 1; i <= high; i++) {
          setCheckedIndex(i);
        }
        high = mid;
        updateLabelText("No, so new high is $high");
        await Future.delayed(Duration(milliseconds: setSpeed));
      }
    }
    if (!isSearchingON) {
      updateLabelText('Element found at index $mid');
    } else {
      updateLabelText('Element Not Found!');
    }
    endSearching();
  }

  void shuffle({double value = 10.0}) {
    setState(() {
      sliderValue = value;
    });
    updateLabelText('Just shuffled!');
    theList = List.generate(sliderValue.toInt(), (i) => i + 1);
    theList.shuffle();
  }

  void updateLabelText(String text) {
    setState(() {
      labelText = text;
    });
  }

  void updateSpeed(int speed) {
    setState(() {
      setSpeed = speed;
    });
  }

  void startSearching() {
    switch (selectedAlgorithm) {
      case 'Linear Searching':
        linearSearch();
        break;

      case 'Binary Searching':
        binarySearch();
        break;
    }
  }

  void endSearching() {
    setState(() {
      currentIndex.clear();
      checkedIndex.clear();
      isSearchingON = false;
    });
  }

  void setCurrentIndex(List<int> currentIndexes) {
    setState(() {
      currentIndex = currentIndexes;
    });
  }

  Color getBarColor(int i) {
    if (checkedIndex.contains(i)) {
      return Colors.red;
    } else {
      if (currentIndex.contains(i)) {
        return Colors.green;
      } else {
        return Colors.blue.shade700;
      }
    }
  }

  void setCheckedIndex(int value) {
    setState(() {
      checkedIndex.add(value);
    });
  }
}
