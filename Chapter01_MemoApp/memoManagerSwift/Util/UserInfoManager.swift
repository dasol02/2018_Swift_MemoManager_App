import UIKit


struct UserInfoKey {
    static let loginID = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
}

class UserInfoManager{
    
    // 로그인 유무
    var isLogin : Bool {
        
        if self.loginID == 0 || self.account == nil{
            return false
        }else{
            return true
        }
    }
    
    
    // 연산 프로퍼티 loginID 정의
    var loginID: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginID)
        }
        set(v){
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.loginID)
            ud.synchronize()
        }
    }
    
    // 계정
    var account : String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.account)
        }
        set (v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.account)
            ud.synchronize()
        }
    }
    
    // 이름
    var name : String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        set (v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    
    // 프로필 이미지
    var profile : UIImage? {
        get {
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile){
                return UIImage(data: _profile)
            }else{
                return UIImage(named: "account.jpg")
            }
        }
        set (v) {
            if v != nil {
                let ud = UserDefaults.standard
                ud.set(v?.pngData(), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }
    
    // 로그인 시도
    func login(inputAccount: String, passwd: String) -> Bool {
        
        if inputAccount == "sqlpro@naver.com" && passwd == "1234" {
            let ud = UserDefaults.standard
            ud.set(100, forKey: UserInfoKey.loginID)
            ud.set(inputAccount, forKey: UserInfoKey.account)
            ud.set("꼼꼼한 재은 씨", forKey: UserInfoKey.name)
            ud.synchronize()
            return true
        }else{
            return false
        }
    }

    // 로그아웃
    func logout() -> Bool {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKey.loginID)
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
        return true
    }
}
