//
//  ViewController.swift
//  Test
//
//  Created by chaostong on 2023/9/11.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var scrollView: TPKeyboardAvoidingScrollView = {
        let sv = TPKeyboardAvoidingScrollView()
        return sv
    }()
    
    var textContainer = TYTextContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTextContainer()
        addScrollView()
        addTextAttributedLabel()
        addSubmitAnswerBtn()
    }
    
    func createTextContainer() {
        let text = "Here’s a common scenario that any number of entrepreneurs face today: you’re the CEO of a small business, and though you’re making a nice [@] , you need to find a way to take it to the next level. What you need to do is [@] growth by establishing a growth team. A growth team is made up of members from different departments within your company, and it harnesses the power of collaboration to focus [@] on finding ways to grow.\nLet’s look at a real-world [@]. Prior to forming a growth team, the software company BitTorrent had 50 employees working in the [@] departments of engineering, marketing and product development. This brought them good results until 2012, when their growth plateaued. The [@] was that too many customers were using the basic, free version of their product. And [@] improvements to the premium, paid version, few people were making the upgrade.\nThings changed, [@] , when an innovative project-marketing manager came aboard, [@] a growth team and sparked the kind of [@] perspective they needed. By looking at engineering issues from a marketing point of view, it became clear that the [@] of upgrades wasn’t due to a quality issue. Most customers were simply unaware of the premium version and what it offered. Armed with this [@] , the marketing and engineering teams joined forces to raise awareness by prominently [@] the premium version to users of the free version. [@] , upgrades skyrocketed, and revenue increased by 92 percent.\nBut in order for your growth team to succeed, it needs to have a strong leader. It needs someone who can [@] the interdisciplinary team and keep them on course for improvement. This leader will [@] the target area, set clear goals and establish a time frame for the [@] of these goals.\nThe growth leader is also [@] for keeping the team focused on moving forward and steering them clear of distractions. [@] attractive, new ideas can be distracting, the team leader must recognize when these ideas don’t [@] the current goal and need to be put on the back burner."
        
        let textContainer = TYTextContainer()
        textContainer.text = text
        
        textContainer.linesSpacing = 2
        textContainer.paragraphSpacing = 5
        
        let blankStorage = parseTextFieldsWithString(text)
        textContainer.addTextStorageArray(blankStorage)
        
        self.textContainer = textContainer.createTextContainer(withTextWidth: view.frame.width-20)
    }
    
    func parseTextFieldsWithString(_ str: String) -> [TYViewStorage] {
        var textFieldArray: [TYViewStorage] = []
        var i = 1
        (str as NSString).enumerateStringsMatched(byRegex: "\\[@\\]") { captureCount, capturedStrings, capturedRanges, stop in
            if captureCount > 0 {
                let textField = TExamTextField(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
                textField.placeholder = "\(i)"
                let viewStorage = TYViewStorage()
                viewStorage.range = capturedRanges![0]
                viewStorage.view = textField
                viewStorage.tag = 1000 + textFieldArray.count
                
                textFieldArray.append(viewStorage)
                i += 1
            }
        }
        return textFieldArray
    }
    
    func addScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func addTextAttributedLabel() {
        let label = TYAttributedLabel()
        scrollView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
//        label.delegate = self
        label.textContainer = textContainer
        label.sizeToFit()
        
//        scrollView.contentSize = CGSize(width: 0, height: CGRectGetMidY(label.frame)+10)
    }
    
    func addSubmitAnswerBtn() {
        
    }
}
