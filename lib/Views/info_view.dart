import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Information'),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Center(
              child: Text('Tämä on android sovellus tehtävien listaukseen.')),
          const Center(
              child: Text(
                  'sovellusta kehitetään Mobiilisovelluskehitys -kurssilla.')),
          const Center(
            child: Text(
                'Voit listata tekemättömät työsi ja merkata kun ne on tehty.'),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
                  'Voitko uskoa, olen tehnyt tämän sovelluksen ihan itse!?')),
          const Center(child: Text('..ja se ei ole ihan vielä valmis')),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
                'sovelluksen valmistumista odotellessa voit tuijotella tätä kissaa'),
          ),
          const SizedBox(
            height: 30,
          ),
          Image.network('https://cataas.com/cat/gif'),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate back to first route when tapped.
              },
              child: const Text('Älä koske!'),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const Center(child: Text('tänään on 22.2.2023')),
        ],
      ),
    );
  }
}
