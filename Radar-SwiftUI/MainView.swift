//
//  MainView.swift
//  Radar-SwiftUI
//
//  Created by Charel FELTEN on 09/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Text("Map view, tbi")
                .tabItem {
                    Text("Map")
            }.tag(1)
            
            ContentView()
                .tabItem {
                    Text("All Activities")
            }.tag(2)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
