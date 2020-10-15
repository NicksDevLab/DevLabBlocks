//
//  SettingsViewController.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import UIKit

class SettingsViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
  }
    
  override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = false
  }

}
