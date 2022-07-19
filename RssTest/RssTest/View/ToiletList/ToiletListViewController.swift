//
//  ViewController.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import UIKit

class ToiletListViewController: UIViewController, Coordinated {

    // MARK: - Subviews

    private lazy var tableView: UITableView = createTableView()

    // MARK: - Dependencies

    internal let presenter: ToiletListPresenter
    internal weak var coordinator: MainCoordinator?

    // MARK: - Coordinated

    func bindWith(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }

    init(presenter: ToiletListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }
}

