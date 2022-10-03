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
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    private var bannerURLs: [String] = []
    private var matches: [Match] = []
    private var tableViewSections: [String] = []
    
    override func viewDidLoad() {
        collectionView.register(BannerCollectionViewCell.nib(), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        tableView.register(MatchTableViewCell.nib(), forCellReuseIdentifier: MatchTableViewCell.identifier)
        tableView.register(MatchSectionHeaderView.nib(), forHeaderFooterViewReuseIdentifier: MatchSectionHeaderView.identifier)
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
        APIClient.shared.getMatches(page: 1, pageSize: 4, teamName: "b", status: "not_predicted", order: "ASC") { apiResponse in
            switch apiResponse {
            case .success(let matchesResponse):
                self.matches = matchesResponse.matches
                self.getSections()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: - Banner Collection View
extension MatchesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
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
        tableViewSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getSectionItems(section: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as! MatchTableViewCell
    
        let sectionItems = self.getSectionItems(section: indexPath.section)
        
        let matchItem = sectionItems[indexPath.row]
        
        cell.isUserInteractionEnabled = false
    
        cell.configure(match: matchItem)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        14
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: MatchSectionHeaderView.identifier)  as! MatchSectionHeaderView
        view.configure(sectionTitle: tableViewSections[section])
        return view
    }
    
    func getSections() {
        for match in matches {
            let index = match.date.index(match.date.startIndex, offsetBy: 10)
            let formattedDate = match.date[..<index]
            if !tableViewSections.contains(String(formattedDate)) {
                tableViewSections.append(String(match.date))
            }
            tableView.reloadData()
        }
    }
    
    func getSectionItems(section: Int) -> [Match] {
        var matchesForSection = [Match]()
        for match in matches {
            if match.date == tableViewSections[section] {
                matchesForSection.append(match)
            }
        }
        return matchesForSection
    }
}
