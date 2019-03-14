import Foundation

enum EmpStateType : Int {
    // 순서대로 재직중(0), 휴직(1), 퇴사(2)
    case ING = 0, STOP, OUT
    
    // 재직 상태 문자열 반환 메소드
    func desc() -> String {
        switch self {
        case .ING:
            return "재직중"
        case .STOP:
            return "휴직"
        case .OUT:
            return "퇴사"
        }
    }
}

struct EmployeeVO {
    var empCd = 0 // 사원 코드
    var empName = "" // 사원명
    var joinDate = "" // 입사일
    var stateCd = EmpStateType.ING // 재직 상태 (기본값 : 재직중)
    var departCd = 0 // 소속 부서 코드
    var departTitle = "" // 소속 부서명
}

class EmployeeDAO : DAOBase{
    
    let SQL_EMPLOYEE_TABLE_NAME : String = "employee"
    let SQL_EMPLOYEE_CD : String = "emp_cd"
    let SQL_EMPLOYEE_NAME : String = "emp_name"
    let SQL_EMPLOYEE_JOINDATE : String = "join_date"
    let SQL_EMPLOYEE_STATE_CD : String = "state_cd"
    let SQL_EMPLOYEE_DEPART_CD : String = "department.depart_cd"
    let SQL_EMPLOYEE_DEPART_TITLE : String = "department.depart_title"
    
    
    // 검색
    func find() -> [EmployeeVO] {
        
        var employeeList = [EmployeeVO]()
        
        do {
            let sql = """
            SELECT \(SQL_EMPLOYEE_CD), \(SQL_EMPLOYEE_NAME), \(SQL_EMPLOYEE_JOINDATE), \(SQL_EMPLOYEE_DEPART_TITLE)
            FROM \(SQL_EMPLOYEE_TABLE_NAME)
            JOIN department On \(SQL_EMPLOYEE_DEPART_CD) = \(SQL_EMPLOYEE_CD)
            ORDER BY \(SQL_EMPLOYEE_DEPART_CD) ASC
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = EmployeeVO()
                
                record.empCd = Int(rs.int(forColumn: SQL_EMPLOYEE_CD))
                record.empName = rs.string(forColumn: SQL_EMPLOYEE_NAME)!
                record.joinDate = rs.string(forColumn: SQL_EMPLOYEE_JOINDATE)!
                record.departTitle = rs.string(forColumn: "depart_title")!
                record.stateCd = EmpStateType(rawValue: Int(rs.int(forColumn: SQL_EMPLOYEE_STATE_CD)))!
        
                employeeList.append(record)
            }
        }catch let error as NSError {
            NSLog("failed: \(error.localizedDescription)")
        }
        
        return employeeList
    }
    
    
    // 호출
    func get(empCd: Int) -> EmployeeVO? {
        
        let sql = """
        SELECT \(SQL_EMPLOYEE_CD), \(SQL_EMPLOYEE_NAME), \(SQL_EMPLOYEE_JOINDATE), \(SQL_EMPLOYEE_STATE_CD), \(SQL_EMPLOYEE_DEPART_TITLE)
        FROM \(SQL_EMPLOYEE_TABLE_NAME)
        JOIN department On \(SQL_EMPLOYEE_DEPART_CD) = \(SQL_EMPLOYEE_CD)
        WHERE \(SQL_EMPLOYEE_CD) = ?
        """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [empCd])
        
        if let _rs = rs {
            _rs.next()
            
            var record = EmployeeVO()
            
            record.empCd = Int(_rs.int(forColumn: SQL_EMPLOYEE_CD))
            record.empName = _rs.string(forColumn: SQL_EMPLOYEE_NAME)!
            record.joinDate = _rs.string(forColumn: SQL_EMPLOYEE_JOINDATE)!
            record.departTitle = _rs.string(forColumn: "depart_title")!
            record.stateCd = EmpStateType(rawValue: Int(_rs.int(forColumn: SQL_EMPLOYEE_STATE_CD)))!
            
            return record
        }else{
         return nil
        }
    }
    
    
    // 생성
    func create(param: EmployeeVO) -> Bool {
        do {
            let sql = """
            INSERT INTO \(SQL_EMPLOYEE_TABLE_NAME) (\(SQL_EMPLOYEE_NAME), \(SQL_EMPLOYEE_JOINDATE), \(SQL_EMPLOYEE_STATE_CD), depart_cd)
            VALUES ( ? , ? , ? , ? )
            """
            
            var params = [Any]()
            params.append(param.empName)
            params.append(param.joinDate)
            params.append(param.stateCd.rawValue)
            params.append(param.departCd)
            
            try self.fmdb.executeUpdate(sql, values: params)
            
            return true
        }catch let error as NSError {
            NSLog("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(empCd: Int) -> Bool {
        do {
            let sql = "DELETE FROM \(SQL_EMPLOYEE_TABLE_NAME) WHERE \(SQL_EMPLOYEE_CD) = ? "
            try self.fmdb.executeUpdate(sql, values: [empCd])
            return true
        } catch let error as NSError {
            NSLog("Remove Error : \(error.localizedDescription)")
            return false
        }
        
    }
    
}



