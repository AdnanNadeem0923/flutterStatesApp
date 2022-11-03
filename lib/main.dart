import 'package:flutter/material.dart';
import 'rest_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: StatesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StatesPage extends StatefulWidget {
  const StatesPage({super.key});

  @override
  _StatesPageState createState() => _StatesPageState();
}

class _StatesPageState extends State<StatesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('States App',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic)),
        centerTitle: true,
      ),
      body: FutureBuilder<List?>(
        future: ApiService.getStates(),
        builder: (context, snapshot) {
          final states = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            if (states == null) {
              return const Text('data not found');
            }
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 2,
                  color: Colors.black54,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: IconButton(
                      color: Colors.redAccent,
                      onPressed: () async {
                        bool deleteStates = await ApiService.deleteState(
                            states[index]['state']);
                        if (deleteStates) {
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.delete)),
                  title: Text(
                    states[index]['state'],
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  subtitle: Text(
                    'capital: ${states[index]['capital']}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                );
              },
              itemCount: states.length,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewStatePage(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        tooltip: 'Add State',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class AddNewStatePage extends StatefulWidget {
  const AddNewStatePage({Key? key}) : super(key: key);

  @override
  State<AddNewStatePage> createState() => _AddNewStatePageState();
}

class _AddNewStatePageState extends State<AddNewStatePage> {
  final _stateNameController = TextEditingController();
  final _stateCapital = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New State'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _stateNameController,
                decoration: InputDecoration(hintText: "State Name"),
              ),
              TextField(
                controller: _stateCapital,
                decoration: InputDecoration(hintText: "State Capital"),
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                onPressed: () {
                  final body = {
                    "state": _stateNameController.text,
                    "capital": _stateCapital.text,
                  };
                  ApiService.addState(body).then((success) {
                    if (success) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("State has been Added"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _stateNameController.text;
                                _stateCapital.text;
                              },
                              child: Text('Ok'),
                            )
                          ],
                        ),
                      );
                      return;
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error Adding Employee'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Ok"),
                            )
                          ],
                        ),
                      );
                      return;
                    }
                  });
                },
                child: Text(
                  'save',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
