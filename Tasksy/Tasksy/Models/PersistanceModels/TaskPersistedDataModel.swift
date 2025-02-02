import Foundation
import RealmSwift

class TasksPersistedDataModel: Object, ObjectKeyIdentifiable {
    @Persisted var tasks = List<TaskPersistedDataModel>()
    
    convenience init(dataModel: TaskDataModel) {
        self.init()
        self.tasks.append(TaskPersistedDataModel(dataModel: dataModel))
    }
}

class TaskPersistedDataModel: Object, ObjectKeyIdentifiable  {
    @Persisted var taskID: String
    @Persisted var taskTitle: String
    @Persisted var taskDescription: String
    @Persisted var taskCategory: String
    @Persisted var taskStatus: String
    
    convenience init(dataModel: TaskDataModel) {
        self.init()
        self.taskID = dataModel.id
        self.taskTitle = dataModel.taskTitle
        self.taskDescription = dataModel.taskDescription
        self.taskCategory = dataModel.taskCategory.rawValue
        self.taskStatus = dataModel.taskStatus.rawValue
    }
}
