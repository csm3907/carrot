//
//  DetailViewController.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.keyboardDismissMode = .onDrag
        view.bounces = false
        view.register(DetailHeaderCell.self, forCellReuseIdentifier: DetailHeaderCell.identifier)
        view.register(DetailInfoCell.self, forCellReuseIdentifier: DetailInfoCell.identifier)
        view.register(DetailPDFCell.self, forCellReuseIdentifier: DetailPDFCell.identifier)
        view.delegate = self
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 300
        return view
    }()
    
    private let viewModel: DetailViewModelType = DetailViewModel()
    private var dataSources: DetailDataSource!
    var cancellables: Set<AnyCancellable> = .init()
    let bookID: String
    init(bookID: String) {
        self.bookID = bookID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "상세"
        view.backgroundColor = .white
        
        setTableView()
        bind()
        viewModel.input.searchDetail(id: bookID)
//        var snapshot = DetailSnapshot()
//        snapshot.appendSections([.book])
//        snapshot.appendItems(
//            [
//                .bookHeader(
//                    model: .init(
//                        title: "Securing DevOps",
//                        subtitle: "Security in the Cloud",
//                        authors: "Julien Vehent",
//                        publisher: "Manning",
//                        image: "https://itbook.store/img/books/9781617294136.png"
//                    )
//                ),
//                .bookInfo(
//                    model: .init(
//                        year: "2018",
//                        rating: "5",
//                        desc: "An application running in the cloud can benefit from incredible efficiencies, but they come with unique security threats too. A DevOps team's highest priority is understanding those risks and hardening the system against them.Securing DevOps teaches you the essential techniques to secure your cloud ...",
//                        price: "$26.98",
//                        url: "https://itbook.store/books/9781617294136",
//                        pages: "384"
//                    )
//                ),
//                .bookPDF(
//                    model: .init(
//                        pdf: [
//                            "Chapter 2": "https://itbook.store/files/9781617294136/chapter2.pdf",
//                            "Chapter 5": "https://itbook.store/files/9781617294136/chapter5.pdf"
//                        ]
//                    )
//                )
//            ]
//        )
//        setSnapshot(snapshot)
    }
    
    func bind() {
        viewModel.output.bookDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] bookDetail in
                guard  let self else { return }
                let snapshot = self.viewModel.output.makeSnapshot()
                self.setSnapshot(snapshot)
            }
            .store(in: &cancellables)
        
        viewModel.output.error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorString in
                self?.alert(message: errorString)
            }
            .store(in: &cancellables)
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dataSources = dataSource(tableView: tableView)
    }
    
    private func dataSource(tableView: UITableView) -> DetailDataSource {
        return DetailDataSource(tableView: tableView) { /*[weak self]*/ tableView, indexPath, item in
            switch item {
            case .bookHeader(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderCell.identifier, for: indexPath) as? DetailHeaderCell
                cell?.titleLbl.text = model.title
                cell?.subTitleLbl.text = model.subtitle
                cell?.authorLbl.text = model.authors
                cell?.iconImageView.loadImage(from: model.image)
                return cell
                
            case .bookInfo(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoCell.identifier, for: indexPath) as? DetailInfoCell
                cell?.configure(data: model)
                return cell
                
            case .bookPDF(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailPDFCell.identifier, for: indexPath) as? DetailPDFCell
                cell?.configure(with: model)
                return cell
            }
        }
    }
    
    func setSnapshot(_ snapshot: DetailSnapshot) {
        dataSources.apply(snapshot, animatingDifferences: false)
    }
}

extension DetailViewController: UITableViewDelegate {
    
}
