//
//  ActivityListView.swift
//  Radar-SwiftUI
//
//  Created by Charel FELTEN on 26/12/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import SwiftUI


struct ActivityListView: View {
    @ObservedObject var data: DataBase
    
    @State var rotation = 0
    
    var body: some View {
        NavigationView {
            List(data.activities) { activity in
                ActivityCell(activity: activity)
            }
        .navigationBarTitle("Activities")
        .navigationBarItems(
            trailing: Button(action: {
                self.data.getActivities()
            }) {
                Image(systemName: "arrow.clockwise")
            }
        )
    }
    }
}


struct ActivityCell: View {
    var activity: Activity
    
    var body: some View {
        NavigationLink(destination: ActivityView(activity: activity)) {
            Text(activity.emoji)
                .font(.largeTitle)
            
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

//struct ActivityListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityListView(activities: DataBase())
//    }
//}
