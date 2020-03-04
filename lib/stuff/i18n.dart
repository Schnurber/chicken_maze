import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class LangDelegate extends LocalizationsDelegate<Lang> {
  const LangDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de', 'es', 'fr'].contains(locale.languageCode);

  @override
  Future<Lang> load(Locale locale) {
    return SynchronousFuture<Lang>(Lang(locale));
  }

  @override
  bool shouldReload(LangDelegate old) => false;
}


class Lang {
  Lang(this.locale);

  final Locale locale;

  static Lang of(BuildContext context) {
    return Localizations.of<Lang>(context, Lang);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'info': """The chicken must pass through the maze. 
It is supposed to eat grains. 
Power pills will allow it to break through 
walls and destroy enemies.
(c) 2019 by Dieter Meiller""",
      'WaitForLoading' : 'Waiting for network connection',
      'ChickenMaze' : 'Chicken Maze',
      'BitteWarten': 'Please wait',
      'Start': 'Start',
      'Pause': 'Pause',
      'StartGame': 'Start Game',
      'GameOver': 'Game Over!',
      'YourScore': 'Your Score:',
      'PlayGame': 'Play Game',
      'HighScores': 'High Scores',
      'Settings': 'Settings',
      'About': 'About',
      "EnterYourPlayerName": "Enter Your Player Name",
      "YouHaveToEnterANameToPlay": "You have to enter a name to play",
      "YourName": "Your Name",
      "Sound": "Sound",
      "Music": "Music",
      "On": "On",
      "Off": "Off",
      "HighScore": "High Score",
      "FailedToLoad": "Failed to Load",
      "Rank": "Rank",
      "Name": "Name",
      "Score": "Score",
      'Level': 'Level',
      'Lives': 'Lives',
      'Power': 'Power',
      "NewHighScore": "New High-Score",
      "PlayAgain": "Play Again",
      "ResumeGame": "Resume Game",
      "AbortGame": "Abort game"
    },
    'de': {
      'info' : """Das Huhn muss durch das Labyrinth. 
Dabei soll es Körner Fressen. 
Kraft-Pillen ermöglichen es ihm, 
Mauern zu durchbgrechen und Feinde 
zu zerstörten.
(c) 2019 by Dieter Meiller""",
      'WaitForLoading' : 'Warte auf Netzwerkverbindung',
      'ChickenMaze' : 'Chicken Maze',
      'BitteWarten': 'Bitte Warten',
      'Start': 'Start',
      'Pause': 'Pause',
      'StartGame': 'Starte Spiel',
      'GameOver': 'Leider zu Ende',
      'YourScore': 'Deine Punkte',
      'PlayGame': 'Spiele das Spiel',
      'HighScores': 'Beste Wertungen',
      'Settings': 'Einstellungen',
      'About': 'Über das Spiel',
      "EnterYourPlayerName": "Bitte gib Deinen Namen ein",
      "YouHaveToEnterANameToPlay": "Du must einen Namen eingeben zum Spielen",
      "YourName": "Dein Name",
      "Sound": "Sound",
      "Music": "Musik",
      "On": "an",
      "Off": "aus",
      "HighScore": "High Score",
      "FailedToLoad": "Laden fehlgeschlagen",
      "Rank": "Rang",
      "Name": "Name",
      "Score": "Punkte",
      'Level': 'Level',
      'Lives': 'Leben',
      'Power': 'Kraft',
      "NewHighScore": "Neuer Bestwert!!!",
      "PlayAgain": "Spiele erneut!",
      "ResumeGame": "Spiel fortsetzen",
      "AbortGame": "Spiel abbrechen"
    },
    'es': {
      'info' : """El pollo debe pasar por el laberinto. 
Se supone que come granos. 
Las píldoras de poder le permiten atravesar 
muros y destruir enemigos. 
(c) 2019 by Dieter Meiller""",
      'WaitForLoading' : 'Esperando la conexión de red',
      'BitteWarten': 'Espera por vavor',
      'Start': 'Inicio',
      'Pause': 'Pausa',
      'StartGame': 'Iniciar el juego',
      'GameOver': 'Final del juego',
      'YourScore': 'Tus puntos',
      'PlayGame': 'Juega el juego',
      'HighScores': 'Mejores puntajes',
      'Settings': 'Opciones',
      'About': 'Acerca del juego',
      "EnterYourPlayerName": "Por favor, introduzca el nombre",
      "YouHaveToEnterANameToPlay": "Debes introducir un nombre para jugar",
      "YourName": "Tu nombre",
      "Sound": "Sonar",
      "Music": "Música",
      "On": "Si",
      "Off": "No",
      "HighScore": "Puntaje más alto",
      "FailedToLoad": "Error de la carga",
      "Rank": "Rango",
      "Name": "Nombre",
      "Score": "Puntajes",
      'Level': 'Nivel',
      'Lives': 'Vida',
      'Power': 'Fuerza',
      "NewHighScore": "¡Nuevo mejor valor!",
      "PlayAgain": "¡Juega de nuevo!",
      "ResumeGame": "Reanudar el juego",
      "AbortGame": "Abortar el juego"
    },
    'fr': {
      'info' : """Le poulet doit passer à travers le labyrinthe. 
      Il est censé manger des céréales. 
      Les pilules de puissance lui permettent de percer 
      les murs et de détruire les ennemis.
      (c) 2019 by Dieter Meiller""",
      'WaitForLoading' : "En attente d'une connexion réseau",
      'ChickenMaze' : 'Chicken Maze',
      'BitteWarten': 'Veuillez patienter',
      'Start': 'Départ',
      'Pause': 'Pause',
      'StartGame': 'Commencer le jeu',
      'GameOver':   "C'est fini",
      'YourScore': 'Vos points',
      'PlayGame': 'Jouer le jeu',
      'HighScores': 'Meilleurs scores',
      'Settings': 'paramètres',
      'About': 'A propos du jeu',
      "EnterYourPlayerName": "Veuillez entrer votre nom",
      "YouHaveToEnterANameToPlay": "Vous devez entrer un nom pour jouer",
      "YourName": "Votre nom",
      "Sound": "Son",
      "Music": "Musique",
      "On": "Commuté",
      "Off": "Éteinte",
      "HighScore": "Meilleurs scores",
      "FailedToLoad": "Echec du chargement",
      "Rank": "Grade",
      "Name": "Nom",
      "Score": "Score",
      'Level': 'Niveau',
      'Lives': 'Crédit',
      'Power': 'Dorce',
      "NewHighScore": "Nouveau record!!!",
      "PlayAgain": "Rejouer!!!!",
      "ResumeGame": "Reprendre le jeu",
      "AbortGame": "Annuler le jeu"
    },
  };

  String t(String what) {
    return _localizedValues[locale.languageCode][what];
  }
}