//
//  ScrollViewController.swift
//  20012018B
//
//  Created by bla on 1/20/18.
//  Copyright © 2018 bla. All rights reserved.
//

//
//  ViewController.swift
//  20012018B
//
//  Created by bla on 1/20/18.
//  Copyright © 2018 bla. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
        print("Scroll available")
    }
    
    override func viewDidLoad() {
        initScrollView()
    }
    
    func initScrollView()
    {
        self.scrollView.backgroundColor = UIColor.lightGray
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        
        let scrolViewWidth = self.scrollView.bounds.size.width
        let scrolViewHeight = self.scrollView.bounds.size.height
        
        
        for i in 1 ... 5 {
            let textToShow = String(i)
            let currentStartYPosition = (Int(i)-1)*Int(scrolViewHeight)
            let subView = createScrollViewItem(textToShow: textToShow, startYPosition: currentStartYPosition , width: Int(scrolViewWidth), height: Int(scrolViewHeight))
            self.scrollView.addSubview(subView)
        }
        
        self.scrollView.contentSize = CGSize(width: scrolViewWidth, height: scrolViewHeight * 5)
    }
    
    func createScrollViewItem(textToShow : String, startYPosition :  Int, width : Int, height : Int) -> UIView
    {
        let myView = UIView(frame : CGRect(
            x: 0,
            y: startYPosition,
            width : width,
            height : height
        ))
        myView.backgroundColor = UIColor.black
        myView.layer.borderWidth = 5
        myView.layer.borderColor = UIColor.cyan.cgColor
        
        let myLabel = UILabel(frame : CGRect(
            x: 50, y: 50, width : 100, height : 50
        ))
        myLabel.text = textToShow
        myLabel.textColor = UIColor.white
        myView.addSubview(myLabel)
        
        return myView
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrolViewHeight = Int(self.scrollView.bounds.size.height)
        let offset = Int(self.scrollView.contentOffset.y)
        let pageNumber = offset / scrolViewHeight
        print("POS: \(offset) and HEIGHT \(scrolViewHeight) PAGE NR: \(offset) PAGE_NR: \(pageNumber + 1)")
    }
    
    //TEMA:
    /*
    1. folosind solutia curenta si metoda care calculeaza numarul paginii sa se seteze badge value pentru SCROLL tab bar item = PAGE NUMBER
    2. se muta SCROLL view controller plus tot ce contine de aici in proiectul de la curs 6 ca tab bar item NOU, primul, se deschide automat la lansarea app; o sa trebuiasca si badge sa ramana functional
    3. se reimplementeaza items.json din proj 20012018A din curs 7 in solutia de la curs 6
    4. se modifica SCROLL astfel incat: numar pagini = nr entry in json si text afisat in pagina din camp nume
    5. se adauga o intrare noua "Path" in fiecare nod din json cu url catre o imagine png online sau offline (inclusiv BUNDLE, apreciez)
    6. se insereaza imaginea sub label in subviews pt paginile din scroll
    7. se salveaza adtele din default array pt json in fisierul defalt.json daca nu exista, daca exista se citeste din el
     */
}

