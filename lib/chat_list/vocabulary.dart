import 'package:flutter/material.dart';
import 'package:language_partner/shared/constants/constants.dart';

Stream<List<String>> dataStream() async*{
  yield ['item'];
}

class Vocabulary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAllSidesRegular,
      child: StreamBuilder(
        stream: dataStream(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            List<String> data = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: paddingAllSidesRegular,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data[index],
                          style: textStyleRegular,
                        ),
                        Divider(
                          color: Colors.black45,
                          thickness: 4.0,
                        ),
                        Text(
                          data[index],
                          style: textStyleRegular,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Your vocabulary is empty.',
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'An error occurred while loading the data.',
                    ),
                  ),
                  IconButton(
                    onPressed: () => print('reload stream data'),
                    icon: Icon(
                      Icons.refresh,
                    ),
                  ),
                ],
              )
            );
          }
        },
      ),
    );
  }
}
