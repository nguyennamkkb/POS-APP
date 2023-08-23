//
//  TestTabsVC.swift
//  LN POS
//
//  Created by namnl on 19/08/2023.
//

import UIKit
import XLPagerTabStrip

class TestTabsVC: ButtonBarPagerTabStripViewController {
    
    @IBOutlet var tabView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTabs()
        
    }
    func settingTabs(){
        //        settings.style.buttonBarItemBackgroundColor = .clear // Set background color of tab items
        //
        //        settings.style.buttonBarItemBackgroundColor = .white
        //        settings.style.buttonBarItemLeftRightMargin = 1
        //        settings.style.selectedBarBackgroundColor = .blue
        //        settings.style.buttonBarItemTitleColor = .blue
        //        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .clear // Set background color of tab items
        
        settings.style.buttonBarItemTitleColor = .gray // Set default color of tab item titles
        settings.style.selectedBarBackgroundColor = .blue // Set selected color of tab item titles
        
        settings.style.selectedBarBackgroundColor = .blue // Set color of the selected tab indicator
        buttonBarView.backgroundColor = .white
        buttonBarView.selectedBar.backgroundColor = .blue
        
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let tabControllers: [UIViewController] = [
            Tab1VC(),
            Tab2VC()
            // Add more tab view controllers here
        ]
        return tabControllers
    }
}
