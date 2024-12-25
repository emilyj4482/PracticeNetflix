//
//  SectionHeaderView.swift
//  PracticeNetflix
//
//  Created by EMILY on 25/12/2024.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
