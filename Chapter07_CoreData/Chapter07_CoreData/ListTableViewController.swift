import UIKit
import CoreData


class ListtableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var date: UILabel!
}

class ListTableViewController: UITableViewController {
    

    
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    // data load
    func fetch() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        // 요청 객체 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")
        
        // data load
        let sort = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        // 데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        
        return result
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    // MARK: - Privite
    
    @objc func add(_ sender: Any){
        
        let alert = UIAlertController(title: "게시글 등록", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { $0.placeholder = "제목" }
        alert.addTextField { $0.placeholder = "내용" }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { (_) in
            
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else{
                return
            }
            
            if self.save(title: title, contents: contents) == true {
                self.tableView.reloadData()
            }
            
        }))
        
        self.present(alert, animated: false, completion: nil)
        
        
    }
    
    
    // MARK: - CoreData CRUD
    
    // delete
    func delete(object: NSManagedObject) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 컨텍스트로부터 해당 객체 삭제
        context.delete(object)
        
        // 영구 저장소 커밋
        do {
            try context.save()
            return true
        }catch {
            context.rollback()
            return false
        }
    }

    
    
    // save
    func save(title: String, contents: String) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let object = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context)
        
        
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        do {
            try context.save()
//            self.list.append(object)
            self.list.insert(object, at: 0)
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    // edit
    func edit(object: NSManagedObject, title: String, contents: String) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        do {
            try context.save()
            self.list = self.fetch()
            return true
        } catch {
            context.rollback()
            return false
        }
        
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListtableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListtableViewCell

        let record = self.list[indexPath.row]
        
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        let date = record.value(forKey: "regdate") as? Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        cell.title?.text = title
        cell.content?.text = contents
        cell.date?.text = "date : \(dateFormatter.string(from: date!))"
        
        cell.title?.font = UIFont.systemFont(ofSize: 18)
        cell.content?.font = UIFont.systemFont(ofSize: 14)
        cell.date?.font = UIFont.systemFont(ofSize: 12)

        return cell
    }

    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        // delete
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // delete
        let object = self.list[indexPath.row]
        if self.delete(object: object) {
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // editing
        let object = self.list[indexPath.row]
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        
        let alert = UIAlertController(title: "게시글 수정", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { $0.text = title }
        alert.addTextField { $0.text = contents }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { (_) in
            
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else {
                return
            }
            
            if self.edit(object: object, title: title, contents: contents) == true {
//                self.tableView.reloadData()
                
                let date = object.value(forKey: "regdate") as? Date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let cell = self.tableView.cellForRow(at: indexPath) as? ListtableViewCell
                cell?.title?.text = title
                cell?.content?.text = contents
                cell?.date?.text = "date : \(dateFormatter.string(from: date!))"
                
                let firestIndexPath = IndexPath(item: 0, section: 0)
                self.tableView.moveRow(at: indexPath, to: firestIndexPath)
            }
        }))
        
        self.present(alert, animated: false, completion: nil)
    }
    
    
}
