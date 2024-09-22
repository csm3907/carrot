//
//  DetailPDFCell.swift
//
//
//  Created by 최승민 on 9/22/24.
//

import UIKit
import Combine
import PDFKit

class DetailPDFCell: UITableViewCell {

    static let identifier = "DetailPDFCell"

    // 스택 뷰 선언
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        view.addSubview(stackView)

        // 스택 뷰 제약 조건 설정
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
    }

    // 데이터 설정 메서드
    func configure(with model: BookPDFModel) {
        let PDFUrls = model.pdf.values.map { $0.url() }
        for pdfURL in PDFUrls {
            let pdfView = PDFView()
            DispatchQueue.global().async  {
                if let document = PDFDocument(url: pdfURL) {
                    DispatchQueue.main.async {
                        pdfView.document = document
                    }
                }
            }
            pdfView.translatesAutoresizingMaskIntoConstraints = false
            pdfView.autoScales = true
            let heightConstraint = pdfView.heightAnchor.constraint(equalToConstant: 400)
            heightConstraint.priority = .required
            heightConstraint.isActive = true
            stackView.addArrangedSubview(pdfView)
        }
    }
}
