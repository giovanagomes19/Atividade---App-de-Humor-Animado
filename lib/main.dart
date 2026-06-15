import 'package:flutter/material.dart';

void main() {
  runApp(const MoodApp());
}

class MoodApp extends StatelessWidget {
  const MoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mood App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MoodScreen(),
    );
  }
}

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  Color cor = Colors.grey;
  IconData icone = Icons.mood;
  String texto = "Escolha um humor";
  String mensagem = "";
  double tamanho = 220;
  double borda = 20;
  String humorAtual = "";

  void selecionarHumor(String humor) {
    setState(() {
      humorAtual = humor;

      switch (humor) {
        case "Feliz":
          cor = Colors.amber;
          icone = Icons.sentiment_very_satisfied;
          texto = "Hoje estou feliz!";
          mensagem = "Que bom ver essa energia positiva!";
          tamanho = 260;
          borda = 40;
          break;

        case "Calmo":
          cor = Colors.lightBlue;
          icone = Icons.cloud;
          texto = "Momento de tranquilidade.";
          mensagem = "Respire fundo e aproveite a calma.";
          tamanho = 240;
          borda = 60;
          break;

        case "Animado":
          cor = Colors.orange;
          icone = Icons.flash_on;
          texto = "Energia total!";
          mensagem = "Hora de conquistar o mundo!";
          tamanho = 280;
          borda = 15;
          break;

        case "Triste":
          cor = Colors.blueGrey;
          icone = Icons.sentiment_dissatisfied;
          texto = "Um dia mais difícil.";
          mensagem = "Tudo passa. Cuide de você.";
          tamanho = 230;
          borda = 30;
          break;
      }
    });
  }

  Widget buildCena() {
    switch (humorAtual) {
      case "Feliz":
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.8, end: 1.2),
          duration: const Duration(seconds: 1),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wb_sunny,
                      color: Colors.yellow, size: 40),
                  SizedBox(width: 8),
                  Icon(Icons.auto_awesome,
                      color: Colors.white, size: 25),
                  SizedBox(width: 8),
                  Icon(Icons.auto_awesome,
                      color: Colors.white, size: 25),
                ],
              ),
            );
          },
        );

      case "Calmo":
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: -15, end: 15),
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(value, 0),
              child: const Icon(
                Icons.cloud,
                color: Colors.white,
                size: 70,
              ),
            );
          },
        );

      case "Animado":
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.5, end: 1.4),
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bolt,
                      color: Colors.yellow, size: 40),
                  SizedBox(width: 8),
                  Icon(Icons.star,
                      color: Colors.white, size: 30),
                ],
              ),
            );
          },
        );

      case "Triste":
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: -10, end: 20),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: const Icon(
                Icons.water_drop,
                color: Colors.lightBlueAccent,
                size: 50,
              ),
            );
          },
        );

      default:
        return const SizedBox();
    }
  }

  Widget botaoHumor(String humor) {
    return ElevatedButton(
      onPressed: () => selecionarHumor(humor),
      child: Text(humor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Mood App",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Escolha um humor e veja a tela mudar com animações.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              width: tamanho,
              height: tamanho,
              decoration: BoxDecoration(
                color: cor,
                borderRadius: BorderRadius.circular(borda),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icone,
                    size: 60,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      texto,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: humorAtual.isEmpty ? 0 : 1,
                    child: buildCena(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            AnimatedOpacity(
              opacity: humorAtual.isEmpty ? 0 : 1,
              duration: const Duration(milliseconds: 800),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                botaoHumor("Feliz"),
                botaoHumor("Calmo"),
                botaoHumor("Animado"),
                botaoHumor("Triste"),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}