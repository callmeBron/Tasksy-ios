import Foundation
//import RealmSwift
//
//class TasksPersistedDataModel: Object, ObjectKeyIdentifiable {
//    @Persisted private var tasks = List<TaskPersistedDataModel>()
//    convenience init(dataModel: TaskDataModel) {
//        self.init()
//        self.tasks.append(TaskPersistedDataModel(dataModel: dataModel))
//    }
//}
//
//class TaskPersistedDataModel: Object, ObjectKeyIdentifiable  {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted private var taskTitle: String
//    @Persisted private var taskDescription: String
//    @Persisted private var taskCategory: String
//    @Persisted private var taskStatus: String
//    
//    convenience init(dataModel: TaskDataModel) {
//        self.init()
//        self.taskTitle = dataModel.taskTitle
//        self.taskDescription = dataModel.taskDescription
//        self.taskCategory = dataModel.taskCategory.rawValue
//        self.taskStatus = dataModel.taskStatus.rawValue
//    }
//}
