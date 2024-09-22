//
//  File.swift
//  
//
//  Created by 최승민 on 9/22/24.
//

import UIKit
import Combine

class DetailInfoCell: UITableViewCell {

    static let identifier = "DetailInfoCell"

    // 스택 뷰 선언
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // 셀에 들어갈 레이블들 선언
    private let yearLbl: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0 // 여러 줄 가능
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0 // 여러 줄 가능
        return label
    }()
    
    private let ratingView: UIView = {
        let view = UIView()
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        view.addSubview(lbl)
        
        
        return view
    }()
    
    private let ratingLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0 // 여러 줄 가능
        return label
    }()
    
    private let pagesLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0 // 여러 줄 가능
        return label
    }()
    
    private let urlLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0 // 여러 줄 가능
        return label
    }()
    
    private let priceLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0 // 여러 줄 가능
        return label
    }()
    
    // 초기화
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        // 스택 뷰에 레이블 추가
        stackView.addArrangedSubview(yearLbl)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(ratingLbl)
        stackView.addArrangedSubview(pagesLbl)
        stackView.addArrangedSubview(urlLbl)
        stackView.addArrangedSubview(priceLbl)
        
        // 스택 뷰를 contentView에 추가
        contentView.addSubview(stackView)

        // 스택 뷰 제약 조건 설정
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(data: BookInfoModel) {
        yearLbl.text = data.year
        descriptionLabel.text = data.desc
        if let rating = data.rating {
            ratingLbl.text = "rating: " + rating
        }
        if let pages = data.pages {
            pagesLbl.text = "pages: " + pages
        }
        if let url = data.url {
            urlLbl.text = "url: " + url
        }
        if let price = data.price {
            priceLbl.text = "price: " + price
        }
    }
}
