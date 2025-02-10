//
//  ContentView.swift
//  comp3097-labtest1
//
//  Created by Nhan Tran on 2025-02-10.
//

import SwiftUI
import CoreData

import SwiftUI
import CoreData



struct ContentView: View {
    @State private var num: Int = 0

    
    var body: some View {
        VStack {
            // Title VStack
            VStack {
                Text("Lab Test 1")
                    .font(.title)
                    .bold()
                    .padding(.top, 40)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
