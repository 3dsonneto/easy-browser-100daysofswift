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
    var progressView: UIProgressView!
    
    override func loadView() {
        webView = WKWebView() //
        webView.navigationDelegate = self //Delegate é uma coisa agindo no lugar de outra, respondendo perguntas e respondendo a eventos. Nesse caso diz para o WKWebView que queremos ser informados quando algo de interessante acontecer. No caso o self diz que é para informar para esse ViewController
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        let url = URL(string: "https://www.hackingwithswift.com")! //Swift guarda url num tipo especifico URL para aumentar as funcionalidades
        webView.load(URLRequest(url: url))//Coloca o url em um urlrequest porque diretamente não funciona
        webView.allowsBackForwardNavigationGestures = true //Permite arrastar para frente ou trás no navegador para voltar e avançar
    }


    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem //importante para ipad, diz ao ios onde o actionsheet vai ficar ancorado
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction){
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

