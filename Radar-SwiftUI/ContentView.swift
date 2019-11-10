//
//  ContentView.swift
//  Radar-SwiftUI
//
//  Created by Charel FELTEN on 06/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
// 

import SwiftUI




struct ContentView: View {
    var activities: [Activity] = []
    var body: some View {
        TabView {
            Text("Map view, tbi")
                .tabItem {
                    VStack {
                        // the icon is from SF symbols
                        Image(systemName: "map")
                        Text("Map")
                    }
            }.tag(1)
            
            ActivityListView(activities: activities)
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
            }.tag(2)
        }
    }
}







struct ActivityListView: View {
    var activities: [Activity]
    // do not forget to give default value, otherwhise the call to
    // ContentView in scenedelegate throws an error
    
    var body: some View {
        NavigationView {
            List(activities) { activity in
                ActivityCell(activity: activity)
            }
        .navigationBarTitle("Activities")
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(activities: testData)
    }
}

// extracted view (right click -> extract view) 
struct ActivityCell: View {
    var activity: Activity
    
    var body: some View {
        // in WWDC video, there is a return in front of this statement,
        // however it does not seem to be necessary
        NavigationLink(destination: ActivityView(activity: activity)) {
            Text(activity.emoji)
                .font(.largeTitle)
//                .padding(3)
//                .background(Color.black)
//                .cornerRadius(10)
//                .border(Color.purple, width: 0)
            
            
            VStack(alignment: .leading) {
                Text(activity.name)
                
                Text(activity.desc)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
    }
}


