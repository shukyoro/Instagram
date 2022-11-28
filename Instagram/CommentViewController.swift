//
//  CommentViewController.swift
//  Instagram
//
//  Created by 廣田秀人 on 2022/11/28.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    //
    var postData: PostData!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 投稿ボタンをタップした時に呼ばれるメソッド
    @IBAction func handlePostButton(_ sender: Any) {
        // コメントが入力されていない時は何もしない
        if textField.text!.isEmpty {
            SVProgressHUD.showError(withStatus: "コメントが入力されていません")
            return
        }
        // ユーザー名を取得
        let name = Auth.auth().currentUser?.displayName
        // 更新データを作成する
        var updateValue: FieldValue
        updateValue = FieldValue.arrayUnion([name! + " : " + textField.text!])
        // comments に更新データを書き込む
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        postRef.updateData(["comments": updateValue])
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        // ホームに戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // キャンセルボタンをタップした時に呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        // ホームに戻る
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
