//
//  ReportMainVC.swift
//  POS App
//
//  Created by namnl on 23/07/2023.
//

import UIKit
import CarbonKit

class ReportMainVC: BaseVC {

    @IBOutlet var viewTab: UIView!
    var tabMenuContainerViewController: MenuReportVC!

//    let listVC: [UIViewController] = [OverviewRPVC(),DetailRPVC()]
    override func viewDidLoad() {
        super.viewDidLoad()
        tabMenuContainerViewController = MenuReportVC()
        addChild(tabMenuContainerViewController)
        viewTab.addSubview(tabMenuContainerViewController.view)
        tabMenuContainerViewController.didMove(toParent: self)
        
//        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: ["Tab 1", "Tab 2"], delegate: self)
//        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: self.view)
//
//        for (index, _) in listVC.enumerated() {
//            carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(view.frame.width / CGFloat(listVC.count), forSegmentAt: index)
//        }
    }


}
//extension ReportMainVC: CarbonTabSwipeNavigationDelegate {
//    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
//
//        return listVC.itemAtIndex(index: Int(index)) ?? UIViewController()
//    }
//}
