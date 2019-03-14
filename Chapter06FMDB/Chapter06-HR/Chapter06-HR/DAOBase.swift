import Foundation


class DAOBase {
    
    // SQLite 연결 및 초기화
    lazy var fmdb : FMDatabase! = {
        // 파일 매니저 객체 생성
        let fileMgr = FileManager.default
        
        // 샌드박스 내 문서 디렉터리에서 데이터베이스 파일 경로를 확인
        let docPath = fileMgr.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        
        // 샌드박스 경로에 파일이 없다면 메인 번들에 만들어 둔 hr.sqlite를 가져와 복사
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource:String = Bundle.main.path(forResource: "hr", ofType: "sqlite")!
            try! fileMgr.copyItem(atPath: dbSource, toPath: dbPath)
        }
        
        // 준비된 데이터베이스 파일을 바탕으로 FMDatabase 객체를 생성
        let db = FMDatabase(path: dbPath)
        
        return db
    }()
    
    
    init() {
        self.fmdb.open()
    }
    
    deinit {
        self.fmdb.close()
    }
    
    
}
