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
}
 







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

