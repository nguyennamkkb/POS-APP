//
//  MenuReportVC.swift
//  POS App
//
//  Created by namnl on 24/07/2023.
//

import UIKit
import CarbonKit


class MenuReportVC: UIViewController {

    let listVC: [UIViewController] = [OverviewRPVC(),DetailRPVC()]
    override func viewDidLoad() {
        super.viewDidLoad()

        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: ["Tổng quan", "Chi tiết"], delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: self.view)

        for (index, _) in listVC.enumerated() {
            carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width / CGFloat(listVC.count), forSegmentAt: index)
        }
    }
}
extension MenuReportVC: CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return listVC.itemAtIndex(index: Int(index)) ?? UIViewController()
    }
}
