//
//  GuideScreen.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import Foundation
import UIKit
import WebKit
class GuideScreen  : UIViewController {
    let urlToLoad  : String
    
    init(urlToLoad: String) {
        self.urlToLoad = urlToLoad
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: .zero)
        self.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        DispatchQueue.main.async {
            if let url = URL(string: self.urlToLoad) {
                webView.load(URLRequest(url: url))
            }
        }
        
        
    }
}
