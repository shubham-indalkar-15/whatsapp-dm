import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp DM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // darkTheme: ThemeData.dark(useMaterial3: true),
      // themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'WhatsApp DM'),
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
  final phoneNumberController = TextEditingController();
  final messageController = TextEditingController();
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'Enter Phone number:',
            // ),
            SizedBox(
              width: width - 100,
              child: TextField(
                maxLength: 10,
                controller: phoneNumberController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  counter: const Text(''),
                  prefixText: '+91',
                  prefixStyle:
                      const TextStyle(fontSize: 16, color: Colors.deepPurple),
                  hintText: '9876543210',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  label: const Text('Enter Phone No.'),
                ),
                // autofillHints: const [AutofillHints.telephoneNumberLocal],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  // LengthLimitingTextInputFormatter(10),
                  // FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny('+91',
                      replacementString: ''),
                ],
                // style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: width - 100,
              child: TextField(
                controller: messageController,
                maxLines: 10,
                maxLength: 1024,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  hintText: 'How you doin\'',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  label: const Text('Enter the message'),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 15),
            FilledButton(
              child: const Text('DM'),
              onPressed: () async {
                var whatsappUrl = Uri.parse(
                    "https://wa.me/+91${phoneNumberController.text}?text=${messageController.text}");
                try {
                  launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
