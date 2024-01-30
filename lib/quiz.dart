import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool? isCorrect;
  final List<Map<String, dynamic>> questions = [
    {
      'questions': 'Qual é o Tubarão mais violento do mundo?',
      'answers': [
        'Tubarão-branco',
        'Tubarão-martelo',
        'Tubarão-tigre',
        'Tubarão-lixa'
      ],
      'correctAnswer': 'Tubarão-branco'
    },
    {
      'questions': 'Qual é o peixe mais rápido do mundo?',
      'answers': ['Carpa', 'Dânio-tigre', 'Perca sol', 'Agulhão-vela'],
      'correctAnswer': 'Agulhão-vela'
    },
    {
      'questions': 'Qual a Expectativa de vida de uma Baleia-azul?',
      'answers': ['60-70 anos', '70-80 anos', '80-90 anos', '90-100 anos'],
      'correctAnswer': '80-90 anos'
    }
  ];
  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }  
  }

  void handleAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == questions[currentQuestionIndex]['correctAnswer'];
      if (!isCorrect!) {
        currentQuestionIndex = 0;
      } else {
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            selectedAnswer = null;
            isCorrect = null;
            if (currentQuestionIndex < questions.length - 1) {
              currentQuestionIndex++;
            } else {
              
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple[50],
          title: Text(
            'Quiz marítimo!',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.deepPurple[50],
            width: double.infinity,
            height: 400,
            child: Center(
              child: Text(
                currentQuestion['questions'],
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          Wrap(
            children: currentQuestion['answers'].map<Widget>((resposta) {
              bool isSelected = selectedAnswer == resposta;
              Color? buttonColor;
              if (isSelected) {
                buttonColor = isCorrect! ? Colors.green : Colors.red;
              }

              return meuBtn(
                  resposta, () => handleAnswer(resposta), buttonColor);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

Widget meuBtn(String resposta, VoidCallback onPressed, Color? color) =>
    Container(
      margin: const EdgeInsets.all(16),
      width: 160,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(resposta),
      ),
    );
