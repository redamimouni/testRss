//
//  ViewController.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import UIKit

final class ToiletListViewController: UIViewController, Coordinated {
    // MARK: - Data

    internal var toiletListViewModelToDisplay: [ToiletViewModel] = []
    private var filterStatus = FilterStatus.all

    // MARK: - Subviews

    private lazy var tableView: UITableView = createTableView()
    private lazy var filterButton: UIBarButtonItem = {
        return UIBarButtonItem(title: filterStatus.rawValue, style: .done, target: self, action: #selector(updateFilter))
    }()

    // MARK: - Dependencies

    internal let presenter: ToiletListPresenter
    internal weak var coordinator: MainCoordinator?

    // MARK: - Coordinated

    func bindWith(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: - Init

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
        setupInterface()
        presenter.fetchToiletList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let toiletList):
                    self?.toiletListViewModelToDisplay = toiletList
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Fetch data has failed with error: \(error)")
                }
            }
        }
    }


    // MARK: - Private

    private func setupInterface() {
        navigationItem.rightBarButtonItem = filterButton
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    @objc
    private func updateFilter() {
        switch filterStatus {
        case .all:
            filterStatus = .prm
        case .nonPrm:
            filterStatus = .all
        case .prm:
            filterStatus = .nonPrm
        }
        filterButton.title = filterStatus.rawValue
        presenter.filter(with: filterStatus) { [weak self] filterArray in
            self?.toiletListViewModelToDisplay = filterArray
            self?.tableView.reloadData()
        }
    }

    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.register(ToiletViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }
}
