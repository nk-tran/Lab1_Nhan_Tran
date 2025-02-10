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
                    .padding(.top, 60)
                    .padding(.bottom, 60)
            
                // Prime Selection Button
                Text("Prime")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedOption == "Not Prime" ? Color.blue : Color.clear, lineWidth: 3)
                    )
                    .onTapGesture {
                        selectedOption = "Prime"
                    }
                Text("Not Prime")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedOption == "Not Prime" ? Color.blue : Color.clear, lineWidth: 3)
                    )
                    .onTapGesture {
                        selectedOption = "Not Prime"
                    }
            
            }
        }
    }
    
    // Start timer to auto-update number after 5 seconds
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.wrongCount += 1
            self.attemptCount += 1
            self.isCorrect = false
            self.checkSummary()
            self.nextNumber()
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
        startTimer()
    }
    
    // end game after 10 counts
    func checkSummary() {
        if attemptCount == 10 {
            showAlert = true
        }
    }
    
    func resetGame() {
        correctCount = 0
        wrongCount = 0
        attemptCount = 0
    }
}
 







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

