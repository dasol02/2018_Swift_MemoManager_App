import UIKit

class SideBarViewController: UITableViewController {
    
    let titles = [
        "메뉴 01",
        "메뉴 02",
        "메뉴 03",
        "메뉴 04",
        "메뉴 05"
    ]
    
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        
        accountLabel.text = "sdfghjk@naver.com"
        accountLabel.textColor = UIColor.white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        let accountView = UIView()
        accountView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        accountView.backgroundColor = UIColor.brown
        accountView.addSubview(accountLabel)
        
        self.tableView.tableHeaderView = accountView

        // Do any additional setup after loading the view.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 재사용 큐로부터 테이블 셀을 꺼내 온다.
        let id = "memucell" // 식별자 선언
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: id)

/*
        a ?? b -> a가 nil일 경우 B를 실행
        // 재사용 큐가 없을 경우 새로 생성 및 등록
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: id)
        }
 */
        
        // 셀 컨텐츠 설정
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }

}
