import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTime: UILabel!

    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var responseView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Action
    @IBAction func callCurrentTime(_ sender: Any) {
        
        if self.requestCallCurrentTime() == false {
            self.setText(time: "다시 시도해주세요.")
        }
    }
    
    @IBAction func post(_ sender: Any) {
        self.requestPostXMLEchoAPI()
    }
    @IBAction func json(_ sender: Any) {
        self.requestPostJsonEchoAPI()
    }
    
    
    // MARK: - Public
    func setText(time: String) {
        self.currentTime.text = time
//        self.currentTime.sizeToFit()
    }
    
    func getUserInfo() -> [String] {
        // 전송할 값 준비
        let userID = (self.userID.text)!
        let userName = (self.name.text)!
        
        return [userID,userName]
    }
    
    // MARK: - Response
    func response(data: Data?, error: Error?, requestType: String){
        
        // 응답 실패
        if let error = error {
            NSLog("An error ha occurred \(error.localizedDescription)")
            return
        }
        
         // 데이타 nill
        guard let responseData = data else{
            NSLog("An responseData nill")
            return
        }
        
        // 응답 성공
        DispatchQueue.main.async {
            do {
                
                let responseDic = try JSONSerialization.jsonObject(with: responseData, options: [] ) as? NSDictionary
                
                guard let jsonObject = responseDic else { return }
                
                let result = jsonObject["result"] as? String
                let timestamp = jsonObject["timestamp"] as? String
                let userID = jsonObject["userID"] as? String
                let name = jsonObject["name"] as? String
                
                if result == "SUCCESS" {
                    self.responseView.text =
                        "아이디 : \(userID ?? "")" + "\n"
                        + "이름 : \(name ?? "")" + "\n"
                        + "응답결과 : \(result ?? "")" + "\n"
                        + "응답시간 : \(timestamp ?? "")" + "\n"
                        + "요청방식 : \(requestType)"
                }
                
                
            } catch let e as NSError {
                NSLog("An Error ha occurred while parsing JSONObject \(e.localizedDescription)")
            }
            
            
        }
    }
    
    
    // MARK: - Request
    func requestPostJsonEchoAPI(){
        let userInfo = self.getUserInfo()
        let userID = userInfo[0]
        let userName = userInfo[1]
        
        let param = ["userID": userID, "name":userName]
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echoJSON")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            NSLog("Response Data = \(String(data: data!, encoding: String.Encoding.utf8)!)")
            self.response(data: data, error: error, requestType: "JSON")
            
        }
        
        task.resume()
    }
    

    func requestPostXMLEchoAPI(){

        let userInfo = self.getUserInfo()
        let userID = userInfo[0]
        let userName = userInfo[1]
        
        let param = "userID=\(userID)&name=\(userName)"
        
        // 인코딩
        let paramData = param.data(using: String.Encoding.utf8)
        
        // URL 객체 정의
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echo")
        
        // URL Request 객체 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        // HTTP 메시지 헤더 설정
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        // URL Session 객체를 통해 전송 및 응답값 처리 로직 작성
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
            // 응답 성공
            NSLog("Response Data = \(String(data: data!, encoding: String.Encoding.utf8)!)")
            self.response(data: data, error: error, requestType: "XML")
            
        }
        
        // POST 전송
        task.resume()
    
    }
    
    func requestCallCurrentTime() -> Bool{
        
        var result: Bool = false
        
        do {
            let url =  URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime")
            let response = try String(contentsOf: url!)
            self.setText(time: response)
            // TODO: - return Type String ..
            result = true
        } catch let error as NSError {
            NSLog("reque call current Time Error \(error)")
        }
        
        return result
    }

}

