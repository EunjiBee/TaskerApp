//
//  TaskListView.swift
//  TaskList
//
//  Created by Daniel on 10/30/19.
//  Copyright © 2019 Minguri. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    var taskName:String = ""
    var dateCreated:String = ""
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(taskName)
                    .font(.headline)
                Text(dateCreated)
                    .font(.caption)
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(taskName: "Name", dateCreated: "Today")
    }
}
