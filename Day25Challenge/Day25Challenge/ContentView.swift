//
//  ContentView.swift
//  Day25Challenge
//
//  Created by John Mueller on 10/17/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

enum Move: String, CaseIterable {
    case rock, paper, scissors

    func fights(_ opponent: Move) -> Outcome {
        if opponent == self { return .tie }

        let index = Move.allCases.firstIndex(of: self)!
        if opponent == Move.allCases[(index + 1) % 3] { return .lose }
        
        return .win
    }

    static func random() -> Move {
        allCases.randomElement()!
    }
}

extension Move: CustomStringConvertible {
    var description: String {
        rawValue.prefix(1).uppercased() + rawValue.dropFirst()
    }
}

enum Outcome {
    case win, tie, lose
}

struct ContentView: View {
    @State private var computerMove: Move = .random()
    @State private var goal: Outcome = Bool.random() ? .win : .lose

    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    @State private var score = 0
    @State private var round = 0

    var body: some View {
        VStack(spacing: 50) {
            VStack {
                Text("I've picked \(computerMove.description)...")
                Text("Try to \(goal == .win ? "win" : "lose")!")
            }
            .font(.title)

            VStack(spacing: 20) {
                ForEach(Move.allCases, id: \.self) { move in
                    Button(action: {
                        self.checkAnswer(move)
                    }) {
                        Text(move.description)
                            .makeRoundedButton()
                    }
                }
            }

            Text("Your score is \(score)")
                .font(.title)

            Spacer()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK"), action: {
                    self.computerMove = .random()
                    self.goal = Bool.random() ? .win : .lose
                  }))
        }
    }

    func checkAnswer(_ move: Move) {
        let outcome = move.fights(computerMove)

        switch outcome {
        case .win:
            alertTitle = "You won"
        case .tie:
            alertTitle = "You tied"
        case .lose:
            alertTitle = "You lost"
        }

        if outcome == goal {
            alertTitle += "!"
            alertMessage = "Good job"
            score += 1
        } else {
            alertTitle += "..."
            alertMessage = "Try again"
            score -= 1
        }

        round += 1
        if round >= 10 {
            alertMessage = "Your final score is \(score)"
            round = 0
            score = 0
        }

        showingAlert = true
    }
}

extension Text {
    func makeRoundedButton() -> some View {
        self.font(.title)
            .foregroundColor(.primary)
            .padding(.vertical, 5)
            .frame(width: 150)
            .background(Capsule().fill(Color.blue.opacity(1)))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
