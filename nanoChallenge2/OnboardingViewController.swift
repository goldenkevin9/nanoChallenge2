//
//  OnboardingViewController.swift
//  nanoChallenge2
//
//  Created by Golden Kevin on 19/09/19.
//  Copyright © 2019 Golden Kevin. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onboardingButton(_ sender: Any) {
        UserDefaults.standard.set(10, forKey: "lanjutkan")
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
