//
//  FooterView.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import UIKit
import Combine

public class FooterView: UITableViewCell {

    public static let identifier = "FooterView"
    
    public let progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(style: .medium)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    var cancellables: Set<AnyCancellable> = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            progressView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 50),
            progressView.heightAnchor.constraint(equalToConstant: 50),
        ])
        progressView.startAnimating()
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        
        cancellables = .init()
        progressView.stopAnimating()
    }
}
