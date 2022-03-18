//
//  DetalleViewController.swift
//  MarvelAPI
//
//  Created by Maximiliano Morales on 17/03/2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var webView: WKWebView!
    
    var url : URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: url!)
        webView.load(request)
    }

}
