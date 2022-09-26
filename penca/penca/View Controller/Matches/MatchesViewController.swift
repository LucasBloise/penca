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
    private var bannerURLs: [String] = []
    
    override func viewDidLoad() {
        collectionView.register(BannerCollectionViewCell.nib(), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
//        pageControl.customPageControl(dotFillColor: UIColor(named: "pageControlColor")!, dotBorderColor: UIColor(named: "pageControlColor")!, dotBorderWidth: 2)
        super.viewDidLoad()
        getBanners()
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

extension UIPageControl {
    func customPageControl(dotFillColor: UIColor, dotBorderColor: UIColor, dotBorderWidth: CGFloat) {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            dotView.backgroundColor = currentPage == pageIndex ? dotFillColor : .clear
            dotView.layer.cornerRadius = dotView.frame.size.height / 2
            dotView.layer.borderColor = dotBorderColor.cgColor
            dotView.layer.borderWidth = dotBorderWidth
        }
    }
}
