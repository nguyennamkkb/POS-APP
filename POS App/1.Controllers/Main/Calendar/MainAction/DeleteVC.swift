//
//  DeleteVC.swift
//  POS App
//
//  Created by namnl on 10/06/2023.
//

import UIKit

class DeleteVC: UIViewController {

    @IBOutlet var nameLbl: UILabel!
    var nnn: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindData(name: String?){
        self.nnn = name
        self.nameLbl.text = self.nnn ?? ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
