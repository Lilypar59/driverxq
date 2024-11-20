import 'package:flutter/material.dart';

class QuestionnairePopup extends StatefulWidget {
  final Function(String mood, bool isReady) onSubmit;

  const QuestionnairePopup({Key? key, required this.onSubmit})
      : super(key: key);

  @override
  _QuestionnairePopupState createState() => _QuestionnairePopupState();
}

class _QuestionnairePopupState extends State<QuestionnairePopup> {
  String? selectedMood; // Para rastrear el estado de ánimo seleccionado
  bool? isReady; // Para rastrear si está listo

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        // Centrar el texto "Bienvenido"
        child: Text(
          "Welcome",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.orange, // Cambiar el color del texto a naranja
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("¿How are you today?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _emojiButton("😊", "Calm"),
              _emojiButton("😰", "Stress"),
              _emojiButton("😴", "Tired"),
              _emojiButton("⚡", "Alert"),
            ],
          ),
          const SizedBox(height: 20),
          const Text("¿Are you ready to start?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _textButton("✅ yes", true),
              _textButton("❌ No", false),
            ],
          ),
        ],
      ),
      actions: [
        Center(
          // Centrar el botón "Enviar"
          child: TextButton(
            onPressed: () {
              if (selectedMood != null && isReady != null) {
                widget.onSubmit(selectedMood!, isReady!);
                Navigator.of(context).pop(); // Cierra el popup
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Please, answer both questions")),
                );
              }
            },
            style: ButtonStyle(
              // Cambiar el color del texto del botón
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.focused)) {
                  return Colors
                      .grey; // Cambiar a gris si el botón tiene el foco
                }
                return const Color.fromARGB(
                    255, 0, 255, 106); // Color normal del texto
              }),
              // Cambiar el color de fondo del botón
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.focused)) {
                  return const Color.fromARGB(255, 93, 64,
                      255); // Fondo naranja claro cuando el botón tiene el foco
                }
                return Colors
                    .transparent; // Fondo transparente cuando no tiene foco
              }),
            ),
            child: const Text(
              "Send",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors
                    .orange, // Cambiar color del texto del botón a naranja
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _emojiButton(String emoji, String mood) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = mood; // Actualizar el estado
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedMood == mood
              ? Colors.orange
              : Colors.transparent, // Naranja si está seleccionado
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(5),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }

  Widget _textButton(String label, bool readyState) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isReady = readyState; // Actualizar el estado
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isReady == readyState
              ? Colors.orange
              : Colors.transparent, // Naranja si está seleccionado
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
