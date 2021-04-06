//
//  ViewController.swift
//  Project4
//
//  Created by Edson Neto on 06/04/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate { //Nosso ViewCOntroller extende UIViewController mas ele conforma-se aos protocolos do WKNavigationDelegate
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView() //
        webView.navigationDelegate = self //Delegate é uma coisa agindo no lugar de outra, respondendo perguntas e respondendo a eventos. Nesse caso diz para o WKWebView que queremos ser informados quando algo de interessante acontecer. No caso o self diz que é para informar para esse ViewController
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://www.hackingwithswift.com")! //Swift guarda url num tipo especifico URL para aumentar as funcionalidades
        webView.load(URLRequest(url: url))//Coloca o url em um urlrequest porque diretamente não funciona
        webView.allowsBackForwardNavigationGestures = true //Permite arrastar para frente ou trás no navegador para voltar e avançar
    }


}

