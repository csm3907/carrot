//
//  DetailHeaderCell.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import UIKit
import Combine

class DetailHeaderCell: UITableViewCell {
    
    static let identifier = "DetailHeaderCell"
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subTitleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var authorLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    var cancellables: Set<AnyCancellable> = .init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        let textStackView = UIStackView(arrangedSubviews: [titleLbl, subTitleLbl, authorLbl])
        textStackView.axis = .vertical
        textStackView.spacing = 4
        textStackView.alignment = .leading

        contentView.addSubview(iconImageView)
        contentView.addSubview(textStackView)
        
        [iconImageView, textStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            
            textStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            textStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            textStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}


