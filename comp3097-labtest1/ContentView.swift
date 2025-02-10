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
    
    var body: some View {
        VStack {
            // Title VStack
            VStack {
                Text("\(number)")
                    .font(.title)
                    .bold()
                    .padding(.top, 40)
            
                // Prime Selection Button
                Text("Prime")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding()

                Text("Not Prime")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding()
        
            
            }
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





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

