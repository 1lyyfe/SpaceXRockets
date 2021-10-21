//
//  RocketDetailViewController.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import UIKit

class RocketDetailViewController: ViewController {
    var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    var viewModel = RocketDetailViewModel()
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.white
        RocketImagesCell.register(in: tableView)
        RocketDescriptionCell.register(in: tableView)
        RocketMetaCell.register(in: tableView)
    }
    
    func configureNavBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back icon")?.withRenderingMode(.alwaysOriginal),
                                           style: .plain,
                                           target: self,
                                           action: #selector(back))
        navigationItem.leftBarButtonItem = backButton
        
        let wikiButton = UIBarButtonItem(image: UIImage(named: "info icon")?.withRenderingMode(.alwaysOriginal),
                                           style: .plain,
                                           target: self,
                                           action: #selector(openWikiLink))
        navigationItem.rightBarButtonItem = wikiButton
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
        buildViews()
        tableView.reloadData()
        self.title = viewModel.name
    }
    
    func buildViews() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        containerView.pinToParentView()
        
        containerView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
        ])
    }
    
    //MARK: - Actions
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openWikiLink() {
        guard let url = viewModel.wikipedia else { return } //TO DO show alert if nil
      
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}

extension RocketDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension RocketDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = RocketImagesCell.dequeue(from: tableView, for: indexPath)
            cell.configureData(images: viewModel.images)
            return cell
        } else if indexPath.row == 1 {
            let cell = RocketDescriptionCell.dequeue(from: tableView, for: indexPath)
            cell.configureData(description: viewModel.description)
            return cell
        } else if indexPath.row == 2 {
            let cell = RocketMetaCell.dequeue(from: tableView, for: indexPath)
            cell.configureData(meta: viewModel.getMetaInfo())
            return cell
        }
        
        return UITableViewCell()
    }
}
