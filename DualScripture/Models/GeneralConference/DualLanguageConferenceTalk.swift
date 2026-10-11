//
//  DualLanguageConferenceTalk.swift
//  DualScripture
//
//  Created by Michael Knight on 10/11/26.
//

import Foundation


struct DualLanguageConferenceTalk {
    var pTitle: String
    var pAuthor: String
    var pCalling: String
    var pSubject: String
    
    var sTitle: String
    var sAuthor: String
    var sCalling: String
    var sSubject: String
    
    var showTargetLangTitle: Bool
    var showTargetLangAuthor: Bool
    var showTargetLangCalling: Bool
    var showTargetLangSubject: Bool

}

var mockConferenceTalk = DualLanguageConferenceTalk(
    pTitle: "Pangwakas na Mensahe",
    pAuthor: "Ni Pangulong Dallin H. Oaks",
    pCalling: "Pangulo ng Ang Simbahan ni Jesucristo ng mga Banal sa mga Huling Araw",
    pSubject: "Habang inaabangan natin ang hinaharap, wini-welcome natin ang mundo, nang personal o virtual, sa Pagdiriwang sa Salt Lake Temple.",
    
    sTitle: "Prophets, Seers, and Revelators",
    sAuthor: "By President Dallin H. Oaks",
    sCalling: "President of The Church of Jesus Christ of Latter-day Saints",
    sSubject: "As we look forward, we are welcoming the world, in person or virtually, to the Salt Lake Temple Celebration.",
    
    showTargetLangTitle: true,
    showTargetLangAuthor: true,
    showTargetLangCalling: true,
    showTargetLangSubject: true
)

