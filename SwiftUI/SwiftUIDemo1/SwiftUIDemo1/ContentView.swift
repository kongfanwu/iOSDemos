//
//  ContentView.swift
//  SwiftUIDemo1
//
//  Created by kfw on 2019/10/10.
//  Copyright © 2019 神灯智能. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack (alignment: .lastTextBaseline, spacing: 0){
                Text("1")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                Spacer() // 占位空间
                Text("2")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .lineLimit(1)
            }
            
            Spacer() // 占位空间
        }
        //        .padding(100)
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
