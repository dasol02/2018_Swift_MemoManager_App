import Foundation
import CoreData


class MemoDAO{
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // 전체 데이터 조회
    func fetch(keyword text: String? = nil) -> [MemoData] {
        
        var memolist = [MemoData]()
        
        // 데이터 요청 객체 선언
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        
        // 데이터 정렬
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        if let t = text, t.isEmpty == false {
            fetchRequest.predicate = NSPredicate(format: "contents CONTAINS[c] %@", t)
        }
        
        do {
            // 데이터 조회
            let resultset = try self.context.fetch(fetchRequest)
            
            for record in resultset {
                let data = MemoData()
                
                data.title = record.title
                data.contents = record.contents
                data.regdate = record.regdate
                data.objectID = record.objectID
                
                if let image = record.image as Data? {
                    data.image = UIImage(data: image)
                }
                
                memolist.append(data)
            }
        } catch let error as NSError {
            NSLog("An error has occurred : %s", error.localizedDescription)
        }
        
        return memolist
    }
    
    // 신규 데이터 삽입
    func insert(_ data: MemoData) {
        let object = NSEntityDescription.insertNewObject(forEntityName: "MemoMO", into: self.context) as! MemoMO
        
        object.title = data.title
        object.contents = data.contents
        object.regdate = data.regdate!
        
        if let image = data.image {
            object.image = image.pngData()
        }
        
        do {
            try self.context.save()
            
            // 로그인되어 있을 경우 서버에 데이터를 업로드한다.
            let tk = TokenUtils()
            
            if tk.getAuthorizationHeader() != nil {
                DispatchQueue.global(qos: .background).async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    let sync = DataSync()
                    sync.uploadDatum(object) {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            }
        } catch let error as NSError {
            NSLog("An error has occurred : %s", error.localizedDescription)
        }
        
    }

    // 기존 데이터 삭제
    func delete(_ objectID: NSManagedObjectID) -> Bool {
        
        let object = self.context.object(with: objectID)
        
        self.context.delete(object)
        
        do {
            try self.context.save()
            return true
        } catch let error as NSError {
             NSLog("An error has occurred : %s", error.localizedDescription)
            return false
        }
    }
}
