//
//  ViewController.swift
//  42r00
//
//  Created by Linda MUCASSI on 2018/10/06.
//  Copyright © 2018 Linda MUCASSI. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    var code: String = "code"
    var accessToken: String = "token"
    var webView: WKWebView!
    
//    @IBAction func nextButton(_ sender: UIButton) {
//        let str  = (webView.url?.absoluteString)!;
//        let array = str.components(separatedBy: "=");
//        code = array[array.count - 1];
//        print("my code is \(code)");
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=feaca4bc0a80a43c02c99c8e4997a955831f8e28c408fd7301bd457355b61894&redirect_uri=https%3A%2F%2Fintra.42.fr&response_type=code")!
        webView.load(URLRequest(url: url))
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        title = webView.title
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            print("link \((webView.url?.absoluteString)!)")
            
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        
        print("no link")
        var link: String = (webView.url?.absoluteString)!;
        if (link.contains("https://intra.42.fr"))
        {
            print("link \((webView.url?.absoluteString)!)")
            let str  = (webView.url?.absoluteString)!;
            let array = str.components(separatedBy: "=");
            code = array[array.count - 1];
            print("my code is \(code)");
            let apiCall = ApiController();
            apiCall.getAccessToken();
            let HomeViewPage:HomeViewForum = self.storyboard?.instantiateViewController(withIdentifier: "homeViewForum") as! HomeViewForum;
            self.navigationController?.pushViewController(HomeViewPage, animated: true);
        }
        link = "";
        decisionHandler(WKNavigationActionPolicy.allow)
        }
    
//    func stopLoading() {
//        webView.removeFromSuperview()
//        self.moveToVC()
//    }
//
//    func moveToVC()  {
//        print("Write code where you want to go in app")
//        // Note: [you use push or present here]
//        let vc =
//            self.storyboard?.instantiateViewController(withIdentifier:
//                "storyboardID") as! ViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
//        stopLoading()
    }
}

