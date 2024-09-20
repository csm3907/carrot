//
//  DetailViewController.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    var cancellables: Set<AnyCancellable> = .init()
    init(bookInfo: SearchPresentationModel) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "상세"
        view.backgroundColor = .white
    }
}
