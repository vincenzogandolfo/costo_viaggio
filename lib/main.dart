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
      debugShowCheckedModeBanner: false,
      title: 'Calcolatore Costo Viaggio',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const CalcolaCostiScreen(),
    );
  }
}

class CalcolaCostiScreen extends StatefulWidget {
  const CalcolaCostiScreen({Key? key}) : super(key: key);

  @override
  State<CalcolaCostiScreen> createState() => _CalcolaCostiScreenState();
}

class _CalcolaCostiScreenState extends State<CalcolaCostiScreen> {
  String tipoPercorso =
      'Urbano'; // Dichiarazione iniziale della Variabile che cambierà
  String messaggio =
      ''; // Dichiarazione iniziale del messaggio che verrà visualizzato, diverso in base alle scelte
  final TextEditingController kmController = TextEditingController();
  final List<String> tipiPercorso = [
    'Urbano',
    'Extraurbano',
    'Misto'
  ]; // Elenco contenuto in DropDownButton

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Risolve problemi di overflow da apparizione tastiera
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Calcolo Costo del Viaggio',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Text(
            'Renault Arkana',
            style: TextStyle(
                fontSize: 40,
                color: Colors.orange,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(), // Separatore
          TextField(
            // Widget utilizzato per ricevere un comando in input dall' Utente
            controller: kmController,
            keyboardType: TextInputType
                .number, // Indicare cosa verrà inserito (Es. number)
            style: const TextStyle(fontSize: 20, color: Colors.grey),
            decoration: const InputDecoration(
              hintText:
                  'Inserire il numero di Km', // Indicazione che scompare durante l'inserimento,
              hintStyle: TextStyle(fontSize: 18),
            ),
          ),
          const Spacer(),
          const Text(
            'Scegliere il tipo di percorso',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            // Menu a scelta multipla
            value:
                tipoPercorso, // value contiene il valore inizialmente dichiarato ('Urbano')
            items: tipiPercorso.map((String value) {
              // item contiene l'Elenco di tipiPercorso, map scorre l'elenco e trasforma ogni Stringa in Item selezionabili
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 20),
                ),
              ); // restituisce una scelta in base all'elenco
            }).toList(),
            onChanged: (String? nuovoValore) {
              setState(() {
                tipoPercorso =
                    nuovoValore!; // sostituisce l'Item selezionato con quello iniziale
              });
            },
          ),
          const Spacer(flex: 2), // Separatore con distanza doppia
          ElevatedButton(
            // Pulsante che attiva, quando premuto, il metodo contenuto in onPressed: () {..}, ovvero calcoloCosto()
            onPressed: () {
              calcolaCosto();
            },
            child: const Text(
              'Calcola',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          const Spacer(flex: 2),
          Text(
            // Questo testo, inizialmente dichiarato vuoto (messaggio = ''), conterrà poi il risultato della variabile (costo)
            messaggio,
            style: TextStyle(fontSize: 20),
          ),
          const Spacer(),
        ]),
      ),
    );
  }

  void calcolaCosto() {
    // Metodo che calcola il costo in base alle scelte dell' Utente
    const costoCarburanteLitro = 1.65;
    double numerokm = double.tryParse(kmController.text) ??
        0; // tryParse trasforma la stringa in numero, se è null darà 0
    double kmTipopercorso;
    double costo;

    if (tipoPercorso == tipiPercorso[0]) {
      // Controllo e Assegnazione valore in base al Tipo di Percorso
      kmTipopercorso = 30;
    } else if (tipoPercorso == tipiPercorso[1]) {
      kmTipopercorso = 14;
    } else {
      kmTipopercorso = 22;
    }
    costo = numerokm *
        costoCarburanteLitro /
        kmTipopercorso; // Calcolo in base alle varie scelte
    setState(() {
      messaggio =
          'Costo =  ${costo.toStringAsFixed(2)} €'; // Trasforma (double costo) in (String costo) con solo DUE decimali
    });
  }
}
