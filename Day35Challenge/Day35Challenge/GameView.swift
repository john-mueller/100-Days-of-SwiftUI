//
//  GameView.swift
//  Day35Challenge
//
//  Created by John Mueller on 11/4/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var model: Model

    @State private var answer: Int = 0
    var answerText: String {
        answer != 0 ? "\(answer)" : " "
    }

    @State private var angle: Angle = .degrees(0)
    @State private var offset: CGFloat = 0
    @State private var color: Color = .primary
    
    var body: some View {
        VStack {
            HStack {
                ButtonView(text: "Quit", colored: true, color: .red) {
                    withAnimation(.default) {
                        self.model.showingActionSheet = true
                    }
                }
                .frame(height: model.rowHeight)
                .aspectRatio(1.5, contentMode: .fit)

                Spacer()
            }

            Spacer()

            Text(model.questionString)
                .font(Font.largeTitle.monospacedDigit())
                .bold()
                .fixedSize()
                .frame(width: model.frameSize.width * 0.7)
                .foregroundColor(color)
                .rotation3DEffect(angle, axis: (x: 0, y: 1, z: 0))
                .offset(x: offset, y: 0)

            Text(answerText).font(.largeTitle)

            VStack(spacing: model.rowSpacing) {
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: self.model.rowSpacing) {
                        ForEach(0..<3, id: \.self) { column in
                            ButtonView(text: "\(row * 3 + column + 1)", colored: false) {
                                self.increaseNumber(row * 3 + column + 1)
                            }
                        }
                    }
                }
                .frame(height: model.rowHeight)

                HStack(spacing: model.rowSpacing) {
                    ButtonView(text: "Clear", colored: true, color: .yellow) {
                        self.answer = 0
                    }
                    ButtonView(text: "0", colored: false) {
                        self.increaseNumber(0)
                    }
                    ButtonView(text: "Check", colored: true, color: (answer == 0) ? .gray : .green) {
                        self.checkAnswer()
                    }
                    .disabled(answer == 0)
                }
                .frame(height: model.rowHeight)
            }
            
            Spacer()
        }
        .padding(model.rowSpacing)
        .sheet(isPresented: $model.showingSheet, onDismiss: {
            if self.model.gameState == .gameOver {
                withAnimation(.default) {
                    self.model.gameState = .playing
                }
            }
        }, content: {
            GameOverView()
                .environmentObject(self.model)
        })
            .actionSheet(isPresented: $model.showingActionSheet) {
                ActionSheet(title: Text("Are you sure?"),
                            message: Text("You will lose all progress if you quit now."),
                            buttons: [
                                .cancel(Text("Keep playing!")),
                                .destructive(Text("Quit"), action: {
                                    withAnimation(.default) {
                                        self.model.gameState = .setup
                                    }
                                })
                ])
        }
    }
    
    private func increaseNumber(_ number: Int) {
        guard answer < Int(1e3) else { return }
        answer = answer * 10 + number
    }

    private func checkAnswer() {
        let correct = model.currentQuestion.isAnswerCorrect(answer)

        model.questionString = model.currentQuestion.answerString

        withAnimation(.default) {
            color = correct ? .green : .red
        }

        if correct {
            withAnimation(.easeInOut(duration: 1)) {
                angle += .degrees(360)
            }
            angle = .degrees(0)

            model.correctAnswers.append(model.currentQuestion)
        } else {
            offset = 10
            withAnimation(.interpolatingSpring(stiffness: 2000, damping: 10)) {
                offset = .zero
            }

            model.wrongAnswers.append(model.currentQuestion)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.resetQuestion()
        }
    }

    private func resetQuestion() {
        color = .primary
        answer = 0
        model.popNextQuestion()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
