//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by John Mueller on 10/12/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var score = 0
    @State private var questionsAsked = 0

    @State private var angle = Angle.degrees(0)
    @State private var offset = CGSize.zero
    @State private var opacity = 1.0

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)

                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(self.countries[number])
                    }
                    .rotation3DEffect(number == self.correctAnswer ? self.angle : .degrees(0), axis: (x: 0, y: 1, z: 0))
                    .offset(self.offset)
                    .opacity(number != self.correctAnswer ? self.opacity : 1)
                }

                Spacer()
            }
        }
        .actionSheet(isPresented: $showingScore) {
            ActionSheet(title: Text(scoreTitle),
                        message: Text("Your \(questionsAsked == 10 ? "final " : "")score is \(score)"),
                        buttons: [.default(Text(questionsAsked == 10 ? "Play Again" : "Continue")) {
                            if self.questionsAsked == 10 {
                                self.score = 0
                                self.questionsAsked = 0
                            }
                            self.askQuestion()

                            self.opacity = 1
                            }])
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1

            withAnimation(.easeInOut(duration: 1)) {
                self.angle += .degrees(360)
            }
            self.angle = .degrees(self.angle.degrees.truncatingRemainder(dividingBy: 360))
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score -= 1

            self.offset = CGSize(width: 10, height: 0)
            withAnimation(.interpolatingSpring(stiffness: 2000, damping: 10)) {
                self.offset = .zero
            }
        }

        withAnimation(.easeInOut) {
            self.opacity = 0.25
        }

        questionsAsked += 1

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
