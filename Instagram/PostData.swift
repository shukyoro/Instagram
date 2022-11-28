//
//  PostData.swift
//  Instagram
//
//  Created by 廣田秀人 on 2022/11/25.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var comments: [String] = []
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.caption = postDic["caption"] as? String
        
        if let comments = postDic["comments"] as? [String] {
            self.comments = comments
        }
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // miydがあれば、いいねを押していると認識する
                self.isLiked = true
            }
        }
    }
}
