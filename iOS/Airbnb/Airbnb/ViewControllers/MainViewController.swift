//
//  MainViewController.swift
//  Airbnb
//
//  Created by delma on 2020/05/23.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import AuthenticationServices

class MainViewController: UIViewController {

    private var session: ASWebAuthenticationSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func githubLogin(_ sender: Any) {
        authTokenWithWebLogin()
    }
    
    private func authTokenWithWebLogin() {
        let authURL = URL(string: "http://52.78.203.80/api/login")
        let callbackURLScheme = "io.airbnb.app"
        
        self.session = ASWebAuthenticationSession(url: authURL!, callbackURLScheme: callbackURLScheme, completionHandler: { (callback: URL?, error: Error?) in
            guard error == nil, let successURL = callback else { return }
            let oAuthToken = URLComponents(string: successURL.absoluteString)?.queryItems?.filter({$0.name == "token"}).first?.value
            UserDefaults.standard.setValue(oAuthToken, forKey: "token")
            self.present()
        })
        self.session?.presentationContextProvider = self
        self.session?.start()
    }
    
    private func present() {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") else { return }
        self.present(nextViewController, animated: true)
    }
}

extension MainViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
