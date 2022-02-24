//
//  View.swift
//  AlbumsApp
//
//  Created by Yalçın Golayoğlu on 22.02.2022.
//

import Foundation
import UIKit

protocol PresenterWillOpenDetailProtocol {
    func openScreen(screenName: String, onViewController: UIViewController)
}

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    func update(with albums: [AlbumResult])
    func update(with error: String)
}

class AlbumsViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
   
    var presenter: AnyPresenter?
    var albums: [AlbumResult] = []
    
    private let refreshControl = UIRefreshControl()
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel: CustomUILabel = CustomUILabel()
    
    func update(with albums: [AlbumResult]) {
        DispatchQueue.main.async {
            self.albums = albums
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.albums = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        tableView.delegate = self
        tableView.dataSource = self
        title = "Albums"
        messageLabel.text = "Downloading..."
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshPage(){
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
  
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.size.width/2 - 100, y: view.frame.size.height/2 - 25, width: 200, height: 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = albums[indexPath.row].name
        content.secondaryText = albums[indexPath.row].artistName
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(self.presenter?.router?.goDetail(for: albums[indexPath.row]) ?? UIViewController(), animated: true)
        }
    
    
    
    
}
