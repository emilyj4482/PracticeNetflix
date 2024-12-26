//
//  MainViewController.swift
//  PracticeNetflix
//
//  Created by EMILY on 25/12/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private let vm = MainViewModel()
    
    private var popularMovies = [Movie]()
    private var topRatedMovies = [Movie]()
    private var upcomingMovies = [Movie]()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "NETFLIX"
        label.textColor = UIColor(red: 229/255, green: 9/255, blue: 30/255, alpha: 1.0)
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    private var collectionViewLayout: UICollectionViewLayout {
        // 각 item이 각 그룹 내에서 전체 너비와 전체 높이를 차지 (컬렉션 뷰 구성은 section > group > item 순인데 group을 구현하지 않으므로 현재 cell이 group이자 item임 - group 안에 하나의 item이 가득 차있음)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 각 group은 화면 너비의 25% 차지, 높이는 화면의 40%
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(0.25))
        
        // horizontal로 구성
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        // 스크롤이 연속적으로 가능하게 하도록 지정
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 10)
        
        // header layout
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        // header를 section에 추가
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        [titleLabel, collectionView]
            .forEach {
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    // TODO: bind
    private func bind() {
        
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .popular: popularMovies.count
        case .topRated: topRatedMovies.count
        case .upcoming: upcomingMovies.count
        default: 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.identifier, for: indexPath) as? PosterCell else {
            return UICollectionViewCell()
        }
        
        switch Section(rawValue: indexPath.section) {
        case .popular:
            cell.configure(with: popularMovies[indexPath.item])
        case .topRated:
            cell.configure(with: popularMovies[indexPath.item])
        case .upcoming:
            cell.configure(with: popularMovies[indexPath.item])
        default:
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    // section 별 Header 지정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // footer는 구현 X, header일 경우만 구현
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView
        else {
            return UICollectionReusableView()
        }
        
        let sectionType = Section.allCases[indexPath.section]
        
        headerView.configure(with: sectionType.title)
        
        return headerView
    }
}

extension MainViewController : UICollectionViewDelegate {
    // TODO: push to youtube
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .popular:
        case .topRated:
        case .upcoming:
        default:
            return
        }
    }
}
