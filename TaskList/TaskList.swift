//
//  taskList.swift
//  TaskList
//
//  Created by Daniel on 10/30/19.
//  Copyright © 2019 Minguri. All rights reserved.
//

import Foundation
import CoreData

public class TaskList:NSManagedObject, Identifiable {
    @NSManaged public var dateCreated:Date?
    @NSManaged public var taskName:String?
}

extension TaskList {
    static func getAllTaskItems() -> NSFetchRequest<TaskList> {
        let request:NSFetchRequest<TaskList> = TaskList.fetchRequest() as! NSFetchRequest<TaskList>
        
        let sortDescriptor = NSSortDescriptor(key: "dateCreated", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
