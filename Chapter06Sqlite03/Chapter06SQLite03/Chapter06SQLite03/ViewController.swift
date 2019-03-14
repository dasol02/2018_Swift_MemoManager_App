import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbPath = self.getDBPath()
        print("Database path : \(dbPath)")
        self.dbExecute(dbPath: dbPath)
       
    }
    
    
    func dbExecute(dbPath:String){
        var db: OpaquePointer? = nil // SQLite 연결 정보를 담을 객체
        
        // 데이터 베이스 연결 되었다면 [db 실행 (db객체 생성)]
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
            print("Database Connect Fail")
            return
        }
        
        // 데이터 베이스 연결 종료
        defer {
             print("Close Database Connectiomn")
             sqlite3_close(db)   // 연결 종료 (객체 해제)
        }
        
        var stmt: OpaquePointer? = nil // 컴파일된 SQL을 담을 객체
        let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
        
        // SQL구문 컴파일 실행 되었다면
        guard sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            print("Database Connect Fail")
            return
        }
        
        // stmt 변수 해제
        defer {
            print("Finalize Statement")
            sqlite3_finalize(stmt) // 컴파일된 쿼리 삭제 (stmt해제)
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE{   // 쿼리 db 전달
            print("Database Table Success")
        }
    }
    
    
    func getDBPath() -> String {
        // 앱 내 문서 디렉터리 경로에서 SQLite DB 파일을 찾는다.
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        
        let dbPath:String = (docPathURL?.appendingPathComponent("db.sqlite").path)!
        
         // dbPath 경로에 파일이 없다면 앱 번들에 만들어 둔 db.sqlite를 가져와 복사한다.
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")!
            try! fileMgr.copyItem(atPath: dbSource, toPath: dbPath)
        }
        
        return dbPath
    }
    
}

