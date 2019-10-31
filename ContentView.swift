//
//  ContentView.swift
//  TaskList
//
//  Created by Daniel on 10/30/19.
//  Copyright © 2019 Minguri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: TaskList.getAllTaskItems()) var taskItems:FetchedResults<TaskList>
    
    @State private var newTaskItem = ""
    @State var size = UIScreen.main.bounds.width / 1.6
    
    var body: some View {
        
        ZStack{
            Color.white
            
            NavigationView{
                List{
                    Section(header: Text("Add a task: ")){
                        HStack{
                            TextField("New Task:", text: self.$newTaskItem)
                            Button(action: {
                                let taskItems = TaskList(context: self.managedObjectContext)
                                taskItems.taskName = self.newTaskItem
                                taskItems.dateCreated = Date()
                                
                                do {
                                    try self.managedObjectContext.save()
                                } catch{
                                    print(error)
                                }
                                
                                self.newTaskItem = ""
                                
                            }){
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                            }
                        }
                    }.font(.headline)
                    Section(header: Text("To Do's")){
                        ForEach(self.taskItems) {taskItem in
                            TaskListView(taskName: taskItem.taskName!, dateCreated: "\(taskItem.dateCreated!)")
                        } .onDelete { indexSet in
                            let deleteItem = self.taskItems[indexSet.first!]
                            self.managedObjectContext.delete(deleteItem)
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch{
                                print(error)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Tasks"))
                .navigationBarItems(leading: Button(action: {
                    self.size = 10
                }, label: {
                    Image("menu")
                        .resizable()
                        .frame(width:20, height: 20)
                        .padding()
                }).foregroundColor(.black))
                .navigationBarItems(trailing: EditButton())
            }
        
            HStack{
                menu(size: $size)
                    .cornerRadius(20)
                    .padding(.leading, -size)
                    .offset(x: -size)
            
                Spacer()
            }
        }.animation(.spring())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct menu : View{
    @Binding var size : CGFloat
    
    var body : some View{
        VStack{
            HStack{
                Spacer()
                
                Button(action: {
                    self.size = UIScreen.main.bounds.width / 1.6
                }) {
                    Image("close")
                        .padding()
                        .frame(width: 15, height: 15)
                        .padding()
                }.background(Color.gray)
                    .foregroundColor(.white)
                .clipShape(Circle())
            }
            
            HStack{
                Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding()
                Text("Home")
                        .fontWeight(.heavy)
                Spacer()
            }.padding(.leading, 20)
        }
    }
    
}
