import UIKit

class DepartPickerVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let departDAO = DepartmentDAO()
    var departList: [(departCd: Int, departTitle: String, departAddr: String)]!
    var pickerView: UIPickerView!
    
    var selectDepartCd: Int {
        let row = self.pickerView.selectedRow(inComponent: 0)
        return self.departList[row].departCd
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // departList 부서 목록 가져와 튜플 배열 초기화
        self.departList = self.departDAO.find()
        
        // 피커뷰 객체 초기화 및 최상위 뷰의 서브 뷰로 등록
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.view.addSubview(self.pickerView)
        
        // 외부에서 뷰 컨트롤러를 참조할 때를 위한 사이즈를 지정한다.
        let pWidth = self.pickerView.frame.width
        let pHeight = self.pickerView.frame.height
        self.preferredContentSize = CGSize(width: pWidth, height: pHeight)
    }
    
    // MARK: - UIPickerView Data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.departList?.count ?? 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        /**
         var titleView = view as? UILabel
         
         if titleView == nil {
         titleView = UILabel()
         titleView.font = UIFont.systemFont(ofSize: 14)
         titleView.textAlignment = .center
         }
         **/
        
        let titleView = view as? UILabel ?? {
            let titleView = UILabel()
            titleView.font = UIFont.systemFont(ofSize: 14)
            titleView.textAlignment = .center
            return titleView
        }()
        
        titleView.text = "\(self.departList[row].departTitle) \(self.departList[row].departAddr)"
        
        return titleView
    }
    


}
