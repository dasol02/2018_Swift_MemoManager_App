import Foundation

class DepartmentDAO : DAOBase {
    
    let SQL_DEPART_TABLE_NAME : String = "department"
    let SQL_DEPART_CD : String = "depart_cd"
    let SQL_DEPART_TITLE : String = "depart_title"
    let SQL_DEPART_ADDR : String = "depart_addr"
    
    // 부서 정보를 담을 튜플 타입 정의
    typealias DepartRecord = (Int, String, String)
    
    
    // 부서목록 읽어올 메소드
    func find() -> [DepartRecord] {
        
        // 반환활 데이터를 담을 [DepartRecord] 타입의 객체 정의
        var departList = [DepartRecord]()
        
        do {
            // 부서 정보 목록을 가져올 SQL 작성 및 쿼리 실행
            let sql = """
                     SELECT \(SQL_DEPART_CD), \(SQL_DEPART_TITLE), \(SQL_DEPART_ADDR)
                     FROM \(SQL_DEPART_TABLE_NAME)
                     ORDER BY \(SQL_DEPART_CD) ASC
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            // 결과 집합 추출
            while rs.next() {
                let departCd = rs.int(forColumn: SQL_DEPART_CD)
                let departTitle = rs.string(forColumn: SQL_DEPART_TITLE)
                let departAddr = rs.string(forColumn: SQL_DEPART_ADDR)
                
                departList.append( (Int(departCd), departTitle!, departAddr!) )
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return departList
        
    }
    
    
    // 단일 부서 정보 호출
    func get(departCd:Int) -> DepartRecord? {
        
        
        let sql = """
                    SELECT \(SQL_DEPART_CD), \(SQL_DEPART_TITLE), \(SQL_DEPART_ADDR)
                    FROM \(SQL_DEPART_TABLE_NAME)
                    WHERE  \(SQL_DEPART_CD) = ?
        """
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [departCd])
        
        // 결과 집합 처리
        if let _rs = rs { // 옵셔널 타입으로 반환되므로, 이를 일반 상수에 바인딩 하여 해제 한다.
            _rs.next()
            
            let departCd = _rs.int(forColumn: SQL_DEPART_CD)
            let departTitle = _rs.string(forColumn: SQL_DEPART_TITLE)
            let departAddr = _rs.string(forColumn: SQL_DEPART_ADDR)
            
            return (Int(departCd), departTitle!, departAddr!)
        }else{ // 결과 집합이 없을 경우 nil 반환
            return nil
        }
    }
    
    // 부서 정보 추가
    func create(title: String!, addr: String!) -> Bool {
        do {
            let sql = """
                        INSERT INTO \(SQL_DEPART_TABLE_NAME) (\(SQL_DEPART_TITLE), \(SQL_DEPART_ADDR))
                        VALUES ( ? , ? )
            """
            
            try self.fmdb.executeUpdate(sql, values: [title,addr])
            return true
        } catch let error as NSError {
            NSLog("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    
    
    // 부서 정보 삭제
    func remove(departCd: Int) -> Bool {
        do {
            let sql = "DELETE FROM \(SQL_DEPART_TABLE_NAME) WHERE \(SQL_DEPART_CD) = ? "
            try self.fmdb.executeUpdate(sql, values: [departCd])
            return true
        } catch let error as NSError {
            NSLog("DELETE Error : \(error.localizedDescription)")
            return false
        }
    }
    
}
