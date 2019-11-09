//
//  ActivityView.swift
//  Radar-SwiftUI
//
//  Created by Charel FELTEN on 08/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    let activity: Activity
    
    var body: some View {
        VStack {
            VStack {
                Text(activity.emoji)
                    .font(.system(size: 60))
                
                Text(activity.name)
                    .font(.largeTitle)
                    
                Text(activity.desc)
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Join activity")
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(8)
                    
                }
                
            }
            
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activity: testData[0])
    }
}
