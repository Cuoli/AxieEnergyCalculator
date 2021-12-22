import 'package:energy_calculator/turn.dart';

class Game {
  late int round;
  late int energy;
  List<Turn> turns = [];

  Game() {
    round = 1;
    energy = 3;
    turns.add(Turn());
  }

  endTurn() {
    addEnergy();
    addEnergy();
    round++;
    turns.add(Turn(round: round, energy: energy));
  }

  addEnergy() {
    if (energy >= 10) return;
    energy++;
  }

  substractEnergy() {
    if (energy <= 0) return;
    energy--;
  }

  reset() {
    energy = 3;
    round = 1;
    turns.clear();
    turns.add(Turn());
  }

  setLastTurnState() {
    if (round == 1) return;
    energy = turns[turns.length - 2].energy;
    round = turns[turns.length - 2].round;
    turns.removeLast();
  }
}
