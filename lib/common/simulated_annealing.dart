/// {@category framework}
library;

import 'dart:math';

/// Provide template for [Simulated Annealing](https://en.wikipedia.org/wiki/Simulated_annealing) based optimizaiton.
abstract base class SimulatedAnnealing<Sys, Soln> {
  /// The System for which Simulated Annealing is being performed.
  final Sys system;

  /// The current optimal solution found.
  late Soln _currentOptimalSolution;

  /// The current optimal solution found.
  Soln get currentOptimalSolution => _currentOptimalSolution;

  /// Initial Temperature (i.e. acceptance of worse solutions at the start of the process).
  final double startTemperature;

  /// Final Temperature (i.e. acceptance of worse solutions at the end of the process).
  final double finalTemperature;

  /// Current Temperature.
  double _currentTemperature;

  /// Current Temperature.
  double get currentTemperature => _currentTemperature;

  /// Number of steps over which cooling occurs.
  final int coolingRangeInSteps;

  /// Temperature decrease per step.
  final double _temperatureDecreasePerStep;

  /// Constructor for [SimulatedAnnealing].
  SimulatedAnnealing({
    required this.system,
    this.startTemperature = 900,
    this.finalTemperature = 28,
    this.coolingRangeInSteps = 872,
  }) : _temperatureDecreasePerStep = (startTemperature - finalTemperature) / coolingRangeInSteps,
       _currentTemperature = startTemperature {
    _currentOptimalSolution = getInitialSolution(system);
  }

  /// Calculate the energy of a given solution.
  int calculateEnergy(Soln solution);

  /// Generate a mutation of a given solution — find find a neighbouring soultion.
  Soln generateMutation(Soln solution);

  /// Get an initial solution for the system.
  Soln getInitialSolution(Sys system);

  Soln optimize() {
    _currentOptimalSolution = _currentOptimalSolution;
    int optimalEnergy = calculateEnergy(_currentOptimalSolution);

    _currentTemperature = startTemperature;
    Random _randomEngine = Random.secure();

    while (_currentTemperature >= finalTemperature) {
      Soln newSolution = generateMutation(_currentOptimalSolution);
      int newEnergy = calculateEnergy(newSolution);

      if (newEnergy < optimalEnergy) {
        _currentOptimalSolution = newSolution;
        optimalEnergy = newEnergy;
      } else {
        double acceptanceProbability = exp((optimalEnergy - newEnergy) / _currentTemperature);

        if (_randomEngine.nextDouble() < acceptanceProbability) {
          _currentOptimalSolution = newSolution;
          optimalEnergy = newEnergy;
        }
      }

      // Cool down the system
      _currentTemperature -= _temperatureDecreasePerStep;
    }

    return _currentOptimalSolution;
  }
}
