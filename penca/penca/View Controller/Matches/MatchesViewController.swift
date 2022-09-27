//
//  MatchesViewController.swift
//  penca
//
//  Created by Lucas Bloise on 22/09/2022.
//

import UIKit

class MatchesViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    private var bannerURLs: [String] = []
    private var matches: [Match] = []
    
    
    override func viewDidLoad() {
        collectionView.register(BannerCollectionViewCell.nib(), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        getBanners()
        getMatches()
    }
    @IBAction private func didChangueBannerPage(_ sender: UIPageControl) {
        self.collectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension MatchesViewController {
    private func getBanners() {
        APIClient.shared.getBanners { apiResponse in
            switch apiResponse {
            case .success(let banners):
                self.bannerURLs = banners.bannerURLs
                self.pageControl.numberOfPages = banners.bannerURLs.count
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getMatches() {
        APIClient.shared.getMatches(page: 1, pageSize: 4, teamName: "b", status: "not_predicted", order: "ASC"){ apiResponse in
            switch apiResponse {
            case .success(let matches):
                print(matches.matches)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Banner Collection View
extension MatchesViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerURLs.count
    }
    // swiftlint:disable force_cast
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        let banner = self.bannerURLs[indexPath.row]
        cell.configure(imagerURL: banner)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
// MARK: - PageControl
extension MatchesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
}

// MARK: - TableView

extension MatchesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
        let sections: NSSet = NSSet(array: sectionsInTable)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}


