//
//  ViewController.swift
//  Project4
//
//  Created by Edson Neto on 06/04/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView() //
        webView.navigationDelegate = self //Delegate é uma coisa agindo no lugar de outra, respondendo perguntas e respondendo a eventos
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

