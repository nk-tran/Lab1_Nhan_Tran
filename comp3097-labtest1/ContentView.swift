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
    @State private var showResult = false
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
                Spacer()
                
                if showResult {
                                    if isCorrect == true {
                                        Image(systemName: "checkmark")
                                            .padding(.top, 20)
                                            .foregroundColor(.green)
                                            .font(.system(size: 120))
                                    } else {
                                        Image(systemName: "xmark")
                                            .padding(.top, 20)
                                            .foregroundColor(.red)
                                            .font(.system(size: 125))
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
            Alert(title: Text("Game Over"), message: Text("You answered \(correctCount) questions correctly and \(wrongCount) questions incorrectly."), dismissButton: .default(Text("OK"), action: {
                resetGame()
            }))
                
        }
    }
    
    // Start timer to auto-update number after 5 seconds
    func startTimer() {
        if gameEnded { return }

        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            if selectedOption == nil {
                wrongCount += 1
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showResult = false
                    nextNumber()
                }
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
        showResult = false
        startTimer()
    }
    
    func resetGame() {
        correctCount = 0
        wrongCount = 0
        attemptCount = 0
        gameEnded = false
        nextNumber()
    }
    
    func checkAnswer(selection: String) {
        selectedOption = selection
        timer?.invalidate()
        attemptCount += 1
        let correct = isPrime(number) ? "Prime" : "Not Prime"
        if selection == correct {
            correctCount += 1
            isCorrect = true
        } else {
            wrongCount += 1
            isCorrect = false
        }
        showResult = true
        checkSummary()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
