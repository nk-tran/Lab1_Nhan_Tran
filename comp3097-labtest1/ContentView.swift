//
//  ContentView.swift
//  comp3097-labtest1
//
//  Created by Nhan Tran on 2025-02-10.
//


import SwiftUI
import CoreData

struct ContentView: View {
    @State private var number = Int.random(in: 1...100)
    @State private var selectedOption: String? = nil
    @State private var timer: Timer? = nil
    @State private var isCorrect: Bool? = nil
    @State private var attemptCount = 0
    @State private var correctCount = 0
    @State private var wrongCount = 0
    @State private var showAlert = false
    @State private var unansweredCount = 0
    @State private var gameEnded = false
    
    var body: some View {
        VStack {
            // Title VStack
            VStack {
                Text("\(number)")
                    .font(.system(size:100))
                    .bold()
                    .padding(.top, 30)
                    .padding(.bottom, 120)
                
                
                // Prime Selection Button
                VStack(spacing: 20) {
                    Button(action: {
                        checkAnswer(selection: "Prime")
                    }) {
                        Text("Prime")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 140, height: 50)
                            .background(selectedOption == "Prime" ? Color.green : Color.blue)
                            .cornerRadius(5)
                    }

                    Button(action: {
                        checkAnswer(selection: "Not Prime")
                    }) {
                        Text("Not Prime")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 140, height: 50)
                            .background(selectedOption == "Not Prime" ? Color.green : Color.red)
                            .cornerRadius(5)
                            .padding(.top, 10)
                    }
                }
                
            }
            .onAppear {
                if !gameEnded {
                    startTimer()  // Start timer when the game first begins
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Game Over"), message: Text("You answered \(correctCount) questions correctly,\(wrongCount) questions incorrectly and \(unansweredCount) questions were unanswered."), dismissButton: .default(Text("OK"), action: {
                resetGame()
            }))
                
        }
    }
    
    // Start timer to auto-update number after 5 seconds
    func startTimer() {
        if gameEnded { return }

        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            if selectedOption == nil {
                unansweredCount += 1
            }
            attemptCount += 1
            checkSummary()
        }
    }
    
    // End game after each 10 counts
    func checkSummary() {
        if attemptCount == 10 {
            gameEnded = true
            showAlert = true
            timer?.invalidate() // Stop timer once condition is met
        }
        else {
            nextNumber()
        }
    }
    
    func isPrime(_ num: Int) -> Bool {
        if num < 2 { return false }
        for i in 2..<num { // Includes 2 but excludes num
            if num % i == 0 {
                return false
            }
        }
        return true
    }
    
    // Get next number and reset selections
    func nextNumber() {
        if gameEnded { return } //Prevents new numbers from generating when game is over
        number = Int.random(in: 1...100)
        isCorrect = nil
        selectedOption = nil
        startTimer()
    }
    
    func resetGame() {
        correctCount = 0
        wrongCount = 0
        unansweredCount = 0
        attemptCount = 0
        gameEnded = false
        nextNumber()
    }
    
    func checkAnswer(selection: String) {
        selectedOption = selection
        attemptCount += 1
        let correct = isPrime(number) ? "Prime" : "Not Prime"
        if selection == correct {
            correctCount += 1
        } else {
            wrongCount += 1
        }
        checkSummary()
        if attemptCount < 10 {
            nextNumber()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
