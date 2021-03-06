//
//  ViewController.swift
//  HttpRequest
//
//  Created by jin on 2018/1/5.
//  Copyright © 2018年 jin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model: DMModel?
    //请求参数
    
    let pi = 1
    let pz = 1
    
    lazy var segment: UISegmentedControl = {
        let tempView = UISegmentedControl(items: ["moya", "链式", "AFN式"])
        tempView.frame = CGRect(x:0, y: 40, width: self.view.frame.width, height: 40)
        tempView.selectedSegmentIndex = 0
        tempView.addTarget(self, action: #selector(clickSegment), for: .valueChanged)
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x:0, y: 100, width: self.view.frame.width, height: self.view.frame.height - 100), style: .plain)
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 100
        
        table.delegate = self
        table.dataSource = self
        table.register(DMCell.self, forCellReuseIdentifier: "DMCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(segment)
        self.view.addSubview(tableView)
        loadDataByMoay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DMCell = tableView.dequeueReusableCell(withIdentifier: "DMCell", for: indexPath) as! DMCell
        cell.album = model?.albums?[indexPath.row]
        return cell
    }
}

extension ViewController {
    
    @objc func clickSegment() {
        switch segment.selectedSegmentIndex {
        case 0:
            loadDataByMoay()
        case 1:
            loadDataByChain()
        case 2:
            loadDataByAFN()
        default:
            break
        }
    }
    
    /// moya请求
    func loadDataByMoay() {
        let kw = "我"
        HttpRequest.loadData(API: DMAPI.self, target: .search(kw: kw, pi: pi, pz: pz), success: { (json) in
            let decoder = JSONDecoder()
            let model = try? decoder.decode(DMModel.self, from: json)
            self.model = model
            self.tableView.reloadData()
        }) { (error_code, message) in
            
        }
    }
    
    /// 链式请求
    func loadDataByChain() {
        let kw = "爱"
        NetworkKit().url("http://v5.pc.duomi.com/search-ajaxsearch-searchall").requestType(.post).params(["kw": kw, "pi": pi, "pz": pz]).success { (json) in
            
            let decoder = JSONDecoder()
            let model = try? decoder.decode(DMModel.self, from: json)
            self.model = model
            self.tableView.reloadData()
            
            }.failure { (error) in
                
            }.request()
    }
    
    /// 类AFN请求
    func loadDataByAFN() {
        let kw = "你"
        NetworkTools.POST(url: "http://v5.pc.duomi.com/search-ajaxsearch-searchall", params: ["kw": kw, "pi": pi, "pz": pz], success: { (json) in
            let decoder = JSONDecoder()
            let model = try? decoder.decode(DMModel.self, from: json)
            self.model = model
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }
}
