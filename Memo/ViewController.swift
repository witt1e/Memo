//
//  ViewController.swift
//  Memo
//
//  Created by 권순욱 on 2/23/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var memoList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        memoList = UserDefaults.standard.array(forKey: "memoList") as? [String] ?? []
    }

    @IBAction func AddMemo(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Memo", message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self else { return }
            
            let memo = alertController.textFields?[0].text
            if memo != nil, memo != "" {
                memoList.append(memo!)
                tableView.reloadData()
                UserDefaults.standard.set(memoList, forKey: "memoList")
            }
        })
        
        present(alertController, animated: true)
    }

} // class

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.label.text = memoList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            UserDefaults.standard.set(memoList, forKey: "memoList")
        }
    }
}
