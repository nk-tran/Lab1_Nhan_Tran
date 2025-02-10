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
    
    var body: some View {
        VStack {
            // Title VStack
            VStack {
                Text("\(number)")
                    .font(.title)
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
                            .cornerRadius(10)
                    }

                    Button(action: {
                        checkAnswer(selection: "Not Prime")
                    }) {
                        Text("Not Prime")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 140, height: 50)
                            .background(selectedOption == "Not Prime" ? Color.green : Color.red)
                            .cornerRadius(10)
                    }
                }
                
            }
            .onAppear {
                startTimer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Game Over"), message: Text("You answered \(correctCount) questions correctly and \(wrongCount) questions incorrectly."), dismissButton: .default(Text("OK")))
        }
    }
    
    // Start timer to auto-update number after 5 seconds
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.wrongCount += 1
            self.attemptCount += 1
            self.isCorrect = false
            nextNumber()
        }
    }
    
    // End game after each 10 counts
    func checkSummary() {
        if attemptCount % 10==0 {
            showAlert = true
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
        number = Int.random(in: 1...100)
        isCorrect = nil
        selectedOption = nil
        attemptCount += 1
        checkSummary()
        startTimer()
    }
    
    func resetGame() {
        correctCount = 0
        wrongCount = 0
        attemptCount = 0
    }
    
    func checkAnswer(selection: String) {
        timer?.invalidate()
        selectedOption = selection
        let correct = isPrime(number) ? "Prime" : "Not Prime"
        if selection == correct {
            correctCount += 1
        } else {
            wrongCount += 1
        }
        nextNumber()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
