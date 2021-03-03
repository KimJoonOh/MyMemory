//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by Kim JoonOh on 2021/03/01.
//

import UIKit

class MemoFormVC: UIViewController {

    var subject:String!
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func save(_ sender: Any) {
        
        //내용이 입력되지 않았을 경우 경고창 출력
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        //데이터 담을 객체 생성후 데이터 저장
        let data = MemoData()
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        
        //앱 델리게이트 객체 읽어온 후 앱델리게이트에 생성해둔 memolist 객체에 append
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        //작성화면 종료후 이전화면 복귀
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension MemoFormVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //카메라 버튼 클릭시 호출
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: false)
        
    }
    
    //사용자가 이미지 클릭시 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]) {
        
        self.preview.image = info[.editedImage] as? UIImage
        
        picker.dismiss(animated: false)
        
    }

}

extension MemoFormVC:UITextViewDelegate {
    
    //15글자까지만 받아옴
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15: contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
        
        
    }
    
}
