//
//  SearchViewController.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import UIKit

public class SearchViewController: UIViewController {
    var isEditMode: Bool {
        let searchController = navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.keyboardDismissMode = .onDrag
        view.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return view
    }()
    
    private var dataSources: SearchDataSource!
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "검색"
        
        setTableView()
        setupSearchController()
        
        var snapshot = SearchSnapshot()
        snapshot.appendSections([.book])
        snapshot.appendItems(
            [
                .bookInfo(
                    model: .init(
                        imageURL: "",
                        title: "title 입니다.",
                        subTitle: "subTitle 입니다.",
                        price: "$32.0"
                    )
                ),
                .bookInfo(
                    model: .init(
                        imageURL: "",
                        title: "title 입니다.2",
                        subTitle: "subTitle 입니다.",
                        price: "$32.0"
                    )
                ),
                .bookInfo(
                    model: .init(
                        imageURL: "",
                        title: "title 입니다.3",
                        subTitle: "subTitle 입니다.",
                        price: "$32.0"
                    )
                ),
                .bookInfo(
                    model: .init(
                        imageURL: "",
                        title: "title 입니다.4",
                        subTitle: "subTitle 입니다.",
                        price: "$32.0"
                    )
                )
            ]
        )
        
        setSnapshot(snapshot)
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dataSources = dataSource(tableView: tableView)
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func dataSource(tableView: UITableView) -> SearchDataSource {
        return SearchDataSource(tableView: tableView) { /*[weak self]*/ tableView, indexPath, item in
            switch item {
            case .bookInfo(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell
                cell?.titleLbl.text = model.title
                cell?.subTitleLbl.text = model.subTitle
                cell?.priceLbl.text = model.price
                cell?.iconImageView.image = UIImage(systemName: "heart.fill")
                return cell
            }
        }
    }
    
    func setSnapshot(_ snapshot: SearchSnapshot) {
        dataSources.apply(snapshot, animatingDifferences: false)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        tableView.reloadData()
    }
}
